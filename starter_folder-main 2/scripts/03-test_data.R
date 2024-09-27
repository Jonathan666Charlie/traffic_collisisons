#### Preamble ####
# Purpose: Tests code for data
# Author: Jingchuan Xu
# Date: 27 Septemebr 2024
# Contact: jingchuan.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: have R installed
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
data <- read_csv("data/analysis_data/analysis_data.csv")

#### Test data ####
# Check for missing values in each column
any(is.na(data))

# Check if all injury_collisions are non-negative
all(data$injury_collisions >= 0)

# Check for unique values in the season column
unique(data$season)

# Check if all years are valid (not in the future)
all(data$OCC_YEAR <= format(Sys.Date(), "%Y"))
