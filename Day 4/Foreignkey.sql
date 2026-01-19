use Lotus;
create table products(Pid int primary key,PName Varchar(20),price decimal(10,2));
desc products;
create table Users(Uid int primary key,UName varchar(20),City varchar(20));
show tables;

create table orders(oid int primary key,userid int,pid int, foreign key(userid) references
users(Uid));

desc orders;

#add foreign key to an existing structure;
#alter table tablename add foreign key (columnname)
#references parenttablename(primarykeycolumn);

alter table orders add foreign key (pid) references
products(Pid);
desc orders;

#alter table tablename drop foreign key foreign key name;
#alter table tablname drop key nonunique key name;

alter table orders drop foreign key orders_ibfk_1;
desc orders;
alter table orders drop key userid;

alter table orders drop foreign key orders_ibfk_2;
alter table orders drop key pid;
desc orders;

use lotus;
alter table orders add foreign key (userid) references
users (Uid);

use lotus;
desc orders;

insert into users(Uid,UName,City)
values (1,"A","X"),(2,"B","X"),(3,"C","Y"),
(4,"D","X"),(5,"E","X");

insert into orders(oid,userid,pid)
values (101,1,201);

select * from orders;

insert into orders(oid,userid,pid)
values (102,10,102);
#above query thow error because userid 10
#doesnot exist in parent table

insert into orders(oid,userid,pid)
values (102,2,202),(103,1,202),(104,3,201),(105,5,203);

delete from users where Uid=4;
select * from users;

delete from users where Uid=1;
#above query throw error because
#uid 1 also exit in child table with columnname userid

alter table orders drop foreign key orders_ibfk_1;
alter table orders drop key userid;

alter table orders add foreign key (userid) references
users (Uid) on delete set null;

delete from users where Uid=1;
select * from users;
select * from orders;

delete from orders where oid=105;

use lotus;
alter table orders drop foreign key orders_ibfk_5;
alter table orders drop key userid;

start transaction;
alter table orders add foreign key (userid) references
users (Uid) on delete cascade;

delete from users where Uid=3;
select * from orders;
rollback;
select * from users;

update users set uid=40 where uid = 4;
select * from users;
update users set uid=20 where uid=2;

alter table orders drop foreign key orders_ibfk_1;
alter table orders drop key userid;

alter table orders add foreign key (userid)
references users(uid) on update cascade;

update users set Uid=20 where Uid=2;
select * from users;
select * from orders;

use lotus;



create database croma;
use croma;
create table departments(Did int primary key,Dname varchar(20));
create table employees(Empid int primary key,Empname varchar(20),Deptid int, foreign key (Deptid) references
departments (Did));

insert into departments(Did,Dname)
values (1,"HR"),(2,"Sales"),(3,"DA"),(4,"Marketing");
insert into employees(Empid,Empname,Deptid)
values (101,"A",1),(102,"B",2),(103,"C",1),(104,"D",3),(105,"E",3);

delete from departments where Did=4;
select * from departments;
select * from employees;
delete from departments where Did=1;

alter table employees drop foreign key employees_ibfk_1;
alter table employees drop key Deptid;

alter table employees add foreign key (Deptid) references 
departments (Did) on delete set null;


select * from employees;
insert into departments(Did,Dname)
values (1,"HR");

alter table employees add foreign key (Deptid) references 
departments (Did) on delete set null;
delete from departments where Did=1;
select * from employees;

alter table employees drop foreign key employees_ibfk_1;
alter table employees drop key Deptid;
use croma;
desc departments;
desc employees;
alter table employees drop primary key;
alter table employees drop key Empid;
alter table departments drop primary key;
alter table departments drop key Did;

use lotus;
create table user(userid int primary key,username varchar(20));
create table addresses(add_1 varchar(20),add_2 varchar(20),uid int,city varchar(10),
state varchar(20),country varchar(15),pincode int, foreign key (uid)
references user (userid));
desc user;
desc addresses;
alter table addresses modify pincode varchar(20);

use lotus;
#table with increment
create table emp(eid int primary key auto_increment,ename varchar(20));
insert into emp(ename)
values ("a"),("b"),("c"),("d");
select * from emp;

#add auto_increment;
alter table emp auto_increment=101;
insert into emp(eid,ename)
values (50,"e");
insert into emp(ename)
values ("g");

select * from emp;

#drop auto_increment
alter table emp modify eid int;
insert into emp(eid,ename)
values (8,"e");

#@num gives the numerical order correctly if the no is 1,2,4,5,6 etc it will correct and assign like 1,2,3,4,5,6
set @num=0;
update emp set eid=@num:=@num+1;
alter table emp drop primary key;
desc emp;
