SELECT
  behavior_segment,
  COUNT(*) AS accounts,
  SUM(defaulted) AS defaulted_accounts,
  ROUND(AVG(defaulted) * 100, 1) AS default_rate_pct,
  ROUND(AVG(avg_balance_3m), 0) AS avg_balance,
  ROUND(AVG(txn_count_3m), 1) AS avg_txn_count
FROM berka.cohort_master
WHERE defaulted IS NOT NULL
GROUP BY behavior_segment
ORDER BY default_rate_pct DESC;