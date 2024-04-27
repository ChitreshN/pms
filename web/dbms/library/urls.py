from django.urls import path

from . import user_views
from . import admin_views
from . import employee_views

urlpatterns = [
        path("", user_views.index, name="index"),
        path("admin/", admin_views.admin, name="admin"),
        path("admin/users", admin_views.users, name="users"),
        path("admin/users/<int:id>", user_views.user, name="users"),
        path("admin/employees", admin_views.employees, name="employees"),
        path("admin/vendors", admin_views.vendors, name="vendors"),
        path("admin/vendors/<int:id>", admin_views.vendor, name="vendor info"),
        path("admin/branches", admin_views.branches, name="branches"),
        path("admin/publishers", admin_views.publishers, name="publishers"),
        path("admin/publishers/<int:id>", admin_views.publisher,
             name="publisher info"),
        path("admin/branches/<int:id>", admin_views.branche,
             name="branche info"),
        path("users/<int:id>", user_views.user, name="user"),
        path("users/<int:id>/borrowed", user_views.borrowed,
             name="user borrow list"),
        path("users/<int:id>/history", user_views.history,
             name="user history"),
        path("users/<int:id>/private_list", user_views.private_list,
             name="user private list"),
        path("employee/<int:id>", employee_views.employee, name="employee"),
        path("employee/<int:id>/issued", employee_views.issued,
             name="employee issues"),
        path("employee/publisher", admin_views.publisher, name="employee"),
        path("employee/vendors", admin_views.vendor, name="employee"),
        path("employee/publisher", admin_views.publisher, name="employee"),
        path("employee/vendors", admin_views.vendors, name="vendors"),
        path("employee/vendors/<int:id>", admin_views.vendor,
             name="vendor info"),
        path("employee/branches", admin_views.branches, name="branches"),
        path("employee/publishers", admin_views.publishers, name="publishers"),
        path("employee/publishers/<int:id>", admin_views.publisher,
             name="publisher info"),
        path("employee/users", admin_views.users, name="users"),
        path("employee/users/<int:id>", user_views.user, name="users"),
        ]
