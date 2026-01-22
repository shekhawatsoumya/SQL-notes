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
                                           

