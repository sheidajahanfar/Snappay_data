# Credit Default Risk Analysis for LendTech


### Project Overview

This project explores credit usage behavior using SQL and Python. The dataset contains customer-level information such as credit consumption, upgrade patterns, and demographic details for a LendTech platform. The focus is on data preparation, feature engineering, and exploratory data analysis (EDA) and then predict customer credit default risk using both statistical and machine learning methods.

### Objectives

Identify key factors influencing customer default risk.

Engineer meaningful features such as repayment delay ratios, full usage ratios, and average spend per order.

Build and compare predictive models (Logistic Regression, Random Forest).

Provide actionable insights to inform credit policies, customer segmentation, and early intervention strategies.

### Data

The dataset includes anonymized customer-level features such as:

age

external_credit_score

total_credit_usage_amount

total_credit_usage_count

total_full_credit_usage_count

total_repayment_delay_count

snappfood_orders_count

Engineered features:

delay_ratio – fraction of delayed repayments per transaction

full_usage_ratio – fraction of transactions with full credit utilization

avg_spend_order – average spending per order

Binned credit scores (low / medium / high)

### Methodology

Exploratory Data Analysis (EDA) – examine distributions, correlations, and feature-target relationships.

Univariate and Multivariate Logistic Regression – identify significant predictors of default.

Feature Engineering – create ratios and bins to capture subtle patterns in customer behavior.

Predictive Modeling – baseline logistic regression, Random Forest.

Model Evaluation – metrics include accuracy, precision, recall, F1-score, and ROC-AUC.

### Key Insights

Repayment delays are the strongest predictor of default.

Credit score and age are also significant.

Raw usage counts lose significance once repayment delays are accounted for.

Engineered features improve predictive power and interpretability.

### Predictive Modeling Results

<img width="837" height="214" alt="Screenshot 2025-09-25 at 18 46 19" src="https://github.com/user-attachments/assets/bbd45fb1-3af1-42c8-88b9-ff06835a6a2a" />


Logistic regression performs slightly better on ranking risk and minority class recall, indicating strong linear relationships in the data.
