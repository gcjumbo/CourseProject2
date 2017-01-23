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

## Question 3 ##

# Of the four t
ypes of sources indicated by the type (point, nonpoint, onroad,
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
