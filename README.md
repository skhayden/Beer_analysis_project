# Beer_analysis

The purpose of this get hub repository is to understand the current characteristics
of beers and their brewers across the United States. The repository is structured with two main directories, 
the analysis folder and the presentation folder. The data used for this analysis is stored in the
analyses directory in the data folder.  Below are the definitions of the variables used and a 
description of the data collected. 


Beers.csv:
Name: Name of the beer.
Beer ID: Unique identifier of the beer.
ABV: Alcohol by volume of the beer.
IBU: International Bitterness Units of the beer.
Brewery ID: Brewery id associated with the beer.
Style: Style of the beer.
Ounces: Ounces of beer.

Breweries.csv:
Brew ID: Unique identifier of the brewery.
Name: Name of the brewery.
City: City where the brewery is located.
State: U.S. State where the brewery is located.
Variable definition 
beers_df: Data frame to store the characteristics of beer across the U.S.
breweries_df: Data frame to store the brewery logistics across the U.S.
beer_brew_merge: Data frame with brewery logistics and beer characteristics merge together. 
ABV_IBU_Median: Data frame stores the Median ABV and IBU by State.
Bbm: beer_brew_merge variable stored in a data table.
max_ibu: The Max IBU in the data set
df1: beer_brew_merge with all NA removed
regressor: coefficient and intercept for the regression model 
y_pred: Stores predicted values from the regression model




Packages 
"sqldf": Adapts SQL language  into R
data.table: Allows stored of large data sets more efficiently 


