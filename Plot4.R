## Loading the required pacakges

library(data.table)
library(datasets)

## Reading in the data using the fread command. This allows for direct subsetting without
## having to store the entire data set

data = fread("household_power_consumption.txt", header=TRUE,sep=";")[Date == "1/2/2007" | Date== "2/2/2007"]

## Changing to Date-Time Type Field

data$datetime = as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")


## Checking for missing values
table(is.na(data[,1]))
table(is.na(data[,2]))
table(is.na(data[,3]))
table(is.na(data[,4]))
table(is.na(data[,5]))
table(is.na(data[,6]))
table(is.na(data[,7]))
table(is.na(data[,8]))
table(is.na(data[,9]))

## Noted that no missing values are present

## Changing data to numeric types as applicable

data$Global_active_power = as.numeric(data$Global_active_power)
data$Global_reactive_power = as.numeric(data$Global_reactive_power)
data$Voltage = as.numeric(data$Voltage)
data$Global_intensity = as.numeric(data$Global_intensity)
data$Sub_metering_1 = as.numeric(data$Sub_metering_1)
data$Sub_metering_2 = as.numeric(data$Sub_metering_2)
data$Sub_metering_3 = as.numeric(data$Sub_metering_3)

## Plotting the Graphs and saving to png file
## NOTE: Tried plotting with transparent backgrond (bg="transparent" in png command).
## However, the results were still displayed as white background. As per documentation
## based on ?png, noted that not all PNG viewers render files with transpernacy correctly.
## Hence plotted with default(white) background. This also ensures better readability


png("plot4.png")
par(mfrow=c(2,2))
plot(data$datetime,data$Global_active_power,xlab="",ylab="Global Active Power",type="l")
plot(data$datetime,data$Voltage,xlab="datetime",ylab="Voltage",type="l")
plot(data$datetime,data$Sub_metering_1,xlab="",ylab= "Energy sub metering",type="n")
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")
lines(data$datetime,data$Sub_metering_1,col="black")
legend("topright",legend= c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),col=c("black","red","blue"),lwd=1,cex=1,bty="n")
plot(data$datetime,data$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
dev.off()
