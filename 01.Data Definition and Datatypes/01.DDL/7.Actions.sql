--19. Basic Select All fields
SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

--20. Basic Select All Fields and Order Them
SELECT * FROM Towns
ORDER BY Name
SELECT * FROM Departments
ORDER BY Name
SELECT * FROM Employees
ORDER BY Salary DESC

--21. Basic Select Some Fields
SELECT Name FROM Towns 
ORDER BY Name
SELECT Name FROM Departments 
ORDER BY Name
SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

--22. Increase Employees Salary
UPDATE Employees
SET Salary+=Salary*0.1
SELECT Salary FROM Employees

--23. Decrease Tax Rate Hotel Database
UPDATE Payments
SET TaxRate-=TaxRate*0.03
SELECT TaxRate FROM Payments

--24. Delete All Records From Hotel Database table Occupancies
TRUNCATE TABLE Occupancies