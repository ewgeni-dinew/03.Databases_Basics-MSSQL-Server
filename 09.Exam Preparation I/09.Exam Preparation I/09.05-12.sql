--05.Clients by Name
SELECT FirstName,LastName,Phone FROM Clients
ORDER BY LastName,ClientId

--06.Job Status
SELECT Status,IssueDate FROM Jobs
WHERE STATUS IN ('Pending','In Progress')
ORDER BY IssueDate,JobId

--07.Mechanic Assignments
SELECT
FirstName+' '+LastName AS [Mechanic],
Status,
IssueDate
FROM Mechanics AS M
JOIN Jobs AS J ON J.MechanicId=M.MechanicId
ORDER BY M.MechanicId,IssueDate,JobId

--08.Current Clients
SELECT
FirstName+' '+LastName AS Client ,
DATEDIFF(DAY,IssueDate,'2017-04-24') AS [Days going] ,
Status
FROM Clients AS C
JOIN Jobs AS J ON J.ClientId=C.ClientId
WHERE Status IN ('Pending','In Progress')
ORDER BY [Days going] DESC, C.ClientId

--09.Mechanic Performance
SELECT
FirstName+' '+LastName AS [Mechanic],
AVG(DATEDIFF(DAY,IssueDate,FinishDate))
FROM Mechanics AS M
JOIN Jobs AS J ON J.MechanicId=M.MechanicId
GROUP BY M.MechanicId,FirstName+' '+LastName
ORDER BY M.MechanicId

--10.Hard Earners
SELECT TOP 3
FirstName+' '+LastName AS [Mechanic],
COUNT(JobId) AS [Jobs]
FROM Mechanics AS M
JOIN Jobs AS J ON J.MechanicId=M.MechanicId
WHERE Status IN ('Pending','In Progress')
GROUP BY J.MechanicId,FirstName+' '+LastName
HAVING COUNT(JobId)>1
ORDER BY [Jobs] DESC,J.MechanicId

--11.Available Mechanics
SELECT FirstName+' '+LastName AS [Available] FROM Mechanics
WHERE MechanicId NOT IN
(SELECT DISTINCT MechanicId FROM Jobs
WHERE MechanicId IS NOT NULL AND STATUS<>'Finished')
ORDER BY MechanicId

--12.Parts Cost
SELECT ISNULL(SUM(P.Price*OP.Quantity),0) FROM Parts AS P
JOIN OrderParts AS OP ON OP.PartId=P.PartId
JOIN Orders AS O ON O.OrderId=OP.OrderId
WHERE DATEDIFF(DAY,IssueDate,'2017-04-24')<=21
