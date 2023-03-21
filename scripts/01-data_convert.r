#### Preamble ####
# Purpose: Import data from the GSS
# Author: Sebastian Rodriguez, Laura Lee-Chu, Iz Leitch
# Email: me@srod.ca
# Date: 16 March 2023
# GitHub: https://github.com/seb646/happiness-and-altruism

#### Workspace set-up ####
#### Workspace set-up ####
# install.packages('pdftools')
# install.packages('stringi')
library(pdftools)
library(tidyverse)
library(stringi)

# download.file("https://dhsprogram.com/pubs/pdf/FR108/FR108.pdf", "inputs/data/1998_Turkey_DHS.pdf", mode="wb")

education_report <- pdf_text("inputs/data/1998_Turkey_DHS.pdf")

page_45<-stri_split_lines(education_report[[45]])[[1]]
page_45<-page_45[page_45 != ""]

page_48<-stri_split_lines(education_report[[48]])[[1]]
page_48<-page_48[page_48 != ""]

#### Education #### 
# Women education level + age
women_education_age <- tibble(all = page_45[9:15])
women_education_age <- women_education_age |>
  mutate(all = str_squish(all)) |>  # Any space more than two spaces is reduced
  mutate(all = str_replace(all, ", ", "_")) |> 
  separate(col = all,
           into = c("characteristic", 
                    "no_education", 
                    "primary_incomplete", 
                    "primary_complete", 
                    "secondary_incomplete", 
                    "secondary_complete", 
                    "total",
                    "number_of_people"),
           sep = " ", # Works fine because the tables are nicely laid out
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )

# Women residence
women_education_residence <- tibble(all = page_45[17:18])
women_education_residence <- women_education_residence |>
  mutate(all = str_squish(all)) |>  # Any space more than two spaces is reduced
  mutate(all = str_replace(all, ", ", "_")) |> 
  separate(col = all,
           into = c("characteristic", 
                    "no_education", 
                    "primary_incomplete", 
                    "primary_complete", 
                    "secondary_incomplete", 
                    "secondary_complete", 
                    "total",
                    "number_of_people"),
           sep = " ", # Works fine because the tables are nicely laid out
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )

# Husband education level + age
husband_education_age <- tibble(all = page_45[28:34])
husband_education_age <- husband_education_age |>
  mutate(all = str_replace(all, ", ", "_")) |> 
  mutate(all = str_replace(all, "I ", "1")) |> 
  mutate(all = str_replace(all, "([:alpha:]) ([:alpha:])", "\\1_\\2")) |> 
  mutate(all = str_replace(all, "([:alpha:]|_) ([:alpha:])", "\\1_\\2")) |> 
  mutate(all = str_squish(all)) |>
  separate(col = all,
           into = c("characteristic", 
                    "no_education", 
                    "primary_incomplete", 
                    "primary_complete", 
                    "secondary_incomplete", 
                    "secondary_complete", 
                    "total",
                    "number_of_people"),
           sep = " ", # Works fine because the tables are nicely laid out
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )

# Husband residence
husband_education_residence <- tibble(all = page_45[36:37])
husband_education_residence <- husband_education_residence |>
  mutate(all = str_replace(all, ", ", "_")) |> 
  mutate(all = str_replace(all, "I ", "1")) |> 
  mutate(all = str_replace(all, "\"", "")) |> 
  mutate(all = str_replace(all, "([:alpha:]) ([:alpha:])", "\\1_\\2")) |> 
  mutate(all = str_replace(all, "([:alpha:]|_) ([:alpha:])", "\\1_\\2")) |>
  mutate(all = str_squish(all)) |>  # Any space more than two spaces is reduced
  separate(col = all,
           into = c("characteristic",
                    "no_education",
                    "primary_incomplete",
                    "primary_complete",
                    "secondary_incomplete",
                    "secondary_complete",
                    "total",
                    "number_of_people"),
           sep = " ", # Works fine because the tables are nicely laid out
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )

# Add gender column
women_education_age <- add_column(women_education_age, "gender" = "Women", .before = "characteristic")
women_education_residence <- add_column(women_education_residence, "gender" = "Women", .before = "characteristic")
husband_education_age <- add_column(husband_education_age, "gender" = "Husband", .before = "characteristic")
husband_education_residence <- add_column(husband_education_residence, "gender" = "Husband", .before = "characteristic")

# Clean the data
data <- bind_rows(women_education_age, women_education_residence, husband_education_age, husband_education_residence) |>
  mutate(characteristic = str_replace(characteristic, ",", "-")) |>
  mutate(characteristic = str_replace(characteristic, "÷", "+")) |>
  mutate(no_education = str_replace(no_education, ",", ".")) |>
  mutate(primary_incomplete = str_replace(primary_incomplete, ",", ".")) |> 
  mutate(primary_complete = str_replace(primary_complete, ",", ".")) |> 
  mutate(secondary_incomplete = str_replace(secondary_incomplete, ",", ".")) |> 
  mutate(secondary_complete = str_replace(secondary_complete, ",", ".")) |> 
  mutate(total = str_replace(total, ",", ".")) |>
  mutate(number_of_people = str_replace(number_of_people, ",", ""))

write_csv(data, "inputs/data/education_levels.csv")

#### Exposure to Print Media ####
media_age <- tibble(all = page_48[19:26])
media_age <- media_age |>
  mutate(all = str_replace(all, ", ", "_")) |> 
  mutate(all = str_replace(all, "I ", "1")) |> 
  mutate(all = str_replace(all, "\"", "")) |> 
  mutate(all = str_replace(all, "([:alpha:]) ([:alpha:])", "\\1_\\2")) |> 
  mutate(all = str_replace(all, "([:alpha:]|_) ([:alpha:])", "\\1_\\2")) |>
  mutate(all = str_squish(all)) |>  # Any space more than two spaces is reduced
  separate(col = all,
           into = c("characteristic",
                    "women_read_weekly",
                    "women_number",
                    "husband_read_weekly",
                    "husband_number"),
           sep = " ", # Works fine because the tables are nicely laid out
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )

media_residence <- tibble(all = page_48[28:29])
media_residence <- media_residence |>
  mutate(all = str_replace(all, ", ", "_")) |> 
  mutate(all = str_replace(all, "I ", "1")) |> 
  mutate(all = str_replace(all, "\"", "")) |> 
  mutate(all = str_replace(all, "([:alpha:]) ([:alpha:])", "\\1_\\2")) |> 
  mutate(all = str_replace(all, "([:alpha:]|_) ([:alpha:])", "\\1_\\2")) |>
  mutate(all = str_squish(all)) |>  # Any space more than two spaces is reduced
  separate(col = all,
           into = c("characteristic",
                    "women_read_weekly",
                    "women_number",
                    "husband_read_weekly",
                    "husband_number"),
           sep = " ", # Works fine because the tables are nicely laid out
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )

media_data <- bind_rows(media_age, media_residence)|>
  mutate(women_number = str_replace(women_number, ",", "")) |>
  mutate(husband_number = str_replace(husband_number, ",", "")) |>
  mutate(husband_read_weekly = str_replace(husband_read_weekly, ",", "."))

write_csv(media_data, "inputs/data/exposure_to_print_media.csv")
