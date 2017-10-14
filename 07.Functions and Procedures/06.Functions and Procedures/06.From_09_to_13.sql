USE Bank
GO

--09.Find Full Name
CREATE PROCEDURE usp_GetHoldersFullName
AS
SELECT 
FirstName+' '+LastName AS [Full Name]
FROM AccountHolders
GO

--10.People with Balance Higher Than
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@InputSum DECIMAL(18,4))
AS
BEGIN
  WITH CTE_AccountHolders (HolderId) AS (
    SELECT AccountHolderId FROM Accounts
    GROUP BY AccountHolderId
    HAVING SUM(Balance) > @InputSum
)
SELECT FirstName,LastName FROM CTE_AccountHolders AS A
JOIN AccountHolders AS AH ON AH.Id=A.HolderId
ORDER BY LastName,FirstName 
END
GO

--11.Future Value Function
CREATE FUNCTION ufn_CalculateFutureValue (@Sum MONEY, @Interest FLOAT, @Years INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @Result MONEY=@Sum
	DECLARE @Count INT = 0
	WHILE @Count<@Years
		BEGIN
			SET @Result+=@Result*@Interest
			SET @Count+=1
		END
	RETURN @Result
END
GO

--12.Calculating Interest
CREATE PROCEDURE usp_CalculateFutureValueForAccount(@AccId INT,@IntrRate FLOAT)
AS
SELECT 
A.Id,
FirstName,
LastName,
Balance,
dbo.ufn_CalculateFutureValue(Balance,@IntrRate,5)
 FROM AccountHolders AS AH
JOIN Accounts AS A ON A.AccountHolderId=AH.Id
WHERE A.ID=@AccId

