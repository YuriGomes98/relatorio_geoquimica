install.packages("reshape2")

library(tidyverse)
library(ggplot2)
library(leaflet)
library(here)
library(countrycode)
library(reshape2)
library(scales)

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

boxplot_df <- cmmi_americas |>
  select(country, cu_ppm)

melted_boxplot_df <- melt(boxplot_df) 

melted_boxplot_df <- melt(boxplot_df) 

ggplot(melted_boxplot_df, aes(x = country, y = value)) + 
  geom_boxplot(fill = "navyblue", color = "white", outlier.shape = NA) +
  theme(axis.text.x=element_text(angle=0,hjust=1, face="bold", color = "black"), 
        axis.text.y=element_text(face="bold", color = "black"))+ 
  theme_gray() +
  labs(title="Copper Grade Distribution per Country", x = "", y = "Copper (in ppm) - log10 scale")+
  stat_boxplot(geom='errorbar') + 
  scale_y_continuous(trans='log10', labels = comma)
