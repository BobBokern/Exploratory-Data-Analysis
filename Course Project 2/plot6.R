## QUESTION 6:
## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California \
## (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?


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

LosAngelesData <-   joinedData %>% 
                    filter(fips=='06037')
                    

motorDataBaltimore <- BaltimoreData[BaltimoreData$SCC %in% MotorVehicleRelatedData$SCC, ]
motorDataLosAngeles <- LosAngelesData[LosAngelesData$SCC %in% MotorVehicleRelatedData$SCC, ]

motorDataBaltimoreSummed <- motorDataBaltimore %>%
                            group_by(year) %>%
                            summarise(TotalEmission = sum(Emissions)) %>%
                            mutate(Location = 'Baltimore')

motorDataLASummed        <- motorDataLosAngeles %>%
                            group_by(year) %>%
                            summarise(TotalEmission = sum(Emissions)) %>%
                            mutate(Location = 'Los Angeles')

allData <- rbind(motorDataBaltimoreSummed,motorDataLASummed)

png(filename = "./plot6.png", width = 480, height = 480)
m <- qplot(year,TotalEmission,data=allData,main='Total emission of motor vehicles in tonnes per Year',  facets  =  .	~	Location,xlim=c(1999,2008))
q<-m + scale_x_continuous(breaks=c(1999,2002,2005,2008))
q + theme(axis.text.x = element_text(angle = 90, hjust = 1))
dev.off()
