library(dplyr)

precipData <- read.csv(".\\PrecipitationRankApp\\PrecipitationRankApp\\RankPrecip.csv", stringsAsFactors = FALSE)

library(ggplot2)

ggplot(precipData, aes(x=Year, y=Precipitation, color=StationName)) + geom_point() + theme(axis.ticks.x = element_blank(), axis.ticks.y = element_blank(), panel.background = element_rect(fill="white"), legend.position = "bottom", legend.background = element_blank(), legend.key = element_blank()) + guides(colour = guide_legend(ncol = 1)) + xlim(1950,2016)



p <- ggplot(precipData, aes(x=ObservationDate, y=Precipitation, color=StationName)) + geom_point() + theme(axis.ticks.x = element_blank(), axis.ticks.y = element_blank(), axis.text.x = element_blank(),panel.background = element_rect(fill="white"), legend.position = "bottom", legend.background = element_blank()) + scale_fill_manual(labels=c("Atlanta" ,"Boston", "Chicago" ,"Detroit","Los Angeles","Miami", "Philedelphia",  "San Francisco", "DC"))


breaks=c("ATLANTA HARTSFIELD INTERNATIONAL AIRPORT GA US","BOSTON MA US","CHICAGO MIDWAY AIRPORT IL US","DETROIT CITY AIRPORT MI US", "LOS ANGELES INTERNATIONAL AIRPORT CA US","MIAMI INTERNATIONAL AIRPORT FL US","PHILADELPHIA INTERNATIONAL AIRPORT PA US","SAN FRANCISCO INTERNATIONAL AIRPORT CA US","WASHINGTON REAGAN NATIONAL AIRPORT VA US"), 
