from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.db import connection
from datetime import date
from django import forms


def index(request):
    # library home page
    return HttpResponse("Hellooooo")


def user(req, id, emp_id=''):
    # get user info and send as a response
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name, last_name FROM members WHERE mem_id = %s", [id])
        row = cursor.fetchone()
        if row:
            first_name, last_name = row

    context = {
        'first_name': first_name,
        'last_name': last_name,
        'id': id,
    }
    return render(req, 'user_dashboard.html', context)


class UserIdForm(forms.Form):
    user_id = forms.IntegerField(label='User ID')

def input_user_id(request):
    if request.method == 'POST':
        form = UserIdForm(request.POST)
        if form.is_valid():
            user_id = form.cleaned_data['user_id']
            return redirect('user_details', id=user_id)
    else:
        form = UserIdForm()
    
    return render(request, 'input_user_details.html', {'form': form})


def return_page(req, id):
    with connection.cursor() as cursor:
        cursor.execute("select issue.book_id, book_name from issue, books where mem_id = %s and books.book_id = issue.book_id",[id])
        rows = cursor.fetchall()
        books = rows
        context = {
                'books': books,
                'user_id': id,
                }
    return render(req, 'return_page.html', context)


def book_return_page(req, mem_id, book_id):
    with connection.cursor() as cursor:
        cursor.execute("delete from issue where mem_id = %s and book_id = %s",
                       [mem_id, book_id])
    return HttpResponse("returned book")


def book_renew_page(req, mem_id, book_id):
    with connection.cursor() as cursor:
        cursor.execute("update issue set due_date = due_date + interval '30' day where mem_id = %s and book_id = %s",
                       [mem_id, book_id])
    return HttpResponse("renewed book")


def borrow_page(req, id):
    # should go to request page if selected here
    with connection.cursor() as cursor:
        cursor.execute("select books.book_id,book_name from books,has,members where status = 1 and has.book_id = books.book_id and has.library_id = members.lib_id and members.mem_id = %s",
                       [id])
        rows = cursor.fetchall()
        context = {
                'books': rows,
                'user_id': id,
                }
    return render(req, 'borrow_page.html', context)


def book_request_page(req, id, book_id):
    # table change
    with connection.cursor() as cursor:
        cursor.execute("insert into send_request(mem_id, book_id) values (%s, %s)",
                       [id, book_id])
        cursor.execute("update books set status = 0 where book_id = %s",
                       [book_id])
    return HttpResponse("book requested")


def books_currently_borrowed(req, id):
    with connection.cursor() as cursor:
        cursor.execute("select issue.book_id, book_name from issue,books where mem_id = %s and books.book_id = issue.book_id", [id])
        rows = cursor.fetchall()
        context = {
                'books': rows,
                'user_id': id,
                }
    return render(req, 'books_currently_borrowed.html', context)
