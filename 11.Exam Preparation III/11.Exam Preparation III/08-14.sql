USE Geography
GO

--08. Peaks and Mountains
SELECT p.PeakName, m.MountainRange AS Mountain, p.Elevation
FROM Peaks AS p
JOIN Mountains AS m ON p.MountainId = m.Id
ORDER BY p.Elevation DESC, p.PeakName

--09. Peaks with Mountain, Country and Continent
SELECT p.PeakName, m.MountainRange AS Mountain, c.CountryName, cont.ContinentName
FROM Peaks AS p
  JOIN Mountains AS m ON p.MountainId = m.Id
  JOIN MountainsCountries AS mc ON m.Id = mc.MountainId
  JOIN Countries AS c ON mc.CountryCode = c.CountryCode
  JOIN Continents AS cont ON c.ContinentCode = cont.ContinentCode
ORDER BY p.PeakName, c.CountryName

--10. Rivers by Country
SELECT c.CountryName, cont.ContinentName, 
  COUNT(r.Id) AS RiverCount, 
  ISNULL(SUM(r.Length), 0) AS TotalLength
FROM Countries AS c
  LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
  LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
  LEFT JOIN Continents AS cont on c.ContinentCode = cont.ContinentCode
GROUP BY c.CountryName, cont.ContinentName
ORDER BY RiverCount DESC, TotalLength DESC, c.CountryName

--11. Count of Countries by Currency
SELECT ccy.CurrencyCode, ccy.Description AS Currency, 
  COUNT(c.CountryCode) AS NumberOfCountries
FROM Currencies AS ccy
LEFT JOIN Countries AS c ON c.CurrencyCode = ccy.CurrencyCode
GROUP BY ccy.CurrencyCode, ccy.Description
ORDER BY NumberOfCountries DESC, Currency

--12. Population and Area by Continent
SELECT cont.ContinentName, 
  SUM(c.AreaInSqKm) AS CountriesArea, 
  SUM(CAST(c.Population AS float)) AS CountriesPopulation
FROM Continents AS cont
LEFT JOIN Countries AS c ON cont.ContinentCode = c.ContinentCode
GROUP BY cont.ContinentName
ORDER BY CountriesPopulation DESC

--13. Monasteries by Country
CREATE TABLE Monasteries(
  Id int NOT NULL IDENTITY, 
  Name nvarchar(200) NOT NULL, 
  CountryCode char(2) NOT NULL,
  CONSTRAINT PK_Monasteries PRIMARY KEY (Id),
  CONSTRAINT FK_Monasteries_Countries FOREIGN KEY (CountryCode) REFERENCES Countries(CountryCode)

)

INSERT INTO Monasteries(Name, CountryCode) VALUES
  ('Rila Monastery “St. Ivan of Rila”', 'BG'), 
  ('Bachkovo Monastery “Virgin Mary”', 'BG'),
  ('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
  ('Kopan Monastery', 'NP'),
  ('Thrangu Tashi Yangtse Monastery', 'NP'),
  ('Shechen Tennyi Dargyeling Monastery', 'NP'),
  ('Benchen Monastery', 'NP'),
  ('Southern Shaolin Monastery', 'CN'),
  ('Dabei Monastery', 'CN'),
  ('Wa Sau Toi', 'CN'),
  ('Lhunshigyia Monastery', 'CN'),
  ('Rakya Monastery', 'CN'),
  ('Monasteries of Meteora', 'GR'),
  ('The Holy Monastery of Stavronikita', 'GR'),
  ('Taung Kalat Monastery', 'MM'),
  ('Pa-Auk Forest Monastery', 'MM'),
  ('Taktsang Palphug Monastery', 'BT'),
  ('Sümela Monastery', 'TR');


WITH CTE_CountriesWithMoreRivers (CountryCode) AS (
  SELECT c.CountryCode
  FROM Countries AS c
  JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
  GROUP BY c.CountryCode
  HAVING COUNT(cr.RiverId) > 3

)

UPDATE Countries
SET IsDeleted = 1
WHERE CountryCode IN (SELECT * FROM CTE_CountriesWithMoreRivers)

SELECT m.Name AS Monastery, c.CountryName AS Country
FROM Monasteries AS m
JOIN Countries AS c ON c.CountryCode = m.CountryCode
WHERE c.IsDeleted = 0
ORDER BY Monastery

--14. Monasteries by Continents and Countries
UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'

INSERT INTO Monasteries (Name, CountryCode)
(SELECT 'Hanga Abbey', CountryCode
 FROM Countries AS c 
 WHERE CountryName = 'Tanzania')

 INSERT INTO Monasteries (Name, CountryCode)
(SELECT 'Myin-Tin-Daik', CountryCode
 FROM Countries AS c 
 WHERE CountryName = 'Myanmar')


SELECT cont.ContinentName, c.CountryName, 
  COUNT(m.Name) AS MonasteriesCount
FROM Continents AS cont
  LEFT JOIN Countries AS c ON cont.ContinentCode = c.ContinentCode
  LEFT JOIN Monasteries AS m ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted = 0
GROUP BY cont.ContinentName, c.CountryName
ORDER BY MonasteriesCount DESC, c.CountryName