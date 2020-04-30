#new coronavirus map, county level

library(tidyverse)
library(janitor)
library(dplyr)
library(readxl)
library(readr)

temp1 <- read_csv("~/GitHub/COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv")
cases <- temp1 %>%
  select(1:11, ncol(temp1)) 
names(cases)[12] <- "cases"

temp2 <- read_csv("~/GitHub/COVID-19/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv") 
deaths <- temp2 %>%
  select(1:12, ncol(temp2)) 
names(deaths)[13] <- "deaths"

merged_data <- left_join(cases, deaths)
merged_data$deaths[is.na(merged_data$deaths)] <- 0

#create column that says whether a death has occured or not for mapping
merged_data$color <- ifelse(merged_data$deaths >0, "deaths", "no deaths")

merged_data$Long_ <- as.numeric(merged_data$Long_)

merged_data <- merged_data %>% 
  rename(long = Long_)

write.csv(merged_data, "~/GitHub/cns/coronavirus-map/coronavirus-clean.csv")

############### NYT data
#fips_codes <- read_csv("~/GitHub/covid-19-data/us-counties.csv") %>%
  #filter(date == Sys.Date() - 1)
  #group_by(county) %>%
  #slice(which.max(as.Date(date, '%Y-%m-%d')))%>%
  #rename("county_fips" = "fips")

#Add Kansas City, Missouri fips, which is NA in original
#fips_codes[1158,4] = '29380'
#Add NYC fips, which is NA in original
#fips_codes[1331,4] = '36061'

#print(sum(fips_codes$cases))
#fips_codes_md <- fips_codes %>%
#  filter(state=='Maryland')
#print(sum(fips_codes_md$cases))
#print(sum(fips_codes_md$deaths))

#zip_codes <- read_excel("~/GitHub/Random/coronavirus-map/ZIP_COUNTY_122019.xlsx") %>%
#  clean_names() %>%
#  rename("county_fips" = "county") %>%
#  select(,1:2) %>%
#  distinct(county_fips, .keep_all = TRUE)

#merged_data <- left_join(fips_codes, zip_codes, by="county_fips") 

#create column with country because carto wants that
#merged_data['country'] = 'USA'

#create column that says whether a death has occured or not for mapping
#merged_data$color <- ifelse(merged_data$deaths >0, "deaths", "no deaths")
  
#write.csv(merged_data, paste0("~/GitHub/Random/coronavirus-map/coronavirus-clean.csv"))
