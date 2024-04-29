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
    return HttpResponse("borrow list with an option to return")


def book_return_page(req, id, book_id):
    return HttpResponse("page to return book")


def borrow_page(req):
    return HttpResponse("books available to borrow from")


def book_request_page(req, id, book_id):
    return HttpResponse("insert entry into request table")


def books_currently_borrowed(req, id):
    return HttpResponse("show details of books that are currently borrowed and fines if any")


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
