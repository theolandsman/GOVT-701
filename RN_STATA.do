
/*
####
######
#######
########  LET'S GET AN IDEA OF HOW STATA WORKS!
#######
######
####
*/

// ____________________________________________________________________


/*
#### CALCULATOR FUNCTION
*/

display 2+4+68+91

display 6/24

display 36^2  //can also shorted to "di"

// ____________________________________________________________________

/* Unlike R, STATA is not object oriented, the primary unit of STATA analysis
   is the variable within a dataset. Only one dataset can be loaded into 
   STATA at a time, however, it is possible to temporally store constants 
   and vectors in memory without assigning them to a variable. */

// ____________________________________________________________________
   
   
scalar math = 8*9 +3
display math * 4

/*
#### CODE MANAGEMENT
*/

/* Opening a new Do file: click the piece of paper icon to the right of the bargraph 
   icon and under "Graphics". Avoid typing code directly into the "Command" area
   because it can't be saved from there. 

   Writing comments: type "//" before your comment if it's on one line. 
   Enclose comments that spread over multiple lines within /* and */. 
   
   When code runs over more than one line, must use /// at end of line to be continued.
   
   Running commands: highlight line of code, then hold down "ctrl" + "d" for    
   Windows, "shift" + "command" + "d" for Macs. 
   
   Note that Stata lets you abbreviate many functions. */

// ____________________________________________________________________


/*
#### OPENING DATA
*/

// You'll need to set your "working directory"
// Windows Users
// cd "C:\Users\TLandsman\Documents\Georgetown_Fall_2021\MathCamp" 

/// Mac Users 
cd "/Users/theolandsman/Documents/GOVT_Math_Camp"
pwd // to check current directory

// You'll need to clear memory whenever you want to use a new dataset
clear

// You can import data by going to "File" -> "Import" -> select data 
// Importing Stata data:
use Stataexample.dta

// Importing csv files:
import delimited "csvexample.csv"

// Importing Excel data:
import excel "Excelexample.xlsx" firstrow // "first row" means row 1 is variable names

// Importing certain sheet from Excel file:
import excel "Congress116.xlsx", sheet("House") firstrow

// ____________________________________________________________________

clear
/*
#### VIEWING DATA
*/

// We'll use our WomenGov10.csv file as an example
import delimited "WomenGov10.csv"

// Viewing dataset as spreadsheet
// Notice that "string" (non-numeric) variables show up in red
browse

// Editing dataset (careful doing this!)
edit

/// Access help files for a given command
help edit

// Set the variable names to show in window by selecting "Window" -> "Variables"
// We can also view all variables using "describe" command
describe
des // notice that we can abbreviate this command

// Viewing summary overview of all variables 
codebook

// Viewing summary overview of one variable
codebook pct_evan

// Viewing value of each variable for all rows
list

// Viewing values of one variable for all rows
list state

// Viewing value of each variable for particular row/s
list if pct_fem_hs <= 15 // use "if" command to specify conditions

// ____________________________________________________________________



/*
#### MANIPULATING DATA 
*/

// Creating new variable based on other variables (e.g., % Democrats who were 
// women in 2010 state legislatures)
generate pct_fem_dem_hs = no_fem_dem_hs / no_dem_hs*100

// Creating new binary (0/1) variable (e.g., equal to 1 for states with 
// women's representation above the mean):
generate pct_women_hs_high = .
replace pct_women_hs_high = 1 if pct_women_hs >= 24.9
replace pct_women_hs_high = 0 if pct_women_hs < 24.9

// Deleting a variable
drop pct_women_hs_high


// ____________________________________________________________________


/*
#### SAVING AND EXPORTING DATA 
*/

// (You can also go to "File" in top menu and select "Export", then choose options) 

// To save as Stata (.dta) file 
save "girlpower.dta"

// To save as csv file
export delimited using "girlpower.csv"

// To save as Excel file
export excel using "girlpower.xlsx", firstrow(variables)
