CREATE OR REPLACE TABLE `berka-cohort-analysis.berka.account_clean` AS
SELECT
  account_id,
  district_id,
  frequency,
  PARSE_DATE('%y%m%d', LPAD(CAST(date AS STRING), 6, '0')) AS date,
FROM
  `berka-cohort-analysis.berka.account`;
CREATE OR REPLACE TABLE `berka-cohort-analysis.berka.trans_clean` AS 
SELECT 
  trans_id,
  account_id,
  PARSE_DATE('%y%m%d', LPAD(CAST(date AS STRING), 6, '0')) AS trans_date,
  type,
  operation,
  amount,
  balance,
  k_symbol,
  bank,
  account
FROM `berka-cohort-analysis.berka.trans`;