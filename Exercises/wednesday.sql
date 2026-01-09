-- =========================================================
-- DIMENSIONAL MODEL SOLUTION - GAMEZONE
-- =========================================================


USE SCHEMA GOLD;

-- -------------------------
-- TASK 3: DIM_DATE
-- -------------------------
CREATE OR REPLACE TABLE DIM_DATE AS
SELECT
    TO_NUMBER(TO_CHAR(d, 'YYYYMMDD')) AS date_key,
    d AS full_date,
    DAY(d) AS day_of_month,
    DAYOFWEEK(d) AS day_of_week,
    DAYNAME(d) AS day_name,
    MONTH(d) AS month_num,
    MONTHNAME(d) AS month_name,
    QUARTER(d) AS quarter,
    YEAR(d) AS year,
    CASE WHEN DAYOFWEEK(d) IN (0, 6) THEN TRUE ELSE FALSE END AS is_weekend
FROM (
    SELECT DATEADD('day', SEQ4(), '2020-01-01')::DATE AS d
    FROM TABLE(GENERATOR(ROWCOUNT => 2191))
);

-- Quick check
SELECT * FROM DIM_DATE WHERE year = 2024 LIMIT 10;

-- -------------------------
-- TASK 4: DIM_CUSTOMER
-- -------------------------
CREATE OR REPLACE TABLE DIM_CUSTOMER (
    customer_key INTEGER AUTOINCREMENT PRIMARY KEY,
    customer_id STRING,
    customer_name STRING,
    loyalty_tier STRING,
    city STRING,
    state STRING,
    country STRING,
    registration_date DATE,
    effective_date DATE DEFAULT CURRENT_DATE(),
    is_current BOOLEAN DEFAULT TRUE
);

INSERT INTO DIM_CUSTOMER (customer_id, customer_name, loyalty_tier, city, state, country, registration_date)
VALUES
    ('C001', 'John Smith', 'Gold',   'New York',     'NY', 'USA', '2023-01-15'),
    ('C002', 'Jane Doe',   'Silver', 'Los Angeles',  'CA', 'USA', '2023-03-20'),
    ('C003', 'Bob Wilson', 'Bronze', 'Chicago',      'IL', 'USA', '2023-06-01'),
    ('C004', 'Ava Patel',  'Gold',   'Austin',       'TX', 'USA', '2023-09-11'),
    ('C005', 'Noah Kim',   'Silver', 'Seattle',      'WA', 'USA', '2023-10-05');


CREATE OR REPLACE TABLE DIM_PRODUCT (
    product_key INTEGER AUTOINCREMENT PRIMARY KEY,
    product_id STRING,
    product_name STRING,
    category STRING,
    subcategory STRING,
    publisher STRING,
    release_date DATE,
    list_price DECIMAL(10,2),
    effective_date DATE DEFAULT CURRENT_DATE(),
    is_current BOOLEAN DEFAULT TRUE
);

INSERT INTO DIM_PRODUCT (product_id, product_name, category, subcategory, publisher, release_date, list_price)
VALUES
    ('P001', 'Galaxy Raiders',     'Action',     'Shooter',     'NovaWorks',  '2023-11-10', 59.99),
    ('P002', 'Mystic Valley',      'RPG',        'Adventure',   'ElderByte',  '2022-09-22', 49.99),
    ('P003', 'Speed Circuit X',    'Racing',     'Arcade',      'TurboLab',   '2024-02-01', 39.99),
    ('P004', 'Castle Architect',   'Simulation', 'Builder',     'StonePeak',  '2021-06-15', 29.99),
    ('P005', 'Pro League 2024',    'Sports',     'Football',    'AthenaPlay', '2024-08-20', 69.99),
    ('P006', 'Dungeon Tactics',    'Strategy',   'Turn-based',  'HexForge',   '2020-03-05', 34.99);


CREATE OR REPLACE TABLE DIM_STORE (
    store_key INTEGER AUTOINCREMENT PRIMARY KEY,
    store_id STRING,
    store_name STRING,
    region STRING,
    country STRING,
    store_type STRING,  -- online/retail
    effective_date DATE DEFAULT CURRENT_DATE(),
    is_current BOOLEAN DEFAULT TRUE
);

INSERT INTO DIM_STORE (store_id, store_name, region, country, store_type)
VALUES
    ('S001', 'GameZone Online', 'North America', 'USA', 'online'),
    ('S002', 'GameZone NYC',    'North America', 'USA', 'retail'),
    ('S003', 'GameZone LA',     'North America', 'USA', 'retail'),
    ('S004', 'GameZone EU',     'Europe',        'UK',  'online');


CREATE OR REPLACE TABLE FCT_SALES (
    transaction_id STRING,
    date_key INTEGER,
    customer_key INTEGER,
    product_key INTEGER,
    store_key INTEGER,
    quantity INTEGER,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    revenue DECIMAL(12,2),
    discount_amount DECIMAL(10,2),
    loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);


INSERT INTO FCT_SALES (transaction_id, date_key, customer_key, product_key, store_key,
                       quantity, unit_price, discount_percent, revenue, discount_amount)
VALUES
    ('T001', 20240115, 1, 1, 1, 2, 59.99, 10, 107.98, 12.00),
    ('T002', 20240115, 2, 2, 2, 1, 29.99, 0, 29.99, 0),
    ('T003', 20240116, 1, 3, 1, 3, 49.99, 15, 127.47, 22.50);



INSERT INTO FCT_SALES (transaction_id, date_key, customer_key, product_key, store_key,
                       quantity, unit_price, discount_percent, revenue, discount_amount)
VALUES
    ('T004', 20240120, 3, 4, 2, 1, 29.99,  5,  28.49,  1.50),
    ('T005', 20240203, 4, 1, 1, 1, 59.99,  0,  59.99,  0.00),
    ('T006', 20240210, 5, 2, 3, 2, 49.99, 10,  89.98, 10.00),
    ('T007', 20240214, 2, 3, 1, 1, 39.99, 20,  31.99,  8.00),
    ('T008', 20240301, 1, 5, 2, 1, 69.99, 15,  59.49, 10.50),
    ('T009', 20240309, 3, 6, 4, 2, 34.99,  0,  69.98,  0.00),
    ('T010', 20240316, 4, 4, 1, 3, 29.99, 10,  80.97,  9.00),
    ('T011', 20240405, 5, 1, 3, 1, 59.99, 25,  44.99, 15.00),
    ('T012', 20240413, 2, 2, 4, 2, 49.99,  5,  94.98,  5.00),
    ('T013', 20240420, 1, 3, 2, 4, 39.99,  0, 159.96,  0.00),
    ('T014', 20240511, 3, 5, 1, 1, 69.99, 10,  62.99,  7.00),
    ('T015', 20240518, 4, 6, 2, 2, 34.99, 20,  55.98, 14.00);

-- Sanity check
SELECT COUNT(*) AS total_fact_rows FROM FCT_SALES;
