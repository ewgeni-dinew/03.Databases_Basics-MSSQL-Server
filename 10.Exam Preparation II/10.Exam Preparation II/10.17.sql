USE Bakery
GO

--17.
CREATE FUNCTION udf_GetRating (@ProductName NVARCHAR(50))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @Rate DECIMAL(6,3)
	DECLARE @Result VARCHAR(10)
	
	SET @Rate=(SELECT AVG(ISNULL(Rate,0)) FROM Products AS P
	JOIN Feedbacks AS F ON F.ProductId=P.Id
	WHERE P.Name=@ProductName
	GROUP BY F.ProductId)

	SET @Result=
	CASE
		WHEN @Rate BETWEEN 0 AND 5 THEN 'Bad'
		WHEN @Rate BETWEEN 5 AND 8 THEN 'Average'
		WHEN @Rate>8 THEN 'Good'
		ELSE 'No rating'
	END

	RETURN @Result
END