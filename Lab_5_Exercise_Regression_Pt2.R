####
######
#######
########  FIRST, SOME TIPS & HELPFUL NOTES...
#######
######
####

# Place a hashtag (or several!) before text to write yourself a note as I'm doing here
#   ALWAYS LEAVE YOURSELF NOTES! Green text = notes = the way to remember what you did later...

# Coding in R is case-sensitive!

# Run lines of code by holding down "ctrl" + "r" OR "ctrl" + "enter" on Windows; "cmd" + "return" on Mac
#   There is also a button up top that says "Run" and you can use that too :)



##
#### BASIC OLS REGRESSION CODE: EXAMPLE
##

# Data from Mike Bailey's Real Stats, Chapter 5 Example Problem 3
library(readr)
cellphones <- read_csv("C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/cellphones_2012.csv")
View(cellphones) # viewing data
names(cellphones) # viewing names of columns (variables)

# Estimating relationship between number of cell phone subscriptions (in thousands)
# and number of traffic fatalities ("regressing traffic fatalities on cell phone usage")
model1 <- lm(numberofdeaths ~ cell_subscription, data=cellphones)
summary(model1)

options(scipen=999) # to remove scientific notation


# Reminder of where t statistic and p value are coming from
# T statistic is the coefficient divided by its standard error
tvalue <- 0.091145/0.006095
tvalue

# We can use the same [row, column] notation to do this calculation, too
tvalue <- summary(model1)$coefficients[2, 1] / summary(model1)$coefficients[2, 2]
tvalue

# Manually calculating p value for a 2-tailed test 
# (the negative absolute value ensures that we are looking at just the area to left of lower tail)
# pvalue <- 2*pt(-abs(tvalue), df)
pvalue <- 2*pt(-abs(14.95406), 48)
pvalue <- 2*pt(-abs(summary(model1)$coefficients[2, 3]), 48)
pvalue


# ____________________________________________________________________

####
######
#######
########  REGRESSION DIAGNOSTICS
#######
######
####

# ____________________________________________________________________

##
#### RESIDUAL VS PREDICTED PLOTS
##

# Fitted or predicted values are where a given x-value falls on the line of best fit
# Find values by substituting a given value of x into the regression equation
model1$fitted.values 

# Residuals are the difference between the observed data and the fitted values
# Positive values mean prediction was too low, negative values mean prediction was too high
model1$residuals

# We can use a plot of residuals versus predicted values to make sure that 
# i) a relationship seems linear (residuals shouldn't be far from line) and 
# ii) the residuals are homoscedastic (residuals should be spread evenly around line in a shapeless cloud) 
# iii) there aren't extreme outliers -- but better ways to do this are DFFITS, DFBETAS, Cook's, etc.

# Plot
yhat <- model1$fitted.values
e <- model1$residuals 
plot(e ~ yhat) # can add graphing elements like title, etc.!
abline(h=0,col="red") # points on the line were perfectly predicted by our model
# In this graph we see fluting, which indicates heteroscedasticity
# This means that the number of cell phone subscribers is a better predictor of
# traffic fatalities for states with fewer cell phone subscribers -- our predictions
# get worse as the number of cell subscribers in a state increases.

## What should you do if you have heteroscedasticity? Don't Panic! 
### There are easy ways to correct our regression to account for this. 
## Note that robust standard errors are even easier in STATA, so many 
## academics running complicated regressions will run them in STATA but plot them in R. 

# Estimating robust (heteroscedasticity-consistent) standard errors 
install.packages("AER") # -- remember, only once/installation of R
library("AER")
coeftest(regression1, vcov = vcovHC(regression1, type = "HC1"))

##
#### IDENTIFYING OUTLIERS
##

# DFBETAS: shows effect of deleting each observation on regression coefficients
# Common cut-off for DFBETAS is 1, or 2/sqrt(n) for large datasets
dfb_model1 <- dfbetas(model1) # make a new object for the DFBETAS values
dfb_model1
summary(dfb_model1) # view summary of DFBETAS values
plot(dfb_model1) # plot the DFBETAS values
abline(h = c(1, -1), col="red") # add reference lines to identify outliers

# To identify the row observations that cross the DFBETAS cut-off
# I make a new object comprised of Boolean (true/false) values
outliers_dfb <- dfb_model1[,'cell_subscription'] > 1 | dfb_model1[,'cell_subscription'] < (-1) 
# Better yet, we can use the "which" function to draw out those that are "true"
outliers_dfb <- which(dfb_model1[,'cell_subscription'] > 1 | dfb_model1[,'cell_subscription'] < (-1))
outliers_dfb # looking at outlier data rows
cellphones$state[5] # identify state name by row number
cellphones$state[32] 
cellphones$state[43] 


# DFFITS: shows effect of deleting each observation on fitted values
# Common cut-off for DFFITS is 1, or 2/sqrt(k+1/n) for large datasets
df_model1 <- dffits(model1) # make a new object for the DFFITS values
df_model1
summary(df_model1) # view summary of DFFITS values
plot(df_model1) # plot the DFFITS values
abline(h = c(1, -1), col="red") # add reference lines to identify outliers

# To identify the row observations that cross the DFFITS cut-off
# I make a new object that is a subset of data based on DFFITS values that cross threshold
outliers_df <- subset(cellphones, df_model1 > 1 | df_model1 < (-1))
View(outliers_df) # viewing new subset of outliers


# Cook's Distance: shows effect of deleting each observation on fitted values 
# Common cut-off for Cook's Distance is 4/n
cook_model1 <- cooks.distance(model1) # make a new object for the Cook's values
cook_model1
nobs(model1) # to find number of observations
4/50
summary(cook_model1) # view summary of Cook's values
plot(cook_model1) # plot the Cook's values
abline(h = 4/50, col="red") # add reference lines to identify outliers

# To identify the row observations that cross the Cook's cut-off
# I make a new object that is a subset of data based on Cook's values that cross threshold
outliers<-subset(cellphones, cook_model1 > (4/50)) 
View(outliers) # viewing new subset of outliers

# ____________________________________________________________________


####
######
#######
########  ESTIMATING MULTIVARIATE OLS REGRESSIONS
#######
######
####

##
#### MULTIVARIATE OLS REGRESSION CODE
##

## "Regress y on x, controlling for z"

# General command for multivariate OLS
regression2 <- lm(good_data$y ~ good_data$x + good_data$control) 
# An easier way to write the same thing:
regression2 <- lm(y ~ x + control, data=good_data)

# To see summary of results: 
summary(regression2)

# ____________________________________________________________________


##
#### MULTIVARIATE OLS REGRESSION CODE: EXAMPLES
##

# Estimating relationship between cell phone use and traffic fatalities
model1 <- lm(numberofdeaths ~ cell_subscription, data=cellphones)
summary(model1)

# Controlling for state population
model2 <- lm(numberofdeaths ~ cell_subscription + population, data=cellphones)
summary(model2)

# Controlling for state population and miles driven within the state annually (in millions of miles)
model3 <- lm(numberofdeaths ~ cell_subscription + population + total_miles_driven, data=cellphones)
summary(model3)

# ____________________________________________________________________

####
######
#######
########  PRESENTING REGRESSION OUTPUT
#######
######
####

# ____________________________________________________________________

##
#### Regression Tables
##

# Two common packages for exporting regression summaries into Latex are "texreg" or "stargazer"
# If you already use Latex, great! If not, you can still copy the code that these packages produce
# into an Overleaf template (https://www.overleaf.com/) and then download the resultant pdf.
# It is also possible to export a regression summary into Word using functions from "huxtable" package.

# Using texreg package: https://cran.r-project.org/web/packages/texreg/texreg.pdf 
install.packages("texreg")
library("texreg")
texreg(list(model1, model2, model3), stars = c(0.01, 0.05, 0.1), 
       caption = "Regression Results", digits = 2)

# Using stargazer package: https://cran.r-project.org/web/packages/stargazer/vignettes/stargazer.pdf 
install.packages("stargazer")
library("stargazer")
stargazer(model1, model2, model3, title="Regression Results", digits = 2)

# Using huxtable package: https://cran.r-project.org/web/packages/huxtable/vignettes/huxtable.html
install.packages("huxtable") # need this package to use jtools package for exporting to Word
library("huxtable") 
regressiontables <- huxreg(model1, model2, model3) # start with huxreg function, then use quick_docx function
quick_docx(regressiontables, file = "C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/testoutput.docx")

# ____________________________________________________________________


##
#### Coefficient plots (often better for presentations)
##

# Two common packages for exporting coefficient plots are "jtools" and "coefplot"
# Both packages have zillions of options for customizing titles, colors, and formatting.
# Excellent resource: https://cran.r-project.org/web/packages/jtools/vignettes/summ.html

# Using plot_summs function from jtools package: https://rdrr.io/cran/jtools/man/plot_summs.html 
install.packages("jtools")
library("jtools")
install.packages("ggstance") # need in order to use plot_summs function
library("ggstance")
install.packages("broom.mixed") # need in order to use plot_summs function
library("broom.mixed")
plot_summs(model1) # plotting coefficients from one regression model
plot_summs(model1, model2, model3) # plotting coefficients from multiple models


# Using coefplot package: https://cran.r-project.org/web/packages/coefplot/coefplot.pdf 
install.packages("coefplot")
library("coefplot")
coefplot(model1, intercept=FALSE) # plotting coefficients from one regression model
multiplot(model1, model2, model3, intercept=FALSE) # plotting coefficients from multiple models

