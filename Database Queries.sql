--Question 4a.
--Find employees with 'on' in first name who live in glasgow (3 marks)

SELECT e.pName.firstName AS "First Name", e.pName.surName AS "Last Name" FROM employeeTable e WHERE e.pAddress.city = 'Glasgow' AND e.pName.firstName LIKE '%on%';

--Question 4b.
--Find the number of savings account at each branch (3 marks)

SELECT count(a.accType) AS "Number of Savings Accounts", a.bID.bAddress.street AS "Branch Street", a.bID.bAddress.city AS "Branch City", a.bID.bAddress.p_code AS "Branch Post Code" FROM accountTable a WHERE a.accType = 'savings' GROUP BY a.bID;