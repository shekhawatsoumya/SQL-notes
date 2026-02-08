use dummy;
CREATE TABLE overtime (
    employee_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    hours INT NOT NULL,
     PRIMARY KEY (employee_name,department)
);
INSERT INTO overtime(employee_name, department, hours)
VALUES('Diane Murphy','Accounting',37),
('Mary Patterson','Accounting',74),
('Jeff Firrelli','Accounting',40),
('William Patterson','Finance',58),
('Gerard Bondur','Finance',47),
('Anthony Bow','Finance',66),
('Leslie Jennings','IT',90),
('Leslie Thompson','IT',88),
('Julie Firrelli','Sales',81),
('Steve Patterson','Sales',29),
('Foon Yue Tseng','Sales',65),
('George Vanauf','Marketing',89),
('Loui Bondur','Marketing',49),
('Gerard Hernandez','Marketing',66),
('Pamela Castillo','SCM',96),
('Larry Bott','SCM',100),
('Barry Jones','SCM',65);

select * from overtime;

#wasq to get employeename,overtime and the leastovertime employee?
select employee_name,hours,
first_value(employee_name) over(order by hours 
range between unbounded preceding and unbounded following) as leastovertimeemployee
from overtime;

#wasq to fetch employename,overtime and the least and the highest overtime employee?
select employee_name,hours,
first_value(employee_name) over(order by hours asc
range between unbounded preceding and unbounded following) as leastovertimeemployee,
last_value(employee_name) over(order by hours asc
range between unbounded preceding and unbounded following) as mostovertimeemployee
from overtime;

#wasq to fetch employeename,overtime and the least and the highest overtime employee of each dept?
select employee_name,hours,department,
first_value(employee_name) over(partition by department order by hours asc
range between unbounded preceding and unbounded following) as leastovertimeemployee,
last_value(employee_name) over(partition by department order by hours asc
range between unbounded preceding and unbounded following) as mostovertimeemployee
from overtime;


#FIRST_VALUE and LAST_VALUE

#FIRST_VALUE – Practice Questions
#For each order, show the order date along with the first purchase date of that customer.
select customername,ordernumber,orderdate,
first_value(orderdate) over(partition by customername order by orderdate asc
range between unbounded preceding and unbounded following) as first_purchasedate
from customers join orders using(customernumber);

#For each customer, list the orders along with the first product they ever ordered.
select customername,ordernumber,productname,
first_value(productname) over(partition by customername order by productname
range between unbounded preceding and unbounded following) as fist_productname
from customers join orders using(customernumber)
join orderdetails using(ordernumber)
join products using(productcode);




