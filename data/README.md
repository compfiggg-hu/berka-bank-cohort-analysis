## Data Sources

### Raw Data
Berka Czech bank dataset — downloaded from Kaggle
https://www.kaggle.com/datasets/berka

8 tables:
- trans.csv — 1,056,320 transactions (semicolon-delimited)
- account.csv — 4,500 accounts with opening dates
- loan.csv — 682 loans with repayment status
- client.csv — client demographics
- card.csv — card type per account
- disp.csv — account-client relationships
- district.csv — regional demographics
- order.csv — permanent payment orders

Date format: YYMMDD integer (e.g. 930101 = Jan 1, 1993)
Delimiter: semicolon — do not open in Excel

### Processed Data
Query outputs from BigQuery — used directly in Tableau:
- cohort_default_rate.csv — default rate by account opening month
- segment_analysis.csv — default rate by behavioral segment
- balance_trajectory.csv — avg balance over time by default status
- model_results.csv — logistic regression odds ratios from R