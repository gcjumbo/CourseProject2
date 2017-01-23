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
