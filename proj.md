# LMS (Library management System)

* The goal of this project is to create an application to manage various things in a library, such as the books, keeping track of users borrowing books and etc.
* A database is essential in such a system because one would need to keep track of various objects and relations between them.
* The database abstracts out various things like concurrency and finding and updating, leaving us to be worried about the high level detail.

## The data we are dealing with

* Books, Authors, Genres, Users and realtionships associated with these objects

## Primary tasks on the data

### The library admin

The admin should be able to perform the following actions

* Create new entries of books, authors, genres etc
* View information regarding which users currently hold which books
* Delete entries in the database

### The users

The users should be able to perform the following actions

* Borrow and return books
* View available books in the library
* View information regarding what books they currently hold
