use MIcroSampel
create table DimProduct
(
  productID int primary key ,
  productName varchar(50) not null,
  Category varchar(50) not null ,
  [Sub-category] varchar(50)not null,
  color varchar(15),
  StandardCost money ,
  listprice money ,
)
insert into DimProduct (productID,productName,Category,[Sub-category],color,StandardCost,listprice)
select D.ProductKey ,D.EnglishProductName ,C.EnglishProductCategoryName,S.EnglishProductSubcategoryName,D.Color,D.StandardCost,D.ListPrice
from AdventureWorksDW2019.dbo.DimProduct D  inner join AdventureWorksDW2019.dbo.DimProductSubcategory S 
on D.ProductSubcategoryKey = S.ProductSubcategoryKey inner join AdventureWorksDW2019.dbo.DimProductCategory C
on S.ProductCategoryKey = C.ProductCategoryKey

-------------------------------------------------------------
create table Dimcastomer 
(
  CustomerID int primary key ,
  Name varchar(60) ,
  Gender varchar(10),
)

insert into Dimcastomer(CustomerID,Name,Gender)
select D.CustomerKey,D.FirstName +' ' +D.LastName,case D.Gender when 'M' then 'Male' when 'F' then 'Female' end as Gender
from AdventureWorksDW2019 .dbo.DimCustomer d 
where D.GeographyKey is not null and Gender is not null


--------------------------------------------------------------
create table Dimlocation 
(
  locationID int primary key ,
  Region varchar(50),
  state varchar(50),
  City varchar(30),
  ipaddress varchar(15)
)

insert into Dimlocation(locationID,Region,state,City,ipaddress)
select D.GeographyKey,D.EnglishCountryRegionName,D.StateProvinceName,D.City,D.IpAddressLocator
from AdventureWorksDW2019.dbo.DimGeography  D


---------------------------------------------------
---factsales internet
create table DimDate 
(
  Datekey int primary key ,
  year int ,
  Quarter int ,
  month varchar(10) ,
  Weak int ,
  DayOFweak int ,
  DayOFmonth int
)

insert into DimDate(Datekey,or)
select distinct(D.DateKey),D.FullDateAlternateKey,D.CalendarYear,D.CalendarQuarter,D.EnglishMonthName,D.DayNumberOfWeek,D.DayNumberOfMonth
from AdventureWorksDW2019.dbo.DimDate D inner join AdventureWorksDW2019.dbo.FactInternetSales F
on D.DateKey = F.OrderDateKey