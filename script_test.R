library(tidyverse)
library(ggplot2)
library(leaflet)
library(here)
library(countrycode)

cmmi_dataset <-
  readr::read_csv(
    here::here("projeto_report_geoquimica/CriticalMineralDepositsGeochemistry.csv")) |> 
  janitor::clean_names()

cmmi_south_america <- cmmi_dataset |>
  dplyr::filter(cmmi_dataset$country %in% c("BRA", "ARG", "CHL", "BOL", "PER", "URY", "ECU", "VEN", "COL"))
