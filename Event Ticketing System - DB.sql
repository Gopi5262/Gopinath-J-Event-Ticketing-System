  #Create a database#
CREATE DATABASE EventTicketingSystem;

  #Use the database#
USE EventTicketingSystem;

  #Create a table for Events#
  
CREATE TABLE Events (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    EventName VARCHAR(50) ,
    EventDate DATE,
    Location VARCHAR(50),
    TotalTickets INT,
    TicketsAvailable INT NOT NULL);

INSERT INTO Events (EventName, EventDate, Location, TotalTickets, TicketsAvailable)
VALUES 
('Music Concert', '2024-03-15', 'Chennai', 5000, 4500),
('Art Exhibition', '2024-04-10', 'Selam', 300, 250),
('Tech Conference', '2024-05-20', 'Coimbatore', 1000, 950),
('Food Festival', '2024-06-25', 'Chennai', 2000, 1750),
('Film Premiere', '2024-07-10', 'Vellore', 800, 750);

Select * from Events; 

  #Create the Tickets table#
  
CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    EventID INT,
    Price int NOT NULL,
    TicketType VARCHAR(50) NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Events(EventID));

INSERT INTO Tickets (EventID, Price, TicketType) VALUES
(1, 1000, 'General'),
(4, 500, 'Standard'),
(2, 750, 'Premium'),
(5, 1500, 'VIP'),
(3, 500, 'General');    
    
Select* from Tickets;

  #Create the Customers table#
  
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(20) NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15));

INSERT INTO Customers (CustomerName, Email, PhoneNumber)
VALUES
    ('John', 'johndoe@example.com', '1234567890'),
    ('Smith', 'janesmith@example.com', '9876543210'),
    ('Johnson', 'alice.johnson@example.com', '4567891230'),
    ('Nandy', 'Nandyannie@example.com', '9817634500'),
    ('Dinesh', 'Dinesh564@example.com', '9940094999'),
    ('Jasmine', 'Jasminejohn@example.com', '8850005437'),
    ('Akil', 'Akilan87@example.com', '9548765356'),
    ('Manoj', 'Manojmax@example.com', '9689785746'),
    ('Boby', 'bob.brown@example.com', 8657900123);

Select* from Customers;

 #Create the Reservations table#
 
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    TicketID INT,
    ReservationDate DATETIME NOT NULL,
    Status enum('Reserved', 'Purchased', 'Cancelled') DEFAULT 'Reserved',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID));
    
 INSERT INTO Reservations (CustomerID, TicketID, ReservationDate, Status) VALUES
(1, 1, '2024-12-22 10:30:00', 'Reserved'),
(2, 2, '2024-12-24 11:55:00', 'Purchased'),
(3, 3, '2024-11-20 09:15:00', 'Reserved'),
(4, 4, '2024-10-25 07:00:00', 'Purchased'),
(5, 5, '2024-12-26 11:55:00', 'Reserved'),
(6, 1, '2024-09-11 09:40:00', 'Reserved'),
(7, 2, '2024-12-15 11:10:00', 'Purchased'),
(8, 3, '2024-08-20 12:40:00', 'Cancelled'),
(9, 4, '2024-05-04 07:30:00', 'Cancelled');   

Select* From Reservations;
 
 #Create the Sales table#
 
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    ReservationID INT,
    SaleDate DATETIME NOT NULL,
    TotalAmount int NOT NULL,
    FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID));
    
INSERT INTO Sales (ReservationID, SaleDate, TotalAmount) VALUES
(1, '2024-12-22 10:30:00', 1000),
(2, '2024-12-24 11:55:00', 1500),
(3, '2024-11-20 09:15:00', 1475),
(4, '2024-10-25 07:00:00', 4200),
(5, '2024-12-26 11:55:00', 3000),
(6, '2024-09-11 09:40:00', 2500),
(7, '2024-12-15 11:10:00', 7500);

Select* From Sales;

#Using Alter#
Alter Table Sales MODIFY COLUMN Saledate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
Alter table Customers add name varchar(20);
Alter table Sales rename Sales_details;


#Join Function#
select * from Events E inner join Tickets T on E.EventID=T.EventID;
select * from Customers C inner join Reservations R on C.CustomerID=R.CustomerID;
SELECT E.EventName, COUNT(S.SaleID) AS TicketsSold, SUM(S.TotalPrice) AS TotalRevenue
FROM Sales S
JOIN Events E ON S.EventID = E.EventID
GROUP BY S.EventID;



#WHERE Clause#
SELECT * FROM Reservations WHERE Status = 'Purchased';
select* from Customers where CustomerName not in ('Smith', 'Johnson'); 
select* from Customers where CustomerName in ('Smith', 'Johnson'); 

#Use Update#
update Sales set TotalAmount = 3750 
 where SaleID = '6';
select* From Sales;

#Order by#
select * from Customers order by CustomerID asc;
select * from Customers order by CustomerID desc limit 2;
select * from Customers order by CustomerID desc limit 1 offset 2;

#Subquery#
Select CustomerName From Customers
where CustomerName like 'J%';
Select CustomerName From Customers
where CustomerName like '%n';
Select Status From Reservations
where Status like '%C%';

#STRING FUNCTION#
select char_length(Status) from Reservations;
select ucase(CustomerName) from Customers;
select Lcase(CustomerName) from Customers;


select count(EventID)from Events;
select Sum(TotalAmount)from Sales;
select Min(TotalAmount)from Sales;
select max(TotalAmount)from Sales;
select avg(Price)from Tickets;

# INDEX FUNCTION 
create index indx_Price on Tickets(Price);
show index from Tickets;

select CustomerName,Count(CustomerID) from Customers group by CustomerName
having count(CustomerID);

#STORE PROCEDURE#
delimiter $$
create procedure get_Sales(in input_SaleID int)
begin
    select count(SaleID) as TotalSales from Sales where SaleID = input_SaleID;
end $$
delimiter ;    


