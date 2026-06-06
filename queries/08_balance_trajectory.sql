SELECT
  d.defaulted,
  FORMAT_DATE('%Y-%m', t.trans_date) AS month,
  ROUND(AVG(t.balance), 0) AS avg_balance
FROM berka.trans_labeled t
JOIN berka.loan_flags d ON t.account_id = d.account_id
GROUP BY d.defaulted, month
ORDER BY month, d.defaulted;