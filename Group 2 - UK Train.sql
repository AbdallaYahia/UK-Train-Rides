
-----------------------------------🚄 1. التحليل العام للرحلات | General Trip Analysis

-- 1.1 إجمالي عدد المعاملات - Total Transactions
SELECT COUNT(*) AS total_transactions FROM railway;

-- 1.2 إجمالي الإيرادات - Total Revenue
SELECT SUM(price) AS total_revenue FROM railway;

-- 1.3 أكثر محطات المغادرة تكرارًا - Top Departure Stations
SELECT departure_station, COUNT(*) AS trips
FROM railway
GROUP BY departure_station
ORDER BY trips DESC;

-- 1.4 أكثر محطات الوصول تكرارًا - Top Arrival Destinations
SELECT arrival_destination, COUNT(*) AS trips
FROM railway
GROUP BY arrival_destination
ORDER BY trips DESC;

---1.5 أكثر الرحلات تكرارًا بين المحطات - Most Frequent Station-to-Station Trips
select departure_station,arrival_destination, 
count(*) as [Total transactions] from railway
group by departure_station,arrival_destination
order by count(*) desc

-- 1.6 عدد المسارات بدون تكرار - Unique Routes Count
SELECT 
  COUNT(*) AS unique_route_count
FROM (
  SELECT DISTINCT 
    Departure_Station, 
    Arrival_Destination
  FROM railway
) AS distinct_routes;

-- 1.7 عدد الرحلات التي وصلت في الموعد والملغاة – On Time vs Cancelled Trips

SELECT
  SUM(CASE WHEN Journey_Status = 'On Time' THEN 1 ELSE 0 END)      AS on_time_trips,
  SUM(CASE WHEN Journey_Status = 'Cancelled' THEN 1 ELSE 0 END)    AS cancelled_trips
FROM railway;

-- 1.8 متوسط سعر التذكرة - Average Ticket Price
SELECT 
  ROUND(AVG(Price), 2) AS avg_ticket_price
FROM railway;

-- 1.9 الإيرادات حسب محطة الانطلاق - Revenue by Departure Station
SELECT 
  Departure_Station AS station,
  ROUND(SUM(Price), 2) AS total_revenue
FROM railway
GROUP BY Departure_Station
ORDER BY total_revenue DESC;

-- 1.10 الإيرادات حسب محطة الوصول - Revenue by Arrival Station
SELECT 
  Arrival_Destination AS station,
  ROUND(SUM(Price), 2) AS total_revenue
FROM railway
GROUP BY Arrival_Destination
ORDER BY total_revenue DESC;



-------------------------------------⏱️ 2. التحليل الزمني والتأخيرات | Timing & Delay Analysis

-- 2.1 عدد الرحلات المتأخرة - Delayed Trips Count
SELECT COUNT(*) AS delayed_trips
FROM railway
WHERE journey_status = 'Delayed';

-- 2.2 متوسط مدة التأخير بالدقائق - Average Delay (Minutes)
SELECT 
  AVG(DATEDIFF(MINUTE, arrival_time, actual_arrival_time)) AS avg_delay_minutes
FROM railway
WHERE journey_status = 'Delayed' AND actual_arrival_time IS NOT NULL;

-- 2.3 أسباب التأخير - Reasons for Delay
SELECT reason_for_delay, COUNT(*) AS delay_count
FROM railway
WHERE journey_status = 'Delayed'
GROUP BY reason_for_delay
ORDER BY delay_count DESC;

-- 2.4 أكثر 5 محطات مغادرة تسبب تأخير - Top 5 Delaying Departure Stations
SELECT TOP 5 
  Departure_Station, 
  COUNT(*) AS delayed_trips
FROM railway
WHERE Journey_Status = 'Delayed'
GROUP BY Departure_Station
ORDER BY delayed_trips DESC;

-- 2.5 معدل الرحلات المتأخرة (%) - Delay Rate (%)
SELECT 
  ROUND(
    100.0 * COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) / COUNT(*), 
    2
  ) AS delay_rate_percentage
FROM railway;

-- 2.6 أكثر المسارات تأخيرًا - Most Delayed Routes
 SELECT 
  Departure_Station,
  Arrival_Destination,
  COUNT(*) AS total_trips,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_trips,
  ROUND(100.0 * COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) / COUNT(*), 2) AS delay_percentage
FROM railway
GROUP BY Departure_Station, Arrival_Destination
ORDER BY 
 
  delay_percentage DESC;

 ------2.7 تحليل شامل لمحطات الانطلاق مقارنة بالمسارات حسب الأداء والتأخير  (Departure vs Route Analysis)
SELECT 
  Departure_Station,
  COUNT(*) AS total_trips,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_trips,
  ROUND(100.0 * COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) / COUNT(*), 2) AS delay_percentage
FROM railway
GROUP BY Departure_Station
ORDER BY total_trips DESC;

-------2.8🚉 تحليل شامل لمحطات الوصول  مقارنة بالمسارات حسب الأداء والتأخير –( Arrival vs Route Analysis)
SELECT 
  Arrival_Destination,
  COUNT(*) AS total_trips,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_trips,
  ROUND(100.0 * COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) / COUNT(*), 2) AS delay_percentage
FROM railway
GROUP BY Arrival_Destination
ORDER BY delay_percentage DESC;
  
--------------------------------------💳 3. تحليل الدفع والاسترداد | Payment & Refund Analysis

-- 3.1 تحليل طرق الدفع - Payment Method Analysis
SELECT payment_method, COUNT(*) AS transactions, SUM(price) AS revenue
FROM railway
GROUP BY payment_method
ORDER BY revenue DESC;


----- 3.2 تحليل طرق الشراء - Purchase Method Analysis

SELECT 
  Purchase_Type,
  COUNT(*) AS total_transactions,
  SUM(Price) AS total_revenue,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_trips,
  ROUND(
    100.0 * COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) / COUNT(*),
    2
  ) AS delay_rate_percentage
FROM railway
GROUP BY Purchase_Type
ORDER BY total_transactions DESC;


-- 3.3 عدد طلبات الاسترداد - Refund Request Count
SELECT refund_request, COUNT(*) AS requests
FROM railway
GROUP BY refund_request;

-- 3.4 معدل طلبات الاسترداد (%) - Refund Rate (%)
SELECT 
  ROUND(
    100.0 * SUM(CASE WHEN Refund_Request = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS refund_rate_percentage
FROM railway;

-- 3.5 عدد طلبات الاسترداد وقيمتها - Refund Count & Value
SELECT
  SUM(CASE WHEN Refund_Request = 1 THEN 1 ELSE 0 END)       AS refund_count,
  SUM(CASE WHEN Refund_Request = 1 THEN Price ELSE 0 END)   AS total_refund_value
FROM railway;

-- 3.6 طلبات الاسترداد ونسبة الاسترداد حسب محطة الانطلاق - Refunds & Rate by Departure Station
SELECT
  Departure_Station AS station,
  COUNT(*) AS total_transactions,
  SUM(CASE WHEN Refund_Request = 1 THEN 1 ELSE 0 END) AS refund_count,
  ROUND(
    100.0 * SUM(CASE WHEN Refund_Request = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS refund_rate_percentage
FROM railway
GROUP BY Departure_Station
ORDER BY refund_rate_percentage DESC;

-- 3.7 طلبات الاسترداد ونسبة الاسترداد حسب محطة الوصول - Refunds & Rate by Arrival Station
SELECT
  Arrival_Destination AS station,
  COUNT(*) AS total_transactions,
  SUM(CASE WHEN Refund_Request = 1 THEN 1 ELSE 0 END) AS refund_count,
  ROUND(
    100.0 * SUM(CASE WHEN Refund_Request = 1 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS refund_rate_percentage
FROM railway
GROUP BY Arrival_Destination
ORDER BY refund_rate_percentage DESC;


-- 3.8 تحليل طرق الشراء والدفع معًا - Purchase & Payment Method Combined Analysis
SELECT 
  Purchase_Type,
  Payment_Method,
  COUNT(*) AS total_transactions,
  SUM(Price) AS total_revenue,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_trips,
  ROUND(
    100.0 * COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) / COUNT(*), 
    2
  ) AS delay_rate_percentage
FROM railway
GROUP BY Purchase_Type, Payment_Method
ORDER BY total_transactions DESC;

------------------------------------🎟️ 4. تحليل التذاكر والبطاقات | Ticket & Railcard Analysis

-- 4.1 استخدام Railcards - Railcard Usage
SELECT 
  Railcard, 
  COUNT(*) AS usage_count,
  SUM(price) AS total_paid
FROM railway
GROUP BY Railcard
ORDER BY usage_count DESC;

-- 4.2 تحليل الريلكارد من حيث عدد التأخيرات - Railcard Delay Analysis
SELECT 
  Railcard,
  COUNT(*) AS total_users,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_users,
  ROUND(100.0 * COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) / COUNT(*), 2) AS delay_rate
FROM railway
GROUP BY Railcard
ORDER BY delay_rate DESC;

-- 4.3 الإيرادات حسب فئة التذكرة - Revenue by Ticket Class
SELECT 
  Ticket_Class, 
  COUNT(*) AS trips,
  SUM(price) AS revenue
FROM railway
GROUP BY Ticket_Class
ORDER BY revenue DESC;

-- 4.4 عدد الرحلات حسب نوع التذكرة - Trips by Ticket Type
SELECT 
  Ticket_Type, 
  COUNT(*) AS trip_count,
  SUM(price) AS total_revenue
FROM railway
GROUP BY Ticket_Type
ORDER BY total_revenue DESC;

-- 4.5 تحليل التأخير حسب نوع التذكرة - Delay by Ticket Type
SELECT 
  Ticket_Type, 
  COUNT(*) AS total_trips,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_trips,
  ROUND(100.0 * COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) / COUNT(*), 2) AS delay_percentage
FROM railway
GROUP BY Ticket_Type
ORDER BY delay_percentage DESC;

-- 4.6 متوسط السعر حسب نوع التذكرة - Avg Price by Ticket Type
SELECT 
  Ticket_Type,
  ROUND(AVG(Price), 2) AS avg_price
FROM railway
GROUP BY Ticket_Type
ORDER BY avg_price DESC;


-------------------------------------📅 5. التحليل الزمني المتقدم | Advanced Date/Time Analysis

-- 5.1 الرحلات حسب أيام الأسبوع - Trips by Day of Week
SELECT 
  DATENAME(WEEKDAY, Date_of_Journey) AS journey_day,
  COUNT(*) AS trips
FROM railway
GROUP BY DATENAME(WEEKDAY, Date_of_Journey)
ORDER BY trips DESC;

-- 5.2 ساعات الذروة في الشراء - Peak Purchase Hours
SELECT 
  DATEPART(HOUR, CAST(Time_of_Purchase AS TIME)) AS purchase_hour,
  COUNT(*) AS purchases
FROM railway
GROUP BY DATEPART(HOUR, CAST(Time_of_Purchase AS TIME))
ORDER BY purchases DESC;

-- 5.3 تحليل موسمي (شهري) - Monthly Seasonality
SELECT 
  MONTH(Date_of_Journey) AS journey_month,
  COUNT(*) AS trips,
  SUM(price) AS revenue
FROM railway
GROUP BY MONTH(Date_of_Journey)
ORDER BY journey_month;

-- 5.4 تحليل سنوي - Yearly Analysis
SELECT 
  YEAR(Date_of_Journey) AS journey_year,
  COUNT(*) AS trips
FROM railway
GROUP BY YEAR(Date_of_Journey)
ORDER BY journey_year;

-- 5.5 أكثر أيام ازدحاماً - Busiest Travel Days (Top 5)
SELECT TOP 5 
  Date_of_Journey,
  COUNT(*) AS trip_count
FROM railway
GROUP BY Date_of_Journey
ORDER BY trip_count DESC;

-- 5.6 الإيرادات حسب الشهر والفئة - Revenue by Month & Class
SELECT 
  FORMAT(Date_of_Journey, 'yyyy-MM') AS month,
  Ticket_Class,
  SUM(Price) AS revenue
FROM railway
GROUP BY FORMAT(Date_of_Journey, 'yyyy-MM'), Ticket_Class
ORDER BY month;

-- 5.7 تحليل يوم شراء التذكرة - Ticket Purchase Day Analysis
SELECT 
  DATENAME(WEEKDAY, Date_of_Purchase) AS purchase_day,
  COUNT(*) AS purchases
FROM railway
GROUP BY DATENAME(WEEKDAY, Date_of_Purchase)
ORDER BY purchases DESC;

-----------------------------------------------⏳ 6. تحليل وقت الحجز والتأخير | Booking Lead Time & Delay

-- 6.1 فرق الوقت بين الحجز والرحلة - Booking Lead Time
SELECT 
  DATEDIFF(DAY, Date_of_Purchase, Date_of_Journey) AS days_in_advance,
  COUNT(*) AS bookings
FROM railway
GROUP BY DATEDIFF(DAY, Date_of_Purchase, Date_of_Journey)
ORDER BY days_in_advance;

-- 6.2 تحليل وقت الحجز مقابل التأخير - Booking Time vs Delay
SELECT 
  DATEDIFF(DAY, Date_of_Purchase, Date_of_Journey) AS days_in_advance,
  COUNT(*) AS total_trips,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_trips
FROM railway
GROUP BY DATEDIFF(DAY, Date_of_Purchase, Date_of_Journey)
ORDER BY days_in_advance;


---------------------------------------🌅 7. تحليلات متقدمة إضافية | Extra Advanced Insights

-- 7.1 التأخير حسب وقت المغادرة - Delay by Departure Time
SELECT 
  DATEPART(HOUR, CAST(Departure_Time AS TIME)) AS departure_hour,
  COUNT(*) AS total_trips,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_trips,
  ROUND(100.0 * COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) * 1.0 / COUNT(*), 2) AS delay_percentage
FROM railway
GROUP BY DATEPART(HOUR, CAST(Departure_Time AS TIME))
ORDER BY delay_percentage DESC;

-- 7.2 مقارنة الفترات الزمنية للرحلات - Morning vs Evening Trips
SELECT 
  CASE 
    WHEN DATEPART(HOUR, Departure_Time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN DATEPART(HOUR, Departure_Time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN DATEPART(HOUR, Departure_Time) BETWEEN 18 AND 23 THEN 'Evening'
    ELSE 'Night'
  END AS time_slot,
  COUNT(*) AS trips,
  COUNT(CASE WHEN Journey_Status = 'Delayed' THEN 1 END) AS delayed_trips
FROM railway
GROUP BY 
  CASE 
    WHEN DATEPART(HOUR, Departure_Time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN DATEPART(HOUR, Departure_Time) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN DATEPART(HOUR, Departure_Time) BETWEEN 18 AND 23 THEN 'Evening'
    ELSE 'Night'
  END
ORDER BY trips DESC;

-- 7.3 مقارنة طرق الدفع من حيث متوسط السعر - Payment Method Avg Price
SELECT 
  Payment_Method,
  COUNT(*) AS transactions,
  AVG(Price) AS avg_price,
  SUM(Price) AS total_revenue
FROM railway
GROUP BY Payment_Method
ORDER BY total_revenue DESC;

-- 7.4 متوسط الإيرادات لآخر 3 شهور - Avg Revenue Last 3 Months
SELECT 
  AVG(monthly_revenue) AS forecast_next_month_revenue
FROM (
  SELECT 
    FORMAT(Date_of_Journey, 'yyyy-MM') AS month,
    SUM(Price) AS monthly_revenue
  FROM railway
  GROUP BY FORMAT(Date_of_Journey, 'yyyy-MM')
  ORDER BY month DESC
  OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) AS last_3_months;






