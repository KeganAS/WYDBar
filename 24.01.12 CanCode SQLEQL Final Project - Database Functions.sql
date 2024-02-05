CREATE PROCEDURE GetLoyaltyInfo
	@CustomerID varchar(10)
AS
BEGIN
	SELECT
		CUSTOMER.FirstName, 
		CUSTOMER.LastName,
		CUSTOMER.Phone, 
		CUSTOMER.Email, 
		CUSTOMER.LoyaltyPoints
	FROM 
		CUSTOMER
	WHERE
		CUSTOMER.CustomerID = @CustomerID;
END;

CREATE PROCEDURE GetProductInfo
	@ProductID varchar(10)
AS
BEGIN
	SELECT
		PRODUCT.ProductName,
		PRODUCT.Category,
		PRODUCT.Cost,
		PRODUCT.Price,
		PRODUCT.StockQuantity,
		PRODUCT.Status,
		SUPPLIER.CompanyName,
		SUPPLIER.ContactName,
		SUPPLIER.ContactPhone
	FROM 
		PRODUCT
	JOIN
		dbo.SUPPLIER ON PRODUCT.SupplierID = SUPPLIER.SupplierID
	WHERE
		PRODUCT.ProductID = @ProductID;
END;


CREATE VIEW EmployeeDetails AS
SELECT
	EMPLOYEE.EmployeeID,
	EMPLOYEE.FirstName,
	EMPLOYEE.LastName,
	POSITION.Title,
	EMPLOYEE.Email,
	EMPLOYEE.StreetNo,
	EMPLOYEE.StreetName,
	EMPLOYEE.AptNo,
	EMPLOYEE.City,
	EMPLOYEE.State,
	EMPLOYEE.ZipCode,
	EMPLOYEE.BirthDate, 
	POSITION.BaseSalary,
	POSITION.BaseHourlyRate
FROM 
	dbo.EMPLOYEE
JOIN
	dbo.POSITION ON Employee.PositionID = POSITION.PositionID
;

CREATE FUNCTION CalculateEmployeeSalesbyRange 
(
    @EmployeeID varchar(10),
    @StartDate smalldatetime,
    @EndDate smalldatetime
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalSales DECIMAL(18, 2);

    SELECT @TotalSales = SUM(OrderTotal)
    FROM ORDERS
    WHERE EmployeeID = @EmployeeID
      AND Date BETWEEN @StartDate AND @EndDate;

    RETURN ISNULL(@TotalSales, 0);
END;

CREATE FUNCTION GetOrderDetails
(
	@OrderID varchar(10)
)
RETURNS TABLE
AS 
RETURN
(
	SELECT
		LINEITEM.OrderID,
		LINEITEM.ProductID,
		PRODUCT.ProductName,
		PRODUCT.Price AS UnitPrice,
		LINEITEM.Quantity,
		LINEITEM.LineTotal
	FROM
		dbo.LINEITEM
	INNER JOIN
		PRODUCT ON LINEITEM.ProductID = PRODUCT.ProductID
	WHERE
		LINEITEM.ORDERID = @OrderID
);

CREATE PROCEDURE AddNewEmployee
    @EmployeeID varchar(10),
    @PositionID varchar(10),
    @ManagerID varchar(10),
    @Status varchar(15),
    @FirstName varchar(50),
    @LastName varchar(50),
    @Email varchar(100),
    @Phone varchar(25),
    @StreetNo varchar(10),
    @StreetName varchar(100),
    @AptNo varchar(10),
    @City varchar(25),
    @State varchar(2),
    @ZipCode varchar(5),
    @HireDate date,
    @BirthDate date
AS
BEGIN
    INSERT INTO EMPLOYEE (EmployeeID, PositionID, ManagerID, Status, FirstName, LastName, Email, Phone, StreetNo, StreetName, AptNo, City, State, ZipCode, HireDate, BirthDate)
    VALUES (@EmployeeID, @PositionID, @ManagerID, @Status, @FirstName, @LastName, @Email, @Phone, @StreetNo, @StreetName, @AptNo, @City, @State, @ZipCode, @HireDate, @BirthDate);
END;

CREATE PROCEDURE UpdateSupplierInfo
    @SupplierID varchar(10),
    @CompanyName varchar(100),
    @ContactName varchar(100),
    @ContactEmail varchar(100),
    @ContactPhone varchar(25),
    @StreetNo varchar(10),
    @StreetName varchar(100),
    @SuiteNo varchar(10),
    @City varchar(25),
    @State varchar(2),
    @ZipCode varchar(5)
AS
BEGIN
    UPDATE SUPPLIER
    SET CompanyName = @CompanyName,
        ContactName = @ContactName,
        ContactEmail = @ContactEmail,
        ContactPhone = @ContactPhone,
        StreetNo = @StreetNo,
        StreetName = @StreetName,
        SuiteNo = @SuiteNo,
        City = @City,
        State = @State,
        ZipCode = @ZipCode
    WHERE SupplierID = @SupplierID;
END;

CREATE PROCEDURE DeleteProduct
    @ProductID varchar(10)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PRODUCT WHERE ProductID = @ProductID)
    BEGIN
        DELETE FROM PRODUCT WHERE ProductID = @ProductID;
    END
    ELSE
    BEGIN
        RAISERROR('Error: Attempt to delete a non-existent product with ProductID' @ProductID);
    END
END;


