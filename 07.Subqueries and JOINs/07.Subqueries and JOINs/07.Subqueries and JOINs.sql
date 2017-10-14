USE SoftUni
--01.Employee Address
SELECT TOP 5
EmployeeID,JobTitle,e.AddressID,a.AddressText
FROM Employees AS e
JOIN Addresses AS a ON e.AddressID=a.AddressID
ORDER BY AddressID

--02.Addresses with Towns
SELECT TOP 50
FirstName,LastName,t.Name,AddressText FROM Employees AS e
JOIN Addresses AS a ON a.AddressID=e.AddressID
JOIN Towns AS t ON t.TownID=a.TownID
ORDER BY FirstName,LastName

--03.Sales Employees
SELECT EmployeeID,FirstName,LastName,d.Name
FROM Employees AS e
JOIN Departments AS d ON D.DepartmentID=E.DepartmentID
WHERE d.Name='Sales'
ORDER BY EmployeeID

--04.Employee Departments
SELECT TOP 5
EmployeeID,FirstName,Salary,D.Name
FROM Employees AS E
JOIN Departments AS D ON D.DepartmentID=E.DepartmentID
WHERE Salary>15000
ORDER BY D.DepartmentID

--05.Employees Without Projects
SELECT TOP 3
E.EmployeeID,FirstName FROM Employees AS E
LEFT JOIN EmployeesProjects AS P ON P.EmployeeID=E.EmployeeID
WHERE P.EmployeeID IS NULL
ORDER BY E.EmployeeID

--06.Employees Hired After
SELECT FirstName,LastName,HireDate,D.Name FROM Employees AS E
JOIN Departments AS D ON D.DepartmentID=E.DepartmentID
WHERE E.HireDate>'01/01/1999'
AND D.Name IN ('Sales','Finance')
ORDER BY E.HireDate

--07.Employees With Project
SELECT TOP 5 
E.EmployeeID,FirstName,P.Name
FROM Employees AS E
JOIN EmployeesProjects AS EP ON EP.EmployeeID=E.EmployeeID
JOIN Projects AS P ON P.ProjectID=EP.ProjectID
WHERE P.StartDate>'2002/08/13'
AND P.EndDate IS NULL
ORDER BY E.EmployeeID

--08.Employee 24
SELECT E.EmployeeID,FirstName,
CASE WHEN P.StartDate>='2005/01/01' THEN NULL
ELSE P.Name
END 
FROM Employees AS E
JOIN EmployeesProjects AS EP ON EP.EmployeeID=E.EmployeeID
JOIN Projects AS P ON P.ProjectID=EP.ProjectID
WHERE E.EmployeeID=24

--09.Employee Manager
SELECT E.EmployeeID,E.FirstName,E.ManagerID,E1.FirstName AS ManagerName
FROM Employees AS E
JOIN Employees AS E1 ON E1.EmployeeID=E.ManagerID
WHERE E.ManagerID IN ('3','7')
ORDER BY EmployeeID

--10.Employees Summary
SELECT TOP 50
E.EmployeeID,
E.FirstName+' '+E.LastName AS [EmployeeName],
E1.FirstName+' '+E1.LastName AS [ManagerName],
D.Name AS [DepartmentName]
FROM Employees AS E
JOIN Employees AS E1 ON E1.EmployeeID=E.ManagerID
JOIN Departments AS D ON E.DepartmentID=D.DepartmentID
ORDER BY E.EmployeeID

--11.Min Average Salary
SELECT TOP 1
AVG(SALARY) AS MinAverageSalary FROM Employees
GROUP BY DepartmentID
ORDER BY MinAverageSalary

USE Geography
GO

--12.Highest Peaks in Bulgaria
SELECT
MC.CountryCode,M.MountainRange,PeakName,Elevation FROM Peaks AS P
JOIN Mountains AS M ON M.ID=P.MountainId
JOIN MountainsCountries AS MC ON MC.MountainId=P.MountainId
WHERE Elevation>2835
AND CountryCode='BG'
ORDER BY ELEVATION DESC 

--13.Count Mountain Ranges
SELECT CountryCode,COUNT(MountainId) AS [MountainRanges]
FROM MountainsCountries
GROUP BY CountryCode
HAVING CountryCode IN('BG','RU','US') 

--14.Countries With or Without Rivers
SELECT TOP 5
C.CountryName,R.RiverName
FROM Countries AS C
LEFT JOIN CountriesRivers AS CR ON CR.CountryCode=C.CountryCode
LEFT JOIN Rivers AS R ON R.Id=CR.RiverId
WHERE C.ContinentCode='AF'
ORDER BY C.CountryName

--15.Continents and Currencies

--16.Countries Without any Mountains
SELECT COUNT(*) FROM Countries AS C
LEFT JOIN MountainsCountries AS MC ON MC.CountryCode= C.CountryCode
WHERE MC.CountryCode IS NULL

--17.Highest Peak and Longest River by Country
SELECT TOP 5
C.CountryName,
MAX(P.Elevation) AS HighestPeakElevation,
MAX(R.Length) AS LongestRiverLength
FROM Countries AS C
LEFT JOIN MountainsCountries AS MC ON MC.CountryCode=C.CountryCode
LEFT JOIN Peaks AS P ON P.MountainId=MC.MountainId
LEFT JOIN CountriesRivers AS CR ON CR.CountryCode=C.CountryCode
LEFT JOIN Rivers AS R ON R.ID=CR.RiverId
GROUP BY C.CountryName
ORDER BY HighestPeakElevation DESC,
LongestRiverLength DESC,
C.CountryName 
