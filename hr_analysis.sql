DROP DATABASE IF EXISTS hr_data_db;
CREATE DATABASE hr_data_db;
USE hr_data_db;

DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS projects;

-- create department table
CREATE TABLE departments(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
manager_id INT
);


-- create employee table
CREATE TABLE employees(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
hire_date DATE,
job_title VARCHAR(50),
department_id INT,
CONSTRAINT employee_department_fk FOREIGN KEY (department_id) REFERENCES departments(id));


-- create projects table

CREATE TABLE projects(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
start_date DATE,
end_date DATE,
department_id INT,
CONSTRAINT project_department_fk FOREIGN KEY(department_id) REFERENCES departments(id)
);

SHOW TABLES;

-- Insert data into 'departments'
INSERT INTO departments (name, manager_id) VALUES 
('HR', 1),
('IT', 2),
('Sales', 3);

-- Insert data into 'employees' 
INSERT INTO employees (name, hire_date, job_title, department_id) VALUES 
('Ravi Kumar', '2018-06-20', 'HR Manager', 1),
('Swapna Reddy', '2019-07-15', 'IT Manager', 2),
('Suresh Babu', '2020-01-10', 'Sales Manager', 3),
('Kavya Lakshmi', '2021-04-30', 'HR Associate', 1),
('Anil Kumar', '2022-10-01', 'IT Associate', 2),
('Meghana Rao', '2023-03-15', 'Sales Associate', 3);

-- Insert data into 'projects'
INSERT INTO projects (name, start_date, end_date, department_id) VALUES 
('HR Project 1', '2023-01-01', '2023-06-30', 1),
('IT Project 1', '2023-02-01', '2023-07-31', 2),
('Sales Project 1', '2023-03-01', '2023-08-31', 3);

-- Update manager_id in departments
UPDATE departments 
SET manager_id = (SELECT id FROM employees WHERE name = 'Ravi Kumar') 
WHERE id=1;

UPDATE departments 
SET manager_id = (SELECT id FROM employees WHERE name = 'Swapna Reddy') 
WHERE id=2;

UPDATE departments 
SET manager_id = (SELECT id FROM employees WHERE name = 'Suresh Babu') 
WHERE id=3;

--  1. Longest ongoing project duration for each department
SELECT d.name AS department_name,p.name AS project_name,
DATEDIFF(p.end_date,p.start_date) AS duration_days
FROM projects p JOIN departments d ON p.department_id=d.id
WHERE DATEDIFF(p.end_date,p.start_date)=(SELECT MAX(
DATEDIFF(p2.end_date,p2.start_date)) FROM projects P2  WHERE p2.department_id=p.department_id);

-- 2. Find all employees who are not managers
SELECT e.name AS employee_name,e.job_title AS job_title FROM employees e 
LEFT JOIN departments d ON e.id=d.manager_id WHERE d.manager_id IS NULL;

-- 3. Find employees hired after the start of a project in their department
SELECT DISTINCT e.name AS employee_name,e.hire_date,p.name AS project_name,p.start_date
FROM employees e JOIN projects p ON e.department_id=p.department_id
WHERE e.hire_date>p.start_date;

-- 4. Rank employees within each department based on their hire date
SELECT*FROM(
SELECT e.name AS employee_name,d.name AS department_name,e.hire_date,
RANK() OVER(PARTITION BY d.id ORDER BY hire_date ASC) AS rnk
FROM employees e JOIN departments d ON e.department_id=d.id) AS ranked;

-- 5. Duration between each employee’s hire date and the next in the same department
SELECT 
e.id AS employee_id,e.name AS employee_name,d.name AS department_name,hire_date AS hire_date,
LEAD(e.hire_date) OVER(PARTITION BY d.name ORDER BY e.hire_date) AS next_hire_date,
DATEDIFF(LEAD(e.hire_date) OVER(PARTITION BY d.name ORDER BY e.hire_date),e.hire_date) AS duration_days,
TIMESTAMPDIFF(MONTH,e.hire_date,LEAD(e.hire_date) OVER(PARTITION BY d.name ORDER BY e.hire_date)) AS duration_months,
round(timestampdiff(month,e.hire_date,lead(e.hire_date) OVER(partition by d.name order by e.hire_date))/12,2) as duration_years
FROM employees e JOIN departments d 
ON e.department_id=d.id 
ORDER BY d.name,e.hire_date ;

