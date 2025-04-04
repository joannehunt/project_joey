---
title: My Final Project Repository
author: Joey Hunt
output: github_document
---
# Final Project Report READ ME File

> loading data, cleaning data, descriptive statistics, plots, stratified analyses

------------------------------------------------------------------------

##  Code descriptions

`code/cleaning_data.R`

  - loads the most recent version of the dataset from OneDrive
  - renames all survey questions into managable/analyzable variable names
  - labels variables with survey question
  - formatting dates
  - saves cleaned datafile as an `.rds` object in `output/` folder

`code/01_makevariables.R`

  - create continuous symptom duration variable (visit date - symptom onset)
  - create categorical symptom duration variable (1,2,3,4,5,6,7+) 
  - create factor variables for vaccine information and symptoms
  - create factor variables for qual test result
  - label all variables and values
  - saves variable clean datafile as an `.rds` object in `output/` folder
  
`code/03_maketable1.R`

  - makes table 1 with PCR totals and symptom duration group
  - saves table 1 as `.rds` object in `output/` folder
  
`code/04_make_covid_boxplot.R`

  - makes boxplot for Covid PCR Ct Values results by Symptom Duration groups
  - saves plot as `.png` file in `output/` folder
  
`code/04_make_fluA_boxplot.R`

  - makes boxplot for flu A PCR Ct Values results by Symptom Duration groups
  - saves plot as `.png` file in `output/` folder

`code/04_make_fluB_boxplot.R`

  - makes boxplot for flu B PCR Ct Values results by Symptom Duration groups
  - saves plot as `.png` file in `output/` folder
  
`code/04_make_rsv_boxplot.R`

  - makes boxplot for rsv PCR Ct Values results by Symptom Duration groups
  - saves plot as `.png` file in `output/` folder

`code/100_render_report.R`

  - renders report

`Makefile`

  - contains rules for building the report
  - `make .data_clean` will generate the cleaned dataset
  - `make .variablized_cleaned_data` will generate the cleaned dataset with variables
  - `make .table1` will create the table 1
  - `make .boxplots_symptom_duration` will create the four `.rds` files needed to compile the plots for the report
# project_joey
