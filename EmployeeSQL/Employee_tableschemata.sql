-- Create tables 

CREATE TABLE departments (
    "dept_no" VARCHAR(10) PRIMARY KEY NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL
);

CREATE TABLE employees (
    "emp_no" int  PRIMARY KEY  NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" date   NOT NULL
);

CREATE TABLE department_employees (
    "emp_no" VARCHAR(10) NOT NULL,
    "dept_no" VARCHAR(10) NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE department_manager (
    "dept_no" VARCHAR(10)  NOT NULL,
    "emp_no" int  NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE salaries (
    "emp_no" int  NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE titles (
    "emp_no" int,
    "title" VARCHAR(30)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
