Uploadable_Project_Draft.html: code/100_render_report.R \
  Uploadable_Project_Draft.Rmd descriptive_analysis boxplots_symptom_duration
	Rscript code/100_render_report.R

output/data_clean.rds: code/00_cleaning_data.R raw_data/fake_data.csv
	Rscript code/00_cleaning_data.R

output/variablized_cleaned_data.rds: code/01_makevariables.R output/data_clean.rds
	Rscript code/01_makevariables.R
	
output/table1.rds: code/03_maketable1.R output/variablized_cleaned_data.rds
	Rscript code/03_maketable1.R

output/covid_boxplot.png: code/04_make_covid_boxplot.R output/variablized_cleaned_data.rds
	Rscript code/04_make_covid_boxplot.R
	
output/fluA_boxplot.png: code/04_make_fluA_boxplot.R output/variablized_cleaned_data.rds
	Rscript code/04_make_fluA_boxplot.R
	
output/fluB_boxplot.png: code/04_make_fluB_boxplot.R output/variablized_cleaned_data.rds
	Rscript code/04_make_fluB_boxplot.R
	
output/rsv_boxplot.png: code/04_make_rsv_boxplot.R output/variablized_cleaned_data.rds
	Rscript code/04_make_rsv_boxplot.R
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	
.PHONY: descriptive_analysis
descriptive_analysis: output/table1.rds 

.PHONY: boxplots_symptom_duration
boxplots_symptom_duration: output/covid_boxplot.png output/fluA_boxplot.png \
  output/fluB_boxplot.png output/rsv_boxplot.png

.PHONY: clean
clean: 
	rm -f output/*.rds && rm -f output/*.png
	
# making rules for docker
PROJECTFILES = Uploadable_Project_Draft.Rmd code/00_cleaning_data.R code/01_makevariables.R code/03_maketable1.R code/04_make_covid_boxplot.R code/04_make_fluA_boxplot.R \
code/04_make_fluB_boxplot.R code/04_make_rsv_boxplot.R \
code/100_render_report.R Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json
# rule to build image
# $@ evaluates to the target name in make
# $(<variable>) references a variable in make
project_image: $(PROJECTFILES) $(RENVFILES)
	docker build --platform=linux/amd64 -t joannehunt/project_image .


#rule to build the report automatically in our container
# $$(<command>) does command substitution in make
report/Uploadable_Project_Draft.html: project_image
	docker run -v \"$$(pwd)/report":/project/final_report joannehunt/final_image
