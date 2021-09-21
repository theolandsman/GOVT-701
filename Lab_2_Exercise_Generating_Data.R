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

### Let's Create Some Fake Data!

a <- runif(10) # vector of random selection of 10 numbers from 0 to 1. 
b <- rbinom(20,1,.5) # random vector generated from a know probability of success (1) or failure (0), in this case
# with 20 elements, 1 run of the probabilistic outcome and a .5 chance of success, basically a coin flip. 
c <- rnorm(15) # random vector R generates from a standard normal distribution (mean=0, sd=1)
d <- rnorm(100, mean=5, sd=2) #vector of random selection of
# 100 numbers from standard distribution with mean=5, sd=2

hist(a)
hist(b)
hist(c)
hist(d)
summary(d)
sd(d) 

## Understanding check! Why is the mean 4.450 instead of 5? Why is the standard deviation 2.19 instead of 2? 

e <- rbinom(10000, 1600, .5)
sqrt(1600*.25)
f <- rnorm(10000, mean =800, sd = 20)

hist(e)
hist(f)

## Note that as we increase the number of trials (eg, two coin flips, which could produce 2 heads (2), 
## a heads and a tails (1), or two tails (2)) the binomial distribution converges to a normal distribution where the mean is
## the probability of success times the number of trials, and the standard deviation is the square root of the number of trials, 
## times the probability of success, times the probability of failure. sd = sqrt(n *p * (1-p)). 

## In other words, the normal distribution is the ideal type for a random process iterated across enough trials!
# ____________________________________________________________________


####
######
#######
########  Combining Fake Variables into a Fake Dataframe
#######
######
####

# Let's start with two normally distributed variables with slightly different properties
g <- rnorm(100, mean = 5, sd = 2)

fakeData <- data.frame(d,g)

# Now we're going to relate them to each other by creating a new variable.

fakeData$h <- g+d

# Let's see if we could pursuade a social scientist that these two variables are related. 

cov <- cov(fakeData$g, fakeData$h)
cov # >0 (positive), <0 (negative)

cor_1 <- cor(fakeData$d, fakeData$h)
cor_2 <- cor(fakeData$g, fakeData$h)
cor_1 # -1 (strong neg cor) to 1 (strong pos cor) 
cor_2

# Both are pretty strongly correlated! What if we wanted to fake a specific correlation? 

fakeData$i <- fakeData$g*1 + fakeData$d*.5
cov_2 <- cov(fakeData$g, fakeData$i)
cor_3 <- cor(fakeData$d, fakeData$i)
cor_4 <- cor(fakeData$g, fakeData$i)
cor_3
cor_4

# Not bad for only 100 pieces of data! 

## Understanding Check! What is equation we are using for variable assignment starting to look like? 

# ____________________________________________________________________

##
#### GRAPHING DATA WITH TWO-WAY PLOTS
##


# What would a scatterplot of these variables look like? 

plot(fakeData$g, fakeData$i)

# How about for our weaker correlation?

plot(fakeData$d, fakeData$i)

# How about for two variables that are uncorrelated? 

plot(fakeData$d, fakeData$g)


# Understanding check! What makes d and g uncorrelated? 

# ____________________________________________________________________


####
######
#######
########  PRACTICE EXERCISE
#######
######
####

# Note that there may be different code that works!

# 1) Create a variable that is negatively correlated with d, demonstrate this correlation. 

# 2) Create a variable that is negatively correlated with d and positively correlated with g, 
# demonstrate both correlations seperately

# 3) Create a variable that is negatively correlated with d and g, where this correlation is made 'noisy' 
# by the addition of another random variable (which we can think of as the error term)

