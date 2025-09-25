
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


**3. Total Full Credit Usage Count**
Observation: Users who repeatedly fully use their credit line are significantly more likely to default. 
Interpretation: number of fully using accounts can be directly related to likelihood of default. as almost all of them fully used their credit more than 5 times , I am thinking about making a binary variable (≥6 full usages) here.
Business Insight: Customers that fully use their credits more and more, are prone to default.

**4. External Credit Score**

Observation: Non-defaulters are concentrated at higher scores (550+).

Defaulters dominate at lower scores (300–450).

Interpretation: External score works as expected — higher score = lower default risk.

Business Insight: This is a strong signal and likely one of the best predictors.

**5. Total Credit Usage Count**

Observation:Both groups overlap, but defaulters appear more frequent at lower counts.

Interpretation: More transactions = more financial activity, which correlates with lower default probability (financially active customers are healthier)

Business Insight: Customers with very few credit transactions may be higher risk.

**6. Total Repayment Delay Count**

Observation: Clear separation: defaulters dominate at high values (15–20 delays).

Non-defaulters cluster at low values.

Interpretation: This is gold. Repayment delays are a direct red flag for default.

Business Insight: A monitoring rule could flag anyone with >10 delays as high risk.


**7. Snappfood Orders Count**
Observation:

Defaulters dominate at low order counts.

Non-defaulters dominate at high order counts (>500).

Interpretation: Weird but interesting! Customers who order food more often are less likely to default (maybe correlated with stable income or lifestyle).

Business Insight: Alternative behavioral data (like food delivery activity) can be a surprisingly strong predictor.

# Quantify observations

First, I calculated the correlations and ranked them based on this measure:

1-Total repayment delay count (0.446, +) → strongest positive correlation → biggest risk driver.

2-External credit score (-0.339) → strong protective factor.

3-Snappfood orders count (-0.167) → engagement reduces default risk.

4-Age (-0.068) → younger = riskier, but weaker effect.

5-Total credit usage count (+0.053) → small risk driver.

6-Total credit usage amount (+0.045) → small risk driver.

7-Total full credit usage count (+0.017) → almost no correlation (may still matter in interactions).


Then, I ran a univariate logistic regressions for each feature against default status and put the results in a Table

<img width="1039" height="211" alt="Screenshot 2025-09-25 at 17 07 28" src="https://github.com/user-attachments/assets/7a07d95b-eb9f-4621-88e0-731bf267c138" />


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
