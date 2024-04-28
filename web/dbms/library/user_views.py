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
        private_list = [("Book1", 1)]
        reading_history = [("Book1", 1)]

    context = {
        'first_name': first_name,
        'last_name': last_name,
        'reading_history': reading_history,
        'currently_borrowed': currently_borrowed,
        'private_list': private_list
    }
    return render(req, 'user_dashboard.html', context)


def users(req):
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name from members")
        row = cursor.fetchall()
        if row:
            first = row
            return HttpResponse(f"{first}")


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
