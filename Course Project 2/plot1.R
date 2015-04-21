if (!require("dplyr")) {
  install.packages("dplyr")
}

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## QUESTION 1:
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

PM2.5_per_Year <- NEI %>%
                  group_by(year) %>%
                  summarise(Total_PM2.5 = sum(Emissions)) %>%
                  select(year,Total_PM2.5)

y <- as.numeric(PM2.5_per_Year[,"Total_PM2.5"]$Total_PM2.5)

png(filename = "./plot1.png", width = 480, height = 480)
plot(y,main='Total PM2.5 emission in tonnes per Year',ylab='total PM2.5 emission in tonnes',type='l' ,xlab='Year',xaxt = "n" ,col = 'red')
axis(1, c(1,2,3,4), c(PM2.5_per_Year[,"year"]$year))
dev.off()


