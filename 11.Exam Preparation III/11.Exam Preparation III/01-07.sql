USE Diablo
GO

--01.Number of Users for Email Provider
SELECT 
  RIGHT(Email, LEN(Email) - CHARINDEX('@', Email)) AS [Email Provider], 
  COUNT(*) AS [Number of Users]
FROM Users
GROUP BY RIGHT(Email, LEN(Email) - CHARINDEX('@', Email))
ORDER BY [Number of Users] DESC, [Email Provider]

--02. All Users in Games
SELECT g.Name AS Game, gt.Name AS [Game Type],
  u.Username, ug.Level, ug.Cash, c.Name AS Character
FROM UsersGames AS ug
  JOIN Games AS g ON ug.GameId = g.Id
  JOIN GameTypes AS gt ON g.GameTypeId = gt.Id
  JOIN Users AS u ON ug.UserId = u.Id
  JOIN Characters AS c ON ug.CharacterId = c.Id
ORDER BY ug.Level DESC, u.Username, Game

--03. Users in Games with Their Items
SELECT u.Username, g.Name AS Game,
  COUNT(ugi.ItemId) AS [Items Count],
  SUM(i.Price) AS [Items Price]
FROM UsersGames AS ug
  JOIN Users AS u ON ug.UserId = u.Id
  JOIN Games AS g ON ug.GameId = g.Id
  JOIN UserGameItems AS ugi ON ugi.UserGameId = ug.Id -- NB! ug.Id <> g.Id
  JOIN Items AS i ON ugi.ItemId = i.Id
GROUP BY u.Username, g.Name
HAVING COUNT(ugi.ItemId) >= 10
ORDER BY
  [Items Count] DESC, [Items Price] DESC, u.Username

  --04. * User in Games with Their Statistics
SELECT 
  u.Username, g.Name AS Game, MAX(c.Name) AS Character, 
  MAX(cs.Strength) + MAX(gts.Strength) + SUM(gis.Strength) AS Strength, 
  MAX(cs.Defence) + MAX(gts.Defence) + SUM(gis.Defence) AS Defence, 
  MAX(cs.Speed) + MAX(gts.Speed) + SUM(gis.Speed) AS Speed, 
  MAX(cs.Mind) + MAX(gts.Mind) + SUM(gis.Mind) AS Mind, 
  MAX(cs.Luck) + MAX(gts.Luck) + SUM(gis.Luck) AS Luck
FROM UsersGames AS ug
JOIN Users AS u ON ug.UserId = u.Id
JOIN Games AS g ON ug.GameId = g.Id
JOIN Characters AS c ON ug.CharacterId = c.Id
JOIN [Statistics] AS cs ON c.StatisticId = cs.Id
JOIN GameTypes AS gt ON gt.Id = g.GameTypeId
JOIN [Statistics] AS gts ON gts.Id = gt.BonusStatsId
JOIN UserGameItems AS ugi ON ugi.UserGameId = ug.Id
JOIN Items AS i ON i.Id = ugi.ItemId
JOIN [Statistics] AS gis ON gis.Id = i.StatisticId
GROUP BY u.Username, g.Name
ORDER BY Strength DESC, Defence DESC, Speed DESC, Mind DESC, Luck DESC

--05. All Items with Greater than Average Statistics
WITH CTE_AboveAverageStats (Id) AS (  
  SELECT Id FROM [Statistics]
  WHERE Mind > (SELECT AVG(Mind  * 1.0) FROM [Statistics]) AND
        Luck > (SELECT AVG(Luck  * 1.0) FROM [Statistics]) AND
       Speed > (SELECT AVG(Speed * 1.0) FROM [Statistics])
)
SELECT 
  i.Name, i.Price, i.MinLevel, 
  s.Strength, s.Defence, s.Speed, s.Luck, s.Mind
FROM CTE_AboveAverageStats AS av
  JOIN [Statistics] AS s ON av.Id = s.Id
  JOIN Items AS i ON i.StatisticId = s.Id
ORDER BY i.Name

--06. Display All Items about Forbidden Game Type
SELECT i.Name AS Item, i.Price, i.MinLevel, gt.Name AS [Forbidden Game Type]
FROM Items AS i -- all items
  LEFT JOIN GameTypeForbiddenItems AS fi ON fi.ItemId = i.Id
  LEFT JOIN GameTypes AS gt ON fi.GameTypeId = gt.Id
ORDER BY [Forbidden Game Type] DESC, Item

--07. Buy Items for User in Game
DECLARE @gameName nvarchar(50) = 'Edinburgh';
DECLARE @username nvarchar(50) = 'Alex';
DECLARE @userGameId int = (
  SELECT ug.Id 
  FROM UsersGames AS ug
  JOIN Users AS u ON ug.UserId = u.Id
  JOIN Games AS g ON ug.GameId = g.Id
  WHERE u.Username = @username AND g.Name = @gameName

);

DECLARE @availableCash money = (SELECT Cash FROM UsersGames WHERE Id = @userGameId);
DECLARE @purchasePrice money = (
  SELECT SUM(Price) FROM Items WHERE Name IN 
  ('Blackguard', 'Bottomless Potion of Amplification', 'Eye of Etlich (Diablo III)',
  'Gem of Efficacious Toxin', 'Golden Gorget of Leoric', 'Hellfire Amulet')

); 

-- validating min game level not required
IF (@availableCash >= @purchasePrice) 
BEGIN 
  BEGIN TRANSACTION  

  UPDATE UsersGames SET Cash -= @purchasePrice WHERE Id = @userGameId; 

  IF(@@ROWCOUNT <> 1) 
  BEGIN
    ROLLBACK; RAISERROR('Could not make payment', 16, 1); RETURN;
  END

  INSERT INTO UserGameItems (ItemId, UserGameId) 
  (SELECT Id, @userGameId FROM Items WHERE Name IN 
    ('Blackguard', 'Bottomless Potion of Amplification', 'Eye of Etlich (Diablo III)',
    'Gem of Efficacious Toxin', 'Golden Gorget of Leoric', 'Hellfire Amulet')) 

  IF((SELECT COUNT(*) FROM Items WHERE Name IN 
    ('Blackguard', 'Bottomless Potion of Amplification', 'Eye of Etlich (Diablo III)', 
	'Gem of Efficacious Toxin', 'Golden Gorget of Leoric', 'Hellfire Amulet')) <> @@ROWCOUNT)
  BEGIN
    ROLLBACK; RAISERROR('Could not buy items', 16, 1); RETURN;
  END	

  COMMIT;

END

-- select users in game with items
SELECT u.Username, g.Name, ug.Cash, i.Name AS [Item Name]
FROM UsersGames AS ug
JOIN Games AS g ON ug.GameId = g.Id
JOIN Users AS u ON ug.UserId = u.Id
JOIN UserGameItems AS ugi ON ug.Id = ugi.UserGameId
JOIN Items AS i ON i.Id = ugi.ItemId
WHERE g.Name = @gameName