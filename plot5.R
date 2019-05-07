## load the data files
NEI <- readRDS("./Exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./Exdata-data-NEI_data/Source_Classification_Code.rds")
vehicle_related <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = T)
new_NEI = NEI[NEI$SCC %in% SCC$SCC[vehicle_related], ]
#motor vehicle sources changed from 1999-2008 in Baltimore
new_NEI_Baltimore_vehicle <- new_NEI[new_NEI$fips == "24510", ]
new_NEI_Baltimore_veh_year <- tapply(new_NEI_Baltimore_vehicle$Emissions, 
                                     new_NEI_Baltimore_vehicle$year, sum)
png(file = "plot5.png", width = 480, height = 480)
barplot(names.arg = names(new_NEI_Baltimore_veh_year), height = new_NEI_Baltimore_veh_year,
     xlab = "year", ylab = "PM2.5 Emissions/tons", 
     main = "Baltimore city PM25 Emissions from motor vehicle sources")
dev.off()
