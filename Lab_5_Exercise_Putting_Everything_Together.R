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
cellphones <- read_csv("cellphones_2012.csv")
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

