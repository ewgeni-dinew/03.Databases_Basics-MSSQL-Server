USE Bank
GO

--04.Withdraw Money Procedure
CREATE PROCEDURE usp_WithdrawMoney(@AccID INT,@MoneyAmm MONEY)
AS
BEGIN
	BEGIN TRANSACTION
		UPDATE Accounts
		SET Balance-=@MoneyAmm
		WHERE(Accounts.ID=@AccID)

		IF(@@ROWCOUNT<>1)
			BEGIN
				ROLLBACK
				RAISERROR ('Invalid account!', 16, 1);
				RETURN
			END
	COMMIT
END
GO

--05.Money Transfer
CREATE PROCEDURE usp_TransferMoney (@SenderID INT,@ReceiverID INT,@Amount MONEY)
AS
BEGIN
	DECLARE @SenderBalanceBeforeTrans MONEY=
	(SELECT Balance FROM Accounts
	WHERE ID=@SenderID)

	IF(@SenderBalanceBeforeTrans IS NULL)
		BEGIN
		RAISERROR('Invalid sender account!', 16, 1)
		RETURN
	END

	DECLARE @ReceiverBalanceBeforeTrans MONEY=
	(SELECT Balance FROM Accounts
	WHERE ID=@ReceiverID)

	IF(@ReceiverBalanceBeforeTrans IS NULL)
		BEGIN
		RAISERROR('Invalid sender account!', 16, 1)
		RETURN
	END

	IF(@SenderID = @ReceiverID)
		BEGIN
		RAISERROR('Sender and receiver accounts must be different!', 16, 1)
		RETURN
	END
	
	 IF(@Amount <= 0)
		BEGIN
		RAISERROR ('Transfer amount must be positive!', 16, 1); 
		RETURN;
	END 
	
	BEGIN TRANSACTION
		EXEC usp_WithdrawMoney @SenderID, @Amount
		EXEC usp_DepositMoney @ReceiverID, @Amount

		DECLARE @SenderBalanceAfter MONEY=
		(SELECT BALANCE FROM Accounts
		WHERE ID=@SenderID)
		DECLARE @ReceiverBalanceAfter MONEY=
		(SELECT BALANCE FROM Accounts
		WHERE ID=@ReceiverID)

		IF((@SenderBalanceAfter <> @SenderBalanceBeforeTrans - @Amount) OR 
			(@ReceiverBalanceAfter <> @ReceiverBalanceBeforeTrans + @Amount))
			BEGIN
				ROLLBACK
				RAISERROR('Invalid account balances!', 16, 1)
				RETURN
			END
	COMMIT 
END 
	