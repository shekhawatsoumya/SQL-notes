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





