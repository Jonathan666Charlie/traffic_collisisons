#### Preamble ####
# Purpose: Simulates data for the Building Permits - Solar Hot Water Heaters.
# Author: Jingchuan Xu
# Date: 26 September 2024
# Contact: jingchuan.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Have a certain R intalled and loaded.
# Any other information needed? None


#### Workspace setup ####
install.packages("lubridate")
install.packages("dplyr")
install.packages("tidyverse")
library(tidyverse)
library(lubridate)
library(dplyr)

#### Simulate data ####
set.seed(1314)

# Use the existing year and month columns directly, no need to extract the year and month from OCC_DATE
simulated_traffic_collisions_data <- traffic_collisions_statistics %>%
  select(OCC_YEAR, OCC_MONTH)

injury_collisions <- simulated_traffic_collisions_data %>%
  mutate(injury_collisions = ifelse("INJURY_COLLISIONS" == "YES", 1, 0))

# Poisson distribution was used to generate the number of traffic accidents with lambda = 15
simulated_traffic_collisions_data <- simulated_traffic_collisions_data %>%
  mutate(injury_collisions = rpois(n = n(), lambda = 15))

# Adding season columns
simulated_traffic_collisions_data <- simulated_traffic_collisions_data %>%
  mutate(season = ifelse(OCC_MONTH %in% c("March", "April", "May"), "Spring", 
                         ifelse(OCC_MONTH %in% c("June", "July", "August"), "Summer",
                                ifelse(OCC_MONTH %in% c("September", "October", "November"), "Autumn",
                                       "Winter"))))

# Group by season and year & 
traffic_collisions_in_season_and_year <- simulated_traffic_collisions_data %>%
  group_by(season, OCC_YEAR)

# The total number of traffic collisions for each season of each year is summarized
simulated_traffic_collisions_each_season <- summarize(traffic_collisions_in_season_and_year, injury_collisions = sum(injury_collisions))

# Compare the number of accidents in winter with other seasons
winter_data <- simulated_traffic_collisions_each_season %>%
  filter(season == "Winter")

non_winter_data <- simulated_traffic_collisions_each_season %>%
  filter(season != "Winter")

#### Write_csv
write_csv(simulated_traffic_collisions_each_season, file = "data/analysis_data/simulated.csv")
