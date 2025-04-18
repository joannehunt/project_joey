library(ggplot2)
library(dplyr)

data_covid_vax_filled<- readRDS(file = here::here("output/variablized_cleaned_data.rds"))

covid_drtn_group_filtered <- data_covid_vax_filled %>%
  filter(!is.na(ct_value_1), !is.na(durtn_vax_factor), !covid_result_factor=="Negative")

boxplot_covidvax<- ggplot(covid_drtn_group_filtered, 
                       aes(x = durtn_vax_factor, y = ct_value_1, fill = durtn_vax_factor)) +
  geom_boxplot(alpha = 0.5, outlier.shape = 14, outlier.size = 1.5, width = 0.6) +  # Adjust box width
  geom_jitter(aes(color = symptom_duration_groups), width = 0.15, height = 0, alpha = 0.6, size = 1.2) +  # Better jitter spread
  scale_fill_manual(values = c("#eff3ff","#c6dbef","#9ecae1", "#6baed6", "#4292c6","#2171b5","#084594"))+
  scale_color_manual(values = c("black", "black", "black", "black", "black", "black","black")) +
  labs(
    title = "Comparison of Sars-CoV-2 Ct Values Across Duration Since Vaccination Groups",
    x = "Duration since Most Recent COVID Vaccination (Months)",
    y = "Ct Value"
  ) +
  theme_minimal() +
  theme(
    text = element_text(size = 12), 
    axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for readability
    legend.position = "none"  # Remove legend if unnecessary
  )

boxplot_covidvax

boxplot_covid <- ggplot(covid_vax_group_filtered, aes(x = durtn_vax_factor, y = ct_value_1)) +
  geom_boxplot(fill = "lightblue", alpha = 0.5, outlier.shape = NA) +  # Boxplot with transparency
  geom_jitter(width = 0.2, height = 0, alpha = 0.6, color = "black", size = 1)  +  # Jitter on top
  labs(title = "Ct Values for COVID-19 by Duration since Vaccination",
       x = "Duration since Vaccination (Months)",
       y = "Ct Value") +
  theme_minimal() +
  theme(text = element_text(size = 9))
boxplot_covid

ggsave(
  here::here("output/covid_boxplot.png"),
  plot = boxplot_covid,
  width = 7, 
  height = 6,
  bg = "white",
  device = "png"
)