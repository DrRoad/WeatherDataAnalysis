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

	SELECT DISTINCT Station_Name
	FROM dbo.NOAARawData

	DELETE FROM dbo.NOAARawData
	WHERE Station_Name='STATION_NAME'

	SELECT top 10 *
	FROM dbo.NOAADATA

	SELECT * 
	FROM dbo.NOAARawData
	WHERE
