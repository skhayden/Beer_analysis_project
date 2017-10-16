
# DDS Case Study 1

beers_df = read.csv("Beers.csv")

head(beers_df)
summary(beers_df)
str (beers_df)

breweries_df = read.csv("Breweries.csv")

head(breweries_df)
summary(breweries_df)
str (breweries_df)

# Clean Data, Make the column name Brewery_id same for both data set.


colnames(breweries_df)[which(names(breweries_df) == "Brew_ID")] <- "Brewery_ID"
colnames(breweries_df)[which(names(breweries_df) == "Name")] <- "Brewery_Name"

colnames(beers_df)[which(names(beers_df) == "Brewery_id")] <- "Brewery_ID"
colnames(beers_df)[which(names(beers_df) == "Name")] <- "Beer_Name"

# 1. How many breweries are present in each state?

#Load below packages
install.packages("sqldf")
install.packages("RSQLite")
install.packages("tcltk2")
library("sqldf")
library("RSQLite")
library("tcltk2")

sessionInfo()
#----------------

brew_count = (sqldf("SELECT count(Brewery_ID) as BreweriesCount, State FROM breweries_df GROUP By State"))
brew_count

head(brew_count)

#------Try Other ways----to get the count
install.packages("data.table")
library("data.table")

bdf = data.table(breweries_df)

bdf[ , .N, by = .( State) ]


#df$count <- unsplit(lapply(split(breweries_df, breweries_df[c("Brewery_ID")]), nrow), df[c("State")])
#df$count

#?colSums

#------Try Other ways----

# 2. Merge beer data with the breweries data. 
# Print the first 6 observations and the last six observations to check the merged file.

beer_brew_merge = merge(beers_df, breweries_df, by = c("Brewery_ID"), na.rm=TRUE)

head(beer_brew_merge)

tail(beer_brew_merge)

# 3. Report the number of NA's in each column.

colSums(is.na(beer_brew_merge))

# rowSums(is.na(beer_brew_merge)) # for no of NA's in each row

# 4. Compute the median alcohol content and international bitterness unit for each state. 
# Plot a bar chart to compare. 

ABV_IBU_Median = (sqldf("SELECT median(ABV) as ABV_Median,median(IBU) as IBU_Median, State FROM beer_brew_merge GROUP By State"))

head(ABV_IBU_Median)



barplot( ABV_IBU_Median$ABV_Median,col=c("darkblue"),space = 1,
     main="ABV Median vs State", # Title
     xlab="ABV Median" ,         # xaxis label 
     names.arg = ABV_IBU_Median$State) 

barplot( ABV_IBU_Median$IBU_Median,col=c("red"),space = 1,
         main="IBU Median vs State", # Title
         xlab="IBU Median",          # xaxis label 
         names.arg = ABV_IBU_Median$State)


# 5. Which state has the maximum alcoholic (ABV) beer? Which state has the most bitter (IBU) beer?


bbm = data.table(beer_brew_merge)

str(bbm)

# na.omit(bbm, cols = "ABV")

max_ABV <- max(bbm[, ABV],na.rm = TRUE)

max(bbm$ABV,na.rm = TRUE)

bbm[ABV == max_ABV,.(State,ABV)]

bbm[ABV == (max(bbm$ABV,na.rm = TRUE)),.(State,ABV)]



max_ibu = max(bbm[, IBU], na.rm = TRUE)

bbm[IBU == max_ibu, .(State, IBU)]



# 6. Summary statistics for the ABV variable

summary(beer_brew_merge$ABV, na.rm = TRUE)


# 7. Is there an apparent relationship between the bitterness of the beer and its alcoholic
# content? Draw a scatter plot.
# You are welcome to use the ggplot2 library for graphs. Please ignore missing values in
# your analysis. Make your best judgment of a relationship and EXPLAIN your answer.



#import data


# Data Frame -> Low = 1, Low-Medium = 2, Medium-High = 3, High = 4

df1 = data.frame(beer_brew_merge, na.rm = TRUE)

head(df1)

str(df1)

#Linear reg

regressor = lm(formula = IBU ~ ABV, data=df1 )
regressor

#predict
y_pred = predict(regressor, newdata = df1 )
y_pred

#ggplot
install.packages("ggplot2",dependencies = TRUE)
library(ggplot2)
#install.packages("gtable")
#library(gtable)
#install.packages("labeling")
#library(labeling)


ggplot() +
  geom_point(aes(x= df1$ABV, y= df1$IBU),
             colour='red', na.rm = TRUE,size = .75)+
  geom_line(aes(x= df1$ABV,y= predict(regressor, newdata = df1 )),
            colour='blue',na.rm = TRUE)+
  ggtitle('ABV vs IBU')+
  xlab('ABV')+
  ylab('IBU')

?ggplot

# Yes there is a linear correlation between alcholol content and the bitterness of the beer
# as the alcholol content increases and the bitterness of the beer also increases.

#----Done---


