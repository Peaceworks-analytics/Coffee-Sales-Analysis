Coffee Chain Business Intelligence Dashboard  

Project Overview  
This project is a full end-to-end Business Intelligence solution built for a fictional Coffee Shop Chain operating multiple stores across Manhattan. The goal is to analyze sales performance, product trends, store efficiency, and time-based behavior using a cleaned dataset of 149,117 transactions.  
The final deliverable is a Power BI dashboard supported by SQL analysis, data modeling, DAX measures, and professional documentation (BRD + SRD).  

Objectives  
Provide leadership with a unified view of business performance  
Identify top-performing stores, products, and categories  
Understand customer purchasing patterns across time  
Support operational decisions (staffing, inventory, promotions)  
Build a portfolio-grade BI project demonstrating SQL, DAX, and Power BI skills  
 
Dataset Description  
The cleaned dataset contains:  
Column  	        Description  
Transaction_ID  	Unique transaction identifier  
Transaction_Date  	Excel serial date  
Transaction_Time  	Decimal time value  
Transaction_QTY  	Quantity purchased  
Store_ID  	        Store identifier  
Store_Location  	Store location (e.g., Lower Manhattan)  
Product_ID  	    Product identifier  
Unit_price  	    Price per unit  
Total_Sales  	    Calculated revenue per transaction  
Product_Category  	High-level product category  
Product_Type  	    Sub-category  
Product_Details  	Specific product name  
  
Tools & Technologies  
Power BI (Data modeling, DAX, visualization)  
SQL (Exploratory analysis, validation)  
Power Query (Data transformation)  
Excel (Initial cleaning)  
 
Data Modeling  
A Star Schema was used for optimal performance:  
Fact Table  
FactSales 
  
Dimension Tables  
DateTable  
DimStore  
DimProduct  
 
Key Relationships  
FactSales[Store_ID] - DimStore[Store_ID]  
FactSales[Product_ID] - DimProduct[Product_ID]  
FactSales[Actual_Date] - DateTable[Date]  
FactSales[Hour] - DateTable[Hour]  
 
Key DAX Measures  
Total Sales  
Total Quantity  
Average Price  
Sales per Transaction  
Category Contribution %  
Store Rank  
Rolling 30-Day Sales  
Month-over-Month %  
Quarter-over-Quarter % 
These measures power the dashboard's KPIs and advanced insights.  
 
Dashboard Pages  
1. Executive Summary  
Total Sales  
Total Quantity  
Average Price  
Sales Trend  
Top Stores  
Category Mix  
  
2. Store Performance  
Store ranking  
Store contribution %  
Store vs Month trend  
Drill-through to store details  
  
3. Product & Category Analysis  
Category revenue  
Top products  
Product trends
Category mix  
  
4. Time Intelligence  
Hourly sales  
Day-of-week sales  
Monthly trend  
Heatmap (Day x Hour)  
MoM, QoQ analysis 
 
Key Insights  
1.	Morning hours (7 AM-11 AM) generate the highest sales, driven by commuters and office workers, making this the most critical period for staffing, inventory, and service efficiency.  
2.	Lower Manhattan is the top-performing store, consistently contributing the largest share of total revenue, while other locations show moderate performance and opportunities for improvement.  
3.	Coffee is the dominant revenue driver, especially gourmet brewed and classic drip options, with tea, drinking chocolate, and bakery items serving as strong complementary categories.  
4.	Customers frequently bundle beverages with pastries, indicating strong cross-selling potential and opportunities to increase average transaction value.  
5.	Weekday sales are beverage-heavy, while weekends show increased demand for bakery and specialty items, reflecting different customer behaviors across the week.  
6.	Seasonal patterns are clear, with hot beverages peaking in colder months and lighter or specialty drinks gaining traction during warmer periods.  
7.	Operational optimization opportunities exist, including dynamic staffing, improved inventory planning, and store-specific product strategies based on localized demand patterns.  
 
Business Recommendations 
1.	Optimize Peak and Off-Peak Operations: Use hourly and daily patterns to increase staffing and inventory during peak hours while introducing targeted promotions during slower periods to boost demand. 
2.	Strengthen High-Performing Categories and Products: Focus on top-selling items by improving availability, promoting bundles, and training staff to upsell high-margin products. 
3.	Improve Underperforming Stores: Leverage Store-level insights to identify locations that need operational support, targeted marketing, or adjustments in product mix and pricing. 
4.	Align Marketing with Seasonal Trends: Monthly and quarterly patterns help time promotions, seasonal drink launches, and loyalty campaigns to match customer demand cycles. 
5.	Reduce Waste Through Smarter Inventory Planning: Category and product performance data can guide more accurate purchasing, reducing overstocking and minimizing spoilage across the chain. 
 
Documentation Included  
BRD - Business Requirements Document  
SRD - System Requirements Document  
SQL Analysis Scripts  
Dashboard Screenshots  
 
Author:  
Onyishi Peace Udoka  
Aspiring Data Analyst   
Excel | Power BI | SQL | Python | Data Modeling | Storytelling  
  
