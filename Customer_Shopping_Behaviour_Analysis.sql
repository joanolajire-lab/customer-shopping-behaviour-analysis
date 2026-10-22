PROJECT: Customer Shopping Behaviour Analysis Using SQL

DATASET: Customer Shopping Trends Dataset
DATABASE: SQLite
TOOL: DB Browser for SQLite

OBJECTIVE:
To analyse customer shopping records, purchase amounts, product categories, customer demographics, payment methods, subscriptions, discounts, and shopping behaviour.


-- ==========================================
-- SECTION 1: DATA EXPLORATION
-- ==========================================

-- Query 1.1: Display the first 10 records
SELECT *
FROM "customer_shopping"
LIMIT 10;

Purpose: Preview the data and inspect the values in the table.

-- Query 1.2: Count the total number of records
SELECT COUNT(*)
FROM "customer_shopping";

Result: 3,900 records.
Interpretation: The dataset contains 3,900 shopping records.

-- Query 1.3: Inspect the table structure
PRAGMA table_info("customer_shopping");

-Purpose: Display information about the table's columns, including column names, data types, and other properties.
Result: The table contains 18 columns.

-- ==========================================
-- SECTION 2: DATA QUALITY CHECKS
-- ==========================================

--2.1: Check for missing purchase amounts
SELECT COUNT(*)
FROM "customer_shopping"
WHERE "Purchase Amount (USD)" IS NULL;

What it does:

COUNT(*) counts the records that match the condition.
WHERE filters records.
IS NULL checks whether a value is missing.

Our result: 0 missing purchase amounts.

--2.2: Check for missing review ratings
SELECT COUNT(*)
FROM "customer_shopping"
WHERE "Review Rating" IS NULL;

What it does: Counts the records where the review rating is missing. We previously found 0.

--2.3: Check for missing subscription status
SELECT COUNT(*)
FROM "customer_shopping"
WHERE "Subscription Status" IS NULL;

This checks whether any records are missing subscription information. We previously found 0 missing values.

-- 2.4: Check for duplicate customer IDs

SELECT "Customer ID", COUNT()
FROM "customer_shopping"
GROUP BY "Customer ID"
HAVING COUNT() > 1;

Established result: No duplicate customer IDs were found.
Every Customer ID appears only once in the dataset.


-- 2.5: Count distinct customer IDs

SELECT COUNT(DISTINCT "Customer ID")
FROM "customer_shopping";

Established result: 3,900 distinct Customer IDs.
The dataset contains 3,900 records and 3,900 unique customer IDs.

-- 2.6: Check for invalid purchase amounts

SELECT COUNT(*)
FROM "customer_shopping"
WHERE "Purchase Amount (USD)" <= 0;

Established result: 0 invalid purchase amounts.
Every recorded purchase amount is greater than zero. No records have a purchase amount of zero or less.

-- 2.7: Check the minimum and maximum ages

SELECT MIN("Age"), MAX("Age")
FROM "customer_shopping";

Established result:
Minimum age: 18 years.
Maximum age: 70 years.
The customers represented in this dataset range from 18 to 70 years old.

-- 2.8: Check for ages below 18

SELECT COUNT(*)
FROM "customer_shopping"
WHERE "Age" < 18;

Established result: 0 records.
No customers in the dataset are younger than 18.

-- 2.9: Check for review ratings outside the 1–5 range

SELECT COUNT(*)
FROM "customer_shopping"
WHERE "Review Rating" < 1
OR "Review Rating" > 5;

Established result: 0 records.
All recorded review ratings fall within the expected range of 1 to 5.


SECTION 3: OVERALL PURCHASE ANALYSIS

-- ==========================================
-- SECTION 3: OVERALL PURCHASE ANALYSIS
-- ==========================================

-- 3.1: Calculate total recorded purchase value

SELECT SUM("Purchase Amount (USD)")
FROM "customer_shopping";

Result: $233,081
Interpretation: The sum of the purchase amounts across all 3,900 shopping records is $233,081.

-- 3.2: Calculate average purchase amount

SELECT AVG("Purchase Amount (USD)")
FROM "customer_shopping";

Result: Approximately $59.76
Interpretation: The average recorded purchase amount across the 3,900 shopping records is approximately $59.76.

-- 3.3: Find the lowest purchase amount

SELECT MIN("Purchase Amount (USD)")
FROM "customer_shopping";

Result: $20
Interpretation: The lowest purchase amount recorded in the dataset is $20.

-- 3.4: Find the highest purchase amount

SELECT MAX("Purchase Amount (USD)")
FROM "customer_shopping";

Result: $100
Interpretation: The highest purchase amount recorded in the dataset is $100.

-- 3.5: Find the range of purchase amounts

SELECT MAX("Purchase Amount (USD)") - MIN("Purchase Amount (USD)")
FROM "customer_shopping";

Result: $80
Calculation: $100 − $20 = $80.
Interpretation: There is an $80 difference between the highest and lowest recorded purchase amounts.



-- ==========================================
-- SECTION 4: CATEGORY ANALYSIS
-- ==========================================

-- 4.1: Count shopping records in each category
SELECT "Category", COUNT()
FROM "customer_shopping"
GROUP BY "Category"
ORDER BY COUNT() DESC;

-- RESULT:
-- Clothing: 1,737
-- Accessories: 1,240
-- Footwear: 599
-- Outerwear: 324

Clothing has the most records (1,737), while Outerwear has the fewest (324).

Interpretation: Clothing represents the largest category by number of shopping records in this dataset.

-- 4.2: Calculate average purchase amount by category

SELECT "Category", AVG("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Category"
ORDER BY AVG("Purchase Amount (USD)") DESC;

-- RESULT:
-- Footwear: $60.26
-- Clothing: $60.03
-- Accessories: $59.84
-- Outerwear: $57.17

Footwear has the highest average purchase amount ($60.26), while Outerwear has the lowest ($57.17).

Interpretation: The average recorded purchase amount for Footwear is slightly higher than for Clothing, even though Clothing has many more records.

-- 4.3: Calculate total recorded purchase value by category

SELECT "Category", SUM("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Category"
ORDER BY SUM("Purchase Amount (USD)") DESC;

-- RESULT:
-- Clothing: $104,264
-- Accessories: $74,200
-- Footwear: $36,093
-- Outerwear: $18,524

Clothing has the highest total ($104,264), followed by Accessories ($74,200).

Interpretation: Clothing has the highest combined purchase value. Its larger number of records helps explain why its total is much higher than Footwear's, despite Footwear having a slightly higher average.

-- 4.4: Find categories with more than 500 shopping records
SELECT "Category", COUNT()
FROM "customer_shopping"
GROUP BY "Category"
HAVING COUNT() > 500
ORDER BY COUNT(*) DESC;

-- RESULT:
-- Clothing: 1,737
-- Accessories: 1,240
-- Footwear: 599

Clothing, Accessories, and Footwear meet this condition. Outerwear does not, because it has only 324 records.

Interpretation: The HAVING clause filters categories based on their grouped record counts.



-- ==========================================
-- SECTION 5: GENDER ANALYSIS
-- ==========================================

-- 5.1: Count shopping records by gender
SELECT "Gender", COUNT()
FROM "customer_shopping"
GROUP BY "Gender"
ORDER BY COUNT() DESC;

-- RESULT:
-- Male: 2,652
-- Female: 1,248

Interpretation: Approximately 68% of the records are associated with male customers and 32% with female customers.

Male customers account for more records in this dataset.

-- 5.2: Calculate average purchase amount by gender

SELECT "Gender", AVG("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Gender"
ORDER BY AVG("Purchase Amount (USD)") DESC;

-- RESULT:
-- Female: $60.25
-- Male: $59.54

Interpretation: Female customers have a slightly higher average recorded purchase amount than male customers, by approximately $0.71.

-- 5.3: Calculate total recorded purchase value by gender

SELECT "Gender", SUM("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Gender"
ORDER BY SUM("Purchase Amount (USD)") DESC;

-- RESULT:
-- Male: $157,890
-- Female: $75,191

Interpretation: Male customers account for the higher total recorded purchase value. This is consistent with the fact that there are substantially more male records in the dataset.

Although female customers have a slightly higher average, their total is lower because there are fewer female records.


-- ==========================================
-- SECTION 6: AGE GROUP ANALYSIS
-- ==========================================

-- 6.1: Count shopping records by age group

SELECT
CASE
WHEN "Age" < 30 THEN 'Young Adult'
WHEN "Age" < 50 THEN 'Adult'
ELSE 'Older Adult'
END AS "Age_Group",
COUNT()
FROM "customer_shopping"
GROUP BY "Age_Group"
ORDER BY COUNT() DESC;

-- RESULT:
-- Older Adult (50+): 1,559
-- Adult (30-49):     1,463
-- Young Adult (18-29): 878

Interpretation: Older Adults account for the most records, while Young Adults account for the fewest.

-- 6.2: Calculate average purchase amount by age group

SELECT
CASE
WHEN "Age" < 30 THEN 'Young Adult'
WHEN "Age" < 50 THEN 'Adult'
ELSE 'Older Adult'
END AS "Age_Group",
AVG("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Age_Group"
ORDER BY AVG("Purchase Amount (USD)") DESC;

-- RESULT:
-- Young Adult: approximately $60.25
-- Older Adult: approximately $59.92
-- Adult: approximately       $59.31

Interpretation: This query helps us identify which age group has the highest average recorded purchase amount. A higher average does not necessarily mean that group generates the highest total purchase value.

-- 6.3: Calculate total recorded purchase value by age group

SELECT
CASE
WHEN "Age" < 30 THEN 'Young Adult'
WHEN "Age" < 50 THEN 'Adult'
ELSE 'Older Adult'
END AS "Age_Group",
SUM("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Age_Group"
ORDER BY SUM("Purchase Amount (USD)") DESC;

-- RESULT:
-- Older Adult: $93,410
-- Adult:       $86,766
-- Young Adult: $53,905

Interpretation: This query compares the combined recorded purchase amounts of the three age groups. The group with the highest total may have more records, a higher average, or both.



-- ==========================================
-- SECTION 7: CATEGORY AND AGE GROUP ANALYSIS
-- ==========================================

SELECT
CASE
WHEN "Age" < 30 THEN 'Young Adult'
WHEN "Age" < 50 THEN 'Adult'
ELSE 'Older Adult'
END AS "Age_Group",
"Category",
COUNT()
FROM "customer_shopping"
GROUP BY "Age_Group", "Category"
ORDER BY COUNT() DESC;

-- 7.1: Count records by age group and category
-- RESULTS:
-- Older Adult + Clothing: 685
-- Adult + Clothing: 648
-- Older Adult + Accessories: 493
-- Adult + Accessories: 472
-- Young Adult + Clothing: 404
-- Young Adult + Accessories: 275
-- Older Adult + Footwear: 252
-- Adult + Footwear: 220
-- Older Adult + Outerwear: 129
-- Young Adult + Footwear: 127
-- Adult + Outerwear: 123
-- Young Adult + Outerwear: 72

Interpretation: Older Adults have the most Clothing records (685), followed by Adults (648). Young Adults have the fewest records in Outerwear (72).

-- 7.2: Calculate average purchase amount by age group and category
SELECT
CASE
WHEN "Age" < 30 THEN 'Young Adult'
WHEN "Age" < 50 THEN 'Adult'
ELSE 'Older Adult'
END AS "Age_Group",
"Category",
AVG("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Age_Group", "Category"
ORDER BY AVG("Purchase Amount (USD)") DESC;

-- ESTABLISHED RESULTS:
-- Young Adult + Footwear: $62.23
-- Young Adult + Accessories: $60.44
-- Adult + Outerwear: $60.22
-- Older Adult + Clothing: $60.91
-- Older Adult + Footwear: $60.47
-- Young Adult + Clothing: $59.95
-- Older Adult + Accessories: $59.82
-- Adult + Accessories: $59.51
-- Adult + Clothing: $59.13
-- Adult + Footwear: $58.87
-- Young Adult + Outerwear: $57.76
-- Older Adult + Outerwear: $53.94

Interpretation: Young Adults have the highest average purchase amount for Footwear, at approximately $62.23. Older Adults have the lowest average for Outerwear, at approximately $53.94.

-- 7.3: Calculate total recorded purchase value by age group and category

SELECT
CASE
WHEN "Age" < 30 THEN 'Young Adult'
WHEN "Age" < 50 THEN 'Adult'
ELSE 'Older Adult'
END AS "Age_Group",
"Category",
SUM("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Age_Group", "Category"
ORDER BY SUM("Purchase Amount (USD)") DESC;

-- ESTABLISHED RESULTS:
-- Older Adult + Clothing: $41,724
-- Adult + Clothing: $38,319
-- Older Adult + Accessories: $29,489
-- Adult + Accessories: $28,089
-- Young Adult + Clothing: $24,221
-- Young Adult + Accessories: $16,622
-- Older Adult + Footwear: $15,239
-- Adult + Footwear: $12,951
-- Young Adult + Footwear: $7,903
-- Adult + Outerwear: $7,407
-- Older Adult + Outerwear: $6,958
-- Young Adult + Outerwear: $4,159

Interpretation: Older Adults' Clothing records contribute the highest total recorded purchase value among the combinations, at $41,724.



-- ==========================================
-- SECTION 8: SUBSCRIPTION ANALYSIS
-- ==========================================

-- 8.1: Count records by subscription status
SELECT "Subscription Status", COUNT()
FROM "customer_shopping"
GROUP BY "Subscription Status"
ORDER BY COUNT() DESC;

| Subscription Status | Records |
| ------------------- | ------: |
| No                  |   2,847 |
| Yes                 |   1,053 |

Interpretation: Approximately 73% of records belong to customers without a subscription, while 27% belong to subscribers.

-- 8.2: Calculate average purchase amount by subscription status
SELECT "Subscription Status", AVG("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Subscription Status"
ORDER BY AVG("Purchase Amount (USD)") DESC;

| Subscription Status | Average |
| ------------------- | ------: |
| No                  |  $59.87 |
| Yes                 |  $59.49 |

Interpretation: Customers without subscriptions have a slightly higher average recorded purchase amount, by approximately $0.38.

-- 8.3: Calculate total recorded purchase value by subscription status

SELECT "Subscription Status", SUM("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Subscription Status"
ORDER BY SUM("Purchase Amount (USD)") DESC;

| Subscription Status |    Total |
| ------------------- | -------: |
| No                  | $170,436 |
| Yes                 |  $62,645 |

Interpretation: Customers without subscriptions account for the higher total recorded purchase value. However, they also represent a much larger share of the records.

-- 8.4: Calculate average review rating by subscription status

SELECT "Subscription Status", AVG("Review Rating")
FROM "customer_shopping"
GROUP BY "Subscription Status"
ORDER BY AVG("Review Rating") DESC;

| Subscription Status |     Average Rating |
| ------------------- | -----------------: |
| No                  | Approximately 3.75 |
| Yes                 | Approximately 3.74 |

Interpretation: Average review ratings are very similar for both groups. The difference is small, so we shouldn't claim that subscription status meaningfully affects customer satisfaction based on these figures alone.



-- ==========================================
-- SECTION 9: DISCOUNT ANALYSIS
-- ==========================================

-- 9.1: Count records by discount status
SELECT "Discount Applied", COUNT()
FROM "customer_shopping"
GROUP BY "Discount Applied"
ORDER BY COUNT() DESC;

-- RESULTS:
-- No discount: 2,223
-- Discount applied: 1,677

Interpretation: More records have no discount applied than have a discount applied.

-- 9.2: Calculate average purchase amount by discount status

SELECT "Discount Applied", AVG("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Discount Applied"
ORDER BY AVG("Purchase Amount (USD)") DESC;

-- RESULTS:
-- No discount: $60.13
-- Discount applied: $59.28

Interpretation: The average recorded purchase amount is $0.85 higher for records without a discount. This does not prove that discounts cause lower purchase amounts.

-- 9.3: Calculate total recorded purchase value by discount status

SELECT "Discount Applied", SUM("Purchase Amount (USD)")
FROM "customer_shopping"
GROUP BY "Discount Applied"
ORDER BY SUM("Purchase Amount (USD)") DESC;

-- RESULTS:
-- No discount: $133,670
-- Discount applied: $99,411

Interpretation: Records without discounts have a higher combined purchase value. The difference may partly reflect the different numbers of records in each group.


-- ==========================================
-- SECTION 10: PAYMENT METHOD ANALYSIS
-- ==========================================

Query 10.1 — Number of records by payment method

SELECT
"Payment Method",
COUNT() AS "Number of Records"
FROM "customer_shopping"
GROUP BY "Payment Method"
ORDER BY COUNT() DESC;

/*
RESULTS:
PayPal: 677 records
Credit Card: 671 records
Cash: 670 records
Debit Card: 636 records
Venmo: 634 records
Bank Transfer: 612 records
*/

Query 10.2 — Average purchase amount by payment method

SELECT
"Payment Method",
AVG("Purchase Amount (USD)") AS "Average Purchase Amount"
FROM "customer_shopping"
GROUP BY "Payment Method"
ORDER BY AVG("Purchase Amount (USD)") DESC;

/*
ESTABLISHED RESULTS — APPROXIMATE

Debit Card: $60.92
Credit Card: $60.07
Bank Transfer: $59.71
Cash: $59.70
PayPal: $59.25
Venmo: $58.95
*/

Query 10.3 — Total recorded purchase value by payment method

SELECT
"Payment Method",
SUM("Purchase Amount (USD)") AS "Total Purchase Value"
FROM "customer_shopping"
GROUP BY "Payment Method"
ORDER BY SUM("Purchase Amount (USD)") DESC;

/*
ESTABLISHED RESULTS

Credit Card: $40,310
PayPal: $40,109
Cash: $40,002
Debit Card: $38,742
Venmo: $37,374
Bank Transfer: $36,544

Total: $233,081
*/

Query 10.4 — Average review rating by payment method

SELECT
"Payment Method",
AVG("Review Rating") AS "Average Review Rating"
FROM "customer_shopping"
GROUP BY "Payment Method"
ORDER BY AVG("Review Rating") DESC;

/*
ESTABLISHED RESULTS — APPROXIMATE

Credit Card: 3.78
Debit Card: 3.76
Venmo: 3.75
Cash: 3.75
PayPal: 3.75
Bank Transfer: 3.70
*/



-- ==========================================
-- SECTION 11: REVIEW RATING ANALYSIS
-- ==========================================

Query 11.1 — Distribution of Review Ratings

This shows how many shopping records received each rating.

SELECT
"Review Rating",
COUNT(*) AS "Number of Records"
FROM "customer_shopping"
GROUP BY "Review Rating"
ORDER BY "Review Rating" DESC;

RESULTS: 
5.0	68
4.9	166
4.8	144
4.7	148
4.6	174
4.5	139
4.4	158
4.3	147
4.2	171
4.1	148
4.0	181
3.9	163
3.8	142
3.7	156
3.6	149
3.5	156
3.4	182
3.3	152
3.2	152
3.1	157
3.0	162
2.9	170
2.8	136
2.7	154
2.6	159
2.5	66

INTERPRETATION:
The most frequent review rating was 3.4, with 182 records,
while 2.5 was the least frequent, with 66 records.

Ratings were distributed across the range of 2.5 to 4.9.
The most frequent rating alone does not establish overall
customer satisfaction. Further analysis of average ratings
and ratings by product category is needed.

Query 11.2 — Average Review Rating by Category

This helps us compare average customer ratings across product categories.

SELECT
"Category",
AVG("Review Rating") AS "Average Review Rating"
FROM "customer_shopping"
GROUP BY "Category"
ORDER BY AVG("Review Rating") DESC;


RESULTS:
Footwear	3.79
Accessories	3.77
Outerwear	3.75
Clothing	3.72

Footwear has the highest average review rating (3.79), while Clothing has the lowest (3.72).

However, the difference between the two is only about 0.07 points. The average ratings across all four categories are relatively close.

Query 11.3 — Average Purchase Amount by Review Rating

Do records with higher ratings also have higher average purchase amounts?

SELECT
"Review Rating",
AVG("Purchase Amount (USD)") AS "Average Purchase Amount",
COUNT(*) AS "Number of Records"
FROM "customer_shopping"
GROUP BY "Review Rating"
ORDER BY "Review Rating" DESC;


RESULTS:
Review  Average Purchase     Number of
Rating      Amount ($)        Records
5.0	     64.35             	68
4.9	     63.89	       166
4.8	     61.88	       144
4.7	     59.28	       148
4.6	     57.68	       174
4.5	     59.49	       139
4.4	     60.53             158
4.3	     59.67             147
4.2	     60.85             171
4.1	     61.96             148
4.0	     59.24             181
3.9	     58.93	       163
3.8	     60.87	       142
3.7	     58.97	       156
3.6	     57.32	       149
3.5	     58.83	       156
3.4	     59.01	       182
3.3	     59.86	       152
3.2	     61.32	       152
3.1	     58.77	       157
3.0	     60.73	       162
2.9	     56.47	       170
2.8	     57.07	       136
2.7	     59.36	       154
2.6	     59.57             159
2.5	     62.29	        66

INTERPRETATION:
Records with a 5.0 review rating had the highest average
purchase amount, approximately $64.35.

Records with a 2.9 rating had the lowest average purchase
amount, approximately $56.47.

However, average purchase amounts did not increase
consistently with review ratings. Some lower-rated groups
had relatively high average purchase amounts.



-- ==========================================
-- SECTION 12: SHOPPING FREQUENCY ANALYSIS
-- ==========================================

Query 12.1 — Number of Records by Shopping Frequency

This shows how the records are distributed across shopping frequency categories.

SELECT
"Frequency of Purchases",
COUNT() AS "Number of Records"
FROM "customer_shopping"
GROUP BY "Frequency of Purchases"
ORDER BY COUNT() DESC;

ESTABLISHED RESULTS:
Every 3 Months: 584
Annually:       572
Quarterly:      563
Monthly:        553
Bi-Weekly:      547
Fortnightly:    542
Weekly:         539

INTERPRETATION:
Every 3 Months had the highest count (584), while Weekly had the lowest (539). The difference was 45 records.
Counts were relatively close across the seven categories.

Query 12.2 — Average Purchase Amount by Shopping Frequency
This compares the average recorded purchase amount across the frequency groups.

SELECT
"Frequency of Purchases",
AVG("Purchase Amount (USD)") AS "Average Purchase Amount",
COUNT(*) AS "Number of Records"
FROM "customer_shopping"
GROUP BY "Frequency of Purchases"
ORDER BY AVG("Purchase Amount (USD)") DESC;

RESULTS:
Frequency of      Average Purchase    Number of
  Purchases          Amount             Records
Bi-Weekly	      60.69	         547
Annually	      60.17	         572
Every 3 Months        60.08              584
Quarterly	      59.98	         563
Monthly	              59.33	         553
Fortnightly	      59.05	         542
Weekly	              58.97	         539

INTERPRETATION:
Bi-Weekly had the highest average purchase amount ($60.69), while Weekly had the lowest ($58.97), a difference of $1.72.

Average purchase amounts were relatively close across the seven frequency groups.

Query 12.3 — Total Recorded Purchase Value by Shopping Frequency

This identifies which frequency groups account for the largest total recorded purchase value.

SELECT
"Frequency of Purchases",
SUM("Purchase Amount (USD)") AS "Total Purchase Value",
COUNT(*) AS "Number of Records"
FROM "customer_shopping"
GROUP BY "Frequency of Purchases"
ORDER BY SUM("Purchase Amount (USD)") DESC;


RESULTS:
Frequency of        Total Purchase     Number of
  Purchases             Value            Records
Every 3 Months	        35088	           584
Annually	        34419	           572
Quarterly        	33771              563
Bi-Weekly	        33200	           547
Monthly	                32810	           553
Fortnightly	        32007	           542
Weekly	                31786              539

INTERPRETATION

Every 3 Months recorded the highest total purchase value ($35,088), while Weekly recorded the lowest ($31,786).

Weekly shoppers did not have the highest average purchase amount; Bi-Weekly shoppers had the highest average ($60.69).

The results do not support the assumption that weekly shoppers are automatically the most valuable group.



-- ========================================================
-- SECTION 13: COMPARING GROUPS AGAINST THE OVERALL AVERAGE
-- ========================================================

Query 13.1 — Using a subquery

SELECT
"Category",
AVG("Purchase Amount (USD)") AS "Average Purchase Amount"
FROM "customer_shopping"
GROUP BY "Category"
HAVING AVG("Purchase Amount (USD)") >
(
SELECT AVG("Purchase Amount (USD)")
FROM "customer_shopping"
)
ORDER BY AVG("Purchase Amount (USD)") DESC;

RESULT:
| Category    | Average purchase amount |
| ----------- | ----------------------: |
| Footwear    |                  $60.26 |
| Clothing    |                  $60.03 |
| Accessories |                  $59.84 |

Outerwear is excluded because its average purchase amount ($57.17) is below the overall average of approximately $59.76.



-- =================================================
-- SECTION 14: FINDING THE HIGHEST-PERFORMING GROUPS
-- =================================================
Query 14.1 — Average purchase amount by age group and category

SELECT
CASE
WHEN "Age" < 30 THEN 'Young Adult'
WHEN "Age" < 50 THEN 'Adult'
ELSE 'Older Adult'
END AS "Age_Group",
"Category",
AVG("Purchase Amount (USD)") AS "Average Purchase Amount"
FROM "customer_shopping"
GROUP BY "Age_Group", "Category"
ORDER BY "Age_Group", AVG("Purchase Amount (USD)") DESC;

RESULTS:
| Age group   | Highest-performing category | Average purchase amount |
| ----------- | --------------------------- | ----------------------: |
| Young Adult | Footwear                    |                  $62.23 |
| Adult       | Outerwear                   |                  $60.22 |
| Older Adult | Clothing                    |                  $60.91 |


Interpretation
Young Adults: Footwear has the highest average purchase amount at $62.23.
Adults: Outerwear leads at $60.22.
Older Adults: Clothing leads at $60.91.

Query 14.2 — Average Purchase Amount by Payment Method Among Female Customers
SELECT
"Payment Method", AVG("Purchase Amount (USD)")
FROM customer_shopping
WHERE "Gender" = "Female"
GROUP BY "Payment Method"
ORDER BY AVG("Purchase Amount (USD)") DESC

RESULTS:

| Rank | Payment method | Average purchase amount |
| ---: | -------------- | ----------------------: |
|    1 | Debit Card     |                  $62.48 |
|    2 | PayPal         |                  $61.19 |
|    3 | Bank Transfer  |                  $59.97 |
|    4 | Credit Card    |                  $59.87 |
|    5 | Venmo          |                  $59.60 |
|    6 | Cash           |                  $58.67 |

Interpretation
Debit Card has the highest average purchase amount among female customers, at $62.48.
Cash has the lowest, at $58.67.
The difference between them is approximately $3.82 per record.
