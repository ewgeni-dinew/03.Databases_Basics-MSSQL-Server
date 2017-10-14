USE Gringotts
GO
--01.Records’ Count
SELECT COUNT(ID) AS Count FROM WizzardDeposits

--02.Longest Magic Wand
SELECT TOP(1) MagicWandSize AS LongestMagicWand FROM WizzardDeposits
ORDER BY LongestMagicWand DESC

--03.Longest Magic Wand per Deposit Groups
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand  FROM WizzardDeposits
GROUP BY DepositGroup

--04.Smallest Deposit Group per Magic Wand Size
SELECT TOP(2) DepositGroup FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

--05.Deposits Sum
SELECT DepositGroup,SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
GROUP BY DepositGroup

--06.Deposits Sum for Ollivander Family
SELECT DepositGroup,SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator LIKE '%Ollivander%'
GROUP BY DepositGroup

--07.Deposits Filter
SELECT DepositGroup,SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator LIKE '%Ollivander%'
GROUP BY DepositGroup
HAVING SUM(DepositAmount)<150000
ORDER BY TotalSum DESC

--08.Deposit Charge
SELECT DepositGroup,MagicWandCreator,MIN(DepositCharge) AS MinDepositCharge FROM WizzardDeposits
GROUP BY DepositGroup,MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

--09.
SELECT
	CASE
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN Age>=61 THEN '[60+]'
	END AS AgeGroup,
	COUNT(ID)
 FROM WizzardDeposits
 GROUP BY 
	CASE
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN Age>=61 THEN '[60+]'
	END

--10.First Letter
SELECT DISTINCT LEFT(FirstName,1) AS FirstLetter FROM WizzardDeposits
WHERE DepositGroup='Troll Chest'

--11.Average Interest
SELECT DepositGroup,IsDepositExpired,AVG(DepositInterest) AS AverageInterest FROM WizzardDeposits
WHERE DepositStartDate>'1985-01-01'
GROUP BY DepositGroup,IsDepositExpired
ORDER BY DepositGroup DESC,IsDepositExpired
SELECT * FROM WizzardDeposits

--12.

USE SoftUni
GO
--13.Departments Total Salaries
SELECT DepartmentID,SUM(Salary) AS TotalSalary FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--14.Employees Minimum Salaries
SELECT DepartmentID,MIN(Salary) AS MinimumSalary FROM Employees
WHERE DepartmentID IN('2','5','7')
AND HireDate>('2000-01-01')
GROUP BY DepartmentID

--15.Employees Average Salaries
SELECT * INTO NEWTABLE FROM Employees
WHERE Salary>30000

DELETE FROM NEWTABLE
WHERE ManagerID=42

UPDATE NEWTABLE
SET SALARY+=5000
WHERE DepartmentID=1

SELECT DepartmentID,AVG(Salary) AS AverageSalary FROM NEWTABLE
GROUP BY DepartmentID

--16.Employees Maximum Salaries
SELECT DepartmentID, MAX(Salary) AS MaxSalary FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--17.Employees Count Salaries
SELECT COUNT(Salary) FROM Employees
WHERE ManagerID IS NULL

--18.3rd Highest Salary
SELECT DepartmentID,Salary FROM Employees
GROUP BY DepartmentID
