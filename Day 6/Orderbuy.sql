#Order by
#select col1,col2....colN from tablename 
#order by Col1[asc/desc],Col2.[asc/desc],....ColN[asc/desc];
#by default - Ascending order works
#
#order of execution
#from---->select....>orderby

#single column sorting
use dummy;
#wasql to fetch contactlastname,contactfirstname from the customers table and sort the data by contactlastname in ascendingorder?
select contactlastname,contactfirstname from customers
order by contactlastname asc;

#wasql to fetch customername,city,state,country and creditlimit from the customerstable and sort the data by highest to lowest credit limit?
select customername,city,state,country,creditlimit from customers
order by creditlimit desc;

#multiplecolumnsorting
#wasql that fetch contactlastname,contactfirstname from the customers table and 
#sort the record by contactlastname in descending order then by contactfirstname in ascending order?
select contactlastname,contactfirstname from customers
order by contactlastname desc,contactFirstName asc;


#wasql that fetch ordernumber and their ordervalue from orderdetails table sort the data by ordervalue in desc order?
select ordernumber,(quantityordered*priceeach) as ordervalue from orderdetails
order by ordervalue desc;

#wasq to fecth employeefullname,jobtitle,officecode from the employees table sort the data 
#first by officecode in asc order then by jobtitle in desc order and then by employeefullname in aplhabetical order?
select concat(firstname," ",lastname) as employeefullname,jobtitle,officecode from employees
order by officecode asc,jobtitle desc,employeefullname asc;

#orderby treats null as small value
use dummy;
#orderby treats null as desc
#wasq to fetch employees detail and sort the result set by reportsto in asc order?
select * from employees order by reportsto asc;

#wasq to fetch ordernumber,orderdate and status and sort the data by orderdate from most recent to outdated?
select ordernumber,orderdate,status from orders 
order by orderdate desc;

#wasql that fetch ordernumber and their ordervalue from orderdetails table sort the data by ordervalue in desc order?
select ordernumber,(quantityordered*priceeach) as ordervalue from orderdetails
order by ordervalue desc;