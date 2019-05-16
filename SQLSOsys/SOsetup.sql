/* creating tables */
/* Nick Truex IS380 */
/* creating tables */
/* Nick Truex IS380 */


set echo on

spool t:setup.txt
drop sequence Ordercount_seq;
drop sequence CNum_seq;
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
create sequence CNum_seq
	start with 100
	increment by 1
	nocache
	nocycle;


insert into Products values ('p1','Pencil','2');
insert into Products values ('p2', 'Pen', '3');
insert into Products values ('p3', 'Ruler', '6');
insert into Products values ('p4', 'Calculator', '60');
insert into Products values ('p5', '100 Page Notebook', '20');
insert into Products values ('p6', 'Folder', '10');
insert into Inventory values ('p1', 'w1', '500');
insert into Inventory values ('p1', 'w3', '1000');
insert into Inventory values ('p2', 'w2', '2000');
insert into Inventory values ('p2', 'w4', '1000');
insert into Inventory values ('p2', 'w6', '800');
insert into Inventory values ('p3', 'w1', '500');
insert into Inventory values ('p4', 'w1', '100');
insert into Inventory values ('p4', 'w3', '250');
insert into Inventory values ('p5', 'w1', '200');
insert into Inventory values ('p5', 'w2', '50');
insert into Inventory values ('p5', 'w5', '70');
insert into Inventory values ('p6', 'w4', '100');
insert into Inventory values ('p6', 'w5', '500');
insert into Warehouse values ('w1','123 Apple Way','Long Beach','California','90803','6955447888');
insert into Warehouse values ('w2','34 Orange Street','Westmin','California','94532','9081232345');
insert into Warehouse values ('w3','4345 Industrial Way','Hayward','California','90034','5103214567');
insert into Warehouse values ('w4','3 Seven Street','Oakland','California','94542','5101230987');
insert into Warehouse values ('w5','90 Sun Way','Tuscon','Arizona','87512','3215550985');
insert into Warehouse values ('w6','123 Igloo Drive','Seattle','Washington','85560','9085556660');


spool off
