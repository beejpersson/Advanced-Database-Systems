--Question 4a.
--Find employees with 'on' in first name who live in glasgow (3 marks)

SELECT e.pName.firstName, e.pName.surName FROM employeeTable e WHERE e.pAddress.city = 'Glasgow' AND e.pName.firstName LIKE '$on$';