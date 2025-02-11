/*
===================================================
IRCTC Real-Time Data Pipeline - SQL Queries
Author: Sujit Mahapatra
Description: This file contains essential SQL scripts 
for data processing, transformation, and analysis 
in BigQuery as part of the IRCTC real-time data pipeline.
===================================================
*/

-- =========================================
-- 1. Insert Sample Data into IRCTC Table
-- =========================================
INSERT INTO `irctc_dwh.irctc_stream_tb` 
(row_key, name, age, email, join_date, last_login, loyalty_points, account_balance, is_active, inserted_at, updated_at, loyalty_status, account_age_days)  
VALUES 
('1', 'Amit Kumar', 28, 'amit.k@example.com', '2020-01-15', CURRENT_TIMESTAMP(), 500, 2000.50, TRUE, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'Gold', 1500);

-- =========================================
-- 2. Retrieve Recently Active Users
-- =========================================
SELECT name, email, last_login, loyalty_status 
FROM `irctc_dwh.irctc_stream_tb`  
WHERE is_active = TRUE  
ORDER BY last_login DESC  
LIMIT 100;

-- =========================================
-- 3. Compute Loyalty Points Summary
-- =========================================
SELECT loyalty_status, COUNT(*) AS total_users, AVG(loyalty_points) AS avg_points  
FROM `irctc_dwh.irctc_stream_tb`  
GROUP BY loyalty_status  
ORDER BY avg_points DESC;

-- =========================================
-- 4. Identify Users with Low Account Balance
-- =========================================
SELECT name, email, account_balance  
FROM `irctc_dwh.irctc_stream_tb`  
WHERE account_balance < 500  
ORDER BY account_balance ASC;

-- =========================================
-- 5. Detect Inactive Users (Last Login > 1 Year)
-- =========================================
SELECT name, email, last_login  
FROM `irctc_dwh.irctc_stream_tb`  
WHERE last_login < TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 YEAR);

-- =========================================
-- 6. Update Loyalty Status Based on Points
-- =========================================
UPDATE `irctc_dwh.irctc_stream_tb`  
SET loyalty_status =  
  CASE  
    WHEN loyalty_points >= 1000 THEN 'Platinum'  
    WHEN loyalty_points BETWEEN 500 AND 999 THEN 'Gold'  
    ELSE 'Silver'  
  END  
WHERE is_active = TRUE;

-- =========================================
-- 7. Remove Inactive Users (More than 2 Years)
-- =========================================
DELETE FROM `irctc_dwh.irctc_stream_tb`  
WHERE is_active = FALSE  
AND last_login < TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 2 YEAR);
