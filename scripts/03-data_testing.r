#### Preamble ####
# Purpose: Testing Data from the GSS
# Prerequisites: Need to have downloaded and cleaned the data
# Author: Sebastian Rodriguez, Laura Lee-Chu, Iz Leitch
# Email: me@srod.ca
# Date: 16 March 2023
# GitHub: https://github.com/seb646/happiness-and-altruism

#### Workspace set-up ####
library(tidyverse)
library(janitor)
library(here)
library(readr)

#### Test the clean happiness positive data #### 
# Fetch the the clean happiness positive data
happy_positive_data <- readr::read_csv(here::here("inputs/data/clean/happy_positive_data.csv"), show_col_types = FALSE)

# Test that the number of people in each column is less than or equal to 6,000
happy_positive_data$people |> max() <= 6000

# Test that the number of people in each column is greater than or equal to 1
happy_positive_data$people |> min() >= 1

# Test that the year is less than or equal to 2014
happy_positive_data$year |> max() <= 2014

# Test that the year is greater than or equal to 2002
happy_positive_data$year |> min() >= 2002


#### Test the clean directions positive data #### 
# Fetch clean directions positive data
directions_positive_data <- readr::read_csv(here::here("inputs/data/clean/directions_positive_data.csv"), show_col_types = FALSE)

# Test that the number of people in each column is less than or equal to 6,000
directions_positive_data$people |> max() <= 6000

# Test that the number of people in each column is greater than or equal to 1
directions_positive_data$people |> min() >= 1

# Test that the year is less than or equal to 2014
directions_positive_data$year |> max() <= 2014

# Test that the year is greater than or equal to 2002
directions_positive_data$year |> min() >= 2002


#### Test the clean homeless positive data #### 
# Fetch the clean homeless positive data
homeless_positive_data <- readr::read_csv(here::here("inputs/data/clean/homeless_positive_data.csv"), show_col_types = FALSE)

# Test that the number of people in each column is less than or equal to 6,000
homeless_positive_data$people |> max() <= 6000

# Test that the number of people in each column is greater than or equal to 1
homeless_positive_data$people |> min() >= 1

# Test that the year is less than or equal to 2014
homeless_positive_data$year |> max() <= 2014

# Test that the year is greater than or equal to 2002
homeless_positive_data$year |> min() >= 2002


#### Test the clean happiness negative data #### 
# Fetch the the clean happiness negative data
happy_negative_data <- readr::read_csv(here::here("inputs/data/clean/happy_negative_data.csv"), show_col_types = FALSE)

# Test that the number of people in each column is less than or equal to 6,000
happy_negative_data$people |> max() <= 6000

# Test that the number of people in each column is greater than or equal to 1
happy_negative_data$people |> min() >= 1

# Test that the year is less than or equal to 2014
happy_negative_data$year |> max() <= 2014

# Test that the year is greater than or equal to 2002
happy_negative_data$year |> min() >= 2002


#### Test the clean directions negative data #### 
# Fetch clean directions negative data
directions_negative_data <- readr::read_csv(here::here("inputs/data/clean/directions_negative_data.csv"), show_col_types = FALSE)

# Test that the number of people in each column is less than or equal to 6,000
directions_negative_data$people |> max() <= 6000

# Test that the number of people in each column is greater than or equal to 1
directions_negative_data$people |> min() >= 1

# Test that the year is less than or equal to 2014
directions_negative_data$year |> max() <= 2014

# Test that the year is greater than or equal to 2002
directions_negative_data$year |> min() >= 2002


#### Test the clean homeless negative data #### 
# Fetch the clean homeless negative data
homeless_negative_data <- readr::read_csv(here::here("inputs/data/clean/homeless_negative_data.csv"), show_col_types = FALSE)

# Test that the number of people in each column is less than or equal to 6,000
homeless_negative_data$people |> max() <= 6000

# Test that the number of people in each column is greater than or equal to 1
homeless_negative_data$people |> min() >= 1

# Test that the year is less than or equal to 2014
homeless_negative_data$year |> max() <= 2014

# Test that the year is greater than or equal to 2002
homeless_negative_data$year |> min() >= 2002