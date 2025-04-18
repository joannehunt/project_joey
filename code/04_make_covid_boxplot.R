library(ggplot2)
library(dplyr)
here::i_am("code/04_make_covid_boxplot.R")
covid_ct_symptom_group<- readRDS(file = here::here("output/variablized_cleaned_data.rds"))

covid_ct_symptom_group_filtered <- covid_ct_symptom_group %>%
  filter(!is.na(ct_value_1), !is.na(symptom_duration_groups), !covid_result_factor=="Negative")

boxplot_covid<- ggplot(covid_ct_symptom_group_filtered, 
       aes(x = symptom_duration_groups, y = ct_value_1, fill = symptom_duration_groups)) +
  geom_boxplot(alpha = 0.5, outlier.shape = 14, outlier.size = 1.5, width = 0.6) +  # Adjust box width
  geom_jitter(aes(color = symptom_duration_groups), width = 0.15, height = 0, alpha = 0.6, size = 1.2) +  # Better jitter spread
  scale_fill_manual(values = c("#eff3ff","#c6dbef","#9ecae1", "#6baed6", "#4292c6","#2171b5","#084594"))+
  scale_color_manual(values = c("black", "black", "black", "black", "black", "black","black")) +
  labs(
    title = "Comparison of Sars-CoV-2 Ct Values Across Symptom Duration Groups",
    x = "Symptom Duration (Days)",
    y = "Ct Value"
  ) +
  theme_minimal() +
  theme(
    text = element_text(size = 12), 
    axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for readability
    legend.position = "none"  # Remove legend if unnecessary
  )

boxplot_covid

ggsave(
  here::here("output/covid_boxplot.png"),
  plot = boxplot_covid,
  width = 7, 
  height = 6,
  bg = "white",
  device = "png"
)