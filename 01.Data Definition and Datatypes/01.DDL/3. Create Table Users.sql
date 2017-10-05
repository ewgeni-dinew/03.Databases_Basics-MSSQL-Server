USE ONE
GO

DROP TABLE USERS
CREATE TABLE Users(
Id BIGINT PRIMARY KEY IDENTITY NOT NULL,
Username VARCHAR(30) UNIQUE NOT NULL,
Password NVARCHAR(26) NOT NULL,
ProfilePicture VARBINARY CHECK(DATALENGTH(ProfilePicture)<900*1024),
LastLoginTime DATETIME DEFAULT CURRENT_TIMESTAMP,
IsDeleted NVARCHAR(5) NOT NULL CHECK(IsDeleted='true'OR IsDeleted='false')
)

INSERT INTO Users(Username,Password,ProfilePicture,LastLoginTime,IsDeleted)
VALUES('Melik', 'Melik123456789', 36, Null, 'true')


INSERT INTO Users (Username, Password, ProfilePicture, LastLoginTime, IsDeleted)
VALUES('Gosho', 'Gosho1234', 450,Null,'false')

INSERT INTO Users (Username, Password, ProfilePicture, LastLoginTime, IsDeleted)
VALUES('Pesho', 'Pesho123', 21,Null,'true')

INSERT INTO Users (Username, Password, ProfilePicture, LastLoginTime, IsDeleted)
VALUES('Vankata', 'Vankata123321',500,Null,'false')

INSERT INTO Users (Username, Password, ProfilePicture, LastLoginTime, IsDeleted)
VALUES('Baba', 'Baba54212', 352,Null,'false')

ALTER TABLE Users
DROP CONSTRAINT [PK__Users__3214EC076FA4A6E0]

AlTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username)

ALTER TABLE Users
ADD CONSTRAINT CK_MinLength CHECK (DATALENGTH(Password)>5)

ALTER TABLE Users
ADD CONSTRAINT DF_Users DEFAULT GETDATE() FOR LastLogin



