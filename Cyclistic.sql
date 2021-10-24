--Combining All Tables
SELECT * 
FROM Test..Divvy_Trips_2020_Q1
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2020_04
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2020_05
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2020_06
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2020_07
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2020_08
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2020_09
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2020_10
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2020_11
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2020_12
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2021_01
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2021_02
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2021_03
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2021_04
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2021_05
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2021_06
UNION ALL
SELECT * 
FROM Test..Divvy_Trips_2021_07

--Exported the data to a New Table
--Opening the Exported New Table

SELECT *
FROM Divvy_trips..Trips

--Cleaning
--Total Data Present in the Final Dataset - 6422279

SELECT COUNT(*) AS Current_Data
FROM Divvy_trips..Trips


--Finding no. Annual Members - 3713540 ...64,22,278

SELECT COUNT(*) AS member_no
FROM Divvy_trips..Trips
WHERE member_casual='member'

--Finding no. Casual Members - 2708738

SELECT COUNT(*) AS casual_no
FROM Divvy_trips..Trips
WHERE member_casual='casual'

--Junk Data

SELECT * 
FROM Divvy_trips..Trips
WHERE member_casual <> 'casual' AND member_casual <> 'member'

--Deleting the junk row

DELETE
FROM Divvy_trips..Trips
WHERE member_casual <> 'casual' AND member_casual <> 'member'

--Checking again for junk Data

SELECT *
FROM Divvy_trips..Trips
WHERE member_casual <> 'casual' AND member_casual <> 'member'

SELECT COUNT(*) AS Current_Data
FROM Divvy_trips..Trips

--Current_Data = 6422278 is right now as (3713540 + 2708738)= 6422278

--Creating Duration Column

SELECT Ride_id,cast(CONVERT(varchar, started_at, 113) as datetime) as start_date,started_at
FROM Divvy_trips..Trips 
WHERE ISDATE(started_at) = 1

--Filter the Invalid Date for Convertion of Date Data type

SELECT Ride_id,rideable_type,cast(CONVERT(varchar, started_at, 113) as datetime) as start_date,cast(CONVERT(varchar, ended_at, 103) as datetime)  as end_date,member_casual
FROM Divvy_trips..Trips 
WHERE ISDATE(started_at) = 1 AND ISDATE(ended_at) = 1

--Checking the Date Accuracy

SELECT ISDATE(started_at), started_at
FROM Divvy_trips..Trips 


--Changing Data Type to Date in a New Table

SELECT *
FROM Divvy_trips..New_Trips 

ALTER TABLE Divvy_trips..New_Trips
ALTER COLUMN start_date DATETIME

ALTER TABLE Divvy_trips..New_Trips
ALTER COLUMN end_date DATETIME

--Duration Column 

SELECT DATEDIFF_BIG( MINUTE , start_date , end_date) AS duration, start_date,end_date
FROM Divvy_trips..New_Trips
ORDER BY 1

--Cleaned Table
WITH Trip_CTE (Ride_id,rideable_type, start_date, end_date, duration, member_casual) 
AS
(
SELECT Ride_id,rideable_type, start_date, end_date,DATEDIFF_BIG( MINUTE , start_date , end_date) AS duration, member_casual
FROM Divvy_trips..New_Trips
)
SELECT * 
FROM Trip_CTE
WHERE duration >= 0 
ORDER BY 5

--Analysis
--Total User using different bike types
WITH Trip_CTE (Ride_id,rideable_type, start_date, end_date, duration, member_casual) 
AS
(
SELECT Ride_id,rideable_type, start_date, end_date,DATEDIFF_BIG( MINUTE , start_date , end_date) AS duration, member_casual
FROM Divvy_trips..New_Trips
)
SELECT rideable_type,COUNT(rideable_type) AS Total_User_Present
FROM Trip_CTE
WHERE duration >= 0 
GROUP BY rideable_type
ORDER BY 2 DESC

--Total New Riders / Total Riders
WITH Trip_CTE (Ride_id,rideable_type, start_date, end_date, duration, member_casual) 
AS
(
SELECT Ride_id,rideable_type, start_date, end_date,DATEDIFF_BIG( MINUTE , start_date , end_date) AS duration, member_casual
FROM Divvy_trips..New_Trips
)
SELECT COUNT(DISTINCT(ride_id)) as New_riders,COUNT(ride_id) as Total_riders
FROM Trip_CTE
WHERE duration >= 0 

--Total Annual Members and Casual Members
WITH Trip_CTE (Ride_id,rideable_type, start_date, end_date, duration, member_casual) 
AS
(
SELECT Ride_id,rideable_type, start_date, end_date,DATEDIFF_BIG( MINUTE , start_date , end_date) AS duration, member_casual
FROM Divvy_trips..New_Trips
)
SELECT member_casual AS Membership_Type,COUNT(member_casual) as members
FROM Trip_CTE
WHERE duration >= 0 
GROUP BY member_casual

--Average Duration of Subscription
WITH Trip_CTE (Ride_id,rideable_type, start_date, end_date, duration, member_casual) 
AS
(
SELECT Ride_id,rideable_type, start_date, end_date,DATEDIFF_BIG( MINUTE , start_date , end_date) AS duration, member_casual
FROM Divvy_trips..New_Trips
)
SELECT member_casual AS Membership_Type,AVG(duration) as Average_duration
FROM Trip_CTE
WHERE duration >= 0 
GROUP BY member_casual

--Maximum Duration of Subscription
WITH Trip_CTE (Ride_id,rideable_type, start_date, end_date, duration, member_casual) 
AS
(
SELECT Ride_id,rideable_type, start_date, end_date,DATEDIFF_BIG( MINUTE , start_date , end_date) AS duration, member_casual
FROM Divvy_trips..New_Trips
)
SELECT member_casual AS Membership_Type,Max(duration) as Maximum_duration
FROM Trip_CTE
WHERE duration >= 0 
GROUP BY member_casual

--Minimum Duration of Subscription
WITH Trip_CTE (Ride_id,rideable_type, start_date, end_date, duration, member_casual) 
AS
(
SELECT Ride_id,rideable_type, start_date, end_date,DATEDIFF_BIG( MINUTE , start_date , end_date) AS duration, member_casual
FROM Divvy_trips..New_Trips
)
SELECT member_casual AS Membership_Type,Min(duration) as Minimum_duration
FROM Trip_CTE
WHERE duration >= 0 
GROUP BY member_casual
