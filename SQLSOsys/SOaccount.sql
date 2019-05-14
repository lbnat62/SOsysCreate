/* create new user account */
set echo on

spool t:account.txt

prompt ****** CREATE AN ACCOUNT ******
prompt 
select 'Today''s Date: ' ||to_char(sysdate, 'Month dd, yyyy') from dual;

prompt
prompt
accept v_FName prompt 'Please enter your first name: '
prompt
accept v_LName prompt 'Please enter your last name: '
prompt
accept v_Address prompt 'Shipping Address: '
accept v_City prompt 'City: '
accept v_State prompt 'State: '
accept v_ZIP prompt 'Zip Code: '
accept v_Phone prompt 'Phone Number: '
prompt
prompt
insert into Customers values (
	(CNum_seq.nextval),
	'&v_FName',
	'&v_LName',
	'&v_Address',
	'&v_City',
	'&v_State',
	'&v_ZIP',
	'&v_Phone');

prompt *** YOUR ACCOUNT HAS BEEN CREATED ***
select * from Customers where CNum_seq.currval = CustomerID;
