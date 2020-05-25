# Initiate all required libraries for the code.
library(dplyr)
library(readr)
library(ggplot2)
library(RCurl)
library(writexl)
# Note: You have to have readr, writexl, RCurl, dplyr and ggplot2 packages
# installed for this code to work. I am using R version 3.6.2.

# Read the .csv file for COVID-19 data issued by the EU.
# This data will refresh every time this script is run.

# Note: This line of code was taken from the EU open data site.
data <- read_csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv")

# Export a graph (US cases over last month)
pdf("US_cases_last_month.pdf") 
data %>% 
  filter(countriesAndTerritories == "United_States_of_America" & month == first(month)) %>%
  ggplot(aes(day, cases, label=cases)) +
  geom_label() +
  geom_line()
dev.off()

# Export a graph (Indian cases over last month)
pdf("India_cases_last_month.pdf") 
data %>% 
  filter(countriesAndTerritories == "India" & month == first(month)) %>%
  ggplot(aes(day, cases, label=cases)) +
  geom_label() +
  geom_line()
dev.off()


# Export a graph (UK cases over last month)
pdf("UK_cases_last_month.pdf") 
data %>% 
  filter(countriesAndTerritories == "United_Kingdom" & month == first(month)) %>%
  ggplot(aes(day, cases, label=cases)) +
  geom_label() +
  geom_line()
dev.off()

# Export a graph (Cases over last month across Oceania)
pdf("Oceania_countries_cases_last_month.pdf") 
data %>% 
  filter(continentExp == "Oceania" & month == first(month)) %>%
  ggplot(aes(day, cases, color=countriesAndTerritories, line=countriesAndTerritories)) +
  geom_point() +
  geom_line()
dev.off()

# Export a graph (US deaths over last month)
pdf("US_deaths_last_month.pdf") 
data %>% 
  filter(countriesAndTerritories == "United_States_of_America" & month == first(month)) %>%
  ggplot(aes(day, deaths, label=deaths)) +
  geom_label() +
  geom_line()
dev.off()

# Export a graph (India deaths over last month)
pdf("India_deaths_last_month.pdf") 
data %>% 
  filter(countriesAndTerritories == "India" & month == first(month)) %>%
  ggplot(aes(day, deaths, label=deaths)) +
  geom_label() +
  geom_line()
dev.off()

# Export a graph (UK deaths over last month)
pdf("UK_deaths_last_month.pdf") 
data %>% 
  filter(countriesAndTerritories == "United_Kingdom" & month == first(month)) %>%
  ggplot(aes(day, deaths, label=deaths)) +
  geom_label() +
  geom_line()
dev.off()

# Export a graph (Cases over last month in US, UK, Italy and India)
mycountries <- c("United_States_of_America", "United_Kingdom", "India", "Italy")
pdf("UKUSINIT_cases_last_month.pdf") 
data %>% 
  filter(countriesAndTerritories%in%mycountries & month == first(month)) %>%
  ggplot(aes(day, cases, label=cases, color=countriesAndTerritories)) +
  geom_label() +
  geom_line()
dev.off()

# Export a graph (Deaths over last month in US, UK, Italy and India)
mycountries <- c("United_States_of_America", "United_Kingdom", "India", "Italy")
pdf("UKUSINIT_deaths_last_month.pdf") 
data %>% 
  filter(countriesAndTerritories%in%mycountries & month == first(month)) %>%
  ggplot(aes(day, deaths, label=deaths, color=countriesAndTerritories)) +
  geom_label() +
  geom_line()
dev.off()

# Get Top 10 countries with highest latest death rate
Top_10_death_rate <- data %>% 
  filter(month == first(month) & day == first(day)) %>%
  mutate(death_rate = deaths/cases) %>%
  arrange(desc(death_rate)) %>%
  head(10)
write_xlsx(Top_10_death_rate_per_10000,"C:\\Users\\lenovo\\Desktop\\Top10DeathRate.xlsx")

# Get Top 10 countries with highest latest case rate per 10000
Top_10_case_rate_per_10000 <- data %>% 
  filter(month == first(month) & day == first(day)) %>%
  mutate(case_rate = cases/popData2018 * 10000) %>%
  arrange(desc(case_rate)) %>%
  head(10)
write_xlsx(Top_10_case_rate_per_10000,"C:\\Users\\lenovo\\Desktop\\Top10CaseRatePer10000.xlsx")
