CREATE DATABASE caseStudy3;
USE caseStudy3;   

CREATE TABLE people (
person_id INT AUTO_INCREMENT,
PRIMARY KEY(person_id),
person_fname VARCHAR(100),
person_lname VARCHAR(100)
);

CREATE TABLE roles ( 
role_id INT AUTO_INCREMENT,
PRIMARY KEY(role_id),
position VARCHAR(100)
);

CREATE TABLE employee (
employee_id INT AUTO_INCREMENT,
PRIMARY KEY (employee_id),
person_id INT,
FOREIGN KEY (person_id) REFERENCES people(person_id),
role_id INT,
FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE book (
book_id INT AUTO_INCREMENT,
PRIMARY KEY (book_id),
author_id INT,
FOREIGN KEY (author_id) REFERENCES book_author (author_id),
book_name VARCHAR(100),
book_description VARCHAR(100),
book_genre VARCHAR(100)
);

CREATE TABLE book_author (
author_id INT AUTO_INCREMENT,
PRIMARY KEY (author_id),
author_fname VARCHAR(100),
author_lname VARCHAR (100)
);

CREATE TABLE book_inventory (
inventory_id INT AUTO_INCREMENT,
PRIMARY KEY (inventory_id),
is_checked_in BOOLEAN,
checkout_date DATE,
checkin_date DATE,
book_id INT,
FOREIGN KEY (book_id) REFERENCES book(book_id),
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE customer (
customer_id INT AUTO_INCREMENT,
PRIMARY KEY (customer_id),
customer_fname VARCHAR(100),
customer_lname VARCHAR(100),
library_card INT,
fines INT
);



        
INSERT INTO people (person_fname, person_lname)
VALUES  ("John","Doe"),
		("Seth","Mulia"),
        ("Emmanuel","Massey"),
		("Vicky","Smith");
        
INSERT INTO roles(position)
VALUES ("Manager"),
		("Librarian"),
        ("Janitor"),
        ("Administrator"),
        ("Owner"),
        ("Technical Support");
INSERT INTO employee (person_id, role_id) 
VALUES (1, 3),
		(1, 6),
        (2, 2),
        (2, 5),
        (3, 4),
        (4, 1),
        (4, 4);        
        
INSERT INTO book(book_name, book_description, book_genre, author_id)
VALUES ("Cracking The Coding Interview", "A book about how to pass coding technical interviews", "Education", 1),
		("Cat in the hat", "A book about a cat in a hat", "Funny", 2),
        ("The house on main street", "A book about a haunted house", "Horror", 3),
        ("Cooking for Dummies", "A book about how to cook", "Education", 4),
        ("Cars and Coffee", "A book aboutcar meets", "General", 5),
        ("Bill Nye the sciece guy", "A book about everyhting science", "Education", 5);
        
INSERT INTO book_author (author_fname, author_lname)
VALUES ("Cambell", "Brady"),
		("Steve", "Smith"),
        ("Justin", "McNeil"),
        ("Drew", "Brees"),
        ("Faith", "Mejia");

INSERT INTO book_inventory (is_checked_in, book_id, customer_id)
VALUES (1, 26, 3),
		(0, 25, 1),
        (0, 27, 2),
        (1, 28, 4),
        (1, 29, 5);

INSERT INTO customer (customer_fname, customer_lname, library_card, fines)
VALUES ("Samantha", "Greene", 123456, 250),
		("Josh", "Allen", 654321, 361),
        ("Ray", "Lewis", 234561, 0),
        ("Richard", "Sherman", 165432, 100),
        ("Jalen", "Ramsey", 345612, 20);
        
-- STORED QUERIES

-- Allows yopu to be like Justin and delete the entire database
SET SQL_SAFE_UPDATES = 0;
DROP DATABASE caseStudy3;
-- Get a list of all the people in the database waiting to have a role aplied to them
SELECT * 
FROM people;
-- Get a list of all the current customers in the database 
SELECT * 
FROM customer;
-- Add a new person to the database even if they don't have a role yet
INSERT INTO people (person_fname, person_lname)
VALUES ("", "");
-- Add a new customer to the database
INSERT INTO customer (customer_fname, customer_lname, library_card, fines)
VALUES ("", "", 000000, 000);
-- Update the rold of an employee in the database
UPDATE employee 
SET role_id = 0, person_id = 0
WHERE employee_id = 0;
/*Update the amount of fines the customer has left to pay
 or add more if they continue to not return books by their id */
UPDATE customer 
SET fines = 0
 WHERE customer_id = 0;
 -- Delete an employee from the database by their id number
DELETE FROM employee
WHERE employee_id = 0;
-- Delete a customer from the database by their id number
DELETE FROM customer 
WHERE customer_id = 0;
-- List all the books and if they are checked in or out
SELECT * FROM book_inventory;

/*Grabs all info from customer table and book inventory table
the book the customer has and if they've returned it or not */
SELECT * 
FROM customer 
LEFT JOIN book_inventory
ON customer.customer_id = book_inventory.customer_id;
/* Grabs a list of all the current books and the author that published the book
 from the book and book_author table and combines it into one table */
SELECT book.book_name, book_author.author_fname, book_author.author_lname 
FROM book 
INNER JOIN book_author
ON book.author_id = book_author.author_id;
