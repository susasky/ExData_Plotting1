###This script assumes that in the working directory is present a file named "household_power_consumption.txt". 
###This file is a copy of the one described in README

#loads required packages
require("sqldf")
#defines SQL query
query <- c("SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'")
#sets the input file name
DataSet <- c("household_power_consumption.txt")
#reads the data selecting from the original file
data <- read.csv2.sql(DataSet,query)
#closes connections
closeAllConnections()

#creates a new column merging date and time
data$when<-paste(data$Date,data$Time)
#forces class to time
data$when<-strptime(data$when,"%d/%m/%Y %H:%M:%S")

#Sets the time to have the days in English
Sys.setlocale("LC_TIME", "C")

#sets output to be the png file with characteristics (name, dimensions and background color)
png(file="plot2.png", width=480, height=480, units="px", bg="transparent")
#builds the plot
plot(data$when,data$Global_active_power,type='l',ylab='Global Active Power (kilowatts)',xlab="")
#sets the graphic device back to the standard output
dev.off()

