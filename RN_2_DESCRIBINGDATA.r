####
######
#######
########  FIRST, SOME TIPS & HELPFUL NOTES...
#######
######
####

# Place a hashtag (or several!) before text to write yourself a note as I'm doing here
#   ALWAYS LEAVE YOURSELF NOTES! 

# Coding in R is case-sensitive!

# Run lines of code by holding down "ctrl" + "r" OR "ctrl" + "enter" on Windows; "cmd" + "return" on Mac
#   There is also a button up top that says "Run" and you can use that too :)

# ____________________________________________________________________

####
######
#######
########  LET'S DESCRIBE OUR DATA
#######
######
####

##
#### IMPORTING THE DATASET
##
#install.packages(readr) -- remember, only once/installation of R
library(readr)
girlpower <- read_csv("C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/WomenGov10.csv")

# ____________________________________________________________________

##
#### DESCRIBING THE DATASET
##

# To see a list of all of the variable names in the dataset (object) called "girlpower":
names(girlpower)

# To look at a spreadsheet version of your dataset (it will open in new tab):
View(girlpower) # note the capital V

# To make edits to your dataset manually (not recommended...)
fix(girlpower)

# To see a snapshot of your data:
head(girlpower) # shows you the first 6 rows

# Understanding check: what is our unit of observation in this dataset?

# To see dimensions of dataset:
dim(girlpower)

# To see number of rows:
nrow(girlpower)

# To see number of columns:
ncol(girlpower)

# Understanding check: How many variables does the dataset have? How many observations?

# ____________________________________________________________________

##
#### ACCESSING VARIABLES
##

# There are two approaches to calling up specific variables from your dataset:
#   1) Using "attach" function
#   2) Specifying location of object

# 1) The "attach" function seems easier, but can create problems when using multiple datasets
# See https://www.r-bloggers.com/to-attach-or-not-attach-that-is-the-question/
attach(girlpower)
summary(pct_women_hs)
detach(girlpower)

# 2) Rather than using "attach" function, it is usually better to specify object's location 
# To specify a variable within a dataset, use $
summary(girlpower$pct_women_hs)


# ____________________________________________________________________

##
#### DESCRIBING VARIABLES
##

# Checking variable types
class(girlpower$pct_women_hs) # example of numeric variable
class(girlpower$state) # example of character variable

#
## Describing numeric variables
#

summary(girlpower$pct_women_hs) # 5-number summary (min, 1st, median, 3rd, max)

sum(is.na(girlpower$pct_women_hs)) # counting number of missing values

mean(girlpower$pct_women_hs) # mean value

min(girlpower$pct_women_hs) # minimum value

max(girlpower$pct_women_hs) # maximum value

range(girlpower$pct_women_hs) # minimum and maximum

var(girlpower$pct_women_hs) # variance

sd(girlpower$pct_women_hs) # standard deviation
  sqrt(var(girlpower$pct_women_hs)) # (also standard deviation)

IQR(girlpower$pct_women_hs) # interquartile range (3rd-1st quartile)

  # Note that base R does not have a function for finding the mode
  # To do this easily, we can use the "modeest" package
install.packages("modeest") # installing modeest package once/R installation
library("modeest") # activating modeest package
mfv(girlpower$pct_women_hs) # mfv = "most frequent value"

#
## Other ways to describe variables
#

unique(girlpower$region) # lists unique values for a variable

length(unique(girlpower$region)) # counts number of unique values

table(girlpower$region) # frequency table for the number of observations for each value of region

table(girlpower$pct_women_hs) # not always useful for examining numeric variables!

# ____________________________________________________________________

##
#### DESCRIBING VARIABLES WITH FREQUENCY AND DESCRIPTIVE PLOTS
##

# may have to set dev.off() to put settings back to default

#
## Histograms
#
hist(girlpower$pct_women_hs)

hist(girlpower$pct_women_hs, breaks=20, col="blue") # changing number of bins and color
  # Note that R will not necessarily give you exactly the number of bins you specify

hist(girlpower$pct_women_hs, breaks=8, col="yellow",
     main="Histogram of Women's Representation in State Legislatures",
     xlab="Percent Women") # adding titles and axis labels


#
## Box and whisker plots
#
boxplot(girlpower$pct_women_hs)

boxplot(girlpower$pct_women_hs,
        main= "Percent State Legislative Seats Held by Women in 2010")

boxplot(pct_women_hs ~ region, data=girlpower, 
        main= "Percent Legislative Seats Held by Women in 2010",
        xlab= "Region", ylab="Percent")


# ____________________________________________________________________

###### Note: when closing R, it is generally better to NOT save the "workspace image" (i.e., the objects in the Environment)
###### Starting with a clean workspace each session makes it easier to keep track of your objects and prevent programming issues