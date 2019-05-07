## load the data files
NEI <- readRDS("./Exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./Exdata-data-NEI_data/Source_Classification_Code.rds")
# emissions from coal combustion-related sources from 1999-2008 in the US
combustion_related <- grepl("comb", SCC$SCC.Level.One, ignore.case = T)
coal_related <- grepl("coal", SCC$SCC.Level.Four, ignore.case = T)
coalcombustion <- (combustion_related & coal_related)
NEI_coalcombustion <- NEI[NEI$SCC %in% SCC$SCC[coalcombustion], ]
NEI_coalcomb_year <- tapply(NEI_coalcombustion$Emissions, NEI_coalcombustion$year, sum, na.rm = TRUE)
png(file = "plot4.png", width = 480, height = 480)
barplot(NEI_coalcomb_year, names.arg = names(NEI_coalcomb_year),  
     xlab = "year", ylab = "PM2.5 Emissions/tons", main = "Change of coal combustion-related PM2.5 Emissions in Baltimore")
dev.off()
