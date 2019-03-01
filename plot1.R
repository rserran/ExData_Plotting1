## John Hopkins University Exploratory Data Analysis Course Project 1
## Plot #1 (plot1.R)

## First step is to download to ./data directory
if(!file.exists("./data")){dir.create("./data")}
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile="./data/dataset.zip")
unzip("./data/dataset.zip")

## install.package(data.table), library(data.table)
install.packages("data.table")
library(data.table)

## read text file with fread (faster)
power_df <- fread(file.path("data", "household_power_consumption.txt"), 
                  header = TRUE, sep = ";", na.strings = "?")

## subset dates from "1/2/2007" to "2/2/2007"
subset_power_df <- power_df[Date %in% c("1/2/2007", "2/2/2007") ,]
rm(power_df)

## create histogram with Global_active_power variable
## output png file
png("plot1.png", width = 480, height = 480)

hist(subset_power_df[, Global_active_power], main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red") 
dev.off()
