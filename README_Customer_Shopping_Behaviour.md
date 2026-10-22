# Customer Shopping Behaviour Analysis Using SQL

## Project overview

This independent portfolio project uses SQL in SQLite to explore the
Customer Shopping Trends dataset. It examines recorded purchase amounts,
product categories, customer demographics, subscriptions, discounts,
payment methods, review ratings, and reported shopping frequency.

**Tools:** SQLite, DB Browser for SQLite, SQL, and a text editor\
**Dataset:** Customer Shopping Trends Dataset (Kaggle)\
**Records analysed:** 3,900\
**Project type:** Independent practice/portfolio project using a public
dataset; not client work.

## Business questions

-   What is the overall recorded purchase value and average purchase
    amount?
-   Which product categories have the most records and highest recorded
    purchase value?
-   How do average purchase amounts vary by gender and age group?
-   How do subscription status and discount status compare?
-   How do payment methods and reported shopping frequency differ?
-   What limitations should be considered before making business
    decisions?

## Key findings

-   The dataset contains **3,900 records** and **\$233,081** in total
    recorded purchase value. The average recorded purchase amount is
    approximately **\$59.76**.
-   **Clothing** has the most records (**1,737**) and the highest total
    recorded purchase value (**\$104,264**).
-   **Footwear** has the highest average purchase amount by category
    (about **\$60.26**), while Outerwear has the lowest (about
    **\$57.17**).
-   Female records have a slightly higher average purchase amount
    (**\$60.25**) than male records (**\$59.54**), while male records
    have a higher total because there are more male records.
-   Young Adults have the highest average purchase amount across the
    three age groups (about **\$60.26**); Older Adults have the highest
    total recorded purchase value (**\$93,410**), in part because this
    group has the most records.
-   Records without a discount have a higher average purchase amount
    (**\$60.13**) than records with a discount (**\$59.28**). This is an
    association in the dataset and does not prove discounts cause lower
    spending.
-   Debit Card has the highest average purchase amount across all
    records by payment method (about **\$60.92**). Among female records,
    Debit Card also has the highest average (about **\$62.48**).
-   "Every 3 Months" has the highest total recorded purchase value by
    reported shopping frequency (**\$35,088**), while "Weekly" has the
    lowest (**\$31,786**).

## Data quality checks

The analysis checked: - Total record count and table structure. -
Missing values in selected fields, including purchase amount, review
rating, and subscription status. - Duplicate Customer IDs. -
Non-positive purchase amounts. - Ages below 18 and the observed age
range. - Review ratings outside the 1--5 range.

The checks performed found 3,900 distinct Customer IDs, no missing
values in the selected fields, no non-positive purchase amounts, no ages
below 18, and no review ratings outside 1--5. The observed age range was
18--70.

## SQL skills demonstrated

-   `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT`
-   Aggregate functions: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and
    `MAX()`
-   `GROUP BY` and `HAVING`
-   Conditional grouping with `CASE`
-   Subqueries for comparison with an overall average
-   Data quality checks and interpretation of grouped results

## Important limitations

-   Each Customer ID appears once, so the dataset provides one record
    per customer rather than repeated, dated transaction history.
    Reported shopping frequency should not be treated as a verified
    transaction timeline.
-   The dataset contains recorded purchase amounts, not costs or profit
    margins. Purchase value is not the same as profit.
-   Differences between groups do not establish cause and effect. For
    example, the analysis cannot prove that discounts reduce purchase
    amounts or that payment method causes higher spending.
-   Total values are influenced by the number of records in each group;
    averages and record counts should be considered together.
-   The labels "Quarterly" and "Every 3 Months" may describe similar
    frequencies, as may "Bi-Weekly" and "Fortnightly." They were kept
    separate rather than merged without a documented rule.
-   The findings describe this dataset and should not automatically be
    generalised to every retail business.

## Files

-   `Customer_Shopping_Behaviour_Analysis.sql` --- SQL queries, results,
    and interpretation comments.
-   `Customer_Shopping_Behaviour_Findings_Report.pdf` --- summary report
    with charts.

## Dataset source

Customer Shopping Trends Dataset, Kaggle:
https://www.kaggle.com/datasets/iamsouravbanerjee/customer-shopping-trends-dataset
