CREATE OR REPLACE TABLE `berka-cohort-analysis.berka.trans_labeled` AS
SELECT
  trans_id,
  account_id,
  trans_date,
  amount,
  balance,
  CASE type
    WHEN 'PRIJEM' THEN 'Credit'
    WHEN 'VYDAJ' THEN 'Debit'
    WHEN 'VYBER' THEN 'Withdrawal'
    ELSE 'Other'
  END AS trans_type,
  CASE operation
    WHEN 'VKLAD' THEN 'Cash Deposit'
    WHEN 'VYBER' THEN 'Cash Withdrawal'
    WHEN 'VYBER KARTOU' THEN 'Card Withdrawal'
    WHEN 'PREVOD NA UCET' THEN 'Outgoing Transfer'
    WHEN 'PREVOD Z UCTU' THEN 'Incoming Transfer'
    ELSE 'Other'
  END AS operation_type,
  k_symbol
FROM `berka-cohort-analysis.berka.trans_clean`