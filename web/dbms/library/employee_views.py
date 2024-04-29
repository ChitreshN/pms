from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection


def employee(req, id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name, last_name FROM employee WHERE emp_id = %s", [id])
        row = cursor.fetchone()
        if row:
            first_name, last_name = row
    context = {
            'first_name': first_name,
            'last_name': last_name,
        }
    return render(req, 'employee_dashboard.html', context)


def requests(req, emp_id):
    return HttpResponse("view borrow requests for his branch")


def accept_requests(req, emp_id, req_id):
    return HttpResponse("insert data into issue table")


def user_list(req, emp_id):
    return HttpResponse("page to view all users of a branch")


def user_info(req, user_id):
    return HttpResponse("page to view fines and books borrowed by a particular user")


def fine_recieved(req, user_id):
    return HttpResponse("update fine recieved in the issue table")


def issued(req, id):
    # query should return books issued by the said employee
    # and their status
    with connection.cursor() as cursor:
        cursor.execute("query that gives books issued by the employee", [id])
        row = cursor.fetchall()
        if row:
            book_title, book_id = row
    return HttpResponse(f"book_id: {book_id}, book_title: {book_title}")
