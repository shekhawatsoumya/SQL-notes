#Groupby
#order of execution
#from--->where---->groupby---->select---->distinct---->orderby--->limit
 
#Exception - alisaing works in groupby

#syntax
#select col1,col2....colN,Agg(col) from tablename 
#where search condition 
#group by col1,col2,...colN 
#order by column[asc/dsc]

# count(*) counts null 
# left or right join we will use count(*)
use dummy;
#wasql to fetch customername and their ordercount?
select customername,count(ordernumber) as ordercount from customers c join orders o 
on c.customernumber=o.customernumber group by customername
order by ordercount desc;

#wasq to fetch customername and their totalordervalue?
select customername,sum(quantityordered*priceeach) as totalordervalue from customers c 
join orders o on c.customernumber=o.customernumber join orderdetails od on o.ordernumber=od.ordernumber
group by customername;

#wasq to fetch totalnumber of orders by each status?
select count(o1.ordernumber) as ordernumber,o1.status from orders o1 join orders o2 on
o1.ordernumber = o2.ordernumber
group by status;
select count(od.ordernumber) as ordernumber,status from orderdetails od join orders o 
on od.ordernumber=o.ordernumber
group by status;

#wasq to fetch total order value by productline of each order year?
select sum(quantityordered*priceeach) as totalordervalue,productline,year(orderdate) as orderyear from orders o
join orderdetails od using(ordernumber)
join products p using(productcode)
group by productline, year(orderdate);

#wasq to fetch customercount of each country?
select count(customernumber) as customercount,country from customers c
group by country;

#wasq to fetch manager name and their (direct reportee)employee count?
select concat(e1.firstname," ",e1.lastname) as managername, count(e1.employeenumber) as employeecount from employees e1 join 
employees e2 on e1.employeenumber = e2.reportsto
group by managername;

#wasq to fetch employeefullname and their customercount?
select concat(firstname," ",lastname) as employeefullname,count(customernumber) from employees e 
join customers c on e.employeenumber=c.salesrepemployeenumber
group by employeefullname;

#wasq to fetch employeefullname and their totalordervalue?
select concat(firstname," ",lastname) as employeefullname,sum(quantityordered*priceeach) as totalordervalue 
from employees e join customers c on e.employeenumber=c.salesrepemployeenumber 
join orders o on c.customernumber=o.customernumber
join orderdetails od on o.ordernumber=od.ordernumber 

 #Basic group by clause
#wasq to fetch status from orders table?
select status from orders;
#wasq to fetch distinct status from orders table?
select distinct status from orders;

#Group by with aggregate function
#single column group by
#wasq to fetch no of orders per orderstatus?
select status,count(*) as ordercount from orders 
group by status;
select status,count(*) as ordercount from orders 
group by status
order by status asc;

#wasq to fetch totalordervalue by status?
select status,sum(quantityordered*priceeach) as totalordervalue
from orders o join orderdetails od using(ordernumber)
group by status;

#wasq to fetch totalordervalue by ordernumber?
select ordernumber,sum(quantityordered*priceeach) as totalordervalue from orderdetails
group by ordernumber;
select ordernumber,sum(quantityordered*priceeach) as totalordervalue from orderdetails
group by 1;

#wasq to fetch totalsales by each orderyear?
select year(orderdate) as orderyear,sum(quantityordered*priceeach) as totalsales from orders
join orderdetails using (ordernumber)
group by orderyear;

use dummy;
#wasq to fetch customername and totalamountpaid(of each year)?
select customername,sum(quantityordered*priceeach) as totalamountpaid, year(orderdate) as eachyear from customers 
join orders using(customernumber) join orderdetails using(ordernumber)
group by customername,eachyear;

select customername,sum(amount) as totalamountpaid, year(paymentdate) as eachyear from payments p join customers c
using (customernumber)
group by customername,year(paymentdate);

#wasq to fetch productname and their totalquantityordered?
select productname,sum(quantityordered) as totalquantityordered from orderdetails od join products p using (productcode)
group by productname;

#wasq to fetch productname and their count?
select productname,count(productcode) as productcount from products
group by productname;

#wasq to fetch totalsales of each employee in the year 2004?
select concat(firstname," ",lastname) as employeename,sum(quantityordered*priceeach) as totalsales,year(orderdate) odyear from employees e 
join customers c on e.employeenumber=c.salesrepemployeenumber
join orders using(customernumber) join orderdetails using(ordernumber) where year(orderdate)=2004
group by employeename,odyear;

select concat(firstname," ",lastname) as employeename,sum(amount) as totalsales,year(paymentdate) from employees e join customers c 
on e.employeenumber=c.salesrepemployeenumber join payments p using(customernumber) where year(paymentdate) = "2004"
group by 1,3;


#wasq to get ordernumber,the number of item sold per order and total sales?
select ordernumber,sum(quantityordered*priceeach) as totalsales,sum(quantityordered) as itemsold from orderdetails
group by ordernumber;




