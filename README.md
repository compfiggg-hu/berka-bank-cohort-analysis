# Berka Cohort Analysis: Early Transaction Patterns and Credit Risk

## The Question
Can early transaction behavior in the first 90 days of account opening predict which loan accounts will default?

## Why It Matters
In fintech lending, early account activity signals customer engagement and financial stability. This analysis identifies which behavioral patterns in the first 90 days correlate with loan default — enabling risk-based pricing and early intervention strategies.

## Dataset
- **Source:** Berka Czech bank dataset (1993–1998) — [Kaggle](https://www.kaggle.com/datasets/berka)
- **Size:** 1,056,320 transactions across 8 tables
- **Scope:** 682 accounts with loans (15% of 4,500 total accounts)
- **Default rate:** 76 defaulted / 606 non-defaulted (11.1%)

## Tools & Pipeline
```
Raw CSVs (8 tables)
    │
    ▼
BigQuery — date conversion (YYMMDD→DATE) + feature engineering + cohort table
    │
    ├──► R — logistic regression (glmnet) → odds ratios
    │
    ▼
Tableau Dashboard ──► GitHub
```

## Key Findings
1. **Low-activity accounts default 2.6x more often** — accounts with 1–4 transactions in first 90 days default at 25% vs 9.6% for moderate-activity accounts
2. **active_months_3m is the strongest predictor (odds ratio: 0.80)** — each additional active month reduces default odds by 20%; accounts active all 3 months default at 7.2% vs 28.5% for accounts active ≤1 month
3. **Balance trajectory diverges early** — defaulted accounts show declining minimum balance from 1994 onward; non-defaulted accounts grow steadily through 1998

## Dashboard
[View on Tableau Public](https://public.tableau.com/views/berka/Dashboard1)

4 views:
- **Default Rate by Opening Month** — which cohorts had higher default risk
- **Default Rate by Behavior Segment** — High/Moderate/Low Frequency comparison
- **Balance Trajectory** — defaulted vs non-defaulted account balance over time
- **Regression Odds Ratios** — which early behaviors predict default

## Limitations
- 1990s Czech bank data — patterns may differ from modern fintech users
- Loan subset only — 682 of 4,500 accounts; results may not generalize
- No holdout validation — for production would split train/test by time
- Class imbalance — 11% default rate; model handles this but worth noting

## Note on Scope
Initial analysis targeted dormancy prediction (90+ day inactivity gaps). Found extreme sparsity — fewer than 5 accounts triggered the threshold. Pivoted to loan default prediction: better class balance, clearer business signal, directly relevant to fintech credit risk roles.

## Repository Structure
```
data/raw/        — original 8 CSVs from Kaggle (semicolon-delimited)
data/processed/  — query output CSVs used in Tableau
queries/         — all SQL files numbered in execution order
scripts/         — R logistic regression (glmnet)
visuals/         — dashboard screenshot + R boxplot
```
