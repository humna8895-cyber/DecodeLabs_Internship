# Task 2 — E-Commerce Sales Performance & Customer Behavior

## Project Overview

This project was completed as part of the **DecodeLabs Data Analytics Internship — Week 2, Project 2**.

The objective is to perform **Exploratory Data Analysis (EDA)** on real-world e-commerce transaction data and identify meaningful patterns in sales, products, geography, trends, correlations, and unusual transactions.

## Dataset

**Dataset:** Online Retail Dataset
**Source:** UCI Machine Learning Repository
**Period:** December 2010 – December 2011

The dataset contains transactional information including invoice numbers, products, quantities, prices, dates, customer IDs, and countries.

## Tools Used

* Python
* Pandas
* Matplotlib
* Seaborn
* Google Colab
* Jupyter Notebook

## Data Preparation

The dataset was systematically investigated before analysis.

### Duplicate Records

The original dataset contained **5,268 exact duplicate records**. These were removed from the working dataset.

* Original records: 541,909
* Records after duplicate removal: 536,641
* Duplicates removed: 5,268

### Missing Data

A total of **1,454 records with missing product descriptions** were removed after investigation.

CustomerID was missing for approximately **24.96%** of the cleaned records. These records were retained for transaction-level analysis because removing them would result in substantial data loss.

### Returns and Non-standard Transactions

Negative quantities were investigated as return/cancellation-type transactions and excluded from normal positive-sales analysis.

Non-positive unit-price records and accounting/service-related entries were also investigated separately.

### Sales Dataset

For normal sales analysis, records were filtered to:

* Quantity > 0
* UnitPrice > 0

Final sales-analysis dataset:

**524,878 records**

## Revenue Calculation

Revenue was calculated as:

`Revenue = Quantity × UnitPrice`

---

# Exploratory Data Analysis

## Descriptive Statistics

Revenue showed a substantial difference between its mean and median:

* Mean Revenue: **20.28**
* Median Revenue: **9.92**
* Q1: **3.90**
* Q3: **17.70**
* Maximum Revenue: **168,469.60**

This indicates a highly uneven revenue distribution.

## Skewness

| Variable  | Skewness |
| --------- | -------: |
| Quantity  |   469.54 |
| UnitPrice |   205.09 |
| Revenue   |   504.23 |

Revenue is extremely right-skewed, with a long upper tail caused by a relatively small number of unusually large transactions.

## Outlier Analysis

The IQR method identified **42,624 revenue outliers**, representing **8.12%** of valid sales transactions.

The upper IQR threshold was **38.40**.

These observations were not automatically removed because unusual transactions may represent legitimate bulk purchases or other valid business activity.

## Monthly Revenue

The highest recorded monthly revenue occurred in:

**November 2011 — 1,503,866.78**

The lowest occurred in:

**February 2011 — 522,545.56**

Revenue increased substantially during September–November 2011.

## Product Performance

After filtering obvious non-product/service entries, the highest-revenue products included:

* REGENCY CAKESTAND 3 TIER — 174,156.54
* PAPER CRAFT , LITTLE BIRDIE — 168,469.60
* WHITE HANGING HEART T-LIGHT HOLDER — 106,236.72
* PARTY BUNTING — 99,445.23
* JUMBO BAG RED RETROSPOT — 94,159.81

An important anomaly was observed for **PAPER CRAFT , LITTLE BIRDIE**, where 168,469.60 revenue came from a single transaction involving 80,995 units.

## Geographic Analysis

The United Kingdom generated:

**9,001,744.09**

or approximately:

**84.59% of total recorded revenue.**

This demonstrates strong geographic concentration in the dataset.

## Correlation Analysis

| Variable Pair        | Pearson r |
| -------------------- | --------: |
| Quantity – Revenue   |     0.907 |
| UnitPrice – Revenue  |     0.137 |
| Quantity – UnitPrice |    -0.004 |

Quantity and Revenue show a strong positive relationship. However, this relationship is partly mechanical because Revenue was calculated using Quantity and UnitPrice.

Correlation does not establish causation.

---

# Key Business KPIs

| KPI                 |        Result |
| ------------------- | ------------: |
| Total Revenue       | 10,642,110.80 |
| Total Units Sold    |     5,572,420 |
| Total Orders        |        19,960 |
| Average Order Value |        533.17 |
| Unique Products     |         4,026 |
| Countries Served    |            38 |

The calculated average units per order was **279.18**, but this value is strongly influenced by extreme bulk transactions and should not be interpreted as a typical customer order size.

---

# Key Business Insights

1. Revenue is highly concentrated in the UK market.
2. Revenue increased considerably during September–November 2011.
3. Transaction-level revenue is extremely right-skewed.
4. A relatively small number of extreme transactions have a substantial effect on average revenue.
5. Product performance varies considerably, with several products generating substantially more revenue than others.
6. Quantity has a strong mathematical relationship with revenue because revenue is calculated from quantity and unit price.
7. Data-quality investigation is essential before interpreting extreme observations.

# Recommendations

* Monitor geographic revenue concentration and investigate opportunities for market diversification.
* Investigate the reasons behind the September–November revenue increase.
* Review extreme transactions individually before treating them as errors.
* Evaluate products using revenue, units sold, and transaction frequency together.
* Maintain separate classifications for sales, returns, postage, fees, and accounting adjustments.
* Use median and distribution-based statistics alongside averages when reporting transaction-level performance.

# Conclusion

This project demonstrates an end-to-end EDA workflow, from raw data inspection and data-quality investigation to statistical analysis, visualization, outlier detection, correlation analysis, and business interpretation.

The analysis converts a large transactional dataset into evidence-based insights while distinguishing unusual business activity from potential data-quality issues.

## Project File

* `E-Commerce_Sales_EDA.ipynb` — Complete Python EDA notebook.

## Author

**Hamna Shabbir**
DecodeLabs Data Analytics Intern
