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
