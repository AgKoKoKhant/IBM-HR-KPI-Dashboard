# IBM HR KPI Dashboard — MSc Big Data Analytics Dissertation

## Project Title
Enhancing Employee Performance Evaluation through KPI Visualisation Using Power BI

## Student Information
- **Student Name:** Aung Ko Ko Khant
- **Student ID:** *******
- **Programme:** MSc Big Data Analytics
- **University:** Sheffield Hallam University

---

## Project Overview
This project develops and evaluates a role-based Power BI dashboard for employee 
performance evaluation using KPI visualisation. The dashboard is built on the IBM HR 
Analytics Employee Attrition and Performance dataset from Kaggle, containing 1,470 
employee records across 31 columns after cleaning.

The dashboard addresses six literature findings across three themes:
- KPI Reporting and Dashboard Effectiveness
- Data Engineering and Business Intelligence for HR Analytics
- BI Methodologies and Interactive Decision Support

---

## Repository Contents

| File | Description |
|---|---|
| `ibm_hr_data_cleaning.R` | R script for data cleaning and preprocessing |
| `IBM_HR_KPI_Dashboard.pbix` | Power BI dashboard file (3 role-based pages) |
| `ibm_hr_cleaned.csv` | Cleaned dataset exported from R script |
| `WA_Fn-UseC_-HR-Employee-Attrition.csv` | Original IBM HR dataset from Kaggle |

---

## Dataset
- **Source:** IBM HR Analytics Employee Attrition and Performance
- **Platform:** Kaggle
- **Records:** 1,470 employees
- **Original columns:** 35
- **Columns after cleaning:** 31 (4 constant columns removed)
- **Missing values:** 0
- **Duplicate rows:** 0

---

## Data Cleaning (R Script)
The R cleaning script performs the following operations:
1. Loads the IBM HR CSV dataset
2. Removes 4 constant columns — EmployeeCount, StandardHours, Over18, EmployeeNumber
3. Checks for missing values — confirmed zero
4. Checks for duplicate rows — confirmed zero
5. Validates rating scale columns (1–4 range)
6. Converts categorical columns to factor type
7. Exports cleaned dataset as CSV and XLSX

**Required R packages:**
```r
install.packages("readr")
install.packages("dplyr")
install.packages("writexl")
```

---

## Power BI Dashboard
The dashboard consists of 3 role-based pages:

### Page 1 — Organisation Overview
- 4 KPI cards: Attrition Rate, Avg Performance Rating, Avg Job Satisfaction, Total Headcount
- Attrition Rate by JobRole (horizontal bar chart)
- Attrition Yes/No split (donut chart)
- Department slicer

### Page 2 — Department & Supervisor View
- Average Monthly Income by JobRole (pie chart)
- Attrition Rate by Department (bar chart)
- KPI Scorecard Matrix (Performance, Satisfaction, Work Life Balance, Job Involvement)
- Dynamic cards: OverTime %, Years Since Last Promotion, Attrition Rate
- Department slicer

### Page 3 — Manager & Workforce View
- Decomposition Tree — Avg Performance Rating by Age, JobRole, Department, JobLevel
- Salary Hike by Performance Rating (bar chart)
- Job Satisfaction vs Performance Rating (scatter plot)
- JobLevel slicer

---

## DAX Measures
| Measure | Formula | Purpose |
|---|---|---|
| Attrition Rate | DIVIDE(COUNTROWS(FILTER...), COUNTROWS()) | Overall attrition % |
| Avg Performance Rating | AVERAGE(PerformanceRating) | Mean performance score |
| Avg Job Satisfaction | AVERAGE(JobSatisfaction) | Mean satisfaction score |
| Total Headcount | COUNTROWS(Sheet1) | Total employee count |
| OverTime % | DIVIDE(COUNTROWS(FILTER...), COUNTROWS()) | % employees on overtime |
| Selected Department | IF(ISFILTERED..., SELECTEDVALUE..., "All Departments") | Dynamic department label |

---

## Literature Foundation
This project is grounded in six academic papers:

1. Perera & Madushanka (2025) — Manual reporting delays KPI monitoring
2. Gusnadi & Hermawan (2019) — Role-based dashboards improve effectiveness
3. Akter & Al Maruf (2025) — ETL pipelines ensure data reliability
4. Gultom et al. (2024) — Interactive BI features identify performance gaps
5. Gonçalves et al. (2023) — Vercellis framework for structured BI development
6. Nadj et al. (2020) — Interactive features support managerial decision making

---

## Tools & Technologies
| Tool | Purpose |
|---|---|
| R | Data cleaning and preprocessing |
| Power BI Desktop | Dashboard development |
| Power Query | ETL within Power BI |
| DAX | KPI measure calculations |
| Kaggle | Dataset source |
| GitHub | Version control and project repository |

---

## Ethics
- Dataset: Publicly available synthetic dataset — no real personal data
- Ethics approval: UREC Form 1 submitted (Sheffield Hallam University)
- Evaluation: Anonymous questionnaire with 1 participant from SHU and 1 from Software Engineering Background

---

## How to Run

### R Script
1. Install required packages
2. Update `file_path` on line 18 to your CSV location
3. Run script in RStudio
4. Cleaned files saved to Downloads folder

### Power BI Dashboard
1. Download Power BI Desktop (free) from microsoft.com
2. Open `IBM_HR_KPI_Dashboard.pbix`
3. Navigate between pages using tabs at the bottom
4. Use slicers to filter by Department or JobLevel

---

## License
This project is submitted as part of an MSc dissertation at Sheffield Hallam University.
Dataset used under Kaggle open licence.
