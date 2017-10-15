#title: "BeerResearch"
#author: "Steven Hayden, Thejas Prasad"
#date: "October 8, 2017"

#Sets the working directory so data can be gathered 
#Imports the Beers file and the Breweries file and merges them together.

setwd("~/GitHub/SMU/Doing_Data_Science_1/CaseStudy/Beer analysis project")

# DDS Case Study 1
#imports data and set the tables to an object
beers_df = read.csv("analysis/Data/Beers.csv")
breweries_df = read.csv("analysis/Data/Breweries.csv")

# Clean Data, Make the column name Brewery_id same for both data set.

colnames(breweries_df)[which(names(breweries_df) == "Brew_ID")] <- "Brewery_ID"
colnames(breweries_df)[which(names(breweries_df) == "Name")] <- "Brewery_Name"

colnames(beers_df)[which(names(beers_df) == "Brewery_id")] <- "Brewery_ID"
colnames(beers_df)[which(names(beers_df) == "Name")] <- "Beer_Name"

# 2. Merge beer data with the breweries data. 



beer_brew_merge = merge(beers_df, breweries_df, by = c("Brewery_ID"))
tail(beer_brew_merge)



#Print the first 6 observations and the last 6 observations to check the merged file.


head(beer_brew_merge)

tail(beer_brew_merge)

