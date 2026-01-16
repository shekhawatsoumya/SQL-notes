#standard insertion method
#single record insertion
#insert into tablename(colname1,colname2,.....colnameN)
#values (dv1,dv2,....dvN);

insert into stu(stu_id,sname,city,fees,d_o_b,mobile)
values (1,"abc","bhopal",45000,"2000-10-02","+917581876738");

select * from stu;


#multiple record insertion

insert into stu(stu_id,sname,city,fees,d_o_b,mobile)
values (2,"pqr","bhopal",45000,"2000-07-14","+918594762457"),
(3,"xyz","indore",46000,"2000-06-23","+918796541235"),
(4,"def","bhopal",47000,"2000-07-01","+919875412357");

use schooldb1;
desc stu;

insert into stu(stu_id,sname,city,fees,d_o_b,mobile)
values (5,"ghi","bhopal",45000,"2000-10-10","+914598753254"),(6,"jkl","indore",46000,"2001-01-06","+918796541236");

select * from stu;


#extension method
insert into stu set stu_id = 7,
sname = "mno", city = "bhopal",fees = 48000,d_o_b = "2001-07-10",mobile = "+917896542138";


#update
#update tablename set columnname="newdatavalue"
#where primarycolname= value;

update stu set sname="decode" where
stu_id= 1;

#when 1175 error shows
#use syntax set sql_safe_updates=0;

set sql_safe_updates=0;
select * from stu;

#delete
#delete from tablename where primarykeycolname=dv;
delete from stu where stu_id=1;

select * from stu;
#transaction & rollback

start transaction;
delete from stu;
select * from stu;
rollback;


#truncate table stu;

truncate table stu;
select * from stu;

#drop table
#drop table tablename;

drop table stu;

#drop database databasename

drop database schooldb1;

