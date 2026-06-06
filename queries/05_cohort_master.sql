CREATE OR REPLACE TABLE `berka-cohort-analysis.berka.cohort_master` AS
SELECT
  a.account_id,
  a.date,
  FORMAT_DATE('%Y-%m', a.date) AS cohort_month,
  f.txn_count_3m,
  f.active_months_3m,
  f,total_credits_3m,
  f.total_debits_3m,
  f.cash_withdrawals_3m,
  f.avg_balance_3m,
  f.min_balance_3m,
  d.defaulted,
  d.loan_amount,
  --Behavioral segment
  CASE
    WHEN f.txn_count_3m >= 15 THEN 'High Frequency'
    WHEN f.txn_count_3m BETWEEN 5 AND 14 THEN 'Moderate'
    WHEN f.txn_count_3m BETWEEN 1 AND 4 THEN 'Low Frequency'
    ELSE 'Inactive'
  END AS behavior_segment
FROM `berka-cohort-analysis.berka.account_clean`a
LEFT JOIN `berka-cohort-analysis.berka.features_3m`f ON a.account_id=f.account_id
LEFT JOIN `berka-cohort-analysis.berka.loan_flags`d ON a.account_id=d.account_id;