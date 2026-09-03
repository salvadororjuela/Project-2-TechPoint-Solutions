-- ============================================================
-- PROJECT 2 - TECHPOINT SOLUTIONS
-- PostgreSQL Database Validation
--
-- Reproducible checks for the final approved database.
-- The dataset is synthetic and was created specifically
-- for this portfolio project.
-- ============================================================

-- ============================================================
-- 01. TABLE INVENTORY
-- ============================================================
SELECT
    tablename
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;

-- ============================================================
-- 02. RECORD COUNTS
-- ============================================================
SELECT 'categories' AS table_name, COUNT(*) AS record_count FROM public.categories
UNION ALL SELECT 'customers', COUNT(*) FROM public.customers
UNION ALL SELECT 'employees', COUNT(*) FROM public.employees
UNION ALL SELECT 'suppliers', COUNT(*) FROM public.suppliers
UNION ALL SELECT 'products', COUNT(*) FROM public.products
UNION ALL SELECT 'productsuppliers', COUNT(*) FROM public.productsuppliers
UNION ALL SELECT 'purchases', COUNT(*) FROM public.purchases
UNION ALL SELECT 'purchasedetails', COUNT(*) FROM public.purchasedetails
UNION ALL SELECT 'inventory', COUNT(*) FROM public.inventory
UNION ALL SELECT 'sales', COUNT(*) FROM public.sales
UNION ALL SELECT 'saledetails', COUNT(*) FROM public.saledetails
UNION ALL SELECT 'inventorymovements', COUNT(*) FROM public.inventorymovements
ORDER BY table_name;

-- ============================================================
-- 03. PRIMARY KEY / DUPLICATE CHECKS
-- ============================================================
SELECT 'customers' AS table_name, COUNT(*) - COUNT(DISTINCT customerid) AS duplicate_keys
FROM public.customers
UNION ALL SELECT 'employees', COUNT(*) - COUNT(DISTINCT employeeid) FROM public.employees
UNION ALL SELECT 'products', COUNT(*) - COUNT(DISTINCT productid) FROM public.products
UNION ALL SELECT 'purchases', COUNT(*) - COUNT(DISTINCT purchaseid) FROM public.purchases
UNION ALL SELECT 'purchasedetails', COUNT(*) - COUNT(DISTINCT purchasedetailid) FROM public.purchasedetails
UNION ALL SELECT 'inventory', COUNT(*) - COUNT(DISTINCT inventoryid) FROM public.inventory
UNION ALL SELECT 'sales', COUNT(*) - COUNT(DISTINCT saleid) FROM public.sales
UNION ALL SELECT 'saledetails', COUNT(*) - COUNT(DISTINCT saledetailid) FROM public.saledetails
UNION ALL SELECT 'inventorymovements', COUNT(*) - COUNT(DISTINCT inventorymovementid)
FROM public.inventorymovements;

-- Composite key check for ProductSuppliers.
SELECT COUNT(*) - COUNT(DISTINCT (productid, supplierid)) AS duplicate_composite_keys
FROM public.productsuppliers;

-- ============================================================
-- 04. FOREIGN KEY ORPHAN CHECKS
-- ============================================================
SELECT COUNT(*) AS orphan_products_category
FROM public.products p
LEFT JOIN public.categories c ON c.categoryid = p.categoryid
WHERE c.categoryid IS NULL;

SELECT COUNT(*) AS orphan_productsuppliers_product
FROM public.productsuppliers ps
LEFT JOIN public.products p ON p.productid = ps.productid
WHERE p.productid IS NULL;

SELECT COUNT(*) AS orphan_productsuppliers_supplier
FROM public.productsuppliers ps
LEFT JOIN public.suppliers s ON s.supplierid = ps.supplierid
WHERE s.supplierid IS NULL;

SELECT COUNT(*) AS orphan_purchases_supplier
FROM public.purchases pu
LEFT JOIN public.suppliers s ON s.supplierid = pu.supplierid
WHERE s.supplierid IS NULL;

SELECT COUNT(*) AS orphan_purchasedetails_purchase
FROM public.purchasedetails pd
LEFT JOIN public.purchases pu ON pu.purchaseid = pd.purchaseid
WHERE pu.purchaseid IS NULL;

SELECT COUNT(*) AS orphan_purchasedetails_product
FROM public.purchasedetails pd
LEFT JOIN public.products p ON p.productid = pd.productid
WHERE p.productid IS NULL;

SELECT COUNT(*) AS orphan_sales_customer
FROM public.sales s
LEFT JOIN public.customers c ON c.customerid = s.customerid
WHERE c.customerid IS NULL;

SELECT COUNT(*) AS orphan_sales_employee
FROM public.sales s
LEFT JOIN public.employees e ON e.employeeid = s.employeeid
WHERE e.employeeid IS NULL;

SELECT COUNT(*) AS orphan_saledetails_sale
FROM public.saledetails sd
LEFT JOIN public.sales s ON s.saleid = sd.saleid
WHERE s.saleid IS NULL;

SELECT COUNT(*) AS orphan_saledetails_product
FROM public.saledetails sd
LEFT JOIN public.products p ON p.productid = sd.productid
WHERE p.productid IS NULL;

SELECT COUNT(*) AS orphan_inventory_product
FROM public.inventory i
LEFT JOIN public.products p ON p.productid = i.productid
WHERE p.productid IS NULL;

SELECT COUNT(*) AS orphan_inventorymovements_product
FROM public.inventorymovements im
LEFT JOIN public.products p ON p.productid = im.productid
WHERE p.productid IS NULL;

SELECT COUNT(*) AS orphan_inventorymovements_purchase_detail
FROM public.inventorymovements im
LEFT JOIN public.purchasedetails pd
    ON pd.purchasedetailid = im.purchasedetailid
WHERE im.purchasedetailid IS NOT NULL
  AND im.purchasedetailid <> 0
  AND pd.purchasedetailid IS NULL;

SELECT COUNT(*) AS orphan_inventorymovements_sale_detail
FROM public.inventorymovements im
LEFT JOIN public.saledetails sd
    ON sd.saledetailid = im.saledetailid
WHERE im.saledetailid IS NOT NULL
  AND im.saledetailid <> 0
  AND sd.saledetailid IS NULL;

-- ============================================================
-- 05. BUSINESS RULE CHECKS

-- Additional approved CHECK-rule validations
SELECT 'Customers.CustomerType allowed values' AS check_name,
       COUNT(*) AS violations
FROM public.customers
WHERE customertype NOT IN ('Individual', 'Business');

SELECT 'Customers.Status allowed values' AS check_name,
       COUNT(*) AS violations
FROM public.customers
WHERE status NOT IN ('Active', 'Inactive');

SELECT 'Suppliers.Status allowed values' AS check_name,
       COUNT(*) AS violations
FROM public.suppliers
WHERE status NOT IN ('Active', 'Inactive');

SELECT 'Products.Status allowed values' AS check_name,
       COUNT(*) AS violations
FROM public.products
WHERE status NOT IN ('Active', 'Inactive');

SELECT 'Purchases.PurchaseStatus allowed values' AS check_name,
       COUNT(*) AS violations
FROM public.purchases
WHERE purchasestatus NOT IN ('Pending', 'Received', 'Cancelled');

SELECT 'Sales.PaymentMethod allowed values' AS check_name,
       COUNT(*) AS violations
FROM public.sales
WHERE paymentmethod NOT IN ('Cash', 'Credit Card', 'Debit Card', 'Bank Transfer');

SELECT 'Sales.SaleStatus allowed values' AS check_name,
       COUNT(*) AS violations
FROM public.sales
WHERE salestatus NOT IN ('Completed', 'Cancelled');

SELECT 'ProductSuppliers.UnitCost >= 0' AS check_name,
       COUNT(*) AS violations
FROM public.productsuppliers
WHERE unitcost < 0;

SELECT 'ProductSuppliers.LeadTimeDays >= 0' AS check_name,
       COUNT(*) AS violations
FROM public.productsuppliers
WHERE leadtimedays < 0;

-- ============================================================
SELECT COUNT(*) AS invalid_product_categories
FROM public.products
WHERE categoryid IS NULL;

SELECT COUNT(*) AS invalid_product_prices
FROM public.products
WHERE sellingprice < 0;

SELECT COUNT(*) AS invalid_purchase_quantities
FROM public.purchasedetails
WHERE quantity <= 0;

SELECT COUNT(*) AS invalid_purchase_costs
FROM public.purchasedetails
WHERE unitcost < 0;

SELECT COUNT(*) AS invalid_sale_quantities
FROM public.saledetails
WHERE quantity <= 0;

SELECT COUNT(*) AS invalid_sale_prices
FROM public.saledetails
WHERE unitprice < 0;

SELECT COUNT(*) AS invalid_inventory_values
FROM public.inventory
WHERE quantityonhand < 0 OR reorderlevel < 0;

SELECT COUNT(*) AS invalid_movement_quantities
FROM public.inventorymovements
WHERE quantity <= 0;

SELECT COUNT(*) AS invalid_movement_types
FROM public.inventorymovements
WHERE movementtype NOT IN (
    'Purchase Receipt',
    'Sale',
    'Inventory Increase',
    'Inventory Decrease',
    'Return'
);

-- ============================================================
-- 06. UNIQUE BUSINESS RULES
-- ============================================================
SELECT COUNT(*) AS duplicate_skus
FROM (
    SELECT sku
    FROM public.products
    GROUP BY sku
    HAVING COUNT(*) > 1
) d;

SELECT COUNT(*) AS products_with_multiple_primary_suppliers
FROM (
    SELECT productid
    FROM public.productsuppliers
    WHERE isprimarysupplier = TRUE
    GROUP BY productid
    HAVING COUNT(*) > 1
) d;

SELECT COUNT(*) AS duplicate_inventory_products
FROM (
    SELECT productid
    FROM public.inventory
    GROUP BY productid
    HAVING COUNT(*) > 1
) d;

-- ============================================================
-- 07. INVENTORY MOVEMENT NORMALIZATION
-- ============================================================
SELECT
    movementtype,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    COUNT(*) AS record_count
FROM public.inventorymovements
GROUP BY movementtype
ORDER BY movementtype;

-- Sales movements are stored with positive quantities;
-- MovementType determines the inventory direction.
SELECT COUNT(*) AS invalid_negative_sale_movements
FROM public.inventorymovements
WHERE movementtype = 'Sale'
  AND quantity < 0;

-- ============================================================
-- 08. FINAL DATASET EXPECTATIONS
-- ============================================================
SELECT
    (SELECT COUNT(*) FROM public.categories) AS categories,
    (SELECT COUNT(*) FROM public.customers) AS customers,
    (SELECT COUNT(*) FROM public.employees) AS employees,
    (SELECT COUNT(*) FROM public.suppliers) AS suppliers,
    (SELECT COUNT(*) FROM public.products) AS products,
    (SELECT COUNT(*) FROM public.productsuppliers) AS productsuppliers,
    (SELECT COUNT(*) FROM public.purchases) AS purchases,
    (SELECT COUNT(*) FROM public.purchasedetails) AS purchasedetails,
    (SELECT COUNT(*) FROM public.inventory) AS inventory,
    (SELECT COUNT(*) FROM public.sales) AS sales,
    (SELECT COUNT(*) FROM public.saledetails) AS saledetails,
    (SELECT COUNT(*) FROM public.inventorymovements) AS inventorymovements;
