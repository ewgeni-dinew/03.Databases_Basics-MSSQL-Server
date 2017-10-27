USE ReportService
GO

--13.Numbers Coincidence
SELECT DISTINCT Username FROM Users AS U
JOIN Reports AS R ON R.UserId=U.Id
WHERE (Username  LIKE '[0-9]%' AND TRY_CONVERT(int,LEFT(Username,1))=R.CategoryId)
OR (Username LIKE '%[0-9]' AND TRY_CONVERT(INT,RIGHT(Username,1))=R.CategoryId)
ORDER BY Username

--14.Open/Closed Statistics
SELECT [EmpName],
        CONCAT(Closed, '/', Opened) AS [Closed Open Reports]
  FROM (SELECT 
		CONCAT(e.FirstName, ' ' ,e.LastName) AS [EmpName],
		e.Id AS EmpId,
		COUNT(r.CloseDate) AS Closed,
		COUNT(r.OpenDate) AS Opened
		FROM Employees AS e
		INNER JOIN Reports AS r
		ON r.EmployeeId = e.Id
		WHERE DATEPART(year, r.OpenDate) = 2016
		OR DATEPART(year, r.CloseDate) = 2016
		GROUP BY CONCAT(e.FirstName, ' ', e.LastName), e.Id) AS epcount
INNER JOIN Employees AS e ON e.Id = epcount.EmpId
ORDER BY [EmpName], e.Id

--15.Average Closing Time
SELECT	d.[Name] AS [Department Name], 
	ISNULL(CONVERT(VARCHAR(10), AVG(DATEDIFF(DAY, r.OpenDate, r.CloseDate))), 'no info') AS [Average Duration]
FROM Departments AS d
INNER JOIN Categories AS c ON c.DepartmentId = d.Id
INNER JOIN Reports AS r ON r.CategoryId = c.Id
GROUP BY d.[Name]
ORDER BY d.[Name]

--16.Favorite Categories
WITH CTE_ReportsByDepartment
AS
(SELECT d.[Name] AS DeptName, c.[Name] AS CatName, COUNT(c.[Name]) as [CountReports]
FROM Departments AS d
INNER JOIN Categories AS c ON c.DepartmentId = d.Id
INNER JOIN Reports AS r ON r.CategoryId = c.Id
GROUP BY d.[Name] , c.[Name])

SELECT	d.[Name] AS [Department Name], 
	c.[Name] AS [Category Name], 
	ROUND((CAST(COUNT(c.[Name]) AS FLOAT) / CAST((SELECT SUM([CountReports]) FROM CTE_ReportsByDepartment WHERE DeptName = d.[Name]) AS FLOAT)) * 100, 0) AS [Percentage]
FROM Departments AS d
INNER JOIN Categories AS c ON c.DepartmentId = d.Id
INNER JOIN Reports AS r ON r.CategoryId = c.Id
GROUP BY d.[Name], c.[Name]
ORDER BY d.[Name], c.[Name], [Percentage]


