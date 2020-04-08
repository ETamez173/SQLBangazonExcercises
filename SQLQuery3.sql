--List each employee first name, last name and supervisor status along with their department name.
--Order by department name, then by employee last name, and finally by employee first name.

SELECT FirstName, LastName,  e.IsSupervisor,  d.[Name] AS DepartmentName, e.departmentId
FROM Employee e
LEFT JOIN Department d ON e.DepartmentId = d.id
ORDER BY DepartmentName, e.LastName, e.FirstName


----List each department ordered by budget amount with the highest first.


SELECT * FROM Department
ORDER BY Budget DESC


----List each department name along with any employees (full name) in that department who are supervisors.

SELECT d.[Name] AS DepartmentName, FirstName, LastName,  e.IsSupervisor, e.departmentId
FROM Employee e
LEFT JOIN Department d ON e.DepartmentId = d.id
WHERE e.IsSupervisor = 1



----List each department name along with a count of employees in each department.

SELECT d.[Name] AS DepartmentName, COUNT(e.DepartmentId) as EmployeeCount 
FROM Employee e
LEFT JOIN Department d ON e.DepartmentId = d.id
GROUP BY d.[Name] 


----Write a single update statement to increase each department's budget by 20%.

SELECT * FROM Department
UPDATE Department
SET Budget = (Budget * 1.2)



---- 6 List the employee full names for employees who are not signed up for any training programs.


SELECT e.FirstName, e.LastNAme, et.EmployeeId, et.TrainingProgramId, t.[Name]
FROM EMPLOYEE e
LEFT JOIN EmployeeTraining et ON e.Id = et.EmployeeId
LEFT JOIN TrainingProgram t ON et.TrainingProgramId = t.Id
WHERE et.TrainingProgramId is NULL


----7 List the employee full names for employees who are signed up for at least one training program and
----include the number of training programs they are signed up for.

SELECT e.FirstName, e.LastNAme, COUNT(et.TrainingProgramId) as TrainingCount
FROM EMPLOYEE e
LEFT JOIN EmployeeTraining et ON e.Id = et.EmployeeId
LEFT JOIN TrainingProgram t ON et.TrainingProgramId = t.Id
WHERE et.TrainingProgramId is NOT NULL
GROUP BY e.FirstName, e.LastNAme

----8 List all training programs along with the count employees who have signed up for each.

SELECT t.[Name], COUNT(et.EmployeeId) as AttendeeCount
FROM TrainingProgram t
LEFT JOIN EmployeeTraining et ON t.Id = et.TrainingProgramId
GROUP BY t.[Name]


----9 List all training programs who have no more seats available.
SELECT t.[Name], t.MaxAttendees, COUNT(et.EmployeeId) as AttendeeCount
FROM TrainingProgram t
LEFT JOIN EmployeeTraining et ON t.Id = et.TrainingProgramId
GROUP BY t.[Name], t.MaxAttendees
HAVING COUNT(et.EmployeeId) < t.MaxAttendees

----10 List all future training programs ordered by start date with the earliest date first.

SELECT t.[Name], t.StartDate
FROM TrainingProgram t
ORDER BY t.StartDate ASC

----11 Assign a few employees to training programs of your choice.

INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId)
OUTPUT INSERTED.Id
Values (3,12)

----12 List the top 3 most popular training programs. (For this question, consider each record in the training 
----program table to be a UNIQUE training program).

SELECT TOP 3 t.[Name], t.[Id], COUNT(et.EmployeeId) as AttendeeCount
FROM TrainingProgram t
LEFT JOIN EmployeeTraining et ON t.Id = et.TrainingProgramId
GROUP BY t.[Id], t.[Name]
ORDER BY AttendeeCount DESC


----13List the top 3 most popular training programs. (For this question consider training programs with the same 
----name to be the SAME training program).

SELECT TOP 3 t.[Name], COUNT(et.EmployeeId) as AttendeeCount
FROM TrainingProgram t
LEFT JOIN EmployeeTraining et ON t.Id = et.TrainingProgramId
GROUP BY t.[Name]
ORDER BY AttendeeCount DESC


----14 List all employees who do not have computers.

SELECT e.FirstName, e.LastName, ce.ComputerId
FROM Employee e
LEFT JOIN ComputerEmployee ce ON ce.EmployeeId = e.Id
WHERE ce.ComputerId IS NULL


----15 List all employees along with their current computer information make and manufacturer combined into a field 
----entitled ComputerInfo. If they do not have a computer, this field should say "N/A".
SELECT e.FirstName, e.LastName, ce.ComputerId, COALESCE(c.Manufacturer + '  ' + c.Make, 'NO PC FOR YOU! HA! HA!') as ComputerInfo
FROM Employee e
LEFT JOIN ComputerEmployee ce ON ce.EmployeeId = e.Id
LEFT JOIN Computer c ON ce.ComputerId = c.Id



----16 List all computers that were purchased before July 2019 that are have not been decommissioned.

SELECT Manufacturer, Make, PurchaseDate, DecomissionDate
FROM Computer
Where PurchaseDate < '20190701'
AND DecomissionDate IS NULL


----17 List all employees along with the total number of computers they have ever had.

SELECT e.FirstName, e.LastName,  c.Make, c.Manufacturer, c.PurchaseDate, c.DecomissionDate
FROM Employee e
LEFT JOIN ComputerEmployee ce ON ce.EmployeeId = e.Id
LEFT JOIN Computer c ON ce.ComputerId = c.Id
GROUP BY e.FirstName, e.LastName, c.Make, c.Manufacturer, c.PurchaseDate, c.DecomissionDate
HAVING c.Make IS NOT NULL

---- grab those employees with Surface Pro
HAVING c.Make = 'Surface Pro'

----18 List the number of customers using each payment type




----19 List the 10 most expensive products and the names of the seller




----20 List the 10 most purchased products and the names of the seller


----21 Find the name of the customer who has made the most purchases


----22 List the amount of total sales by product type


----23 List the total amount made from all sellers