#*******************************************************************************
#	Program:       plot2.R 
#
#	Purpose:       Generate plot2.png for Coursera "Exploratory Data 
#                      Analysis" assignment, Week1
# 
#
#	Input:	       household_power_consumption.txt
#                      file URL: https://d396qusza40orc.cloudfront.net/
#                                exdata%2Fdata%2Fhousehold_power_consumption.zip
#		
#	Output:        plot2.png (Line chart of Global Active Power over time
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

png("plot2.png", width = 480, height = 480, unit = "px")
plot(mydate, dat$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()


