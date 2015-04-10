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

GlobalActivePower <- as.numeric(dataNew[,"Global_active_power"])

png(filename = "./plot1.png", width = 480, height = 480)
hist(GlobalActivePower,main='Global Active Power',ylab='Frequency', xlab='Global Active Power (kilowatts)' ,col = 'red')
dev.off()