use dummy;
#wa storedprocedure to get highest products by tov of each productline of each orderyear.
#Take drank as 1st input parameter and p_productline as a 2nd input parameter
#o_year as 3rd input
delimiter $$
create procedure highest_products(in p_productline varchar(100),in drank int,in o_year year)
begin
 with cte as
  (select productname,productline,sum(quantityordered*priceeach) as tov,year(orderdate) as orderyear,
  dense_rank() over(partition by productline,year(orderdate) order by sum(quantityordered*priceeach) desc) as d_rank
  from products p join orderdetails using(productcode) join orders using(ordernumber)
   group by 1,2,4)
   select * from cte where productline=p_productline and d_rank<=drank and orderyear=o_year;
end $$
DELIMITER ;

call highest_products("classic cars",3,2004);

use dummy;

# stored procedure without parameter.

delimiter $$
create procedure cust_details_usa()
begin
select customernumber,customername,city,state,country,
creditlimit from customers
where country="usa";
end $$
delimiter ;

call cust_details_usa();

# stroed procedure with multiple select

delimiter $$
create procedure c_c()
begin
select * from customers;
select * from orders;
select * from products;
end $$
delimiter ;

call c_c();

# stored procedure with input parameter.
delimiter $$
create procedure cust_details(in country varchar(100))
begin
select customernumber,customername,city,state,
country,creditlimit from customers c
where c.country=country;
end $$
delimiter ;

call cust_details("austria");

# stored procedure with multiple input
delimiter $$
create procedure customer_details
(in country varchar(100),in creditlimit decimal(10,2))
begin
select customernumber,customername,city,state,country,
c.creditlimit from customers c
where c.country=country and c.creditlimit > creditlimit ;
end $$
delimiter ;

call customer_details("france",50000);

#wa storedprocedure to get highest products by tov of each productline of each orderyear.
#Take drank as 1st input parameter and p_productline as a 2nd input parameter
#o_year as 3rd input

delimiter $$
create procedure highest_product
(in p_productline varchar(100),in drank int,in o_year year)
begin
with cte as
(select productline,productname,year(orderdate) as orderyear,
sum(quantityordered*priceeach) as totalsales,
dense_rank() over(partition by productline,year(orderdate)
order by sum(quantityordered*priceeach) desc) as d_rn
from products inner join orderdetails using(productcode)
inner join orders using(ordernumber) 
group by 1,2,3)
select * from cte where productline=p_productline and d_rn<=drank
and orderyear=o_year;
end $$
delimiter ;

call highest_product("classic cars",5,2004);


use dummy;
#wa storedprocedure to get lowest selling products by quantityordered by customers
#Take drank as 1st input parameter and p_productline as a 2nd input parameter

delimiter $$
create procedure lowest_selling (in drank int,in p_productline varchar(100))
begin
with cte as
(select customername,sum(quantityordered) as lowest_quantordered,productline,
dense_rank() over(partition by productline order by sum(quantityordered) asc) as d_rank
from customers c join orders o using(customernumber)
join orderdetails od using(ordernumber)
join products p using(productcode)
group by 1,3)
select * from cte where d_rank>=drank and productline=p_productline;
end $$
delimiter ;

call lowest_selling(3,"classic cars");

#Take country 1st parameter

delimiter $$
create procedure offices_country(in country varchar(100))
begin
select city,state,country,concat(firstname," ",lastname) as empfullname from offices o join employees e using(officecode)
where o.country=country;
end $$
delimiter ;

call offices_country("usa");

#storeprocedure  averageordervalue per employee based on their customers order 
#1 producline,orderyear 2nd
delimiter $$
create procedure employee_avgordervalue(in p_productline varchar(100),in o_year year,out avgodrvalue int)
begin
with cte as
(select concat(firstname," ",lastname) as empfullname,customername,year(orderdate)as eachyear,avg(quantityordered*priceeach) as avg_odrvalue,productline from employees e
join customers c on e.employeenumber=c.salesrepemployeenumber
join orders o using(customernumber)
join orderdetails using(ordernumber)
join products using(productcode)
group by 1,2,3,5)
select * from cte where productline=p_productline and eachyear=o_year and avg_odrvalue>=avgodrvalue;
end $$
delimiter ;
drop procedure employee_avgordervalue;

call employee_avgordervalue("vintage cars",2004,3000);


#wasq to fetch highest employee of each country(acc to totalsales)  of each year ?
delimiter $$
create procedure emplyeesales(in c_country varchar(10),in drank int ,in oyear year)
begin
  with cte as
(select concat_ws(" ",firstname,lastname),c.country,sum(quantityordered* priceeach) as tov,year(orderdate) as orderyear,
dense_rank() over(partition by c.country,year(orderdate) order by sum(quantityordered*priceeach) desc) as d_rnk
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber join orders using(customernumber)
 inner join orderdetails using(ordernumber) group by 1,2,4)
select * from cte where country=c_country and d_rnk<=drank and orderyear= oyear;
end $$
delimiter ;

call emplyeesales("usa",2,2005);






















