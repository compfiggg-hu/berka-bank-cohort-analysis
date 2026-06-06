# Berka Cohort Analysis: Early Transaction Patterns and Credit Risk

## Objective
Do early transaction behaviors — frequency, balance trajectory, 
withdrawal patterns — predict which accounts default on loans?

## Dataset
- Berka Czech bank dataset (1993–1998)
- 1,056,320 transactions across 8 tables
- Source: Kaggle

## Tools & Pipeline
Raw CSVs → BigQuery (date conversion + feature engineering + cohort table)
→ R (logistic regression + odds ratios)
→ Tableau (dashboard)

## Key Findings
- Low frequency accounts (1–4 transactions in first 90 days) 
  default at 25% vs 9.6% for moderate frequency accounts
- active_months_3m is the strongest predictor — odds ratio 0.80, 
  meaning each additional active month reduces default risk by 20%
- Defaulted accounts show declining balance trajectory from 1994 
  while non-defaulted accounts grow steadily through 1998

## Limitations
- 1990s Czech bank data — behavioral patterns may differ from 
  modern fintech users
- Only 682 accounts have loans (15% of total accounts)
- Class imbalance: 76 defaulted vs 606 non-defaulted

## Dashboard
[View on Tableau Public]
(https://public.tableau.com/views/berka/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Repository Structure
data/raw/ — original 8 CSVs
data/processed/ — query output CSVs used in Tableau dashboard
queries/  — all SQL files numbered in execution order
scripts/  — R logistic regression
visuals/  — dashboard screenshot