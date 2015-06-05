## IMPORTANT: The datafile has to be in your working directory
## Read data into R
data <- read.table("household_power_consumption.txt", header = T, sep = ";",
           na.strings = "?")


## Check data 
dim(data)
names(data)
lapply(data, class)
str(data)

## Investigate date and time format and test conversion with 1 element
library(lubridate) #load lubridate package for date and time conversions
data$Date[1:10]
data$Time[1:10]
as.POSIXct(paste(data$Date[1], data$Time[1]), format = "%d/%m/%Y %H:%M:%S")

## Create date-time column in POSIXct format
data$DateTime <- as.POSIXct(paste(data$Date, data$Time),
                            format = "%d/%m/%Y %H:%M:%S")

## Subset data between dates 2007-02-01 and 2007-02-02
data.subset <- subset(data, DateTime >= "2007-02-01 00:00:00 GMT" &
           DateTime < "2007-02-02 24:00:00 GMT")

## Check data subset
head(data.subset)[1:2]
tail(data.subset)[1:2]

## Create function to plot graph
plotGraph <- function() {
    hist(data.subset$Global_active_power, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
}

## Plot histogram in png file
?Devices #check devices
png(filename = "plot1.png") #standard size is 480 by 480 pixels
plotGraph()
dev.off()

