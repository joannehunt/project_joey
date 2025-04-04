Final_Project_Draft_April3.html: code/100_render_report.R \
  Final_Project_Draft.Rmd descriptive_analysis boxplots_symptom_duration
	Rscript code/100_render_report.R

output/data_clean.rds: code/cleaning_data.R raw_data/full_dataset_working_copy_03.csv
	Rscript code/cleaning_data.R

output/variablized_cleaned_data.rds: code/01_makevariables.R output/data_clean.rds
	Rscript code/01_makevariables.R
	
output/table1.rds: code/03_maketable1.R output/variablized_cleaned_data.rds
	Rscript code/03_maketable1.R

output/covid_boxplot.png: code/04_make_covid_boxplot.R output/covid_boxplot.png
	Rscript code/04_make_covid_boxplot.R
	
output/fluA_boxplot.png: code/04_make_fluA_boxplot.R output/fluA_boxplot.png
	Rscript code/04_make_fluA_boxplot.R
	
output/fluB_boxplot.png: code/04_make_fluB_boxplot.R output/fluB_boxplot.png
	Rscript code/04_make_fluB_boxplot.R
	
output/rsv_boxplot.png: code/04_make_rsv_boxplot.R output/rsv_boxplot.png
	Rscript code/04_make_rsv_boxplot.R

.PHONY: descriptive_analysis
descriptive_analysis: output/table1.rds 

.PHONY: boxplots_symptom_duration
boxplots_symptom_duration: output/covid_boxplot.png output/fluA_boxplot.png \
  output/fluB_boxplot.png output/rsv_boxplot.png

.PHONY: clean
clean: 
	rm -f output/*.rds && rm -f output/*.png