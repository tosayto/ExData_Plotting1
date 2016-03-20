#Author:tosayto
#Date:2016/03/20
#Plot 4

#Dataset:Electric Power Consumption
#Estimated data size = 2,075,259(rows) * 9 (columns) * 8 (bytes) / 2^30 = 1.073 GB
#Load Data
Consumptiondata<-read.table(file="household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", stringsAsFactors = FALSE)
#dim(data)
#add column DateConv as Date conversion of Date column to Dataset
Consumptiondata$DateConv <- as.Date(as.Date( as.character(Consumptiondata$Date), "%d/%m/%Y"), format = "%Y-%m-%d")

#subset only tow days from dataset
twoDaysConsumption <- Consumptiondata[(Consumptiondata$DateConv == as.Date("2007-02-01"))|(Consumptiondata$DateConv == as.Date("2007-02-02")),] 
#add libray data.table
library(data.table)
#convert data.frame to data.table
dt <- data.table(twoDaysConsumption)
#add new column called: dateTimeConv with concatinating DateConv and Time columns
dt[, dateTimeConv := paste(DateConv,Time) ]
#add new column dataTimePOSIXct (with converting dateTimeConv column to POSIXct datetime type) 
dt[, dateTimePOSIXct := as.POSIXct(dateTimeConv)]

#reset to default configuration
dev.off()
par(mfrow= c(1,1))
Sys.setlocale("LC_TIME", "English")
#By default, the graphs are 480x480 pixels in size, at a resolution of 72 dpi (6.66x6.66 inches).
#Plot4
png(file="plot4.png")
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(dt, plot(dateTimePOSIXct, Global_active_power, type="l",xlab = "", ylab = "Global Active Power" ))

with(dt, plot(dateTimePOSIXct, Voltage, type="l",xlab = "datetime", ylab = "Voltage" ))

with(dt, plot(dateTimePOSIXct, Sub_metering_1, type="l",xlab = "", ylab = "Energy Sub metering" ))
with(dt, lines(dateTimePOSIXct, Sub_metering_2, col="red"))
with(dt, lines(dateTimePOSIXct, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1,1),col=c("black","red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(dt, plot(dateTimePOSIXct, Global_reactive_power, type="l",xlab = "datetime" ))

dev.off()