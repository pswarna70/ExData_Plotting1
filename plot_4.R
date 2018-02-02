#Set the working directory
library(dplyr)
library(lubridate)

setwd("C:/Users/zps48/Documents/R/DataScience/ExData_Plotting1/Data")
# Read CSV into R
MyData <- read.csv(file="household_power_consumption.txt", header=TRUE, sep=";")
head(MyData)
str(MyData)
#Copy MyData DataFrame to MyData.C
MyData.C<-MyData
#Convert Date Column to Date Variable
MyData.C$Date <- as.Date(MyData.C$Date, "%d/%m/%Y")

#limit the data in MyData.C to two Days - (2007-02-01 & 2007-02-02) using the filter operation
MyData.f <- filter(MyData.C, Date >= "2007-02-01" & Date<="2007-02-02")

#Convert the factor variable to Numeric
MyData.f$Global_active_power <-as.numeric(as.character(MyData.f$Global_active_power)) 
MyData.f$Sub_metering_1 <-as.numeric(as.character(MyData.f$Sub_metering_1)) 
MyData.f$Sub_metering_2 <-as.numeric(as.character(MyData.f$Sub_metering_2))
MyData.f$Sub_metering_3 <-as.numeric(as.character(MyData.f$Sub_metering_3))
MyData.f$Global_reactive_power<-as.numeric(as.character(MyData.f$Global_reactive_power))


MyData.f <- mutate(MyData.f,Date.Time=paste(MyData.f$Date,MyData.f$Time)) 
MyData.f<-mutate(MyData.f,dt=as_datetime(MyData.f$Date.Time))


MyData.f <- select(MyData.f,dt,Global_active_power:Sub_metering_3,Voltage,-Date,-Time,-Date.Time)
str(MyData.f)

par(mfrow = c(2, 2), # 2 x 2 pictures on one plot
    pty = "s") 

plot(MyData.f$dt,MyData.f$Global_active_power,  type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(MyData.f$dt,MyData.f$Voltage,  type="l", xlab = "", ylab = "Voltage")

plot(MyData.f$dt,MyData.f$Sub_metering_1,  type="b", xlab = "", ylab = "Energy sub meetering", col="black")
lines(MyData.f$dt,MyData.f$Sub_metering_2,  type="b", xlab = "", ylab = "Energy sub meetering",col="red")
lines(MyData.f$dt,MyData.f$Sub_metering_3,  type="b", xlab = "", ylab = "Energy sub meetering",col="blue")

plot(MyData.f$dt,MyData.f$Global_reactive_power,  type="l", xlab = "", ylab = "Global reacive power")


dev.copy(png, file="plot_4.png",width=480, height=480)
dev.off()

