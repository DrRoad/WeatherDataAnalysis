BULK INSERT dbo.NOAARawData
    FROM 'C:\Sara\SaraGitHub\WeatherDataAnalysis\RawDataFiles\SanFranciscoWeatherData.csv'
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
	WHERE Station_Name='Station_Name'

	SELECT top 10 *
	FROM dbo.NOAADATA

