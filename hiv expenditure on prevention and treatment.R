library(jsonlite)

# Fetch the data
df <- read.csv("https://ourworldindata.org/grapher/hiv-expenditure.csv?v=1&csvType=full&useColumnShortNames=true")

# Fetch the metadata
metadata <- fromJSON("https://ourworldindata.org/grapher/hiv-expenditure.metadata.json?v=1&csvType=full&useColumnShortNames=true")

#check the data structure

str(df)
head(df)
summary(df)

# Check columns
colnames(df)

#inspect the dataset
metadata$title
metadata$description
names(metadata$variables)
metadata$variables[[1]]

#clean the dataset for power Bi
library(dplyr)
clean_df <- df %>%
  rename(
    country = Entity,
    iso = Code,
    year = Year,
    hiv_expenditure = domestic_spending_fund_source__group_total
  ) %>%
  filter(!is.na(hiv_expenditure)) %>%
  arrange(country, year)

#Check the cleaned result
head(clean_df)
summary(clean_df$hiv_expenditure)

#Export for Power BI
write.csv(clean_df, "clean_hiv_expenditure.csv", row.names = FALSE)

