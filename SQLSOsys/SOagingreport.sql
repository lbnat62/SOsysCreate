spool t:aging.txt

set echo off
set heading off
set verify off
set feedback off

prompt ****** AGING REPORT ******

prompt

select 'Today''s Date '||to_char(sysdate, 'mm/dd/yyyy') from dual;

prompt
prompt

column OrdID heading 'Order|Number' format a4
column Orddate heading 'Order|Date' format a10
column Ordstatus heading 'Order|Status' format a7
column ProdID heading 'Prod|Num' format a4
column Proddesc heading 'Product|Description' format a9
column Ordqty heading 'Order|Qty' format 999
column Unitpr heading 'Unit|Price' format $999.99
column Ordamt heading 'Order|Amount' format $9,999.99
column Dayso heading 'Days|Open' format 999

set heading on
select Orders.OrderID OrdID, to_char(Orders.Orderdate, 'mm/dd/yyyy') Orddate, Orders.Orderstatus Ordstatus,
	Orders.ProductID ProdID, Products.Productdesc, Orders.Orderqty Ordqty, Orders.Unitprice Unitpr, 
	Orders.Orderamt Ordamt, (sysdate - Orders.Orderdate) Dayso from Orders, Products 
	where Products.ProductID = Orders.ProductID and Orders.Orderstatus = 'OPEN';

clear column

spool off