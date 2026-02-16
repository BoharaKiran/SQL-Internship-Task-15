use intern_training_db;

#Extend the employees table by adding salary, joining date, and department information
ALTER TABLE employees11
ADD COLUMN joining_date DATE;

desc employees11;
INSERT INTO employees11 (emp_id, name, salary, department, joining_date)
VALUES
(7,'Shiya',30000,'IT','2022-01-10'),
(8,'Mona',60000,'HR','2021-03-15'),
(9,'Raj',70000,'IT','2022-07-11'),
(10,'Het',50000,'HR','2022-03-23'),
(11,'Pream',75000,'sales','2021-09-10'),
(12,'Mitu',65000,'sales','2022-07-19');

SELECT * FROM employees11;

#Use ROW_NUMBER() to assign unique ranks within each department
SELECT name, department, salary,
ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS row_num
FROM employees11;

#RANK() and DENSE_RANK() to understand ranking differences
SELECT name, department, salary,

RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_num,

DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dense_rank_num

FROM employees11;

#running totals using SUM() OVEROVER(PARTITION BY ...)
SELECT name, department, salary,

SUM(salary) OVER(
PARTITION BY department
ORDER BY salary
) AS running_total

FROM employees11;

#Use LAG() and LEAD() to compare salaries between consecutive employees
SELECT name, department, salary,

LAG(salary) OVER(
PARTITION BY department
ORDER BY salary
) AS previous_salary

FROM employees11;

SELECT name, department, salary,

LEAD(salary) OVER(
PARTITION BY department
ORDER BY salary
) AS next_salary

FROM employees11;

#window functions without collapsing rows unlike GROUP BY
SELECT department, SUM(salary)
FROM employees11
GROUP BY department;

#WHERE clauses with window functions using subqueries
SELECT *
FROM (
    SELECT name, department, salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS rn
    FROM employees11
) t
WHERE rn = 1;

#Map analytics use cases like salary trends and performance analysis
SELECT name, salary,
RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM employees11;

DESC employees11;

