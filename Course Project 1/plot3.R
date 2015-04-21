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

Sub1 <- dataNew[,c("Time","Sub_metering_1")]
Sub2 <- dataNew[,c("Time","Sub_metering_2")]
Sub3 <- dataNew[,c("Time","Sub_metering_3")]

png(filename = "./plot3.png", width = 480, height = 480)
plot(Sub1[,"Sub_metering_1"],type='l',xaxt = "n",xlab="",ylab="Energy sub metering")
lines(Sub2[,"Sub_metering_2"],col='red')
lines(Sub3[,"Sub_metering_3"],col='blue')


firstHalfIndex  <- dim(TimeGlobalActivePower)[1]/2
secondHalfIndex <- dim(TimeGlobalActivePower)[1]
axis(1, c(0,firstHalfIndex,secondHalfIndex), c("Thu","Fri","Sat"))


legend("topright", lty=1,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
dev.off()

