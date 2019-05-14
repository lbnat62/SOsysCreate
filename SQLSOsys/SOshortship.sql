spool t:shortship.txt

set echo off
set heading off
set verify off
set feedback off

prompt ****** SHORT SHIP REPORT ******

prompt

select 'Today''s Date: '||to_char(sysdate, 'mm/dd/yyyy') from dual;

prompt
prompt

column WID heading 'Warehouse' format a9

column Wloc heading 'City, State' format a12

column Shortorders heading 'Number of|Short Ship|Orders' format 9,999

column Shortamt heading 'Total|Short Ship|Qty' format 99,999

set heading on 

select Orders.WarehouseID WID, Warehouse.City||', '||Warehouse.State Wloc, count(*) Shortorders,
	sum(Orders.Orderqty-Orders.Shipqty) Shortamt from Warehouse, Orders
	where Warehouse.WarehouseID=Orders.WarehouseID
	and Orders.Orderqty > Orders.Shipqty group by Orders.WarehouseID, Warehouse.City, Warehouse.State;
spool off

