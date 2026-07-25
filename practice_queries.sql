use library_managemnet_system


-- 1 . Show only the book title and publication year.

select title as book_title, publication_year from books

--2. Show all books published after 2000.

select * from books where publication_year > 2000

--3.  Show all books with available copies greater than 5.

select title as book_title from books where available_copies >= 5

-- 4.  Sort books by publication year (newest first).

select * from books order by publication_year desc

-- 5 . Display only Fantasy books (this will require a JOIN).

select b.title as book_name, c.catagory_name from books b inner join catagories c on c.catagory_id=b.catagorie_id where catagory_name = 'fantasy'

-- 6 . How many books are available in our library?


select count(title) as number_of_books from books

-- 7 . Show me all unique categories available in the library.

select distinct catagory_name from catagories

-- 8 . Find all books published between 1990 and 2010.

select  title, publication_year from books where publication_year between 1990 and 2010 order by publication_year desc

-- 9 . Find all students whose names start with the letter R

select* from stu_dents where student_name like 'R%'

-- 10 . "Show all books whose title contains the word 'The'.

select*  from books where title like 'the%'

-- 11 . How many students are registered in the library
select * from stu_dents

select count(students_id) as number_of_students_registered from stu_dents

-- 12 . Find all books belonging to either the Fantasy or Mystery category.

select b.title as book_name, c.catagory_name from books b inner join catagories c on b.catagorie_id=c.catagory_id where catagory_name in ('fantasy', 'mystery')

-- 13 . Display all books that have not been returned yet

select books.title, books.total_copies  from book_issue  inner join books on book_issue.book_id = books.book_id where book_issue.return_date is null

-- 14 . Show the oldest book in the library.

select top(1) title, max(publication_year) as year_of_publication from books  group by publication_year, title order by publication_year

-- 15 . Which book has the highest number of available copies

select top(1) title, available_copies from books order by available_copies desc

-- 16 . Show the names of students who currently have a book issued

select s.student_name from stu_dents s inner join book_issue b on s.students_id=b.student_id where return_date is null

-- 17.  How many books are available in each category

select c.catagory_name,  count(b.book_id) as number_of_book from books b inner join catagories c on b.catagorie_id=c.catagory_id group by c.catagory_name

-- 18 . What is the total number of available copies of all books?

select book_id, title, available_copies from books 

-- 19 . What is the average number of available copies per book

select  avg(available_copies) as average_copies from books 

-- 20 . Which category has the highest number of books

select top(1) c.catagory_id, c.catagory_name, count(b.book_id) as total_count
from books b inner join catagories c on b.catagorie_id=c.catagory_id group by c.catagory_id, c.catagory_name order by total_count desc

-- 21 . Show only those categories that have more than 2 books

select c.catagory_name,COUNT(b.book_id) AS total_books  from catagories c inner join books b on c.catagory_id=b.catagorie_id group by c.catagory_name, c.catagory_id HAVING count(b.book_id) > 2

-- 22 . Which author has written the most books in the library

select top(1) a.author_name, count(b.book_id) as total_books from author a inner join books b on a.author_id=b.author_id group by a.author_name order by total_books desc


-- 23 . Find the total number of books issued.

select count(*) as total_books_issued from book_issue where return_date is null

-- 24 . Which students have borrowed more than one book

select top(1) s.students_id, s.student_name, count(b.book_id) as total_book_issued from book_issue b inner join stu_dents s on b.student_id=s.students_id group by s.students_id,s.student_name having count(b.book_id)> 0 order by total_book_issued desc

-- 25 . Books that have never been borrowed

select books.book_id, books.title from books  left join book_issue on books.book_id=book_issue.book_id where book_issue.issue_date is null

-- 26 . students who have never borrowed a book.

select s.students_id, s.student_name from  stu_dents s left join book_issue b  on s.students_id = b.student_id where b.student_id is null

-- 27 . List all students who have borrowed more than 3 books.

select s.students_id,s.student_name from stu_dents s left join book_issue b on s.students_id = b.student_id group by students_id,student_name having count(b.book_id) > 3


-- 28 . Find the student who has borrowed the highest number of books.

select  s.students_id, s.student_name,count(b.book_id) as total_books from stu_dents s inner join book_issue b on s.students_id=b.student_id group by s.students_id,s.student_name order by total_books desc 

-- 29. Find the books that have been borrowed the most.

select count(books.book_id) as times_borrowed,books.title from books inner join book_issue on books.book_id = book_issue.book_id   
group by books.title order by times_borrowed desc

-- 30 . Find all books that have been borrowed but have not been returned yet.

select bb.book_id,bb.title from books bb inner join book_issue b on bb.book_id=b.book_id where return_date is null 

-- 31 . Find students who have not returned their books and whose books are overdue.

select s.student_name,bb.title, b.due_date from stu_dents s join book_issue b on s.students_id=b.student_id join books bb on bb.book_id=b.book_id where return_date is null and due_date < getdate() 

-- 32 . The author whose books have been borrowed the most.

select top (1) a.author_name, count(bb.book_id) as most_borrowed from author a join books b on a.author_id = b.author_id join book_issue bb on b.book_id=bb.book_id  group by a.author_name order by most_borrowed desc

-- 33 . Category-wise Book Count

select c.catagory_name, count(b.book_id) as book_count from catagories c left join books b on c.catagory_id=b.catagorie_id group by c.catagory_name order by book_count

-- 34 . Students who currently have more than one book issued

select s.student_name, count(book_id) as books_count from stu_dents s inner join book_issue b on s.students_id=b.student_id  where b.return_date is null group by s.student_name having count(b.book_id) > 1 order by books_count desc

-- 35.  the top 3 students who have borrowed the most books overall

select top(3) with ties s.student_name, count(b.book_id) as book_count from stu_dents s inner join book_issue b on s.students_id=b.student_id group by s.student_name order by book_count desc, s.student_name asc

-- 36 . Find the student(s) who borrowed the highest number of books.

select top(1) s.student_name, count(b.book_id) as highest_book_count from stu_dents s inner join book_issue b on s.students_id=b.student_id group by s.student_name order by highest_book_count desc

-- 37 . Books that have never been issued.

select b.book_id,b.title from books b left join book_issue bb on b.book_id=bb.book_id where bb.book_id is null 

-- 38 . Category-wise Book Count
select catagory_id, catagory_name, count(b.book_id) as book_count from catagories c left join books b on c.catagory_id = b.catagorie_id group by catagory_id,catagory_name order by book_count,c.catagory_id
select * from catagories 
select * from books

-- 39 . Monthly Borrowing Trends

select month(issue_date) as month,year(issue_date) as year, count(book_id) as book_count from book_issue group by year(issue_date),month(issue_date) order by year(issue_date),month(issue_date)

-- 40 . Daily Issue Report

select issue_date,count(book_id) as book_count from book_issue group by issue_date order by book_count,issue_date


-- 41 . Top 3 Students Who Borrowed the Most Books

select top (3) s.students_id,s.student_name, count(b.book_id) as book_count from stu_dents s left join book_issue b on s.students_id=b.student_id group by s.students_id,s.student_name order by book_count desc

-- 42 . Students Who Currently Have More Than One Book Issued

select s.students_id,s.student_name, count(b.book_id) as book_count  from stu_dents s inner join book_issue b on s.students_id = b.student_id group by s.students_id, s.student_name having count(b.book_id) > 1  order by book_count

-- 43 . Categories That Have More Than 5 Books





select  c.catagory_id, c.catagory_name, count(b.book_id) as book_count from catagories c left join books b on c.catagory_id = b.catagorie_id group by c.catagory_id,c.catagory_name having count(b.book_id) >5  order by book_count desc

--44 . Students Who Have Never Borrowed a Book (Using NOT EXISTS)

SELECT
    s.students_id,
    s.student_name
FROM stu_dents s
WHERE NOT EXISTS
(
    SELECT 1
    FROM book_issue b
    WHERE s.students_id = b.student_id
);

-- 45 . Which student has borrowed the highest number of books?

select top 1 s.students_id,s.student_name,count(bi.book_id) as book_count from book_issue bi inner join stu_dents s on bi.student_id = s.students_id group by students_id,student_name order by book_count desc

-- 46 . Display the students who currently have books issued (i.e., books that have not yet been returned).

select 
  s.students_id,
  s.student_name,
  b.book_id,
  b.issue_date 
from 
  stu_dents s inner join book_issue b 
on 
  s.students_id=b.student_id  
where
  return_date is null 
order by 
  b.issue_date 

-- 47 . Find the Most Borrowed Book
select 
 b.book_id,
 b.title,
 count(bi.book_id) as book_count
from 
 books b inner join book_issue bi
on 
 b.book_id = bi.book_id
group by 
 b.book_id,
 b.title

-- 48 . Find the Most Popular Author

select top 1 with ties
 a.author_id,
 a.author_name,
 count(bi.book_id) as book_count_borrowed
from 
 author a inner join books b on a.author_id = b.author_id
 inner join book_issue bi on b.book_id = bi.book_id
 
group by 
  a.author_id,
  a.author_name
order by
  book_count_borrowed desc
 

-- 49 . Find the category whose books have been borrowed the most.

select top 1
 c.catagory_name,
 count(bi.book_id) as book_count
from 
 catagories c inner join books b on c.catagory_id = b.catagorie_id inner join book_issue bi on b.book_id = bi.book_id 
 group by 
  c.catagory_name
 order by book_count desc
 
--50 . Students Who Borrowed Books from the Most Different Categories

select top 1
 s.student_name, count(distinct c.catagory_id) as different_cat_count 
from
 stu_dents s inner join book_issue bi on s.students_id = bi.student_id
 inner join books b on bi.book_id=b.book_id inner join catagories c on b.catagorie_id = c.catagory_id
group by 
 s.student_name

order by 
 different_cat_count desc

 -- 51 . Find the Student Who Borrowed the Same Book More Than Once
 select * from book_issue

 select s.student_name from stu_dents s inner join book_issue bi on s.students_id = bi.student_id  group by s.student_name,s.students_id,bi.book_id having count(*) > 1


-- 52 . Books Never Returned

select 
 distinct bi.book_id,b.title 
from 
 book_issue bi inner join books b on bi.book_id=b.book_id 
where 
 return_date is null 

-- 53 . Find students who have borrowed books but have never returned even a single book.

SELECT
    s.students_id,
    s.student_name
FROM stu_dents s
WHERE EXISTS (
    SELECT 1
    FROM book_issue bi
    WHERE bi.student_id = s.students_id
)
AND NOT EXISTS (
    SELECT 1
    FROM book_issue bi
    WHERE bi.student_id = s.students_id
      AND bi.return_date IS NOT NULL
);
-- 54 . Find the books that have been borrowed by every student.

SELECT
    b.book_id,
    b.title
FROM books b
INNER JOIN book_issue bi
    ON b.book_id = bi.book_id
GROUP BY
    b.book_id,
    b.title
HAVING COUNT(DISTINCT bi.student_id) =
(
    SELECT COUNT(*)
    FROM stu_dents
);

--Query 55: Find the student who has borrowed the highest number of books.

select top 1 s.students_id,s.student_name, count(*) as book_count from stu_dents s inner join book_issue bi on s.students_id=bi.student_id group by s.students_id ,s.student_name order by book_count desc

--Query 56: Find the author whose books have been borrowed the most times.

select top 1 a.author_id,a.author_name, count(*) as book_count from author a inner join books b on a.author_id=b.author_id inner join book_issue bi on b.book_id=bi.book_id group by a.author_id,a.author_name order by book_count desc 

--Query 57: Find the category whose books have been borrowed the most times.

select top 1 c.catagory_id,c.catagory_name, count(*) as most_borrowed from catagories c inner join books b on c.catagory_id=b.catagorie_id inner join book_issue bi on b.book_id=bi.book_id group by c.catagory_id,c.catagory_name order by most_borrowed desc 

--Query 58: Find the student who has borrowed the most different books.

select top 1 s.students_id,s.student_name, count(distinct bi.book_id) as different_books from stu_dents s inner join book_issue bi on s.students_id=bi.student_id group by s.students_id,s.student_name order by different_books desc

--Query 59: Find students who have borrowed all books from a particular category.

SELECT
    s.students_id,
    s.student_name
FROM stu_dents s
INNER JOIN book_issue bi
    ON s.students_id = bi.student_id
INNER JOIN books b
    ON bi.book_id = b.book_id
WHERE b.catagorie_id = 1
GROUP BY
    s.students_id,
    s.student_name
HAVING COUNT(DISTINCT b.book_id) =
(
    SELECT COUNT(*)
    FROM books
    WHERE catagorie_id = 1
);


--Query 60: Find students who have borrowed books from more than one category.

select s.students_id,s.student_name,count(distinct b.catagorie_id) as catagory_count
from stu_dents s inner join book_issue bi on s.students_id=bi.student_id inner join books b on bi.book_id=b.book_id 
group by s.students_id,s.student_name
having count(distinct b.catagorie_id) > 1

--Query 61: Find students who have borrowed the same book more than once.

select s.students_id,s.student_name,b.title, count(*) as borrowed_books from stu_dents s inner join book_issue bi on s.students_id=bi.student_id inner join books b on bi.book_id=b.book_id
group by s.students_id,s.student_name,b.title
having count(*) > 1

-- Query 62: Find students who have never borrowed a book.

select s.students_id,s.student_name 
from stu_dents s left join book_issue bi on s.students_id=bi.student_id
where bi.student_id is null
group by s.students_id,s.student_name

--Query 63: Find books that have never been borrowed.

select b.book_id,b.title 
from books b left join book_issue bi on b.book_id=bi.book_id 
where bi.book_id is null 
group by b.book_id,b.title

--Query 64: Find authors whose books have never been borrowed.
select * from book_issue
select * from author
select * from catagories
select * from stu_dents


select a.author_id,a.author_name 
from author a inner join books b on a.author_id=b.author_id left join book_issue bi on b.book_id=bi.book_id 
where bi.book_id is null
group by a.author_id,a.author_name 

--Query 65: Find categories that have no books.

select c.catagory_id,c.catagory_name from catagories c left join books b on c.catagory_id=b.catagorie_id 
where b.book_id is null 
