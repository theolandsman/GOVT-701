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


##
#### CREATING DATA FRAMES (objects that are two dimensional)
##

newdata <- data.frame(a,b)
newdata

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
# Read .csv file
# Obtain the csv file from: `HS117_members.csv` at  https://voteview.com/data

voteview <- read_csv("HS117_members.csv")

# obtain the tab file from `IdealpointestimatesAll_Mar2021.tab` at 
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=hdl:1902.1/12379

# Read tab file
UNideal <- read_delim("IdealpointestimatesAll_Mar2021.tab")

# ____________________________________________________________________

##
#### DESCRIBING THE DATASET
##

# To see a list of all of the variable names in the dataset (object) called "voteview":
names(voteview)

# To look at a spreadsheet version of your dataset (it will open in new tab):
View(voteview) # note the capital V

# To make edits to your dataset manually (not recommended...)
# fix(voteview)

# To see a snapshot of your data:
head(UNideal) # shows you the first 6 rows

# Understanding check: what is our unit of observation in this dataset?

# To see dimensions of dataset:
dim(UNideal)

# To see number of rows:
nrow(UNideal)

# To see number of columns:
ncol(UNideal)

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
attach(voteview)
summary(nominate_dim1)
detach(voteview)

# 2) Rather than using "attach" function, it is usually better to specify object's location 
# To specify a variable within a dataset, use $
summary(voteview$nominate_dim1)


# ____________________________________________________________________

##
#### DESCRIBING VARIABLES
##

# Checking variable types
class(UNideal$session) # example of numeric variable
class(UNideal$Countryname) # example of character variable

#
## Describing numeric variables
#
# First, I'm going to get rid of some annoying data so that I don't have to include `na.rm = TRUE` in every line

voteview <- voteview[-1,]

# Understanding check: Math camp folks, what is this doing?

## Getting into the data
summary(voteview$nominate_dim1) # 5-number summary (min, 1st, median, 3rd, max)

sum(is.na(voteview$nominate_dim1)) # counting number of missing values

mean(voteview$nominate_dim1) # mean value

min(voteview$nominate_dim1) # minimum value

max(voteview$nominate_dim1) # maximum value

range(voteview$nominate_dim1) # minimum and maximum

var(voteview$nominate_dim1) # variance

sd(voteview$nominate_dim1) # standard deviation
  sqrt(var(voteview$nominate_dim1)) # (also standard deviation)

IQR(voteview$nominate_dim1) # interquartile range (3rd-1st quartile)

  # Note that base R does not have a function for finding the mode
  # To do this easily, we can use the "modeest" package
install.packages("modeest") # installing modeest package once/R installation
library("modeest") # activating modeest package
mfv(voteview$nominate_dim1) # mfv = "most frequent value"

#
## Other ways to describe variables
#

unique(voteview$state_abbrev) # lists unique values for a variable

length(unique(voteview$state_abbrev)) # counts number of unique values

table(voteview$state_abbrev) # frequency table for the number of observations for each value of region

table(voteview$nominate_dim1) # not always useful for examining numeric variables!

# ____________________________________________________________________

#### Exercise 1
## Create a small dataset for something in your life, 
## think `family` where each row is a person, their relationship to you, and their age,
## or `food` where each item is a food item you need to pickup, its price, and what meal you plan to eat it for. 

vector1 <- c()
vector2 <- c()
vector3 <- c()

mydata <- data.frame(vector1, vector2, vector3)

#### Exercise 2
## Compute the mean and the standard deviation of `nominate_dim2` variable to the mean and standard deviation for `nominate_dim2`
## Find the mean and standard deviation of `nominate_dim2` for only House members and for only Senate members. 

# ____________________________________________________________________

###### Note: when closing R, save your RProject file so that you can return to your datasets with all of your
###### relevant code loaded. If you are not using an RProject, it is generally better to NOT save the "workspace image"
###### (i.e., the objects in the Environment) Starting with a clean workspace each session makes it easier to keep track 
###### of your objects and prevent programming issues. Be intentional about the project space you are working in!