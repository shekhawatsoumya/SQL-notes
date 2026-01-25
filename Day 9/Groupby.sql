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
group by employeefullname;



