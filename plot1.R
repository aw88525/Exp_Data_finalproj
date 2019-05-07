## load the data files
NEI <- readRDS("./Exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./Exdata-data-NEI_data/Source_Classification_Code.rds")
## total emissions of pm25 for each year
sum_Emission <- tapply(NEI$Emissions, NEI$year, sum)
png(file = "plot1.png", width = 480, height = 480)
barplot(height = sum_Emission, names.arg = names(sum_Emission), xlab = "year", ylab = "Emissions/ton",
     main = "Total Emissions of PM25 in US in each year")
dev.off()