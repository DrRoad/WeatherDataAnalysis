# Greatest 100 Hourly Precipitation Events

I downloaded weather station data from 12 of the largest metro areas in the United States from [NOAA](https://www.ncdc.noaa.gov/cdo-web/) which provides csv files for each weather station.

First I created a table 'NOAARawData' in SQL server...

``` sql
CREATE TABLE NOAARawData
(
[STATION] varchar(max),
[STATION_NAME] varchar(max),
[ELEVATION] varchar(max),
[LATITUDE] varchar(max),
[LONGITUDE] varchar(max),
[DATE] varchar(max),
[REPORTTPYE] varchar(max),
[HOURLYSKYCONDITIONS] varchar(max),
[HOURLYVISIBILITY] varchar(max),
[HOURLYPRSENTWEATHERTYPE] varchar(max),
[HOURLYDRYBULBTEMPF] varchar(max),
[HOURLYDRYBULBTEMPC] varchar(max),
[HOURLYWETBULBTEMPF] varchar(max),
[HOURLYWETBULBTEMPC] varchar(max),
[HOURLYDewPointTempF] varchar(max),
[HOURLYDewPointTempC] varchar(max),
[HOURLYRelativeHumidity] varchar(max),
[HOURLYWindSpeed] varchar(max),
[HOURLYWindDirection] varchar(max),
[HOURLYWindGustSpeed] varchar(max),
[HOURLYStationPressure] varchar(max),
[HOURLYPressureTendency] varchar(max),
[HOURLYPressureChange] varchar(max),
[HOURLYSeaLevelPressure] varchar(max),
[HOURLYPrecip] varchar(max),
[HOURLYAltimeterSetting] varchar(max),
[DAILYMaximumDryBulbTemp] varchar(max),
[DAILYMinimumDryBulbTemp] varchar(max),
[DAILYAverageDryBulbTemp] varchar(max),
[DAILYDeptFromNormalAverageTemp] varchar(max),
[DAILYAverageRelativeHumidity] varchar(max),
[DAILYAverageDewPointTemp] varchar(max),
[DAILYAverageWetBulbTemp] varchar(max),
[DAILYHeatingDegreeDays] varchar(max),
[DAILYCoolingDegreeDays] varchar(max),
[DAILYSunrise] varchar(max),
[DAILYSunset] varchar(max),
[DAILYWeather] varchar(max),
[DAILYPrecip] varchar(max),
[DAILYSnowfall] varchar(max),
[DAILYSnowDepth] varchar(max),
[DAILYAverageStationPressure] varchar(max),
[DAILYAverageSeaLevelPressure] varchar(max),
[DAILYAverageWindSpeed] varchar(max),
[DAILYPeakWindSpeed] varchar(max),
[PeakWindDirection] varchar(max),
[DAILYSustainedWindSpeed] varchar(max),
[DAILYSustainedWindDirection] varchar(max),
[MonthlyMaximumTemp] varchar(max),
[MonthlyMinimumTemp] varchar(max),
[MonthlyMeanTemp] varchar(max),
[MonthlyAverageRH] varchar(max),
[MonthlyDewpointTemp] varchar(max),
[MonthlyWetBulbTemp] varchar(max),
[MonthlyAvgHeatingDegreeDays] varchar(max),
[MonthlyAvgCoolingDegreeDays] varchar(max),
[MonthlyStationPressure] varchar(max),
[MonthlySeaLevelPressure] varchar(max),
[MonthlyAverageWindSpeed] varchar(max),
[MonthlyTotalSnowfall] varchar(max),
[MonthlyDeptFromNormalMaximumTemp] varchar(max),
[MonthlyDeptFromNormalMinimumTemp] varchar(max),
[MonthlyDeptFromNormalAverageTemp] varchar(max),
[MonthlyDeptFromNormalPrecip] varchar(max),
[MonthlyTotalLiquidPrecip] varchar(max),
[MonthlyGreatestPrecip] varchar(max),
[MonthlyGreatestPrecipDate] varchar(max),
[MonthlyGreatestSnowfall] varchar(max),
[MonthlyGreatestSnowfallDate] varchar(max),
[MonthlyGreatestSnowDepth] varchar(max),
[MonthlyGreatestSnowDepthDate] varchar(max),
[MonthlyDaysWithGT90Temp] varchar(max),
[MonthlyDaysWithLT32Temp] varchar(max),
[MonthlyDaysWithGT32Temp] varchar(max),
[MonthlyDaysWithLT0Temp] varchar(max),
[MonthlyDaysWithGT001Precip] varchar(max),
[MonthlyDaysWithGT010Precip] varchar(max),
[MonthlyDaysWithGT1Snow] varchar(max),
[MonthlyMaxSeaLevelPressureValue] varchar(max),
[MonthlyMaxSeaLevelPressureDate] varchar(max),
[MonthlyMaxSeaLevelPressureTime] varchar(max),
[MonthlyMinSeaLevelPressureValue] varchar(max),
[MonthlyMinSeaLevelPressureDate] varchar(max),
[MonthlyMinSeaLevelPressureTime] varchar(max),
[MonthlyTotalHeatingDegreeDays] varchar(max),
[MonthlyTotalCoolingDegreeDays] varchar(max),
[MonthlyDeptFromNormalHeatingDD] varchar(max),
[MonthlyDeptFromNormalCoolingDD] varchar(max),
[MonthlyTotalSeasonToDateHeatingDD] varchar(max),
[MonthlyTotalSeasonToDateCoolingDD] varchar(max)
)
```

and populated it with data from each weather station.

``` sql
--------------------------------
--Insert csv files for each city
--------------------------------
BULK INSERT dbo.NOAARawData
    FROM 'C:\Sara\SaraGitHub\WeatherDataAnalysis\RawDataFiles\PhoenixWeatherData.csv'
    WITH
    (
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    ERRORFILE = 'C:\Sara\SaraGitHub\WeatherDataAnalysis\RawDataFiles\ErrorRows.csv',
    TABLOCK
    )
--------------------
--Delete header rows
--------------------
DELETE FROM dbo.NOAARawData
	WHERE Station_Name='STATION_NAME'
```

Then I pulled a small subset of variables that may be interesting to look at into another table: 
* StationName
* ObservationDate
* HourlyTemperature
* HourlyHumidity
* HourlyWindSpeed
* HourlyWindDirection
* HourlyPressure
* HourlyPrecipitation

First I made a table 'NOAAData'...

``` sql
Create Table NOAAData
(
	StationName varchar(max)
	, ObservationDate datetime --Date
	, Temperature numeric(3,1) --HOURLYDRYBULBTEMPC
	, Humidity int  --hourlyrelativehumidity
	, WindSpeed int  --HOURLYWindSpeed
	, WindDirection int --HOURLYWindDirection
	, Pressure numeric (4,2) --HOURLYStationPressure
	, Precipitation numeric(4,2) --HOURLYPrecip
)

INSERT INTO NOAAData
(
	StationName
	, ObservationDate --datetime --Date
	--, Temperature --numeric(3,1) --HOURLYDRYBULBTEMPC
	--, Humidity --int  --hourlyrelativehumidity
	--, WindSpeed --int  --HOURLYWindSpeed
	--, WindDirection --int --HOURLYWindDirection
	--, Pressure --numeric (4,2) --HOURLYStationPressure
	--, Precipitation --numeric(4,2) --HOURLYPrecip
)

SELECT 
		STATION_NAME
		 ,	Cast(Date as datetime)
		--, HOURLYDRYBULBTEMPC
		--, hourlyrelativehumidity
		--, HOURLYWindSpeed
		--, HOURLYWindDirection
		--, HOURLYStationPressure
		--, HOURLYPrecip
FROM dbo.NOAARawData

```

and populated it with data from NOAARawData along with some cleaning.

``` sql
-------------------
--Add precipitation
-------------------

UPDATE NOAAData
Set NOAAData.Precipitation = Cast(
								Replace(NOAARawData.HOURLYPrecip, 's', '') 
										as numeric(4,2)
								)
FROM NOAARawData
	JOIN NOAAData
		ON NOAARawData.STATION_NAME = NOAAData.StationName
		AND NOAARawData.Date = NOAAData.ObservationDate
WHERE isnumeric(Replace(HOURLYPrecip, 's', ''))=1

--------------
--Add pressure
--------------

UPDATE NOAAData
Set NOAAData.Pressure = Cast(
								Replace(NOAARawData.HOURLYStationPressure, 's', '') 
										as numeric(4,2)
								)
FROM NOAARawData
	JOIN NOAAData
		ON NOAARawData.STATION_NAME = NOAAData.StationName
		AND NOAARawData.Date = NOAAData.ObservationDate
WHERE isnumeric(Replace(HOURLYStationPressure, 's', ''))=1

```

With increased global temperatures, we expect for more extreme weather events. I ranked the HourlyPrecipitation data for each city and selected the top 100 hourly precipitation events.

``` sql
-------------------------------------
--find earliest date for each station
-------------------------------------
SELECT StationName, Min(ObservationDate)
FROM NOAAData
Group By StationName

-----------------------------
--Precipitation Ranks top 100
-----------------------------
SELECT * 
FROM (
		SELECT StationName, ObservationDate, Year(ObservationDate) as [Year], Precipitation, RANK() over(partition by StationName order by precipitation desc) as PrecipitationRank
		FROM NOAAData
		WHERE ObservationDate>='1950-01-01' AND StationName Not in ('DALLAS FAA AIRPORT TX US', 'HOUSTON WILLIAM P HOBBY AIRPORT TX US', 'JFK INTERNATIONAL AIRPORT NY US', 'PHOENIX SKY HARBOR INTERNATIONAL AIRPORT AZ US')
	) as RankedHourlyPrecipitation
WHERE PrecipitationRank <= 100
Order By ObservationDate

```

I put the data into a very basic RShiny app to visualize when those top 100 hourly precipitation events happened for each city. View the app [here](https://skammlade.shinyapps.io/precipitationrankapp/).

``` r
# RShiny web app
library(shiny)
library(ggplot2)
library(dplyr)

precipData <- read.csv("RankPrecip.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
        titlePanel("100 Greatest Hourly Precipitation Events"),
        sidebarLayout(
          sidebarPanel(
            checkboxGroupInput(inputId = "StationName", 
                               label = "Select Cities:",
                               choices = c("Atlanta" = "ATLANTA HARTSFIELD INTERNATIONAL AIRPORT GA US" ,
                                           "Boston" = "BOSTON MA US",
                                           "Chicago" = "CHICAGO MIDWAY AIRPORT IL US",
                                           "Detroit" = "DETROIT CITY AIRPORT MI US",
                                           "Los Angeles" = "LOS ANGELES INTERNATIONAL AIRPORT CA US",
                                           "Miami" = "MIAMI INTERNATIONAL AIRPORT FL US",
                                           "Philedelphia" = "PHILADELPHIA INTERNATIONAL AIRPORT PA US",
                                           "San Francisco" = "SAN FRANCISCO INTERNATIONAL AIRPORT CA US",
                                           "DC" = "WASHINGTON REAGAN NATIONAL AIRPORT VA US"))),
          mainPanel(
            plotOutput(outputId = "coolplot",
                       height = "400px")
          )
        )
      )

server <- function(input, output, session) {
  filtered <- reactive({
    print(eval(input$StationName))
    precipData %>% 
      filter(StationName %in% eval(input$StationName))
  })
  
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(x=Year, y=Precipitation, color=StationName)) + geom_point(shape=21, size=3) + theme(axis.ticks.x = element_blank(), axis.ticks.y = element_blank(), axis.title.x = element_blank(), panel.background = element_rect(fill="white"), legend.position = "right", legend.background = element_blank(), legend.key = element_blank()) + guides(colour = guide_legend(ncol = 1)) + xlim(1950,2016)
    
  })
  
}

shinyApp(ui = ui, server = server)

```

At first glance it sure looks like there are more extreme precipitation events after 2000.
![Screenshot](https://raw.githubusercontent.com/skammlade/WeatherDataAnalysis/master/RShinyCapture.JPG)


I took a closer look at some of those data points.

``` sql
--Precipitation Ranks
SELECT * 
FROM (
		SELECT StationName, ObservationDate, Year(ObservationDate) as [Year], Precipitation, RANK() over(partition by StationName order by precipitation desc) as PrecipitationRank
		FROM NOAAData
		WHERE ObservationDate>='1950-01-01' AND StationName Not in ('DALLAS FAA AIRPORT TX US', 'HOUSTON WILLIAM P HOBBY AIRPORT TX US', 'JFK INTERNATIONAL AIRPORT NY US', 'PHOENIX SKY HARBOR INTERNATIONAL AIRPORT AZ US')
	) as RankedHourlyPrecipitation
WHERE PrecipitationRank <= 100 and StationName = 'BOSTON MA US'
Order By ObservationDate

```

While it certainly fits the expected narrative, those data points are likely measurement errors.

![Screenshot](https://raw.githubusercontent.com/skammlade/WeatherDataAnalysis/master/SQLOutputCapture.JPG)

Back to the data for more cleaning!