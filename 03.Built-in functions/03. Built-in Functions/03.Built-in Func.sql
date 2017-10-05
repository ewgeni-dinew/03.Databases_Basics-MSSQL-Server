USE SoftUni
GO

--01.Find Names of All Employees by First Name
SELECT FirstName,LastName FROM Employees
WHERE LEFT(FirstName,2)='SA'

--02.Find Names of All Employees by Last Name
SELECT FirstName,LastName FROM Employees
WHERE LastName LIKE ('%ei%')

--03.Find First Names of All Employess
SELECT FirstName FROM Employees
WHERE DepartmentID=3 OR DepartmentID=10
AND DATEPART(YEAR,HireDate)>1995 AND
DATEPART(YEAR,HireDate)<2005

--04.Find All Employees Except Engineers
SELECT FirstName,LastName FROM Employees
WHERE JobTitle NOT LIKE ('%engineer%')

--05.Find Towns with Name Length
SELECT Name FROM Towns
WHERE DATALENGTH(Name)=5 OR DATALENGTH(NAME)=6
ORDER BY NAME

--06.Find Towns Starting With
SELECT * FROM Towns
WHERE Name LIKE('M%') OR
Name LIKE('K%') OR
Name LIKE('B%') OR
Name LIKE('E%')
ORDER BY Name

--07.Find Towns Not Starting With
SELECT * FROM Towns
WHERE Name NOT LIKE('R%') AND
Name NOT LIKE('B%') AND
Name NOT LIKE('D%')
ORDER BY Name

--08.Create View Employees Hired After
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
WHERE DATEPART(YEAR,HireDate)>2000

--09.Length of Last Name
SELECT FirstName,LastName FROM Employees
WHERE DATALENGTH(LastName)=5

USE Geography
GO
--10.Countries Holding 'A'
SELECT CountryName, IsoCode FROM Countries
WHERE CountryName LIKE ('%A%A%A%')
ORDER BY IsoCode

--11.Mix of Peak and River Names
SELECT PeakName,RiverName, LOWER(LEFT(PeakName,LEN(PEAKNAME)-1)+RiverName)AS [Mix] FROM Peaks, Rivers
WHERE RIGHT(PeakName,1)=LEFT(RiverName,1)
ORDER BY Mix

USE Diablo
GO

--12.Games From 2011 and 2012 Year
SELECT TOP(50) Name,FORMAT(Start,'yyyy-MM-dd')AS[Start] FROM GAMES
WHERE DATEPART(YEAR,Start)=2011
OR DATEPART(YEAR,Start)=2012
ORDER BY Start,Name

--13.User Email Providers
SELECT Username,RIGHT(Email,LEN(EMAIL)-CHARINDEX('@',Email))AS [Email Provider] FROM USERS
ORDER BY [Email Provider],Username

--14.Get Users with IPAddress Like Pattern
SELECT Username,IpAddress FROM Users
WHERE IpAddress LIKE('___.1%.%.___')
ORDER BY Username

--15.Show All Games with Duration
SELECT G.Name AS Game,
CASE 
WHEN DATEPART(HOUR,G.Start) BETWEEN 0 AND 11 THEN 'Morning'
WHEN DATEPART(HOUR,G.Start) BETWEEN 12 AND 17 THEN 'Afternoon'
WHEN DATEPART(HOUR,G.Start) BETWEEN 18 AND 23 THEN 'Evening'
END AS [Part of the Day],
CASE
WHEN G.Duration <=3 THEN 'Extra Short'
WHEN G.Duration BETWEEN 4 AND 6 THEN 'Short'
WHEN G.Duration >6 THEN 'Long'
ELSE 'Extra Long'
END AS [Duration]
FROM Games AS G
ORDER BY G.Name,
[Duration],
[Part of the Day]

USE Orders
GO
--16.Orders Table
SELECT ProductName,OrderDate, 
DATEADD(DAY,3,OrderDate) AS [Pay Due],
DATEADD(MONTH,1,OrderDate) AS [Deliver Due]
FROM Orders
