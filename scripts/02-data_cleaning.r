#### Preamble ####
# Purpose: Import raw csv data, clean it, and generate new csv files
# Author: Sebastian Rodriguez, Laura Lee-Chu, Iz Leitch
# Email: me@srod.ca
# Date: 16 March 2023
# GitHub: https://github.com/seb646/happiness-and-altruism

#### Workspace set-up ####
library(foreign)
library(tidyverse)
library(dplyr)
library(here)
library(readr)
library(janitor)

#### Fetch and clean happiness data (where happy) ####
clean_happy_positive_data <- readr::read_csv(here::here("inputs/data/raw/GSS.csv"), show_col_types = FALSE) |>
  # Change column naming format
  clean_names() |> 
  select(year, happy) |>
  filter(happy >= 2) |> 
  count(year, happy) |>
  group_by(year) |>
  summarise(people = sum(n))

write_csv(
  x = clean_happy_positive_data,
  file = here::here("inputs/data/clean/happy_positive_data.csv"),
)

#### Fetch and clean directions data (where happy) ####
clean_directions_positive_data <- readr::read_csv(here::here("inputs/data/raw/GSS.csv"), show_col_types = FALSE) |>
  # Change column naming format
  clean_names() |> 
  select(year, directns) |>
  filter(directns >= 1, directns <= 4) |> 
  count(year, directns) |>
  group_by(year) |>
  summarise(people = sum(n))

write_csv(
  x = clean_directions_positive_data,
  file = here::here("inputs/data/clean/directions_positive_data.csv"),
)

#### Fetch and homeless directions data (where happy) ####
clean_homeless_positive_data <- readr::read_csv(here::here("inputs/data/raw/GSS.csv"), show_col_types = FALSE) |>
  # Change column naming format
  clean_names() |> 
  select(year, givhmlss) |>
  filter(givhmlss >= 1, givhmlss <= 4) |>
  count(year, givhmlss) |>
  group_by(year) |>
  summarise(people = sum(n))

write_csv(
  x = clean_homeless_positive_data,
  file = here::here("inputs/data/clean/homeless_positive_data.csv"),
)

#### Fetch and clean happiness data (where happy) ####
clean_happy_negative_data <- readr::read_csv(here::here("inputs/data/raw/GSS.csv"), show_col_types = FALSE) |>
  # Change column naming format
  clean_names() |> 
  select(year, happy) |>
  filter(happy == 3) |> 
  count(year, happy) |>
  group_by(year) |>
  summarise(people = sum(n))

write_csv(
  x = clean_happy_negative_data,
  file = here::here("inputs/data/clean/happy_negative_data.csv"),
)

#### Fetch and clean directions data (where happy) ####
clean_directions_negative_data <- readr::read_csv(here::here("inputs/data/raw/GSS.csv"), show_col_types = FALSE) |>
  # Change column naming format
  clean_names() |> 
  select(year, directns) |>
  filter(directns >= 5) |> 
  count(year, directns) |>
  group_by(year) |>
  summarise(people = sum(n))

write_csv(
  x = clean_directions_negative_data,
  file = here::here("inputs/data/clean/directions_negative_data.csv"),
)

#### Fetch and clean homeless data (where happy) ####
clean_homeless_negative_data <- readr::read_csv(here::here("inputs/data/raw/GSS.csv"), show_col_types = FALSE) |>
  # Change column naming format
  clean_names() |> 
  select(year, givhmlss) |>
  filter(givhmlss >= 5) |>
  count(year, givhmlss) |>
  group_by(year) |>
  summarise(people = sum(n))

write_csv(
  x = clean_homeless_negative_data,
  file = here::here("inputs/data/clean/homeless_negative_data.csv"),
)