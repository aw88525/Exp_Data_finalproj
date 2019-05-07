## load the data files
NEI <- readRDS("./Exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./Exdata-data-NEI_data/Source_Classification_Code.rds")
choose_Baltimore <- NEI$fips == "24510"
NEI_Baltimore <- NEI[choose_Baltimore, ]
sum_Emission_Baltimore <- tapply(NEI_Baltimore$Emissions, NEI_Baltimore$year, sum)
png(file = "plot2.png", width = 480, height = 480)
barplot(height = sum_Emission_Baltimore, names.arg = names(sum_Emission_Baltimore),
     xlab = "year", ylab = "Emissions/ton",
     main = "Total Emissions of PM25 in Baltimore in each year")
dev.off()