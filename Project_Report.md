
# Project Overview

This project explores credit usage behavior using SQL and Python. The dataset contains customer-level information such as credit consumption, upgrade patterns, and demographic details. The focus is on data preparation, feature engineering, and exploratory data analysis (EDA) to build a foundation for predictive modeling of default events.


# Business Problem

Snappay is a LendTech company providing customers with interest-free credit for purchasing goods. The company earns revenue from commissions on merchant sales.

**Key challenges:**

-Default risk: If customers fail to repay their credit (i.e., “default”), the company loses money and may have to slow down lending.

-Growth limitation: Expanding credit to new users without understanding risk could lead to cash flow issues.

-Optimization of credit allocation: Identifying safe vs. risky customers allows the company to grow smarter, lending more to low-risk users while minimizing exposure to high-risk users.

# Why This Analysis Matters
Goal: Predict and understand which users are more likely to default, and identify behaviors that signal financial risk.

**Business impact:**

-Increase credit allocation to low-risk users, boosting revenue.

-Reduce defaults by identifying risky users early.

-Optimize product strategy by understanding credit usage patterns.

-Provide actionable insights for marketing, loyalty programs, and credit upgrades.

**Data-driven decision-making:**

By analyzing customer behavior (credit usage, repayment history, engagement with Snapp services), Snappay can:

Build risk models for smarter lending.

Design personalized offers or limits to maximize repayment and user satisfaction.

Improve business growth sustainably, without overexposing the company to default risk.


# Data Description

 The table data has 80K rows with these columns:  

<img width="1537" height="775" alt="image" src="https://github.com/user-attachments/assets/552178ea-406f-4062-a4c0-99493f029d65" />



    
  
# CLeaning process 

Data quality checks were performed to ensure reliable analysis:

-**Missing Values:** All credit-related columns (e.g., total usage count, full usage count) were checked for NULL values. No major missing values were found that required imputation.

-**Inconsistent Ratios:** A key derived feature was Full Usage Ratio:(Full Usage Ratio=Total Full Credit Usage Count/Total Credit Usage Count)

Ideally, this ratio should always fall between 0 and 1. However, ~4,000 records showed ratios greater than 1, which is logically impossible (full usage cannot exceed total usage).    

**-Resolution:**These anomalies likely reflect data entry or aggregation errors. Since the dataset is sufficiently large, the safest decision was to remove these ~4,000 rows to avoid distorting downstream analysis.


# Methodology

**1.EDA and visualization in Python**

I used pandas + matplotlib/seaborn to summarize all numeric features quickly and Check distributions, outliers, skewness.I believe this approach is fast  and gives a solid sense of the data before modeling.

# Analysis & Findings

From the EDA step, I was able to draw insightful information about the correlation of important metrics in defaul risk:


<img width="1174" height="659" alt="Screenshot 2025-09-25 at 15 43 15" src="https://github.com/user-attachments/assets/9e77322a-5d9f-4026-adfb-ff1bf404846d" />

**Interpretation:**

**1-Age by Default Status**

Observation: Defaulters (orange) seem more concentrated in the late 20s to mid-30s.

Non-defaulters (blue) are more common in late 40s to 50s.

Interpretation: Younger borrowers may carry higher default risk (possibly less stable income, less financial experience).

Business Insight: Age could be a risk segmenting factor. 



**2. Total Credit Usage Amount**
Observation: Both groups skew heavily toward lower values (long right tail).

Defaulters and non-defaulters overlap a lot, but defaulters seem a bit more concentrated at higher usage amounts.

Interpretation: Very high credit usage is associated with increased likelihood of default.

Business Insight: Customers with unusually high spending relative to peers may need tighter monitoring.

5. Analysis & Findings

Present insights from your queries (in words, not just SQL)

Use simple tables or even charts (you can save them as .png in a /docs folder and embed them in Markdown like ![Alt text](docs/plot.png))

Connect each insight back to the business case

6. Business Implications

What actions could a company take based on your findings?

Example: “Customers with late payments in the first 3 months are X% more likely to default. Lenders should implement early-warning systems.”

7. Limitations & Next Steps

Be honest about what your analysis can’t do (e.g., limited dataset, SQL only, no predictive modeling yet)

Suggest what could be added if you had more time/resources

8. Conclusion

Wrap up in 3–4 sentences: what you found, why it’s important, and how it could be used in a real business context
