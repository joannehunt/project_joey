here::i_am("code/03_maketable1.R")

data_1<- readRDS(file = here::here("output/variablized_cleaned_data.rds"))

library(gtsummary)
table_1 <- tbl_summary(
  data = data_1,
  include = c("covid_result_factor", "fluA_result_factor", "fluB_result_factor", "rsv_result_factor", 
              "covid_vaccine_factor", "symptom_duration_groups", 
              "durtn_vax_factor", "durtn_omicron_vax_factor", "data_flu_vax_factor"),  # Select your 5 variables
  statistic = all_categorical() ~ "{n} ({p}%)",  # Count and percentage
  missing = "ifany"  # Exclude missing values
)



saveRDS(table_1, 
        file = here::here("output/table1.rds"))