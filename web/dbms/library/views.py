from django.shortcuts import render, redirect
from django import forms

class EmployeeIdForm(forms.Form):
    emp_id = forms.IntegerField(label='Employee ID')

def input_employee_id(request):
    if request.method == 'POST':
        form = EmployeeIdForm(request.POST)
        if form.is_valid():
            emp_id = form.cleaned_data['emp_id']
            return redirect('employee_details', id=emp_id)
    else:
        form = EmployeeIdForm()
    
    return render(request, 'input_employee_id.html', {'form': form})

