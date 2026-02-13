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






















