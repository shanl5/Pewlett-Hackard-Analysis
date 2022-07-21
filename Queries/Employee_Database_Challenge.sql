-- Deliverable 1: The Number of Retiring Employees by Title
--   D1_1-7. up to pre-export of csv
--   ('Retirement Titles' table data definition: "all the
--    titles of employees who were born between Jan 1, 1952
--    and Dec 31, 1955.")
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   t.title,
	   t.from_date,
	   t.to_date
INTO retirement_titles
FROM employees AS "e"
INNER JOIN titles AS "t"
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Check data in the new table
SELECT * FROM retirement_titles;

-- Note (from Mod. 7 Challenge desription):
--     "There are duplicate entries for some employees
--     because they have switched titles over the years."
--     The instructions below will remove the duplicates
--     "and keep only the most recent title of each employee."
--   D1_8-15. up to pre-export of csv file two
--   ('Unique Titles' table data definition: "the most recent
--    title only of employees who were born between Jan 1, 1952
--    and Dec 31, 1955; i.e. the most recent title of employees
--    in the --Retirement Titles-- table from query above")
--     Note: query code template below from file...
--           `Employee_Challenge_starter_code.sql`
-- -- Use Dictinct with Orderby to remove duplicate rows
-- -- SELECT DISTINCT ON (______) _____,
-- -- ______,
-- -- ______,
-- -- ______

-- -- INTO nameyourtable
-- -- FROM _______
-- -- WHERE _______
-- -- ORDER BY _____, _____ DESC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles AS "rt"
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

-- Check data in newly created table:
SELECT * FROM unique_titles;

--   D1_16-21. up to pre-export of Challenge csv file three
--   From the Challenge text, will "retrieve the number of
--   employees by their most recent job title who are about
--   to retire." A full table description is as below ...
--   ('Retiring Titles' table data definition: the number
--    of employees who were born between Jan 1, 1952
--    and Dec 31, 1955 by their most recent job title; i.e.,
--    num employees from unique_titles table in query above
--    by their (in) most recent job title(s).)
SELECT count(ut.emp_no),
	   ut.title
INTO retiring_titles
FROM unique_titles AS "ut"
GROUP BY ut.title
ORDER BY "count" DESC, ut.title; -- note(a)

--- (a) not strictly necessary to give secondary sort on title
--- here since no duplication in the title, or emp_no, counts

-- Check the data in the table created in the query above...
SELECT * FROM retiring_titles;

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Deliverable 2: The Employees Eligible for the Mentorship Program
--   D2(1-11). up to pre-export of deliverable 2 csv
--   ('Mentorship_Eligibility' table data definition: seven columns of
--    info culled from three database tables for "current employees ...
--    whose birth dates are between Jan 1, 1965 and Dec 31, 1965."
--    --from Mod. 7 Challenge text)
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   t.title
INTO mentorship_eligibility
FROM employees AS "e"
INNER JOIN dept_emp AS "de"
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS "t"
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Check: the newly created table from query immediately above...
SELECT * FROM mentorship_eligibility;