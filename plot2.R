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

#Establish that we will be using a png file
png("plot2.png")

#Create the plot
plot(dateAndTime, globalActivePower, 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
closeAllConnections()