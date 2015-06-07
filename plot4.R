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

#Create a Global Active Power object
globalActivePower <- housingData$Global_active_power

#Create three objects for submetering 1-3
subMetering1 <- housingData$Sub_metering_1
subMetering2 <- housingData$Sub_metering_2
subMetering3 <- housingData$Sub_metering_3

#Create voltage object
voltage <- housingData$Voltage

#Create global reactive power
globalReactivePower <- housingData$Global_reactive_power

#Establish that we will be using a png file
png("plot4.png")

#Establish that we will use multiple plots
par(mfcol = c(2, 2))
with (housingData, {
  
  #Create plot 1
  plot(dateAndTime, globalActivePower, 
       type = "l", xlab = "", ylab = "Global Active Power")
  
  #Create plot 2
  #Create the plot with points for the second and third submetering.  Also add legend.
  #Unlike plot3.R, note that bty = "n" in the legend, which removes the box
  #Also shrunk the legend using the cex property
  plot(x = dateAndTime, y = subMetering1, type = "l", 
       xlab = "", ylab = "Energy sub metering")
  points(x = dateAndTime, y = subMetering2, type = "l", col = "red")
  points(x = dateAndTime, y = subMetering3, type = "l", col = "blue")
  legend("topright", lty = 1, bty = "n", cex = 0.75, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  #Create plot 3
  plot(dateAndTime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  
  #Create plot 4
  plot(dateAndTime, globalReactivePower, type = "l", xlab = "datetime",
       ylab = "Global_reactive_power")
  
  #Set the axis to handle increments of 0.1
  axis(side = 2, at = seq(0.1:0.5, by = 0.1), labels = seq(0.1:0.5, by = 0.1))
  
}
      )
dev.off()
closeAllConnections()