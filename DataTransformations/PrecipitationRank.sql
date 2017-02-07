

SELECT top 1000 *
FROM NOAAData

--find earliest date for each station
SELECT StationName, Min(ObservationDate)
FROM NOAAData
Group By StationName


--Precipitation Ranks
SELECT * 
FROM (
		SELECT StationName, ObservationDate, Year(ObservationDate) as [Year], Precipitation, RANK() over(partition by StationName order by precipitation desc) as PrecipitationRank
		FROM NOAAData
		WHERE ObservationDate>='1950-01-01' AND StationName Not in ('DALLAS FAA AIRPORT TX US', 'HOUSTON WILLIAM P HOBBY AIRPORT TX US', 'JFK INTERNATIONAL AIRPORT NY US', 'PHOENIX SKY HARBOR INTERNATIONAL AIRPORT AZ US')
	) as RankedHourlyPrecipitation
WHERE PrecipitationRank <= 100-- and StationName = 'ATLANTA HARTSFIELD INTERNATIONAL AIRPORT GA US'
Order By ObservationDate





SELECT StationName, Cast(Year(ObservationDate) AS varchar)+'-'+Cast(Month(ObservationDate) as varchar)+'-01' as ObservationDate, Isnull(Sum(Precipitation),0) as MonthPrecip
FROM NOAAData
WHERE ObservationDate>='1950-01-01' AND StationName Not in ('DALLAS FAA AIRPORT TX US', 'HOUSTON WILLIAM P HOBBY AIRPORT TX US', 'JFK INTERNATIONAL AIRPORT NY US', 'PHOENIX SKY HARBOR INTERNATIONAL AIRPORT AZ US')
Group By StationName, Cast(Year(ObservationDate) AS varchar)+'-'+Cast(Month(ObservationDate) as varchar)+'-01'
Order By StationName, Cast(Year(ObservationDate) AS varchar)+'-'+Cast(Month(ObservationDate) as varchar)+'-01'



SELECT Cast(Year(ObservationDate) AS varchar)+'-'+Cast(Month(ObservationDate) as varchar)+'-01' as ObservationDate, avg(Precipitation), STDEV(precipitation)
FROM NOAAData
WHERE StationName='PHOENIX SKY HARBOR INTERNATIONAL AIRPORT AZ US' AND Precipitation<>0
Group By  Cast(Year(ObservationDate) AS varchar)+'-'+Cast(Month(ObservationDate) as varchar)+'-01'
Order By STDEV(precipitation)


SELECT * 
FROM NOAAData
WHERE StationName='HOUSTON WILLIAM P HOBBY AIRPORT TX US' AND Year(ObservationDate)=2002 AND Month(ObservationDate)=12