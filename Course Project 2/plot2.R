## QUESTION 2:
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

if (!require("dplyr")) {
  install.packages("dplyr")
}

library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimoreData <-  NEI %>% 
  filter(fips=='24510') %>%
  group_by(year) %>%
  summarise(Total_PM2.5 = sum(Emissions)) %>%
  select(year,Total_PM2.5) 

y <- as.numeric(BaltimoreData[,"Total_PM2.5"]$Total_PM2.5)

png(filename = "./plot2.png", width = 480, height = 480)
plot(y,main='Total PM2.5 emission in tonnes per Year',ylab='total PM2.5 emission in tonnes',type='l' ,xlab='Year',xaxt = "n" ,col = 'red')
mtext("in the Baltimore City, Maryland (fips == 24510)")
axis(1, c(1,2,3,4), c(BaltimoreData[,"year"]$year))
dev.off()