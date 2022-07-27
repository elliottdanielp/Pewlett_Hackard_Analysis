# Pewlett_Hackard_Analysis:
Now that Bobby has proven his SQL chops, his manager has given both of you two more assignments: determine the number of retiring employees per title and identify employees who are eligible to participate in a mentorship program. Then, you’ll write a report that summarizes your analysis and helps prepare Bobby’s manager for the “silver tsunami” as many current employees reach retirement age.


# Results:
 - Looking at the retirement_titles table we can see that there are duplicated employee names from them changing roles over the years.
```sql
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
```
 [retirement_titles.csv](https://github.com/elliottdanielp/Pewlett_Hackard_Analysis/files/9199577/retirement_titles.csv)
 
 - Because of the duplicated employee names, we need to create a table of eligable employees in their current role.
 ```sql
SELECT DISTINCT ON (emp_no) emp_no,
  first_name,
  last_name,
  title
INTO unique_titles
FROM emp_title_time
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;
```
 [unique_titles.csv](https://github.com/elliottdanielp/Pewlett_Hackard_Analysis/files/9199628/unique_titles.csv)

- We also can break down the number of eligible employees per department. 
```sql
SELECT COUNT(title), unique_titles.title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;
```
[retiring_titles.csv](https://github.com/elliottdanielp/Pewlett_Hackard_Analysis/files/9199856/retiring_titles.csv)

- Since there are so many eligible employees for retirement, we will need to find employees that are eligible to fill the roles.
```sql
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
	e.birth_date,
	de.from_date, 
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no);
WHERE (e.to_date = '9999-01-01' AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'))
ORDER BY e.emp_no;
```
[mentorship_eligiblity.csv](https://github.com/elliottdanielp/Pewlett_Hackard_Analysis/files/9199906/mentorship_eligiblity.csv)
 

# Summary:

 How many roles will need to be filled as the "silver tsunami" begins to make an impact?

- We can view the count of the retirement_info and get an approximate 41,000 roles that will need to be filled.
 ![retirement_info count](https://user-images.githubusercontent.com/106495422/181274995-91d220f9-40e0-429e-9b85-96059e13ad75.png)


Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
- We can view that there are a little over 1,500 employees that are eligible

![mentorship_eligibility count](https://user-images.githubusercontent.com/106495422/181276697-1ad12f5f-35b0-4792-ad7b-f2fac9d3410c.png)


