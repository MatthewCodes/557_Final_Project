

# Libraries load
library(tidyverse)

# Data load
dataraw <- read_csv('../Data/multipleChoiceResponses.csv')
convRates <- read_csv('../Data/conversionRates.csv')
convRates <- convRates[,2:3]
names(convRates) <- c("CompensationCurrency", "ExchangeRate(USA)")


# columns to focus on for out project
variables.to.focus <- c("GenderSelect", "Country", "Age", "EmploymentStatus",
                        "StudentStatus", "LearningDataScience", "CodeWriter",
                        "CareerSwitcher", "CurrentJobTitleSelect", "TitleFit",
                        "CurrentEmployerType","DataScienceIdentitySelect", 
                        "FormalEducation", "MajorSelect", "Tenure", "LanguageRecommendationSelect", 
                        "CompensationAmount", "CompensationCurrency")

# new DF for the raw data with chosen variables
DS_dataset <- dataraw[,variables.to.focus]
DS_dataset <- DS_dataset[order(DS_dataset$CompensationCurrency,DS_dataset$Country),]

# merging dfs, adding the compensation rate 
DS_merged <- merge(x=DS_dataset,y=convRates, by.x = "CompensationCurrency", all.x = T)
DS_merged <- DS_merged[order(DS_merged$CompensationCurrency, DS_merged$Country),]


# converting compensation to USD
DS_compensation <- DS_merged[,]
DS_compensation$CompensationYearUSD <- DS_compensation$CompensationAmount*DS_compensation$`ExchangeRate(USA)`

# Load working DF to csv
write.csv(DS_compensation, "../Data/DataScienceData.csv")