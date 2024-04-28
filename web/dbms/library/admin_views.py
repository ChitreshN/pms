from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection


def admin(req):
    context = {}
    return render(req, 'admin_dashboard.html', context)


def users(req, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name from members")
        row = cursor.fetchall()
        if row:
            first = row
        return HttpResponse(f"{first}")


def employees(req, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from employee")
        employee_list = cursor.fetchall()
        if employee_list:
            response = employee_list
        return HttpResponse(f"{response}")


def vendors(req, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from vendor")
        vendor_list = cursor.fetchall()
        if vendor_list:
            response = vendor_list
        return HttpResponse(f"{response}")


def vendor(req, id, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from vendor where vendor_id = %s", [id])
        vendor_list = cursor.fetchall()
        if vendor_list:
            response = vendor_list
        return HttpResponse(f"{response}")


def branches(req, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from lib")
        branches_list = cursor.fetchall()
        if branches_list:
            response = branches_list
        return HttpResponse(f"{response}")


def branche(req, id, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from lib where library_id = %s", [id])
        branches_list = cursor.fetchall()
        if branches_list:
            response = branches_list
        return HttpResponse(f"{response}")


def publishers(req, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from publisher")
        pub_list = cursor.fetchall()
        if pub_list:
            response = pub_list
        return HttpResponse(f"{response}")


def publisher(req, id, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from publisher where pub_id = %s", [id])
        pub_list = cursor.fetchall()
        if pub_list:
            response = pub_list
        return HttpResponse(f"{response}")


def books(req, emp_id=''):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from books")
        book_list = cursor.fetchall()
        return HttpResponse(f"{book_list}")
