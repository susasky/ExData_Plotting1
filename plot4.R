##This script assumes that in the working directory is present a file named "household_power_consumption.txt". This file is a copy of the one described in README

##loads required packages
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
png(file="plot4.png", width=480, height=480, units="px", bg="transparent")

#sets pars to plot 4 figures in one plot
old.par <- par(mfrow=c(2, 2))

#builds the plot
#top left
plot(data$when,data$Global_active_power,type='l',ylab='Global Active Power',xlab="")
#top right
plot(data$when,data$Voltage,type='l',ylab='Voltage',xlab="datetime")
#bottom left
plot(data$when,data$Sub_metering_1,type='l',ylim=c(0,max(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3)),xlab="",ylab="",axes=F)
par(new=T)
plot(data$when,data$Sub_metering_2,type='l',ylim=c(0,max(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3)),col="red",xlab="",ylab="",axes=F)
par(new=T)
plot(data$when,data$Sub_metering_3,type='l',ylim=c(0,max(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3)),col="blue",xlab="",ylab="Energy sub metering")
legend('topright', names(data)[7:9], lty=1, col=c('black', 'red', 'blue'), bty='black', cex=.75)
par(new=F)
#bottom right
plot(data$when,data$Global_reactive_power,type='l',ylab='Global_reactiveìpower',xlab="datetime")

#sets pars back to default values
par(old.par)

#sets the graphic device back to the standard output
dev.off()


