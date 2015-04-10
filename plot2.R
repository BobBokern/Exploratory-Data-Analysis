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

png(filename = "./plot2.png", width = 480, height = 480)
plot(TimeGlobalActivePower[,"Global_active_power"],type='l',xaxt = "n",xlab="",ylab="Global Active Power (kilowatts)")

firstHalfIndex  <- dim(TimeGlobalActivePower)[1]/2
secondHalfIndex <- dim(TimeGlobalActivePower)[1]
axis(1, c(0,firstHalfIndex,secondHalfIndex), c("Thu","Fri","Sat"))
dev.off()


