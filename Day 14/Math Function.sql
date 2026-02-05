#Math function

#abs()
select abs(-10);
select abs(10);
select abs(-10.0);

#Floor 
#returs prior value
select floor(19.9);

#Ceil
#returns next value
select ceil(19.9);

select productline,buyprice from products;
select productline,ceil(avg(buyprice)) as avgbuyprice from products
group by productline;

select productline,floor(avg(buyprice)) as avgbuyprice from products
group by productline;

#MOD(dividend,divisor) - %
#if in case numerator is smaller than denominator than is returns the dividend value
select mod(5,2);
select 5%2;
select mod(10,2);
select mod(2,5); 
#2/5 if numerator is smaller than denominator than is returns the dividend value.
select mod(3,6);









