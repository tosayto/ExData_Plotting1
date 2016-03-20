#Author:tosayto
#Date:2016/03/20
#Plot 2

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
#Plot2
with(dt, plot(dateTimePOSIXct, Global_active_power, type="l",xlab = "", ylab = "Global Active Power (kilowatts)" ))
#copy plot to a file
dev.copy(png,"plot2.png")
dev.off()
