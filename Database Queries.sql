--Question 4a. 
--Find employees with 'on' in first name who live in glasgow (3 marks)

SELECT
    e.pName.firstName AS "First Name",
    e.pName.surName AS "Last Name" 
FROM
    employeeTable e 
WHERE
    e.pAddress.city = 'Glasgow'
    AND e.pName.firstName LIKE '%on%';

--Question 4b.
--Find the number of savings account at each branch (3 marks)

SELECT 
    COUNT(a.accType) AS "Number of Savings Accounts",
    a.bID.bAddress.street AS "Branch Street",
    a.bID.bAddress.city AS "Branch City",
    a.bID.bAddress.p_code AS "Branch Post Code"
FROM
    accountTable a
WHERE
    a.accType = 'savings'
    GROUP BY a.bID;

--Question 4g.
--Find the number of eployees who are supervised by Mr William, who is supervised by Mrs Smith 
SELECT
    CONCAT(CONCAT(e.pName.title, ' '), e.pName.surName) AS "Supervisor Name",
    (SELECT COUNT(e.supervisorID) FROM employeeTable e WHERE e.supervisorID.empID = 301) AS "Number of Employees Supervised",
    (SELECT CONCAT(CONCAT(e.supervisorID.pName.title, ' '), e.supervisorID.pName.surName) FROM employeeTable e WHERE e.supervisorID.empID = 309) AS "Supervisor's Supervisor"
FROM
    employeeTable e
WHERE
    e.empID = 301;
--Double concat used to join first names and last names under one column, with a space between the names.
--Count retrived from nested SELECT
--Mr William's supervisor's name retrived using nested SELECT with 