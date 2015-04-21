## QUESTION 5:
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


if (!require("dplyr")) {
  install.packages("dplyr")
}

library(dplyr)

if (!require("ggplot2")) {
  install.packages("ggplot2")
}

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

MotorVehicleRelatedData <- SCC[grepl("motor", SCC[,"Short.Name"], ignore.case = TRUE), ]


joinedData <- merge(NEI, MotorVehicleRelatedData, by = 'SCC')


BaltimoreData <-  joinedData %>% 
                        filter(fips=='24510') 

motorData <- BaltimoreData[BaltimoreData$SCC %in% MotorVehicleRelatedData$SCC, ]

motorDataSummed <- motorData %>%
                   group_by(year) %>%
                   summarise(TotalEmission = sum(Emissions))

y <- as.numeric(motorDataSummed[,"TotalEmission"]$TotalEmission)

png(filename = "./plot5.png", width = 480, height = 480)
plot(y,main='Total emission from motor vehicle sources per Year',ylab='total emission in tonnes',type='l' ,xlab='Year',xaxt = "n" ,col = 'red')
axis(1, c(1,2,3,4), c(motorDataSummed[,"year"]$year))
dev.off()
