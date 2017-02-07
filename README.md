# Top 100 Precipitation Events

I downloaded weather station data from 12 of the largest metro areas in the United States from [NOAA](https://www.ncdc.noaa.gov/cdo-web/).

First I'll create a table in SQL server...

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

and populated it.

``` sql
-----------
Insert csv files for each city
-----------
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
----------
Delete header rows
----------
DELETE FROM dbo.NOAARawData
	WHERE Station_Name='STATION_NAME'
```
