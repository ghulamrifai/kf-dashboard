-- Create the analysis table
CREATE OR REPLACE TABLE rakamin-kf-analytics-444207.kimia_farma.analysis_table AS
WITH 
    -- Subquery 'main' for transactions, branch, and product data
    main AS (
        SELECT
            t.transaction_id,
            t.date,
            t.branch_id,
            c.branch_name,
            c.kota,
            c.provinsi,
            c.rating AS rating_cabang,
            t.customer_name,
            t.product_id,
            p.product_name,
            p.price AS actual_price,
            t.discount_percentage,
            -- Calculate gross profit percentage based on price
            CASE 
                WHEN p.price <= 50000 THEN 0.1
                WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
                WHEN p.price > 100000 AND p.price <= 300000 THEN 0.2
                WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
                ELSE 0.3
            END AS persentase_gross_laba,
            -- Calculate nett sales
            p.price * (1 - t.discount_percentage) AS nett_sales
        FROM 
            rakamin-kf-analytics-444207.kimia_farma.kf_final_transaction t
        LEFT JOIN 
            rakamin-kf-analytics-444207.kimia_farma.kf_kantor_cabang c
        ON 
            t.branch_id = c.branch_id
        LEFT JOIN 
            rakamin-kf-analytics-444207.kimia_farma.kf_product p
        ON 
            t.product_id = p.product_id
    )
-- Select all columns from 'main' and calculate additional metrics
SELECT
    DISTINCT 
    main.*,
    -- Calculate nett profit
    (main.actual_price * main.persentase_gross_laba) - 
    (main.actual_price - main.nett_sales) AS nett_profit,
    -- Add transaction rating
    t.rating AS rating_transaksi
FROM 
    main
JOIN 
    rakamin-kf-analytics-444207.kimia_farma.kf_final_transaction t
ON 
    main.transaction_id = t.transaction_id
-- Order the transactions by the latest date
ORDER BY 
    main.date ASC;

-- Verify the results
SELECT * 
FROM rakamin-kf-analytics-444207.kimia_farma.analysis_table
ORDER BY date ASC;