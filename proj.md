---
geometry: "left=3cm, right=3cm, top=3cm, bottom=3cm"
---
# PMS (Password management System)

* The aim of this project is to create a simple yet useful application, which can be used to : 
* * Storing, updating and retrieving of usernames and passwords.
* The application should also support multiple accounts for the same website
* We ensure the secrecy of the passwords from the database manager by using cryptographic measures
to encrypt the passwords
* When a user asks for a password we decrypt it using the key and return back the password

## Tables

### Users
* id, name 

### Websites
* id, name

### Account details 
* id, userId, websiteId, username, hashed_pswd
* Here the userId and websiteId are foreign keys

## Tasks to be done on data

* Add new pswds
* Update old pswds
* Retrieve stored pswds

## Expected results

* The user should be able to login and retrieve passwords for the websites for
which they have stored them beforehand or add new passwords
