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
# Draw a plot and save it to a PNG file called plot2.png,
# with a width of 480 pixels and a height of 480 pixels.
#---------------------------------------------------------------------
threeDays <- subset(dataSubset, weekdays(DateTime) %in% c("Thursday", "Friday", "Saturday"))

png(file="plot2.png", width = 480, height = 480)
with(threeDays,
     plot(DateTime, Global_active_power, 
                      type="l", 
                      xlab="",
                      ylab="Global Active Power (kilowatts)"))
dev.off()
