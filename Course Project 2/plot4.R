## QUESTION 4:
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


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

CoalRelatedData <- SCC[grepl("coal", SCC[,"Short.Name"], ignore.case = TRUE), ]

joinedData <- merge(NEI, CoalRelatedData, by = 'SCC')
joinedDataSummed <- joinedData %>%
                    group_by(year) %>%
                    summarise(TotalEmission = sum(Emissions))


y <- as.numeric(joinedDataSummed[,"TotalEmission"]$TotalEmission)

png(filename = "./plot4.png", width = 480, height = 480)
plot(y,main='Total emission in tonnes from coal combustion-related sources per Year',ylab='total emission in tonnes',type='l' ,xlab='Year',xaxt = "n" ,col = 'red')
axis(1, c(1,2,3,4), c(joinedDataSummed[,"year"]$year))
dev.off()
