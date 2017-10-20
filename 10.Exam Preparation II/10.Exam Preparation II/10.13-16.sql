USE Bakery
GO

--13.Middle Range Distributors
SELECT D.Name,I.Name,P.Name,AVG(Rate) FROM Distributors AS D
JOIN Ingredients AS I ON I.DistributorId=D.Id
JOIN ProductsIngredients AS PIn ON PIn.IngredientId=I.Id
JOIN Products AS P ON PIn.ProductId=P.Id
JOIN Feedbacks AS F ON F.ProductId=P.Id
GROUP BY D.Name,I.Name,P.Name
HAVING AVG(Rate) BETWEEN 5 AND 8
ORDER BY D.NAME,I.Name,P.Name

--14.The Most Positive Country
SELECT
Ctr.Name AS [CountryName],
AVG(Rate) AS [FeedbackRate] FROM Feedbacks AS F
JOIN Customers AS C ON C.Id=F.CustomerId
JOIN Countries AS Ctr ON Ctr.Id=C.CountryId
GROUP BY Ctr.Name
HAVING AVG(RATE) IN 
	(SELECT TOP 1
	AVG(Rate) AS [FeedbackRate] FROM Feedbacks AS F
	JOIN Customers AS C ON C.Id=F.CustomerId
	JOIN Countries AS Ctr ON Ctr.Id=C.CountryId
	GROUP BY Ctr.Name
	ORDER BY AVG(Rate) DESC)
ORDER BY AVG(Rate) DESC

--15.Country Representative
SELECT CountryName, DistributorName
FROM (
	SELECT c.[Name] AS CountryName, d.[Name] AS DistributorName, 
		COUNT(i.Id) AS IngredientCount, 
		DENSE_RANK() OVER(PARTITION BY c.[Name] ORDER BY COUNT(i.Id) DESC) AS [Rank]
	FROM Countries AS c
	JOIN Distributors AS d ON d.CountryId = c.Id
	LEFT JOIN Ingredients AS i ON d.Id = i.DistributorId
	GROUP BY c.[Name], d.[Name]
) AS RankedDistributors
WHERE [Rank] = 1
ORDER BY CountryName, DistributorName


--16.Customers With Countries
CREATE VIEW v_UserWithCountries
AS
SELECT 
FirstName+' '+LastName AS [CustomerName],
AGE,
GENDER,
Ctr.Name FROM Customers AS C
JOIN Countries AS Ctr ON Ctr.Id=C.CountryId
GO