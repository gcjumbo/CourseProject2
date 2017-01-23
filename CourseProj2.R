### Peer-graded Assignment: Course Project 2 ###

## Packages ##

library(dplyr)
library(mosaic)
library(ggplot2)

## Data ##

setwd("/Users/jarrenLS/Documents/Grinnell College/04_Spring 2017/MAT-397 (Adv Data Sci)/Coursera/04_Exploratory Data Analysis/Week 04/CourseProject2")

NEI <- readRDS("exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
# Variables:
  # 𝚏𝚒𝚙𝚜: A five-digit number (represented as a string) indicating the U.S. county
  # 𝚂𝙲𝙲: The name of the source as indicated by a digit string (see source code classification table)
  # 𝙿𝚘𝚕𝚕𝚞𝚝𝚊𝚗𝚝: A string indicating the pollutant
  # 𝙴𝚖𝚒𝚜𝚜𝚒𝚘𝚗𝚜: Amount of PM2.5 emitted, in tons
  # 𝚝𝚢𝚙𝚎: The type of source (point, non-point, on-road, or non-road)
  # 𝚢𝚎𝚊𝚛: The year of emissions recorded

SCC <- readRDS("exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")
# Variables:
  # Mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 sourceset


## Question 1 ##

# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

NEI <- NEI[complete.cases(NEI), ]
NEI$year <- as.factor(NEI$year)
NEI.1999 <- sum(NEI$Emissions[NEI$year == "1999"])
NEI.2002 <- sum(NEI$Emissions[NEI$year == "2002"])
NEI.2005 <- sum(NEI$Emissions[NEI$year == "2005"])
NEI.2008 <- sum(NEI$Emissions[NEI$year == "2008"])
NEI.Emissions <- c(NEI.1999, NEI.2002, NEI.2005, NEI.2008)
NEI.Years <- c(1999, 2002, 2005, 2008)
NEI.test <- data.frame(NEI.Years, NEI.Emissions)
names(NEI.test) <- c("Year", "Total.Emissions")
NEI.test$Year <- as.factor(NEI.test$Year)

# Plot 1
png(filename = "plot1.PNG")

barplot(NEI.test$Total.Emissions, 
        names = NEI.test$Year, 
        xlab = "Year", 
        ylab = "Total PM2.5 Emissions", 
        main = "PM2.5 Emissions in the U.S. from 1999-2008")

dev.off()

# According to the plotted bar graph, total emissions from PM2.5 have decreased 
# in the United States from 1999 to 2008.  We see a total decrease of almost
# four million tons of PM2.5.


## Question 2 ##

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting systemto makea plot
# answering this question.

NEI.balt <- NEI[NEI$fips == "24510", ]
NEI.balt$year <- as.factor(NEI.balt$year)
NEI.balt.1999 <- sum(NEI.balt$Emissions[NEI$year == "1999"], na.rm = TRUE)
NEI.balt.2002 <- sum(NEI.balt$Emissions[NEI$year == "2002"], na.rm = TRUE)
NEI.balt.2005 <- sum(NEI.balt$Emissions[NEI$year == "2005"], na.rm = TRUE)
NEI.balt.2008 <- sum(NEI.balt$Emissions[NEI$year == "2008"], na.rm = TRUE)
NEI.balt.Emissions <- c(NEI.balt.1999, NEI.balt.2002, NEI.balt.2005, NEI.balt.2008)
NEI.balt.Years <- c(1999, 2002, 2005, 2008)
NEI.balt.test <- data.frame(NEI.balt.Years, NEI.balt.Emissions)
names(NEI.balt.test) <- c("Year", "Total.Emissions")
NEI.balt.test$Year <- as.factor(NEI.test$Year)

# Plot 2
png(filename = "plot2.PNG")

barplot(NEI.balt.test$Total.Emissions, 
        names = NEI.balt.test$Year, 
        xlab = "Year", 
        ylab = "Total PM2.5 Emissions", 
        main = "PM2.5 Emissions in the U.S. from 1999-2008")

dev.off()

# According to the plotted bar graph, total emissions from PM2.5 in Baltimore
# City, Maryland have indeed decreased from 1999 to 2008.  We see a huge 
# decrease from 1999 to 2002, where it remains at a similar level later on.  

# NOTE: I tried taking the log of these emissions to observe how that may 
# change the axes/scale, but even in log form there exists a stark difference.
# I anticipate that we observe such a drastic difference perhaps due to some
# change in recording PM2.5.


## Question 3 ##

# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.

png(filename = "plot3.PNG")
fs <- ggplot(NEI, aes(x = type, y = log(Emissions), fill = factor(year))) +
    geom_boxplot() +
    labs(title = "PM2.5 Emissions by Type from 1999-2008") +
    scale_fill_discrete(guide = guide_legend(title = "Year"))
fs    
dev.off()

# According to the plotted bar graph, we see that all four sources see decrease
# in emissions from 1999-2008 when stratified by the type.  We see the largest
# decrease in those with the point type.  None of the sources see increases in
# emissions from 1999-2008, which means that we are getting more squeaky-clean 
# by the year. :)


## Question 4 ##

# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

SCC4 <- filter(SCC, grepl("Coal", SCC$EI.Sector))
coal.ID <- SCC4[, 1]
NEI.coal <- NEI[NEI$SCC %in% coal.ID, ]

png(filename = "plot4.PNG")
coal.plot <- ggplot(NEI.coal, aes(x = factor(year), y = log(Emissions), fill = factor(year))) +
    geom_boxplot() +
    labs(title = "PM2.5 Emissions of Coal Combustion-Related Sources from 1999-2008", x = "Year")
coal.plot   
dev.off()

# According to the plotted bar graph, PM2.5 emissions from coal combustion-
# related sources have not changed much from 1999-2008.  Arguably, you can say
# that they have slightly increased over time.  This makes sense because coal
# is a pivotal fuel source across the United States, which means that coal
# usage may either remain the same, as we see in the graph, or increase over
# time due to increased fuel demand in the United States caused by increasing
# populations.  However, at this point I am somewhat rambling.


## Question 5 ##

# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

SCC5 <- filter(SCC, grepl("Motor", SCC$Short.Name))
coal.ID <- SCC5[, 1]
NEI.coal <- NEI[NEI$fips == "24510", ]
NEI.coal <- NEI.coal[NEI.coal$SCC %in% coal.ID, ]

png(filename = "plot5.PNG")
coal.plot <- ggplot(NEI.coal, aes(x = factor(year), y = log(Emissions), fill = factor(year))) +
    geom_boxplot() +
    labs(title = "PM2.5 Emissions of Motor Vehicles in Baltimore City from 1999-2008", x = "Year")
coal.plot
dev.off()

# According to the plotted bar graph, PM2.5 emissions from motor vehicle
# sources in Baltimore City have sporadically changed from 1999-2008.  We can
# observe that there seems to be a decrease in emissions from 1999 to 2005.
# However, we then see an increase from 2005 to 2008, which is still lower than
# the emissions seen in 1999.


## Question 6 ##

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California 
# (fips == “06037”). Which city has seen greater changes over time in motor
# vehicle emissions?

SCC6 <- filter(SCC, grepl("Motor", SCC$Short.Name))
coal.ID <- SCC6[, 1]
NEI.coal <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ]
NEI.coal <- NEI.coal[NEI.coal$SCC %in% coal.ID, ]
NEI.coal$fips <- as.factor(NEI.coal$fips)
levels(NEI.coal$fips) <- c("Los Angeles County, CA", "Baltimore City, MD")


png(filename = "plot6.PNG")
fs <- ggplot(NEI.coal, aes(x = fips, y = log(Emissions), fill = factor(year))) +
    geom_boxplot() +
    labs(title = "PM2.5 Emissions by Type from 1999-2008", x = "City") +
    scale_fill_discrete(guide = guide_legend(title = "Year"))
fs
dev.off()

# According to the plotted bar graph, PM2.5 emissions from motor vehicle
# sources in Los Angeles County, CA have seen greater changes over time than
# those in Baltimore City, MD.  In Los Angeles County, CA, we can observe that
# PM2.5 emissions fluctuate up and down more vigorously than those in Baltimore
# City, MD.