#*******************************************************************************
#	Program:       plot4.R 
#
#	Purpose:       Generate plot4.png for Coursera "Exploratory Data 
#                      Analysis" assignment, Week1
# 
#
#	Input:	       household_power_consumption.txt
#                      file URL: https://d396qusza40orc.cloudfront.net/
#                                exdata%2Fdata%2Fhousehold_power_consumption.zip
#		
#	Output:        plot1.png (histograme of Global Active Power)		
#
#*******************************************************************************

#*******************************************************************************
# Load libraries
#*******************************************************************************

library(dplyr)
library(data.table)
library(chron)

#*******************************************************************************
# Download and unzip the files if they have not already been downloaded
#*******************************************************************************

if(!file.exists("household_power_consumption.txt")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        outfile <- "exdata_data_household_power_consumption.zip"
        download.file(fileUrl, destfile = outfile)
        unzip(outfile)
}

#*******************************************************************************
# Read data in text file into data table for the specified date range
#*******************************************************************************


dat <- filter(fread("household_power_consumption.txt", na.strings = "?"), 
              Date == "1/2/2007" | Date =="2/2/2007")

#*******************************************************************************
# Convert to dates and times to date/time classes from character variables
#*******************************************************************************

dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
dat$Time <- times(dat$Time)

mydate <- as.POSIXct(paste(dat$Date, dat$Time))

#*******************************************************************************
# Make plot and save to png file
#*******************************************************************************

png("plot4.png", width = 480, height = 480, unit = "px")

par(mfrow=c(2,2), cex = .8)
plot(mydate, dat$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")

plot(mydate, dat$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

plot(mydate, dat$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(mydate, dat$Sub_metering_2, type = "l", col = "red")
lines(mydate, dat$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), col = c("black", "red", "blue"),
                               lty = c(1,1,1), lwd = 2, bty = "n", cex = .9)

plot(mydate, dat$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()


