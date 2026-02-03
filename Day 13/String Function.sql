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

