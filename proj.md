# LMS (Library management System)

* The goal of this project is to create an application to manage various things in a library, such as the books, keeping track of users borrowing books and etc.
* A database is essential in such a system because one would need to keep track of various objects and relations between them.
* The database abstracts out various things like concurrency and finding and updating, leaving us to be worried about the high level detail.

## The data we are dealing with

* Books 
* Authors 
* Genres 
* Users  
* Book instance (an instance associated with each book)
* Payments
* Inventory 
* Branches
* Local books
* Books available to buy

## Primary tasks on the data

### The library admin

The admin should be able to perform the following actions

* Create new entries of books, authors, genres etc
* Maintain the information of all the branches of the libraries.
* Buy new books for the library
* View information regarding which users currently hold which books
* Send requests to other branches to get books based on demand 
* Make purchases based on requests from users (Inventory)
* No.of seats available in the library(different branches)
* Time in and time out of a student,(different branches)
* Delete entries in the database

### The users

The users should be able to perform the following actions

* Borrow and return books
* View available books in the library
* View information regarding what books they currently hold
* Make payments
* Subscribe to membership classes
* Reserve books
* Buy books
* Request for new books to be added to the library
* Book a slot (time) for a seat in a library(particular branch of library)


#### Grp members details

* Santhoshi      - 112101005
* Pawan Kumar    - 112101031
* Ruthvik        - 112101018
* Chitresh       - 112101032
