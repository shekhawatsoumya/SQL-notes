create database trigger_db;
use trigger_db;

create table student1(student_id int primary key auto_increment,sname varchar(100),age tinyint,course varchar(100),
registered_at timestamp default current_timestamp);

create table student1_logs(log_id int primary key auto_increment,student_id int,sname varchar(100),course varchar(100),
log_time timestamp default current_timestamp);

alter table student1_logs add column action varchar(100);
use trigger_db;

delimiter $$
create trigger student_detail_insertion
before insert on student1
for each row
begin
  set new.sname=upper(new.sname);
  set new.course=upper(new.course);
end $$
delimiter ;

insert into student1(sname,age,course)
values("pqr",22,"ds");

select * from student1;

delimiter $$
create trigger student_detail_deletion
after delete on student1
for each row
begin
 insert into student1_logs(student_id,sname,course,action)
 values(old.student_id,old.sname,old.course,"after delete");
end $$
delimiter ;

delete from student1 where student_id=1;
select * from student1;
select * from student1_logs;


#after update
delimiter $$
create trigger students_after_update
after update on student1
for each row
begin
  insert into student1_logs(student_id,sname,course,action)
  values(old.student_id,old.sname,old.course,concat_ws(old.course,"to",new.course));
end $$
delimiter ;

drop trigger students_after_update;

update student1 set course="da" where student_id=3;

select * from student1_logs;

use dummy;
create table customers_log(logid int primary key auto_increment,cid int,cname varchar(100),creditlimit decimal(10,2),
action varchar(100),log_time timestamp default current_timestamp);

#after delete trigger?
delimiter $$
create trigger customer_after_deletion
after delete on customers
for each row
begin
  insert into customers_log(cid,cname,creditlimit,action)
  values(old.customernumber,old.customername,old.creditlimit,"after delete");
end $$
delimiter ;

delete from customers where customernumber=168;
 
select * from customers_log;

#before insert trigger?
delimiter $$
create trigger customers_insertion
before insert on customers
for each row
begin
  set new.customername=upper(trim(new.customername));
  set new.contactfirstname=upper(trim(new.contactfirstname));
  set new.contactlastname=upper(trim(new.contactlastname));
  set new.phone=replace(new.phone," ","");
end $$
delimiter ;

select * from customers;
insert into customers
values(10101,"dgh"," gfd"," ghd","91 59841","1645bhsdgn","h4cscd","bpl","mp","462023","india",1166,002.00);

select * from customers where customernumber=10101;

use dummy;

#create an after update trigger customer may change their creditlimit.
#we want to lock every creditlimit change so we know the history?

delimiter $$
create trigger customers_after_update
after update on customers
for each row
begin
   if new.creditlimit!=old.creditlimit then
   insert into customers_log(cid,cname,creditlimit,action)
   values(old.customernumber,old.customername,old.creditlimit,concat_ws(" ","changecreditlimit",old.creditlimit,"to",new.creditlimit));
  end if;
end $$
delimiter ;
drop trigger customers_after_update;
update customers set creditlimit=20.00 where customernumber=10101;



























  
  

