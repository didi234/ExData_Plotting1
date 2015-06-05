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

## Convert Date column to date format in subset
data.subset$Date <- as.Date(data.subset$Date, "%d/%m/%Y")

## Create function to plot graph
plotGraph <- function() {
    par(mfcol = c(2, 2), mar = c(4, 4, 4, 2))
    with(data.subset, {
        ## Plot graph 1
        plot(Global_active_power ~ DateTime, type = "l",
             xlab = "", ylab = "Global Active Power (kilowatts)")       
        ## Plot graph 2
        plot(Sub_metering_1 ~ DateTime, type = "l", col = "black", 
             xlab = "", ylab = "Energy sub metering")
        lines(Sub_metering_2 ~ DateTime, type = "l", col = "red")
        lines(Sub_metering_3 ~ DateTime, type = "l", col = "blue")
    })
    legend("topright", lwd = 1, col = c("black", "red", "blue"),
           legend = names(data)[7:9])
    with(data.subset, {
        plot(Voltage ~ DateTime, type = "l")
        plot(Global_reactive_power ~ DateTime, type = "l")
    })
}

## Plot histogram in png file
png(filename = "plot4.png") #standard size is 480 by 480 pixels
plotGraph()
dev.off()
