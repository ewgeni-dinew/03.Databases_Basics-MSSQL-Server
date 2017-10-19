USE SoftUni
GO

--08.Employees with Three Projects
CREATE PROCEDURE usp_AssignProject(@EmployeeID INT,@ProjectID INT)
AS
BEGIN
	DECLARE @MaxEmployeeProjectsCount INT = 3;
	DECLARE @EmployeeProjectsCount INT;

	BEGIN TRANSACTION
	INSERT INTO EmployeesProjects VALUES
	(@EmployeeID,@ProjectID)

	SET @EmployeeProjectsCount=(
	SELECT COUNT(*) FROM EmployeesProjects
	WHERE @EmployeeID=EmployeeID)

	IF(@EmployeeProjectsCount>@MaxEmployeeProjectsCount)
		BEGIN
			RAISERROR('The employee has too many projects!', 16, 1);
			ROLLBACK
		END

	ELSE COMMIT
END

--09.Deleted Employees
CREATE TABLE Deleted_Employees(
EmployeeId INT PRIMARY KEY NOT NULL,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
MiddleName VARCHAR (50) NOT NULL,
JobTitle VARCHAR(25) NOT NULL,
DepartmentId INT NOT NULL,
Salary MONEY NOT NULL)
GO

CREATE TRIGGER tr_DeletedEmployees ON Employees AFTER DELETE
AS 
BEGIN
	DECLARE @FirstName VARCHAR(50)=(SELECT FirstName FROM deleted)
	DECLARE @LastName VARCHAR(50)=(SELECT LastName FROM deleted)
	DECLARE @MiddleName VARCHAR(50)=(SELECT MiddleName FROM deleted)
	DECLARE @JobTitle VARCHAR(50)=(SELECT JobTitle FROM deleted)
	DECLARE @DepartmentId INT=(SELECT DepartmentID FROM deleted)
	DECLARE @Salary MONEY=(SELECT Salary FROM deleted)

	INSERT INTO Deleted_Employees(FirstName,LastName,MiddleName,JobTitle,DepartmentId,Salary)
	VALUES
	(@FirstName,@LastName,@MiddleName,@JobTitle,@DepartmentId,@Salary)
END