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

use dummy;
#wasq to fetch totalorderdount of each country of each year?
select country,year(orderdate),ordernumber,count(ordernumber) over(partition by country,year(orderdate)) as totalordercount
from customers join orders using(customernumber);

select country,year(orderdate),count(ordernumber) as totalordernumber
from customers join orders using(customernumber)
group by 1,2;


#RANK
#ROW_RANK()

#wasq to give sequential numbe rto products table?
select*,row_number() over() as r_no from products;

select row_number() over() as r_no,p.* from products p;

select row_number() over(order by buyprice desc) as r_no,p.* from products p;

#wasq to give sequential number to each productline in products table?
with cte as
(select productline,productname,buyprice,
row_number() over(partition by productline) as r_no from products)
select * from cte where r_no=1;

select *,
row_number() over(partition by fiscal_year order by sale desc) as r_no,
rank() over(partition by fiscal_year order by sale desc) as rn,
dense_rank() over(partition by fiscal_year order by sale desc) as d_rn
from sales1;

#wasq to fetch highest ordervalue customers of each country by dense_rank?
with cte as
(select customername,country,sum(quantityordered*priceeach) as ordervalue,
dense_rank() over(partition by country order by sum(quantityordered*priceeach) desc) as d_r
from customers join orders using(customernumber)
join orderdetails using(ordernumber)
group by 1,2)
select * from cte where d_r=1;

#wasq to fetch least selling product of each productline by rank?
with cte as
(select productname,productline,quantityordered,
rank() over(partition by productline order by quantityordered asc) as rno
from products inner join orderdetails using(productcode))
select * from cte where rno=1;

use dummy;

#wasq to fetch 2nd and 3rd highest quantityordered product of each productline?
with cte as
(select productline,productname,sum(quantityordered) as totalquantordered,
dense_rank() over(partition by productline order by sum(quantityordered) desc) as denr_quant
from products join orderdetails using (productcode)
group by 1,2)
select * from cte where denr_quant in (2,3);

with cte as
(select dense_rank() over(partition by productline order by sum(quantityordered) desc) as denr_quant,
productline,productname,sum(quantityordered) as totalquantordered
from products join orderdetails using (productcode)
group by productline,productname)
select * from cte where denr_quant in (2,3);

#wasq to fetch 3rd highest ordercount customer of each year?
with cte as
(select customername,year(orderdate) as year,count(ordernumber),
dense_rank() over(partition by year(orderdate) order by count(ordernumber) desc) as denr_ordercount
from customers join orders using(customernumber)
group by 1,2)
select * from cte where denr_ordercount=3;

#wasq to fetch least ordercount customer of each year of each country?
with cte as
(select customername,country,year(orderdate),count(ordernumber) as ordercount,
dense_rank() over(partition by year(orderdate),country order by count(ordernumber) asc) as r_ordercount
from customers join orders using(customernumber)
group by 1,2,3)
select * from cte where r_ordercount=1;

#wasq to fetch 2nd highest employee(acc to totalsales) of each year?
with cte as
(select concat(firstname," ",lastname) as empfullname,year(orderdate),sum(quantityordered*priceeach) as totalsales,
dense_rank() over(partition by year(orderdate) order by sum(quantityordered*priceeach) desc) as r_employeesales
from employees join customers on employeenumber=salesrepemployeenumber
join orders using(customernumber)
join orderdetails using(ordernumber)
group by 1,2)
select * from cte where r_employeesales=2;


use dummy;
#wasq to fetch ordernumber,productcode and their ordervalue only fetch the record whose ordervalue between 2000 and 3000 and sort the data 
#by ordervalue in desc order?
select ordernumber,productcode,quantityordered*priceeach as ordervalue from orderdetails
where quantityordered*priceeach between 2000 and 3000
group by 1,2
order by ordervalue desc;

#wasq to fetch top 2 manager name by no. of employee they managed with the help of dense rank?
with cte as
(select concat(m.firstname," ",m.lastname) as manager,count(*) as empcount,
dense_rank() over(order by count(*) desc) as r_n from employees m join employees e
on m.employeenumber=e.reportsto
group by 1)
select * from cte where r_n<=2;

use dummy;
#wasq to fetch customername and their totalordervalue of each quarter or each country(fetch second and third highest)?
with cte as
(select customername,sum(quantityordered*priceeach) as totalordervalue,country,quarter(orderdate),
dense_rank() over(partition by country,quarter(orderdate) order by sum(quantityordered*priceeach) desc) as r_n
from customers join orders using(customernumber)
join orderdetails using(ordernumber)
group by 1,3,4)
select * from cte where r_n in (2,3);

#wasq to find percentile_rank of every productline by totalsales and also roundoff the percent_rank upto 2 decimal places?
select productline,sum(quantityordered*priceeach) as totalsales,
round(percent_rank() over(order by sum(quantityordered*priceeach) asc),2) as p_rank from products join orderdetails using(productcode)
group by 1;

#wasq to fetch to find percentile_rank of employees by totalsales of each orderyear?
select concat(firstname," ",lastname) as empfullname,sum(quantityordered*priceeach) as totalsales,year(orderdate) as orderyear,
round(percent_rank() over(partition by year(orderdate) order by sum(quantityordered*priceeach) asc),2) as p_rn from employees e 
join customers c on e.employeenumber=c.salesrepemployeenumber 
join orders using(customernumber)
join orderdetails using(ordernumber)
group by 1,3;

#wasq to fetch customername,usa,eachyear acc to totalsales percentilerank?
with cte as
(select customername,year(orderdate) as eachyear,sum(quantityordered*priceeach) as totalsales,
round(percent_rank() over(partition by year(orderdate) order by sum(quantityordered*priceeach) asc),2) as p_rn
from customers join orders using(customernumber)
join orderdetails using(ordernumber) 
where country="usa"
group by 1,2)
select * from cte where p_rn>=.50;

use dummy;
#VALUE WINDOW FUNCTION
#WF(COLUMN,[OFFSET],[IFNOTFOUND-"NULL"]) over(partition defn
#                                             order defn)
#LAG is previous
#LEAD is next

#LAG
use dummy;
#wasq to fetch totalsales diff. b/w current and the previous year of each productline of each year?
with cte as
(select productline,year(orderdate) as year,sum(quantityordered*priceeach) as totalsales,
lag(sum(quantityordered*priceeach),1,0) over(partition by productline order by year(orderdate) asc) as previous
from products 
join orderdetails using(productcode)
join orders using(ordernumber)
group by 1,2)
select *,(totalsales-previous) as diff from cte;

#wasq to fetch for each customers order find the orderamount along with previous ordersamount?
select customername,(quantityordered*priceeach) as current_orderamount,
lag((quantityordered*priceeach),1,0) over (partition by customername order by (quantityordered*priceeach) asc) as previous_orderamnt
from customers join orders using(customernumber)
join orderdetails using(ordernumber);

#wasq to fetch for each year show the day diff b/w current orderdate an previous orderdate of the same customer?
with cte as
(select customername,(orderdate) as current_orderdate,
lag((orderdate),1,0) over(partition by customername order by orderdate asc) as prv_orderdate
from customers join orders using(customernumber))
select *,datediff(current_orderdate,prv_orderdate) as diff from cte;

#wasq to fetch for each payment display the payment and the previous payment amount made by the customer?
select customername,amount as current_amt,
lag(amount,1,0) over(partition by customername order by amount asc) as prv_amt
from customers join payments using(customernumber);

select customername,(quantityordered*priceeach) as current_amt,
lag((quantityordered*priceeach),1,0) over(partition by customername order by (quantityordered*priceeach) asc) as prv_amt
from customers join orders using(customernumber)
join orderdetails using(ordernumber);











 
 
 
