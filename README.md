📊 SALES DATA ANALYSIS PROJECT REPORT
🧩 1. Project Overview

Objective:
To analyze historical sales data from Amazon retail branches to identify top-performing products, customers, and regions; understand purchasing patterns; and derive actionable insights to optimize business decisions.

Data Source:
amazon.csv — 1,000+ records of transactional sales data from three cities in Myanmar (Yangon, Mandalay, Naypyitaw).

Toolset:

Database: MySQL

Visualization: Power BI (for dashboards)

Languages: SQL

Key Deliverables: 28 Business Insights + 4 KPI Cards + 8–9 Interactive Dashboards

🧾 2. Data Description
Column	Description
Invoice ID	Unique transaction identifier
Branch	Store branch (A, B, or C)
City	City where the store is located
Customer type	Member / Normal
Gender	Male / Female
Product line	Product category
Unit price	Price per product
Quantity	Units purchased
Tax 5%	5% VAT
Total	Total amount (including tax)
Date	Transaction date
Time	Transaction time
Payment	Mode of payment
COGS	Cost of goods sold
Gross margin %	Profit margin
Gross income	Profit earned
Rating	Customer rating (1–10)

Added Columns (via SQL):

timeofday → Morning, Afternoon, Evening

dayname → Weekday (Mon–Sun)

monthname → Month (Jan–Mar)

⚙️ 3. Data Processing Steps (MySQL)

Data Cleaning

Checked for null values, replaced with 0 where needed.

Standardized column names (used backticks for spaces).

Feature Engineering

ALTER TABLE amazon
ADD COLUMN timeofday VARCHAR(20),
ADD COLUMN dayname VARCHAR(10),
ADD COLUMN monthname VARCHAR(10);


Then populated each column using HOUR(Time) and STR_TO_DATE() logic.

View Creation

Created 28 SQL Views for all business questions (sales, profit, time-based, and customer insights).

Each view serves as a reusable data model for Power BI dashboards.

💡 4. Key Business Insights
🏙️ Branch & City Insights

3 cities: Yangon, Mandalay, Naypyitaw

Each branch operates exclusively in one city.

Yangon generated the highest overall revenue.

💰 Sales & Revenue Insights

Product Line with Highest Sales: Food and Beverages

Product Line with Highest Profit: Health and Beauty

Highest COGS Month: January

Monthly Revenue Peak: January (~$116K)

💳 Customer & Payment Insights

Most used payment method: Ewallet (34%)

Customer Type with Highest Revenue: Member Customers

Predominant Gender: Female (54%)

Branch with Most Sales Volume: Branch A

⏰ Time-based Insights

Most sales occur in the Afternoon (12 PM–6 PM)

Highest Ratings provided in the Evening

Monday and Friday showed slightly higher transaction counts.

⭐ Customer Experience

Average Rating across dataset: 6.97 / 10

Highest-rated product line: Fashion Accessories

Branch C achieved the highest customer satisfaction.

📘 7. Conclusion

Ewallet is the most preferred payment method, showing the shift to digital transactions.

Members contribute more revenue, suggesting loyalty programs are effective.

Afternoons are the busiest; increasing staff and stock during that time could improve efficiency.

Health & Beauty and Food & Beverages dominate sales — ideal focus areas for promotion.

Customer satisfaction is steady (~7/10), but can improve through personalized offers.

🧭 8. Recommendations

Branch Optimization: Increase product variety in Mandalay to boost lower-performing sales.

Customer Engagement: Launch reward programs for “Normal” customers.

Product Strategy: Expand Health & Beauty line due to strong profitability.

Operational Strategy: Focus marketing campaigns during Afternoon hours.
