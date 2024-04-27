from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection


def index(request):
    # library home page
    return HttpResponse("Hellooooo")


def user(req, id):
    # get user info and send as a respose
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name, last_name FROM members WHERE mem_id = %s", [id])
        row = cursor.fetchone()
        if row:
            first_name, last_name = row
    return HttpResponse(f"first_name: {first_name}, last_name: {last_name}")


def users(req):
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name from members")
        row = cursor.fetchall()
        if row:
            first = row
            return HttpResponse(f"{first}")


def borrowed(req, id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name from members")
        row = cursor.fetchall()
        if row:
            first = row
            return HttpResponse(f"{first}")


def history(req, id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name from members")
        row = cursor.fetchall()
        if row:
            first = row
            return HttpResponse(f"{first}")


def private_list(req, id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT first_name from members")
        row = cursor.fetchall()
        if row:
            first = row
            return HttpResponse(f"{first}")
