USE Bakery
GO

--05.Products by Price
SELECT NAME,Price,Description FROM Products
ORDER BY Price DESC, Name

--06.Ingredients
SELECT NAME,Description,OriginCountryId FROM Ingredients
WHERE OriginCountryId IN(1,10,20)
ORDER BY Id

--07.Ingredients from Bulgaria and Greece
SELECT TOP 15
I.Name,Description,C.Name FROM Ingredients AS I
JOIN Countries AS C ON C.Id=I.OriginCountryId
WHERE C.Name IN  ('Bulgaria','Greece')
ORDER BY I.Name,C.Name

--08.Best Rated Products
SELECT TOP 10
 P.NAME,
 P.Description,
 AVG(Rate) AS AverageRate,
 COUNT(*) AS Amount
 FROM Products AS P
JOIN Feedbacks AS F ON F.ProductId=P.Id
GROUP BY P.Name,P.Description
ORDER BY AverageRate DESC,Amount DESC

--09.Negative Feedback
SELECT ProductId,Rate,Description,CustomerId,Age,Gender FROM Feedbacks AS F
JOIN Customers AS C ON C.Id=F.CustomerId 
WHERE RATE<5.00
ORDER BY ProductId DESC,Rate

--10.Customers without Feedback
SELECT CONCAT(FirstName, ' ', LastName) AS [Name], PhoneNumber, Gender
FROM Customers AS c
LEFT OUTER JOIN Feedbacks AS f ON c.Id = f.CustomerId
WHERE f.Id IS NULL

--11.Honorable Mentions
SELECT 
ProductId,
FirstName+' '+LastName AS CustomerName,
Description 
FROM Feedbacks AS F
JOIN Customers AS C ON C.Id=F.CustomerId
WHERE CustomerId IN
	(SELECT CustomerId FROM Feedbacks
	GROUP BY CustomerId
	HAVING COUNT(CustomerId)>=3)
ORDER BY ProductId,CustomerName,F.Id

--12.Customers by Criteria
SELECT FirstName,AGE,PhoneNumber FROM Customers AS CU
JOIN Countries AS CO ON CO.Id=CU.CountryId
WHERE (AGE>=21 AND FirstName LIKE('%an%'))
OR (PhoneNumber LIKE ('%38') AND CO.Name!='Greece')
ORDER BY FirstName, AGE DESC