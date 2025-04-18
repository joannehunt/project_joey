here::i_am("code/100_render_report.R")

library(rmarkdown)
report_filename<- paste0(
  "Uploadable_Project_Draft.html"
)
#rendering in production mode
render("Final_Project_Draft.Rmd",
       output_file = report_filename)
