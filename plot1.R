library(sqldf)
library(datasets)

closeAllConnections()
#Selecting only Feb 1 and Feb 2
housingData <- read.csv.sql("household_power_consumption.txt", 
                            sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";")
closeAllConnections()

#Establish that we will be using a png file
png("plot1.png")

#Create the histogram
hist(housingData$Global_active_power, col = "Red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()