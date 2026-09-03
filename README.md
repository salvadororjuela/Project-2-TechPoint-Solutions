# PROJECT 2 — TECHPOINT SOLUTIONS
## Small Business Sales & Inventory Database

## Executive Summary

TechPoint Solutions is a portfolio project that demonstrates the design and implementation of a relational sales and inventory database solution for a small technology business.

The project follows a controlled end-to-end workflow, from business requirements and relational data modeling to implementation in Microsoft Access and PostgreSQL, controlled data migration, and validation.

The solution focuses on data integrity, relational modeling, operational usability, reproducibility, and consistency between the Access and PostgreSQL implementations.

Dataset Notice: All data in this repository are synthetic and were specifically created and controlled for portfolio demonstration purposes. They do not represent real TechPoint Solutions customer, supplier, employee, or transaction data.

## Project Files

The repository includes the main files and evidence required to review the database solution and reproduce its PostgreSQL implementation.

### Microsoft Access

- [TechPoint_Solutions.accdb](access/TechPoint_Solutions.accdb) — Complete Microsoft Access database implementation, including the relational model, operational forms, queries, and reports.

### PostgreSQL

- [01_create_tables.sql](database/01_create_tables.sql) — Creates the relational database structure and integrity constraints.
- [02_load_data.sql](database/02_load_data.sql) — Loads the controlled synthetic dataset into PostgreSQL.
- [03_validate_database.sql](database/03_validate_database.sql) — Provides reproducible database and data-integrity validation.

### Controlled Synthetic Dataset

The repository includes nine CSV files used for controlled data loading and reproducibility:

- [Customers.csv](data/Customers.csv)
- [Products.csv](data/Products.csv)
- [ProductSuppliers.csv](data/ProductSuppliers.csv)
- [Purchases.csv](data/Purchases.csv)
- [PurchaseDetails.csv](data/PurchaseDetails.csv)
- [Inventory.csv](data/Inventory.csv)
- [Sales.csv](data/Sales.csv)
- [SaleDetails.csv](data/SaleDetails.csv)
- [InventoryMovements.csv](data/InventoryMovements.csv)

### Evidence & Screenshots

Selected screenshots document the implemented Access solution, including:

- [Entity Relationship Diagram](screenshots/TechPoint_ERD_Audit_2026-08-17.png)
- [frmSales](screenshots/frmSales_Form.png)
- [frmPurchases](screenshots/frmPurchases_Form.png)
- [rptSalesDetail](screenshots/rptSalesDetails.png)
- [rptPurchaseDetail](screenshots/rptPurchaseDetail.png)
- [rptInventoryStatus](screenshots/rptInventoryStatus.png)
- [rptInventoryReconciliation](screenshots/rptInventoryReconciliation.png)
- [rptReturnsAnalysis](screenshots/rptReturnsAnalysis.png)

The screenshots provide visual evidence of the database structure, operational forms, and reporting layer.

## Business Problem

TechPoint Solutions is a small technology and accessories retailer serving individual consumers and small businesses from one physical store with a storage area.

The business needs a centralized way to organize and manage operational information across:

- Customers and sales representatives
- Products and categories
- Suppliers and product–supplier relationships
- Purchases and purchase details
- Sales and sale details
- Current inventory
- Inventory movements and returns

The database should reduce duplicated or inconsistent information and make operational data easier to query, maintain, and use.

The project therefore focuses on creating a structured relational database foundation that supports these operational processes while maintaining clear relationships and data integrity.

## Project Objectives

The project was designed to:

- Design a focused and explainable relational database model for a small technology and accessories business.
- Establish clear relationships and integrity rules across customers, employees, products, categories, suppliers, purchases, sales, inventory, and inventory movements.
- Implement the approved database model in Microsoft Access with operational forms, queries, and reports.
- Implement the equivalent relational model in PostgreSQL.
- Create and use a controlled synthetic dataset covering 12 months of operational transactions.
- Perform a controlled Access-to-PostgreSQL data migration, preserving source identifiers and maintaining data consistency.
- Validate record counts, relationships, business rules, inventory balances, and cross-platform results.
- Document the completed solution as a reproducible portfolio case study.

## Database Model

The database was designed as a Third Normal Form (3NF) relational database (relational model designed according to normalization principles) for the core operational processes of TechPoint Solutions.

The final model contains 12 entities and 14 approved relationships, covering customers, employees, products, categories, suppliers, purchases, sales, inventory, and inventory movements.

Key modeling elements include:

- Primary and foreign keys to maintain referential integrity.
- Many-to-many relationships resolved through associative entities, including:
  - Products ↔ Suppliers through ProductSuppliers.
  - Sales ↔ Products through SaleDetails.
  - Purchases ↔ Products through PurchaseDetails.
- A composite primary key in ProductSuppliers to uniquely identify each product–supplier combination.
- A one-to-one relationship between Products and Inventory.
- Header-detail relationships for purchases and sales.
- Business rules implemented through appropriate constraints and data types.
- InventoryMovements modeled separately to maintain a traceable history of inventory activity.

### Entity Relationship Diagram

The Entity Relationship Diagram (ERD) provides a visual representation of the final relational database model, including the 12 entities, their primary and foreign keys, and the approved relationships between them.

The diagram was used to review and validate the relational structure before and during implementation in Microsoft Access and PostgreSQL.

## Technology Stack

| Technology | Role in the Project |
|---|---|
| Microsoft Access | Operational database implementation, forms, queries, and reports |
| PostgreSQL | Relational database implementation and controlled data migration target |
| pgAdmin 4 | PostgreSQL database administration and management |
| SQL | Database creation, data loading, integrity constraints, and validation |
| CSV | Controlled data exchange and reproducible PostgreSQL loading |
| Microsoft Excel | Controlled synthetic dataset design, reconciliation, and data preparation |

## Controlled Synthetic Dataset

The project uses a controlled synthetic dataset specifically created for portfolio demonstration purposes. The data were designed to represent approximately 12 months of operational activity for TechPoint Solutions and to support the relationships and business rules defined in the relational model.

The dataset includes nine CSV files:

| Dataset | Records |
|---|---:|
| Customers | 100 |
| Products | 57 |
| ProductSuppliers | 100 |
| Purchases | 200 |
| PurchaseDetails | 474 |
| Inventory | 57 |
| Sales | 1,200 |
| SaleDetails | 1,590 |
| InventoryMovements | 1,837 |

The dataset was controlled before database implementation to ensure consistency between purchases, sales, returns, inventory movements, and final inventory balances.

The CSV files are included in this repository to support reproducible PostgreSQL loading and validation.

Synthetic Data Notice: These datasets are fictional and do not contain real customer, supplier, employee, sales, purchase, or inventory information.

## Access Database Solution

The Microsoft Access implementation provides a functional operational database environment built from the approved relational model.

The solution includes operational forms, queries, and reports designed to support sales, purchases, inventory management, reconciliation, and returns.

### Forms

**frmSales**

Operational form for recording and managing sales transactions and their related details.

**frmPurchases**

Operational form for recording and managing purchase transactions and their related details.

### Queries

The Access solution includes the following validated operational queries:

- qrySalesDetail
- qryPurchaseDetail
- qryInventoryStatus
- qryInventoryMovementHistory
- qryInventoryReconciliation
- qryReturnsAnalysis

These queries provide reusable operational views of the underlying relational data and support the reporting layer.

### Reports

The validated Access reports include:

- rptSalesDetail
- rptPurchaseDetail
- rptProductList
- rptInventoryStatus
- rptInventoryMovementHistory
- rptInventoryReconciliation
- rptReturnsAnalysis

The reports provide structured operational information for sales, purchases, products, inventory, inventory movements, reconciliation, and returns.

The Access forms, queries, and reports were functionally validated before the PostgreSQL implementation and controlled data migration.

### Evidence

The repository includes selected screenshots of the Access implementation to demonstrate the operational interface, relational model, and reporting layer.

## PostgreSQL Implementation

The PostgreSQL implementation is organized into three reproducible SQL scripts:

database/

├── 01_create_tables.sql
├── 02_load_data.sql
└── 03_validate_database.sql

### 01_create_tables.sql

Creates the approved relational structure, including:

- Tables
- Primary keys
- Foreign keys
- Unique constraints
- Check constraints
- Defaults
- Indexes
- Approved relationships

### 02_load_data.sql

Loads the controlled synthetic dataset using:

- CSV-based loading
- Staging tables where appropriate
- Preserved source identifiers
- Referentially ordered loading
- Inventory movement normalization
- Sequence synchronization

### 03_validate_database.sql

Provides reproducible validation of:

- Table structure
- Record counts
- Primary key integrity
- Duplicate records
- Foreign key integrity
- Business rules
- Unique constraints
- Check constraints
- Inventory movement rules
- Sequence status

The final PostgreSQL implementation contains 12 relational tables and was validated against the approved database model and controlled synthetic dataset.

## Data Migration & Validation

### Data Migration Workflow

The migration workflow was designed to preserve data consistency between the Access and PostgreSQL implementations:

Controlled Dataset
↓
Microsoft Access
↓
Controlled Extraction
↓
CSV / Staging
↓
PostgreSQL
↓
Post-load Validation
↓
Cross-platform Validation

Source identifiers were preserved during migration so that records could be traced and reconciled across platforms.

The migration process also included referentially ordered loading, controlled staging, inventory movement normalization, and sequence synchronization where required.

### Validation

The final database solution was validated through multiple controls, including:

- Record-count reconciliation
- Primary-key validation
- Duplicate detection
- Foreign-key orphan checks
- Allowed-value validation
- Quantity and price rules
- Product–supplier rules
- Inventory movement normalization
- Sequence synchronization
- Cross-platform consistency checks

The final controlled dataset contains:

57 products · 12 suppliers · 100 product-supplier relationships · 200 purchases · 474 purchase details · 1,200 sales · 1,590 sale details · 1,837 inventory movements · 57 inventory records.

The validation process confirmed consistency between the source Access implementation and the PostgreSQL database.

## Database Quality Assurance

The database solution was subjected to structured quality assurance checks to verify data integrity, relational consistency, and adherence to defined business rules.

Quality assurance controls included:

- Primary key integrity — verification of unique and non-null identifiers.
- Foreign key integrity — identification of orphan records and invalid relationships.
- Duplicate detection — verification of unintended duplicate records.
- Unique constraint validation — verification of fields and combinations required to remain unique.
- Check constraint validation — verification of allowed values and defined field-level rules.
- Business rule validation — verification of quantities, prices, transaction statuses, and other defined operational rules.
- Inventory consistency — validation of inventory records and inventory movement logic.
- Product–supplier integrity — validation of product–supplier relationships and associative records.
- Sequence synchronization — verification that PostgreSQL sequences remained aligned with explicitly loaded identifiers.
- Cross-platform consistency — comparison of relevant results between Microsoft Access and PostgreSQL.

The quality assurance process was designed to identify structural, relational, and data-level inconsistencies before considering the database solution complete.

The final implementation passed the defined validation controls and provides a consistent relational database foundation for the project's operational requirements.

## Operational Reporting

The Microsoft Access solution includes a set of operational reports designed to present structured information from the relational database.

The reports provide visibility into key operational areas, including:

- Sales transactions and sales details
- Purchase transactions and purchase details
- Product information
- Current inventory status
- Inventory movement history
- Inventory reconciliation
- Product returns

The validated reports include:

- rptSalesDetail
- rptPurchaseDetail
- rptProductList
- rptInventoryStatus
- rptInventoryMovementHistory
- rptInventoryReconciliation
- rptReturnsAnalysis

These reports are supported by the validated operational queries and demonstrate how the relational database can be used to generate structured outputs for day-to-day operational review.

The reporting layer focuses on operational visibility and data consistency, rather than advanced business intelligence or analytical dashboards.

## Project Scope & Limitations

This project focuses on the design, implementation, migration, and validation of a relational sales and inventory database solution for a small technology business.

The project scope includes:

- Relational database design and normalization
- Microsoft Access implementation
- Operational forms, queries, and reports
- PostgreSQL implementation
- Controlled synthetic data preparation
- Access-to-PostgreSQL data migration
- Data integrity and business-rule validation
- Cross-platform consistency checks
- Reproducible SQL-based database implementation

The project does not aim to represent a complete enterprise information system or production-scale retail platform.

Advanced business intelligence, interactive dashboards, predictive analytics, and advanced sales-performance analysis are outside the scope of this project and are addressed separately in Project 3 — Sales Performance & Inventory Analytics.

The dataset is synthetic and was created specifically for portfolio demonstration purposes. Therefore, the project demonstrates the technical design and validation of a controlled database solution, rather than the performance of a live production system with real business users and transactions.

## Tools & Technologies

The project demonstrates practical experience with the following tools and technologies:

- Microsoft Access — relational database implementation, operational forms, queries, and reports.
- PostgreSQL — relational database implementation, SQL-based loading, constraints, and validation.
- pgAdmin 4 — PostgreSQL database administration and management.
- SQL — database creation, data loading, integrity controls, and validation.
- Microsoft Excel — controlled synthetic dataset preparation and reconciliation.
- CSV — controlled data exchange and reproducible data loading.

The combination of these tools supports an end-to-end workflow covering relational database design, operational implementation, controlled data migration, data integrity, and validation.

## Project Outcome

The project resulted in a controlled, relational database solution implemented across Microsoft Access and PostgreSQL, with operational interfaces, reporting, reproducible SQL scripts, controlled synthetic data, and documented validation procedures.

The solution demonstrates the ability to move from a business requirement to a structured database implementation while maintaining data integrity, traceability, and reproducibility.

## Skills Demonstrated

- Relational database design
- Entity–relationship modeling
- Data normalization
- Microsoft Access database development
- PostgreSQL
- SQL
- Data migration
- Referential integrity
- Data validation
- Inventory reconciliation
- Operational reporting
- Controlled synthetic data design
- Cross-platform database validation

## Note on Portfolio Scope

This project demonstrates database and information-management capabilities.

Advanced sales analytics, KPIs, business insights, and interactive BI are addressed separately in Project 3 — Sales Performance & Inventory Analytics.
