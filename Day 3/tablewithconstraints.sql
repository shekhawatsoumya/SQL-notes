# Table with constraints

create database dd200;
use dd200;

create table emp(empid int primary key,
empname varchar(30) not null,doj date,
city varchar (50) default "bhopal",age tinyint,
mobile varchar(20) unique, check(age>=18));

desc emp;

#remove primary key
#alter table tablename drop primary key;
alter table emp drop primary key;
desc emp;

#remove not null;
#alter table tablename modify columnname datatype;
alter table emp modify empid int;
alter table emp modify empname varchar(20);
desc emp;

#default
#alter table tablename modify columnname datatype;
alter table emp modify city varchar(20);

#unique
#alter table tablename drop index/key uniquekeyname;
alter table emp drop key mobile;
desc emp;

#check 
#alter table tablename drop constraint checkconsname;
alter table emp drop constraint emp_chk_1;

use dd200;
desc emp;

#add primary key
# alter table tablename add primary key (columnname);

alter table emp add primary key (empid);

#not null
# alter table tablename modify columnname datatype not null;

alter table emp modify empname varchar (50) not null;
desc emp;

#default 
#alter table tablename modify columname datatype default "datavalue";
alter table emp modify city varchar(30) default "bhopal";

#check table
#alter table tablename add constraint check(columncondition);
alter table emp add constraint check(age>=18);

#unique
#alter table tablename add unique(columnname);
alter table emp add unique(mobile);
desc emp;