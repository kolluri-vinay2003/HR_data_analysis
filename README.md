# HR Data Analysis – SQL Project

This project focuses on building a simple HR database using MySQL and running key SQL queries to analyze employee, department, and project data.

## Tables Created

- **departments**: Stores department names and their manager IDs
- **employees**: Stores employee details such as name, hire date, job title, and department
- **projects**: Stores project details including start and end dates and department association

## Key Features

- Created tables with proper primary and foreign key relationships
- Inserted sample data for employees, departments, and projects
- Updated department managers using subqueries
- Wrote SQL queries to answer real-world business questions

## SQL Queries Included

1. **Longest project per department**  
   Finds the project with the highest duration in each department.

2. **Employees who are not managers**  
   Lists employees who are not assigned as department managers.

3. **Employees hired after a project started**  
   Shows employees who joined after the start of a project in their department.

4. **Rank employees by hire date**  
   Ranks employees within each department based on their hire date using the RANK() window function.

5. **Time difference between hires**  
   Uses the LEAD() function to calculate how many days passed between consecutive hires in the same department.

## Skills Demonstrated

- Data modeling and schema design
- Writing complex SQL queries with joins and subqueries
- Using window functions like RANK() and LEAD()
- Performing date-based calculations with DATEDIFF()

## How to Run

1. Open MySQL Workbench or any other SQL editor.
2. Run the `hr_data_analysis.sql` script file step by step.
3. Review the outputs for each query and analyze the results.

