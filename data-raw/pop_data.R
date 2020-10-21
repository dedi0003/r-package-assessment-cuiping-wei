# population data

## remotes::install_github("nset-ornl/wbstats")
library(dplyr)
library(wbstats)

pop_data <- wb_data("SP.POP.TOTL", start_date = 2019, end_date = 2019) %>%
  select(country, population = "SP.POP.TOTL") %>%
  mutate(country = recode(country,
                          "Bahamas, The" = "Bahamas",
                          "Gambia, The" = "Gambia",
                          "Kyrgyz Republic" = "Kyrgyzstan",
                          "Lao PDR" = "Laos",
                          "St. Kitts and Nevis" = "Saint Kitts and Nevis",
                          "Syrian Arab Republic" = "Syria",
                          "Brunei Darussalam" = "Brunei",
                          "Congo, Dem. Rep." = "Congo (Kinshasa)",
                          "Congo, Rep." = "Congo (Brazzaville)",
                          "Czech Republic" = "Czechia",
                          "Egypt, Arab Rep." = "Egypt",
                          "Iran, Islamic Rep." = "Iran",
                          "Korea, Rep." =  "Korea, South",
                          "St. Lucia" = "Saint Lucia",
                          "Russian Federation" = "Russia",
                          "Slovak Republic" = "Slovakia",
                          "United States" = "US",
                          "St. Vincent and the Grenadines" = "Saint Vincent and the Grenadines",
                          "Venezuela, RB" = "Venezuela",
                          "Yemen, Rep." = "Yemen",
                          "Myanmar" = "Burma"))


## Data from worldometer, add data for no population countries
add_pop <- data.frame(
  country    = c("Holy See", "Western Sahara", "Taiwan", "MS Zaandam"),
  population = c(801, 601115, 23827505, 76804)
)

## conbine together
pop_data<- bind_rows(pop_data, add_pop)

usethis::use_data(pop_data, overwrite = FALSE)


