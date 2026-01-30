#functions
#aggregate fuction
#Group_concat
#wasq to fetch country and their customername(fetch customername in a single row with comma seperated values)?
select country,group_concat(customername) as customername from customers 
group by country;

select country,group_concat(distinct customername order by customername desc separator "/") as customername from customers 
group by country;

 use dummy;
#Controlflow function
#1.Case Expression
#2.If

#1.Case Expression
#a.Simple case expression
#case columname
#when value 1 then result1
#when value 2 then result
#.
#.
#when value N then resultN
#else 'result'
#end

#b.Search case expression
#case
#when expression 1 then result1
#when expression 1 then result1
#.
#.
#when expression N then result N
#else result
#end
#a.Simple case expression
#wasq to fetch customername and their ordercount on the basis of ordercount create one custom column name customer_type
#conditions are 
#if order count is 1 then 1 time customer
#if order count is 2 then repeated customer
#if/when order count is 3 then frequent customer
#if ordercount>=4 then loyal customer

with cte as
(select customername,count(ordernumber) as ordercount from customers join orders using(customernumber)
group by customername)
select*,
case ordercount
when 1 then "one time customer"
when 2 then "repeated customer"
when 3 then "frequent customer"
else "loyal customer"
end as customer_type from cte;

#b.Search Case Expression
#MULTIPLE TABLE

#was to fetch customername and their tov on the basis of tov create one custom column name customer_type 
#now conditions are
#if tov is<10k then silver customer
#if tov between 10k and 100k then gold customer
#if tov is>100k then platinum customer?

with cte as
(select customername,sum(quantityordered*priceeach) tov from customers join 
orders using(customernumber) join orderdetails
using(ordernumber)
group by customername),
cte1 as
(select*,
case
when tov<10000 then "silver customer"
when tov between 10000 and 100000 then "gold customer"
else "platinum customer"
end as customer_type from cte)
select customer_type,count(*) as cust_count from cte1
group by customer_type;

use dummy;
#wasq to fetch totalsales of each employee on the basis of totalsales create one customer column
#employee_type,top,average,lowest andcount employee_type?

with cte as
(select concat(firstname," ",lastname) as emplfullname,sum(quantityordered*priceeach) as totalsales
from employees e join customers c on e.employeenumber=c.salesrepemployeenumber
join orders o using(customernumber) join orderdetails using(ordernumber)
group by emplfullname),
cte1 as
(select*,
case 
when totalsales<500000 then "worst performer"
when totalsales between 500000 and 1000000 then "average performer"
else "topemployee"
end as employee_type from cte)
select employee_type,count(*) as emp_count from cte1
group by employee_type;

#wasq to fetch totalordervalue of each productline on the basis of tov create one customer column
#productline_type
#highest selling productline
#average selling productline
#lowest selling productline

with cte as
(select productline,sum(quantityordered*priceeach) as tov from products join orderdetails 
using (productcode)
group by productline)
select *,
case 
when tov<600000 then "lowest selling productline"
when tov between 600000 and 1000000 then "average selling productline"
else "highest selling productline"
end as product_type from cte;

with cte as
(select productline,sum(quantityordered*priceeach) as tov from products join orderdetails 
using (productcode)
group by productline),
cte1 as
(select *,
case 
when tov<600000 then "lowest selling productline"
when tov between 600000 and 1000000 then "average selling productline"
else "highest selling productline"
end as product_type from cte)
select product_type,count(*) from cte1
group by product_type;

use dummy;
#wasq to fetch ordercount of each status in a single row
select
sum(case when status="shipped" then 1 else 0 end) as "shipped",
sum(case when status="cancelled" then 1 else 0 end) as "cancelled",
sum(case when status="resolved" then 1 else 0 end) as "resolved",
sum(case when status="on hold" then 1 else 0 end) as "on hold",
sum(case when status="disputed" then 1 else 0 end) as "disputed",
sum(case when status="in process" then 1 else 0 end) as "in process",
count(*) as ordercount from orders;

#wasq to fetch no.ofproductcount of each productline in a single row?
select count(productcode),productline from products
group by productline;

select
sum(case when productline="classic cars" then 1 else 0 end) as "classic cars",
sum(case when productline="motorcycles" then 1 else 0 end) as "motorcycles",
sum(case when productline="palnes" then 1 else 0 end) as "planes",
sum(case when productline="ships" then 1 else 0 end) as "ships",
sum(case when productline="trains" then 1 else 0 end) as "trains",
sum(case when productline="trucks and buses" then 1 else 0 end) as "trucks and buses",
sum(case when productline="vintage cars" then 1 else 0 end) as "vintage cars",
count(*) as no_ofproductcount
from products;

use dummy;
#wasq to fetch customernumber,customername,city,state,country from customers table 
#sort the customers by state if state is not null or sort the country in case state is null?    
select customernumber,customername,city,state,country from customers order by
if(state is null,state,country) asc;

#wasq to fetch customername and their ordercount on the basis of ordercount 
#create one custom column name customer_type
#conditions are 
#if order count is 1 then 1 time customer
#if order count is 2 then repeated customer
#if/when order count is 3 then frequent customer
#if ordercount>=4 then loyal customer
with cte as
(select customername,count(ordernumber) as ordercount from customers join orders using(customernumber)
group by customername),
cte1 as
(select *,
if (ordercount = 1,"onetimecustomer",
   if (ordercount =2,"repeatedcustomer",
      if (ordercount=3,"frequentcustomer","loyalcustomer")))
as customer_type from cte)
select customer_type,count(*) as cust_count from cte1
group by 1;

#was to fetch customername and their tov on the basis of tov 
#create one custom column name customer_type 
#now conditions are
#if tov is<10k then silver customer
#if tov between 10k and 100k then gold customer
#if tov is>100k then platinum customer?
with cte as
(select customername,sum(quantityordered*priceeach) as tov from customers join orders using(customernumber)
join orderdetails using(ordernumber)
group by 1),
cte1 as
(select*,
if (tov<10000, "silvercustomer",
  if (tov between 10000 and 100000, "goldcustomer","platinumcustomer")) as customer_type
from cte)
select customer_type,count(*) as cust_count from cte1
group by 1;

#wasq to fetch totalsales of each employee on the basis of totalsales create one customer column
#employee_type,top,average,lowest andcount employee_type?
#when totalsales<500000 then "worst performer"
#when totalsales between 500000 and 1000000 then "average performer"
#else "topemployee"
with cte as
(select concat(firstname," ",lastname) as emplfullname,sum(quantityordered*priceeach) as totalsales from employees e 
join customers c on e.employeenumber=c.salesrepemployeenumber join orders using(customernumber) join orderdetails using(ordernumber)
group by 1),
cte1 as
(select*,
if (totalsales<500000,"worstperformer",
  if (totalsales between 500000 and 1000000,"averageperformer","topemployee")) as employee_type
from cte)
select employee_type,count(*) from cte1
group by 1;





