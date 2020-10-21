# load libraries
library(covid19)
library(coronavirus)
library(dplyr)
library(tidyverse)
library(leaflet)
library(scales)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(highcharter)
library(htmltools)
library(plotly)
library(DT)
library(shinythemes)
select <- dplyr::select


# read covid-19 data
data("coronavirus")

## Update the latest data
update_dataset(silence = FALSE)


# Map plot section
## world data for COVID-19, prepare for map
covid19<-coronavirus %>%
  mutate(country = ifelse(country=="Taiwan*", "Taiwan", country),
         province = ifelse(province=="", country, province))

## some countries/regions have different lot/long, select only one randomly
location <- covid19 %>%
  select(province, country, lat, long) %>%
  unique() %>%
  group_by(province, country) %>%
  sample_n(size = 1)

## join population and location data
covid_pop <- covid19 %>%
  pivot_wider(c("date", "province", "country"),
              names_from = type,
              values_from = cases) %>%
  left_join(pop_data, by = c("country"  = "country")) %>%
  left_join(location, by = c( "province" = "province", "country" = "country")) %>%
  mutate(active = confirmed - death - recovered)


## cumulative cases
covid_pop$confirmed_cum <- ave(covid_pop$confirmed, covid_pop$province, FUN = cumsum)
covid_pop$recovered_cum <- ave(covid_pop$recovered, covid_pop$province, FUN = cumsum)
covid_pop$death_cum <- ave(covid_pop$death, covid_pop$province, FUN = cumsum)
covid_pop$active_cum <- ave(covid_pop$active, covid_pop$province, FUN = cumsum)


## function for filtering date, prepare for map
date_filter <- function(inputdate) {
  covid_pop<-covid_pop %>%
    filter(date == inputdate) %>%
    distinct()
}




# other plots section
## data for confirmed cases rate and mortality rate
case_comparison <- covid_pop %>%
  mutate(population = population/1e6) %>%
  group_by(date, country,population) %>%
  summarise(confirmed_cum = sum(confirmed, na.rm = TRUE),
            death_cum = sum(death, na.rm = TRUE)) %>%
  mutate(date= as.Date(date, format = "%d/%m/%y"),
         Confirmed = round((confirmed_cum/population) ,3),
         Mortality = round((death_cum/population),3))

## log cases based on event_data
log_data <- covid_pop %>%
  group_by(date, country) %>%
  summarise(confirmed = sum(confirmed_cum, na.rm = TRUE),
            recovered = sum(recovered_cum, na.rm = TRUE),
            active = sum(active_cum, na.rm = TRUE),
            death = sum(death_cum, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(-confirmed)


## filter cumulative data for the last day
log_data_top <- log_data%>%
  filter(date == max(date)) %>%
  mutate(confirmed = confirmed/1e6)


# valuebox data
total_value <- log_data %>%
  filter(date == max(date)) %>%
  select(3:6) %>%
  summarise_all(.funs = sum)
