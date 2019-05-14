set echo off
set feedback off
set verify off
set heading off

spool t:ship.txt

prompt ****** UPDATE SHIPPING ******
prompt

accept v_OrderID prompt 'Please enter your Order Number: ';
prompt


select 'Order Number: '|| OrderID from Orders
	where OrderID = &v_OrderID;

select 'Order Date: '|| Orderdate from Orders
	where OrderID = &v_OrderID;

select 'Customer Number: '|| CustomerID from Orders
	where OrderID = &v_OrderID;

select '	'||Lastname||', '||Firstname from Orders, Customers
	where OrderID = &v_OrderID and Orders.CustomerID = Customers.CustomerID;

select '	'||Address from Customers, Orders
	where OrderID = &v_OrderID and Orders.CustomerID = Customers.CustomerID;

select '	'||City||', '||State||' '||ZIP from Orders, Customers
	where OrderID = &v_OrderID and Orders.CustomerID = Customers.CustomerID;

select '	'||'('||substr(Phone,1,3)||')'||substr(Phone,4,3)||'-'||
	substr(Phone,7,4) from Customers, Orders
	where OrderID = &v_OrderID and Orders.CustomerID = Customers.CustomerID;

select 'Item Number: '||ProductID from Orders
	where OrderID = &v_OrderID;

select '	Item Description: '|| Productdesc from Orders, Products
	where OrderID = &v_OrderID and Orders.ProductID = Products.ProductID;

select '	Unit Price: '||to_char(Orders.Unitprice,'$99,999.99')
	from Orders, Products
	where OrderID = &v_OrderID and Orders.ProductID = Products.ProductID;

select 'Quantity Ordered: '||Orderqty from Orders
	where OrderID = &v_OrderID;

select 'Amount Ordered: '||(to_char(Orderamt, '$99,999.99')) from Orders
	where OrderID = &v_OrderID;
prompt
select 'Shipping Warehouse: '||WarehouseID from Orders
	where OrderID = &v_OrderID;

select '	'||Address from Orders, Warehouse
	where OrderID = &v_OrderID and Orders.WarehouseID = Warehouse.WarehouseID;

select '	'||City||', '||State||'     '||ZIP from Orders, Warehouse
	where OrderID = &v_OrderID and Orders.WarehouseID = Warehouse.WarehouseID;

select '	'||'('||substr(Phone,1,3)||')'||substr(Phone,4,3)||'-'||substr(Phone,7,4)
	from Orders, Warehouse
	where OrderID = &v_OrderID and Orders.WarehouseID = Warehouse.WarehouseID;

prompt

accept v_Shipqty prompt 'Please enter quantity shipped: ';

prompt

update Orders set Shipdate = (select sysdate from dual),
	Shipqty = &v_Shipqty,
	Shipamt = &v_Shipqty * (select Unitprice from Orders where OrderID = &v_OrderID),
	Orderstatus = 'SHIPPED'
	where OrderID = &v_OrderID;

update Inventory set Inventory = Inventory - &v_Shipqty
	where WarehouseID = (select WarehouseID from Orders where OrderID = &v_OrderID)
	and ProductID = (select ProductID from Orders where OrderID = &v_OrderID);

prompt
prompt ***************************
select 'Order is now ----> '||Orderstatus from Orders
	where OrderID = &v_OrderID;

select 'Date Shipped: '||Shipdate from Orders
	where OrderID = &v_OrderID;

select 'Quantity Shipped: '||Shipqty from Orders
	where OrderID = &v_OrderID;

select 'Amount Shipped: '||(to_char(Shipamt, '$99,999.99')) from Orders
	where OrderID = &v_OrderID;

spool off