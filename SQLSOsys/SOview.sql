set heading off
set echo off
set verify off
set feedback off

spool t:show.txt


prompt ****** SHOW ORDER DETAILS ******

prompt

accept v_OrderID prompt 'Please enter the Order Number: '

prompt

select 'Order Number: '||OrderID from Orders
	where OrderID=&v_OrderID;

select 'Order Status: '||Orderstatus from Orders
	where OrderID=&v_OrderID;

prompt


select 'Customer Number: '||Customers.CustomerID
	||chr(10)||'	'||Lastname||', '||Firstname
	||chr(10)||'	'||Address
	||chr(10)||'	'||City||', '||State||'   '||Zip
	||chr(10)||'	'||'('||substr(Phone,1,3)||')'||substr(Phone,4,3)||'-'||substr(Phone,7,4) from Orders, Customers
		where Orders.OrderID=&v_OrderID
		and Orders.CustomerID=Customers.CustomerID;

prompt

select 'Product Number: '||Products.ProductID
	||chr(10)||'	'||'Item Description: '||Productdesc
	||chr(10)||'	'||'Unit Price: '||to_char(Products.Unitprice,'99,999,99') from Orders, Products
		where Orders.OrderID=&v_OrderID and Orders.ProductID=Products.ProductID;

prompt

select 'Order Date: '||to_char(Orderdate, 'Month dd, yyyy') from Orders 
	where OrderID=&v_OrderID

select 'Shipping Date: '||
	case
	when Shipdate is null
	then 'not shipped'
	else to_char(Shipdate, 'Month dd, yyyy')
	end
	from Orders 
	where OrderID=&v_OrderID;

prompt
select 'Quantity Ordered: '||Orderqty from Orders
	where OrderID=&v_OrderID;

select 'Amount Ordered: '||to_char(Orderamt, '$99,999.99') from Orders
	where OrderID=&v_OrderID;

select 'Quantity Shipped: '||
	case
	when Shipqty is null
	then '------'
	else to_char(Shipqty)
	end
	from Orders
	where OrderID=&v_OrderID;

select 'Amount Shipped: '||
	case
	when Shipamt is null
	then '------'
	else to_char(Shipamt, '$99,999.99')
	end
	from Orders
	where OrderID=&v_OrderID;

prompt
prompt
select 'Shipping Warehouse: '||Warehouse.WarehouseID
	||chr(10)||'	'||Address
	||chr(10)||'	'||City||', '||State||' '||Zip
	||chr(10)||'	'||'('||substr(Phone,1,3)||')'||substr(Phone,4,3)||'-'||substr(Phone,7,4) from Orders, Warehouse
		where Orders.OrderID=&v_OrderID
		and Orders.WarehouseID=Warehouse.WarehouseID;

spool off
