#Author:tosayto
#Date:2016/03/20
#Plot 1

#Dataset:Electric Power Consumption
#Estimated data size = 2,075,259(rows) * 9 (columns) * 8 (bytes) / 2^30 = 1.073 GB
#Load Data
Consumptiondata<-read.table(file="household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", stringsAsFactors = FALSE)
#dim(data)
#add column DateConv as Date conversion of Date column to Dataset
Consumptiondata$DateConv <- as.Date( as.character(Consumptiondata$Date), "%d/%m/%Y")

#subset only tow days from dataset
twoDaysConsumption <- Consumptiondata[(Consumptiondata$DateConv == as.Date("2007-02-01"))|(Consumptiondata$DateConv == as.Date("2007-02-02")),] 
#reset to default configuration
dev.off()
par(mfrow= c(1,1))

#By default, the graphs are 480x480 pixels in size, at a resolution of 72 dpi (6.66x6.66 inches).
#plot the histogram
with(twoDaysConsumption, hist(Global_active_power, main ="Global Active Power", col="red", xlab ="Global Active Power (kilowatts)"))
#copy plot to a file
dev.copy(png,"plot1.png")
dev.off()


