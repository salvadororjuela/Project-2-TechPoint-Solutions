-- ============================================================
-- PROJECT 2 - TECHPOINT SOLUTIONS
-- PostgreSQL Data Load
--
-- Loads the approved synthetic dataset created specifically
-- for this portfolio project.
--
-- Run from the repository root with psql so that relative
-- paths used by \copy resolve to the data/ folder.
-- ============================================================

-- ============================================================
-- 01. CATEGORIES
-- ============================================================
INSERT INTO public.categories
    (categoryid, categoryname, description)
VALUES
    (1, 'Computing', ''),
    (2, 'Connectivity', ''),
    (3, 'Audio', ''),
    (4, 'Accessories', ''),
    (5, 'Storage', '');

-- ============================================================
-- 02. SUPPLIERS
-- ============================================================
INSERT INTO public.suppliers
    (supplierid, suppliername, contactname, phone, email)
VALUES
    (1, 'NorthStar Computing Supply', 'Daniel Brooks', '555-0101', 'daniel.brooks@example.com'),
    (2, 'Apex Network Solutions', 'Melissa Carter', '555-0102', 'melissa.carter@example.com'),
    (3, 'CoreLink Technologies', 'Jason Miller', '555-0103', 'jason.miller@example.com'),
    (4, 'PrimeTech Distribution', 'Rebecca Adams', '555-0104', 'rebecca.adams@example.com'),
    (5, 'Digital Edge Supply', 'Thomas Wilson', '555-0105', 'thomas.wilson@example.com'),
    (6, 'Vertex Hardware Group', 'Amanda Clark', '555-0106', 'amanda.clark@example.com'),
    (7, 'ConnectPro Equipment', 'Kevin Harris', '555-0107', 'kevin.harris@example.com'),
    (8, 'SoundWave Technology', 'Laura Mitchell', '555-0108', 'laura.mitchell@example.com'),
    (9, 'OfficeTech Distribution', 'Brian Anderson', '555-0109', 'brian.anderson@example.com'),
    (10, 'SecureNet Systems', 'Jennifer Turner', '555-0110', 'jennifer.turner@example.com'),
    (11, 'BrightTech Supplies', 'Steven Parker', '555-0111', 'steven.parker@example.com'),
    (12, 'FutureWave Electronics', 'Rachel Thompson', '555-0112', 'rachel.thompson@example.com');

-- ============================================================
-- 03. CUSTOMERS
-- ============================================================
CREATE TEMP TABLE customers_load (
    customerid integer,
    customertype varchar(20),
    customername varchar(100),
    email varchar(150),
    phone varchar(25),
    registrationdate date,
    status varchar(20)
);

\copy customers_load FROM 'data/Customers.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO public.customers
    (customerid, customertype, customername, email, phone, registrationdate, status)
SELECT
    customerid, customertype, customername, email, phone, registrationdate, status
FROM customers_load;

-- ============================================================
-- 04. EMPLOYEES
-- ============================================================
INSERT INTO public.employees
    (employeeid, firstname, lastname, role, email, hiredate)
VALUES
    (1, 'Alex', 'Morgan', 'Sales Representative', 'alex.morgan@test.techpoint.local', '2024-01-15'),
    (2, 'Jordan', 'Lee', 'Sales Representative', 'jordan.lee@test.techpoint.local', '2024-02-12'),
    (3, 'Taylor', 'Brooks', 'Sales Representative', 'taylor.brooks@test.techpoint.local', '2024-03-18'),
    (4, 'Casey', 'Rivera', 'Sales Representative', 'casey.rivera@test.techpoint.local', '2024-04-22'),
    (5, 'Morgan', 'Hayes', 'Sales Representative', 'morgan.hayes@test.techpoint.local', '2024-05-20');

-- ============================================================
-- 05. PRODUCTS
-- ============================================================
CREATE TEMP TABLE products_load (
    productid integer,
    sku varchar(30),
    productname varchar(100),
    categoryid integer,
    sellingprice numeric(12,2),
    status varchar(20)
);

\copy products_load FROM 'data/Products.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO public.products
    (productid, sku, productname, categoryid, sellingprice, status)
SELECT
    productid, sku, productname, categoryid, sellingprice, status
FROM products_load;

-- ============================================================
-- 06. PRODUCTSUPPLIERS
-- ============================================================
CREATE TEMP TABLE productsuppliers_load (
    productid integer,
    supplierid integer,
    supplierproductcode varchar(30),
    unitcost numeric(12,2),
    leadtimedays integer,
    isprimarysupplier boolean
);

\copy productsuppliers_load FROM 'data/ProductSuppliers.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO public.productsuppliers
    (productid, supplierid, supplierproductcode, unitcost, leadtimedays, isprimarysupplier)
SELECT
    productid, supplierid, supplierproductcode, unitcost, leadtimedays, isprimarysupplier
FROM productsuppliers_load;

-- ============================================================
-- 07. PURCHASES
-- ============================================================
CREATE TEMP TABLE purchases_load (
    purchaseid integer,
    supplierid integer,
    purchasedate date,
    purchasestatus varchar(20)
);

\copy purchases_load FROM 'data/Purchases.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO public.purchases
    (purchaseid, supplierid, purchasedate, purchasestatus)
SELECT
    purchaseid, supplierid, purchasedate, purchasestatus
FROM purchases_load;

-- ============================================================
-- 08. PURCHASEDETAILS
-- ============================================================
CREATE TEMP TABLE purchasedetails_load (
    purchasedetailid integer,
    purchaseid integer,
    productid integer,
    quantity integer,
    unitcost numeric(12,2)
);

\copy purchasedetails_load FROM 'data/PurchaseDetails.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO public.purchasedetails
    (purchasedetailid, purchaseid, productid, quantity, unitcost)
SELECT
    purchasedetailid, purchaseid, productid, quantity, unitcost
FROM purchasedetails_load;

-- ============================================================
-- 09. INVENTORY
-- ============================================================
CREATE TEMP TABLE inventory_load (
    inventoryid integer,
    productid integer,
    quantityonhand integer,
    reorderlevel integer,
    lastupdated date
);

\copy inventory_load FROM 'data/Inventory.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO public.inventory
    (inventoryid, productid, quantityonhand, reorderlevel, lastupdated)
SELECT
    inventoryid,
    productid,
    quantityonhand,
    reorderlevel,
    lastupdated::timestamp
FROM inventory_load;

-- ============================================================
-- 10. SALES
-- ============================================================
CREATE TEMP TABLE sales_load (
    saleid integer,
    customerid integer,
    employeeid integer,
    saledate date,
    paymentmethod varchar(30),
    salestatus varchar(20)
);

\copy sales_load FROM 'data/Sales.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO public.sales
    (saleid, customerid, employeeid, saledate, paymentmethod, salestatus)
SELECT
    saleid,
    customerid,
    employeeid,
    saledate::timestamp,
    paymentmethod,
    salestatus
FROM sales_load;

-- ============================================================
-- 11. SALEDETAILS
-- ============================================================
CREATE TEMP TABLE saledetails_load (
    saledetailid integer,
    saleid integer,
    productid integer,
    quantity integer,
    unitprice numeric(12,2)
);

\copy saledetails_load FROM 'data/SaleDetails.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO public.saledetails
    (saledetailid, saleid, productid, quantity, unitprice)
SELECT
    saledetailid, saleid, productid, quantity, unitprice
FROM saledetails_load;

-- ============================================================
-- 12. INVENTORYMOVEMENTS
-- ============================================================
CREATE TEMP TABLE inventorymovements_load (
    inventorymovementid integer,
    productid integer,
    movementdate timestamp without time zone,
    movementtype varchar(30),
    quantity integer,
    purchasedetailid integer,
    saledetailid integer,
    notes varchar(255)
);

\copy inventorymovements_load FROM 'data/InventoryMovements.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO public.inventorymovements
    (inventorymovementid, productid, movementdate, movementtype, quantity,
     purchasedetailid, saledetailid, notes)
SELECT
    inventorymovementid,
    productid,
    movementdate,
    movementtype,
    CASE
        WHEN movementtype = 'Sale' THEN ABS(quantity)
        ELSE quantity
    END AS quantity,
    purchasedetailid,
    saledetailid,
    notes
FROM inventorymovements_load;

-- ============================================================
-- 13. IDENTITY SEQUENCE SYNCHRONIZATION
-- ============================================================
SELECT setval(pg_get_serial_sequence('public.categories', 'categoryid'),
              (SELECT MAX(categoryid) FROM public.categories));

SELECT setval(pg_get_serial_sequence('public.suppliers', 'supplierid'),
              (SELECT MAX(supplierid) FROM public.suppliers));

SELECT setval(pg_get_serial_sequence('public.customers', 'customerid'),
              (SELECT MAX(customerid) FROM public.customers));

SELECT setval(pg_get_serial_sequence('public.employees', 'employeeid'),
              (SELECT MAX(employeeid) FROM public.employees));

SELECT setval(pg_get_serial_sequence('public.products', 'productid'),
              (SELECT MAX(productid) FROM public.products));

SELECT setval(pg_get_serial_sequence('public.purchases', 'purchaseid'),
              (SELECT MAX(purchaseid) FROM public.purchases));

SELECT setval(pg_get_serial_sequence('public.purchasedetails', 'purchasedetailid'),
              (SELECT MAX(purchasedetailid) FROM public.purchasedetails));

SELECT setval(pg_get_serial_sequence('public.inventory', 'inventoryid'),
              (SELECT MAX(inventoryid) FROM public.inventory));

SELECT setval(pg_get_serial_sequence('public.sales', 'saleid'),
              (SELECT MAX(saleid) FROM public.sales));

SELECT setval(pg_get_serial_sequence('public.saledetails', 'saledetailid'),
              (SELECT MAX(saledetailid) FROM public.saledetails));

SELECT setval(pg_get_serial_sequence('public.inventorymovements', 'inventorymovementid'),
              (SELECT MAX(inventorymovementid) FROM public.inventorymovements));
