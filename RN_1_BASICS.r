
####
######
#######
########  LET'S GET STARTED WITH SOME BASICS...
#######
######
####

# ____________________________________________________________________

##
#### CALCULATOR FUNCTION
##

2+4+68+91

6/24

36^2

# ____________________________________________________________________

##
#### CODE MANAGEMENT
##
# Opening a new R script: click the piece of paper icon on top left under "file" (select "script") - avoid typing code directly into the 
# "Console" below because it can't be saved from there.

# Writing comments: type "#" before your comment. ALWAYS WRITE COMMENTS. Can also press "ctrl" + "shift" + "c" to comment out text.

# Running commands: hold down "ctrl" + "r" on Windows; "cmd" + "return" on Mac

# Installing packages:
install.packages("foreign") # only needs to be run once/installation
library("foreign") # needs to be run every session
#Note: "foreign" is the package that allows R to read Stata files

# Setting working directory:
setwd("C:/Users/krolf/OneDrive/Documents/_Georgetown_Fall_2019") # note that slashes need to be reversed on Windows
getwd()

# ____________________________________________________________________

##
#### OPENING DATA
##

# TIP: Click "import dataset" under Environment (upper right box), select data type, and copy provided code into your script
install.packages("readr")
library(readr)
girlpower <- read_csv("C:/Users/krolf/OneDrive/Documents/_Georgetown_Fall_2019/WomenGov10.csv")


# ____________________________________________________________________

##
#### VIEWING DATA
##

# To see a list of all of the variable names in the data set (object) called "girlpower":
names(girlpower)

# To look at a spreadsheet of your dataset:
View(girlpower) # note the capital V

# To see a snapshot of your data:
head(girlpower) # shows you the first 10 rows

# To see dimensions of dataset:
dim(girlpower)

# To see number of rows:
nrow(girlpower)

# To see number of columns:
ncol(girlpower)

######## -> How many variables does the dataset have? How many observations?

# ____________________________________________________________________

##
#### SUMMARY STATISTICS
##

# To calculate mean percent of women across state legislatures in 2010:
mean(girlpower$pct_fem_bothchambers)
# Remember that women make up approximately half of the U.S. population...
# To calculate mean for only those rows that meet certain conditions:
mean(girlpower$pct_fem_bothchambers[girlpower$West==1])

############ Which region has the highest average percent female representation?

# To view summary statistics for the percent of women across state legislatures in 2010:
summary(girlpower$pct_fem_bothchambers)

# To see which state had the minimum of 10 percent:
girlpower$state[girlpower$pct_fem_bothchambers==10]

######## -> How would you see which state had more than 30 percent representation?

# To see which states in the west have less than 25 percent representation:
girlpower$state[girlpower$pct_fem_bothchambers<25 & girlpower$West==1]

######## -> How would you see which states have either less than 25 percent or more than 35 percent representation?
#           Hint: you'll need to use the | symbol (for "or")

# To calculate the standard deviation of women across state legislatures in 2010:
sqrt(var(girlpower$pct_fem_bothchambers))

# To view table of the percent women in each state legislature
table(girlpower$pct_fem_bothchambers)

# To view histogram of the percent women across each state legislature
hist(girlpower$pct_fem_bothchambers, xlab="Percent Women", main="Histogram of Women's Representation in State Legislatures")



# ____________________________________________________________________

##
#### MANIPULATING DATA 
##

# To create a new variable for percent Democrats who were women in 2010 state legislatures:
girlpower$pct_fem_dem_hs <- girlpower$no_fem_dem_hs/girlpower$no_dem_hs

######## -> How would you create a new variable for the percent of Republicans who were women?

# To create a new binary (0/1) variable for states with representation above mean:
girlpower$pct_fem_hs_high <- as.numeric(girlpower$pct_fem_bothchambers>=mean(girlpower$pct_fem_bothchambers))

# To view spread of variable that you just created:
table(girlpower$pct_fem_hs_high)


# ____________________________________________________________________

##
#### GRAPHING DATA 
##

# To plot a bar graph of the percent state legislature seats held by women:

# (let's make a subset of our data for just western states to start -- 49 states is a lot to fit on one plot)
girlpower_west <- subset(girlpower, girlpower$West==1)
# Now we can make our barplot from this subset of the data:
barplot(girlpower_west$pct_fem_bothchambers, names.arg=girlpower_west$ST, las=2,
        xlab="State", ylab="Percent Women", ylim=c(0,50), main="Percent Women in State Legislatures by State")
# Note that "names.arg" attaches the names of the states to the bars, "las" can flip labels,
# "xlab" and "ylab" are for axis labels, and "xlim" and "ylim" are for length of axes

# To make bargraph where states are in ascending order by percent women in state legislatures:
# (let's start with a new subset again)
girlpower_west_or <- girlpower_west[order(girlpower_west$pct_fem_bothchambers),]
# Now we can make our barplot from this subset of the data:
barplot(girlpower_west_or$pct_fem_bothchambers, names.arg=girlpower_west_or$ST, las=2,
        xlab="State", ylab="Percent Women", ylim=c(0,50), main="Percent Women in State Legislatures by State")

######## -> How would you create a bar plot for southern states?

# ____________________________________________________________________

##
#### SAVING DATA
##

write.csv(girlpower, file = "C:/Users/krolf/OneDrive/Documents/_Georgetown_Fall_2019/girlpower_v2.csv")