#functions
#aggregate fuction
#Group_concat
#wasq to fetch country and their customername(fetch customername in a single row with comma seperated values)?
select country,group_concat(customername) as customername from customers 
group by country;

select country,group_concat(distinct customername order by customername desc separator "/") as customername from customers 
group by country;

 use dummy;
#Controlflow function
#1.Case Expression
#2.If

#1.Case Expression
#a.Simple case expression
#case columname
#when value 1 then result1
#when value 2 then result
#.
#.
#when value N then resultN
#else 'result'
#end

#b.Search case expression
#case
#when expression 1 then result1
#when expression 1 then result1
#.
#.
#when expression N then result N
#else result
#end
#a.Simple case expression
#wasq to fetch customername and their ordercount on the basis of ordercount create one custom column name customer_type
#conditions are 
#if order count is 1 then 1 time customer
#if order count is 2 then repeated customer
#if/when order count is 3 then frequent customer
#if ordercount>=4 then loyal customer

with cte as
(select customername,count(ordernumber) as ordercount from customers join orders using(customernumber)
group by customername)
select*,
case ordercount
when 1 then "one time customer"
when 2 then "repeated customer"
when 3 then "frequent customer"
else "loyal customer"
end as customer_type from cte;

#b.Search Case Expression
#MULTIPLE TABLE

#was to fetch customername and their tov on the basis of tov create one custom column name customer_type 
#now conditions are
#if tov is<10k then silver customer
#if tov between 10k and 100k then gold customer
#if tov is>100k then platinum customer?

with cte as
(select customername,sum(quantityordered*priceeach) tov from customers join 
orders using(customernumber) join orderdetails
using(ordernumber)
group by customername),
cte1 as
(select*,
case
when tov<10000 then "silver customer"
when tov between 10000 and 100000 then "gold customer"
else "platinum customer"
end as customer_type from cte)
select customer_type,count(*) as cust_count from cte1
group by customer_type;






