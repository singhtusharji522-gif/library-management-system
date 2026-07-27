create database library_managemnet_system


create table author
( author_id int primary key,
author_name varchar(255),
country varchar(255))

select * from author


create table catagories
(
book_id int primary key,
title varchar(255) not null,
author_id int,
catagorie_id int,
publication_year int,
total_copies int,
available_copies int)
select * from catagories

exec sp_rename 'catagories','books'

select * from books

create table catagories
(
catagory_id int primary key,
catagory_name varchar(255) not null)

select * from catagories

create table stu_dents 
(
students_id int primary key,
student_name varchar(255),
gender varchar(255),
contact int,
course varchar(255),
email varchar(255),
registration_date date
)

create table librarians
(
librarian_id int primary key,
librarian_name varchar(255),
contact int,
email varchar(255)
)

create table book_issue
(
issue_id int primary key,
book_id int,
student_id int,
librarian_id int,
issue_date date,
due_date date,
return_date date
)

-- adding foreign key
alter table book_issue add constraint for_key_book_id  foreign key (book_id) references books(book_id)

alter table book_issue add constraint fro_key_student_id foreign key (student_id) references stu_dents(students_id)

alter table book_issue add constraint for_key_librarian_id foreign key (librarian_id) references librarians(librarian_id)


INSERT INTO Author VALUES
(1, 'J.K. Rowling', 'United Kingdom'),
(2, 'George Orwell', 'United Kingdom'),
(3, 'Paulo Coelho', 'Brazil'),
(4, 'Chetan Bhagat', 'India'),
(5, 'Ruskin Bond', 'India'),
(6, 'R.K. Narayan', 'India'),
(7, 'Dan Brown', 'United States'),
(8, 'Agatha Christie', 'United Kingdom'),
(9, 'Stephen King', 'United States'),
(10, 'Arthur Conan Doyle', 'United Kingdom');

INSERT INTO Catagories VALUES
(1, 'Fiction'),
(2, 'Science'),
(3, 'Technology'),
(4, 'History'),
(5, 'Biography'),
(6, 'Fantasy'),
(7, 'Mystery'),
(8, 'Programming'),
(9, 'Mathematics'),
(10, 'Self Help');
select*from books

INSERT INTO Books VALUES
(101,'Harry Potter',1,6,1997,10,6),
(102,'Animal Farm',2,1,1945,8,5),
(103,'The Alchemist',3,10,1988,12,9),
(104,'Five Point Someone',4,1,2004,7,3),
(105,'The Blue Umbrella',5,1,1990,6,6),
(106,'Malgudi Days',6,1,1943,10,8),
(107,'The Da Vinci Code',7,7,2003,9,4),
(108,'Murder on the Orient Express',8,7,1934,8,2),
(109,'The Shining',9,7,1977,5,5),
(110,'Sherlock Holmes',10,7,1892,10,7);

alter table stu_dents alter column contact varchar(55)

INSERT INTO Stu_dents VALUES
(1,'Rahul Sharma','Male','9876543210','BCA','rahul@gmail.com','2025-01-10'),
(2,'Priya Singh','Female','9876543211','B.Sc','priya@gmail.com','2025-01-15'),
(3,'Aman Verma','Male','9876543212','B.Com','aman@gmail.com','2025-02-01'),
(4,'Sneha Gupta','Female','9876543213','B.Tech','sneha@gmail.com','2025-02-05'),
(5,'Rohit Kumar','Male','9876543214','BCA','rohit@gmail.com','2025-02-10');

alter table librarians alter column contact varchar(55)

INSERT INTO Librarians VALUES
(1,'Anjali Mehta','9999999991','anjali@library.com'),
(2,'Suresh Kumar','9999999992','suresh@library.com');

select * from book_issue

INSERT INTO Book_Issue VALUES
(1,101,1,1,'2025-06-01','2025-06-15','2025-06-14'),
(2,102,2,2,'2025-06-03','2025-06-17','2025-06-18'),
(3,103,3,1,'2025-06-05','2025-06-19',NULL),
(4,107,4,2,'2025-06-07','2025-06-21','2025-06-20'),
(5,108,5,1,'2025-06-10','2025-06-24',NULL);

select * from catagories
select * from books
select * from librarians

select * from book_issue
select * from stu_dents








