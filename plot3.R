library(sqldf)
library(datasets)

closeAllConnections()
#Selecting only Feb 1 and Feb 2
housingData <- read.csv.sql("household_power_consumption.txt", 
                            sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";")

#Add a new column to housingData known as combinedDateAndTime
housingData$combinedDateAndTime <- 
  paste(housingData$Date, housingData$Time, sep=' ')

#Create a dateAndtime object that is converted to date/time format
dateAndTime <- 
  strptime(housingData$combinedDateAndTime, format = "%d/%m/%Y %H:%M:%S")

#Create three objects for submetering 1-3
subMetering1 <- housingData$Sub_metering_1
subMetering2 <- housingData$Sub_metering_2
subMetering3 <- housingData$Sub_metering_3

#Establish that we will be using a png file
png("plot3.png")

#Create the plot with points for the second and third submetering.  Also add legend.
plot(x = dateAndTime, y = subMetering1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
points(x = dateAndTime, y = subMetering2, type = "l", col = "red")
points(x = dateAndTime, y = subMetering3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
closeAllConnections()