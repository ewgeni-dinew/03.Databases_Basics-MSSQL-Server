USE ReportService
GO
--17.Employee’s Load
CREATE FUNCTION udf_GetReportsCount(@employeeId INT, @statusId INT)
RETURNS INT
AS
BEGIN
	DECLARE @Result INT=
	(SELECT COUNT(*) FROM Reports
	 WHERE EmployeeId=@employeeId AND StatusId=@statusId)

	 RETURN @Result
END
