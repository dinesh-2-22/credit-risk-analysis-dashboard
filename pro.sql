create database  credit_project ;
use credit_project;
select count(*)  as total_rows from german_credit_data;

select risk , count(*) 
from german_credit_data
group by risk;

select risk , count(*) as total_customers  ,round( count(*) /(select count(*) from german_credit_data) *100,2) as risk_percentage 
from german_credit_data 
group by risk ; 

SELECT 
    job,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) AS bad_customers,
    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM german_credit_data
GROUP BY job
ORDER BY default_rate DESC;
 
SELECT 
    job,
    SUM(`Credit amount`) AS total_amount,
    SUM(CASE 
            WHEN risk = 'bad' THEN `Credit amount` 
            ELSE 0 
        END) AS bad_amount,
    ROUND(
        SUM(CASE 
                WHEN risk = 'bad' THEN `Credit amount` 
                ELSE 0 
            END) 
        / SUM(`Credit amount`) * 100, 
    2) AS loss_percentage
FROM german_credit_data
GROUP BY job
ORDER BY loss_percentage DESC;




SELECT
    CASE
        WHEN Age BETWEEN 18 AND 29 THEN 'Youth'
        WHEN Age BETWEEN 30 AND 59 THEN 'Middle Age'
        WHEN Age >= 60 THEN 'Senior'
    END AS age_segment,

    COUNT(*) AS total_customers,

    SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) AS bad_customers,

    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) 
        / COUNT(*) * 100,
        2
    ) AS default_rate

FROM german_credit_data

GROUP BY age_segment

ORDER BY default_rate DESC;


SELECT 
    purpose,
    COUNT(*) AS total_customers,
    SUM(CASE 
            WHEN risk = 'bad' THEN 1 
            ELSE 0 
        END) AS bad_customers,
    ROUND(
        SUM(CASE 
                WHEN risk = 'bad' THEN 1 
                ELSE 0 
            END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM german_credit_data
GROUP BY purpose
ORDER BY default_rate DESC; 


select min(`Credit amount`), max(`Credit amount`)
from german_credit_data;   

SELECT 
    CASE 
        WHEN `Credit amount` < 4000 THEN 'Small'
        WHEN `Credit amount` BETWEEN 4000 AND 10000 THEN 'Medium'
        ELSE 'Large'
    END AS loan_range,

    COUNT(*) AS total_customers,

    SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) AS bad_customers,

    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) 
        / COUNT(*) * 100,
        2
    ) AS default_rate

FROM german_credit_data

GROUP BY loan_range

ORDER BY default_rate DESC;


SELECT 
    CASE 
        WHEN `Credit amount` < 4000 THEN 'Small'
        WHEN `Credit amount` BETWEEN 4000 AND 10000 THEN 'Medium'
        ELSE 'Large'
    END AS loan_range,
    sum(`Credit amount`) as total_credit_amount , 
     SUM(CASE 
            WHEN risk = 'bad' THEN `Credit amount` 
            ELSE 0 
        END) AS bad_credit_amount,
        ROUND(
        SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) 
        / COUNT(*) * 100,
        2
    ) AS loss_percentage 
    from german_credit_data 
    group by loan_range;



CREATE VIEW overall_portfolio_summary AS
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) AS bad_customers,
    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS overall_default_rate,
    SUM(`Credit amount`) AS total_credit_amount,
    SUM(CASE WHEN risk = 'bad' THEN `Credit amount` ELSE 0 END) AS total_bad_credit_amount,
    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN `Credit amount` ELSE 0 END)
        / SUM(`Credit amount`) * 100,
        2
    ) AS overall_loss_percentage
FROM german_credit_data;


CREATE VIEW job_risk_summary AS
    SELECT 
        job,
        COUNT(*) AS total_customers,
        SUM(CASE
            WHEN risk = 'bad' THEN 1
            ELSE 0
        END) AS bad_customers,
        ROUND(SUM(CASE
                    WHEN risk = 'bad' THEN 1
                    ELSE 0
                END) / COUNT(*) * 100,
                2) AS default_rate,
        SUM(`Credit amount`) AS total_credit_amount,
        SUM(CASE
            WHEN risk = 'bad' THEN `Credit amount`
            ELSE 0
        END) AS bad_credit_amount,
        ROUND(SUM(CASE
                    WHEN risk = 'bad' THEN `Credit amount`
                    ELSE 0
                END) / SUM(`Credit amount`) * 100,
                2) AS loss_percentage
    FROM
        german_credit_data
    GROUP BY job;
    
CREATE VIEW purpose_risk_summary AS
SELECT 
    purpose,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) AS bad_customers,
    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate,
    SUM(`Credit amount`) AS total_credit_amount,
    SUM(CASE WHEN risk = 'bad' THEN `Credit amount` ELSE 0 END) AS bad_credit_amount,
    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN `Credit amount` ELSE 0 END)
        / SUM(`Credit amount`) * 100,
        2
    ) AS loss_percentage
FROM german_credit_data
GROUP BY purpose;



CREATE VIEW loan_range_risk_summary AS
SELECT 
    CASE 
        WHEN `Credit amount` < 4000 THEN 'Small'
        WHEN `Credit amount` BETWEEN 4000 AND 10000 THEN 'Medium'
        ELSE 'Large'
    END AS loan_range,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) AS bad_customers,
    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate,
    SUM(`Credit amount`) AS total_credit_amount,
    SUM(CASE WHEN risk = 'bad' THEN `Credit amount` ELSE 0 END) AS bad_credit_amount,
    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN `Credit amount` ELSE 0 END)
        / SUM(`Credit amount`) * 100,
        2
    ) AS loss_percentage
FROM german_credit_data
GROUP BY loan_range;


CREATE VIEW age_segment_risk_summary AS
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 29 THEN 'Youth'
        WHEN Age BETWEEN 30 AND 59 THEN 'Middle Age'
        ELSE 'Senior'
    END AS age_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) AS bad_customers,
    ROUND(
        SUM(CASE WHEN risk = 'bad' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM german_credit_data
GROUP BY age_segment;


SELECT * FROM overall_portfolio_summary;
SELECT * FROM job_risk_summary;
SELECT * FROM purpose_risk_summary;
SELECT * FROM loan_range_risk_summary;
SELECT * FROM age_segment_risk_summary;



