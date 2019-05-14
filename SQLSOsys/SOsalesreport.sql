spool t:salesreport.txt

set heading on

prompt ****** SALES REPORT ******

prompt

column ProdID heading 'Prod|No' format a7

column Proddesc heading 'Product|Name' format a12

column Ordermo heading 'Order|Month' format a7

column Noord heading 'No of|Orders' format 99

column Totalqty heading 'Total|Qty' format 999,999

column Totalamt heading 'Total|Amount' format $99,999.99

select Products.ProductID ProdID, Productdesc Proddesc, to_char(Orderdate, 'mm/yyyy') Ordermo,
	count(OrderID) Noord, sum(Orderqty) Totalqty, sum(Orderamt) Totalamt from Products, Orders 
	where Products.ProductID = Orders.ProductID group by Products.ProductID, Productdesc,
	to_char(Orderdate, 'mm/yyyy') order by Products.ProductID; 

