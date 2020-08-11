---------------------------- SQL HW: EMPLOYEE DATABASE ANALYSIS FOR PEWLETT HACKARD ---- ZAC CHEATLE 


-- drop tables to reset data if needed
drop table titles;
drop table employees;
drop table departments;
drop table salaries;
drop table dept_emp;
drop table dept_manager;


---------------------- CREATE TABLES

-- create titles table
create table titles (title_id varchar primary key, title varchar);

-- create employees table
create table employees (emp_no int primary key, emp_title varchar, foreign key (emp_title) references titles (title_id), birth_date date, 
						first_name text, last_name text, sex varchar, hire_date date);

-- create departments table
create table departments (dept_no varchar primary key, dept_name varchar);

-- create salaries table
create table salaries (emp_no int, foreign key (emp_no) references employees (emp_no), salary int);

-- create dept_emp junction table
create table dept_emp (emp_no integer not null, 
	foreign key (emp_no) references employees (emp_no), 
	dept_no varchar not null,
	foreign key (dept_no) references departments (dept_no),
	primary key (emp_no, dept_no));
	
-- create dept_manager table junction table
create table dept_manager (dept_no varchar, foreign key (dept_no) references departments (dept_no),
	emp_no int not null,
	foreign key (emp_no) references employees (emp_no),
	primary key (dept_no, emp_no));

---------------------- IMPORT DATA INTO TABLES (in the order they were created)
---- verify tables are accurate
select * from titles;
select * from employees;
select * from departments;
select * from salaries;
select * from dept_emp;
select * from dept_manager;



---------------------- DATA ANALYSIS

-- 1.) List the following details of each employee: 
------ employee number, last name, first name, sex, and salary.

select employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
from employees
inner join salaries
on employees.emp_no = salaries.emp_no
order by emp_no;

-- 2.) List first name, last name, and hire date for employees who were hired in 1986.

select first_name, last_name, hire_date
from employees 
where hire_date between '1986-01-01' and '1986-12-31'
order by hire_date;

-- 3.) List the manager of each department with the following information: 
------ department number, department name, the manager's employee number, last name, first name.

select departments.dept_no, departments.dept_name, 
		dept_manager.emp_no, employees.last_name, employees.first_name
from departments
inner join dept_manager
on departments.dept_no = dept_manager.dept_no
inner join employees
on dept_manager.emp_no = employees.emp_no
order by departments.dept_no;

-- 4.) List the department of each employee with the following information: 
------ employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
inner join dept_emp
on employees.emp_no = dept_emp.emp_no
inner join departments
on dept_emp.dept_no = departments.dept_no
order by employees.emp_no;

-- 5.) List first name, last name, and sex for employees whose: 
------ frist name is "Hercules" and last names begin with "B."

select last_name, first_name, sex 
from employees
where first_name = 'Hercules'
and last_name like 'B%';

-- 6.) List all employees in the Sales department: 
------ including their employee number, last name, first name, and department name. 

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
inner join dept_emp
on employees.emp_no = dept_emp.emp_no
inner join departments
on dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales'
order by employees.emp_no;


-- 7.) List all employees in the Sales and Development departments: 
------ including their employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
inner join dept_emp
on employees.emp_no = dept_emp.emp_no
inner join departments
on dept_emp.dept_no = departments.dept_no
where dept_name in ('Sales', 'Development')
order by departments.dept_name, employees.emp_no;


-- 8.) In descending order, list the frequency count of employee last names: 
------ i.e., how many employees share each last name.

select last_name, count(last_name) as "count of employees with last name" from employees
group by last_name
order by "count of employees with last name" desc;












