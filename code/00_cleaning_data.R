#make sure working directory is set to the final_proj folder
here::i_am("code/00_cleaning_data.R")
absolute_path_to_data<- here::here("raw_data/fake_data.csv")

data<- read.csv(absolute_path_to_data, header = TRUE)

library(labelled)
library(gtsummary)
library(dplyr)
library(lubridate)

###SYMPTOM DATA

colnames(data)[8:25] <- c("Fever_14day", "Chills_14day", "Congestion_14day", "Cough_14day", "Headache__14day", 
                          "Sore_Throat_14day", "Fatigue_14day", "Joint_Pain_14day", "Myalgia_14day", "Light_Sens_14day", 
                          "Vomiting_14day", "Nausea_14day", "Diarrhea_14day", "Abdominal_Pain_14day", "Lossof_smell_14day",
                          "Shortnessof_Breath_14day", "Other_14day", "None_14day")

colnames(data)[26:43] <- c("Fever_current", "Chills_current", "Congestion_current", "Cough_current", "Headache_current", 
                          "Sore_Throat_current", "Fatigue_current", "Joint_Pain_current", "Myalgia_current", "Light_Sens_current", 
                          "Vomiting_current", "Nausea_current", "Diarrhea_current", "Abdominal_Pain_current", "Lossof_smell_current",
                          "Shortnessof_Breath_current", "Other_current", "None_current")

colnames(data)[44:61] <- c("Fever_7day", "Chills_7day", "Congestion_7day", "Cough_7day", "Headache_7day", 
                           "Sore_Throat_7day", "Fatigue_7day", "Joint_Pain_7day", "Myalgia_7day", "Light_Sens_7day", 
                           "Vomiting_7day", "Nausea_7day", "Diarrhea_7day", "Abdominal_Pain_7day", "Lossof_smell_7day",
                           "Shortnessof_Breath_7day", "Other_7day", "None_7day")

colnames(data)[62:73]<- c("residual_ct1", "residual_ct2", "assay_system","comparator_cov_test", "ct_value_1","ct_value_2",
               "lab1_result_n1ct","lab1_result_rnact","lab2_result_n1ct","lab2_result_rnact",
               "salivaom_ct1_v2", "salivaom_ct2_v2")

colnames(data)[74:93]<- c("opswabom_ct1_v2", "opswabom_ct2", 
               "cepheid_n", "cepheid_e", "cepheid_n2_e","vaccine","covid_vaccine","doses",
               "dose1_vaccine","binary_date_dose1_vaccine","date_dose1_vaccine", 
               "dose2_vaccine","binary_date_dose2_vaccine","date_dose2_vaccine", 
               "dose3_vaccine","binary_date_dose3_vaccine","date_dose3_vaccine",
               "dose4_vaccine", "binary_date_dose4_vaccine","date_dose4_vaccine")

colnames(data)[94:111]<- c("dose_omicron","binary_date_omicron","date_omicron", "vaccinated", "doses_numberoverall",
              "binary_date_recent_vax","date_recent_vax", "flu_vaccine_lastyr","count_fluvax","binary_date_fluvax", "date_flu_vax",
              "rsv_vaccine_lastyr","count_rsvvax","binary_date_rsvvax", "date_rsv_vax",
              "previous_covid1","previous_covid2","date_covid_test")

colnames(data)[112:125]<- c("ceph_multi_res_flua", "flua_ct1", "flua_ct2", 
                           "ceph_multi_res_flub", "flub_ct1", "multi_rsv", "rsv_ct",
                           "comparator","comparator_antigen_result", "any_test_14days1", "any_test_14days2", "pos_test_14days", "neg_test_14days", "neg_test_2days")


var_label(data$covid_vaccine)="Have you received any of the COVID-19 vaccines (excluding the version of the vaccine targeting the Omicron variant that was approved in September 2022)?"
var_label(data$vaccine)="Which vaccine?"
var_label(data$doses)="How many vaccine doses have you received (excluding the version of the vaccine targeting the Omicron variant approved in September 2022)?"
var_label(data$dose1_vaccine)="Which vaccine did you receive for dose #1?"
var_label(data$binary_date_dose1_vaccine)= "Do you know the date you received dose #1?"
var_label(data$date_dose1_vaccine)= "Date COVID Vax 1"
var_label(data$dose2_vaccine)="Which vaccine did you receive for dose #2?"
var_label(data$binary_date_dose2_vaccine)= "Do you know the date you received dose #2?"
var_label(data$date_dose2_vaccine)= "Date COVID Vax 2"
var_label(data$dose3_vaccine)="Which vaccine did you receive for dose #3?"
var_label(data$binary_date_dose3_vaccine)= "Do you know the date you received dose #3?"
var_label(data$date_dose3_vaccine)= "Date COVID Vax 3"
var_label(data$dose4_vaccine)="Which vaccine did you receive for dose #4?"
var_label(data$binary_date_dose4_vaccine)= "Do you know the date you received dose #4?"
var_label(data$date_dose4_vaccine)= "Date COVID Vax 4"
var_label(data$dose_omicron)="Have you received the vaccine booster targeting the Omicron variant approved in September 2022?"
var_label(data$binary_date_omicron)= "Do you know the date you received the booster?"
var_label(data$date_omicron)= "Date Omicron Booster"
var_label(data$vaccinated)= "Were you vaccinated for COVID-19?"
var_label(data$doses_numberoverall)= "How many doses"
var_label(data$binary_date_recent_vax)= "do you know the date of the last vaccination"
var_label(data$date_recent_vax)= "Date of most recent vaccination"
var_label(data$flu_vaccine_lastyr)= "Flu vaccine last year"                           
var_label(data$count_fluvax)= "How many flu vaccines"                               
var_label(data$date_flu_vax)= "last date of flu vaccine"                                 
var_label(data$rsv_vaccine_lastyr)= "did you get the RSV vaccine last year"                           
var_label(data$count_rsvvax)= "how many rsv vaccines"                                
var_label(data$date_rsv_vax)= "date of last rsv vaccine"   
var_label(data$previous_covid1)="Have you tested positive previously (prior to the current illness) for COVID-19 using a PCR lab test?"
var_label(data$previous_covid2)="Have you tested positive previously (prior to the current illness) for COVID-19 using a PCR lab test? 1"
var_label(data$date_covid_test)="Date of clinical comparator COVID test:"
var_label(data$any_test_14days1)="Have you had a COVID-19 test of any type in the last 14 days"
var_label(data$any_test_14days2)="Has the participant had a COVID-19 test of any type in the last 14 days"
var_label(data$pos_test_14days)="Has the participant had a positive on any COVID-19 test in the last 14 days"
var_label(data$neg_test_2days)="Has the participant had a negative on any COVID-19 test in the last 2 days"
var_label(data$neg_test_14days)="Has the participant had a negative on any COVID-19 test in the last 14 days"

var_label(data$residual_ct1)="Residual NP Swab: CT Value 1:"
var_label(data$residual_ct2)="Residual NP Swab: CT Value 2: "
var_label(data$assay_system)="ASSAY SYSTEM:"
var_label(data$ct_value_1)="Covid CT Value 1"
var_label(data$ct_value_2)="Covid CT Value 2  "
var_label(data$lab1_result_n1ct)="SARS-CoV2 N1 test result (CT value) 1"
var_label(data$lab1_result_rnact)="Human RNAse-P test result (CT value) 1"
var_label(data$lab2_result_n1ct)="SARS-CoV2 N1 test result (CT value) 2"
var_label(data$lab2_result_rnact)="Human RNAse-P test result (CT value) 2"
var_label(data$salivaom_ct1_v2)="Saliva - Omicron: CT Value 1:"
var_label(data$salivaom_ct2_v2)="Saliva - Omicron: CT Value 2"
var_label(data$opswabom_ct1_v2)="OP Swab - Omicron: CT Value 1:"
var_label(data$opswabom_ct2)="OP Swab - Omicron: CT Value 2:"
var_label(data$cepheid_n)="CEPHEID (stand alone) result N2: "
var_label(data$cepheid_e)="CEPHEID (stand alone) result E:"
var_label(data$cepheid_n2_e)="CEPHEID (multiplex) result N2+E:"
var_label(data$comparator_antigen_result)="Result of clinical comparator COVID test:"
var_label(data$ceph_multi_res_flua)="Multiplex Result: Flu A"
var_label(data$flua_ct1)="Flu A CT 1"
var_label(data$flua_ct2)="Flu A CT 2"
var_label(data$ceph_multi_res_flub)="Multiplex Result: Flu B"
var_label(data$flub_ct1)="Flu B CT"
var_label(data$multi_rsv)="Multiplex Result: RSV" 
var_label(data$rsv_ct)="RSV CT"

cleaned_dataset <- data %>% rename(
  ID=Record.ID,
  event=Event.Name,
  age=Age.in.years,
  sex=Participant.s.Sex.at.birth,
  visit_date=Visit.Date,
  symptom_onset=What.is.the.date.of.the.earliest.symptom.onset.,
  current_symptomatic=Are.you.currently.symptomatic...HIDDEN.9.13.23.)

var_label(cleaned_dataset)<-list(
  age="Age in years",
  sex="Participants Sex at birth",
  visit_date="Visit Date",
  symptom_onset="Earliest Symptom Onset",
  current_symptomatic="Symptomatic at Visit Date")
  
symptoms<-c("Fever_14day", "Chills_14day", "Congestion_14day", "Cough_14day", "Headache__14day", 
            "Sore_Throat_14day", "Fatigue_14day", "Joint_Pain_14day", "Myalgia_14day", "Light_Sens_14day", 
            "Vomiting_14day", "Nausea_14day", "Diarrhea_14day", "Abdominal_Pain_14day", "Lossof_smell_14day",
            "Shortnessof_Breath_14day", "Other_14day", "None_14day", "Fever_current", "Chills_current", "Congestion_current", "Cough_current", "Headache_current", 
            "Sore_Throat_current", "Fatigue_current", "Joint_Pain_current", "Myalgia_current", "Light_Sens_current", 
            "Vomiting_current", "Nausea_current", "Diarrhea_current", "Abdominal_Pain_current", "Lossof_smell_current",
            "Shortnessof_Breath_current", "Other_current", "None_current", "Fever_7day", "Chills_7day", "Congestion_7day", "Cough_7day", "Headache_7day", 
            "Sore_Throat_7day", "Fatigue_7day", "Joint_Pain_7day", "Myalgia_7day", "Light_Sens_7day", 
            "Vomiting_7day", "Nausea_7day", "Diarrhea_7day", "Abdominal_Pain_7day", "Lossof_smell_7day",
            "Shortnessof_Breath_7day", "Other_7day", "None_7day")

cleaned_dataset[, symptoms] <- lapply(cleaned_dataset[, symptoms], function(x) {
  ifelse(x == "Checked", 1, ifelse(x == "Unchecked", 0, x))
})

##dates
dates <- c("visit_date", "symptom_onset", "date_dose1_vaccine", "date_dose2_vaccine",
           "date_dose3_vaccine", "date_dose4_vaccine","date_omicron", "date_recent_vax",
           "date_flu_vax", "date_rsv_vax", "date_covid_test")

cleaned_dataset$visit_date <- as.Date(cleaned_dataset$visit_date, format="%m/%d/%Y")
cleaned_dataset$symptom_onset <- as.Date(cleaned_dataset$symptom_onset, format="%m/%d/%Y")

cleaned_dataset$date_dose1_vaccine <- as.Date(cleaned_dataset$date_dose1_vaccine, format="%m/%d/%Y")
cleaned_dataset$date_dose2_vaccine <- as.Date(cleaned_dataset$date_dose2_vaccine, format="%m/%d/%Y")
cleaned_dataset$date_dose3_vaccine <- as.Date(cleaned_dataset$date_dose3_vaccine, format="%m/%d/%Y")
cleaned_dataset$date_dose4_vaccine <- as.Date(cleaned_dataset$date_dose4_vaccine, format="%m/%d/%Y")
cleaned_dataset$date_omicron <- as.Date(cleaned_dataset$date_omicron, format="%m/%d/%Y")
cleaned_dataset$date_recent_vax <- as.Date(cleaned_dataset$date_recent_vax, format="%m/%d/%Y")
cleaned_dataset$date_flu_vax <- as.Date(cleaned_dataset$date_flu_vax, format="%m/%d/%Y")
cleaned_dataset$date_rsv_vax <- as.Date(cleaned_dataset$date_rsv_vax, format="%m/%d/%Y")
cleaned_dataset$date_covid_test <- as.Date(cleaned_dataset$date_covid_test, format="%m/%d/%Y")

final_cleaned_dataset <- cleaned_dataset %>% select(
                                            ##demographic information
                                                    "ID", "age","sex", "visit_date","symptom_onset", "current_symptomatic",
                                                    "assay_system", "comparator_cov_test", 
                                            ##laboratory information
                                                    "ct_value_1", "ct_value_2", "ceph_multi_res_flua",
                                                    "flua_ct1", "flua_ct2", "ceph_multi_res_flub", "flub_ct1", "multi_rsv", "rsv_ct", "comparator",
                                            ##vaccine information
                                                    "vaccine", "covid_vaccine", "doses", "dose1_vaccine", "binary_date_dose1_vaccine", "date_dose1_vaccine",
                                                    "dose2_vaccine", "binary_date_dose2_vaccine", "date_dose2_vaccine", "dose3_vaccine",
                                                    "binary_date_dose3_vaccine", "date_dose3_vaccine", "dose4_vaccine", "binary_date_dose4_vaccine",
                                                    "date_dose4_vaccine", "dose_omicron", "binary_date_omicron", "date_omicron", "vaccinated",
                                                    "doses_numberoverall", "binary_date_recent_vax", "date_recent_vax", "flu_vaccine_lastyr",
                                                    "count_fluvax", "binary_date_fluvax", "date_flu_vax", "rsv_vaccine_lastyr" , "count_rsvvax", "binary_date_rsvvax", 
                                                    "date_rsv_vax", "previous_covid1", "previous_covid2", "date_covid_test", "comparator_antigen_result",
                                                    "any_test_14days1", "any_test_14days2", "pos_test_14days", "neg_test_14days", "neg_test_2days",
                                            ##symptom information
                                                    "Fever_14day", "Chills_14day", "Congestion_14day", "Cough_14day",
                                                    "Headache__14day", "Sore_Throat_14day", "Fatigue_14day","Joint_Pain_14day",
                                                    "Myalgia_14day", "Light_Sens_14day", "Vomiting_14day", "Nausea_14day", "Diarrhea_14day",
                                                    "Abdominal_Pain_14day", "Lossof_smell_14day", "Shortnessof_Breath_14day", "Other_14day",
                                                    "None_14day", "Fever_current", "Chills_current", "Congestion_current", "Cough_current",
                                                    "Headache_current", "Sore_Throat_current", "Fatigue_current", "Joint_Pain_current",
                                                    "Myalgia_current", "Light_Sens_current", "Vomiting_current", "Nausea_current",
                                                    "Diarrhea_current", "Abdominal_Pain_current", "Lossof_smell_current",
                                                    "Shortnessof_Breath_current", "Other_current", "None_current",
                                                    "Fever_7day", "Chills_7day", "Congestion_7day", "Cough_7day", "Headache_7day", "Sore_Throat_7day",
                                                    "Fatigue_7day", "Joint_Pain_7day", "Myalgia_7day", "Light_Sens_7day", "Vomiting_7day",
                                                    "Nausea_7day", "Diarrhea_7day", "Abdominal_Pain_7day", "Lossof_smell_7day", "Shortnessof_Breath_7day",
                                                    "Other_7day", "None_7day"
                                                    )
##removed the samples that did not have a sample tested as indicated in the comparator comments section 
#(went from 2940 to 2925)
final_cleaned_dataset <- final_cleaned_dataset %>% filter(!comparator_cov_test=="" & !comparator_cov_test=="UNDETERMINED (Inconclusive)")
saveRDS(
  final_cleaned_dataset, 
  file = here::here("output/data_clean.rds")
)


