----KULTRA MEGA STORES INVENTORY----

select * from [KMS Sql Case Study]

alter table [KMS Sql Case Study]
  alter column shipping_cost decimal (10, 2)

alter table [KMS Sql Case Study]
     alter column sales decimal (10, 2)

alter table [KMS Sql Case Study]
     alter column discount decimal (10, 2)

alter table [KMS Sql Case Study]
     alter column unit_price decimal (10, 2)

alter table [KMS Sql Case Study]
     alter column profit decimal (10, 2)

alter table [KMS Sql Case Study]
     alter column product_base_margin decimal (5, 2)

	        ---A. CASE SCENARIO ONE---
select * from [KMS Sql Case Study]

---1. Product Category With Highest Sales = Technology - 5,984,248.76---
select Product_Category, sum(Sales) as [Total Sales]
from [KMS Sql Case Study]
group by Product_category
order by [Total Sales] desc

--2. Top 3 Regions In Terms Of Sales =	West, Ontario and Prarie---
select top 3 Region, sum(Sales) as [Total Sales]
from [KMS Sql Case Study]
group by Region
order by [Total Sales] desc

---Bottom 3 Regions In Terms Of Sales Nunavut, Northwest Territories and Yukon---
select top 3 Region, sum(Sales) as [Total sales]
from [KMS Sql Case Study]
group by Region
order by [Total Sales] asc

---3. Total Sales Of Appliances In Ontario = 202,346.84---
select sum(Sales) as [Total Sales]
   from [KMS Sql Case Study]
	   where Province = 'ontario' and Product_Sub_Category = 'appliances'
	  
---4. Revenue of Bottom 10 Customers---
select top 10 Customer_name, Product_name, Order_Quantity, Discount,
  sum(sales) as [Total Revenue], sum(Profit) as [Total Proift]
from [KMS Sql Case Study]
group by Customer_name, Product_name, Order_Quantity, Discount
order by [Total Revenue] asc
-----Based on the above analysis, to increase revenue of the 10 bottom customers,
-----and boost company profit, management can take the steps below:
---1. Collect feedback from customers to undersatnd their needs
---2. Improve customer services and engagements
---3. Increase discounts to encourage purchases
---4. Review pricing and implement loyalty rewards to them to encourage repeat business
---5. Offer complementary products to them based on their order pattern
-----By following these steps, the revenue of these customers can be increased 
-----and boost overall company profitabilty.

---5. Ship Mode With Highest Shipping Cost = Delivery Truck - 51,971.94---
select Ship_Mode, sum(Shipping_Cost) as [Total Shipping Cost],
sum(Order_Quantity) as [Total Orders]
from [KMS Sql Case Study]
group by Ship_Mode
order by [Total Shipping Cost] desc


        ---B. CASE SCENARIO TWO---
select * from [KMS Sql Case Study]

---6. Most Valuable Customers and Products Purchased---
select top 5 Customer_Name, Product_Name, sum(Profit) as [Total Profit], 
    sum(Sales) as [Total Revenue] 
from [KMS Sql Case Study]
group by Customer_Name, Product_Name
order by [Total Profit] desc

---7. Small Business Customer With Highest Sales = Dennis Kane with sales of 33,367.85---
select top 3 Customer_Name, Customer_Segment, sum(Sales) as [Total Sales]
   from [KMS Sql Case Study]
	   where  Customer_Segment = 'small business'
	   group by Customer_Name, Customer_Segment, Sales
	   order by [Total Sales] desc

--- 8. Corporate Customer With The Most Number Of Orders In 2009 - 2012---
alter table [KMS Sql Case Study]
   add Years int

   update [KMS Sql Case Study]
   set Years = year(order_date)

with ranked_customers as (
  select Years, Customer_Name, Customer_Segment,
     sum(Order_Quantity) as [Total Orders],
     rank() over (partition by Years order by sum(Order_Quantity) desc) as rank
  from [KMS Sql Case Study]
  where Customer_Segment = 'Corporate'
  group by Years, Customer_Name, Customer_Segment 
)
  select Years, Customer_Name, Customer_Segment, [Total Orders]
  from ranked_customers
  where rank = 1 and Years between 2009 and 2012;


---9. Most Profitable Consumer Customer = Emily Phan with profit of 27,220.69 and 40% profit marign----
select top 3 Customer_Name, Customer_Segment, sum(Profit) as [Total Profit],
   avg(Product_Base_Margin) as [Average Profit Margin]
   from [KMS Sql Case Study]
	   where  Customer_Segment = 'Consumer'
	   group by Customer_Name, Customer_Segment, profit
	   order by [Total Profit] desc
	   
---10. Customers That Returned Items And Their Segment---
select * from Order_Status

select [KMS Sql Case Study].Row_ID,[KMS Sql Case Study].Customer_Name,Order_Status.Order_ID,[KMS Sql Case Study].Customer_Segment,
	   Order_Status.Status
from [KMS Sql Case Study]
join Order_Status
on Order_Status.Order_ID = [KMS Sql Case Study].Row_ID

---11. Shipping Cost Based On Order Priority---

---Delivery Truck - Economical (Cheapest) but slowest---
---Express Air - Fastest but most expensive---
---Where Order Priority options are; Low, Medium, High, Critical, Not Specified---

---The order priority bases all orders on their level of importance and urgency
---so the time sensitive orders should be delivered first or very quickly hence the need for speed.
---In order for management to achieve this, it is best for the urgent orders to be delivered to customers 
---with the faster ship modes regardless of the cost because of their priority
--- So YES, it was indeed wise for management to base shipping cost on order priority as shown below:

---For Critical and High orders, Ship mode - Express air
---For Medium orders, Ship mode - Regular air
---And for Low and Not Specified orders, Ship mode - Delivery truck

select Order_ID, Order_Priority,
    case 
	   when Order_Priority in ('Critical', 'High') then 'Express Air'
	   when Order_priority = 'Medium' then 'Regular Air'
	   else 'Delivery Truck'
	end as Advised_Ship_Mode
from [KMS Sql Case Study]
---Basing the shipping cost on order priority reduces shipping cost for the company
---and makes the company's delivery system more efficient.

select * from [KMS Sql Case Study]

alter table [KMS Sql Case Study]
drop column [Unit_Price]

alter table [KMS Sql Case Study]
drop column [Product_Container]
	  
alter table [KMS Sql Case Study]
drop column [Ship_Date]







 
