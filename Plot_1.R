
#Set the working directory
library(dplyr)
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
GblActPwr<-as.numeric(as.character(MyData.f$Global_active_power)) 
hist(GblActPwr,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red",breaks=16)
dev.copy(png, file="plot_1.png",width=480, height=480)
dev.off()

