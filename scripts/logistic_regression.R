# logistics_regression.R
# 1. Load required libraries
library(dplyr)
library(ggplot2)
library(glmnet)

# Load data
df <- read.csv("data/processed/cohort_master.csv") %>%
  filter(!is.na(defaulted))

# 2. Prepare data matrices (glmnet requires matrix input)
x <- as.matrix(df[, c("txn_count_3m", "avg_balance_3m", "cash_withdrawals_3m", "active_months_3m", "min_balance_3m")])
y <- df$defaulted

# Check class balance
print("Class balance (0 = No Default, 1 = Default):")
print(table(y))

# 3. Fit the model using Cross-Validation
print("Fitting Cross-Validated Logistic Regression (Lasso)...")
fit <- cv.glmnet(x, y, family = "binomial")

# Look at coefficients
print("Model summary (lambda values):")
print(summary(fit))

# 4. Extract coefficients at the best lambda
coef_matrix <- coef(fit, s = "lambda.min")

# 5. Convert to a readable data frame and filter out 0s
model_table <- data.frame(
  term = rownames(coef_matrix),
  coefficient = as.numeric(coef_matrix)
) %>%
  filter(coefficient != 0) %>%
  mutate(odds_ratio = exp(coefficient))

# Display the final table
print("Model Coefficients and Odds Ratios:")
print(model_table)

# Export the model_table to a CSV file in the local workspace
output_csv <- "data/processed/model_results.csv"
write.csv(model_table, output_csv, row.names = FALSE)
print(paste("Results saved to:", output_csv))

# 6. Plot and save visualization
print("Creating boxplot of transaction frequency vs defaults...")
p <- ggplot(df, aes(x = factor(defaulted), y = txn_count_3m)) +
  geom_boxplot(fill = "skyblue", outlier.color = "red") +
  labs(
    x = "Defaulted (0 = No, 1 = Yes)", 
    y = "Transaction Count (First 3 Months)",
    title = "Early Transaction Frequency vs Loan Defaults"
  ) +
  theme_minimal()

# Save the plot locally
output_plot <- "visuals/boxplot_txn_count_vs_default.png"
ggsave(output_plot, plot = p, width = 6, height = 5)
print(paste("Plot saved to:", output_plot))
