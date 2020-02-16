/* Drop existing tables if needed

drop table department_employees CASCADE;
drop table department_manager CASCADE;
drop table departments CASCADE;
drop table employees CASCADE;
drop table salaries CASCADE;
drop table titles CASCADE;

*/


-- Import the data to the tables

COPY departments from '/Users/Umar/departments.csv'
with (format CSV, HEADER);

COPY employees from '/Users/Umar/employees.csv'
with (format CSV, HEADER);

COPY department_employees from '/Users/Umar/dept_emp.csv'
with (format CSV, HEADER);

COPY department_manager from '/Users/Umar/dept_manager.csv'
with (format CSV, HEADER);

COPY titles from '/Users/Umar/titles.csv'
with (format CSV, HEADER);

COPY salaries from '/Users/Umar/salaries.csv'
with (format CSV, HEADER);

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees e
inner join salaries s
  on e.emp_no = s.emp_no;

-- List employees who were hired in 1986
select e.emp_no, e.last_name, e.first_name
from employees e
inner join department_employees d
  on e.emp_no = d.emp_no
where from_date between '1986-01-01' and '1986-12-31';

-- List the manager of each department with the following information: department number, department name,
-- the manager's employee number, last name, first name, and start and end employment dates.

select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, de.from_date, dm.to_date
from departments d
inner join department_manager dm
  on d.dept_no = dm.dept_no
inner join employees e
  on dm.emp_no = e.emp_no
inner join department_employees de
  on e.emp_no = de.emp_no;


-- List the department of each employee with the following information: employee number, last name, first name, and department name.
select DISTINCT de.emp_no,
				e.last_name,
				e.first_name,
				d.dept_name,
				de.from_date
from department_employees de
inner join employees e
  on de.emp_no = e.emp_no
inner join departments d
  on de.dept_no = d.dept_no
order by e.last_name, e.first_name, de.from_date;

-- List all employees whose first name is Hercule and last names begin with B
select first_name, last_name
from employees
where (first_name = 'Hercules')
and (last_name like 'B%');

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE VIEW dept_employee_view AS
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
inner join department_employees de
  on e.emp_no = de.emp_no
inner join departments d
  on de.dept_no = d.dept_no;

select * from dept_employee_view
where dept_name = 'Sales'
order by last_name;

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select * from dept_employee_view
where dept_name in ('Sales', 'Development')
order by dept_name, last_name;

-- In descending order, list the frequency count of employee last names
select last_name, count(last_name) as ln_count
from employees
group by last_name
order by ln_count DESC;
