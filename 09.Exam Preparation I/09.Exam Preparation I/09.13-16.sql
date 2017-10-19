USE WMS
GO

--13.Past Expenses
SELECT J.JobId,
	(SELECT ISNULL(SUM(P.Price*OP.Quantity),0) FROM Parts AS P
	JOIN OrderParts AS OP ON OP.PartId=P.PartId
	JOIN Orders AS O ON O.OrderId=OP.OrderId
	JOIN Jobs AS JO ON JO.JobId=O.JobId
	WHERE JO.JobId=J.JobId) AS Total
FROM Jobs AS J
WHERE Status='Finished'
ORDER BY Total DESC,J.JobId

--14.Model Repair Time
SELECT 
M.ModelId,
Name,
CONCAT(AVG(DATEDIFF(DAY,IssueDate,FinishDate)),' days') AS Average
 FROM Models AS M
JOIN Jobs AS J ON J.ModelId=M.ModelId
GROUP BY M.ModelId,Name
ORDER BY Average

--15.Faultiest Model
SELECT TOP 1 WITH TIES
       m.Name,
       COUNT(*) AS [Times Serviced],
       (SELECT ISNULL(SUM(p.Price * op.Quantity), 0) FROM Jobs AS j
        JOIN Orders AS o ON o.JobId = j.JobId
        JOIN OrderParts AS op ON op.OrderId = o.OrderId
        JOIN Parts AS p ON p.PartId = op.PartId
        WHERE j.ModelId = m.ModelId) AS [Parts Total]
  FROM Models AS m
JOIN Jobs AS j ON j.ModelId = m.ModelId
GROUP BY m.ModelId, m.Name
ORDER BY [Times Serviced] DESC

--16.
SELECT p.PartId,
       p.Description,
       SUM(pn.Quantity) AS Required,
       AVG(p.StockQty) AS [In Stock],
       ISNULL(SUM(op.Quantity), 0) AS Ordered
  FROM Parts AS p
JOIN PartsNeeded pn ON pn.PartId = p.PartId
JOIN Jobs AS j ON j.JobId = pn.JobId
LEFT JOIN Orders AS o ON o.JobId = j.JobId
LEFT JOIN OrderParts AS op ON op.OrderId = o.OrderId
WHERE j.Status <> 'Finished'
GROUP BY p.PartId, p.Description
HAVING AVG(p.StockQty) + ISNULL(SUM(op.Quantity), 0) < SUM(pn.Quantity)
ORDER BY p.PartId