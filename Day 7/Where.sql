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

use dummy;
#between operator
# between low and high
#and both low and high 
# and both low and high are inclusive

select employeenumber,concat(firstname," ",lastname) as empfullname,officecode from employees where officecode between 1 and 3 
order by empfullname desc;

#wasql to fetch ordernumber,orderdate and status from orders
# table only fetch orders who placed in 2003 and 2004 ?

select ordernumber,orderdate,status from orders where orderdate between "2003-01-01" and "2004-12-31";
select ordernumber,orderdate,status from orders where orderdate>="2003-01-01" and orderdate <="2004-12-31";

#wasql to fetch employees detail who belongs to officecode 1,3 and5?
select * from employees
where officecode=1 or officecode=3 or officecode=5;

#wasq to fetch payment made in 2003, fetch customernumber,checknumber,amount?
select customernumber,checknumber,amount from payments
where paymentdate between "2003-01-01" and "2003-12-31";

#wasq to fetch customers who belongs to usa and have creditlimit greater than 15000?
select * from customers
where country="usa" and creditlimit>15000;

#wasq to fetch employeenumber,empfullname from employees table wgo belongs to
#office code 1,2,3 and jobtitle are sales rep?
select employeenumber,concat(firstname,"_",lastname) as empfullname from employees
where officecode between 1 and 3 and jobtitle= "sales rep";

#wasq to fetch productname,whose mrsp greater than 100?
select productname from products
where msrp>100;


# IN and NOT IN
#wasq to fetch customername,city,state,
#country from customers table who belong to usa,japan
#and france?
select customername,city,state,country from customers
where country in ("usa","france","japan");

#wasq to fetch customername,city,state,
#country from customers table who do not belong to usa,japan
#and france?
select customername,city,state,country from customers
where country not in ("usa","france","japan");


