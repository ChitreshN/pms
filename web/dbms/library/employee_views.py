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


def issued(req, id):
    # query should return books issued by the said employee
    with connection.cursor() as cursor:
        cursor.execute("query that gives books issued by the employee", [id])
        row = cursor.fetchall()
        if row:
            book_title, book_id = row
    return HttpResponse(f"book_id: {book_id}, book_title: {book_title}")
