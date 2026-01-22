#where 

#syntax
# select columnlist from tablename
# where search condition
# order by columnname (asc|desc);

#order of execution
# from----> where-----> select--->order by

#Where clause with equality operator

#wasq to fetch employees detail
#whose jobtitle are sales resp?
select * from employees where jobtitle="sales rep";

#wasq to fetch employees detail
#whose jobtitle are sales resp
#sort the data by officecode in desc order?
select * from employees where jobtitle="sales rep"
order by officecode desc;

#wasql to fetch customernumber,customername and creditlimit belongs to USA?
select customernumber,customername,creditlimit from customers where country="usa";
select customernumber,customername,creditlimit from customers where country="usa"
order by creditlimit desc;

# not equals to <>, !=
select customernumber,customername,creditlimit from customers where country !="usa"
order by creditlimt desc;

#logical operator 
#and 
#or

select employeenumber,firstname,lastname,jobtitle,
officecode from employees
where officecode=1 and jobtitle= "sales rep";

select employeenumber,firstname,lastname,jobtitle,
officecode from employees
where officecode=1 or jobtitle= "sales rep";

use dummy;
#wasq to fetch the employeenumber,empfullname and officecode who belongs to officecode 1,2 and 3 
#and sort the data by empfullname in descc order?
select employeenumber,concat(firstname," ",lastname) as empfullname,officecode from employees where officecode=1 or officecode=2 or officecode=3 
order by empfullname desc;

#wasq to fetch customernumber and customername who belongs to usa,japan and france?
select customernumber,customername from customers where country = "usa" or country = "japan" or country = "france";
                                           
#is / is not
#wasq to fetch employeenumber,employeefullname,jobtitle who does not reports to anyone?
select employeenumber,concat(firstname," ",lastname) as employeefullname,
jobtitle from employees
where reportsto is null;

#wasq to fetch employeenumber,employeefullname,jobtitle who reports to whom?
select employeenumber,concat(firstname," ",lastname) as employeefullname,
jobtitle from employees
where reportsto is not null;

select customername,customernumber,
state,country from customers
where state is not null
order by state desc;

select customername,customernumber,
state,country from customers
where state is null
order by state desc;

# Distinct 
#does not work on multiple column
#order of execution
#from----where----select----distinct----order by

select status from orders;
select distinct status from orders;

select country from customers;
select distinct country from customers;

#like operator
#pattern matching
# 2 wild card operator
#1. %
#2. _ undersccore

#1. #
#wasq to fetch customername where customername starts with a?
select customername from customers
where customername like "a%";

#wasq to fetch customername where customername ends with .?
select customername from customers
where customername like "%.";

#wasq to fetch customername where customername starts with a and ends with .?
select customername from customers
where customername like "a%.";

#wasq to fetch productname where productname has car in it?
select productname from products
where productname like "%car%";

#2. _
#wasq to fetch fisrtname,lastname where firstname has 3 letters in it?
select firstname,lastname from employees
where firstname like "t_m";

#Que-
#wasq to fetch customername starts with vowels?
select customername from customers
where customername like "i%";

#wasq to fetch customername ends with vowels?
select customername from customers
where customername like"%o";

#wasq to fetch customername starts with vowels and ends with vowels?
select customername from customers
where customername like "a%o";
select customername from customers
where customername like "a%e";

#wasq to fetch customer whose name do not start from vowel?
select customername from customers
where customername not like "a%" or "e%" or "i%" or "o%" or "u%";

use dummy;
#LIMIT - row count(returns row count)
#order of execution
#from---where---select---distinct----order by---limit

#wasq to fetch customers detail only fetch first 10 records?
select * from customers limit 10;

#wasq to fetch customername,customernumber and creditlimit from customers only
#(that returns top 5 highest creditlimit customer)?
select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 5;

#offset - starts from zero 0
select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 5 offset 0;

#wasq to fetch customername,customernumber and creditlimit from customers only
#(that returns top 2 highest creditlimit customer)?
select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 2 offset 1;

#when we dont mentioned offset it is to be written before limit number 
#like 4 is offset and 1 is limit
select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 4,1;

#wasq to fetch second highest quantityinstock,product from the products table? 
select quantityinstock,productname from products
order by quantityinstock desc limit 1,1;
select quantityinstock,productname from products
order by quantityinstock desc limit 1 offset 1;

use dummy;

#wasq to fetch customername,customernumber,city,state,country and 
#creditlimit who belongs to usa,france,japan and have creditlimit more than 50000 and
#whose customername starts with vowels?
select customername,customernumber,city,state,country,creditlimit from customers
where country in ("usa","france","japan") and creditlimit>50000 and 
(customername like "a%" or customername like"e%" or customername like "i%" or customername like "o%" 
or "u%");

#wasq to fetch ordernumber,orderdate,status from the orders table only fetch the 
#orders placed in 2003 and have shipped status,sort the data by orderdate in asc order?
select ordernumber,orderdate,status from orders
where orderdate;

#wasq to fetch employeenumber,empname,email,officecode and jobtitle from the employees table 
#only fetch the records whose firstname starts with consonants and 
#sort the data by firstname in asc order and then by lastname desc order?
select employeenumber,concat(firstname," ",lastname)as emp,email,officecode,jobtitle from employees
where firstname like "b%" order by firstname asc, lastname desc;
