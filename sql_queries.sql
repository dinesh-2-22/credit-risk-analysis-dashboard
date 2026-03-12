-- Total customers and bad customers
SELECT 
COUNT(*) AS total_customers,
SUM(CASE WHEN credit_risk = 'bad' THEN 1 ELSE 0 END) AS bad_customers
FROM german_credit;

-- Default rate
SELECT 
ROUND(SUM(CASE WHEN credit_risk='bad' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) 
AS default_rate
FROM german_credit;

-- Default rate by loan range
SELECT loan_range,
ROUND(SUM(CASE WHEN credit_risk='bad' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) 
AS default_rate
FROM german_credit
GROUP BY loan_range;

-- Default rate by job
SELECT job,
ROUND(SUM(CASE WHEN credit_risk='bad' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) 
AS default_rate
FROM german_credit
GROUP BY job;