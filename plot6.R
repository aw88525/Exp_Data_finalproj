## load the data files
NEI <- readRDS("./Exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./Exdata-data-NEI_data/Source_Classification_Code.rds")
vehicle_related <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = T)
new_NEI = NEI[NEI$SCC %in% SCC$SCC[vehicle_related], ]

#motor vehicle sources changed from 1999-2008 in Baltimore
new_NEI_Baltimore_vehicle <- new_NEI[new_NEI$fips == "24510",]
new_NEI_Baltimore_veh_year <- tapply(new_NEI_Baltimore_vehicle$Emissions, 
                                     new_NEI_Baltimore_vehicle$year, sum)
#Compare emissions
new_NEI_LA_vehicle <- new_NEI[new_NEI$fips == "06037",]
new_NEI_LA_veh_year <- tapply(new_NEI_LA_vehicle$Emissions, 
                              new_NEI_LA_vehicle$year, sum)

datamerged <- c(new_NEI_Baltimore_veh_year, new_NEI_LA_veh_year)
newdataFrame <- data.frame(matrix(nrow = 8, ncol = 3))
colnames(newdataFrame) <- c("year", "Emissions", "city")
for(i in seq(1,8)){
    newdataFrame[i, 1] <- names(datamerged[i])
    newdataFrame[i, 2] <- datamerged[[i]]
    if(i <= 4)
       newdataFrame[i, 3] <- "Baltimore City"
    else
       newdataFrame[i, 3] <- "Los Angeles County"
  
}

png(file = "plot6.png", width = 480, height = 480)

ggplot(newdataFrame, aes(year, Emissions, fill = city)) + 
  geom_bar(stat = "identity") + 
  facet_grid(.~city) + ggtitle("Emissions from vehicle in Baltimore vs LA")



dev.off()
