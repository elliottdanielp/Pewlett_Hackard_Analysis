-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no,
	first_name,
	last_name
FROM employees;

-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title,
	from_date,
	to_date
FROM titles;

-- Create a new table using the INTO clause.Join both tables on the primary key.
-- Filter the data on the birth_date column to retrieve the employees who were born 
-- between 1952 and 1955. Then, order by the employee number.
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    t.title,
    t.from_date,
	t.to_date
INTO emp_title_time
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT *
FROM emp_title_time;

--Steps 8 - 13 
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM emp_title_time
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

SELECT * 
FROM unique_titles

--Steps 16 - 19
SELECT COUNT(title), unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT *
FROM retiring_titles;