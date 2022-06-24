# *************************************************************************
# This is the source script for Workshop 1: An introduction to R and R Studio *
# JPS Feb 28th 2022
# Filename: IntroToRStudioScript.R
#
#  **********************************
#  ****** FIRST IMPORTANT TASK ****** 
#  **********************************
# Create a directory on your desktop called 'RWork' (or whatever you want) and download the data and script files from the Canvas website)
# Read Beckerman et al. Chapter 1 and 2
# Note the colour coding on the scripts (using indents to tidy your code also helps; especially with programme loops)
# This character '#' indicates a comment and can be placed above your code to indicate what's coming next or adjacent to the code as indicated below:

# **************************
# Setting the home directory and environment

# ********************************************************************************************************
# You can do this in RStudio by selecting "Session" then "Set Working Directory" then "Choose directory" *
# I'll demonstrate that just before we start with the coding. YOU'VE ALREADY DONE THIS.
# ********************************************************************************************************

#Check where R is looking
getwd()

# Load in the CVS file 
# Filename: Gradient.csv
# To do this we are going to use the read.csv function - there are lots of ways of doing this in R
# From tab delineated data, xls files, SPSS files and so on. See Beckerman et al. chapter 2.

Gradient <- read.csv("Gradient.csv") # note that file name is in quotes and you need the suffix i.e. .csv

# Look at the Gradient datafile....
names(Gradient) # shows all the column names in the file
str(Gradient) # Note one continous/numeric variable and two factor variables Site and Size
dim(Gradient# shows the dimension or the number of rows and the number of columns
head(Gradient) #lists the first six rows of the data
tail(Gradient) #lists the last six rows of data

View(Gradient) # displays the imported data as a spreasheet
#NOTE - this is an RStudio function call so notice it is capitalised....

# ABOUT these data:
# 1. They are simulated data based on a study I did looking at ground beetles in urban woodlands in Birmingham
# 2. The response variable 'SR' is species richness of beetles or the number of different beetle species in each of 
# the 12 woodlands
# 3. The 'Site' variable is a character with three groups ('Urban', 'Suburban' and 'Rural') indicating where a site
# is located in the city ie. city centre = Urban, the suburbs = suburban, or on the margins of the city = rural
# 4. The 'Size' varaible is a factor with two level ('Large', 'Small') indicating different site sizes

# We need the charactor fields to be a factor classes to use many of the R functions
# so we'll change that using the as.factor command.git add 

Gradient$Site <- as.factor(Gradient$Site # change the Site variable to a factor
Gradient$Size <- as.factor(Gradient$Size) # change the Size variable to a factor

# Check to see if has done that
str(Gradient) # Now the character fields are factors!

# Now we have the data in the correct format, let's some basic plotting to understand the patterns

# Histogram - let's us understand normality...
hist(Gradient$SR) # notice the use of the '$' operator which just asks R to plot a histogram using the column called "SR" from the datafile "Gradient

# Make it look nicer
hist(Gradient$SR,
     col="black",
     xlab = "Site Location",
     ylab = "Frequency",
     border = "White")

# boxplots - useful for normality
# The black line in the middle of the block is the median not the mean
# The block represents the lower 25 percentile and the upper 75 percentile
# The whiskers represent the uper and lower ranges
# so if the median line sits in the middle of the block and the 25/75%iles are evenly balance around it then we can assume
# normality

#NOTE we use boxplots when we are comparing 1 continuous variate with one factor or grouping variable

boxplot(SR ~ Site, data = Gradient)

# Add some titles, labels and colour
boxplot(SR ~ Site, data = Gradient, main="Boxplot of carabids in Birmingham Woodlands",
        xlab = "Site Location", 
        ylab = "Species Richness",
        col = "Light Blue")

# Now repeat for size variable
boxplot(SR ~ Size, data = Gradient, 
        main="Boxplot of carabids in Birmingham Woodlands",
        xlab = "Site Size", 
        ylab = "Species Richness",
        col = "Light Blue")
# the labels/titles are always bounded by the string indicator symbol or " [double quotes]
# main = mail title text
# xlab = x axes text
# ylab = y axes text

# We can also use a package called ggplot2 - creates lovely graphics but the functions/commands are different
# Do do this we need to install ggplot2. It is in the tidyverse package
install.packages("ggplot2")

# We now need to load the ggplot2 library
library(ggplot2)

Ex_Boxplot <- ggplot(Gradient, aes(x = Site, y = SR)) +
geom_boxplot()+ xlab("Site Type") + ylab("Species richness of beetles")

Ex_Boxplot # plots the picture

# so this is different. The first chunk of code after the ( sign is the datafile name)
# the aes(x = Site, y = SR) set the aesthetics or tells what the X and Y axes are
# and finally the + geom_boxplot() tells R to plot a boxplot

# If we have two factors in our data as in this example Site and Size
FacetPlot <- ggplot(Gradient, aes(x=Site, y=SR)) + geom_boxplot() + facet_grid(~Size) 
FacetPlot #plots the picture

#Note the new command here + facet_grid(~Size) use the site size factor to compare both plots.

# add in some labels
FacetPlot1 <- FacetPlot + xlab("Site Type") + ylab("Species richness of beetles")
FacetPlot1

# Jazz up the colours....and we get a legend for free
FacetPlot2 <- ggplot(Gradient, aes(x=Site, y=SR, fill=Site)) + geom_boxplot() + 
  facet_grid(~Size) 
FacetPlot2 

# The new colour command here is fill=Site - gives us a different colour for each site type.

# Now do a basic analysis. We have three groups of sites we want to look at here.
# So we are in the world of Analysis of Variance (ANOVA)
Anova.run <- aov(SR ~ Site, data = Gradient)

# Check results
summary(Anova.run)
# P value is 0.00163 so a highly significant different between the groups of sites

# We should really validate the ANOVA model using R's inbuilt features 
# but we'll cover that in the workshop sessions later in the module.

# ****************************************************
# CLASS EXERCISE                                     *
# ****************************************************

# Repeat the above plots using the compensation.cvs dataset you downloaded earlier
# Note that the filename will be different, as are the column names
# Use the names() and str() functions to see the differences (see above)

# These data differ from the 'Gradient' data; here you have three columns
# but only one of the them 'Grazing' is a character variable. The other two: 'Fruit' and 'Root' are numeric
# the compensation data are derived from a study looking at the production of fruit (apples, kg) 
# on rootstocks of different widths (mm; the tops are grafted onto rootstocks). 
# Furthermore, some trees are in parts of the orchard that allow grazing by cattle, 
# and others are in parts free from grazing. Grazing may reduce the amount of grass, 
# which might compete with the apple trees for resources.

# Remember to make the character variable a factor
