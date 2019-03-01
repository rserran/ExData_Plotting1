## John Hopkins University Exploratory Data Analysis Course Project 1
## Plot #4 (plot4.R)

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

## change Date and Time variables to POSIXlt
subset_power_df$DateTime <- strptime(paste(subset_power_df$Date, subset_power_df$Time, 
                                           sep = " "), "%d/%m/%Y %H:%M:%S")

## create four plots
## output png file
png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

## plot 1
with(subset_power_df, plot(DateTime, Global_active_power, type = "l", 
                           xlab = "", ylab = "Global Active Power (kilowatts)"))

## plot 2
with(subset_power_df, plot(DateTime, Voltage, type = "l", 
                           xlab = "datetime", ylab = "Voltage"))

## plot 3
with(subset_power_df, plot(DateTime, Sub_metering_1, type = "l", 
                           xlab = "", ylab = "Energy sub metering"))
with(subset_power_df, lines(DateTime, Sub_metering_2, type = "l", col = "red"))

with(subset_power_df, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1), 
       col = c("black", "red", "blue"))

## plot 4
with(subset_power_df, plot(DateTime, Global_reactive_power, type = "l", 
                           xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()