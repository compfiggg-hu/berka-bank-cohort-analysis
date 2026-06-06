SELECT
  cohort_month,
  COUNT(*) AS total_accounts,
  SUM(defaulted) AS defaulted_accounts,
  ROUND(SUM(defaulted) * 100.0 / COUNT(*), 1) AS default_rate_pct
FROM berka.cohort_master
WHERE defaulted IS NOT NULL
GROUP BY cohort_month
ORDER BY cohort_month;