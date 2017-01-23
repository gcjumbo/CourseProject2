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

# Have total em
issions from PM2.5 decreased in the United States from 1999 to
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
