USE ReportService
GO
--18.Assign Employee
CREATE PROCEDURE usp_AssignEmployeeToReport(@employeeId INT, @reportId INT)
AS
BEGIN
BEGIN TRANSACTION
	 DECLARE @employeeDep INT=
	 (SELECT DepartmentId FROM Employees
	 WHERE Id=@employeeId) 

	 DECLARE @reportCat INT=
	 (SELECT DepartmentId FROM Categories
	 JOIN Reports AS R ON R.CategoryId=Categories.ID
	 WHERE @reportId=R.Id)

	 IF(@reportCat!=@employeeDep)
		BEGIN
			ROLLBACK
			RAISERROR('Employee doesn''t belong to the appropriate department!', 16, 1)		
		END
	 ELSE
		INSERT INTO Reports(Id,EmployeeId) VALUES
		(@reportId,@employeeId)
		COMMIT
END