-- Create ProductTable
CREATE TABLE ProductTable (
    ProductId INTEGER PRIMARY KEY,
    ProductType TEXT,
    Product TEXT,
    Type TEXT
);

-- Create LocationTable
CREATE TABLE LocationTable (
    AreaCode INTEGER PRIMARY KEY,
    State TEXT,
    Market TEXT,
    MarketSize TEXT
);

-- Create FactTable
CREATE TABLE FactTable (
    Date TEXT,
    ProductId INTEGER,
    Profit INTEGER,
    Sales INTEGER,
    Margin INTEGER,
    COGS INTEGER,
    TotalExpenses INTEGER,
    Marketing INTEGER,
    Inventory INTEGER,
    BudgetProfit INTEGER,
    BudgetCOGS INTEGER,
    BudgetMargin INTEGER,
    BudgetSales INTEGER,
    AreaCode INTEGER,
    FOREIGN KEY (ProductId) REFERENCES ProductTable(ProductId),
    FOREIGN KEY (AreaCode) REFERENCES LocationTable(AreaCode)
);
