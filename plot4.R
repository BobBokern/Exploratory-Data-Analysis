if (!require("dplyr")) {
  install.packages("dplyr")
}

library('dplyr')
data <- as.data.frame(read.table("C:/Users/Bob/Desktop/household_power_consumption.txt",sep=";",header=TRUE,as.is = TRUE),stringsAsFactors = FALSE)

febFirst  <- as.Date("01/02/2007","%d/%m/%Y")
febSecond <- as.Date("02/02/2007","%d/%m/%Y")

test <- as.Date("16/12/2006","%d/%m/%Y")

dataNew <- data %>% 
  mutate(Date_new = as.Date(data[,1],"%d/%m/%Y"))  %>%
  filter(Date_new==febFirst| Date_new==febSecond)


TimeGlobalActivePower <- dataNew[,c("Time","Global_active_power")]
TimeGlobalReactivePower <- dataNew[,c("Time","Global_reactive_power")]
TimeVoltage           <- dataNew[,c("Time","Voltage")]
Sub1 <- dataNew[,c("Time","Sub_metering_1")]
Sub2 <- dataNew[,c("Time","Sub_metering_2")]
Sub3 <- dataNew[,c("Time","Sub_metering_3")]

png(filename = "./plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

firstHalfIndex  <- dim(dataNew)[1]/2
secondHalfIndex <- dim(dataNew)[1]

plot(TimeGlobalActivePower[,"Global_active_power"],type='l',xaxt = "n",xlab="",ylab="Global Active Power (kilowatts)")
axis(1, c(0,firstHalfIndex,secondHalfIndex), c("Thu","Fri","Sat"))

plot(TimeVoltage[,"Voltage"],type='l',xaxt = "n",xlab="datetime",ylab="Voltage")
axis(1, c(0,firstHalfIndex,secondHalfIndex), c("Thu","Fri","Sat"))

plot(Sub1[,"Sub_metering_1"],type='l',xaxt = "n",xlab="",ylab="Energy sub metering")
lines(Sub2[,"Sub_metering_2"],col='red')
lines(Sub3[,"Sub_metering_3"],col='blue')
axis(1, c(0,firstHalfIndex,secondHalfIndex), c("Thu","Fri","Sat"))
legend("topright", lwd=1,bty = "n",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))


legend("topright", bty = "n", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

plot(TimeGlobalReactivePower[,"Global_reactive_power"],type='l',xaxt = "n",xlab="",ylab="Global_reactive_power")
axis(1, c(0,firstHalfIndex,secondHalfIndex), c("Thu","Fri","Sat"))

dev.off()
