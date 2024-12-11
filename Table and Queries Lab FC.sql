CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY, 
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Genre VARCHAR(30),
    Published_Year INT,
    Quantity_Available INT NOT NULL CHECK (Quantity_Available >= 0)
);


CREATE TABLE Users (
    User_ID SERIAL PRIMARY KEY,  
    Full_Name VARCHAR(200) NOT NULL,
    Email_Address VARCHAR(200) UNIQUE NOT NULL,
    Membership_Date DATE NOT NULL
);

CREATE TYPE loan_status AS ENUM ('borrowed', 'returned', 'overdue');

CREATE TABLE Book_Loans (
    Loan_ID SERIAL PRIMARY KEY,
    User_ID INT NOT NULL,
    Book_ISBN VARCHAR(13) NOT NULL,
    Loan_Date DATE NOT NULL,
    Return_Date DATE,
    Status loan_status NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY (Book_ISBN) REFERENCES Books(ISBN),
    CHECK (Return_Date IS NULL OR Return_Date >= Loan_Date)
);



INSERT INTO Books (Title, Author, ISBN, Genre, Published_Year, Quantity_Available)
VALUES ('Harry Potter', 'J. K. Rowling', '9780439708180', 'Fantasy', 1997, 5);

INSERT INTO Users (Full_Name, Email_Address, Membership_Date)
VALUES ('Sakamoto Usagi', 'UsagiSakamoto@gmail.com', '2024-12-9');

INSERT INTO Book_Loans (User_ID, Book_ISBN, Loan_Date, Return_Date, Status)
VALUES (1, '9780439708180', '2024-12-10', '2024-12-12', 'borrowed');

SELECT Books.Title, Books.Author, Book_Loans.Loan_Date, Book_Loans.Status
FROM Books
JOIN Book_Loans ON Books.ISBN = Book_Loans.Book_ISBN
WHERE Book_Loans.User_ID = 1;

INSERT INTO Book_Loans (User_ID, Book_ISBN, Loan_Date, Return_Date, Status)
VALUES (1, '9780439708180', '2024-12-9', '2024-12-10', 'overdue');

SELECT Book_Loans.Loan_ID, Users.Full_Name, Books.Title, Book_Loans.Loan_Date, Book_Loans.Return_Date, Book_Loans.Status
FROM Book_Loans
JOIN Users ON Book_Loans.User_ID = Users.User_ID
JOIN Books ON Book_Loans.Book_ISBN = Books.ISBN
WHERE Book_Loans.Status = 'overdue';


