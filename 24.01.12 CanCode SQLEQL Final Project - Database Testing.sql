SELECT
	ORDERS.OrderID,
	CUSTOMER.FirstName,
	CUSTOMER.LastName,
	CUSTOMER.Phone,
	CUSTOMER.LoyaltyPoints,
	ORDERS.Date,
	ORDERS.SubTotal,
	ORDERS.OrderTotal,
	ORDERS.PaymentMethod
FROM
	dbo.ORDERS
JOIN
	dbo.CUSTOMER ON ORDERS.CustomerID = CUSTOMER.CustomerID;


DECLARE @Total DECIMAL(18, 2);
SELECT @Total = dbo.CalculateEmployeeSalesbyRange('EM001', '2019-01-01', '2023-12-31');
PRINT 'Total Sales: ' + CAST(@Total AS VARCHAR);

EXEC GetLoyaltyInfo @CustomerID = CU013;

EXEC GetProductInfo @ProductID = PR021;

SELECT * FROM GetOrderDetails('ORD002');

SELECT * FROM EmployeeDetails;

EXEC AddNewEmployee
    @EmployeeID = 'EM040',
    @PositionID = 'P00',
    @ManagerID = 'EM005',
    @Status = 'Active',
    @FirstName = 'James',
    @LastName = 'Baldwin',
    @Email = 'jimmyb@h2obar.com',
    @Phone = '410-238-2918',
    @StreetNo = '7',
    @StreetName = 'Eastern Avenue',
    @AptNo = '3B',
    @City = 'New Baltimore',
    @State = 'NY',
    @ZipCode = '12305',
    @HireDate = '2024-01-16',
    @BirthDate = '1990-05-12';

EXEC UpdateSupplierInfo
	@SupplierID = 'SU018',
    @CompanyName = 'Saratoga Springs Water',
    @ContactName = 'Aqua Fina',
    @ContactEmail = 'aquafina@sswater.org',
    @ContactPhone = '987-654-3210',
    @StreetNo = '456',
    @StreetName = 'Elm Street',
    @SuiteNo = '2B',
    @City = 'Saratoga',
    @State = 'NY',
    @ZipCode = '14321';

DELETE FROM LINEITEM WHERE LINEITEM.ProductID = 'PR022';

EXEC DeleteProduct @ProductID = 'PR022';

