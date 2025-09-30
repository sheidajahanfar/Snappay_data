
# Project Overview

This project explores credit usage behavior using SQL and Python. The dataset contains customer-level information such as credit consumption, upgrade patterns, and demographic details for a LendTech platform. The focus is on data preparation, feature engineering, and exploratory data analysis (EDA) and then predict customer credit default risk using both statistical and machine learning methods.



# Business Problem

Snappay is a LendTech company providing customers with interest-free credit for purchasing goods. The company earns revenue from commissions on merchant sales.

### Key challenges:

-Default risk: If customers fail to repay their credit (i.e., “default”), the company loses money and may have to slow down lending.

-Growth limitation: Expanding credit to new users without understanding risk could lead to cash flow issues.

-Optimization of credit allocation: Identifying safe vs. risky customers allows the company to grow smarter, lending more to low-risk users while minimizing exposure to high-risk users.

# Why This Analysis Matters
Goal: Predict and understand which users are more likely to default, and identify behaviors that signal financial risk.

### Business impact:

-Increase credit allocation to low-risk users, boosting revenue.

-Reduce defaults by identifying risky users early.

-Optimize product strategy by understanding credit usage patterns.

-Provide actionable insights for marketing, loyalty programs, and credit upgrades.

### Data-driven decision-making:

By analyzing customer behavior (credit usage, repayment history, engagement with Snapp services), Snappay can:

-Build risk models for smarter lending.

-Design personalized offers or limits to maximize repayment and user satisfaction.

-Improve business growth sustainably, without overexposing the company to default risk.


# Data Description

 The table data has 80K rows with these columns:  

<img width="1537" height="775" alt="image" src="https://github.com/user-attachments/assets/552178ea-406f-4062-a4c0-99493f029d65" />



    
  
# Cleaning process 

Data quality checks were performed to ensure reliable analysis:

-**Missing Values:** All credit-related columns (e.g., total usage count, full usage count) were checked for NULL values. No major missing values were found that required imputation.

-**Inconsistent Ratios:** A key derived feature was Full Usage Ratio:(Full Usage Ratio=Total Full Credit Usage Count/Total Credit Usage Count)

Ideally, this ratio should always fall between 0 and 1. However, ~4,000 records showed ratios greater than 1, which is logically impossible (full usage cannot exceed total usage).    

**-Resolution:** These anomalies likely reflect data entry or aggregation errors. Since the dataset is sufficiently large, the safest decision was to remove these ~4,000 rows to avoid distorting downstream analysis.


# Lets Dive in

### EDA and visualization in Python

I used pandas + matplotlib/seaborn to summarize all numeric features quickly and Check distributions, outliers, skewness.I believe this approach is fast  and gives a solid sense of the data before modeling.


From the EDA step, I was able to draw insightful information about the correlation of important metrics in defaul risk:


<img width="1174" height="659" alt="Screenshot 2025-09-25 at 15 43 15" src="https://github.com/user-attachments/assets/9e77322a-5d9f-4026-adfb-ff1bf404846d" />


### Interpretation:

**1-Age by Default Status:**

-Defaulters (orange) seem more concentrated in the late 20s to mid-30s.

-Non-defaulters (blue) are more common in late 40s to 50s.

-Younger borrowers may carry higher default risk (possibly less stable income, less financial experience).

-Business Insight: Age could be a risk segmenting factor. 


  
**2. Total Credit Usage Amount:**

-Both groups skew heavily toward lower values (long right tail).

-Defaulters and non-defaulters overlap a lot, but defaulters seem a bit more concentrated at higher usage amounts.

- Very high credit usage is associated with increased likelihood of default.

-Business Insight: Customers with unusually high spending relative to peers may need tighter monitoring.


**3. Total Full Credit Usage Count:**

-Users who repeatedly fully use their credit line are significantly more likely to default. 

-number of fully using accounts can be directly related to likelihood of default. as almost all of them fully used their credit more than 5 times , I am thinking about making a binary variable (≥6 full usages) here.

-Business Insight: Customers that fully use their credits more and more, are prone to default.

**4. External Credit Score:**

-Non-defaulters are concentrated at higher scores (550+).

-Defaulters dominate at lower scores (300–450).

-External score works as expected — higher score = lower default risk.

-Business Insight: This is a strong signal and likely one of the best predictors.

**5. Total Credit Usage Count:**

-Both groups overlap, but defaulters appear more frequent at lower counts.

-More transactions = more financial activity, which correlates with lower default probability (financially active customers are healthier)

-Business Insight: Customers with very few credit transactions may be higher risk.

**6. Total Repayment Delay Count:**

-Clear separation: defaulters dominate at high values (15–20 delays).

-Non-defaulters cluster at low values.

-This is gold. Repayment delays are a direct red flag for default.

-Business Insight: A monitoring rule could flag anyone with >10 delays as high risk.


**7. Snappfood Orders Count:**

-Defaulters dominate at low order counts.

-Non-defaulters dominate at high order counts (>500).

-Weird but interesting! Customers who order food more often are less likely to default (maybe correlated with stable income or lifestyle).

-Business Insight: Alternative behavioral data (like food delivery activity) can be a surprisingly strong predictor.


### Quantify observations

First, I calculated the correlations and ranked them based on this measure:

1-Total repayment delay count (0.446, +) → strongest positive correlation → biggest risk driver.

2-External credit score (-0.339) → strong protective factor.

3-Snappfood orders count (-0.167) → engagement reduces default risk.

4-Age (-0.068) → younger = riskier, but weaker effect.

5-Total credit usage count (+0.053) → small risk driver.

6-Total credit usage amount (+0.045) → small risk driver.

7-Total full credit usage count (+0.017) → almost no correlation (may still matter in interactions).


### univariate logistic regressions

As the default risk was binary, I ran univariate logistic regressions for each feature against default status and put the results in a Table

<img width="1039" height="211" alt="Screenshot 2025-09-25 at 17 07 28" src="https://github.com/user-attachments/assets/7a07d95b-eb9f-4621-88e0-731bf267c138" />


### Interpretation:
-Strongest risk factors (positive): repayment delays, frequent/maxed-out credit usage.

-Protective factors (negative): older age, higher external credit score, higher SnappFood engagement.

-Weaker but still significant risks: total spending and total usage count.




### multivariate logistic regression
My Next step is to run a multivariate logistic regression to  See which features remain significant when included together, and how their coefficients change compared to the univariate models:



<img width="854" height="416" alt="Screenshot 2025-09-25 at 17 35 27" src="https://github.com/user-attachments/assets/992c7dff-6903-4ad5-9759-4be75c1cb65b" />




###  Insights:

-Dominant predictor: total_repayment_delay_count  captures most of the default risk.

-Features losing importance: Usage amounts/counts become insignificant when delay is included — they were likely correlated with delays.

-Credit score still matters, independent of delays.

-Age and orders remain significant — subtle but meaningful effects.

**And this shows why multivariate models are crucial: univariate correlations can be misleading.**



# Business Implications of this information

1-Monitor repayment behavior closely, Focus on total_repayment_delay_count.

Intervene early when customers start showing delays: Flag high-delay customers for manual review or stricter credit limits.

2-Leverage credit score for risk-based decisions: Use external_credit_score to assign credit limits or pricing.

Offer lower limits or stricter terms for low-score customers.

3-Segment customers by age and engagement: Younger customers → higher risk → closer monitoring.

Engaged users (snappfood_orders_count high) → lower risk → consider incentives to retain them.

4- Focus on risk-adjusted growth, not just usage Raw credit usage alone doesn’t predict default; don’t give high limits blindly.


# Some useful ratios:

I want to Make features more informative by combining raw variables into meaningful ratios.

-Delays per usage: Captures default risk relative to activity. A user with many delays but few transactions is riskier than someone with same delays but many transactions.

-Full usage ratio: how often the user maxed out credit, controlling for activity.

-Average spend per order: spending behavior per order, rather than total usage.


# Predictive modeling:  

Lets start with a benchmark and then more complex one:  

### 1-Baseline Logistic Regression

A simple, interpretable model to serve as a benchmark:

<img width="800" height="172" alt="Screenshot 2025-09-25 at 18 40 49" src="https://github.com/user-attachments/assets/13ec3635-bcc5-4a1b-ae4f-689399c8e624" />

**Model's overall performance** 

-Accuracy: 0.91 → 91% of predictions are correct.

-Macro avg: 0.82 → averages metrics ignoring class imbalance.

-Weighted avg: 0.90 → averages metrics considering class imbalance.

-ROC-AUC: 0.953 → excellent discriminative ability. Model distinguishes defaulters vs non-defaulters very well.

-Logistic regression captures the main signal (repayment delays, age, credit score).

-Performance on minority class (defaulters) is lower (recall 0.64). This is expected with class imbalance.


### 2-Random Forest Classifier

Surprisingly, Random Forest did not outperform logistic regression here.

Possible reasons:

-Strong linear signal in the dataset (repayment_delay_count, external_credit_score, age).

-Random Forest may overfit the majority class despite class_weight='balanced'.

-Feature engineering may not introduce strong non-linear patterns for RF to exploit.  

<img width="837" height="214" alt="Screenshot 2025-09-25 at 18 46 19" src="https://github.com/user-attachments/assets/5b7e0a89-f4b1-4eb9-8afe-54b65fe04c08" />




**Baseline Model: Logistic Regression:**
-Accuracy: 91%

-ROC-AUC: 0.953 → excellent ability to distinguish high-risk customers

-Defaulter recall: 64% → model identifies most defaulters, but some are missed

**Random Forest Model:**

-Accuracy: 90%

-ROC-AUC: 0.946

-Slightly lower recall for defaulters (61%)



# Business Implications

### Proactive Risk Management

-Focusing on customers with high repayment delay ratios and low credit scores for early intervention.

-Using the logistic regression model to assign risk scores and prioritize follow-up.

### Customer Segmentation

-Considering segmenting customers based on age, credit score bins, and usage behavior.

-Targeted communication or credit limits can be adjusted per segment.

### Monitoring & Reporting

-Track the engineered ratios (delays per transaction, full usage ratio) monthly.

-Integrate predictive scores into dashboards for continuous monitoring.


Thank you for your attention

Sheida Jahanfar

