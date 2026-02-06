use dummy;
#WINDOW FUNCTION
#Syntax
# WF (Parameter) over(partition defn
#                     order defn
#                     frame defn)
         
CREATE TABLE sales1(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales1(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales1;

#wasq to fetch totalsales?
select sum(sale) as totalsales from sales1;

select*, sum(sale) over() as totalsales from sales1;

#wasq to fetch total sales by fiscal_year?
select fiscal_year,sum(sale) as totalsales from sales1
group by 1;

select fiscal_year, sum(sale) over(partition by fiscal_year) as totalsales from sales1;

#wasq to fetch total sales by sales_employee?
select sales_employee,sum(sale) as totalsales from sales1
group by 1;

select *,sum(sale) over(partition by sales_employee) as totalsales from sales1;

#wasq to fetch totalbuyprice,maxbuyprice,minbuyprice and avgbuyprice of each productline with the help of windowfunction?
select productline,productname,buyprice,
       sum(buyprice) over(partition by productline) as totalbuyprice,
	   max(buyprice) over(partition by productline) as maxbuyprice,
	   min(buyprice) over(partition by productline) as minbuyprice,
	   avg(buyprice) over(partition by productline) as avgbuyprice
from products;

use dummy;
select productline,productname,
     sum(quantityordered*priceeach) over(partition by productline) as totalsales,
     max(quantityordered*priceeach) over(partition by productline) as maxsales,
	 min(quantityordered*priceeach) over(partition by productline) as mminsales,
     avg(quantityordered*priceeach) over(partition by productline) as avgsales
from products join orderdetails using(productcode);

select concat_ws(" ",firstname,lastname) as empfullname,productline,productname,
	 sum(quantityordered*priceeach) over(partition by productline) as totalsales,
     max(quantityordered*priceeach) over(partition by productline) as maxsales,
	 min(quantityordered*priceeach) over(partition by productline) as mminsales,
     avg(quantityordered*priceeach) over(partition by productline) as avgsales
from employees e join customers c on e.employeenumber=c.salesrepemployeenumber
join orders using(customernumber)
join orderdetails using(ordernumber)
join products using(productcode);


select customername,productline,productname,
       sum(quantityordered) over(partition by productline) as totalquantityordered,
       max(quantityordered) over(partition by productline) as maxtotalquantityordered,
       min(quantityordered) over(partition by productline) as mintotalquantityordered,
       avg(quantityordered) over(partition by productline) as avgtotalquantityordered
from customers join orders using(customernumber) 
join orderdetails using(ordernumber)
join products using(productcode);

select concat_ws(" ",firstname,lastname) as empfullname,year(orderdate),productline,productname,
	 sum(quantityordered*priceeach) over(partition by productline) as totalsales,
     max(quantityordered*priceeach) over(partition by productline) as maxsales,
	 min(quantityordered*priceeach) over(partition by productline) as mminsales,
     avg(quantityordered*priceeach) over(partition by productline) as avgsales
from employees e join customers c on e.employeenumber=c.salesrepemployeenumber
join orders using(customernumber)
join orderdetails using(ordernumber)
join products using(productcode);

select concat_ws(" ",firstname,lastname) as emplfullname,customername,country,productline,productname,
	 sum(quantityordered*priceeach) over(partition by productline) as totalsales,
     max(quantityordered*priceeach) over(partition by productline) as maxsales,
	 min(quantityordered*priceeach) over(partition by productline) as mminsales,
     avg(quantityordered*priceeach) over(partition by productline) as avgsales
from employees join customers on employeenumber=salesrepemployeenumber 
join orders using(customernumber) 
join orderdetails using(ordernumber)
join products using(productcode);











 
 
 
