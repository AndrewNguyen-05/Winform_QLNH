CREATE DATABASE QLNH
GO

USE QLNH
GO

-- Food
-- Table
-- FoodCategory
-- Account
-- Bill
-- BillInfo

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên' ,
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống',--Trống || Có người
	isHidden INT NOT NULL DEFAULT 0
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Admin',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL DEFAULT 0 --1: Admin && 0: Staff
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0,
	isHidden INT NOT NULL DEFAULT 0,
	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0, --1: Đã thanh toán && 0: Chưa thanh toán
	discount INT NOT NULL DEFAULT 0,
	totalPrice FLOAT,

	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0,

	FOREIGN KEY (idFood) REFERENCES dbo.Food(id),
	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id)
)
GO

INSERT INTO Account (UserName, DisplayName, PassWord, Type) VALUES ('Admin', 'Administrator', '1', 1)
INSERT INTO Account VALUES ('Anh0505', 'Anh', '1', 0)
GO

CREATE PROC USP_GetAccountByUserName
@userName NVARCHAR(100)
AS 
BEGIN
	SELECT * FROM Account WHERE UserName = @userName
END
GO

EXEC USP_GetAccountByUserName @userName = N'Anh0505'
GO

CREATE PROC USP_Login
@userName NVARCHAR(100), @passWord NVARCHAR(100)
AS
BEGIN
	SELECT * FROM Account WHERE UserName = @userName AND PassWord = @passWord
END
GO

--Thêm bàn
DECLARE @i INT = 0

WHILE @i <= 100
BEGIN
	INSERT INTO TableFood (name) VALUES (N'Bàn ' + CAST(@i AS NVARCHAR(100)))
	SET @i = @i + 1
END
GO

CREATE PROC USP_GetTableList
AS SELECT * FROM TableFood WHERE isHidden = 0
GO

EXEC USP_GetTableList
GO

--Thêm Food Category
INSERT INTO FoodCategory (name) VALUES (N'Hải sản/Seafood')
INSERT INTO FoodCategory (name) VALUES (N'Gỏi/Salad')
INSERT INTO FoodCategory (name) VALUES (N'Mì/Noodle')
INSERT INTO FoodCategory (name) VALUES (N'Cơm/Rice')
INSERT INTO FoodCategory (name) VALUES (N'Nước giải khát/Drinks')
GO

--Thêm Food 
INSERT INTO Food (name, idCategory, price) VALUES (N'Cua nướng muối ớt', 1 , 130000 )
INSERT INTO Food (name, idCategory, price) VALUES (N'Tôm hùm nướng phô mai', 1 , 250000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Canh cá chua', 1, 150000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Canh cua cà pháo', 1 , 70000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Gỏi xoài tôm khô', 2, 100000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Gỏi xoài khô mực', 2, 100000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Gỏi cá trích', 2, 120000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Mì xào bò', 3, 75000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Mì xào hải sản', 3, 80000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Cơm chiên dương châu', 4, 90000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Cơm chiên thập cẩm', 4, 85000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Cơm trắng', 4, 20000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Coca Cola', 5, 15000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Sữa đậu nành', 5, 12000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Fanta', 5, 15000)
INSERT INTO Food (name, idCategory, price) VALUES (N'7Up', 5, 15000)
INSERT INTO Food (name, idCategory, price) VALUES (N'Nước lọc', 5, 10000)
GO

----Thêm bill
--INSERT INTO Bill (DateCheckIn, DateCheckOut, idTable, status) VALUES (GETDATE(), null, 55, 0)
--INSERT INTO Bill (DateCheckIn, DateCheckOut, idTable, status) VALUES (GETDATE(), null, 60, 0)
--INSERT INTO Bill (DateCheckIn, DateCheckOut, idTable, status) VALUES (GETDATE(), null, 59, 1)
--GO
----Thêm Bill Info
--INSERT INTO BillInfo (idBill, idFood, count) VALUES (1, 2, 3)
--INSERT INTO BillInfo (idBill, idFood, count) VALUES (1, 3, 4)
--INSERT INTO BillInfo (idBill, idFood, count) VALUES (1, 4, 2)
--INSERT INTO BillInfo (idBill, idFood, count) VALUES (2, 3, 1)
--INSERT INTO BillInfo (idBill, idFood, count) VALUES (2, 5, 2)
--INSERT INTO BillInfo (idBill, idFood, count) VALUES (2, 1, 2)
--INSERT INTO BillInfo (idBill, idFood, count) VALUES (3, 2, 3)
--INSERT INTO BillInfo (idBill, idFood, count) VALUES (3, 4, 5)
--INSERT INTO BillInfo (idBill, idFood, count) VALUES (3, 5, 2)
--GO



SELECT f.name, bi.count, f.price, f.price * bi.count AS totalPrice
FROM BillInfo bi, Bill b, Food f
WHERE bi.idBill = b.id AND bi.idFood = f.id AND b.idTable = 55

GO

CREATE PROC USP_InsertBill
@idTable INT
AS
BEGIN
	INSERT dbo.Bill 
		( DateCheckIn,
	      DateCheckOut,
		  idTable,
		  status,
		  discount
		)
	VALUES (GETDATE(),
			NULL,
			@idTable,
			0,
			0
		   )
END 
GO

CREATE PROC USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT
AS
BEGIN
	DECLARE @isExitsBillInfo INT
	DECLARE @FoodCount INT = 1
	SELECT @isExitsBillInfo = id, @FoodCount = dbb.count 
	FROM dbo.BillInfo AS dbb
	WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @FoodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo SET count = @FoodCount + @count WHERE idBill = @idBill AND idFood = @idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END 
	ELSE
	BEGIN
		INSERT dbo.BillInfo
			( idBill, idFood, count)
		VALUES (@idBill, @idFood, @count)
	END
END 
GO

CREATE TRIGGER UTG_UpdateBillInfo
ON BillInfo FOR INSERT, UPDATE
AS 
BEGIN
DECLARE @idBill INT
	
	SELECT @idBill = idBill FROM Inserted
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status = 0	
	
	DECLARE @count INT
	SELECT @count = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idBill
	
	IF (@count > 0)
	BEGIN
	
		PRINT @idTable
		PRINT @idBill
		PRINT @count
		
		UPDATE dbo.TableFood SET status = N'Có người' WHERE id = @idTable		
		
	END		
	ELSE
	BEGIN
	PRINT @idTable
		PRINT @idBill
		PRINT @count
	UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable	
	END
	
END
GO

CREATE TRIGGER UTG_UpdateBill
ON Bill FOR UPDATE
AS 
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = id FROM Inserted	
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill
	
	DECLARE @count int = 0
	
	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0
	
	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO

CREATE PROC USP_GetAccountInfo
AS
BEGIN
	SELECT UserName, DisplayName, [Type] FROM Account
END
GO


CREATE PROC USP_SwitchTable
@idTable1 INT, @idTable2 int
AS BEGIN

	DECLARE @idFirstBill int
	DECLARE @idSecondBill INT
	
	DECLARE @isFirstTablEmpty INT = 1
	DECLARE @isSecondTablEmpty INT = 1
	
	
	SELECT @idSecondBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
	
	IF (@idFirstBill IS NULL)
	BEGIN
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable1 , -- idTable - int
		          0  -- status - int
		        )
		        
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
		
	END
	
	SELECT @isFirstTablEmpty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill
	
	IF (@idSecondBill IS NULL)
	BEGIN
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable2 , -- idTable - int
		          0  -- status - int
		        )
		SELECT @idSecondBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
		
	END
	
	SELECT @isSecondTablEmpty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSecondBill

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSecondBill
	
	UPDATE dbo.BillInfo SET idBill = @idSecondBill WHERE idBill = @idFirstBill
	
	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)
	
	DROP TABLE IDBillInfoTable
	
	IF (@isFirstTablEmpty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2
		
	IF (@isSecondTablEmpty= 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END
GO

SELECT * FROM Bill

CREATE PROC USP_GetListBillByDate
@checkIn date, @checkOut date
AS
BEGIN
	SELECT t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM Bill AS b, TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO


SELECT * FROM Account
SELECT * FROM Bill
SELECT * FROM BillInfo
SELECT * FROM Food
SELECT * FROM FoodCategory
SELECT * FROM TableFood