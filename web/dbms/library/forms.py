from django import forms


class AddBookForm(forms.Form):
    book_name = forms.CharField(label='Book Name', max_length=50)
    book_price = forms.IntegerField(label='Price')
    status = forms.IntegerField(label='Status')
    author_id = forms.IntegerField(label='Author ID')
    genre_id = forms.IntegerField(label='Genre ID')
    pub_id = forms.IntegerField(label='Publisher ID')
    lib_id = forms.IntegerField(label='Library ID')


class AddAuthorForm(forms.Form):
    author_name = forms.CharField(label='Author Name', max_length=50)
    author_subject = forms.CharField(label='Author Subject', max_length=50)
    qualification = forms.CharField(label='Qualification', max_length=50)


class AddGenreForm(forms.Form):
    genre_name = forms.CharField(label='Genre Name', max_length=30)
