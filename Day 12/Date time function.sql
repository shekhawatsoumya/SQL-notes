use dummy;
#wasql to fetch  quarterly totalsales of productline
select productline,sum(quantityordered*priceeach)as totalsales,quarter(orderdate) as quartersales from products join orderdetails 
using(productcode) join orders using(ordernumber) group by productline,3;

select country,count(ordernumber),monthname(orderdate) from customers join orders using(customernumber)
group by country,monthname(orderdate);
 
select productline,sum(quantityordered*priceeach)as totalsales,year(orderdate) as quartersales from products join orderdetails 
using(productcode) join orders using(ordernumber)
group by productline,3; 

#Datetime function

select sysdate(); #system date time
select now(); #serever date time
select current_timestamp(); #timestamp

select current_date();
select current_time();

#Now () and Sysdate()
select sysdate(),sleep(10),sysdate();
select now(),sleep(10),now();

#Datediff()
#Datediff(enddate,startdate);

select datediff(now(),"2023-11-12")/365;
select datediff(shippeddate,orderdate),status from orders;

#Extract
select year(now());
select quarter(now());
select month(now());
select monthname(now());
select week(now());
select weekday(now());
select day(now());
select dayname(now());
select date(now());
select time(now());
select hour(now());
select minute(now());
select second(now());

use dummy;
#find the no. of days between the requireddate and shippeddate of each order?
select datediff(requireddate,shippeddate),ordernumber from orders;

#wasq to get all orders whose status are in process and calculate the no of days between order date and required date?
select datediff(requireddate,orderdate),ordernumber from orders
where status ="in process";

#calculate the days between order date and shipped date and display N/A when the shipped date is null?
select ordernumber,ifnull(datediff(shippeddate,orderdate),"n/a") from orders;

#wasq to get ordercount for each quarter of the year 2004?
select count(ordernumber),quarter(orderdate) from orders
where year(orderdate) = 2004
group by 2;

#wasq to get ordercount of each quarter of each year?
select count(ordernumber),year(orderdate),quarter(orderdate) from orders
group by 2,3;

#wasq to get ordercount of each quarter?
select count(ordernumber),quarter(orderdate) from orders
group by 2;

