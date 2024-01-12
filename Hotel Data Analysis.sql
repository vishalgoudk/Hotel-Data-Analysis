 
-- To fetch data to view from the tables

select * from dbo.['2018$']
select * from dbo.['2019$']
select * from dbo.['2020$']


-- Combining the Data

-- To combine the data from the three tables, we simply use the UNION operator among these commands.

select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$']


-- Exploratory Data Analysis (EDA)

-- we will first create a single temporary table hotels that combines all the data using following code for easier access and analysis.

with hotel as
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$']


-- Now, we are going to apply EDA on the data and try answer the following questions.

-- 1. Is our hotel revenue growing yearly?

select 
  (stays_in_week_nights + stays_in_weekend_nights) * adr
  as revenue from hotels


-- Let’s bring another column arrival_date_year from the data and then calculate the sum of revenue while grouping the data by year.

select 
arrival_date_year
sum((stays_in_week_nights + stays_in_weekend_nights) * adr)
as revenue from hotels group by arrival_date_year

-- We can also determine the revenue trend by hotel type by grouping the data by hotel and then seeing which hotels have generated the most revenue.


select 
arrival_date_year, hotel,
sum((stays_in_week_nights + stays_in_weekend_nights) * adr)
as revenue from hotels group by arrival_date_year, hotel


-- 2. Should we increase our parking lot size?


select
arrival_date_year, hotel,
sum((stays_in_week_nights + stays_in_weekend _nights) * adr) as renenue,
concat (round((sum(required_car_parking_spaces)/sum(stays_in_week_nights +
stays_in_weekend_nights)) * 100, 2), '%') as parking_percentage
from hotels group by arrival_date_year, hotel

-- we will perform two left join queries on the data.

with hotels as(
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select * from hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal
    

-- 3. What trends can we see in the data?

-- created some visuals using Power BI that show some possible trends. Here are a few of them:

-- 1. Revenue increased from 2018 to 2019, but it began to decrease from 2019 to 2020.
-- 2. The average daily rate (ADR) has increased from 2019 to 2020, from $99.53 to $104.47.
-- 3. Total number of nights booked by customers decreased from 2019 to 2020.
-- 4. The discount percentage offered by the hotel has increased from 2019 to 2020 to attract more customers.
