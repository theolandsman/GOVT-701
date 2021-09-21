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
########  LET'S CREATE NEW OBJECTS
#######
######
####

# R is an object-oriented programming language, meaning 
# everything in the R environment is an object 
# An "object" is some kind of data element or structure

##
#### CREATING SIMPLE OBJECTS: SCALARS (single value objects)
##

x <- 5 #creating object "x" with value of 5
y <- 3 #creating object "y" with value of 3

x #tells us value of x is 5
y #tells us value of y is 3


##
#### CREATING VECTORS (objects that are sequences of values)
##

a <- c(2, 4, 6, 8) #use c to combine values into vector
b <- c("cat", "dog", "bird", "fish") #creating a character vector
c <- rnorm(15) #vector of random selection of 15 numbers 
# R generates from a standard normal distribution (mean=0, sd=1)
d <- rnorm(100, mean=5, sd=2) #vector of random selection of
# 100 numbers from standard distribution with mean=5, sd=2

hist(d)
summary(d)
sd(d)


##
#### CREATING DATA FRAMES (objects that are two dimensional)
##

newdata <- data.frame(a,b)
newdata

# Note that there are other kinds of object too (matrix, list)

# ____________________________________________________________________


####
######
#######
########  LET'S APPLY THESE CONCEPTS TO OUR GIRLPOWER DATASET
#######
######
####

##
#### IMPORTING THE DATASET
##
#install.packages(readr) -- remember, only once/installation of R
library(readr)
girlpower <- read_csv("C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/WomenGov10.csv")
View(girlpower)

girlpower <- as.data.frame(girlpower) 
# Sometimes R produces strange errors when your script creates variables
# but you haven't run those lines of code yet. They don't stop you from doing
# anything but are annoying. This line of code usually fixes the issue for me.

# ____________________________________________________________________

##
#### HELPFUL SYNTAX FOR SPECIFYING CONDITIONS
##

#use brackets to specify condition/s
girlpower$state[girlpower$south==1] #note the double ==

girlpower$state[girlpower$pct_women_hs<15] 

# multiple conditions can be specified with | (or) or & (and)

# ____________________________________________________________________

##
#### CREATING SIMPLE OBJECTS
##

cov <- cov(girlpower$pct_LFP_women, girlpower$pct_women_hs)
cov # >0 (positive), <0 (negative)

cor <- cor(girlpower$pct_LFP_women, girlpower$pct_women_hs)
cor # -1 (strong neg cor) to 1 (strong pos cor) 

maxpop <- girlpower$state[girlpower$pop==max(girlpower$pop)]
maxpop

girlpower$maxpop <- girlpower$state[girlpower$pop==max(girlpower$pop)]
girlpower$maxpop #by using $ we are creating "maxpop" within the girlpower object

# ____________________________________________________________________

##
#### CREATING NEW VARIABLES
##

# Creating new variable by transforming existing variable...
  #e.g., for percent of house seats held by Democrats
girlpower$pct_dem_hs <- (girlpower$num_dem_hs/girlpower$num_total_hs)*100
summary(girlpower$pct_dem_hs) #always make sure it worked!

  #e.g., for women's labor force participation squared
girlpower$pct_LFP_women_sq <- girlpower$pct_LFP_women^2
summary(girlpower$pct_LFP_women_sq) 


# Creating new categorical variable...
  #e.g., a new region id variable with values from 1-4
girlpower$regionid <- NA #start by filling new vector with NAs
girlpower$regionid[girlpower$northeast==1] <- 1 #note the double ==
girlpower$regionid[girlpower$midwest==1] <- 2
girlpower$regionid[girlpower$west==1] <- 3
girlpower$regionid[girlpower$south==1] <- 4
table(girlpower$regionid, useNA = "always") #make sure NAs are gone!


# Creating new binary variables...
  #e.g., for whether state has percent women representatives that is above average
girlpower$highwomen <- NA #start by filling new vector with NAs
girlpower$highwomen[girlpower$pct_women_hs < median(girlpower$pct_women_hs)] <- 0
girlpower$highwomen[girlpower$pct_women_hs >= median(girlpower$pct_women_hs)] <- 1
table(girlpower$highwomen, useNA = "always") 

  #e.g., for a region variable (this is already in the dataset!)
girlpower$west <- NA
girlpower$west[girlpower$regionid==3] <- 1
girlpower$west[girlpower$regionid==1 |  #note the | (symbol for "or")
               girlpower$regionid==2 | 
               girlpower$regionid==4] <- 0
table(girlpower$west)

  #e.g., also for a region variable but using "ifelse" function
girlpower$south <- ifelse(girlpower$regionid == 4,1,0) #(when regionid is 4, value is 1 (and 0 if regionid is not 4))
table(girlpower$south)


# ____________________________________________________________________


####
######
#######
########  PRACTICE EXERCISE
#######
######
####

# Note that there may be different code that works!


# 1) One could look at the summary data first
summary(girlpower$pct_women_hs) #then plug min into next line
girlpower$state[girlpower$pct_women_hs==11.88] #Oklahoma

# Possible, but more complicated, to use one line of code
girlpower$state[girlpower$pct_women_hs==min(girlpower$pct_women_hs)]


# 2) One could start with a summary of variable for the south
summary(girlpower$pct_women_hs[girlpower$south==1]) #then plug value into next line
girlpower$state[girlpower$pct_women_hs==34.75] #Maryland

# Possible, but much more complicated, to use one line of code
girlpower$state[girlpower$pct_women_hs==max(girlpower$pct_women_hs[girlpower$south==1])]


# 3)
girlpower$pct_rep_hs <- (girlpower$num_rep_hs/girlpower$num_total_hs)*100
summary(girlpower$pct_rep_hs) #mean = 52.86 percent


# 4)
cor <- cor(girlpower$pct_rep_hs, girlpower$pct_women_hs)
cor # negative correlation 


# 5)
girlpower$highevan <- NA
girlpower$highevan[girlpower$pct_evan<((1/3)*100)] <- 0
girlpower$highevan[girlpower$pct_evan>=((1/3)*100)] <- 1

table(girlpower$highevan) # 8 states

girlpower$state[girlpower$highevan==1] #ID, UT, MS, AR, KY, AL, TN, OK

# ____________________________________________________________________


###### Note: when closing R, it is generally better to NOT save the "workspace image" (i.e., the objects in the Environment)
###### Starting with a clean workspace each session makes it easier to keep track of your objects and prevent programming issues