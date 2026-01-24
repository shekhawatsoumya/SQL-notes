Create database joins;
use joins;
create table table1(id int);
create table table2(id int);
insert into table1(id)
value (1),(1),(1),(2),(3),(3),(3),(null);
select * from table1;
insert into table2(id)
value (1),(1),(2),(4),(null),(null);
select * from table2;

#cross join
#syntax
#select columnlist/* from tablename1 cross join
#tablename2;
select * from table1 cross join table2;
select count(*) from table1 cross join table2;

#inner join
#syntax
#select columnlist/* from tablename1 inner join/join tablename2
# on tablename1.commcolname=tablename2.commcolname;
select * from table1 t1 inner join table2 t2 
on t1.id=t2.id;
select count(*) from table1 t1 join table2 t2
on t1.id=t2.id;


#Note - inner join without common column condition/(On)
#it behaves like cross join

#left join
#syntax
#select columnlist/* from tablename1 left join tablename2
#on tablename1.commcolname=tablename2.commcolname;
select * from table1 t1 left join table2 t2
on t1.id=t2.id;
select count(*) from table1 t1 left join table2 t2
on t1.id=t2.id;

#right join
#syntax
#select columnlist/* from tablename1 right join tablename2
#on tablename1.commcolname=tablename2.commcolname;
select * from table1 t1 right join table2 t2
on t1.id=t2.id;
select count(*) from table1 t1 right join table2 t2
on t1.id=t2.id;

use joins;

#natural join
select * from table1 natural join table2;
select count(*) from table1 t1 natural join table2;

alter table table2 rename column id to eid;
alter table table2 rename column eid to id;

#full join
#inner + remaining value of left table + remaining value of right table

#right exclusive + left join
select * from table1 t1
left join table2 t2 on t1.id=t2.id
union all
select * from table1 t1
right join table2 t2 on t1.id=t2.id
where t1.id is null;

#left exclusive + right join
select * from table1 t1
left join table2 t2 on t1.id=t2.id
where t2.id is null
union all
select * from table1 t1 
right join table2 t2 on t1.id=t2.id;

use dummy;

#cross join
select * from customers cross join orders;

#inner join
#inner behaves as cross join if on condition is not used.
#wasq to fecth customer details who have placed any order?
select * from customers c inner join orders o
on c.customernumber=o.customernumber;

select count(*) from customers c inner join orders o
on c.customernumber=o.customernumber;


#left join
select * from customers c left join orders o
on c.customernumber=o.customernumber;

select count(*) from customers c left join orders o
on c.customernumber=o.customernumber;

#right join
select * from customers c right join orders o
on c.customernumber=o.customernumber;

select count(*) from customers c right join orders o
on c.customernumber=o.customernumber;

#left exclusive
#was to fetch customer details who have not placed any order?
select * from customers c left join orders o
on c.customernumber=o.customernumber
where o.customernumber is null;

select count(*) from customers c left join orders o
on c.customernumber=o.customernumber
where o.customernumber is null;

#right exclusive
select * from customers c right join orders o
on c.customernumber=o.customernumber
where c.customernumber is null;

select count(*) from customers c right join orders o
on c.customernumber=o.customernumber
where c.customernumber is null;

#natural join
select * from customers natural join orders;
select count(*) from customers natural join orders;

#full join
#left exclusive + right join
select * from customers c left join orders o
on c.customernumber=o.customernumber
where o.customernumber is null
union all
select * from customers c right join orders o
on c.customernumber=o.customernumber;

select count(*) from customers c left join orders o
on c.customernumber=o.customernumber
where o.customernumber is null
union all
select count(*) from customers c right join orders o
on c.customernumber=o.customernumber;

#full join
#left join + right exclusive
select * from customers c left join orders o
on c.customernumber=o.customernumber
union all
select * from customers c right join orders o
on c.customernumber=o.customernumber
where c.customernumber is null;

select count(*) from customers c left join orders o
on c.customernumber=o.customernumber
union all
select count(*) from customers c right join orders o
on c.customernumber=o.customernumber
where c.customernumber is null;

#Questions-
#wasq to fetch customername and their ordervalue?
select customername,(priceeach*quantityordered) as ordervalue from customers c join orders o on c.customernumber=o.customernumber 
join orderdetails od on o.ordernumber=od.ordernumber;

#wasq to fetch productname and their ordervalue?
select productname,(priceeach*quantityordered) as ordervalue from products p join 
orderdetails od on p.productcode=od.productcode;

#wasq to fetch customername and their respective sales representative name?
select customername,concat(firstname,' ' ,lastname) as salesrepname from customers c join 
employees e on c.salesrepemployeenumber=e.employeenumber;

#wasq to fetch employeename who does not represent any customer?
select concat(firstname," ",lastname) as employeename from employees e left join customers c on e.employeenumber=c.salesRepEmployeeNumber
where c.salesRepEmployeeNumber is null;

#Questions

#wasq to fetch customername along with their ordernumber and status(only fetch the data who have placed any order)?
select customername,ordernumber,status from customers c join orders o on c.customernumber=o.customernumber;

#wasq to fetch customer details who have not placed any order?
select * from customers c left join orders o on c.customernumber=o.customernumber where o.customernumber is null;

#wasq to fetch customername,paymentdate and amount from customers and payments table?
select customername,paymentdate,amount from customers c join payments p 
on c.customernumber=p.customernumber;

select customernumber,customername,paymentdate,amount from customers c join payments p
on c.customernumber=p.customernumber;

select c.customernumber,customername,paymentdate,amount from customers c join payments p
on c.customernumber=p.customernumber;

#using
select customernumber,customername,paymentdate,amount from customers join payments
using (customernumber);

#wasq to fetch orderdate and ordervalue?
select orderdate,(quantityordered*priceeach) as ordervalue from orders o join orderdetails od 
on o.ordernumber=od.ordernumber;

#wasq to fetch empfullname,customername,orderdate,productname from multiple tables?
select concat(firstname," ",lastname) as empfullname,customername,orderdate,productname from employees e 
join customers c on e.employeenumber=c.salesrepemployeenumber join orders o 
on c.customernumber=o.customernumber join orderdetails od on o.ordernumber=od.ordernumber join products p 
on od.productcode=p.productcode;

#wasq to fetch customername who have salesrepresentative but have not placed any order?
select customername,employeenumber,firstname,lastname from customers c join employees e on c.salesrepemployeenumber=e.employeenumber
left join orders o on c.customernumber=o.customernumber 
where o.customernumber is null;

select customername from customers left join orders using(customernumber)
where salesrepemployeenumber is not null
and ordernumber is null;

#wasq to fetch productsname that have not been sold?
select productname from products p left join orderdetails od on p.productcode=od.productcode
where od.productcode is null;

use dummy;
#wasql to fetch total number of records if we perform full join between 2 table first one is products and order details?
select count(*) from products p left join orderdetails od
on p.productcode=od.productcode
where od.productcode is null
union 
select count(*) from products p right join orderdetails od
on p.productcode=od.productcode;

#wasql to fetch empfullname customername and the productname from different tables?
select concat(firstname," ",lastname) as empfullname,customername,productname from employees e join customers c
on e.employeenumber=c.salesrepemployeenumber join orders o on c.customernumber=o.customernumber 
join orderdetails od on o.ordernumber=od.ordernumber join products p on od.productcode=p.productcode;


#wasql to retrieve the name of customer and employees who belongs to same city?
select customername,concat(firstname," ",lastname) as empname,c.city from customers c join employees e 
on c.salesrepemployeenumber=e.employeenumber 
join offices o on e.officecode=o.officecode
where c.city=o.city;

select customername,concat(firstname," ",lastname) as empname,c.city as sharedcity from customers c join employees e 
on c.salesrepemployeenumber=e.employeenumber 
join offices o on e.officecode=o.officecode
where c.city=o.city;

