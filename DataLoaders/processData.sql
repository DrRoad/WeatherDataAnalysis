INSERT INTO NOAAData
(
	ObservationDate --datetime --Date
	--, Temperature numeric(3,1) --HOURLYDRYBULBTEMPC
	--, Humidity int  --hourlyrelativehumidity
	--, WindSpeed int  --HOURLYWindSpeed
	--, WindDirection int --HOURLYWindDirection
	--, Pressure numeric (4,2) --HOURLYStationPressure
	, Precipitation --numeric(4,2) --HOURLYPrecip
)
SELECT 
			Cast(Date as datetime)
		--, HOURLYDRYBULBTEMPC
		--, hourlyrelativehumidity
		--, HOURLYWindSpeed
		--, HOURLYWindDirection
		--, HOURLYStationPressure
		, Cast(
				Replace(HOURLYPrecip, 's', '') 
				as numeric(4,2)
			   )
FROM dbo.NOAARawData
WHERE isnumeric(Replace(HOURLYPrecip, 's', ''))=1
