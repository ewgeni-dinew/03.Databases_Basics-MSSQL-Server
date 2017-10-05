Use ONE
GO

CREATE TABLE Directors
(
	Id int IDENTITY NOT NULL PRIMARY KEY,
	DirectorName NVARCHAR(255) NOT NULL,
	Notes NVARCHAR(255)
)

CREATE TABLE Genres
(
	Id int IDENTITY NOT NULL PRIMARY KEY,
	GenreName NVARCHAR(255) NOT NULL,
	Notes NVARCHAR(255)
)

CREATE TABLE Categories
(
	Id int IDENTITY NOT NULL  PRIMARY KEY,
	CategoryName NVARCHAR(255) NOT NULL,
	Notes NVARCHAR(255)
)


CREATE TABLE Movies
(
	Id INT IDENTITY NOT NULL PRIMARY KEY,	
	Title NVARCHAR(255) NOT NULL,
	DirectorID INT UNIQUE,
	CopyrightYear DATETIME,
	Length DECIMAL(10,2),
	GenreID INT UNIQUE,
	CategoryID INT,
	Rating INT,
	Notes NVARCHAR(255)
)

INSERT INTO Directors(DirectorName, Notes)
Values('Pesho', NULL)
INSERT INTO Directors(DirectorName, Notes)
Values('Gosho', 'Nearly done!')
INSERT INTO Directors(DirectorName, Notes)
Values('Maria', 'Completely done!')
INSERT INTO Directors(DirectorName, Notes)
Values('Ivanka', NULL)
INSERT INTO Directors(DirectorName, Notes)
Values('Todorka', NULL)

INSERT INTO Genres(GenreName, Notes)
Values('Pesho', NULL)
INSERT INTO Genres(GenreName, Notes)
Values('Gosho', 'Completely done!')
INSERT INTO Genres(GenreName, Notes)
Values('Ivanka', NULL)
INSERT INTO Genres(GenreName, Notes)
Values('Mariika', 'Completely done!')
INSERT INTO Genres(GenreName, Notes)
Values('Stefan', 'Nearly done!')

INSERT INTO Categories(CategoryName, Notes)
Values('Pesho', 'Completely done!')
INSERT INTO Categories(CategoryName, Notes)
Values('Gosho', 'Nearly done!')
INSERT INTO Categories(CategoryName, Notes)
Values('Pesho', NULL)
INSERT INTO Categories(CategoryName, Notes)
Values('Mariika', 'Nearly done!')
INSERT INTO Categories(CategoryName, Notes)
Values('Stefan', 'Completely done!')

INSERT INTO Movies(Title, DirectorID, CopyrightYear, Length, GenreID, CategoryID,Rating,Notes)
Values('Scary Movie', 11233412, NULL, NUll, 643675, 3, 6,NULL)
INSERT INTO Movies(Title, DirectorID, CopyrightYear, Length, GenreID, CategoryID,Rating,Notes)
Values('Action Movie', 535123, NULL, NUll, 123453, 2, 4,NULL)
INSERT INTO Movies(Title, DirectorID, CopyrightYear, Length, GenreID, CategoryID,Rating,Notes)
Values('Erotic Movie', 7657457, NULL, NUll, 51532, 1, 3,NULL)
INSERT INTO Movies(Title, DirectorID, CopyrightYear, Length, GenreID, CategoryID,Rating,Notes)
Values('Love movie', 123547568, NULL, NUll, 4343, 4, 2,NULL)
INSERT INTO Movies(Title, DirectorID, CopyrightYear, Length, GenreID, CategoryID,Rating,Notes)
Values('Dramatic Movie', 97876543, NULL, NUll, 123, 1, 5,NULL)