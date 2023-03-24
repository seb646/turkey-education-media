#### Preamble ####
# Purpose: Import and clean data from the USAID's DHS
# Author: Youngho Kim, Laura Lee-Chu, Sebastian Rodriguez
# Email: me@srod.ca
# Date: 27 March 2023
# GitHub: https://github.com/seb646/turkey-education-media

#### Workspace set-up ####
library(pdftools)
library(tidyverse)
library(stringi)
library(here)
library(arrow)

#### Import data ####
# Download the pdf from the DHS website
download.file(
  "https://dhsprogram.com/pubs/pdf/FR108/FR108.pdf",
  here::here("inputs/1998_Turkey_DHS.pdf"),
  mode = "wb"
)

# Fetch the PDF report
education_report <- pdf_text(
  here::here("inputs/1998_Turkey_DHS.pdf")
)

# Fetch Page 45 of the PDF - Education Levels
page_45 <- stri_split_lines(education_report[[45]])[[1]]
page_45 <- page_45[page_45 != ""]

# Fetch Page 48 of the PDF - Exposure to Print Media
page_48 <- stri_split_lines(education_report[[48]])[[1]]
page_48 <- page_48[page_48 != ""]

#### Clean Education Levels Data Table ####
## Women - Age ## 
# Find the relevant rows
women_education_age <- tibble(all = page_45[9:15])

# Initial data cleaning
women_education_age <- women_education_age |>
  # Remove any two or more spaces
  mutate(all = str_squish(all)) |>
  
  # Replace all commas with underscores
  mutate(all = str_replace(all, ", ", "_")) |>
  
  # Separate into columns
  separate(
    col = all,
    into = c(
      "characteristic",
      "no_education",
      "primary_incomplete",
      "primary_complete",
      "secondary_incomplete",
      "secondary_complete",
      "total",
      "number_of_people"
    ),
    sep = " ", # Separate by spaces
    remove = TRUE,
    fill = "right",
    extra = "drop"
  )

## Women - Residence ## 
# Find the relevant rows
women_education_residence <- tibble(all = page_45[17:18])

# Initial data cleaning
women_education_residence <- women_education_residence |>
  # Remove any two or more spaces
  mutate(all = str_squish(all)) |>
  
  # Replace all commas with underscores
  mutate(all = str_replace(all, ", ", "_")) |>
  
  # Separate into columns
  separate(
    col = all,
    into = c(
      "characteristic",
      "no_education",
      "primary_incomplete",
      "primary_complete",
      "secondary_incomplete",
      "secondary_complete",
      "total",
      "number_of_people"
    ),
    sep = " ", # Separate by spaces
    remove = TRUE,
    fill = "right",
    extra = "drop"
  )

## Husband - Age ## 
# Find the relevant rows
husband_education_age <- tibble(all = page_45[28:34])

# Initial data cleaning
husband_education_age <- husband_education_age |>
  # Replace all commas with underscores
  mutate(all = str_replace(all, ", ", "_")) |>
  
  # Replace all "I" with "1" caused by PDF reading error
  mutate(all = str_replace(all, "I ", "1")) |>
  
  # Replace any other odd formatting issues
  mutate(all = str_replace(all, "([:alpha:]) ([:alpha:])", "\\1_\\2")) |>
  mutate(all = str_replace(all, "([:alpha:]|_) ([:alpha:])", "\\1_\\2")) |>
  
  # Remove any two or more spaces
  mutate(all = str_squish(all)) |>
  
  # Separate into columns
  separate(
    col = all,
    into = c(
      "characteristic",
      "no_education",
      "primary_incomplete",
      "primary_complete",
      "secondary_incomplete",
      "secondary_complete",
      "total",
      "number_of_people"
    ),
    sep = " ", # Separate by spaces
    remove = TRUE,
    fill = "right",
    extra = "drop"
  )

## Husband - Residence ## 
# Find the relevant rows
husband_education_residence <- tibble(all = page_45[36:37])

# Initial data cleaning
husband_education_residence <- husband_education_residence |>
  # Replace all commas with underscores
  mutate(all = str_replace(all, ", ", "_")) |>
  
  # Replace all "I" with "1" caused by PDF reading error
  mutate(all = str_replace(all, "I ", "1")) |>
  
  # Remove all "\"" caused by PDF reading error
  mutate(all = str_replace(all, "\"", "")) |>
  
  # Replace any other odd formatting issues
  mutate(all = str_replace(all, "([:alpha:]) ([:alpha:])", "\\1_\\2")) |>
  mutate(all = str_replace(all, "([:alpha:]|_) ([:alpha:])", "\\1_\\2")) |>
  
  # Remove any two or more spaces
  mutate(all = str_squish(all)) |>
  
  # Separate into columns
  separate(
    col = all,
    into = c(
      "characteristic",
      "no_education",
      "primary_incomplete",
      "primary_complete",
      "secondary_incomplete",
      "secondary_complete",
      "total",
      "number_of_people"
    ),
    sep = " ", # Separate by spaces
    remove = TRUE,
    fill = "right",
    extra = "drop"
  )

## Add gender column for data ## 
women_education_age <- add_column(
  women_education_age, 
  "gender" = "Women", 
  .before = "characteristic"
)
women_education_residence <- add_column(
  women_education_residence,
  "gender" = "Women",
  .before = "characteristic"
)
husband_education_age <- add_column(
  husband_education_age,
  "gender" = "Husband",
  .before = "characteristic"
)
husband_education_residence <- add_column(
  husband_education_residence, 
  "gender" = "Husband",
  .before = "characteristic"
)

# Clean and format the data
data <-
  # Specify which tables to merge (this merges by row)
  bind_rows(
    women_education_age,
    women_education_residence,
    husband_education_age,
    husband_education_residence
  ) |>
  
  # Fix those pesky PDF formatting errors
  mutate(characteristic = str_replace(characteristic, ",", "-")) |>
  mutate(characteristic = str_replace(characteristic, "÷", "+")) |>
  mutate(no_education = str_replace(no_education, ",", ".")) |>
  mutate(primary_incomplete = str_replace(primary_incomplete, ",", ".")) |>
  mutate(primary_complete = str_replace(primary_complete, ",", ".")) |>
  mutate(secondary_incomplete = str_replace(secondary_incomplete, ",", ".")) |>
  mutate(secondary_complete = str_replace(secondary_complete, ",", ".")) |>
  mutate(total = str_replace(total, ",", ".")) |>
  mutate(number_of_people = str_replace(number_of_people, ",", ""))

# Write it all to a parquet file
write_parquet(
  data, 
  here::here("inputs/data/education_levels.parquet")
)

#### Exposure to Print Media ####
## Media - Age ## 
# Find the relevant rows
media_age <- tibble(all = page_48[19:26])

# Initial data cleaning
media_age <- media_age |>
  # Replace all commas with underscores
  mutate(all = str_replace(all, ", ", "_")) |>
  
  # Replace all "I" with "1" caused by PDF reading error
  mutate(all = str_replace(all, "I ", "1")) |>
  
  # Remove all "\"" caused by PDF reading error
  mutate(all = str_replace(all, "\"", "")) |>
  
  # Replace any other odd formatting issues
  mutate(all = str_replace(all, "([:alpha:]) ([:alpha:])", "\\1_\\2")) |>
  mutate(all = str_replace(all, "([:alpha:]|_) ([:alpha:])", "\\1_\\2")) |>
  
  # Remove any two or more spaces
  mutate(all = str_squish(all)) |>

  # Separate into solumns
  separate(
    col = all,
    into = c(
      "characteristic",
      "women_read_weekly",
      "women_number",
      "husband_read_weekly",
      "husband_number"
    ),
    sep = " ", # Separate by spaces
    remove = TRUE,
    fill = "right",
    extra = "drop"
  )

## Media - Residence ## 
# Find the relevant rows
media_residence <- tibble(all = page_48[28:29])

# Initial data cleaning
media_residence <- media_residence |>
  # Replace all commas with underscores
  mutate(all = str_replace(all, ", ", "_")) |>
  
  # Replace all "I" with "1" caused by PDF reading error
  mutate(all = str_replace(all, "I ", "1")) |>
  
  # Remove all "\"" caused by PDF reading error
  mutate(all = str_replace(all, "\"", "")) |>
  
  # Replace any other odd formatting issues
  mutate(all = str_replace(all, "([:alpha:]) ([:alpha:])", "\\1_\\2")) |>
  mutate(all = str_replace(all, "([:alpha:]|_) ([:alpha:])", "\\1_\\2")) |>
  
  # Remove any two or more spaces
  mutate(all = str_squish(all)) |>
  
  # Separate into columns
  separate(
    col = all,
    into = c(
      "characteristic",
      "women_read_weekly",
      "women_number",
      "husband_read_weekly",
      "husband_number"
    ),
    sep = " ", # Separate by spaces
    remove = TRUE,
    fill = "right",
    extra = "drop"
  )

# Clean and format the data
media_data <- 
  # Specify which tables to merge (this merges by row)
  bind_rows(media_age, media_residence) |>
  
  # Fix those pesky PDF formatting errors
  mutate(women_number = str_replace(women_number, ",", "")) |>
  mutate(husband_number = str_replace(husband_number, ",", "")) |>
  mutate(husband_read_weekly = str_replace(husband_read_weekly, ",", "."))

# Write it all to a parquet file
write_parquet(
  media_data,
  here::here("inputs/data/exposure_to_print_media.parquet")
)
