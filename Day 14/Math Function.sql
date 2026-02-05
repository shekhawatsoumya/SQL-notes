#Math function

#abs()
select abs(-10);
select abs(10);
select abs(-10.0);

#Floor 
#returs prior value
select floor(19.9);

#Ceil
#returns next value
select ceil(19.9);

select productline,buyprice from products;
select productline,ceil(avg(buyprice)) as avgbuyprice from products
group by productline;

select productline,floor(avg(buyprice)) as avgbuyprice from products
group by productline;

#MOD(dividend,divisor) - %
#if in case numerator is smaller than denominator than is returns the dividend value
select mod(5,2);
select 5%2;
select mod(10,2);
select mod(2,5); 
#2/5 if numerator is smaller than denominator than is returns the dividend value.
select mod(3,6);

use dummy;

#wasq to fetch ordernumber and the item sold per order on the basis of
#item sold per order create on custom column odd or even?
with cte as
(select ordernumber,sum(quantityordered) as itemsoldperorder from orderdetails
group by 1)
select *,
case
when itemsoldperorder%2 then "odd"
else "even"
end as columnoddeven from cte;


use dummy;
#wasq to fetch dailysales of each productline of second and third quarter of each year(fetch year(orderdate),dayname and total sales))?
select year(orderdate),sum(quantityordered*priceeach) as tov,dayname(orderdate),productline from orders 
join orderdetails using(ordernumber) join products using(productcode)
where quarter(orderdate) in (2,3)
group by 1,3,4
order by productline;










