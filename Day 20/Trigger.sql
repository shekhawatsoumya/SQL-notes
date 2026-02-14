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





























  
  

