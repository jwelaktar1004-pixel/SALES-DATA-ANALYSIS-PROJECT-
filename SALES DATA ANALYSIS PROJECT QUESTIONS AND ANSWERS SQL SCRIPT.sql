select * from amazon

ALTER TABLE amazon
ADD COLUMN timeofday VARCHAR(20),
ADD COLUMN dayname VARCHAR(10),
ADD COLUMN monthname VARCHAR(10);

UPDATE amazon
SET timeofday = CASE
    WHEN HOUR(Time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN HOUR(Time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN HOUR(Time) BETWEEN 18 AND 23 THEN 'Evening'
    ELSE 'Late Night'
END;

UPDATE amazon
SET dayname = DAYNAME(Date);

UPDATE amazon
SET dayname = DAYNAME(STR_TO_DATE(Date, '%Y-%m-%d'));

UPDATE amazon
SET monthname = MONTHNAME(STR_TO_DATE(Date, '%Y-%m-%d'));

CREATE VIEW amazon_time_insights AS
SELECT 
    Branch,
    City,
    timeofday,
    dayname,
    monthname,
    SUM(Total) AS total_sales,
    SUM(`Gross income`) AS total_profit,
    COUNT(*) AS transactions
FROM amazon
GROUP BY Branch, City, timeofday, dayname, monthname;


CREATE VIEW view_distinct_cities AS
SELECT COUNT(DISTINCT City) AS distinct_cities
FROM amazon;

CREATE VIEW view_branch_city AS
SELECT Branch, City
FROM amazon
GROUP BY Branch, City;

CREATE VIEW view_distinct_product_lines AS
SELECT COUNT(DISTINCT `Product line`) AS distinct_product_lines
FROM amazon;

CREATE VIEW view_most_frequent_payment AS
SELECT Payment, COUNT(*) AS frequency
FROM amazon
GROUP BY Payment
ORDER BY frequency DESC
LIMIT 1;

CREATE VIEW view_top_sales_product_line AS
SELECT `Product line`, SUM(Total) AS total_sales
FROM amazon
GROUP BY `Product line`
ORDER BY total_sales DESC
LIMIT 1;

CREATE VIEW view_monthly_revenue AS
SELECT monthname, SUM(Total) AS monthly_revenue
FROM amazon
GROUP BY monthname
ORDER BY STR_TO_DATE(CONCAT('01-', monthname, '-2019'), '%d-%M-%Y');

CREATE VIEW view_peak_month_cogs AS
SELECT monthname, SUM(cogs) AS total_cogs
FROM amazon
GROUP BY monthname
ORDER BY total_cogs DESC
LIMIT 1;

CREATE VIEW view_top_revenue_product_line AS
SELECT `Product line`, SUM(Total) AS total_revenue
FROM amazon
GROUP BY `Product line`
ORDER BY total_revenue DESC
LIMIT 1;

CREATE VIEW view_top_revenue_city AS
SELECT City, SUM(Total) AS total_revenue
FROM amazon
GROUP BY City
ORDER BY total_revenue DESC
LIMIT 1;

CREATE VIEW view_top_vat_product_line AS
SELECT `Product line`, SUM(`Tax 5%`) AS total_vat
FROM amazon
GROUP BY `Product line`
ORDER BY total_vat DESC
LIMIT 1;

CREATE VIEW view_product_line_sales_status AS
SELECT 
    `Product line`,
    SUM(Total) AS total_sales,
    CASE 
        WHEN SUM(Total) > (SELECT AVG(Total) FROM amazon) THEN 'Good'
        ELSE 'Bad'
    END AS sales_category
FROM amazon
GROUP BY `Product line`;


CREATE VIEW view_branches_above_avg_quantity AS
SELECT Branch, SUM(Quantity) AS total_quantity
FROM amazon
GROUP BY Branch
HAVING total_quantity > (SELECT AVG(Quantity) FROM amazon);


CREATE VIEW view_top_productline_by_gender AS
SELECT Gender, `Product line`, COUNT(*) AS frequency
FROM amazon
GROUP BY Gender, `Product line`
ORDER BY Gender, frequency DESC;

CREATE VIEW view_avg_rating_product_line AS
SELECT `Product line`, ROUND(AVG(Rating),2) AS avg_rating
FROM amazon
GROUP BY `Product line`;

CREATE VIEW view_sales_by_time_weekday AS
SELECT dayname, timeofday, COUNT(*) AS sales_count
FROM amazon
GROUP BY dayname, timeofday
ORDER BY FIELD(dayname, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');


CREATE VIEW view_top_revenue_customer_type AS
SELECT `Customer type`, SUM(Total) AS total_revenue
FROM amazon
GROUP BY `Customer type`
ORDER BY total_revenue DESC
LIMIT 1;

CREATE VIEW view_top_vat_city AS
SELECT City, ROUND(SUM(`Tax 5%`) / SUM(cogs) * 100, 2) AS vat_percentage
FROM amazon
GROUP BY City
ORDER BY vat_percentage DESC
LIMIT 1;

CREATE VIEW view_top_vat_customer_type AS
SELECT `Customer type`, SUM(`Tax 5%`) AS total_vat
FROM amazon
GROUP BY `Customer type`
ORDER BY total_vat DESC
LIMIT 1;

CREATE VIEW view_distinct_customer_types AS
SELECT COUNT(DISTINCT `Customer type`) AS distinct_customer_types
FROM amazon;


CREATE VIEW view_distinct_payment_methods AS
SELECT COUNT(DISTINCT Payment) AS distinct_payment_methods
FROM amazon;

CREATE VIEW view_most_frequent_customer_type AS
SELECT `Customer type`, COUNT(*) AS frequency
FROM amazon
GROUP BY `Customer type`
ORDER BY frequency DESC
LIMIT 1;

CREATE VIEW view_top_purchase_customer_type AS
SELECT `Customer type`, COUNT(*) AS purchase_count
FROM amazon
GROUP BY `Customer type`
ORDER BY purchase_count DESC
LIMIT 1;


CREATE VIEW view_predominant_gender AS
SELECT Gender, COUNT(*) AS gender_count
FROM amazon
GROUP BY Gender
ORDER BY gender_count DESC
LIMIT 1;

CREATE VIEW view_gender_distribution_branch AS
SELECT Branch, Gender, COUNT(*) AS count_by_gender
FROM amazon
GROUP BY Branch, Gender
ORDER BY Branch;

CREATE VIEW view_top_rating_timeofday AS
SELECT timeofday, COUNT(Rating) AS rating_count
FROM amazon
GROUP BY timeofday
ORDER BY rating_count DESC
LIMIT 1;

CREATE VIEW view_highest_rating_time_branch AS
SELECT Branch, timeofday, ROUND(AVG(Rating),2) AS avg_rating
FROM amazon
GROUP BY Branch, timeofday
ORDER BY Branch, avg_rating DESC;

CREATE VIEW view_top_avg_rating_day AS
SELECT dayname, ROUND(AVG(Rating),2) AS avg_rating
FROM amazon
GROUP BY dayname
ORDER BY avg_rating DESC
LIMIT 1;

CREATE VIEW view_top_avg_rating_branch_day AS
SELECT Branch, dayname, ROUND(AVG(Rating),2) AS avg_rating
FROM amazon
GROUP BY Branch, dayname
ORDER BY Branch, avg_rating DESC;
