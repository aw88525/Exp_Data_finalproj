## load the data files
NEI <- readRDS("./Exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./Exdata-data-NEI_data/Source_Classification_Code.rds")
choose_Baltimore <- NEI$fips == "24510"
NEI_Baltimore <- NEI[choose_Baltimore, ]
## which type decrease which type increase in Baltimore?
NEI_Baltimore_bytype <- split(NEI_Baltimore, NEI_Baltimore$type)
sum_Emission_Baltimore_eachtype <- lapply(NEI_Baltimore_bytype, 
                                          function(x){tapply(x$Emissions, x$year, sum)})

#maybe this is a stupid way to convert the above tapply list results to data.frame
newdataFrame <- data.frame(matrix(nrow = 16, ncol = 3))
colnames(newdataFrame) <- c("year", "Emissions", "type")
for(i in seq(1,4)){
  for(j in  seq(1,4)){
    #this is year
    newdataFrame[4*(i-1)+j, 1] <- as.integer(names(sum_Emission_Baltimore_eachtype[[i]][j]))
    newdataFrame[4*(i-1)+j, 2] <- sum_Emission_Baltimore_eachtype[[i]][[j]]
    newdataFrame[4*(i-1)+j, 3] <- names(sum_Emission_Baltimore_eachtype[i])
  }
  
}

library(ggplot2)
png(file = "plot3.png", width = 640, height = 640)
#qplot(year, Emissions, data = newdataFrame, facets = .~type, main = "PM2.5 Emissions in Baltimore")
baseplot <- ggplot(newdataFrame, aes(as.character(year), Emissions, fill = type)) + 
  geom_bar(stat = "identity") + 
  facet_grid(.~type, scales ="free", space = "free") + 
  ggtitle(label = "PM25 Emissions in Baltimore") + theme_bw() 
baseplot
dev.off()
