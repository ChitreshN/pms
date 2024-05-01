from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection


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

        # Assuming reading_history and private_list are retrieved from the database
        currently_borrowed = [("Book1", 1)]
        reading_history = [("Book1", 1)]

    context = {
        'first_name': first_name,
        'last_name': last_name,
        'reading_history': reading_history,
        'currently_borrowed': currently_borrowed,
    }
    return render(req, 'user_dashboard.html', context)


def return_page(req, id):
    with connection.cursor() as cursor:
        cursor.execute("select book_id from issue, send_request where send_request.mem_id = %s and issue.book_id = send_request.book_id",[id])
        rows = cursor.fetchall()
        books = rows

        context = {
                'books': books
                }
    return HttpResponse(context)


def book_return_page(req, id, book_id):
    with connection.cursor() as cursor:
        cursor.execute("delete from issue where mem_id = %s and book_id = %s",
                       [id, book_id])
        cursor.execute("select book_name from books where book_id = %s",
                       [book_id])
        name = cursor.fetchone()
        context = {
                'book': name,
                }
    return HttpResponse(context)


def borrow_page(req):
    # should go to request page if selected here
    with connection.cursor() as cursor:
        cursor.execute("select book_id from books where status = 1")
        rows = cursor.fetchall()
        context = {
                'books': rows,
                }
    return HttpResponse(context)


def book_request_page(req, id, book_id):
    with connection.cursor() as cursor:
        cursor.execute("insert into send_request(mem_id, book_id) values (%s, %s)",
                       [id, book_id])
        rows = cursor.fetchall()
        context = {
                'books': rows,
                }
    return HttpResponse(context)


def books_currently_borrowed(req, id):
    with connection.cursor() as cursor:
        cursor.execute("select book_id from issue where mem_id = %s", [id])
        rows = cursor.fetchall()
        context = {
                'books': rows,
                }
    return HttpResponse(context)


def books(req, user_id, book_id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT book_name from books where book_id = %s",
                       [book_id])
        row = cursor.fetchone()
        if row:
            book_name = row[0]

        context = {
                'name': book_name,
                }
        return HttpResponse(f"{book_name}")
