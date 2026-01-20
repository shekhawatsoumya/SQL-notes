use dummy;

#select
select 1+1;
select 10*5;

#select now for date and time
select now();

#select concat combine two or more strings
#as is use to give tablename in result grid
select concat("decode", " ", "data"," ","bhopal");
select concat("decode", " ", "data"," ","bhopal")
as fullname;

# select from
# used to fetch data/records from particular table
# syntax
# select columnlist/*/expression from tablename;

#order of execution
# from--->select

# write a sql to fetch customername,customernumer from
# customers table?

select customernumber,customername from customers;

#write a sql query to fetch empfullname,employeenumber,
#jobtitle from employees table

select employeenumber,concat(firstname," ",lastname) 
as empfullname,jobtitle from employees;

#wasq fetch ordernumber and their ordervalue from
#orderdetails?
select ordernumber,(quantityordered*priceeach) 
as ordervalue from orderdetails;
select ordernumber,productcode,(quantityordered*priceeach) 
as ordervalue from orderdetails;

use dummy;
