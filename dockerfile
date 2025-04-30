FROM rocker/tidyverse AS base

RUN apt-get update && apt-get install -y

RUN mkdir /project
WORKDIR /project

RUN mkdir code
RUN mkdir output
RUN mkdir raw_data
#copy all relevant files
COPY raw_data raw_data
COPY code code
COPY Makefile .
COPY Uploadable_Project_Draft.Rmd .

#be careful to copy only the essential renv files and not the renv library
COPY .Rprofile .
COPY renv.lock .
RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.json renv
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE=renv/.cache

RUN R -e 'options(repos = c(CRAN = "https://cloud.r-project.org")); renv::restore()'

RUN mkdir final_report

RUN apt-get update && apt-get install -y pandoc

CMD make && mv Uploadable_Project_Draft.html final_report/