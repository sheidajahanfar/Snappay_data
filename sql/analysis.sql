-- View first 10 rows
SELECT * FROM snappay LIMIT 10;

-- Count total users
SELECT COUNT(*) AS total_users FROM snappay;

-- Count defaulters
SELECT is_defaulter, COUNT(*) AS user_count
FROM snappay
GROUP BY is_defaulter;
