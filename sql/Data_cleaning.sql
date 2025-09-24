SELECT * FROM snappay LIMIT 10;

SELECT COUNT(*) AS total_users FROM snappay;

SELECT is_defaulter, COUNT(*) AS user_count
FROM snappay
GROUP BY is_defaulter;


SELECT MIN(age) AS min_age, MAX(age) AS max_age, AVG(age) AS avg_age
FROM snappay;

SELECT COUNT(*) AS missing_credit_score
FROM snappay
WHERE "external credit score" IS NULL;


SELECT 
    COUNT(*) - COUNT(age) AS missing_age,
    COUNT(*) - COUNT(gender) AS missing_gender,
    COUNT(*) - COUNT("external credit score") AS missing_credit_score,
    COUNT(*) - COUNT("total credit usage count") AS missing_credit_usage
FROM snappay;


SELECT customer_id, total_credit_usage_amount
FROM snappay
ORDER BY total_credit_usage_amount DESC
LIMIT 10;

SELECT 
    MIN(external_credit_score) AS min_score,
    MAX(external_credit_score) AS max_score,
    AVG(external_credit_score) AS avg_score
FROM snappay;


SELECT 
    CASE 
        WHEN external_credit_score BETWEEN 300 AND 579 THEN 'Poor'
        WHEN external_credit_score BETWEEN 580 AND 669 THEN 'Fair'
        WHEN external_credit_score BETWEEN 670 AND 739 THEN 'Good'
        WHEN external_credit_score BETWEEN 740 AND 800 THEN 'Very Good'
    END AS credit_band,
    COUNT(*) AS user_count,
    AVG(is_defaulter) * 100 AS default_rate_percent
FROM snappay
GROUP BY credit_band
ORDER BY MIN(external_credit_score);


SELECT 
    total_repayment_delay_count,
    COUNT(*) AS user_count,
    round(AVG(is_defaulter) * 100,2) AS default_rate_percent
FROM snappay
GROUP BY total_repayment_delay_count
ORDER BY total_repayment_delay_count;



SELECT 
    CASE 
        WHEN external_credit_score BETWEEN 300 AND 579 THEN 'Poor'
        WHEN external_credit_score BETWEEN 669 AND 739 THEN 'Good'
        WHEN external_credit_score  BETWEEN 740 AND 800 THEN 'Very Good'
        ELSE 'Fair'
    END AS credit_band,
    total_repayment_delay_count  AS delay_count,
    COUNT(*) AS user_count,
    ROUND(AVG(is_defaulter) * 100, 2) AS default_rate_percent
FROM snappay
GROUP BY credit_band, delay_count
ORDER BY credit_band, delay_count;



SELECT 
    total_credit_usage_count  AS usage_count,
    COUNT(*) AS user_count,
    ROUND(AVG(is_defaulter) * 100, 2) AS default_rate_percent
FROM snappay
GROUP BY usage_count
ORDER BY usage_count;



SELECT 
   Round(CAST (total_full_credit_usage_count AS FLOAT)/ total_credit_usage_count,2) AS full_usage_ratio,
    COUNT(*) AS user_count,
    ROUND(AVG(is_defaulter) * 100, 2) AS default_rate_percent
FROM snappay
GROUP BY full_usage_ratio
ORDER BY full_usage_ratio;

--i found out that the full usage ration( total_full_credit_usage_count / total_credit_usage_count) is abouve 1 for some users which is a problem
SELECT customer_id, 
       total_full_credit_usage_count,
	   total_credit_usage_count
FROM snappay
WHERE total_full_credit_usage_count  > total_credit_usage_count;

-- As the ratio is above 1 for 5% of users, I will delete these rows and make a new TABLE
CREATE TABLE snappay_users_cleaned AS
SELECT *
FROM snappay
WHERE total_full_credit_usage_count  <= total_credit_usage_count;

SELECT COUNT(*) AS total_rows_cleaned
FROM snappay_users_cleaned
WHERE total_full_credit_usage_count > total_credit_usage_count;
