USE SoftUni
GO

SELECT * FROM Employees 

SELECT NAME FROM Departments

SELECT FirstName+'.'+LastName+'@softuni.bg' AS [Full Email Address] FROM Employees

SELECT DISTINCT Salary FROM Employees

SELECT * FROM Employees
WHERE JobTitle='Sales Representative'

SELECT FirstName,LastName,JobTitle FROM Employees
WHERE Salary<=30000 AND Salary>=20000

SELECT FirstName+' '+MiddleName+' '+LastName AS [Full Name] FROM Employees
WHERE Salary=25000 OR Salary=14000 OR Salary=12500 OR Salary=23600

SELECT FirstName,LastName FROM Employees
WHERE ManagerID IS NULL

SELECT FirstName,LastName, Salary FROM Employees
WHERE Salary>50000
ORDER BY Salary DESC

SELECT TOP (5) FirstName,LastName FROM Employees
ORDER BY Salary DESC

SELECT FirstName,LastName FROM Employees
WHERE DepartmentID!=4

SELECT * FROM Employees
ORDER BY Salary DESC, FirstName, LastName DESC,MiddleName

CREATE VIEW v_EmployeesSalaries AS
SELECT FirstName,LastName,Salary FROM Employees

CREATE VIEW V_EmployeeNameJobTitle AS
SELECT FirstName+' '+MiddleName+' '+LastName AS [Full Name], JobTitle FROM Employees
WHEN MiddleName IS NULL 

SELECT DISTINCT JOBTITLE FROM Employees

SELECT TOP (10) * FROM Projects
ORDER BY StartDate,Name

SELECT TOP(7) FirstName,LastName,HireDate FROM Employees
ORDER BY HireDate DESC

UPDATE Employees
SET SALARY=SALARY*1.12
WHERE JobTitle='Engineering' OR JobTitle='Marketing' 
OR JobTitle='Information Services' OR JobTitle='Tool Design'

USE Geography
GO
SELECT TOP (30) CountryName,Population FROM Countries
WHERE ContinentCode='EU'
ORDER BY Population DESC,CountryName

USE Diablo
GO
SELECT Name FROM Characters
ORDER BY NAME

