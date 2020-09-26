library(tidyverse)
library(lubridate)

## Importing data (i saved data as household in my device)

dat <- read.table("household.txt", sep = ";", header = TRUE)

# filtering dates
Data <- dat[dat$Date %in% c("1/2/2007","2/2/2007") ,]

## Plot1
Power <- as.numeric(Data$Global_active_power)
png("plot1.png", width=480, height=480)
hist(Power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

## Plot 2
## Date and Time into Datetime
datetime <- strptime(paste(Data$Date, Data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
Power <- as.numeric(Data$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, Power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

## Plot 3
Metering1 <- as.numeric(Data$Sub_metering_1)
Metering2 <- as.numeric(Data$Sub_metering_2)
Metering3 <- as.numeric(Data$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(datetime, Metering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, Metering2, type="l", col="red")
lines(datetime, Metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

## Plot 4
ReactivePower <- as.numeric(Data$Global_reactive_power)
voltage <- as.numeric(Data$Voltage)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, Power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, Metering1, type="l", ylab="Energy Submetering")
lines(datetime, Metering2, type="l", col="red")
lines(datetime, Metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, ReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
