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
########  LET'S GRAPH!
#######
######
####


##
#### IMPORTING DATASETS
##

library(readr)
foodfight  <- read_csv("http://bit.ly/cs631-hotdog", 
                                  col_types = cols(
                                    gender = col_factor(levels = NULL)
                                  )) # Note that we can import a dataset straight from a url. 
                                    # This only works if the url is for the your data and only your data, i.e. you
                                    # CANNOT use canvas data viewer links this way. 
View(foodfight) #winners of Nathan's Hot Dog Eating Contest, 1972-2017

pres_vote <- read_excel("pres_vote.xlsx")
View(pres_vote)
# These data come from the Daisy KOS and the unit is congressional districts

# Graphing example comes from Dr. Wesley Joe


# ____________________________________________________________________

##
#### DESCRIBING DATA USING HISTOGRAMS, BOXPLOTS
##

# See instructions for creating histograms and box/whisker plots in Reference Note #2

# ____________________________________________________________________

##
#### GRAPHING DATA WITH BARPLOTS 
##

# Credit: Example comes from Nathan Yau in his book "Visualize This"

barplot(foodfight$num_eaten) 
#specifying names of each bar (names.arg)
barplot(foodfight$num_eaten, names.arg=foodfight$year) 

#removing border around individual bars (border)
barplot(foodfight$num_eaten, names.arg=foodfight$year, border=NA) 

#adding x and y axis labels (xlab, ylab)
barplot(foodfight$num_eaten, names.arg=foodfight$Year, border=NA,
        xlab="Year", ylab="Hot Dogs Eaten") 

#changing color of bars (col)
barplot(foodfight$num_eaten, names.arg=foodfight$year, border=NA, 
        xlab="Year", ylab="Hot Dogs Eaten", col="dark blue")
#changing color of bars using hexadecimal codes: https://htmlcolorcodes.com/
barplot(foodfight$num_eaten, names.arg=foodfight$year, border=NA, 
        xlab="Year", ylab="Hot Dogs Eaten", col="#333366") #navy blue

#changing x or y axis lengths (xlim, ylim)
barplot(foodfight$num_eaten, names.arg=foodfight$year, border=NA, 
        xlab="Year", ylab="Hot Dogs Eaten", col="#333366", ylim=c(0,70))

#adding main title (main)
barplot(foodfight$num_eaten, names.arg=foodfight$year, col="#333366",
        border=NA, xlab="Year", ylab="Hot Dogs Eaten", ylim=c(0,70),
        main="Hot Dogs Eaten at Nathan's Hot Dog Eating Contest") 

# ____________________________________________________________________

##
#### GRAPHING DATA WITH TWO-WAY PLOTS
##

#making basic scatterplot (x variable, y variable) 
plot(pres_vote$rnormvote, pres_vote$Trump_2016)

# Sure looks correlated, is it?
cov(pres_vote$rnormvote, pres_vote$Trump_2016) # Find covariance
cor(pres_vote$rnormvote, pres_vote$Trump_2016) # Find correlation

#changing shape of point (pch)
plot(pres_vote$rnormvote, pres_vote$Trump_2016, 
     pch = 16)  
# http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r

#changing size of point (cex)
plot(pres_vote$rnormvote, pres_vote$Trump_2016, 
     pch = 1, cex=5)  

#changing color of point (col)
plot(pres_vote$rnormvote, pres_vote$Trump_2016, 
     pch = 16, cex=.5, col="#00AFBB")  

#adding axis labels and title (xlab, ylab, main)
plot(pres_vote$rnormvote, pres_vote$Trump_2016, 
     pch = 16, cex=1, col="#00AFBB",
     main="Trump vote compared to normal vote for a GOP Nominee", 
     xlab="Average GOP performance in 2008 and 2012",
     ylab="Trump Voteshare") 

#changing orientation of axis values (las)
plot(pres_vote$rnormvote, pres_vote$Trump_2016, 
     pch = 16, cex=1, col="#00AFBB",
     main="Trump vote compared to normal vote for a GOP Nominee", 
     xlab="Average GOP performance in 2008 and 2012",
     ylab="Trump Voteshare", las=1)  

#adding lowess or regression lines
##lowess line is a line of best fit (not a regression line!)
lines(lowess(pres_vote$rnormvote, pres_vote$Trump_2016)) 
##regression line
abline(lm(pres_vote$rnormvote ~ pres_vote$Trump_2016))
##changing color, width for lines
abline(lm(pres_vote$rnormvote ~ pres_vote$Trump_2016), col="#C4961A", lwd=2) 

# ____________________________________________________________________



#
## SAVING AS IMAGES: Base R
#

## Saving a plot in base R requires two steps in addition to creating the plot
# Specifying the pathyway and file type for the image, which is done before creating the plot.
# Telling R to stop sending things to that file path, this is done with dev.off()

# For example
png("rnorm_vs_Trump.png")
plot(pres_vote$rnormvote, pres_vote$Trump_2016, 
     pch = 16, cex=1, col="#00AFBB",
     main="Trump vote compared to normal vote for a GOP Nominee", 
     xlab="Average GOP performance in 2008 and 2012",
     ylab="Trump Voteshare", las=1)  
dev.off()

# ____________________________________________________________________
##
#### GGPLOT2
##

## ggplot2 is a popular graphics package that has more contemporary default 
## options than "base" R and also offers streamlined ways of incorporating 
## more data into a single plot

## It relies on "geoms" (plot layers) and "aesthetics" 
# (visual characteristics of geom-specific plot elements)
# Common geoms include: geom_density, geom_histogram, geom_bar, geom_point, 
# geom_smooth, geom_blank, geom_text, geom_dumbbell
# Great resource on geoms here: 
# https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
# Common aesthetics include: x, y, color, shape, size, stroke, alpha (transparency)

## Other features of ggplot2 include "facets" (multiple plots), "labs" (labels), and "themes"
# Common themes include theme_bw(), theme_grey(), theme_classic(), theme_minimal()


# ____________________________________________________________________

#
## EXAMPLE: BASIC SCATTER PLOT WITH LINE
#

library(ggplot2)

# We start by producing a blank plot
# specifying the data and x and y axes
# x = Mean Republican vote share from 2008 and 2012
# y = Share of vote received by Trump in 2016
ggplot(data = pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016))


# To add scatterplot points, we add the "geom_point" geom
ggplot(data = pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    # remember to use a plus!!
  geom_point() # with parentheses


# To adjust the characteristics of points, we include "constants" 
# inside the "geom_point" parentheses
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    
  geom_point(color = "#808080", size = 2, alpha = 0.5) #alpha is transparency


# To add a regression line, we add the "gemo_smooth" geom (with lm option)
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    
  geom_point(color = "#808080", size = 2, alpha = 0.75) + # use a plus here too!
  geom_smooth(method = "lm")


# To adjust characteristics of the regression line, we include "constants" 
# inside the "geom_smooth" parentheses:
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    
  geom_point(color = "#808080", size = 2, alpha = 0.75) +
  geom_smooth(method = "lm", linetype = 2, se = FALSE, color = "#2F4F4F", size = 1)


# We can add a title, subtitle, caption, and axis labels by adding labs()
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    
  geom_point(color = "#808080", size = 2, alpha = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#2F4F4F", size = 1) + # use a plus here too!
  labs(title = "GOP Vote Share and Trump's Vote Share in 2016", 
       subtitle = "Each point represents a congressional district", 
       caption = "Data Source: Daily KOS", 
       x = "Mean GOP Vote Share from 2008 and 2012", 
       y = "Trump's Vote Share in 2016")


# We can change axis ranges by adding "xlim()" or "ylim()"
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    
  geom_point(color = "#808080", size = 2, alpha = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#2F4F4F", size = 1) +
  labs(title = "GOP Vote Share and Trump's Vote Share in 2016", 
       subtitle = "Each point represents a congressional district", 
       caption = "Data Source: Daily KOS", 
       x = "Mean GOP Vote Share from 2008 and 2012", 
       y = "Trump's Vote Share in 2016") + # use a plus here too!
  xlim(0, 100) + # and here!
  ylim(0, 100)


# We can change the default visual settings by adding a "theme"
# more themes here: https://www.datanovia.com/en/blog/ggplot-themes-gallery/
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    
  geom_point(color = "#808080", size = 2, alpha = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#2F4F4F", size = 1) +
  labs(title = "GOP Vote Share and Trump's Vote Share in 2016", 
       subtitle = "Each point represents a congressional district", 
       caption = "Data Source: Daily KOS", 
       x = "Mean GOP Vote Share from 2008 and 2012", 
       y = "Trump's Vote Share in 2016") + # use a plus here too!
  theme_bw() # this is the black/white theme

ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    
  geom_point(color = "#808080", size = 2, alpha = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#2F4F4F", size = 1) +
  labs(title = "GOP Vote Share and Trump's Vote Share in 2016", 
       subtitle = "Each point represents a congressional district", 
       caption = "Data Source: Daily KOS", 
       x = "Mean GOP Vote Share from 2008 and 2012", 
       y = "Trump's Vote Share in 2016") +
  theme_classic() # this is the classic theme

ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    
  geom_point(color = "#808080", size = 2, alpha = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#2F4F4F", size = 1) +
  labs(title = "GOP Vote Share and Trump's Vote Share in 2016", 
       subtitle = "Each point represents a congressional district", 
       caption = "Data Source: Daily KOS", 
       x = "Mean GOP Vote Share from 2008 and 2012", 
       y = "Trump's Vote Share in 2016") +
  theme_minimal() # this is the minimal theme


# We can change the design elements of the axis tick marks, labels, and titles 
# using the "element_text" argument within "theme", specified by axis component
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +    
  geom_point(color = "#808080", size = 2, alpha = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "#2F4F4F", size = 1) +
  labs(title = "GOP Vote Share and Trump's Vote Share in 2016", 
       subtitle = "Each point represents a congressional district", 
       caption = "Data Source: Daily KOS", 
       x = "Mean GOP Vote Share from 2008 and 2012", 
       y = "Trump's Vote Share in 2016") +
  theme_minimal() +
  theme(axis.text.x = element_text(face="bold", color="#2F4F4F", 
                                   size=10, angle=45),
        axis.text.y = element_text(face="bold", color="#2F4F4F", 
                                   size=10, angle=45),
        axis.title.x = element_text(color="#2F4F4F", size=12),
        axis.title.y = element_text(color="#2f4F4F", size=12),
        plot.title = element_text(color="#2F2F2F", hjust = 0.5),
        plot.subtitle = element_text(color="#2F2F2F", hjust = 0.5))


# ____________________________________________________________________

#
## TAKING ADVANTAGE OF GGPLOT2 CAPABILITIES
#

# We used mapping = aes() to "map" our specified variables to the graph
# x = Mean Republican vote share from 2008 and 2012
# y = Share of vote received by Trump in 2016
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016))

# We can also use aes() for other variables to "map" on additional variables 
# onto specific geoms, e.g., coloring or shaping our "geom_point" points by
# the party ID of the incumbent for each district (variable= Party)
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_point(mapping = aes(color = Party))

ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_point(mapping = aes(shape = Party))

# We can also manually specify the colors/shapes/etc. 
# using "scale_[aesthetic]_manual"
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_point(mapping = aes(color = Party)) +
  scale_color_manual(name = "Party ID",
                     values = c(R = "red", D = "blue"),
                     labels = c(R = "Republican", D = "Democrat"))

ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_point(mapping = aes(shape = Party)) +
  scale_shape_manual(name = "Party ID",
                     values = c(R = 1, D = 2),
                     labels = c(R = "Republican", D = "Democrat"))

# We could also use aes() with the geom_smooth geom to 
# "map" additional variables onto our line, e.g., showing different
# regression lines for districts in which the incumbent was R vs D
ggplot(data= pres_vote,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_point(mapping = aes(color = Party)) +
  scale_color_manual(name = "Party ID",
                     values = c(R = "red", D = "blue"),
                     labels = c(R = "Republican", D = "Democrat")) +
  geom_smooth(mapping = aes(color = Party),
              method = "lm", se = FALSE)

# We could also use the same logic to use district abbreviations as points
# First I'll make a subset for just one state
# to ensure readability of labels
pres_vote_VA <- subset(pres_vote, state== "VA")

# Mapping labels onto points
ggplot(data= pres_vote_VA,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_text(mapping = aes(label = CD))

# Changing size of all points
ggplot(data= pres_vote_VA,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_text(mapping = aes(label = CD), size = 2)

# vs using aes() to map Obama vote share in 2008 onto size
ggplot(data= pres_vote_VA,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_text(mapping = aes(label = CD, size = Obama_2008))

# Mapping labels and colors for incumbent party onto points
ggplot(data= pres_vote_VA,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_text(mapping = aes(label = CD, color = Party), size = 2.5)

# Fixing color scheme, removing legend, adding labels
ggplot(data= pres_vote_VA,
       mapping = aes(x = rnormvote, y = Trump_2016)) +
  geom_text(mapping = aes(label = CD, color = Party), size = 3) +
  scale_color_manual(name = "Party ID",
                     values = c(R = "red", D = "blue"),
                     labels = c(R = "Republican", D = "Democrat")) + 
  labs(title = "Normal GOP Vote Share and Trump's 2016 Vote Share in Virginia", 
       subtitle = "Congressional districts with Democratic incumbent in 2016 in blue
Congressional districts with Republican incumbent in 2016 in red", 
       caption = "Data Source: Daily KOS", 
       x = "Mean GOP Vote Share from 2008 and 2012", 
       y = "Trump's Vote Share in 2016") +
  theme_minimal() + # this is the minimal theme 
  theme(legend.position = "none")


# ____________________________________________________________________

#
## SAVING AS IMAGES
#

# Can click "Export" under "Plots" and select "Save as Image"
# I often have the best luck saving as ".png" file

# For ggplot2 graphs, you can also use "ggsave"
# This allows you to specify a higher image quality

# dpi is a measure of image quality (journals usually require >300)
ggsave("VA_rnorm_Trump.png", 
       dpi = 300)

# can also designate size in terms of width and height
ggsave("VA_rnorm_Trump.png", 
       width = 20, height = 20, units = "cm")

###### Note: when closing R, it is generally better to NOT save the "workspace image" (i.e., the objects in the Environment)
###### Starting with a clean workspace each session makes it easier to keep track of your objects and prevent programming issues

