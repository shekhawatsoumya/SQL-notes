# views
# views are the virtual table define by stored select query
# views do not stored data but provide a way to interact a data from 
# base table.
# syntax ---
# create view viewname as
# select columnlist/* from tablename

# create view
create view cust_details_usa as
select * from customers where country="usa";

select * from cust_details_usa;

# create view with different column name
create view cust_details(cnumber,cname,city,state,country) as
select customername,customernumber,city,state,country from customers;

select * from cust_details;

# rename view
rename table cust_details to customer_details;

# drop view
drop view customer_details;


