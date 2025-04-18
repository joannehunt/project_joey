
here::i_am("code/01_makevariables.R")

data<- readRDS(file = here::here("output/data_clean.rds"))

library(dplyr)
library(labelled)

#make a variable for symptom duration 
# (symptom_onset)-(visit_date)= Symptom_duration

data$symptom_duration <- data$visit_date - data$symptom_onset
data$symptom_duration <- as.numeric(data$symptom_duration)

#. I think the thought was to stratify by most recent vaccine 
#> 3 months, 3-6 months, 6-9 months, 9-12 months, and 12+ month

#trying to fill in any data by using the last date provided for vaccination
data <- data %>%
  mutate(date_recent_vax = ifelse(is.na(date_recent_vax), date_dose4_vaccine, date_recent_vax))
data$date_recent_vax <- as.Date(data$date_recent_vax, format="%m/%d/%Y")

#trying to fill in using the next level
data <- data %>%
  mutate(date_recent_vax = ifelse(is.na(date_recent_vax), date_dose3_vaccine, date_recent_vax))
data$date_recent_vax <- as.Date(data$date_recent_vax, format="%m/%d/%Y")

#. I think the thought was to stratify by most recent vaccine 
#> 3 months, 3-6 months, 6-9 months, 9-12 months, and 12+ month

data$durtn_post_cov_vax <- data$visit_date - data$date_recent_vax
data$durtn_post_cov_vax <- as.numeric(data$durtn_post_cov_vax)

##droping the negative values
data_covid_vax_filled <- data %>% filter(durtn_post_cov_vax >= 0) 

data <- data %>% mutate(
  durtn_vax_factor = ifelse(is.na(durtn_post_cov_vax), NA,
                            ifelse(durtn_post_cov_vax <0, NA,
                                   ifelse(durtn_post_cov_vax >=0 & durtn_post_cov_vax <=93, 1,
                                          ifelse(durtn_post_cov_vax >=94 & durtn_post_cov_vax <=186, 2, 
                                                 ifelse(durtn_post_cov_vax >=187 & durtn_post_cov_vax <=279, 3,
                                                        ifelse(durtn_post_cov_vax >=280 & durtn_post_cov_vax <=365, 4,
                                                               ifelse(durtn_post_cov_vax >=366 & durtn_post_cov_vax <=552, 5,
                                                                      ifelse(durtn_post_cov_vax >=553 & durtn_post_cov_vax <=730, 6,
                                                                             ifelse(durtn_post_cov_vax >=731, 7,NA))))))))))

#Create factor variable
data <- data %>% mutate(durtn_vax_factor = 
                          factor(durtn_vax_factor, 
                                 levels = 1:7, 
                                 labels = c("Less than 3 months",
                                            "3-6 months", "6-9 months",
                                            "9-12 months", "12-18 months",
                                            "18-24 months",
                                            "Over two years")))


data$durtn_post_omicron_vax <- data$visit_date - data$date_omicron
data$durtn_post_omicron_vax <- as.numeric(data$durtn_post_omicron_vax)


data <- data %>% mutate(
  durtn_omicron_vax_factor = ifelse(is.na(durtn_post_omicron_vax), NA,
                                    ifelse(durtn_post_omicron_vax <0, NA,
                                           ifelse(durtn_post_omicron_vax >=0 & durtn_post_omicron_vax <=93, 1,
                                                  ifelse(durtn_post_omicron_vax >=94 & durtn_post_omicron_vax <=186, 2, 
                                                         ifelse(durtn_post_omicron_vax >=187 & durtn_post_omicron_vax <=279, 3,
                                                                ifelse(durtn_post_omicron_vax >=280 & durtn_post_omicron_vax <=365, 4,
                                                                       ifelse(durtn_post_omicron_vax >=366 & durtn_post_omicron_vax <=552, 5,
                                                                              ifelse(durtn_post_omicron_vax >=553 & durtn_post_omicron_vax <=730, 6,
                                                                                     ifelse(durtn_post_omicron_vax >=731, 7,NA))))))))))

#Create factor variable
data <- data %>% mutate(durtn_omicron_vax_factor = 
                          factor(durtn_omicron_vax_factor, 
                                 levels = 1:7, 
                                 labels = c("Less than 3 months",
                                            "3-6 months", "6-9 months",
                                            "9-12 months", "12-18 months",
                                            "18-24 months",
                                            "Over two years")))


data$durtn_post_flu_vax <- data$visit_date - data$date_flu_vax
data$durtn_post_flu_vax <- as.numeric(data$durtn_post_flu_vax)

##droping the negative values
data_flu_vax <- data %>% filter(durtn_post_cov_vax >= 0) 

data <- data %>% mutate(
  data_flu_vax_factor = ifelse(is.na(durtn_post_flu_vax), NA,
                               ifelse(durtn_post_flu_vax <0, NA,
                                      ifelse(durtn_post_flu_vax >=0 & durtn_post_flu_vax <=93, 1,
                                             ifelse(durtn_post_flu_vax >=94 & durtn_post_flu_vax <=186, 2, 
                                                    ifelse(durtn_post_flu_vax >=187 & durtn_post_flu_vax <=279, 3,
                                                           ifelse(durtn_post_flu_vax >=280 & durtn_post_flu_vax <=365, 4,
                                                                  ifelse(durtn_post_flu_vax >=366 & durtn_post_flu_vax <=552, 5,
                                                                         ifelse(durtn_post_flu_vax >=553 & durtn_post_flu_vax <=730, 6,
                                                                                ifelse(durtn_post_flu_vax >=731, 7,NA))))))))))

#Create factor variable
data <- data %>% mutate(data_flu_vax_factor = 
                          factor(data_flu_vax_factor, 
                                 levels = 1:7, 
                                 labels = c("Less than 3 months",
                                            "3-6 months", "6-9 months",
                                            "9-12 months", "12-18 months",
                                            "18-24 months",
                                            "Over two years")))


#vaccines
###factor 

data <- data %>% mutate(covid_vaccine_factor = case_when(
  vaccinated == "No" ~ "0",
  vaccinated == "Yes" ~ "1", 
  vaccinated == "" ~ "2"))

data$covid_vaccine_factor <- as.numeric(data$covid_vaccine_factor)

data$covid_vaccine_factor <-factor(data$covid_vaccine_factor,
  levels = 0:2,
  labels = c("No","Yes","Unknown/No Response"))

data <- data %>% mutate(dose1_vaccine_factor = case_when(
  dose1_vaccine == "Pfizer" ~ "1",
  dose1_vaccine == "Moderna" ~ "2",
  dose1_vaccine == "Johnson and Johnson" ~ "3",
  dose1_vaccine == "Other" ~ "4",
  dose1_vaccine == "I dont know" ~ "5"))
data$dose1_vaccine_factor <- as.numeric(data$dose1_vaccine_factor)

data <- data %>% mutate(dose2_vaccine_factor = case_when(
  dose2_vaccine == "Pfizer" ~ "1",
  dose2_vaccine == "Moderna" ~ "2",
  dose2_vaccine == "Johnson and Johnson" ~ "3",
  dose2_vaccine == "Other" ~ "4",
  dose2_vaccine == "I dont know" ~ "5"))
data$dose2_vaccine_factor <- as.numeric(data$dose2_vaccine_factor)

data <- data %>% mutate(dose3_vaccine_factor = case_when(
  dose3_vaccine == "Pfizer" ~ "1",
  dose3_vaccine == "Moderna" ~ "2",
  dose3_vaccine == "Johnson and Johnson" ~ "3",
  dose3_vaccine == "Other" ~ "4",
  dose3_vaccine == "I dont know" ~ "5"))
data$dose3_vaccine_factor <- as.numeric(data$dose3_vaccine_factor)

data <- data %>% mutate(dose4_vaccine_factor = case_when(
  dose4_vaccine == "Pfizer" ~ "1",
  dose4_vaccine == "Moderna" ~ "2",
  dose4_vaccine == "Johnson and Johnson" ~ "3",
  dose4_vaccine == "Other" ~ "4",
  dose4_vaccine == "I dont know" ~ "5"))
data$dose4_vaccine_factor <- as.numeric(data$dose4_vaccine_factor)

doses <- c("dose1_vaccine_factor", "dose2_vaccine_factor", "dose3_vaccine_factor", "dose4_vaccine_factor")

data[,doses] <- lapply(data[,doses], function(x){
  factor(x, levels = c(1,2,3,4,5), labels = c("Pfizer", "Moderna","Johnson and Johnson", "Other", "I dont know" ))
})

data <- data %>% mutate(dose_omicron_factor = case_when(
  dose_omicron == "Yes" ~ "1",
  dose_omicron == "No" ~ "0"))
  
data$dose_omicron_factor <- as.numeric(data$dose_omicron_factor)

data$dose_omicron_factor <-factor(data$dose_omicron_factor,
                                     levels = c(0,1),
                                     labels = c("No", "Yes"))

## dealing with symptom duration variable

data$symptom_duration_groups<- ifelse(is.na(data$symptom_duration), NA, ifelse(
  data$symptom_duration <=0, 0, ifelse(
    data$symptom_duration == 1,1, ifelse(
      data$symptom_duration == 2, 2, ifelse(
        data$symptom_duration == 3, 3, ifelse(
          data$symptom_duration == 4, 4, ifelse(
            data$symptom_duration == 5, 5, ifelse(
              data$symptom_duration == 6, 6, "7+"
            ))))))))
data$symptom_duration_groups <- as.factor(data$symptom_duration_groups)
data$symptom_duration_groups <- factor(data$symptom_duration_groups,
                                    levels = 0:6,
                                    labels = c("0 Days", "1 day", "2 days", "3 days", "4 days", "5 days", "6 days"))
##droping the negative values
data_1 <- data[data$symptom_duration >= 0, ]  

##now data_1 has dropped the variables with negative symptom duration
## turning Positive/Negative into factor
#COVID
data_1 <- data_1 %>% mutate(covid_result_factor = case_when(
  comparator_cov_test == "NEGATIVE" ~ "0",
  comparator_cov_test == "POSITIVE" ~ "1",
  comparator_cov_test == "UNDETERMINED (Inconclusive)" ~ "2",
  comparator_cov_test == "" ~ "2",
  comparator_cov_test == NA ~ "2"))

data_1$covid_result_factor <- as.numeric(data_1$covid_result_factor)

#FLU A
data_1 <- data_1 %>% mutate(fluA_result_factor = case_when(
  ceph_multi_res_flua == "NEGATIVE" ~ "0",
  ceph_multi_res_flua == "POSITIVE" ~ "1",
  ceph_multi_res_flua == "UNDETERMINED (Inconclusive)" ~ "2",
  ceph_multi_res_flua == "" ~ "2",
  ceph_multi_res_flua == NA ~ "2"))

data_1$fluA_result_factor <- as.numeric(data_1$fluA_result_factor)

#FLU B
data_1 <- data_1 %>% mutate(fluB_result_factor = case_when(
  ceph_multi_res_flub == "NEGATIVE" ~ "0",
  ceph_multi_res_flub == "POSITIVE" ~ "1",
  ceph_multi_res_flub == "UNDETERMINED (Inconclusive)" ~ "2",
  ceph_multi_res_flub == "" ~ "2",
  ceph_multi_res_flub == NA ~ "2"))

data_1$fluB_result_factor <- as.numeric(data_1$fluB_result_factor)

#RSV
data_1 <- data_1 %>% mutate(rsv_result_factor = case_when(
  multi_rsv == "NEGATIVE" ~ "0",
  multi_rsv == "POSITIVE" ~ "1",
  multi_rsv == "UNDETERMINED (Inconclusive)" ~ "2",
  multi_rsv == "" ~ "2", 
  multi_rsv == NA ~ "2"))

data_1$rsv_result_factor <- as.numeric(data_1$rsv_result_factor)

#turn to factor
results<- c("covid_result_factor","fluA_result_factor", "fluB_result_factor", "rsv_result_factor" )

data_1[,results]<-lapply(data_1[,results], function(x){
  factor(x,
         levels = c(0,1,2),
         labels = c("Negative","Positive","Not Determined"))
})

#variable for coinfections

data_1 <- data_1 %>%
  mutate(coinfection = rowSums(across(all_of(results),~. =="Positive"),))

#labeling the variables 
var_label(data_1)<-list(
  covid_result_factor="COVID-19 PCR Test Result",
  fluA_result_factor="Flu A PCR Test Result",
  fluB_result_factor="Flu B PCR Test Result",
  rsv_result_factor="RSV PCR Test Result", 
  covid_vaccine_factor="Vaccination for COVID-19",
  dose_omicron_factor="Vaccination for Omicron",
  coinfection="Sum of Positive PCR Test Results (Coinfection)",
  symptom_duration_groups="Duration since Symptom Onset", 
  durtn_vax_factor="Duration since most recent COVID Vaccine",
  durtn_omicron_vax_factor="Duration since Omicron Booster",
  data_flu_vax_factor="Duration since most recent Flu Vaccine")

data_final <- data_1 %>% filter(!is.na(comparator_cov_test))
saveRDS(
  data_final, 
  file = here::here("output/variablized_cleaned_data.rds")
)
