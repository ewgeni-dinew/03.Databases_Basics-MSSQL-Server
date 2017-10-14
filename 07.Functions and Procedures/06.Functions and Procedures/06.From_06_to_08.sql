USE SoftUni
GO

--06.Employees by Salary Level
CREATE PROCEDURE usp_EmployeesBySalaryLevel(@SALARYLEVEL VARCHAR(50))
AS
SELECT FirstName,LastName FROM Employees
WHERE dbo.ufn_GetSalaryLevel(Salary)=@SALARYLEVEL
GO

--07.Define Function
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50),@word VARCHAR(50))
RETURNS BIT
BEGIN
	DECLARE @RESULT BIT
		WHILE
		BEGIN
		END
	RETURN @RESULT
END
GO

--08.Delete Employees and Departments
CREATE PROCEDURE usp_DeleteEmployeesFromDepartment(@departmentId INT)
AS
ALTER TABLE Departments
ALTER COLUMN ManagerID INT NULL

DELETE FROM EmployeesProjects
WHERE EmployeeID IN(
	SELECT EmployeeID FROM Employees
	WHERE DepartmentID=@departmentId
)

UPDATE Employees
SET ManagerID = NULL
WHERE ManagerID IN (
	SELECT EmployeeID FROM Employees
	WHERE DepartmentID = @departmentId
)

UPDATE Departments
SET ManagerID = NULL
WHERE ManagerID IN (
	SELECT EmployeeID FROM Employees
	WHERE DepartmentID = @departmentId
)

DELETE FROM Employees
WHERE DepartmentID=@departmentId

DELETE FROM Departments
WHERE DepartmentID=@departmentId

SELECT COUNT(*) FROM Employees AS E
JOIN Departments AS D ON D.DepartmentID=E.EmployeeID
WHERE E.DepartmentID=@departmentId