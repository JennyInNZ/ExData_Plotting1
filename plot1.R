#---------------------------------------------------------------------
# Read in the full set of power data and then get the subset we want
#---------------------------------------------------------------------
powerData = read.csv("./data/household_power_consumption.txt", 
                 sep=";", header=TRUE, na.strings="?" )
# Create a subset for only 1 and 2 February 2007
dataSubset <- powerData[powerData$Date %in% c('1/2/2007', '2/2/2007'),]

#---------------------------------------------------------------------
# Draw a bar chart and save it to a PNG file called plot1.png,
# with a width of 480 pixels and a height of 480 pixels.
#---------------------------------------------------------------------
png(file="plot1.png", width = 480, height = 480)
hist(dataSubset$Global_active_power, col="red", breaks=20,
     main = "Global Active Power", labels=FALSE, xlab="Global Active Power (kilowatts)")
dev.off()