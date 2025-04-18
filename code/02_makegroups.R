
data_1 <- readRDS(file = here::here("output/variablized_cleaned_data.rds")
)

#creating positive subset of covid result
covid_ct_symptom_group<- data_1 %>% filter(covid_result_factor=="Positive")

#dropping the NAs for this subset
covid_ct_symptom_group <- covid_ct_symptom_group %>%
  filter(!is.na(symptom_duration_groups))

#creating positive subset of FLU A result
fluA_ct_symptom_group<- data_1 %>% filter(fluA_result_factor=="Positive")

    #dropping the NAs for this subset
      fluA_ct_symptom_group <- fluA_ct_symptom_group %>%
        filter(!is.na(symptom_duration_groups))

#creating positive subset of FLU B result
fluB_ct_symptom_group<- data_1 %>% filter(fluB_result_factor=="Positive")

    #dropping the NAs for this subset
      fluB_ct_symptom_group <- fluB_ct_symptom_group %>%
         filter(!is.na(symptom_duration_groups))

#creating positive subset of FLU B result
rsv_ct_symptom_group<- data_1 %>% filter(rsv_result_factor=="Positive")
      
    #dropping the NAs for this subset
      rsv_ct_symptom_group <- rsv_ct_symptom_group %>%
        filter(!is.na(symptom_duration_groups))
      


saveRDS(
  covid_ct_symptom_group, 
  file = here::here("output/covid_pcr_pos.rds")
)

saveRDS(
  fluA_ct_symptom_group, 
  file = here::here("output/fluA_pcr_pos.rds")
)

saveRDS(
  fluB_ct_symptom_group, 
  file = here::here("output/fluB_pcr_pos.rds")
)

saveRDS(
  rsv_ct_symptom_group, 
  file = here::here("output/rsv_pcr_pos.rds")
)



      