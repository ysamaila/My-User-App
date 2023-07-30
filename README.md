# My User App

This project implements the MVC (Model-View-Controller) architecture to create a user management application. It involves creating a User class to interact with an SQLite database, and a controller to handle various routes and return JSON responses.

## Part I - User Class

### Class: User

The `User` class provides an interface to interact with the SQLite database and perform CRUD operations on user records. The database file is named `db.sql`, and it contains a table named `users` with the following attributes:

- `firstname` (string)
- `lastname` (string)
- `age` (integer)
- `password` (string)
- `email` (string)

#### Methods:

1. `def create(user_info):`

   - Creates a new user with the provided `user_info` attributes (firstname, lastname, age, password, and email).
   - Returns a unique ID (a positive integer) for the created user.

2. `def find(user_id):`

   - Retrieves the user associated with the given `user_id`.
   - Returns all information contained in the database for that user.

3. `def all():`

   - Retrieves all users from the database.
   - Returns a hash of users.

4. `def update(user_id, attribute, value):`

   - Retrieves the user associated with the given `user_id`.
   - Updates the `attribute` with the provided `value`.
   - Returns the user hash after the update.

5. `def destroy(user_id):`

   - Retrieves the user associated with the given `user_id`.
   - Deletes the user from the database.

## Part II - Controller

The controller handles various routes and returns JSON responses.

### Routes:

1. `GET` on `/users`:

   - Returns all users (without their passwords).

2. `POST` on `/users`:

   - Receives firstname, lastname, age, password, and email.
   - Creates a new user and stores it in the database.
   - Returns the created user (without the password).

3. `POST` on `/sign_in`:

   - Receives email and password.
   - Adds a session containing the user_id to log in the user.
   - Returns the created user (without the password).

4. `PUT` on `/users`:

   - Requires a user to be logged in.
   - Receives a new password and updates it for the logged-in user.
   - Returns the user (without the password) after the update.

5. `DELETE` on `/sign_out`:

   - Requires a user to be logged in.
   - Signs out the current user.
   - Returns nothing (code 204 in HTTP).

6. `DELETE` on `/users`:

   - Requires a user to be logged in.
   - Signs out the current user and destroys the current user record from the database.
   - Returns nothing (code 204 in HTTP).

### Session & Cookies:

The "signed in" functionality will use session and cookies to keep track of logged-in users.

## Part III - Index Page

The route `/` responds with HTML and renders the template in `index.html` located in the `views` subdirectory.

### Example `index.html`:

```html
<!DOCTYPE html>
<html>
    <head>
        <title>Users index page</title>
    </head>
    <body>
        <h1>Users</h1>
        <table>
            <tr>
                <th>FirstName</th>
                <th>LastName</th>
                <th>Age</th>
                <th>Email</th>
            </tr>
            <tr>
                <td>XXXX</td>
                <td>XXXX</td>
                <td>XXXX</td>
                <td>XXXX</td>
            </tr>
        </table>
    </body>
</html>
```

In this template, use `<tr>` for rows in the table, `<th>` for the header row (only one), and `<td>` for content rows (multiple).

### Tips

- To run the server locally, use port: `8080`.
- To access it from your browser, change the binding address to: `0.0.0.0`.
