USE SoftUni
GO

--06.Employees by Salary Level
CREATE PROCEDURE usp_EmployeesBySalaryLevel(@SALARYLEVEL VARCHAR(50))
AS
SELECT FirstName,LastName FROM Employees
WHERE dbo.ufn_GetSalaryLevel(Salary)=@SALARYLEVEL
GO

--07.Define Function
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(max), @word VARCHAR(max))
RETURNS BIT
AS
BEGIN
  DECLARE @isComprised BIT = 0;
  DECLARE @currentIndex INT = 1;
  DECLARE @currentChar CHAR;

  WHILE(@currentIndex <= LEN(@word))
  BEGIN

    SET @currentChar = SUBSTRING(@word, @currentIndex, 1);
    IF(CHARINDEX(@currentChar, @setOfLetters) = 0)
      RETURN @isComprised;
    SET @currentIndex += 1;

  END
  RETURN @isComprised + 1;
END

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