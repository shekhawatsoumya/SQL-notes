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

# create view from another view
create view cust_details as
select customername,customernumber,city,state,country from cust_details_usa;

select * from cust_details;

# join two views
select count(*) from cust_details_usa cross join cust_details;

# updatable view
create view customer_details as
select * from customers;

update customer_details set customername ="decode"
where customernumber=103;

select * from customers;

create algorithm= undefined view order_details as
select * from orders;

update order_details set status="cancelled"
where ordernumber=10100;

# non updatable view

create algorithm= temptable view customer_details_france as
select * from customers where country ="france";

select * from customer_details_france;

update customer_details_france set customername="data"
where customernumber=103;

show full tables;
