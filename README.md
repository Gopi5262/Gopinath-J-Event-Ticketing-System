# Gopinath-J-Event-Ticketing-System

**Event Ticketing System**

The Event Ticketing System is a comprehensive database schema designed to manage events, tickets, reservations, customer information, and sales transactions efficiently. Below is an overview of the system and its components.

**Features and Functionalities**

Event Management: Create, update, and delete events.

Ticket Inventory: Manage ticket availability and pricing.

Reservations: Allow customers to reserve tickets for events.

Customer Management: Maintain detailed customer records.

Sales Tracking: Record and manage ticket sales transactions.

**Usage**

Use SQL queries to interact with the database.

**Sample Queries**

1.Select * from Events; 
2.Select* from Tickets;

3.Alter table Customers add name varchar(20);
4.Alter table Sales rename Sales_details;

5.select * from Events E inner join Tickets T on E.EventID=T.EventID;
6.select * from Customers C inner join Reservations R on C.CustomerID=R.CustomerID;

7.SELECT * FROM Reservations WHERE Status = 'Purchased';
8.select* from Customers where CustomerName not in ('Smith', 'Johnson'); 

