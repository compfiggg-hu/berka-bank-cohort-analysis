CREATE OR REPLACE TABLE berka.loan_flags AS
SELECT
  account_id,
  CASE 
    WHEN status IN ('B','D') THEN 1 
    ELSE 0 
  END AS defaulted,
  status,
  amount AS loan_amount,
  duration
FROM berka.loan;