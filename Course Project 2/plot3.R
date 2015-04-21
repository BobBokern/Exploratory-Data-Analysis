## QUESTION 3:
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999–2008 
## for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 
## plotting system to make a plot answer this question.

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

BaltimoreData <-  NEI %>% 
                  filter(fips=='24510') %>%
                  group_by(year, type) %>%
                  summarise(Total_PM2.5 = sum(Emissions))


png(filename = "./plot3.png", width = 480, height = 480)
m <- qplot(year,Total_PM2.5,data=BaltimoreData,main='Baltimore City: Total emission in tonnes per Year per type of source',  facets  =	.	~	type,xlim=c(1999,2008))
q<-m + scale_x_continuous(breaks=c(1999,2002,2005,2008))
q + theme(axis.text.x = element_text(angle = 90, hjust = 1))
dev.off()