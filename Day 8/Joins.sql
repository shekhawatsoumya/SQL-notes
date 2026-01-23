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



