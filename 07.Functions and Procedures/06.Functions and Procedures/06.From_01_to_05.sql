USE SoftUni
GO
--01.Employees with Salary Above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
SELECT FirstName,LastName FROM Employees
WHERE Salary>35000
GO

--02.Employees with Salary Above Number
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@SALARY DECIMAL(18,4))
AS
SELECT FirstName,LastName FROM Employees
WHERE Salary>=@SALARY
GO

--03.Town Names Starting With
CREATE PROCEDURE usp_GetTownsStartingWith (@INPUT VARCHAR(50))
AS
SELECT Name FROM Towns
WHERE Name LIKE CONCAT(@INPUT,'%')
GO

--04.Employees from Town
CREATE PROCEDURE usp_GetEmployeesFromTown(@TOWNNAME VARCHAR(50))
AS
SELECT FirstName,LastName FROM Employees AS E
JOIN Addresses AS A ON E.AddressID=A.AddressID
JOIN Towns AS T ON A.TownID=T.TownID
WHERE T.Name=@TOWNNAME
GO

--05.Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel(@SALARY DECIMAL(18,4))
RETURNS VARCHAR(50)
BEGIN
	DECLARE @SALARYLEVEL VARCHAR(50)
	IF(@SALARY<30000) SET @SALARYLEVEL='Low'
	ELSE IF(@SALARY BETWEEN 30000 AND 50000) SET @SALARYLEVEL='Average'
	ELSE SET @SALARYLEVEL='High'
	RETURN @SALARYLEVEL
END
GO
