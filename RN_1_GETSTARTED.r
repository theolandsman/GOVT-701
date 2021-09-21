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

# The space below this R script is called the "console". You can type code into the console, but it is harder to save from there
#   The wiser option is to always write your code into an R script like I am doing right now and to save the script
#   You can open a new R script by clicking the piece of paper icon right under File (select "script")

# R is "object-oriented," meaning that most things you do are stored as "objects"
#   Variables are objects, datasets that you upload are objects, etc.
#   Object names cannot begin with a number (e.g., variable names must start with a letter)

# We'll often use a "function" in R to specify what we want R to do to our R environment 
#   function()
# ... or more commonly, what we want R to do to an object in the environment
#   function(object)
# Sometimes we'll add arguments to the function to further specify what should be done to the object
#   function(object, argument_1, argument_2)
# Sometimes we'll name this new function as its own object to our environment
#   function_name <- function(object, argument_1, argument_2)


# ____________________________________________________________________

####
######
#######
########  LET'S GET STARTED WITH SOME BASICS...
#######
######
####

##
#### CALCULATOR FUNCTION
##

2+4+68-42 # we can do addition or subtraction

6/24 # or division

2*2 # or multiplication

36^2 # or exponents

pi # R knows pi, too!

(3+4/56)^3 # R can do order of operations (remember PEMDAS?)

options(digits=2) # we can specify the number of digits by starting with this line of code (FYI default is 7)
(3+4/56)^3 # and then running the calculation

options(digits=25) # Ah! Error. It's okay. What is the error telling us?
pi
options(digits=22)
pi

options(digits=7) # before we continue let's change the setting back to the default of 7

# ____________________________________________________________________

##
#### WORKING DIRECTORY
##

## Opening a project automatically sets your working directory to the project directory. 

# The "working directory" that you set becomes the default file path for all files that you want to read into R
#   Note that some people don't use the working directory option. Why?
#   Here's one argument against it: https://www.tidyverse.org/articles/2017/12/workflow-vs-script/ 
#   Basically, if your workflow involves pulling files from a bunch of different folders, it is a waste of time to 
#   set a working directory.
#   Or to put it differently if your file system is disorganized, you will waste a lot of time finding things and 
#   specifying correct filepaths regardless of whether you use a working directory or not. 

# If you don't use projects functionality, you can set the working directory manually. 
# Setting the working directory:
# Mac
setwd("/Users/theolandsman/Documents/GOVT_Math_Camp") # note that slashes need to be reversed on Windows
# Windows
setwd("C:\Users\TLandsman\Documents\Georgetown_Fall_2021\Math_Camp")
#   Now that I set my WD here, I will only have to write the specific file name when writing my code for importing
getwd() # this code will remind you which working directory you have set

# ____________________________________________________________________

##
#### PACKAGES
##

# "Base R" refers to R's default capabilities, which can be limiting
#   So, we install "packages" that allow us to do exciting things that aren't possible in base R 
#   Packages must be installed AND activated
#   We have to install a package once per installation of R
#   We have to activate a package each time we open a new session of R

# Installing and activating packages:
install.packages("foreign") # to install (only necessary once)
library("foreign") # to activate (necessary every session)
#Note: "foreign" is a package that allows R to read Stata files


# ____________________________________________________________________

##
#### IMPORTING DATA: CODE DEPENDS ON TYPE OF DATA FILE!
##

# I like to use the "Import Dataset" option in the Environment tab (top right)
# This way you don't have to remember the code for specific kinds of files
#   But remember to copy the code that R shows you into your script! 

#
## csv files (note that the option "From Text" under "Import Dataset" should work for most csv files)
#

# If you don't set a working directory, you'll have to write out the file path like this (example for a csv file):
install.packages("readr")
library(readr)
girlpower <- read_csv("/Users/theolandsman/Documents/GOVT_Math_Camp/WomenGov10.csv")



# If you did set a working directory, you'll only have to write the file name (example for a csv file):
library(readr)
girlpower <- read_csv("WomenGov10.csv") # see why some people like to set a working directory? :)
View(girlpower)

# ***note that the following examples assume that you have already loaded your working directory***

#
## Excel files (pay attention which "sheet" you want to import)
#

install.packages("readxl")
library(readxl)

# Importing an Excel file with only one sheet
ExampleExcel <- read_excel("ExampleExcel.xlsx")

# Importing one sheet from an Excel file with multiple sheets
congress116 <- read_excel("Congress116.xlsx", sheet = "House")

#
## Stata, SPSS, and SAS files
#

install.packages("haven")
library("haven")
# If you are having trouble installing "haven" you can try downloading "tidyverse" (big package that includes "haven")

# Stata files
ExampleStata <- read_dta("ExampleStata.dta")

# SAS files
ExampleSAS <- read_sas("ExampleSAS.sas7bdat") 

# SPSS files
ExampleSPSS <- read_sav("ExampleSPSS.sav") 

#
## .txt files
#

Exampletxt<-read.table("Exampletxt.txt", header = T) # header=T means that the first row of data is the variable names

#
## R files
#

load(file = "ExampleR.RData")


# If your import worked, you should see the new dataset under "Data" in the Environment tab (top right) 
# To clear the environment, use the code below:
rm(list=ls(all=TRUE))


# ____________________________________________________________________

##
#### UNDERSTANDING THE DATASET
##

# To see a list of all of the variable names in the data set (object) called "girlpower":
names(girlpower)

# To look at a spreadsheet version of your dataset (it will open in new tab):
View(girlpower) # note the capital V

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
