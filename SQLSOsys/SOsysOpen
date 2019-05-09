set heading off
set feedback off
set echo off
set verify off

spool t:open.txt


prompt ****** OPEN AN ORDER ******
prompt
select 'Today''s Date: ' ||to_char(sysdate, 'Month dd, yyyy') from dual;

/* show customer info */

prompt

accept var_CustomerID prompt 'Enter the Customer Number: ';

prompt

select '	Customer Name: '||Lastname||', '||Firstname from Customers 
	where CustomerID='&var_CustomerID';

select '	Shipping Address: '||Address from Customers 
	where CustomerID='&var_CustomerID';

select '	City, State, Zip: '||City||', '||State||', '||Zip from Customers
	where CustomerID='&var_CustomerID';

/* splitting the phone number into substrings */

select '	Phone: '||'('||substr(Phone,1,3)||')'||substr(Phone,4,3)||'-'||
	substr(Phone,7,4) from Customers
	where CustomerID='&var_CustomerID';

/* showing the product info */

prompt

accept var_ProductID prompt 'Enter the Item Number: ';

select '	Item Number: '||ProductID from Products 
	where ProductID='&var_ProductID';

select '	Item Description: '||Productdesc from Products
	where ProductID='&var_ProductID';

select '	Unit Price: '||to_char(Unitprice,'$99,999.99') from Products
	where ProductID='&var_ProductID';

/* show amount ordered from the quantity entered */

prompt

accept var_Orderqty prompt 'Enter the quantity ordered: ';

select '	Amount Ordered: '||to_char(&var_Orderqty*Unitprice, '$99,999.99') from Products
	where ProductID='&var_ProductID';

/* showing all the warehouses that carry the product */

prompt 
prompt Please choose from the following warehouses: 
prompt
prompt Warehouse City,State Zip Inventory
select Inventory.WarehouseID||City	||', '||	State||	Zip||	(to_char(Inventory)) from Warehouse, Inventory
	where ProductID='&var_ProductID' and Warehouse.WarehouseID=Inventory.WarehouseID;
prompt

accept var_WarehouseID prompt 'Enter the warehouse code: ';

/* inserting a new record */

insert into Orders values (
	(Ordercount_seq.nextval),
	'OPEN',
	sysdate,
	'&var_CustomerID',
	'&var_ProductID',
	'&var_Orderqty',
	(select Unitprice from Products 
		where Products.ProductID='&var_ProductID'),
	(select Unitprice*&var_Orderqty from Products 
		where Products.ProductID='&var_ProductID'),
	'&var_WarehouseID',
	null,
	null,
	null);

prompt
prompt ***** Order Status: OPEN
select '***** Order number is ----->'
||Ordercount_seq.currval from dual;
commit;

	
spool off