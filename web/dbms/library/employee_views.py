from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.db import connection
from datetime import date
from django import forms


class EmployeeIdForm(forms.Form):
    emp_id = forms.IntegerField(label='Employee ID')


def input_employee_id(request):
    if request.method == 'POST':
        form = EmployeeIdForm(request.POST)
        if form.is_valid():
            emp_id = form.cleaned_data['emp_id']
            return redirect('employee_info', id=emp_id)
    else:
        form = EmployeeIdForm()
    return render(request, 'input_employee_id.html', {'form': form})


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
    with connection.cursor() as cursor:
        cursor.execute("SELECT send_request.book_id, members.mem_id, members.first_name, members.last_name, books.book_name FROM send_request JOIN members ON members.mem_id = send_request.mem_id JOIN employee ON employee.lib_id = members.lib_id JOIN books ON books.book_id = send_request.book_id WHERE employee.emp_id = %s", [emp_id])
        rows = cursor.fetchall()
        context = {
                'emp_id': emp_id,
                'details': rows,
                }
    return render(req, 'requests.html', context)


def accept_requests(req, emp_id, book_id, mem_id):
    _date = date.today()
    with connection.cursor() as cursor:
        cursor.execute("insert into issue(mem_id, emp_id, book_id, issue_date, issue_status, return_status, due_date) values (%s, %s, %s, %s, %s, %s, %s)",

                       [mem_id, emp_id, book_id, _date, 1, 1, _date])
        cursor.execute("delete from send_request where mem_id = %s and book_id = %s",
                       [mem_id, book_id])
    return HttpResponse("request accepted")


def user_list(req, emp_id):
    with connection.cursor() as cursor:
        cursor.execute("select mem_id, members.first_name from members, employee where employee.emp_id = %s and employee.lib_id = members.lib_id",
                       [emp_id])
        rows = cursor.fetchall()
        context = {
                'emp_id': emp_id,
                'user_info': rows,
                }
    return render(req, 'user_list.html', context)


def user_info(req, emp_id, user_id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT SUM(fine) FROM issue WHERE mem_id = %s", [user_id])
        fine = cursor.fetchone()
        cursor.execute("SELECT issue.book_id ,book_name FROM issue, books WHERE mem_id = %s and issue.book_id = books.book_id", [user_id])
        books = cursor.fetchall()
        context = {
            'fine': fine,
            'books': books,
            'emp_id': emp_id,
            'user_id': user_id
        }
    return render(req, 'user_info.html', context)


def fine_page(req, emp_id, user_id):
    # Page to view fine for each book
    with connection.cursor() as cursor:
        cursor.execute("SELECT issue.book_id ,book_name ,fine FROM issue, books WHERE mem_id = %s and issue.book_id = books.book_id and fine > 0", [user_id])
        rows = cursor.fetchall()
        context = {
            'information': rows,
            'emp_id': emp_id,
            'user_id': user_id,
        }
    return render(req, 'fine_page.html', context)


def fine_recive(req, emp_id, user_id, book_id):
    # page to view fine for each book
    _date = date.today()
    with connection.cursor() as cursor:
        cursor.execute("update issue set fine = 0,emp_id = %s, issue_date = %s, due_date = %s + interval '30' day where mem_id = %s and book_id = %s",
                       [emp_id, _date, _date, user_id, book_id])
    return HttpResponse("fine updated")


def issued(req, id):
    # query should return books issued by the said employee
    # and their status
    with connection.cursor() as cursor:
        cursor.execute("select book_id, issue_date, due_date, issue_status, return_status, fine from issue where emp_id = %s", [id])
        row = cursor.fetchall()
        context = {
                'issued_books': row,
                }
    return render(req, 'issued.html', context)
