#STRING Function
# concat(string1,string2,...stringN)
select customername,concat(city," ",state," ",country," ",postalcode)as
customerfulladd from customers;

#concat_ws(separator,string1,string2,...stringN)
#it works on non null value only. 
#ws - with separator
select customername,concat_ws(" ",city,state,country,postalcode)as
customerfulladd from customers;

select customername,concat_ws("/",city,state,country,postalcode)as
customerfulladd from customers;

#Upper(string)
select upper(customername),country from customers;

#lower(string)
select lower(customername) from customers;

#length(string)-return no of characters in a given string.
select productline,length(textdescription) from productlines;

#reverse(string)
select reverse("decode");

#trim(string)
# is used for removing unwanted leading and trailing
# whites paces from the given string.
select trim("  decode  data"  );

#ltrim(string)
select ltrim("   decode   data"   );

#rtrim(string)
select rtrim("   decode   data"   );

#replace(string,oldsubstring,new substring)
select replace("welcome to bhopal","bhopal","to city of lakes");
select replace("welcome to bhopal","o","a");
select replace("welcome to bhopal","a","o");
select replace("welcome to bhopol","bhopol","bhopal");


use dummy;
#wasq to fetch employeefullname and their respective customerfullname 
#and also fetch their total ordervalue of year 2003?
select concat_ws(" ",firstname,lastname) as empfullname,
concat_ws(" ",contactfirstname,contactlastname) as custfullname,
sum(quantityordered*priceeach) as tov from employees e 
join customers c on e.employeenumber=c.salesrepemployeenumber join orders using(customernumber)
join orderdetails using(ordernumber) where year(orderdate) = 2003
group by 1,2;

use dummy;

# extract substring from given string.
# LEFT(string,length)- 
# extract substring from left hand side of string.

# RIGHT(string,length)
# extract substring from right side side of the string.

# SUBSTRING(string,offset,length)
# extract substring from given string.

select left("decode",3);
select right("bhopal",3);
select substring("decode",1,3);
select substring("decode",-3,3);

# wasq to fetch customername whose name start with vowels?
select customername from customers
where left(customername,1) in ("a","e","i","o","u") and 
right(customername,1) in ("a","e","i","o","u");

select customername from customers
where substring(customername,1,1) in ("a","e","i","o","u") 
and substring(customername,-1,1) in ("a","e","i","o","u");

use dummy;
#wasql to fetch employees fullname whose first name starts with vowel and 
#lastname ends with consonant with help of substring function?
select concat_ws(" ",firstname,lastname) as empfullname from employees
where substring(firstname,1,1) in ("a","e","i","o","u") and
substring(lastname,-1,1) not in ("a","e","i","o","u");


# instr(string,substring)

select instr("welcome to bhopal","w");
select instr("welcome to bhopal","o");
select instr("welcome to bhopal","bhopal");
select instr("welcome to bhopal","bho");
select instr("decode","z");

#wasq to fetch productname that contain car key word in it(with the help of instr function)?
select productname from products
where instr(productname,"car");

select instr(productname,"car") from products;

