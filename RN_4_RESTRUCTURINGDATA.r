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
########  LET'S MAKE NEW DATASETS
#######
######
####

##
#### IMPORTING DATASET
##
#install.packages(readr) -- remember, only once/installation of R
library(readr)
girlpower <- read_csv("C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/WomenGov10.csv")
View(girlpower)

#girlpower <- as.data.frame(girlpower) #in case of not yet created var errors

# ____________________________________________________________________


##
#### CREATING SUBSETS
##

# Maybe we want to create a mini dataset of data for just the southern states:
girlpower_south <- subset(girlpower, girlpower$south==1)
View(girlpower_south)

# Or a subset using only certain columns
termlimit_states <- subset(girlpower, select=c("state", "termlimit"))
View(termlimit_states)

# Other ways to subset: https://www.statmethods.net/management/subset.html


# ____________________________________________________________________


##
#### MERGING DATA
##

# We often want to combine, or merge, two different datasets

# Let's import the dataset to merge ("WomenGov10_extravars.csv")
library(readr)
extravars <- read_csv("C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/WomenGov10_extravars.csv")
View(extravars) # I named this object "extravars"

names(girlpower) #see what variables are in the dataset
nrow(girlpower) #see how many observations are in dataset
names(extravars) #see what variables are in the dataset
nrow(extravars) #see how many observations are in dataset

# Both datasets have "state", "year", and "st" -- let's combine using those
girlpowerplus <- merge(girlpower, extravars, by=c("state", "year", "st"))
View(girlpowerplus)
nrow(girlpowerplus) #uh oh! We seem to have lost a row!

# We could just merge all cases, even when the merging values don't match
girlpowerplus <- merge(girlpower, extravars, by=c("state", "year", "st"), all=TRUE)
nrow(girlpowerplus) #uh oh! Now we are showing an extra row!

# We must have a data cleaning issue here...
# Let's explore the unmatched cases using the "anti_join" function:
install.packages("dplyr") #once/installation of R
library(dplyr) #activating "dplyr" package for this session

# We'll create new objects showing the rows that don't match
problems <- anti_join(girlpower, extravars, by=c("state", "year", "st"))
View(problems) # shows cases from first dataset that weren't merged over
problems2 <- anti_join(extravars, girlpower, by=c("state", "year", "st"))
View(problems2) # shows cases from second dataset that weren't merged over

# Let's fix the issue by correcting values in "extravars" dataset
# Using idea of specifying conditions from GeneratingData reference note
extravars$state[extravars$state=="NewYork"] <- "New York"
extravars$st[extravars$st=="Ny"] <- "NY"
View(extravars)

# Now we can re-merge:
girlpowerplus <- merge(girlpower, extravars, by=c("state", "year", "st"))
nrow(girlpowerplus) #Yes! All set!


# ____________________________________________________________________


##
#### CHANGING DATA FORMAT BETWEEN WIDE AND LONG
##

# Sometimes we think about datasets as being in "wide" format or "long" format.
# Long: rows show multiple observation for a unit or category
# e.g., Alabama-2010 is one observation and Alabama-2011 is another
# Wide: a summary of long data; the data in one category is grouped in some way
# e.g., Alabama is one observation and columns reflect data for 2010, 2011 

library(readr)
pctwom <- read_csv("C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/WomenGov1011_pctwomhs.csv")
View(pctwom) #see how this is a "long" dataset?

# In R, we can use the reshape2 package to convert between these formats. 
# The function melt() converts wide to long, and the function dcast() converts long to wide.
# Excellent resource for help with this: https://seananderson.ca/2013/10/19/reshape/
# I recommend working with just a few variables at a time!

install.packages("reshape2") #once/installation of R
library(reshape2) #activate reshape2 package for session

# To turn the example "long" dataset into "wide" format, we use dcast()
# This code means we want a column for "state" and "year" is the breakdown for state
# R knows that the remaining column contains the values that we are interested in
pctwom_wide <- dcast(pctwom, state ~ year)
View(pctwom_wide)

# To turn this wide dataset back into long format, we use melt()
# This code means "state" is id variable that identifies individual rows of data
pctwom_long <- melt(pctwom_wide, id.vars = c("state"))
View(pctwom_long)

# Clean up the column names once you finish to keep track of things!
names(pctwom_long)[names(pctwom_long) == "variable"] <- "year"
names(pctwom_long)[names(pctwom_long) == "value"] <- "pct_wom_hs"


# ____________________________________________________________________


##
#### SAVING DATA AS NEW FILE
##

#
## write CSV files (I would typically save things as a CSV rather than Excel)
#

write.csv(girlpower_south, file="C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/girlpower_south.csv")

#
## write Stata files
#

install.packages("foreign")
library(foreign)
write.dta(girlpower_south, file="C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/girlpower_south.dta")

#
## write R files
#

save(girlpower_south, file = "C:/Users/krolf/OneDrive/Documents/_Georgetown Fall 2020/girlpower_south.RData")


# ____________________________________________________________________


###### Note: when closing R, it is generally better to NOT save the "workspace image" (i.e., the objects in the Environment)
###### Starting with a clean workspace each session makes it easier to keep track of your objects and prevent programming issues