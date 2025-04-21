# UK-Train-Rides
UK Train Rides

# 🚄 UK Train Data Analysis using SQL

This repository contains a comprehensive set of SQL queries to analyze UK train journey data. The dataset is stored in a single table called `railway` within the `uk_train` database.

## 📊 Overview

The analysis is structured into several categories for better organization and readability. Each section includes key performance indicators (KPIs), usage statistics, delay breakdowns, and customer behavior insights.

---

## 1. 🚄 General Trip Analysis
Basic statistics and high-level insights:
- Total number of transactions
- Total revenue
- Most common departure/arrival stations
- Most frequent routes
- On-time vs cancelled journeys
- Revenue by station
- Average ticket price

---

## 2. ⏱️ Timing & Delay Analysis
Explores time-related performance:
- Count and percentage of delayed trips
- Average delay duration
- Delay reasons and top delaying stations
- Delay breakdown by routes

---

## 3. 💳 Payment & Refund Analysis
Covers financial and customer service metrics:
- Payment method usage
- Purchase method behavior
- Refund request analysis and rates
- Refunds by station
- Delay correlation with purchase types

---

## 4. 🎟️ Ticket & Railcard Analysis
Focuses on ticket type and discount usage:
- Railcard usage and delay rates
- Ticket class and type revenue
- Delay by ticket type
- Average prices by ticket type

---

## 5. 📅 Advanced Date/Time Analysis
Seasonal and time-of-day patterns:
- Trips by weekday and month
- Peak purchase hours
- Yearly trends
- Busiest travel dates
- Revenue by month and class

---

## 6. ⏳ Booking Lead Time & Delay
Analyzes how far in advance tickets are purchased:
- Booking lead time distribution
- Correlation between booking time and delays

---

## 7. 🌅 Extra Advanced Insights
In-depth behavior and forecasting:
- Delays by hour of departure
- Morning vs evening trip comparison
- Average price by payment method
- Revenue forecast for upcoming month (based on last 3 months)

---

## 🗂️ Dataset Schema

The `railway` table contains the following fields:

| Column               | Description                          |
|----------------------|--------------------------------------|
| Departure_Station    | Name of departure station            |
| Arrival_Destination  | Name of arrival station              |
| Journey_Status       | Status: On Time, Delayed, Cancelled  |
| Date_of_Journey      | Scheduled travel date                |
| Date_of_Purchase     | Ticket purchase date                 |
| Time_of_Purchase     | Time when the ticket was purchased   |
| Departure_Time       | Scheduled departure time             |
| Arrival_Time         | Scheduled arrival time               |
| Actual_Arrival_Time  | Real arrival time (if available)     |
| Price                | Ticket price                         |
| Payment_Method       | Payment method used                  |
| Purchase_Type        | Channel used for purchasing          |
| Refund_Request       | Whether a refund was requested (0/1) |
| Railcard             | Type of railcard used                |
| Ticket_Class         | Ticket class (e.g., Standard, First) |
| Ticket_Type          | Type (e.g., Single, Return)          |
| Reason_For_Delay     | Text reason for delay (if delayed)   |

---

## 🧠 Usage

All queries are written in T-SQL and are ready to be executed in SQL Server Management Studio (SSMS) or any compatible environment connected to the `uk_train` database.

To run the full analysis:
1. Make sure the `railway` table is properly populated.
2. Execute queries section by section or modify them for your custom dashboard.

---

## 📌 Notes

- This project is focused on query design and analytical coverage, not on data ingestion or preprocessing.
- Feel free to adapt these queries for other datasets or visualization tools (e.g., Power BI, Tableau, Python).

---

## 📄 License

MIT License. Feel free to fork and build upon this work!


