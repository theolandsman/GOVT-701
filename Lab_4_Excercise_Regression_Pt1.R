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

# ____________________________________________________________________

####
######
#######
########  ESTIMATING BIVARIATE OLS REGRESSIONS
#######
######
####

# ____________________________________________________________________

##
#### BASIC OLS REGRESSION CODE
##

## "Regress y on x"

# General command for OLS
regression1 <- lm(good_data$y ~ good_data$x) 
# An easier way to write the same thing:
regression1 <- lm(y ~ x, data=good_data) 

# View summary of regression results 
summary(regression1)


# We can also estimate a regression for a subset of the dataset
# To do this, we add conditions after the data object using the structure [row, column]
regression1 = lm(y ~ x, data=good_data[rowcondition , columncondition])
# For example, regressing women's representation on women's LFP for only western states would be
# regression1 = lm(pct_women_hs ~ pct_LFP_women, data=girlpower[west==1, ]
# Note that we only used a row condition and kept the comma but didn't add a column condition

##
#### BASIC OLS REGRESSION CODE: EXAMPLE
##

# Data from Mike Bailey's Real Stats, Chapter 5 Example Problem 3
library(readxl)
pres_vote <- read_excel("pres_vote.xlsx")
View(pres_vote) # viewing data

# Estimating relationship between number of cell phone subscriptions (in thousands)
# and number of traffic fatalities ("regressing traffic fatalities on cell phone usage")
model1 <- lm(Trump_2016 ~ rnormvote, data=pres_vote)
summary(model1)


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

# ____________________________________________________________________


## 
#### Another way to think about residuals and fits, lets look at the figures from the lecture slides. 
##
# Load the data
ev <- read_csv(file = "econ_vote.csv")


# Scatter plot

range(ev$elec_margin, na.rm = TRUE)
range(ev$gdp_growth, na.rm = TRUE)

# Plot X against Y
plot(ev$gdp_growth, ev$elec_margin, xlim = c(-3, 3), ylim = c(-25, 25))

# Regress X on Y, note that the notation has reversed, we now put Y first and X second. 
ev_fit <- lm(formula = elec_margin ~ gdp_growth, data = ev)

summary(ev_fit)
# Plot X against Y
plot(ev$gdp_growth, ev$elec_margin, xlim = c(-3, 3), ylim = c(-25, 25))

# Plot the regression line
abline(ev_fit)
## We can also make other kinds of lines, like a line at 0. 
abline(v = 0)


## Making the figure from the slides.

library(ggplot2)
ev_gg<-ev[-19,]
ev_gg$predicted <- predict(ev_fit)
ev_gg$residuals <- residuals(ev_fit) 
ggplot(ev_gg, aes(x = gdp_growth, y = elec_margin)) +
  geom_smooth(method = "lm", se = FALSE, color = "lightgrey") +  # Plot regression slope
  geom_segment(aes(xend = gdp_growth, yend = predicted), alpha = .2) + # Segments show residual distance
  geom_label(aes(x= gdp_growth, y=(predicted+elec_margin)/2, label = round(residuals,3)), size = 3)  + # Labels show residual value                                                                  # alpha to fade lines
  geom_point() + # Values  
  geom_point(aes(y = predicted), shape = 1) + # Fitted values
  theme_bw()  # Add theme for cleaner look

# We can take the residual values we plotted in this chart and square them, then add them up. 
# This is the value that OLS is minimizing. 
sum((ev_gg$residuals)^2)

## What if we used a different line? 

# In this example, we think that the change in incumbent party margin should be GDP growth *10 (from the same baseline as before)

ev_gg$predict2<- -.9292 + ev_gg$gdp_growth*10 

# In this example, we think that the change in incumbent party margin should be GDP growth *3

ev_gg$predict3<- -.9292 + ev_gg$gdp_growth*3

# The same figure with our first new line
ggplot(ev_gg, aes(x = gdp_growth, y = elec_margin)) +
  geom_abline(intercept = -.9292, slope = 10, color = "lightgrey") +  # Plot regression slope
  geom_segment(aes(xend = gdp_growth, yend = predict2), alpha = .2) +  # Segments show distance of values from fitted values, alpha fades lines
  geom_label(aes(x= gdp_growth, y=(predicted+elec_margin)/2, label = round(residuals,3)), size = 3)  + # Labels show residual value                                                                  # alpha to fade lines
  geom_point() +   # Values                                                    
  geom_point(aes(y = predict2), shape = 1) + # Fitted values
  theme_bw()  # Add theme for cleaner look

# Sum squared residuals on our new line, significantly larger.
sum((ev_gg$predict2-ev_gg$elec_margin)^2)

# The same figure with our second new line

ggplot(ev_gg, aes(x = gdp_growth, y = elec_margin)) +
  geom_abline(intercept = -.9292, slope = 3, color = "lightgrey") +  # Plot regression slope
  geom_segment(aes(xend = gdp_growth, yend = predict3), alpha = .2) +  # Segments show distance of values from fitted values 
  # Alpha to fade lines
  geom_label(aes(x= gdp_growth, y=(predicted+elec_margin)/2, label = round(residuals,3)), size = 3)  + # Labels show residual value              
  geom_point() +   # Values
  geom_point(aes(y = predict3), shape = 1) + # Fitted values
  theme_bw()  # Add theme for cleaner look

# Sum squared residuals on our second new line, better than the first but significantly larger than our OLS residuals

sum((ev_gg$predict3-ev_gg$elec_margin)^2)

## Exercises: 

# 1)
cellphones<- read_csv("cellphones_2012.csv")

# 2) Hypothesis: every 5 new cellphones in the state population causes 1 additional vehicle fatality. 
cellphones$predicted_deaths <- cellphones$cell_subscription/5

# 3) Testing our prediction against the actual data
sum((cellphones$predicted_deaths - cellphones$numberofdeaths)^2)

# 4) 

reg5 <- lm(cellphones$numberofdeaths ~ cellphones$cell_subscription)
summary(reg5)
## The data suggests that every additional cellphone causes a .1 increase in vehicle fatalities with a base value of 123, 
# ie for every 10 new cellphone subscriptions, 1 additional vehicle fatality happens. 
cellphones$residuals <- residuals(reg5)

sum(cellphones$residuals^2)

# Or to be more like 3)
cellphones$fitted_values <- predict(reg5)
sum((cellphones$fitted_values - cellphones$numberofdeaths)^2)
