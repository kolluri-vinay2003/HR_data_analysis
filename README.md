# HR Data Analysis with SQL

This project involves designing a relational database for an HR department and performing insightful SQL queries to analyze hiring trends, project durations, and employee roles.

## 📊 Project Overview

The HR Data Analysis project was developed using **MySQL** and includes:

- Database and schema creation
- Data insertion for departments, employees, and projects
- Business queries using **joins**, **window functions**, **ranking**, and **date calculations**
- Use of advanced SQL features like `RANK()`, `LEAD()`, and subqueries

This project demonstrates strong command over **data modeling**, **relational joins**, and **analytics-driven query writing**.

---

## 🗂️ Database Schema

```text
+----------------+          +----------------+          +----------------+
|  departments   |          |   employees    |          |    projects    |
+----------------+          +----------------+          +----------------+
| id (PK)        |<-------+ | id (PK)        |          | id (PK)        |
| name           |        | | name           |          | name           |
| manager_id (FK)|        +-| hire_date      |          | start_date     |
                        |   | job_title      |          | end_date       |
                        +---| department_id (FK) |       | department_id (FK) |
                            +----------------+          +----------------+
