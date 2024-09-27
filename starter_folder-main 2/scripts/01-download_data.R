#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Jingchuan Xu
# Date: 26 September 2024
# Contact: jingchuan.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: R package "opendatatoronto" installation
# Any other information needed? None


#### Workspace setup ####
install.packages("opendatatoronto")
install.packages("tidyverse")
library(opendatatoronto)
library(tidyverse)


#### Download data ####

# Retrieve a list of first 131 pages of available data packages from the OpenDataToronto portal
list_packages <- list_packages(131)

# Display the list of available packages
list_packages

# Search for the data package on OpenDataToronto by keyword ("Police Annual Statistical Report - Traffic Collisions")
traffic_collisions_packages <- search_packages("Police Annual Statistical Report - Traffic Collisions")

# Retrieve a list of id available within the found package
traffic_collisions_resources <- traffic_collisions_packages %>%
  list_package_resources()

# Display the list of resources available in the "Police Annual Statistical Report - Traffic Collisions" package
traffic_collisions_resources

# Download the .csv dataset of "Police Annual Statistical Report - Traffic Collisions" package"
traffic_collisions_statistics <- traffic_collisions_resources[8,"id"] %>%
  get_resource()

# Display the csv dataset
traffic_collisions_statistics
subset_df <- simulated_traffic_collisions_each_season[1:1000,1:3]
#### Save data ####
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(subset_df, "data/raw_data/raw_data.csv") 

         
