USE global_fashion_retail;
CREATE OR REPLACE VIEW vw_clean_customers AS
SELECT
    Customer_ID,
    TRIM(Name) AS Customer_Name,
    LOWER(TRIM(Email)) AS Email,
    TRIM(Telephone) AS Telephone,
    TRIM(City) AS City,
    TRIM(Country) AS Country,
    UPPER(TRIM(Gender)) AS Gender,
    CAST(Date_Of_Birth AS DATE) AS Date_Of_Birth,
    COALESCE(NULLIF(TRIM(Job_Title), ''), 'Unknown') AS Job_Title
FROM customers;

CREATE OR REPLACE VIEW vw_clean_products AS
SELECT
    Product_ID,
    TRIM(Category) AS Category,
    TRIM(Sub_Category) AS Sub_Category,
    TRIM(Description_EN) AS Product_Description,
    COALESCE(NULLIF(TRIM(Color), ''), 'Not Specified') AS Color,
    COALESCE(NULLIF(TRIM(Sizes), ''), 'Not Applicable') AS Sizes,
    Production_Cost
FROM products;

CREATE OR REPLACE VIEW vw_clean_stores AS
SELECT
    Store_ID,
    TRIM(Country) AS Country,
    TRIM(City) AS City,
    TRIM(Store_Name) AS Store_Name,
    Number_of_Employees,
    ZIP_Code,
    Latitude,
    Longitude
FROM stores;

CREATE OR REPLACE VIEW vw_clean_employees AS
SELECT
    Employee_ID,
    Store_ID,
    TRIM(Name) AS Employee_Name,
    TRIM(Position) AS Position
FROM employees;

CREATE OR REPLACE VIEW vw_clean_discounts AS
SELECT
    CAST(`Start` AS DATE) AS Start_Date,
    CAST(`End` AS DATE) AS End_Date,
    Discont AS Discount_Rate,
    TRIM(Description) AS Promotion_Description,

    COALESCE(
        NULLIF(TRIM(Category), ''),
        'All Categories'
    ) AS Category,

    COALESCE(
        NULLIF(TRIM(Sub_Category), ''),
        'All Subcategories'
    ) AS Sub_Category

FROM discounts;

CREATE OR REPLACE VIEW vw_clean_transactions AS
SELECT
    TRIM(Invoice_ID) AS Invoice_ID,
    `Line`,
    Customer_ID,
    Product_ID,

    COALESCE(
        NULLIF(TRIM(Size), ''),
        'Not Applicable'
    ) AS Size,

    COALESCE(
        NULLIF(TRIM(Color), ''),
        'Not Specified'
    ) AS Color,

    Unit_Price,
    Quantity,
    `Date` AS Transaction_Date,
    Discount,
    Line_Total,
    Store_ID,
    Employee_ID,
    UPPER(TRIM(Currency)) AS Currency,
    TRIM(Currency_Symbol) AS Currency_Symbol,
    TRIM(SKU) AS SKU,
    TRIM(Transaction_Type) AS Transaction_Type,
    TRIM(Payment_Method) AS Payment_Method,
    Invoice_Total

FROM transactions;

SELECT * FROM vw_clean_customers LIMIT 10;
SELECT * FROM vw_clean_products LIMIT 10;
SELECT * FROM vw_clean_discounts LIMIT 10;
SELECT * FROM vw_clean_transactions LIMIT 10;





