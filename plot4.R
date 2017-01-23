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
