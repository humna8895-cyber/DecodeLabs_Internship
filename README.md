# DecodeLabs Internship — Task 2

## E-Commerce Sales Performance & Customer Behavior — Exploratory Data Analysis

### Project Overview

This project was completed as part of **Week 2 — Project 2** of the DecodeLabs Data Analytics Internship.

The objective of this project is to perform **Exploratory Data Analysis (EDA)** on real-world e-commerce transaction data and transform raw transaction records into meaningful business insights.

The analysis focuses on:

* Data quality and preparation
* Descriptive statistics
* Distribution and skewness
* Outlier detection
* Monthly revenue trends
* Product performance
* Geographic revenue distribution
* Correlation analysis
* Business KPIs
* Business implications and recommendations

---

## Dataset

**Dataset:** Online Retail Dataset

**Source:** UCI Machine Learning Repository — Online Retail Dataset

The dataset contains transactional records from a UK-based online retail business covering transactions from **December 2010 to December 2011**.

### Original Variables

| Variable    | Description                  |
| ----------- | ---------------------------- |
| InvoiceNo   | Invoice/transaction number   |
| StockCode   | Product code                 |
| Description | Product description          |
| Quantity    | Number of units purchased    |
| InvoiceDate | Date and time of transaction |
| UnitPrice   | Price per unit               |
| CustomerID  | Customer identifier          |
| Country     | Customer country             |

---

## Tools & Technologies

* **Python**
* **Pandas**
* **Matplotlib**
* **Seaborn**
* **Google Colab**
* **Jupyter Notebook**

---

## Data Preparation & Quality Checks

The raw dataset was systematically investigated before performing the EDA.

### Duplicate Records

The original dataset contained **5,268 exact duplicate records**.

These duplicate rows were removed from the working dataset.

* Original records: **541,909**
* After duplicate removal: **536,641**
* Duplicates removed: **5,268**
* Remaining exact duplicates: **0**

### Missing Values

The `Description` field contained missing values. Investigation showed that these records also had zero unit prices and missing CustomerIDs.

Because these records did not represent usable product-level sales observations, **1,454 records with missing descriptions were removed**.

`CustomerID` was missing in approximately **24.96%** of the cleaned records. These records were retained because removing them would result in substantial transaction-level data loss. CustomerID was therefore not required for the main transaction-level sales analysis.

### Returns and Cancellations

Negative quantities were investigated rather than automatically treated as errors.

Many negative-quantity transactions were associated with invoice numbers beginning with `C`, indicating cancellation/return-type transactions.

These records were retained in the cleaned master dataset but excluded from the positive-sales dataset used for normal sales analysis.

### Negative Unit Prices

Negative unit-price records were also investigated separately because they represented non-standard accounting-related entries rather than normal product sales.

### Sales Analysis Dataset

For normal sales analysis, only records satisfying:

* `Quantity > 0`
* `UnitPrice > 0`

were included.

Final sales-analysis records:

**524,878**

---

## Revenue Calculation

A new revenue variable was created using:

```text
Revenue = Quantity × UnitPrice
```

This allowed transaction-level and aggregated revenue analysis.

---

# Exploratory Data Analysis

## 1. Descriptive Statistics

The descriptive statistics revealed substantial differences between the mean and median values.

| Metric  | Quantity | Unit Price |    Revenue |
| ------- | -------: | ---------: | ---------: |
| Mean    |    10.62 |       3.92 |      20.28 |
| Median  |     4.00 |       2.08 |       9.92 |
| Q1      |     1.00 |       1.25 |       3.90 |
| Q3      |    11.00 |       4.13 |      17.70 |
| Maximum |   80,995 |  13,541.33 | 168,469.60 |

The large difference between mean and median values indicates that extreme observations substantially influence the distributions.

---

## 2. Skewness Analysis

The distributions were highly right-skewed.

| Variable   | Skewness |
| ---------- | -------: |
| Quantity   |   469.54 |
| Unit Price |   205.09 |
| Revenue    |   504.23 |

Revenue had a particularly high skewness value of **504.23**, indicating a long right tail caused by a relatively small number of extremely large observations.

---

## 3. Revenue Distribution

The revenue histogram showed that most transaction-level revenue values were concentrated close to the lower end of the distribution, while a small number of observations extended far into the upper range.

This demonstrates that transaction revenue is not normally distributed and that extreme values have a strong influence on the mean.

---

## 4. Revenue Outlier Analysis

The IQR method was used to identify unusual revenue observations.

### Five-number summary

* Q1 = **3.90**
* Median = **9.92**
* Q3 = **17.70**
* IQR = **13.80**

The upper outlier threshold was:

```text
Q3 + 1.5 × IQR = 38.40
```

The analysis identified:

**42,624 revenue outliers**

representing approximately:

**8.12% of valid sales transactions**

These observations were **not automatically deleted**, because an outlier is not necessarily an error. Some may represent legitimate bulk purchases or unusual business transactions.

---

## 5. Extreme Transaction Investigation

Several extreme transactions were examined individually.

One notable transaction recorded:

* Quantity: **80,995 units**
* Unit price: **2.08**
* Revenue: **168,469.60**

This demonstrates why extreme observations require investigation before being removed.

The presence of such transactions can substantially influence average revenue and aggregate product performance.

---

## 6. Monthly Revenue Trend

Monthly revenue was analyzed from December 2010 through December 2011.

### Highest Revenue Month

**November 2011 — 1,503,866.78**

### Lowest Revenue Month

**February 2011 — 522,545.56**

Revenue showed fluctuations during the first part of 2011, followed by a strong increase during September–November, with November recording the highest monthly revenue.

December 2011 should be interpreted cautiously because the dataset ends in December and may not represent a complete month.

---

## 7. Product Performance

Non-product/service descriptions such as postage, manual entries, fees, and adjustments were filtered when creating the actual-product revenue ranking.

### Top Products by Revenue

| Rank | Product                            |    Revenue |
| ---: | ---------------------------------- | ---------: |
|    1 | REGENCY CAKESTAND 3 TIER           | 174,156.54 |
|    2 | PAPER CRAFT , LITTLE BIRDIE        | 168,469.60 |
|    3 | WHITE HANGING HEART T-LIGHT HOLDER | 106,236.72 |
|    4 | PARTY BUNTING                      |  99,445.23 |
|    5 | JUMBO BAG RED RETROSPOT            |  94,159.81 |
|    6 | MEDIUM CERAMIC TOP STORAGE JAR     |  81,700.92 |
|    7 | RABBIT NIGHT LIGHT                 |  66,870.03 |
|    8 | PAPER CHAIN KIT 50'S CHRISTMAS     |  64,875.59 |
|    9 | ASSORTED COLOUR BIRD ORNAMENT      |  58,927.62 |
|   10 | CHILLI LIGHTS                      |  54,096.36 |

An important data-quality observation is that **PAPER CRAFT , LITTLE BIRDIE** generated 168,469.60 from a single transaction involving 80,995 units. Therefore, revenue rankings should be interpreted together with transaction frequency and quantity.

---

## 8. Geographic Revenue Analysis

Revenue was aggregated by country.

The **United Kingdom** generated:

**9,001,744.09**

which represents:

**84.59% of total recorded revenue.**

Other major revenue-generating countries included the Netherlands, EIRE, Germany, France, and Australia.

The strong UK concentration means that this dataset is heavily weighted toward the UK market and should not be interpreted as representative of global e-commerce behavior.

---

## 9. Correlation Analysis

Pearson correlation was calculated between Quantity, UnitPrice, and Revenue.

| Variable  | Quantity | UnitPrice | Revenue |
| --------- | -------: | --------: | ------: |
| Quantity  |    1.000 |    -0.004 |   0.907 |
| UnitPrice |   -0.004 |     1.000 |   0.137 |
| Revenue   |    0.907 |     0.137 |   1.000 |

### Key observations

* Quantity and Revenue: **r = 0.907**
* UnitPrice and Revenue: **r = 0.137**
* Quantity and UnitPrice: **r = -0.004**

The strong Quantity–Revenue relationship is expected in part because revenue was directly calculated as:

```text
Revenue = Quantity × UnitPrice
```

Therefore, the correlation should **not be interpreted as evidence that quantity independently causes revenue**.

As always, correlation does not establish causation.

---

## 10. Key Business KPIs

| KPI                     |        Result |
| ----------------------- | ------------: |
| Total Revenue           | 10,642,110.80 |
| Total Units Sold        |     5,572,420 |
| Total Orders            |        19,960 |
| Average Order Value     |        533.17 |
| Average Units per Order |        279.18 |
| Unique Products         |         4,026 |
| Countries Served        |            38 |

The average units per order is strongly influenced by extreme bulk transactions and therefore should not be interpreted as a typical customer order size.

---

# Key Findings

1. The dataset contains **10.64 million in recorded revenue** across 19,960 orders.
2. The UK contributes **84.59% of total recorded revenue**.
3. November 2011 recorded the highest monthly revenue at **1.50 million**.
4. Revenue is extremely right-skewed, with skewness of **504.23**.
5. **8.12%** of valid sales transactions were identified as revenue outliers using the IQR method.
6. Extreme bulk transactions can substantially influence revenue statistics.
7. Regency Cakestand 3 Tier recorded the highest revenue among the filtered actual products.
8. Quantity and Revenue have a strong positive correlation (**r = 0.907**), partly because revenue is calculated from quantity and unit price.
9. UnitPrice and Revenue have a weak positive correlation (**r = 0.137**).
10. Data-quality issues were investigated systematically rather than blindly removing unusual observations.

---

# Business Implications

### Geographic Concentration

The high proportion of revenue generated in the UK indicates substantial geographic concentration. Future analysis could examine international market development and revenue diversification.

### Seasonal Revenue Patterns

The strong increase in revenue during September–November provides an opportunity to investigate seasonal purchasing behavior, promotional activity, and holiday-related demand.

### Outlier Management

Large transactions should be investigated individually. Automatically deleting outliers could remove legitimate bulk purchases and distort business results.

### Product Performance

Product performance should be evaluated using multiple indicators such as revenue, units sold, and transaction frequency rather than revenue alone.

### Data Governance

Separating normal sales from returns, postage, fees, manual entries, and accounting adjustments can improve the reliability of future dashboards and business reports.

---

# Recommendations

1. **Monitor geographic concentration** and evaluate opportunities for broader international revenue distribution.
2. **Investigate seasonal patterns**, particularly the strong September–November revenue increase.
3. **Review extreme transactions separately** to distinguish legitimate bulk purchases from potential data-quality issues.
4. **Evaluate products using multiple KPIs**, including revenue, units sold, and transaction frequency.
5. **Maintain separate transaction categories** for sales, returns, postage, fees, and accounting adjustments.
6. **Use median and distribution-based measures alongside averages** when reporting transaction-level performance because of the highly skewed data.

---

# Conclusion

This EDA project demonstrates how systematic data cleaning, statistical analysis, visualization, and business interpretation can transform a large transactional dataset into actionable analytical insights.

The analysis identified important patterns in revenue, products, geography, time, correlations, and unusual transactions while maintaining a clear distinction between genuine business variation and potential data-quality issues.

The project demonstrates an end-to-end workflow from **raw transactional data → data quality investigation → exploratory analysis → visualization → business insights and recommendations**.

---

## Project Files

* `E-Commerce_Sales_EDA.ipynb` — Complete Python EDA notebook
* `README.md` — Project documentation

## Skills Demonstrated

**Python | Pandas | Matplotlib | Seaborn | Data Cleaning | Exploratory Data Analysis | Descriptive Statistics | Outlier Detection | IQR Analysis | Data Visualization | Time-Series Analysis | Correlation Analysis | Business Analytics | Data Storytelling**

---

## Author

**Hamna Shabbir**

Data Analytics Intern | Geography Graduate
Interests: Data Analytics, GIS, Spatial Analysis, Environmental & Urban Analytics
