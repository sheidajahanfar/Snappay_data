# Credit Default Risk Analysis for LendTech


### Project Overview

This project analyzes and predicts customer credit default risk for a LendTech platform. It combines statistical analysis, feature engineering, and machine learning models to identify high-risk customers and support proactive risk management.

Objectives

Identify key factors influencing customer default risk.

Engineer meaningful features such as repayment delay ratios, full usage ratios, and average spend per order.

Build and compare predictive models (Logistic Regression, Random Forest, XGBoost).

Provide actionable insights to inform credit policies, customer segmentation, and early intervention strategies.

Data

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

Methodology

Exploratory Data Analysis (EDA) – examine distributions, correlations, and feature-target relationships.

Univariate and Multivariate Logistic Regression – identify significant predictors of default.

Feature Engineering – create ratios and bins to capture subtle patterns in customer behavior.

Predictive Modeling – baseline logistic regression, Random Forest, and XGBoost.

Model Evaluation – metrics include accuracy, precision, recall, F1-score, and ROC-AUC.

Key Insights

Repayment delays are the strongest predictor of default.

Credit score and age are also significant.

Raw usage counts lose significance once repayment delays are accounted for.

Engineered features improve predictive power and interpretability.

Predictive Modeling Results
Model	Accuracy	ROC-AUC	Defaulter Recall
Logistic Regression	91%	0.953	64%
Random Forest	90%	0.946	61%

Logistic regression performs slightly better on ranking risk and minority class recall, indicating strong linear relationships in the data.
