from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection


def admin(req):
    with connection.cursor() as cursor:
        cursor.execute("select count(*) from books")
        book_count = cursor.fetchone()
    if book_count:
        book_count = book_count[0]
        # add other information here as well
    return HttpResponse(f"book count: {book_count}")


def users(req):
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name from members")
        row = cursor.fetchall()
        if row:
            first = row
        return HttpResponse(f"{first}")


def employees(req):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from employee")
        employee_list = cursor.fetchall()
        if employee_list:
            response = employee_list
        return HttpResponse(f"{response}")


def vendors(req):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from vendor")
        vendor_list = cursor.fetchall()
        if vendor_list:
            response = vendor_list
        return HttpResponse(f"{response}")


def vendor(req, id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from vendor where vendor_id = %s", [id])
        vendor_list = cursor.fetchall()
        if vendor_list:
            response = vendor_list
        return HttpResponse(f"{response}")


def branches(req):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from lib")
        branches_list = cursor.fetchall()
        if branches_list:
            response = branches_list
        return HttpResponse(f"{response}")


def branche(req, id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from lib where library_id = %s", [id])
        branches_list = cursor.fetchall()
        if branches_list:
            response = branches_list
        return HttpResponse(f"{response}")


def publishers(req):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from publisher")
        pub_list = cursor.fetchall()
        if pub_list:
            response = pub_list
        return HttpResponse(f"{response}")


def publisher(req, id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * from publisher where pub_id = %s", [id])
        pub_list = cursor.fetchall()
        if pub_list:
            response = pub_list
        return HttpResponse(f"{response}")
