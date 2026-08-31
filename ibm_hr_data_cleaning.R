
library(readr)
library(dplyr)
library(writexl)

# ── 2. Load dataset ──────────────────────────────────────────
file_path <- "D:/Dissertation/HR_Employee_Dataset.csv"  # replace with your file path
cat("Dataset Checked")
hr_data <- read_csv(file_path)

cat("=== Dataset loaded ===\n")
cat("Rows:", nrow(hr_data), "\n")
cat("Columns:", ncol(hr_data), "\n\n")

# ── 3. Drop constant/useless columns ─────────────────────────
# These four columns have the same value across all 1,470 rows
# and carry no analytical value for KPI dashboards

constant_cols <- c("EmployeeCount", "StandardHours", "Over18", "EmployeeNumber")

hr_data <- hr_data %>% select(-all_of(constant_cols))

cat("=== Constant columns removed ===\n")
cat("Columns dropped:", paste(constant_cols, collapse = ", "), "\n")
cat("Remaining columns:", ncol(hr_data), "\n\n")

# ── 4. Check for missing values ───────────────────────────────
cat("=== Missing Value Check ===\n")
na_summary <- colSums(is.na(hr_data))
if (sum(na_summary) == 0) {
  cat("No missing values found across all columns ✓\n\n")
} else {
  cat("Columns with missing values:\n")
  print(na_summary[na_summary > 0])
  cat("\n")
  # Remove rows with any NA values
  hr_data <- hr_data %>% filter(complete.cases(.))
  cat("Rows remaining after NA removal:", nrow(hr_data), "\n\n")
}

# ── 5. Check for duplicate rows ───────────────────────────────
cat("=== Duplicate Row Check ===\n")
dup_count <- sum(duplicated(hr_data))
cat("Duplicate rows found:", dup_count, "\n")

if (dup_count > 0) {
  cat("Example duplicate rows:\n")
  dup_rows <- hr_data[duplicated(hr_data) | duplicated(hr_data, fromLast = TRUE), ]
  print(head(dup_rows, 10))
  hr_data <- hr_data[!duplicated(hr_data), ]
  cat("Duplicates removed. Clean rows remaining:", nrow(hr_data), "\n\n")
} else {
  cat("No duplicate rows found ✓\n\n")
}

# ── 6. Validate key categorical columns ───────────────────────
cat("=== Categorical Column Validation ===\n")

# Attrition
cat("Attrition values:", paste(unique(hr_data$Attrition), collapse = ", "), "\n")

# Department
cat("Departments:", paste(unique(hr_data$Department), collapse = ", "), "\n")

# JobRole
cat("Job Roles:", paste(unique(hr_data$JobRole), collapse = ", "), "\n")

# Gender
cat("Gender values:", paste(unique(hr_data$Gender), collapse = ", "), "\n\n")

# ── 7. Validate key numeric columns (KPI fields) ──────────────
cat("=== Numeric KPI Column Summary ===\n")

kpi_cols <- c("PerformanceRating", "JobSatisfaction", "EnvironmentSatisfaction",
              "RelationshipSatisfaction", "WorkLifeBalance", "JobInvolvement",
              "MonthlyIncome", "PercentSalaryHike", "TrainingTimesLastYear",
              "YearsAtCompany", "YearsSinceLastPromotion", "YearsInCurrentRole")

print(summary(hr_data[, kpi_cols]))
cat("\n")

# ── 8. Check rating scale columns are within expected range ───
cat("=== Rating Scale Validation (expected range: 1–4) ===\n")

rating_cols <- c("PerformanceRating", "JobSatisfaction", "EnvironmentSatisfaction",
                 "RelationshipSatisfaction", "WorkLifeBalance", "JobInvolvement")

for (col in rating_cols) {
  out_of_range <- hr_data %>% filter(.data[[col]] < 1 | .data[[col]] > 4)
  if (nrow(out_of_range) > 0) {
    cat("⚠ Out-of-range values in", col, ":", nrow(out_of_range), "rows\n")
  } else {
    cat(col, ": All values within 1–4 ✓\n")
  }
}
cat("\n")

# ── 9. Convert categorical columns to factors ─────────────────
cat("=== Converting categoricals to factors ===\n")

factor_cols <- c("Attrition", "BusinessTravel", "Department", "EducationField",
                 "Gender", "JobRole", "MaritalStatus", "OverTime")

hr_data <- hr_data %>% mutate(across(all_of(factor_cols), as.factor))

cat("Factor columns set:", paste(factor_cols, collapse = ", "), "\n\n")

# ── 10. Final summary ─────────────────────────────────────────
cat("=== Final Clean Dataset Summary ===\n")
cat("Total rows:", nrow(hr_data), "\n")
cat("Total columns:", ncol(hr_data), "\n")
cat("Attrition breakdown:\n")
print(table(hr_data$Attrition))
cat("\n")

# ── 11. Export cleaned dataset ────────────────────────────────
output_csv  <- "D:/Dissertation//ibm_hr_cleaned.csv"
output_xlsx <- "D:/Dissertation//ibm_hr_cleaned.xlsx"

write_csv(hr_data, output_csv)
write_xlsx(hr_data, output_xlsx)

cat("=== Export complete ===\n")
cat("CSV saved to: ", output_csv, "\n")
cat("XLSX saved to:", output_xlsx, "\n")
cat("Ready for Power BI import ✓\n")