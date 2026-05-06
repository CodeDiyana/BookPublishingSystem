CREATE DATABASE book_publishing_system;
USE book_publishing_system;


-- 4: SQL Table Creation
-- Create Publisher Table
CREATE TABLE publisher (
    publisher_id VARCHAR(10) PRIMARY KEY,
    pu_name VARCHAR(100) NOT NULL,
    pu_address VARCHAR(200),
    pu_phone VARCHAR(20),
    pu_website_url VARCHAR(100)
);

-- Create Author Table
CREATE TABLE author (
    author_id VARCHAR(10) PRIMARY KEY,
    au_name VARCHAR(100) NOT NULL,
    au_address VARCHAR(200),
    au_homepage_url VARCHAR(100)
);

-- Create Warehouse Table
CREATE TABLE warehouse (
    warehouse_code VARCHAR(10) PRIMARY KEY,
    wh_address VARCHAR(200),
    wh_phone VARCHAR(20)
);

-- Create Book Table
CREATE TABLE book (
    isbn VARCHAR(13) PRIMARY KEY,
    book_title VARCHAR(200) NOT NULL UNIQUE,
    book_year INT,
    book_price DECIMAL(10, 2),
    publisher_id VARCHAR(10),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Create Book-Author Junction Table
CREATE TABLE book_author (
    isbn VARCHAR(13),
    author_id VARCHAR(10),
    PRIMARY KEY (isbn, author_id),
    FOREIGN KEY (isbn) REFERENCES book(isbn),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Create Book-Warehouse Junction Table 
CREATE TABLE book_warehouse (
    isbn VARCHAR(13),
    warehouse_code VARCHAR(10),
    copies INT DEFAULT 0,
    PRIMARY KEY (isbn, warehouse_code),
    FOREIGN KEY (isbn) REFERENCES book(isbn),
    FOREIGN KEY (warehouse_code) REFERENCES warehouse(warehouse_code)
);

-- 5: Populate Tables with Sample Data

-- Insert Publishers
INSERT INTO publisher (publisher_id, pu_name, pu_address, pu_phone, pu_website_url) VALUES
('P1', 'TechBooks Ltd.', '123 Tech Street, NY', '555-1234', 'www.techbooks.com'),
('P2', 'DataPress Inc.', '456 Data Avenue, CA', '555-5678', 'www.datapress.com'),
('P3', 'CodePublish Co.', '789 Code Lane, TX', '555-9012', 'www.codepublish.com'),
('P4', 'Academic Press', '321 University Blvd, MA', '555-3456', 'www.academicpress.com');

SELECT * FROM publisher;

-- Insert Authors
INSERT INTO author (author_id, au_name, au_address, au_homepage_url) VALUES
('A1', 'John Smith', '100 Writer Way, NY', 'www.johnsmith.com'),
('A2', 'Jane Miller', '200 Author Ave, CA', 'www.janemiller.com'),
('A3', 'Mike Brown', '300 Book Street, TX', 'www.mikebrown.com'),
('A4', 'Sarah Davis', '400 Novel Road, FL', 'www.sarahdavis.com'),
('A5', 'Tom Wilson', '500 Story Lane, WA', 'www.tomwilson.com');

SELECT * FROM author;

-- Insert Warehouses
INSERT INTO warehouse (warehouse_code, wh_address, wh_phone) VALUES
('W1', '1000 Storage Blvd, NJ', '555-1111'),
('W2', '2000 Stock Street, IL', '555-2222'),
('W3', '3000 Warehouse Way, GA', '555-3333'),
('W4', '4000 Inventory Ave, CO', '555-4444');

SELECT * FROM warehouse;

-- Insert Books
INSERT INTO book (isbn, book_title, book_year, book_price, publisher_id) VALUES
('123456789', 'AI Essentials', 2023, 49.99, 'P1'),
('987654321', 'SQL for Dummies', 2022, 39.99, 'P2'),
('111222333', 'Python Basics', 2024, 44.99, 'P1'),
('444555666', 'Data Science Guide', 2023, 59.99, 'P2'),
('777888999', 'Web Development Pro', 2024, 54.99, 'P3'),
('555666777', 'Machine Learning Handbook', 2023, 64.99, 'P1'),
('888999000', 'Cloud Computing Essentials', 2024, 52.99, 'P2');

SELECT * FROM book;

-- Insert Book-Author relationships
INSERT INTO book_author (isbn, author_id) VALUES
('123456789', 'A1'),
('123456789', 'A2'),
('987654321', 'A3'),
('111222333', 'A2'),
('111222333', 'A4'),
('444555666', 'A1'),
('444555666', 'A3'),
('444555666', 'A5'),
('777888999', 'A4'),
('555666777', 'A2'),
('888999000', 'A3'),
('888999000', 'A5');

SELECT * FROM book_author;

-- Insert Book-Warehouse stock
INSERT INTO book_warehouse (isbn, warehouse_code, copies) VALUES
('123456789', 'W1', 10),
('123456789', 'W2', 5),
('987654321', 'W1', 3),
('987654321', 'W3', 8),
('111222333', 'W2', 15),
('111222333', 'W4', 12),
('444555666', 'W1', 7),
('444555666', 'W2', 9),
('444555666', 'W3', 6),
('777888999', 'W3', 20),
('777888999', 'W4', 18),
('555666777', 'W1', 14),
('555666777', 'W3', 11),
('888999000', 'W2', 16),
('888999000', 'W4', 9);

SELECT * FROM book_warehouse;

-- 6a) List all books written by the author 'John Smith'
SELECT b.isbn, b.book_title, b.book_year, b.book_price
FROM book b
JOIN book_author ba ON b.isbn = ba.isbn
JOIN author a ON ba.author_id = a.author_id
WHERE a.au_name = 'John Smith';

-- 6b) Find the total number of copies available for each book across all warehouses
SELECT b.isbn, b.book_title, SUM(bw.copies) AS total_copies
FROM book b
LEFT JOIN book_warehouse bw ON b.isbn = bw.isbn
GROUP BY b.isbn, b.book_title;

-- 6c) List all publishers that have published more than 2 books
SELECT p.publisher_id, p.pu_name, COUNT(b.isbn) AS num_books
FROM publisher p
JOIN book b ON p.publisher_id = b.publisher_id
GROUP BY p.publisher_id, p.pu_name
HAVING COUNT(b.isbn) > 2;

-- 6d) Show the warehouse(s) where the book titled 'Python Basics' is stored
SELECT w.warehouse_code, w.wh_address, bw.copies
FROM warehouse w
JOIN book_warehouse bw ON w.warehouse_code = bw.warehouse_code
JOIN book b ON bw.isbn = b.isbn
WHERE b.book_title = 'Python Basics';

-- 6e) List all books along with their authors and publisher names
SELECT b.isbn, b.book_title, a.au_name AS author_name, p.pu_name AS publisher_name
FROM book b
JOIN publisher p ON b.publisher_id = p.publisher_id
JOIN book_author ba ON b.isbn = ba.isbn
JOIN author a ON ba.author_id = a.author_id
ORDER BY b.book_title, a.au_name;

-- 6f) Find the most expensive book and the name of its publisher
SELECT b.isbn, b.book_title, b.book_price, p.pu_name
FROM book b
JOIN publisher p ON b.publisher_id = p.publisher_id
WHERE b.book_price = (SELECT MAX(book_price) FROM book);

-- 6g) List books that are stored in more than one warehouse
SELECT b.isbn, b.book_title, COUNT(bw.warehouse_code) AS num_warehouses
FROM book b
JOIN book_warehouse bw ON b.isbn = bw.isbn
GROUP BY b.isbn, b.book_title
HAVING COUNT(bw.warehouse_code) > 1;

-- 7: Add Constraints and Indexing

-- Create index on author name for faster searches
CREATE INDEX idx_author_name ON author(au_name);

-- 8: Use CASE and GROUP BY

-- Group books by publisher with total count, average price, and volume classification
SELECT
    p.publisher_id,
    p.pu_name,
    COUNT(b.isbn) AS num_books,
    AVG(b.book_price) AS avg_price,
    CASE
        WHEN COUNT(b.isbn) > 3 THEN 'High Volume Publisher'
        ELSE 'Small Publisher'
    END AS publisher_category
FROM publisher p
LEFT JOIN book b ON p.publisher_id = b.publisher_id
GROUP BY p.publisher_id, p.pu_name;