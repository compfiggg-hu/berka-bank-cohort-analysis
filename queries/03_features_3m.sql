CREATE OR REPLACE TABLE `berka-cohort-analysis.berka.features_3m` AS
WITH account_window AS(
  SELECT
  t.account_id,
  t.trans_date,
  t.amount,
  t.balance,
  t.trans_type,
  t.operation_type,
  a.date,
  DATE_DIFF(t.trans_date, a.date, DAY) AS days_since_open
  FROM `berka-cohort-analysis.berka.trans_labeled`t
  JOIN `berka-cohort-analysis.berka.account_clean`a ON t.account_id=a.account_id
  WHERE DATE_DIFF (t.trans_date, a.date, DAY) BETWEEN 0 AND 90
  )
SELECT
  account_id,
  COUNT(*)  AS txn_count_3m,
  COUNT(DISTINCT DATE_TRUNC(trans_date, MONTH))  AS active_months_3m,
  SUM(CASE WHEN trans_type ='Credit' THEN amount ELSE 0 END) AS total_credits_3m, 
  SUM(CASE WHEN trans_type = 'Debit'  THEN amount ELSE 0 END)   AS total_debits_3m,
  SUM(CASE WHEN operation_type = 'Cash Withdrawal' THEN amount ELSE 0 END) AS cash_withdrawals_3m,
  AVG(balance)                                       AS avg_balance_3m,
  MIN(balance)                                       AS min_balance_3m,
  MAX(trans_date)                                    AS last_txn_date_3m
FROM account_window
GROUP BY account_id;