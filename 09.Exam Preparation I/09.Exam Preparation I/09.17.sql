USE WMS
GO
--17.Cost of Order
CREATE FUNCTION udf_GetCost (@jobID INT)
RETURNS DECIMAL(6, 2)
AS
BEGIN
	DECLARE @TotalSum DECIMAL(6, 2) =
	(SELECT ISNULL(SUM(P.Price*OP.Quantity),0) FROM Parts AS P
	JOIN OrderParts AS OP ON OP.PartId=P.PartId
	JOIN Orders AS O ON O.OrderId=OP.OrderId
	JOIN Jobs AS J ON J.JobId=O.JobId
	WHERE @jobID=J.JobId)

	RETURN @TotalSum
END

