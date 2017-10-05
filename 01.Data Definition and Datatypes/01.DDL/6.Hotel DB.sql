CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50),
	Title NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(255)
)

CREATE TABLE Customers
(
	AccountNumber INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	PhoneNumber INT,
	EmergencyName NVARCHAR(255),
	EmergencyNumber INT NOT NULL,
	Notes NVARCHAR(255)
)

CREATE TABLE RoomStatus
(
	RoomType NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(255)
)

CREATE TABLE RoomTypes
(
	RoomType NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(255)
)


CREATE TABLE BedTypes
(
	BedType NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(255)
)

CREATE TABLE Rooms
(
	RoomNumber INT PRIMARY KEY IDENTITY,
	RoomType NVARCHAR(50) NOT NULL,
	BedType NVARCHAR(50) NOT NULL,
	Rate NVARCHAR(50),
	RoomStatus NVARCHAR(50),
	Notes NVARCHAR(255)
)

CREATE TABLE Payments
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT UNIQUE NOT NULL,
	PaymentDate DATETIME,
	AccountNumber INT NOT NULL,
	FirstDateOccupied DATETIME,
	LastDateOccupied DATETIME,
	TotalDays INT NOT NULL,
	AmountCharged INT NOT NULL,
	TaxRate INT,
	TaxAmount INT,
	PaymentTotal INT NOT NULL,
	Notes NVARCHAR(255)
)

CREATE TABLE Occupancies
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeId INT UNIQUE NOT NULL,
	DateOccupied DATETIME,
	AccountNumber INT NOT NULL,
	RoomNumber INT NOT NULL,
	RateApplied INT,
	PhoneCharge INT,
	Notes NVARCHAR(255)
)

INSERT INTO Employees(FirstName,LastName,Title,Notes)
VALUES('Pesho', 'Peshov', 'Software Developer',NULL)
INSERT INTO Employees(FirstName,LastName,Title,Notes)
VALUES('Gosho', 'Peshov', 'Pilot',NULL)
INSERT INTO Employees(FirstName,LastName,Title,Notes)
VALUES('Pesho', 'Petrov', 'Engineer',NULL)

INSERT INTO Customers(FirstName,LastName,PhoneNumber,EmergencyName,EmergencyNumber, Notes)
VALUES('Pesho', 'Peshov', NULL, NULL, 112, NULL)
INSERT INTO Customers(FirstName,LastName,PhoneNumber,EmergencyName,EmergencyNumber, Notes)
VALUES('Pesho', 'Petrov', NULL, NULL, 911, NULL)
INSERT INTO Customers(FirstName,LastName,PhoneNumber,EmergencyName,EmergencyNumber, Notes)
VALUES('Pesho', 'Peshov', NULL, NULL, 912, NULL)

INSERT INTO RoomStatus(RoomType, Notes)
VALUES('Free', NULL)
INSERT INTO RoomStatus(RoomType, Notes)
VALUES('Reserved', NULL)
INSERT INTO RoomStatus(RoomType, Notes)
VALUES('Currently not available', NULL)

INSERT INTO RoomTypes(RoomType,Notes)
VALUES('Luxury', NULL)
INSERT INTO RoomTypes(RoomType,Notes)
VALUES('Standard', NULL)
INSERT INTO RoomTypes(RoomType,Notes)
VALUES('Small', NULL)

INSERT INTO BedTypes(BedType,Notes)
VALUES('LARGE', NULL)
INSERT INTO BedTypes(BedType,Notes)
VALUES('Medium', NULL)
INSERT INTO BedTypes(BedType,Notes)
VALUES('Small', NULL)

INSERT INTO Rooms(RoomType, BedType, Rate,RoomStatus,Notes)
VALUES('Luxury', 'Large', 'Perfect for rich people', 'Available', NULL)
INSERT INTO Rooms(RoomType, BedType, Rate,RoomStatus,Notes)
VALUES('Medium', 'Medium', NULL, 'Not available', NULL)
INSERT INTO Rooms(RoomType, BedType, Rate,RoomStatus,Notes)
VALUES('Economy', 'Small', NULL, 'Available', NULL)

INSERT INTO Payments(EmployeeId,PaymentDate,AccountNumber,FirstDateOccupied,LastDateOccupied,TotalDays,AmountCharged,TaxRate,TaxAmount,PaymentTotal,Notes)
VALUES(231, NULL, 2311, NULL,NULL, 7, 5000, 0,0,5000,NULL)
INSERT INTO Payments(EmployeeId,PaymentDate,AccountNumber,FirstDateOccupied,LastDateOccupied,TotalDays,AmountCharged,TaxRate,TaxAmount,PaymentTotal,Notes)
VALUES(321, NULL, 3211, NULL,NULL, 7, 5000, 0,2000,7000,NULL)
INSERT INTO Payments(EmployeeId,PaymentDate,AccountNumber,FirstDateOccupied,LastDateOccupied,TotalDays,AmountCharged,TaxRate,TaxAmount,PaymentTotal,Notes)
VALUES(999, NULL, 9989, NULL,NULL, 7, 5000, 0,50,5500,NULL)

INSERT INTO Occupancies(EmployeeId,DateOccupied,AccountNumber,RoomNumber,RateApplied,PhoneCharge,Notes)
VALUES(991, NULL, 534, 8, NULL,NULL,NULL)
INSERT INTO Occupancies(EmployeeId,DateOccupied,AccountNumber,RoomNumber,RateApplied,PhoneCharge,Notes)
VALUES(561, NULL, 75, 9, NULL,NULL,NULL)
INSERT INTO Occupancies(EmployeeId,DateOccupied,AccountNumber,RoomNumber,RateApplied,PhoneCharge,Notes)
VALUES(135, NULL, 8, 10, NULL,NULL,NULL)