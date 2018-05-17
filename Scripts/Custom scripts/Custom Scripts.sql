--1.2.1
select ContactName, Country from Customers
where Country in ('USA', 'Canada')
order by ContactName, Country

--1.2.2
select ContactName, Country from Customers
where Country not in ('USA', 'Canada')
order by ContactName

--1.2.3
select distinct Country from Customers
order by Country desc

--1.4
select ProductName from Products
where ProductName like '%cho_olade%'


--2.1.1
select sum(UnitPrice * Quantity * (1 - Discount)) as Totals
from [Order Details]

--2.1.2
select count(*) - count(ShippedDate) from Orders

--2.1.3
select count(distinct CustomerID) from Orders


--2.3.1
select distinct e.EmployeeID, e.FirstName + ' ' + e.LastName as FullName
from Employees e
join EmployeeTerritories et
on e.EmployeeID = et.EmployeeID
join Territories t
on et.TerritoryID = t.TerritoryID
join Region r
on r.RegionID = t.RegionID
where r.RegionDescription = 'Western'


--2.3.2
select c.ContactName, count(o.CustomerID) as OrdersCount
from Customers c
left join Orders o
on c.CustomerID = o.CustomerID
group by c.ContactName
order by count(o.CustomerID) asc


--2.4.1
select CompanyName from Suppliers s
where SupplierID in 
(
	select SupplierID
	from Products
	where UnitsInStock = 0
)


--2.4.2
select e.EmployeeID, e.FirstName, e.LastName, o.OrdersCount from Employees e
join (
	select EmployeeID, count(*) as OrdersCount
	from Orders
	group by EmployeeID
	having count(*) > 150
) as o
on e.EmployeeID = o.EmployeeID


--2.4.3
select * from Customers c
where not exists 
(
	select *
	from Orders o
	where o.CustomerID = c.CustomerID
)


--3.1

-- 1.0 -> 1.1
use Northwind;

if object_id(N'EmployeeCreditCards', N'U') is null
create table EmployeeCreditCards
(
	CreditCardID int identity (1, 1) not null primary key,
	CardNumber bigint not null,
	ExpiredDate datetime not null,
	CardHolder varchar not null,
	EmployeeID int not null,
	constraint FK_EmployeeCreditCards_Employees foreign key (EmployeeID) references Employees (EmployeeID)
);


-- 1.1 -> 1.3
use Northwind;

if object_id(N'Region', N'U') is not null
execute sp_rename N'Region', N'Regions'

if col_length('Customers','FoundationDate') is null
alter table Customers
add FoundationDate datetime null