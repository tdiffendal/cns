# DC Gent map
#Merge gent data and geojson data

library(janitor)
library(readxl)
library("xlsx")
library(readr)
library(tidyverse)
library(dplyr)
library(plyr)

setwd("~/GitHub/cns/dc-map")

gent <- read_excel("dc_gent.xlsx")
camps <- read.csv("geolocated_clearances.csv")
geom <- read.csv("")

gent$bins2 <- cut(gent$StrongExpansionDecline, breaks=c(-1400, -1000, -500, -1, 1, 500, 1000, 1900), labels=c("Extreme Gentrification", "Gentrification", "Little Gentrification", "No Gentrification", "Little Decline", "Decline", "Extreme Decline"))

temp <- camps %>%
  select(location) %>%
  count()

count(camps, "coordinates")

write.xlsx(gent, "dc_gent_bins.xlsx")