
#title: "Beer_Brew_ analysis"
#author: "Steven Hayden, Thejas Prasad"
#date: "October 10, 2017"


#install.packages("sqldf")
library("sqldf")

#install.packages("data.table")
library("data.table")


#Report the number of NA's in each column.

colSums(is.na(beer_brew_merge))


#Compute the median alcohol content and international bitterness unit for each state. 
#Uses SQL to group data by state (like the tapply functtion) and provied the Median ABV and Median IBU

ABV_IBU_Median = (sqldf("SELECT median(ABV) as ABV_Median,median(IBU) as IBU_Median, State FROM beer_brew_merge GROUP By State"))



#Finds the max ABV and the state Associated with it using Data Table.
#beer_brew_merge[which(beer_brew_merge$ABV==max(beer_brew_merge$ABV,na.rm = TRUE)),"State"]

bbm = data.table(beer_brew_merge)
bbm[ABV == (max(bbm$ABV,na.rm = TRUE)),.(State,ABV)]

#state has the most bitter (IBU) beer


max_ibu = max(bbm[, IBU], na.rm = TRUE)
bbm[IBU == max_ibu, .(State, IBU)]


#Summary statistics for the ABV variable

summary(beer_brew_merge$ABV, na.rm = TRUE)


# Relationship between bitterness and alcohol
# Validate if there is an apparent relationship between the bitterness of the beer and its alcoholic
# content.

#Assign beer_brew_merge data frame to df1 data frame.
df1 = data.frame(beer_brew_merge, na.rm = TRUE)

#Linear reg - Creates a regressor.

regressor = lm(formula = IBU ~ ABV, data=df1 )

#Creates a predictor vriable.
y_pred = predict(regressor, newdata = df1 )

# Based on the above variables plots will be generated in the Presentation file.

# End of File