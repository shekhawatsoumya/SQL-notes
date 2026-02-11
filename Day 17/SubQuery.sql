#SUBQUERY

#wasq to fetch maximum amnt from payments table?
select max(amount) from payments;

select customerNumber,checkNumber,max(amount) from payments
group by 1,2;

select customernumber,checknumber,amount from payments
where amount=(select max(amount) from payments);

#wasq to fetch customernumber and amount of a customer
#whose amount is more than average?
select customernumber,amount from payments
where amount>(select avg(amount) from payments);

#wasq to fetch customerdetail who have not placed any order?(subquery)
select customername from customers
where customernumber not in (select customernumber from orders);

#wasq to fetch customerdetail who have placed any order?(subquery)
select customername from customers
where customernumber in (select customernumber from orders);

#wasq to fetch product whose buyprice is avg buyprice of all products?
select productname,buyprice from products
where buyprice>(select avg(buyprice) from products);

#wasq to fetch employeenumber,employeename who have not managed any customer?
select employeenumber,concat(firstname," ",lastname) as employeename from employees
where employeenumber not in (select employeenumber from customers);

#wasq to fetch productname that have not been sold? 
select productname from products
where productcode not in (select productcode from orderdetails);

#wasq to fetch productline whose tov is greater than avg ov of all productline?
select productline,sum(quantityordered*priceeach) as tov
from products join orderdetails using(productcode)
group by 1
having tov>(select sum(quantityordered*priceeach)/count(distinct productline) as avgtov from products join orderdetails using(productcode));

use dummy;
#wasq to fetch second and third highest product of each productline?

#wasq to fetch customername and their ordercount on the basis of ordercount create one custom column customer_type
#condiition are
#if ordercount is one than one time customer
#if ordercount is two than one repeated customer
#if ordercount is thre than one frequent customer
#if ordercount>=4 then loyal customer?


#wasq to fetch first and second least quantity sold products of each productline of each orderyear?
select * from
(select productline,productname,sum(quantityordered) as quansold,year(orderdate) as orderyear,
dense_rank() over(partition by productline,year(orderdate) order by sum(quantityordered) asc) as d_rn from products 
join orderdetails using(productcode)
join orders using(ordernumber)
group by 1,2,4) as derived
where d_rn in (1,2);


#wasq to fetch 2nd highest employee by totalsales of each order year?
select * from
(select concat(firstname," ",lastname) as employee,sum(quantityordered*priceeach) as tov,year(orderdate) as orderdate,
dense_rank() over(partition by year(orderdate) order by sum(quantityordered*priceeach) desc) as d_rn from employees
join customers on employeenumber=salesrepemployeenumber 
join orders using(customernumber)
join orderdetails using(ordernumber)
group by 1,3) as derived
where d_rn = 2;

#wasq to fetch customername and their tov on the basis of tov create one custom column customer_type
#condition are
#if tov<10k then silver customer
#if tov between 10k and 100k gold customer
#if tov >100k then platinum customer
#final ouput will be thw count of customer_type?(subquery)
select customer_type,count(*) from
(select *, case 
when tov<10000 then "silvercustomer"
when tov between 10000 and 100000 then "goldcustomer"
else "platinumcustomer" end as customer_type 
from
(select customername,sum(quantityordered*priceeach) as tov from customers
join orders using(customernumber)
join orderdetails using(ordernumber)
group by 1) as derived1) as derived2
group by customer_type;

use dummy;
#wasq to fetch second and third highest customer by total amount paid of each payment year?(using subquery) 
select * from
(select customername,sum(amount) as totalamt_paid,year(paymentdate) as payment_yr,
dense_rank() over(partition by year(paymentdate) order by sum(amount) desc) as r_custamt
from customers join payments using(customernumber)
group by 1,3) as derived
where r_custamt in (2,3);

#wasq to fetch percentile rank to each customer by ordercount of each order year?(Using subquery)
select customername,count(ordernumber),year(orderdate) as each_year,
round(percent_rank() over(partition by year(orderdate) order by count(ordernumber) asc),2) as perr_ordercount
from customers join orders using(customernumber)
group by 1,3;


