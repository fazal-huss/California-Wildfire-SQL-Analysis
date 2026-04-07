
USE WildfireDB
  SELECT TOP (1000) [Incident_ID]
      ,[Date]
      ,[Location]
      ,[Area_Burned_Acres]
      ,[Homes_Destroyed]
      ,[Businesses_Destroyed]
      ,[Vehicles_Damaged]
      ,[Injuries]
      ,[Fatalities]
      ,[Estimated_Financial_Loss_Million]
      ,[Cause]
  FROM [WildfireDB].[dbo].[Cal_Wild_Fire]

  EXEC sp_rename 'Cal_Wild_Fire', 'CWF';

  -- ADDING YEAR COL
ALTER TABLE CWF ADD Year INT;

UPDATE CWF
SET Year = YEAR(Date);

SELECT COUNT(*) AS Total_Rows FROM CWF;

-- Total Area Burned
SELECT SUM(Area_Burned_Acres) area_burned
FROM CWF;

-- Avg Financial Loss
SELECT AVG(Estimated_Financial_Loss_Million) est_fin_loss
FROM CWF;

-- Total Fatalities & Injuries
SELECT SUM(Fatalities) as fatalities, SUM(Injuries) as injuries
FROM CWF;

--- GENERAL ANALYSIS ---

-- Total area burned
SELECT SUM(Area_Burned_Acres) AS Total_Area_Burned_in_Acres
FROM CWF;

-- Average financial loss
SELECT ROUND(AVG(Estimated_Financial_Loss_Million),2) AS Avg_Financial_Loss_Million
FROM CWF;

-- Total fatalities and injuries
SELECT 
    SUM(Fatalities) AS Total_Fatalities, 
    SUM(Injuries) AS Total_Injuries
FROM CWF;

-- Top 5 most destructive wildfires (FIXED: DESC added)
SELECT TOP 5 Incident_ID, Location, Estimated_Financial_Loss_Million
FROM CWF
ORDER BY Estimated_Financial_Loss_Million DESC;

--- LOC BASED

-- Location with most wildfires 
SELECT TOP 1 Location, COUNT(*) AS Fire_Count
FROM CWF
GROUP BY Location
ORDER BY Fire_Count DESC;

-- Total damage per location
SELECT 
    Location,
    SUM(Homes_Destroyed) AS Total_Homes_Destroyed,
    SUM(Businesses_Destroyed) AS Total_Businesses_Destroyed,
    SUM(Vehicles_Damaged) AS Total_Vehicles_Damaged
FROM CWF
GROUP BY Location
ORDER BY Total_Homes_Destroyed DESC;

-- Average area burned per wildfire by location
SELECT 
    Location,
    ROUND(AVG(Area_Burned_Acres),2) AS Avg_Area_Burned
FROM CWF
GROUP BY Location
ORDER BY Avg_Area_Burned DESC;

-- Location with highest financial loss
SELECT TOP 1
    Location,
    SUM(Estimated_Financial_Loss_Million) AS Total_Loss
FROM CWF
GROUP BY Location
ORDER BY Total_Loss DESC;


--- COST BASED ANALYSIS ---
-- Most common cause
SELECT TOP 1
    Cause, 
    COUNT(*) AS Occurrences
FROM CWF
GROUP BY Cause
ORDER BY Occurrences DESC;

-- Total financial loss per cause
SELECT 
    Cause,
    ROUND(SUM(Estimated_Financial_Loss_Million),2) AS Total_Loss_Million
FROM CWF
GROUP BY Cause
ORDER BY Total_Loss_Million DESC;

-- Fatalities & injuries by cause
SELECT 
    Cause, 
    SUM(Fatalities) AS Total_Fatalities, 
    SUM(Injuries) AS Total_Injuries
FROM CWF
GROUP BY Cause
ORDER BY Total_Fatalities DESC;


--- YEARLY TRENDS ---

-- Wildfires per year
SELECT 
    Year, 
    COUNT(*) AS Total_Fires
FROM CWF
GROUP BY Year
ORDER BY Year;

-- Total financial loss per year
SELECT 
    Year, 
    ROUND(SUM(Estimated_Financial_Loss_Million),2) AS Total_Loss_Million
FROM CWF
GROUP BY Year
ORDER BY Year;

-- Average area burned per year
SELECT 
    Year, 
    ROUND(AVG(Area_Burned_Acres),2) AS Avg_Area_Burned
FROM CWF
GROUP BY Year
ORDER BY Year;

--- Severity Classification ---
SELECT 
    Incident_ID,
    Location,
    Area_Burned_Acres,
    CASE 
        WHEN Area_Burned_Acres > 50000 THEN 'Severe'
        WHEN Area_Burned_Acres BETWEEN 10000 AND 50000 THEN 'Moderate'
        ELSE 'Low'
    END AS Fire_Severity
FROM CWF;


--- Percentage Contribution by Cause
SELECT 
    Cause,
    SUM(Estimated_Financial_Loss_Million) AS Total_Loss,
    ROUND(
        SUM(Estimated_Financial_Loss_Million) * 100.0 /
        (SELECT SUM(Estimated_Financial_Loss_Million )FROM CWF),
    2) AS Loss_Percentage
FROM CWF
GROUP BY Cause;


--- Cumulative Financial Loss ---
SELECT 
    Year,
    SUM(Estimated_Financial_Loss_Million) AS Yearly_Loss,
    SUM(SUM(Estimated_Financial_Loss_Million)) 
        OVER (ORDER BY Year) AS Running_Total_Loss
FROM CWF
GROUP BY Year;

SELECT 
    Incident_ID,
    Location,
    Estimated_Financial_Loss_Million,
    RANK() OVER (ORDER BY Estimated_Financial_Loss_Million DESC) AS Rank_By_Loss
FROM CWF;

SELECT 
    Location,
    Incident_ID,
    Estimated_Financial_Loss_Million,
    RANK() OVER (PARTITION BY Location ORDER BY Estimated_Financial_Loss_Million DESC) AS Rank_Within_Location
FROM CWF; --ranked wildfires separately within each location

SELECT 
    Year,
    SUM(Estimated_Financial_Loss_Million) AS Yearly_Loss,
    LAG(SUM(Estimated_Financial_Loss_Million)) 
        OVER (ORDER BY Year) AS Previous_Year_Loss
FROM CWF
GROUP BY Year;

-- FIRST_VALUE / LAST_VALUE
SELECT 
    Year,
    SUM(Estimated_Financial_Loss_Million) AS Yearly_Loss,
    FIRST_VALUE(SUM(Estimated_Financial_Loss_Million)) 
        OVER (ORDER BY Year) AS First_Year_Loss
FROM CWF
GROUP BY Year;

---NTILE (BUCKETING DATA)
SELECT 
    Incident_ID,
    Estimated_Financial_Loss_Million,
    NTILE(4) OVER (ORDER BY Estimated_Financial_Loss_Million DESC) AS Quartile
FROM CWF;--I divided wildfires into 4 groups based on financial impact

--- WINDOW AVG (Moving Average)
SELECT 
    Year,
    AVG(Estimated_Financial_Loss_Million) AS Avg_Loss,
    AVG(AVG(Estimated_Financial_Loss_Million)) 
        OVER (ORDER BY Year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Moving_Avg
FROM CWF
GROUP BY Year;--I calculated a moving average to smooth yearly fluctuations.”