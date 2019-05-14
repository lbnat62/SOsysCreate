/* creating tables */
/* Nick Truex IS380 */


set echo on

spool t:setup.txt
drop sequence Ordercount_seq;
drop table Customers cascade constraints;
drop table Inventory cascade constraints;
drop table Products cascade constraints;
drop table Warehouse cascade constraints;
drop table Orders cascade constraints;



create table Customers (
	CustomerID varchar2(10) primary key,
	Firstname varchar2(25),
	Lastname varchar2(25),
	Address varchar2(30),
	City varchar2(30),
	State varchar2(30),
	ZIP varchar2(10),
	Phone varchar(10));

create table Products (
	ProductID varchar2(10) primary key,
	Productdesc varchar2(20),
	Unitprice number(6,2));

create table Warehouse (
	WarehouseID varchar2(10)primary key,
	Address varchar2(30),
	City varchar2(30),
	State varchar2(30),
	ZIP varchar2(10),
	Phone varchar2(10));

create table Inventory (
	ProductID varchar2(10),
	WarehouseID varchar2(10),
	Inventory number(10),
	primary key(ProductID,WarehouseID),
	constraint fk6 foreign key(ProductID) references Products(ProductID),
	constraint fk7 foreign key(WarehouseID) references Warehouse(WarehouseID));

create table Orders (
	OrderID varchar2(10) primary key,
	Orderstatus varchar2(20),
	Orderdate date,
	CustomerID varchar2(10),
	ProductID varchar2(10),
	Orderqty number(10),
	Unitprice number(6,2),
	Orderamt number(10),
	WarehouseID varchar2(10),
	Shipdate date,
	Shipqty number(10),
	Shipamt number(10),
	constraint fk3 foreign key(CustomerID) references Customers(CustomerID),
	constraint fk4 foreign key(ProductID) references Products(ProductID),
	constraint fk5 foreign key(WarehouseID) references Warehouse(WarehouseID));

create sequence Ordercount_seq
	start with 1000
	increment by 1
	nocache
	nocycle;

insert into Customers values ('101','Nick','Truex','35 Foxcroft','Long Beach','California','90803','9258582788');
insert into Products values ('p1','Pencil','2');
insert into Warehouse values ('w1','123 Apple Way','Long Beach','California','90803','6955447888');
insert into Inventory values ('p1','w1','200');

spool off