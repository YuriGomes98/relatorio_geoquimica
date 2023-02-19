library(tidyverse)
library(ggplot2)
library(leaflet)
library(here)
library(countrycode)

cmmi_dataset <-
  readr::read_csv(
    here::here("projeto_report_geoquimica/CriticalMineralDepositsGeochemistry.csv")) |> 
  janitor::clean_names()

cmmi_americas <- cmmi_dataset |>
  dplyr::filter(country %in% c("MEX", "USA", "CAN", "BRA", "ARG", "CHL", "BOL", "PER", "URY", "ECU", "VEN", "COL")) |>
  dplyr::select(sample_name, primary_commodities, deposit_name, deposit_environment, country, 
                state, cu_ppm, cu_detection_limit, cu_method, 
                deposit_longitude_wgs84,deposit_latitude_wgs84)|>
  drop_na(cu_ppm)|>
  dplyr::filter(cu_ppm >= 50) |>
  mutate(country = countrycode(country, "iso3c", "country.name")) 