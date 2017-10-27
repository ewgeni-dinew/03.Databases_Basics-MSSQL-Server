USE ReportService
GO

--05.Users by Age
SELECT Username,Age FROM Users
ORDER BY AGE, Username DESC

--06.Unassigned Reports
SELECT Description,OpenDate FROM Reports
WHERE EmployeeId IS NULL
ORDER BY OpenDate,Description

--07.Employees & Reports
SELECT FirstName,LastName,Description,FORMAT(OpenDate,'yyyy-MM-dd') FROM Reports
JOIN Employees AS E ON E.Id=Reports.EmployeeId
WHERE EmployeeId IS NOT NULL
ORDER BY EmployeeId,OpenDate,Reports.Id

--08.Most Reported Category
SELECT Name,COUNT(R.Id) AS [ReportsNumber] FROM Categories AS C
JOIN Reports AS R ON R.CategoryId=C.Id
GROUP BY Name
ORDER BY ReportsNumber DESC,Name

--09.Employees in Category
SELECT C.Name,COUNT(E.Id) AS [Employees Number] FROM Categories AS C
JOIN Departments AS D ON D.Id=C.DepartmentId
JOIN Employees AS E ON D.Id=E.DepartmentId
GROUP BY C.Name
ORDER BY C.Name

--10.Users per Employee
SELECT
FirstName+' '+LastName AS [EmployeeName],
COUNT(R.UserId) AS [Users Number]
FROM Reports AS R
RIGHT JOIN Employees AS E ON E.Id=R.EmployeeId
GROUP BY FirstName+' '+LastName
ORDER BY [Users Number]DESC,[EmployeeName]

--11.Emergency Patrol
SELECT OpenDate,Description,Email FROM Reports AS R
JOIN Categories AS C ON C.Id=R.CategoryId
JOIN Departments AS D ON D.Id=C.DepartmentId
JOIN Users AS U ON U.Id=R.UserId
WHERE CloseDate IS NULL
AND DATALENGTH(Description)>20
AND Description LIKE ('%str%')
AND D.Name IN ('Infrastructure','Emergency', 'Roads Maintenance')
ORDER BY OpenDate,Email,R.Id

--12.Birthday Report
SELECT C.Name FROM Reports AS R
JOIN Categories AS C ON C.Id=R.CategoryId
JOIN Users AS U ON U.Id=R.UserId
WHERE DATEPART(MONTH,BirthDate)=DATEPART(MONTH,OpenDate)
AND DATEPART(DAY,BirthDate)=DATEPART(DAY,OpenDate)
GROUP BY C.Name
ORDER BY C.Name

