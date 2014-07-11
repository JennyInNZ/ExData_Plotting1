#---------------------------------------------------------------------
# Read in the full set of power data and then get the subset we want
#---------------------------------------------------------------------
powerData = read.csv("./data/household_power_consumption.txt", 
                 sep=";", header=TRUE, na.strings="?" )
# Create a subset for only 1 and 2 February 2007
dataSubset <- powerData[powerData$Date %in% c('1/2/2007', '2/2/2007'),]
# Merge the Date and Time columns into a new DateTime column
dataSubset$DateTime <- paste(dataSubset$Date, dataSubset$Time, sep=" ") 
# Convert the DateTime column to a Date class
dataSubset$DateTime <- strptime(dataSubset$DateTime, format= "%d/%m/%Y %H:%M:%S", tz = "")

#---------------------------------------------------------------------
# Draw a plot and save it to a PNG file called plot4.png,
# with a width of 480 pixels and a height of 480 pixels.
# It should have four subplots.
#---------------------------------------------------------------------
threeDays <- subset(dataSubset, weekdays(DateTime) %in% c("Thursday", "Friday", "Saturday"))

png(file="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
with(threeDays, {
#   Plot 1
     plot(threeDays$DateTime, Global_active_power, 
          type="l", 
          xlab="",
          ylab="Global Active Power")
#   Plot 2
plot(threeDays$DateTime, Voltage, 
     type="l", 
     xlab="datetime",
     ylab="Voltage")
#   Plot 3
plot(threeDays$DateTime, Sub_metering_1,  
     type="l", 
     xlab="",
     ylab="Energy Sub Metering")
lines(threeDays$DateTime, threeDays$Sub_metering_2, col="red")
lines(threeDays$DateTime, threeDays$Sub_metering_3, col="blue")
# Add a legend
legend("topright", pch="_", 
       col=c("black", "red", "blue"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#   Plot 4
plot(threeDays$DateTime, Global_reactive_power, 
     type="l", 
     xlab="datetime",
     ylab="Global_reactive_power")
})
dev.off()