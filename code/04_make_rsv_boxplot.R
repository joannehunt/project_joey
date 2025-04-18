library(ggplot2)
library(dplyr)
here::i_am("code/04_make_rsv_boxplot.R")
data <- readRDS(file = here::here("output/variablized_cleaned_data.rds"))

rsv_ct_symptom_group<- data %>% filter(rsv_result_factor=="Positive")

#dropping the NAs for this subset
rsv_ct_symptom_group <- rsv_ct_symptom_group %>%
  filter(!is.na(symptom_duration_groups))

boxplot_rsv <- ggplot(rsv_ct_symptom_group, aes(x = symptom_duration_groups, y = rsv_ct, fill = symptom_duration_groups)) +
  geom_boxplot(alpha = 0.5, outlier.shape = 14, outlier.size = 1.5, width = 0.6) +  # Adjust box width
  geom_jitter(aes(color = symptom_duration_groups), width = 0.15, height = 0, alpha = 0.6, size = 1.2) +  # Better jitter spread
  scale_fill_manual(values = c("#eff3ff","#c6dbef","#9ecae1", "#6baed6", "#4292c6","#2171b5","#084594"))+
  scale_color_manual(values = c("black", "black", "black", "black", "black", "black","black")) +
  labs(
    title = "Comparison of RSV Ct Values Across Symptom Duration Groups",
    x = "Symptom Duration (Days)",
    y = "Ct Value"
  ) +
  theme_minimal() +
  theme(
    text = element_text(size = 12), 
    axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for readability
    legend.position = "none"  # Remove legend if unnecessary
  )

ggsave(
  here::here("output/rsv_boxplot.png"),
  plot = boxplot_rsv,
  width = 7, 
  height = 6,
  bg = "white",
  device = "png"
)