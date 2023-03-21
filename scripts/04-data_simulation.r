### Preamble ####
# Purpose: Read in data from the GSS
# Prerequisites: Need to know where to get GSS data
# Author: Sebastian Rodriguez, Laura Lee-Chu, Iz Leitch
# Email: me@srod.ca
# Date: 16 March 2023
# GitHub: https://github.com/seb646/happiness-and-altruism

#### Workspace set-up ####
library(tidyverse) # A collection of data-related packages
library(janitor) # Helps clean datasets
set.seed(124) # Set the seed for consistent randomness

#### Simulate data based on three datasets from GSS ####
# General Happiness: https://gssdataexplorer.norc.org/variables/434/vshow
# Has Given Directions to a Stranger: https://gssdataexplorer.norc.org/variables/2886/vshow
# Has Given Money or Food to a Homeless Person: https://gssdataexplorer.norc.org/variables/2878/vshow

simulated_raw_data <-
  tibble(
    # Configure for ballots numbered 1-3
    "BALLOT" = sample(
      x = c(1:3),
      size = 10000,
      replace = TRUE
    ),
    # Configure for happiness responses -100, -99, -98, -97, 1, 2, 3
    "HAPPY" = sample(
      x = c(-100, -99, -98, -97, 1, 2, 3),
      size = 10000,
      replace = TRUE
    ),
    # Configure for homeless giving responses -100, -99, -98, -97, 1, 2, 3, 4, 5, 6
    "GIVHMLSS" = sample(
      x = c(-100, -99, -98, -97, 1, 2, 3, 4, 5, 6),
      size = 10000,
      replace = TRUE
    ),
    # Configure for directions responses -100, -99, -98, -97, 1, 2, 3, 4, 5, 6
    "DIRECTNS" = sample(
      x = c(-100, -99, -98, -97, 1, 2, 3, 4, 5, 6),
      size = 10000,
      replace = TRUE
    ),
    # Configure for years 2002, 2004, 2012, 2014
    "YEAR" = sample(
      x = c(2002, 2004, 2012, 2014),
      size = 10000,
      replace = TRUE
    )
  )

simulated_raw_data