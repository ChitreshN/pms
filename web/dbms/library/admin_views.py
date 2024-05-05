from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection
from .forms import AddBookForm, AddAuthorForm, AddGenreForm

def index(req):
    return render(req, 'home_page.html')

def admin(req):
    context = {}
    return render(req, 'admin_dashboard.html', context)


def users(req):
    with connection.cursor() as cursor:
        cursor.execute("select mem_id, first_name, last_name from members",
                       )
        rows = cursor.fetchall()
        context = {
                'user_info': rows,
                }
    return render(req, 'admin_user_list.html', context)


def employees(req, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from employee")
        employee_list = cursor.fetchall()
        if employee_list:
            response = employee_list
        return HttpResponse(f"{response}")


def vendors(req, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT v_name, contact_no from vendor")
        vendor_list = cursor.fetchall()
        context = {
                'vendors': vendor_list,
                }
        return render(req, 'vendors.html', context)


def vendor(req, id, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from vendor where vendor_id = %s", [id])
        vendor_list = cursor.fetchall()
        if vendor_list:
            response = vendor_list
        return HttpResponse(f"{response}")


def branches(req):
    with connection.cursor() as cursor:
        cursor.execute("SELECT library_name, contact_no, address from lib, library_address where lib.library_id = library_address.library_id")
        branches_list = cursor.fetchall()
        context = {
                'branches_list': branches_list,
                }
    return render(req, 'admin_branch_list.html', context)

def branche(req, id, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from lib where library_id = %s", [id])
        branches_list = cursor.fetchall()
        if branches_list:
            response = branches_list
        return HttpResponse(f"{response}")


def publishers(req, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT pub_name, country from publisher")
        pub_list = cursor.fetchall()
        context = {
                'publishers': pub_list,
                }
        return render(req, 'publishers.html', context)


def books(req):
    with connection.cursor() as cursor:
        cursor.execute("SELECT book_name, library_name from books, has, lib where books.book_id = has.book_id and has.library_id = lib.library_id")
        book_list = cursor.fetchall()
        context = {
                'book_list': book_list,
                }
        return render(req, 'admin_books_list.html', context)


def user_info(req, user_id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT SUM(fine) FROM issue WHERE mem_id = %s", [user_id])
        fine = cursor.fetchone()
        cursor.execute("SELECT books.book_id, books.book_name FROM issue, books WHERE mem_id = %s and books.book_id = issue.book_id", [user_id])
        books = cursor.fetchall()
        context = {
                'fine': fine,
                'books': books,
                'user_id': user_id
                }
    return render(req, 'admin_user_info.html', context)


def employee_list(req):
    with connection.cursor() as cursor:
        cursor.execute("select emp_id, first_name, last_name from employee")
        emps = cursor.fetchall()
        context = {
                'emp_info': emps,
                }
    return render(req, 'admin_empl_info.html', context)


def employee_info(req, emp_id):
    with connection.cursor() as cursor:
        cursor.execute("select book_id, issue_date, due_date, issue_status, return_status, fine from issue where emp_id = %s",
                       [emp_id])
        row = cursor.fetchall()
        context = {
                'issued_books': row,
                }
    return render(req, 'issued.html', context)


def add_book(request):
    if request.method == 'POST':
        form = AddBookForm(request.POST)
        if form.is_valid():
            book_name = form.cleaned_data['book_name']
            book_price = form.cleaned_data['book_price']
            status = form.cleaned_data['status']
            author_id = form.cleaned_data['author_id']
            genre_id = form.cleaned_data['genre_id']
            pub_id = form.cleaned_data['pub_id']
            lib_id = form.cleaned_data['lib_id']

            
            with connection.cursor() as cursor:
                cursor.execute("INSERT INTO books (book_name, book_price, status, author_id, genre_id, pub_id) VALUES (%s, %s, %s, %s, %s, %s)",
                               [book_name,
                                book_price,
                                status,
                                author_id,
                                genre_id,
                                pub_id])
                cursor.execute("select max(book_id) from books")
                value = cursor.fetchone()
                book_id = value[0]
                cursor.execute("INSERT INTO has (library_id, book_id) VALUES(%s, %s)", [lib_id, book_id])
            return HttpResponse('Book added successfully!')
    else:
        form = AddBookForm()
    
    return render(request, 'add_book.html', {'form': form})

def add_author(request):
    if request.method == 'POST':
        form = AddAuthorForm(request.POST)
        if form.is_valid():
            author_name = form.cleaned_data['author_name']
            author_subject = form.cleaned_data['author_subject']
            qualification = form.cleaned_data['qualification']
            
            with connection.cursor() as cursor:
                cursor.execute("INSERT INTO author (author_name, author_subject, qualification) VALUES (%s, %s, %s)", [author_name, author_subject, qualification])
                
            return HttpResponse('Author added successfully!')
    else:
        form = AddAuthorForm()
    
    return render(request, 'add_author.html', {'form': form})


def add_genre(request):
    if request.method == 'POST':
        form = AddGenreForm(request.POST)
        if form.is_valid():
            genre_name = form.cleaned_data['genre_name']
            
            with connection.cursor() as cursor:
                cursor.execute("INSERT INTO genre (genre_name) VALUES (%s)", [genre_name])
                
            return HttpResponse('Genre added successfully!')
    else:
        form = AddGenreForm()
    
    return render(request, 'add_genre.html', {'form': form})
