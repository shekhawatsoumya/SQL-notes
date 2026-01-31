#Comparison Function
#ifnull(value1,value2) - it takes two arguments only.
#coalesce(value1,value2,...valueN) - it takes n no of argument
#both function return first non null values#use for null substitution
 use dummy;
 
select ifnull(null,1);
select coalesce(null,1);

select ifnull(null,null,1); #it doesnot work as ifnull only take 2 arguments so we will use coalesce for more than 2 arguments
select coalesce(null,null,null,null,null,1);

select customername,city,state,country from customers;

select customername,city,ifnull(state,"N/A") as state,country from customers;
select customername,city,ifnull(state,country) as state,country from customers;

select customername,city,coalesce(state,"N/A") as state,country from customers;
select customername,city,coalesce(state,country) as state,country from customers;

select customername,city,state,country from customers
order by ifnull(state,country) asc;

use dummy;
#wasq to fetch productname,totalno.ofitemsoldperorder and tov of each productline of year 2004; 
select productline,productname,sum(quantityordered) as totalnoofitemsoldpo,sum(quantityordered*priceeach) as tov from products 
join orderdetails using(productcode) join orders using(ordernumber)
where year(orderdate)=2004
group by 1,2;




