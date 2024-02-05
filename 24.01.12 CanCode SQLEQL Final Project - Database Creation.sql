CREATE TABLE [EMPLOYEE] (
    [EmployeeID] varchar(10)  NOT NULL ,
    [PositionID] varchar(10)  NOT NULL ,
    [ManagerID] varchar(10)  NOT NULL ,
    [Status] varchar(15)  NOT NULL ,
    [FirstName] varchar(50)  NOT NULL ,
    [LastName] varchar(50)  NOT NULL ,
    [Email] varchar(100)  NOT NULL ,
    [Phone] varchar(25)  NOT NULL ,
    [StreetNo] varchar(10)  NOT NULL ,
    [StreetName] varchar(100)  NOT NULL ,
    [AptNo] varchar(10)  NULL ,
    [City] varchar(25)  NOT NULL ,
    [State] varchar(2)  NOT NULL ,
    [ZipCode] varchar(5)  NOT NULL ,
    [HireDate] date  NOT NULL ,
    [BirthDate] date  NOT NULL ,
    CONSTRAINT [PK_EMPLOYEE] PRIMARY KEY CLUSTERED (
        [EmployeeID] ASC
    )
)

CREATE TABLE [POSITION] (
    [PositionID] varchar(10)  NOT NULL ,
    [Title] varchar(100)  NOT NULL ,
    [BaseSalary] money  NULL ,
    [BaseHourlyRate] decimal  NULL ,
    [TipEligible] bit  NOT NULL ,
    CONSTRAINT [PK_POSITION] PRIMARY KEY CLUSTERED (
        [PositionID] ASC
    )
)

CREATE TABLE [CUSTOMER] (
    [CustomerID] varchar(10)  NOT NULL ,
    [FirstName] varchar(50)  NULL ,
    [LastName] varchar(50)  NULL ,
    [Phone] varchar(25)  NULL ,
    [Email] varchar(100)  NULL ,
    [LoyaltyPoints] int  NULL ,
    CONSTRAINT [PK_CUSTOMER] PRIMARY KEY CLUSTERED (
        [CustomerID] ASC
    )
)

CREATE TABLE [ORDERS] (
    [OrderID] varchar(10)  NOT NULL ,
    [EmployeeID] varchar(10)  NOT NULL ,
    [CustomerID] varchar(10)  NOT NULL ,
    [Date] smalldatetime  NOT NULL ,
    [OrderStatus] varchar(15)  NOT NULL ,
    [SubTotal] decimal  NOT NULL ,
    [TipAmount] decimal  NULL ,
    [OrderTotal] decimal  NOT NULL ,
    [PaymentMethod] varchar(20)  NULL ,
    CONSTRAINT [PK_ORDER] PRIMARY KEY CLUSTERED (
        [OrderID] ASC
    )
)

CREATE TABLE [SUPPLIER] (
    [SupplierID] varchar(10)  NOT NULL ,
    [CompanyName] varchar(100)  NULL ,
    [ContactName] varchar(100)  NULL ,
    [ContactEmail] varchar(100)  NULL ,
    [ContactPhone] varchar(100)  NULL ,
    [StreetNo] varchar(10)  NOT NULL ,
    [StreetName] varchar(100)  NOT NULL ,
    [SuiteNo] varchar(10)  NOT NULL ,
    [City] varchar(25)  NOT NULL ,
    [State] varchar(2)  NOT NULL ,
    [ZipCode] varchar(5)  NOT NULL ,
    CONSTRAINT [PK_SUPPLIER] PRIMARY KEY CLUSTERED (
        [SupplierID] ASC
    )
)

CREATE TABLE [PRODUCT] (
    [ProductID] varchar(10)  NOT NULL ,
    [ProductName] varchar(50)  NOT NULL ,
    [SupplierID] varchar(10)  NULL ,
    [ProductDescription] varchar(5000)  NULL ,
    [Category] varchar(50)  NULL ,
    [Cost] decimal  NULL ,
    [Price] decimal  NULL ,
    [StockQuantity] int  NULL ,
    [Status] varchar(15)  NOT NULL ,
    CONSTRAINT [PK_PRODUCT] PRIMARY KEY CLUSTERED (
        [ProductID] ASC
    )
)

CREATE TABLE [LINEITEM] (
    [OrderID] varchar(10)  NOT NULL ,
    [ProductID] varchar(10)  NOT NULL ,
    [Quantity] int  NOT NULL ,
    [LineTotal] decimal  NOT NULL 
)

ALTER TABLE [EMPLOYEE] WITH CHECK ADD CONSTRAINT [FK_EMPLOYEE_PositionID] FOREIGN KEY([PositionID])
REFERENCES [POSITION] ([PositionID])

ALTER TABLE [EMPLOYEE] CHECK CONSTRAINT [FK_EMPLOYEE_PositionID]

ALTER TABLE [EMPLOYEE] WITH CHECK ADD CONSTRAINT [FK_EMPLOYEE_ManagerID] FOREIGN KEY([ManagerID])
REFERENCES [EMPLOYEE] ([EmployeeID])

ALTER TABLE [EMPLOYEE] CHECK CONSTRAINT [FK_EMPLOYEE_ManagerID]

ALTER TABLE [ORDERS] WITH CHECK ADD CONSTRAINT [FK_ORDER_EmployeeID] FOREIGN KEY([EmployeeID])
REFERENCES [EMPLOYEE] ([EmployeeID])

ALTER TABLE [ORDERS] CHECK CONSTRAINT [FK_ORDER_EmployeeID]

ALTER TABLE [ORDERS] WITH CHECK ADD CONSTRAINT [FK_ORDER_CustomerID] FOREIGN KEY([CustomerID])
REFERENCES [CUSTOMER] ([CustomerID])

ALTER TABLE [ORDERS] CHECK CONSTRAINT [FK_ORDER_CustomerID]

ALTER TABLE [PRODUCT] WITH CHECK ADD CONSTRAINT [FK_PRODUCT_SupplierID] FOREIGN KEY([SupplierID])
REFERENCES [SUPPLIER] ([SupplierID])

ALTER TABLE [PRODUCT] CHECK CONSTRAINT [FK_PRODUCT_SupplierID]

ALTER TABLE [LINEITEM] WITH CHECK ADD CONSTRAINT [FK_LINEITEM_OrderID] FOREIGN KEY([OrderID])
REFERENCES [ORDERS] ([OrderID])

ALTER TABLE [LINEITEM] CHECK CONSTRAINT [FK_LINEITEM_OrderID]

ALTER TABLE [LINEITEM] WITH CHECK ADD CONSTRAINT [FK_LINEITEM_ProductID] FOREIGN KEY([ProductID])
REFERENCES [PRODUCT] ([ProductID])

ALTER TABLE [LINEITEM] CHECK CONSTRAINT [FK_LINEITEM_ProductID]