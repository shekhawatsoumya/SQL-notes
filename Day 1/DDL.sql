SHOW DATABASES;

USE SAKILA;
show tables;
DESC ACTOR;

# DDL
# create database
#syntax
# create database databasename

create database schooldb1;
use schooldb1;

# create table without constraint
# create table tablename(col1name datatype,col2name datatype..
#......colNname datatype);

create table student(sid int,sname varchar(40),
city varchar(40),fees decimal(10,2),d_o_b date,
mobile varchar(20));

desc student;

# rename structure or table
# rename table tablenoldname to tablenewname;

rename table student to stu;


#ALTER
#ADD COLUMN TO AN EXISTING STRUCTURE
#ALTER TABLE TABLENAME ADD COLUMN COLUMNNAME DATATYPE;


USE SCHOOLDB1;
ALTER TABLE STU ADD COLUMN PINCODE VARCHAR(20);
DESC STU;

#REMOVE COLUMN FROM AN EXISTING STRUCTURE
#ALTER TABLE TABLENAME DROP COLUMN COLUMNNAME;

ALTER TABLE STU DROP COLUMN PINCODE;

#RENAME COLUMN TO AN EXISTING STRUCTURE
#ALTER TABLE TABLENAME RENAME COLUMN COLOLDNAME TO COLNEWNAME;

ALTER TABLE STU RENAME COLUMN SID TO Stu_id;


DESC STU;
ALTER TABLE STU RENAME COLUMN STU_ID TO Stu_id;

DESC STU;


#change datatype in an existing structure
#alter table tablename modify columnname newdatatype;

alter table stu modify stu_id tinyint;

alter table stu modify sname varchar(50);



alter table stu modify fees decimal(8,2);

desc stu;




 