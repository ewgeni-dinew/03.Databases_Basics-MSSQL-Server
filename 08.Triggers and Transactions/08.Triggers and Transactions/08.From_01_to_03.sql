USE BANK
GO

--01.Create Table Logs

CREATE TABLE Logs(
LogID INT PRIMARY KEY NOT NULL,
AccountID INT NOT NULL,
OldSum MONEY NOT NULL,
NewSum MONEY NOT NULL
)
GO

 CREATE TRIGGER tr_AccountBalanceChange ON Accounts
 FOR UPDATE
 AS
 BEGIN
	DECLARE @AccountID INT =(SELECT ID FROM inserted)
	DECLARE @OldSum MONEY=(SELECT BALANCE FROM deleted)
	DECLARE @NewSum MONEY=(SELECT BALANCE FROM inserted)

	IF(@NewSum<>@OldSum)
		INSERT INTO Logs VALUES
		(@AccountID,@OldSum,@NewSum)
 END

 --02.Create Table Emails
 CREATE TABLE NotificationEmails(
ID INT PRIMARY KEY NOT NULL,
Recipient INT NOT NULL,
Subject NVARCHAR(200) NOT NULL,
Body NVARCHAR(200) NOT NULL
)
GO

CREATE TRIGGER tr_LogsNotificationEmails ON Logs FOR INSERT
AS
BEGIN
	DECLARE @Recipient INT=(SELECT AccountID FROM inserted)
	DECLARE @OldSum MONEY=(SELECT OldSum FROM inserted)
	DECLARE @NewSum MONEY=(SELECT NewSum FROM inserted)
	DECLARE @Subject NVARCHAR(200)=CONCAT('Balance change for account: ',@Recipient)
	DECLARE @Body NVARCHAR(200)=CONCAT('On',GETDATE(),' your balance was changed from ',
	@OldSum, ' to ', @NewSum,'.')

	INSERT INTO NotificationEmails (Recipient,Subject,Body)
	VALUES
	(@Recipient,@Subject,@Body)
END
GO

--03.Deposit Money
CREATE PROCEDURE usp_DepositMoney(@AccID INT,@MoneyAmmount MONEY)
AS
BEGIN
	BEGIN TRANSACTION
		UPDATE Accounts
		SET Balance+=@MoneyAmmount
		WHERE (Accounts.Id=@AccID)

		IF(@@ROWCOUNT<>1)
			BEGIN
				ROLLBACK
				RAISERROR ('Invalid account!', 16, 1);
				RETURN
			END
	COMMIT
END
GO