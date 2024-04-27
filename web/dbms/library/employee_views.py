from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection


def employee(req, id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name, last_name FROM members WHERE emp_id = %s", [id])
        row = cursor.fetchone()
        if row:
            first_name, last_name = row
    return HttpResponse(f"first_name: {first_name}, last_name: {last_name}")


def issued(req, id):
    # query should return books issued by the said employee
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name, last_name FROM members WHERE emp_id = %s", [id])
        row = cursor.fetchone()
        if row:
            first_name, last_name = row
    return HttpResponse(f"first_name: {first_name}, last_name: {last_name}")
