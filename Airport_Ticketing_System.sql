------------------------------------------------------------
-- CREATING DATABASE
------------------------------------------------------------

-- Create Database
CREATE DATABASE AirportTicketingDB;
GO

-- Use the created database
USE AirportTicketingDB;
GO
------------------------------------------------------------
-- 1 CREATING TABLE
------------------------------------------------------------

-- Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Role VARCHAR(30) NOT NULL CHECK (Role IN ('Ticketing Staff', 'Ticketing Supervisor')),
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL
);

-- Passengers table
CREATE TABLE Passengers (
    PassengerID INT PRIMARY KEY IDENTITY(1,1),
    PNR VARCHAR(10) NOT NULL UNIQUE,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Meal VARCHAR(20) CHECK (Meal IN ('vegetarian', 'non-vegetarian', 'gluten-free', 'vegan', 'kosher', 'halal', 'dairy-free')),
    DOB DATE NOT NULL,
    EmergencyContact VARCHAR(20) NULL
);

-- Flights table
CREATE TABLE Flights (
    FlightID INT PRIMARY KEY IDENTITY(1,1),
    FlightNumber VARCHAR(10) NOT NULL UNIQUE,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    Origin VARCHAR(100) NOT NULL,
    Destination VARCHAR(100) NOT NULL
);

-- Seats table to track seat availability
CREATE TABLE Seats (
    SeatID INT PRIMARY KEY IDENTITY(1,1),
    FlightID INT NOT NULL,
    SeatNumber VARCHAR(10) NOT NULL,
    SeatClass VARCHAR(20) CHECK (SeatClass IN ('Economy', 'Business', 'FirstClass')),
    IsReserved BIT DEFAULT 0,  -- 0 = Available, 1 = Reserved
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Reservations table
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    PNR VARCHAR(10) NOT NULL UNIQUE,
    ReservationDate DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
    PassengerID INT,
    FlightID INT,
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Tickets table
CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    Fare DECIMAL(10, 2) NOT NULL,
    Seat VARCHAR(10) NULL,
    Class VARCHAR(20) NOT NULL CHECK (Class IN ('Economy', 'Business', 'FirstClass')),
    FlightID INT NOT NULL,
    ReservationID INT NOT NULL,
    EmployeeID INT NOT NULL,
    IssueDate DATE DEFAULT GETDATE(),
    IssueTime TIME DEFAULT GETDATE(),
    EBoardingNumber VARCHAR(20),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Baggage table
CREATE TABLE Baggage (
    BaggageID INT PRIMARY KEY IDENTITY(1,1),
    Weight DECIMAL(5, 2) NOT NULL,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('CheckedIn', 'Loaded', 'In Transit', 'Delivered', 'Lost')),
    Fee DECIMAL(10, 2) NOT NULL,
    TicketID INT NOT NULL,
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
);

-- Services table
CREATE TABLE Services (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),
    TicketID INT NOT NULL,
    ServiceType VARCHAR(50) NOT NULL,
    Fee DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
);

-- Employee login logs
CREATE TABLE EmployeeLoginLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    LoginTime DATETIME NOT NULL DEFAULT GETDATE(),
    Action VARCHAR(50) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

------------------------------------------------------------
-- INSERT DATA
------------------------------------------------------------

-- Insert data into Employees
INSERT INTO Employees (Name, Email, Role, Username, Password) VALUES
('Aisha Khan', 'aisha.khan@example.com', 'Ticketing Staff', 'aishak', 'password123'),
('Carlos Garcia', 'carlos.garcia@example.com', 'Ticketing Supervisor', 'carlosg', 'password456'),
('Fatima Ali', 'fatima.ali@example.com', 'Ticketing Staff', 'fatimaa', 'password789'),
('Raj Patel', 'raj.patel@example.com', 'Ticketing Supervisor', 'rajp', 'password321'),
('Yuki Tanaka', 'yuki.tanaka@example.com', 'Ticketing Staff', 'yukit', 'password654'),
('Liam O’Connor', 'liam.oconnor@example.com', 'Ticketing Staff', 'liamo', 'password987'),
('Chloe Dubois', 'chloe.dubois@example.com', 'Ticketing Supervisor', 'chloed', 'password159'),
('Omar El-Sayed', 'omar.elsayed@example.com', 'Ticketing Staff', 'omare', 'password753'),
('Sofia Rossi', 'sofia.rossi@example.com', 'Ticketing Supervisor', 'sofiar', 'password852'),
('Nia Mwangi', 'nia.mwangi@example.com', 'Ticketing Staff', 'niam', 'password963');

-- Insert data into Passengers
INSERT INTO Passengers (PNR, FirstName, LastName, Email, Meal, DOB, EmergencyContact) VALUES
('PNR001', 'John Smith', 'Doe', 'john.smith@example.com', 'vegetarian', '1985-05-15', '123-456-7890'),
('PNR002', 'Maria Gonzalez', 'Lopez', 'maria.gonzalez@example.com', 'non-vegetarian', '1990-08-20', '098-765-4321'),
('PNR003', 'Akira Yamamoto', 'Tanaka', 'akira.tanaka@example.com', 'gluten-free', '1988-12-30', '555-555-5555'),
('PNR004', 'Amina Mohammed', 'Ali', 'amina.ali@example.com', 'kosher', '1975-03-10', '444-444-4444'),
('PNR005', 'Liam O’Reilly', 'Murphy', 'liam.murphy@example.com', 'vegan', '1995-07-25', '333-333-3333'),
('PNR006', 'Fatou Ndiaye', 'Diallo', 'fatou.diallo@example.com', 'halal', '1982-11-11', '222-222-2222'),
('PNR007', 'Zara Khan', 'Patel', 'zara.patel@example.com', 'dairy-free', '1992-01-01', '111-111-1111'),
('PNR008', 'Chen Wei', 'Li', 'chen.li@example.com', 'non-vegetarian', '1980-04-04', '666-666-6666'),
('PNR009', 'Sofia Ivanova', 'Petrova', 'sofia.petrova@example.com', 'vegetarian', '1993-09-09', '777-777-7777'),
('PNR010', 'Omar Farouk', 'Hassan', 'omar.hassan@example.com', 'gluten-free', '1987-02-14', '888-888-8888');

-- Insert data into Flights
INSERT INTO Flights (FlightNumber, DepartureTime, ArrivalTime, Origin, Destination) VALUES
('FL001', '2025-05-01 08:00:00', '2025-05-01 10:00:00', 'New York', 'Los Angeles'),
('FL002', '2025-05-02 09:30:00', '2025-05-02 12:30:00', 'Mexico City', 'Miami'),
('FL003', '2025-05-03 14:00:00', '2025-05-03 16:00:00', 'Tokyo', 'Seattle'),
('FL004', '2025-05-04 07:15:00', '2025-05-04 09:15:00', 'Mumbai', 'Dubai'),
('FL005', '2025-05-05 11:45:00', '2025-05-05 14:00:00', 'London', 'Paris'),
('FL006', '2025-05-06 15:30:00', '2025-05-06 17:30:00', 'Sydney', 'Auckland'),
('FL007', '2025-05-07 18:00:00', '2025-05-07 20:00:00', 'Cairo', 'Istanbul'),
('FL008', '2025-05-08 10:00:00', '2025-05-08 12:00:00', 'Rio de Janeiro', 'Buenos Aires'),
('FL009', '2025-05-09 13:00:00', '2025-05-09 15:00:00', 'Berlin', 'Amsterdam'),
('FL010', '2025-05-10 16:30:00', '2025-05-10 18:30:00', 'Toronto', 'Vancouver');

-- Insert Economy Seats for each flight
INSERT INTO Seats (FlightID, SeatNumber, SeatClass, IsReserved)
VALUES
(1, 'E1', 'Economy', 0), (1, 'E2', 'Economy', 0), (1, 'E3', 'Economy', 0),
(2, 'E1', 'Economy', 0), (2, 'E2', 'Economy', 0), (2, 'E3', 'Economy', 0),
(3, 'E1', 'Economy', 0), (3, 'E2', 'Economy', 0), (3, 'E3', 'Economy', 0),
(4, 'E1', 'Economy', 0), (4, 'E2', 'Economy', 0), (4, 'E3', 'Economy', 0),
(5, 'E1', 'Economy', 0), (5, 'E2', 'Economy', 0), (5, 'E3', 'Economy', 0),
(6, 'E1', 'Economy', 0), (6, 'E2', 'Economy', 0), (6, 'E3', 'Economy', 0),
(7, 'E1', 'Economy', 0), (7, 'E2', 'Economy', 0), (7, 'E3', 'Economy', 0),
(8, 'E1', 'Economy', 0), (8, 'E2', 'Economy', 0), (8, 'E3', 'Economy', 0),
(9, 'E1', 'Economy', 0), (9, 'E2', 'Economy', 0), (9, 'E3', 'Economy', 0),
(10, 'E1', 'Economy', 0), (10, 'E2', 'Economy', 0), (10, 'E3', 'Economy', 0);

-- Insert Business Seats for each flight
INSERT INTO Seats (FlightID, SeatNumber, SeatClass, IsReserved)
VALUES
(1, 'B1', 'Business', 0), (1, 'B2', 'Business', 0), (1, 'B3', 'Business', 0),
(2, 'B1', 'Business', 0), (2, 'B2', 'Business', 0), (2, 'B3', 'Business', 0),
(3, 'B1', 'Business', 0), (3, 'B2', 'Business', 0), (3, 'B3', 'Business', 0),
(4, 'B1', 'Business', 0), (4, 'B2', 'Business', 0), (4, 'B3', 'Business', 0),
(5, 'B1', 'Business', 0), (5, 'B2', 'Business', 0), (5, 'B3', 'Business', 0),
(6, 'B1', 'Business', 0), (6, 'B2', 'Business', 0), (6, 'B3', 'Business', 0),
(7, 'B1', 'Business', 0), (7, 'B2', 'Business', 0), (7, 'B3', 'Business', 0),
(8, 'B1', 'Business', 0), (8, 'B2', 'Business', 0), (8, 'B3', 'Business', 0),
(9, 'B1', 'Business', 0), (9, 'B2', 'Business', 0), (9, 'B3', 'Business', 0),
(10, 'B1', 'Business', 0), (10, 'B2', 'Business', 0), (10, 'B3', 'Business', 0);

-- Insert FirstClass Seats for each flight
INSERT INTO Seats (FlightID, SeatNumber, SeatClass, IsReserved)
VALUES
(1, 'F1', 'FirstClass', 0), (1, 'F2', 'FirstClass', 0), (1, 'F3', 'FirstClass', 0),
(2, 'F1', 'FirstClass', 0), (2, 'F2', 'FirstClass', 0), (2, 'F3', 'FirstClass', 0),
(3, 'F1', 'FirstClass', 0), (3, 'F2', 'FirstClass', 0), (3, 'F3', 'FirstClass', 0),
(4, 'F1', 'FirstClass', 0), (4, 'F2', 'FirstClass', 0), (4, 'F3', 'FirstClass', 0),
(5, 'F1', 'FirstClass', 0), (5, 'F2', 'FirstClass', 0), (5, 'F3', 'FirstClass', 0),
(6, 'F1', 'FirstClass', 0), (6, 'F2', 'FirstClass', 0), (6, 'F3', 'FirstClass', 0),
(7, 'F1', 'FirstClass', 0), (7, 'F2', 'FirstClass', 0), (7, 'F3', 'FirstClass', 0),
(8, 'F1', 'FirstClass', 0), (8, 'F2', 'FirstClass', 0), (8, 'F3', 'FirstClass', 0),
(9, 'F1', 'FirstClass', 0), (9, 'F2', 'FirstClass', 0), (9, 'F3', 'FirstClass', 0),
(10, 'F1', 'FirstClass', 0), (10, 'F2', 'FirstClass', 0), (10, 'F3', 'FirstClass', 0);

-- Insert data into Reservations
INSERT INTO Reservations (PNR, ReservationDate, Status, PassengerID, FlightID) VALUES
('PNR011', GETDATE(), 'Confirmed', 1, 1),
('PNR012', GETDATE(), 'Confirmed', 2, 2),
('PNR013', GETDATE(), 'Cancelled', 3, 3),
('PNR014', DATEADD(DAY, -1, GETDATE()), 'Confirmed', 4, 4),
('PNR015', DATEADD(DAY, 2, GETDATE()), 'Confirmed', 5, 5),
('PNR016', DATEADD(DAY, 3, GETDATE()), 'Pending', 6, 6),
('PNR017', DATEADD(DAY, 3, GETDATE()), 'Confirmed', 7, 7),
('PNR018', DATEADD(DAY, 5, GETDATE()), 'Pending', 8, 8),
('PNR019', DATEADD(DAY, 5, GETDATE()), 'Confirmed', 9, 9),
('PNR020', DATEADD(DAY, 6, GETDATE()), 'Confirmed', 10, 10);

-- Insert data into Tickets (adjusting ReservationID values accordingly)
INSERT INTO Tickets (Fare, Seat, Class, FlightID, ReservationID, EmployeeID, EBoardingNumber) VALUES
(250.00, 'E1', 'Economy', 1, 1, 1, 'EBN001'),
(320.00, 'B2', 'Business', 2, 2, 2, 'EBN002'),
(150.00, 'E1', 'Economy', 3, 3, 3, 'EBN003'),
(500.00, 'F1', 'FirstClass', 4, 4, 4, 'EBN004'),
(450.00, 'B1', 'Business', 5, 5, 5, 'EBN005'),
(200.00, 'E1', 'Economy', 6, 6, 6, 'EBN006'),
(180.00, 'E1', 'Economy', 7, 7, 7, 'EBN007'),
(350.00, 'B1', 'Business', 8, 8, 8, 'EBN008'),
(400.00, 'F1', 'FirstClass', 9, 9, 9, 'EBN009'),
(450.00, 'B1', 'Business', 10, 10, 10, 'EBN010');

-- Insert data into Baggage
INSERT INTO Baggage (Weight, Status, Fee, TicketID) VALUES
(25.00, 'CheckedIn', 50.00, 1),
(30.00, 'Loaded', 60.00, 2),
(22.00, 'In Transit', 40.00, 3),
(40.00, 'CheckedIn', 70.00, 4),
(28.00, 'Loaded', 55.00, 5),
(15.00, 'In Transit', 35.00, 6),
(30.00, 'CheckedIn', 60.00, 7),
(35.00, 'Loaded', 65.00, 8),
(25.00, 'CheckedIn', 50.00, 9),
(28.00, 'In Transit', 55.00, 10);

-- Insert data into Services 
INSERT INTO Services (TicketID, ServiceType, Fee) VALUES
(1, 'Meal', 20.00),
(1, 'Extra Baggage', 100.00), 
(1, 'Preferred Seat', 30.00), 
(2, 'Meal', 25.00),
(2, 'Lounge Access', 50.00),
(3, 'Meal', 15.00),
(3, 'Extra Baggage', 100.00), 
(4, 'Meal', 30.00),
(4, 'Preferred Seat', 30.00),
(5, 'Lounge Access', 40.00),
(5, 'Meal', 20.00),
(6, 'Meal', 20.00),
(7, 'Meal', 25.00),
(8, 'Lounge Access', 50.00),
(9, 'Meal', 20.00),
(10, 'Lounge Access', 50.00),
(10, 'Preferred Seat', 30.00); 

-- Insert data into EmployeeLoginLog
INSERT INTO EmployeeLoginLog (EmployeeID, LoginTime, Action) VALUES
(1, '2025-04-17 08:00:00', 'Login'),
(2, '2025-04-17 08:15:00', 'Login'),
(3, '2025-04-17 08:30:00', 'Login'),
(4, '2025-04-17 08:45:00', 'Login'),
(1, '2025-04-17 17:00:00', 'Logout'),
(2, '2025-04-17 17:15:00', 'Logout'),
(3, '2025-04-17 17:30:00', 'Logout'),
(4, '2025-04-17 17:45:00', 'Logout'),
(5, '2025-04-18 08:00:00', 'Login'),
(6, '2025-04-18 08:15:00', 'Login');

------------------------------------------------------------
-- QUESTIONS 
------------------------------------------------------------
--2. Add the constraint to check that the reservation date is not in the past.

ALTER TABLE Reservations
WITH NOCHECK -- Don't check existing data
ADD CONSTRAINT CHK_ReservationDate_NotPast -- Naming the constraint
CHECK (ReservationDate >= CAST(GETDATE() AS DATE)); -- Only allow today or future dates
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Identify Passengers with Pending Reservations and Passengers with age more than 40 years. 

SELECT 
	DISTINCT P.PassengerID,  -- Unique passengers
	P.PNR,
	P.FirstName,
	P.LastName,
	P.DOB
FROM Passengers P
JOIN Reservations R ON P.PassengerID = R.PassengerID  -- Join with reservations
WHERE R.Status = 'Pending' 
   OR DATEDIFF(YEAR, P.DOB, GETDATE()) > 40;  -- Age > 40
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 3. The ticketing system also requires stored procedures or user-defined functions to do the  following things:
-- 4 a) Search the database of the ticketing system for matching character strings by last name of passenger. Results should be sorted with most recent issued ticket first.

-- Create procedure to search passengers by last name
CREATE PROCEDURE SP_FindPassengerByLastName
    @Keyword VARCHAR(50)  -- Input parameter for last name
AS
BEGIN
    -- Select passenger and ticket details where last name matches
    SELECT 
        P.PassengerID, P.FirstName, P.LastName, P.Email,
        T.TicketID, T.IssueDate, T.IssueTime
    FROM Passengers P
    INNER JOIN Reservations R ON P.PassengerID = R.PassengerID  -- Join with Reservations
    INNER JOIN Tickets T ON R.ReservationID = T.ReservationID    -- Join with Tickets
    WHERE P.LastName LIKE '%' + @Keyword + '%'  -- Filter by last name
    ORDER BY T.IssueDate DESC, T.IssueTime DESC;  -- Order by latest ticket issue
END;

-- Execute procedure with 'Patel' as the search keyword
EXEC SP_FindPassengerByLastName @Keyword = 'Patel';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- b) Return a full list of passengers and his/her specific meal requirement in business class who has a reservation today (i.e., the system date when the query is run)

-- Create procedure to fetch business class passengers' meal for today
CREATE PROCEDURE SP_GetBusinessClassPassengersMeal
AS
BEGIN
    -- Select business class passengers' details for today's reservations
    SELECT 
        p.FirstName, p.LastName, p.Meal, t.Class, r.ReservationDate
    FROM Passengers p
    JOIN Reservations r ON p.PassengerID = r.PassengerID
    JOIN Tickets t ON r.ReservationID = t.ReservationID
    WHERE t.Class = 'Business'  -- Filter for Business class
    AND CAST(r.ReservationDate AS DATE) = CAST(GETDATE() AS DATE)  -- Today's reservations
    ORDER BY r.ReservationDate DESC;  -- Most recent reservation first
END;

-- Execute the procedure
EXEC SP_GetBusinessClassPassengersMeal;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- c) Insert a new employee into the database.

-- Create procedure to insert a new employee and return the EmployeeID
CREATE PROCEDURE InsertNewEmployee
    @Name VARCHAR(100),  
    @Email VARCHAR(100),  
    @Role VARCHAR(30),    
    @Username VARCHAR(50), 
    @Password VARCHAR(255) 
AS
BEGIN
-- Insert new employee
    INSERT INTO Employees (Name, Email, Role, Username, Password)
    VALUES (@Name, @Email, @Role, @Username, @Password);

-- Return the last inserted EmployeeID
    SELECT SCOPE_IDENTITY() AS NewEmployeeID;
END;

-- Execute procedure to insert a new employee
EXEC InsertNewEmployee 
    @Name = 'Giriraj Madhumilton', 
    @Email = 'Giriraj.Madhumilton@example.com', 
    @Role = 'Ticketing Staff', 
    @Username = 'Girirajmadhumilton', 
    @Password = 'securepassword123';

-- Check the Employees table for the new entry
SELECT * FROM Employees;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- d) Update the details for a passenger that has booked a flight before.

-- Create procedure to update passenger details if they have a reservation before today
CREATE PROCEDURE UpdatePassengerDetailsIfBooked
    @PNR VARCHAR(10),  
    @FirstName VARCHAR(50),  
    @LastName VARCHAR(50),  
    @Email VARCHAR(100),  
    @Meal VARCHAR(20),  
    @DOB DATE,  
    @EmergencyContact VARCHAR(20)  
AS
BEGIN
    -- Check if the passenger has a reservation made before today
    IF EXISTS (
        SELECT 1
        FROM Passengers p
        JOIN Reservations r ON p.PassengerID = r.PassengerID
        WHERE p.PNR = @PNR  -- Condition: Passenger must have a reservation
        AND r.ReservationDate < CAST(GETDATE() AS DATE)  -- Reservation must be before today
    )
    BEGIN
        -- If exists, update passenger details
        UPDATE Passengers
        SET FirstName = @FirstName,
            LastName = @LastName,
            Email = @Email,
            Meal = @Meal,
            DOB = @DOB,
            EmergencyContact = @EmergencyContact
        WHERE PNR = @PNR;

        PRINT 'Passenger details updated successfully.';
    END
    ELSE
    BEGIN
        PRINT 'No valid reservation found for this passenger before today. Update not applied.';
    END
END;

-- Execute the procedure
EXEC UpdatePassengerDetailsIfBooked
    @PNR = 'PNR002',
    @FirstName = 'Maria',
    @LastName = 'Sanchez',
    @Email = 'maria.sanchez@example.com',
    @Meal = 'Gluten-Free',
    @DOB = '1990-08-20',
    @EmergencyContact = '999-888-7777';

	-- Execute the procedure
EXEC UpdatePassengerDetailsIfBooked
    @PNR = 'PNR004',
    @FirstName = 'Amina Mohammed',
    @LastName = 'Ali',
    @Email = 'amina.ali@example.com',
    @Meal = 'kosher',
    @DOB = '1975-03-10',
    @EmergencyContact = '444-444-4444';
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5. The ticketing system wants to be able to view all e-boarding numbersIssued by a Specific Employee showing the overall revenue generated by that employee on a particular flight. It should include details of the fare, additional baggage fees, upgraded meal or  preferred seat. You should create a view containing all the required information.

CREATE VIEW EmployeeFlightRevenue AS
SELECT 
    e.Name AS EmployeeName,             
    f.FlightNumber,                    
    t.Fare,                             

    -- Aggregated fees by service type
    SUM(CASE WHEN s.ServiceType = 'Meal' THEN s.Fee ELSE 0 END) AS MealFee,
    SUM(CASE WHEN s.ServiceType = 'Lounge Access' THEN s.Fee ELSE 0 END) AS LoungeFee,
    SUM(CASE WHEN s.ServiceType = 'Preferred Seat' THEN s.Fee ELSE 0 END) AS SeatFee,
    SUM(CASE WHEN s.ServiceType = 'Extra Baggage' THEN s.Fee ELSE 0 END) AS ExtraBaggageFee,

    COALESCE(b.Fee, 0) AS BaggageFee,   -- Basic baggage fee

    -- Total revenue includes all selected services and baggage
    (t.Fare 
     + COALESCE(b.Fee, 0) 
     + SUM(CASE WHEN s.ServiceType = 'Meal' THEN s.Fee ELSE 0 END)
     + SUM(CASE WHEN s.ServiceType = 'Lounge Access' THEN s.Fee ELSE 0 END)
     + SUM(CASE WHEN s.ServiceType = 'Preferred Seat' THEN s.Fee ELSE 0 END)
     + SUM(CASE WHEN s.ServiceType = 'Extra Baggage' THEN s.Fee ELSE 0 END)
    ) AS TotalRevenue

FROM 
    Tickets t
JOIN Employees e ON t.EmployeeID = e.EmployeeID           -- Ticket issued by employee
JOIN Flights f ON t.FlightID = f.FlightID                 -- Ticket linked to a flight
LEFT JOIN Baggage b ON t.TicketID = b.TicketID            -- Optional baggage
LEFT JOIN Services s ON t.TicketID = s.TicketID           -- Optional service add-ons

GROUP BY 
    e.Name, f.FlightNumber, t.Fare, b.Fee;                -- Group by employee, flight, and base cost


--  Query to get data for a specific employee  and a specific flight

SELECT * 
FROM EmployeeFlightRevenue 
WHERE EmployeeName = 'Carlos Garcia' 
AND FlightNumber = 'FL002';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- checking everything before creating trigger for reservation
-- Upading seats for the already inserted values

UPDATE Seats
SET IsReserved = 1
WHERE SeatNumber IN (
    SELECT Seat FROM Tickets WHERE Seat IS NOT NULL
);

-- Get the count of remaining available seats for each flight before trigger
SELECT
    f.FlightNumber,
    s.SeatClass,
    COUNT(s.SeatID) AS TotalSeats,
    SUM(CASE WHEN s.IsReserved = 0 THEN 1 ELSE 0 END) AS AvailableSeats
FROM
    Flights f
JOIN
    Seats s ON f.FlightID = s.FlightID
GROUP BY
    f.FlightNumber, s.SeatClass
ORDER BY
    f.FlightNumber, s.SeatClass;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6. Create a trigger so that the current seat allotment of a passenger automatically updates to reserved when the ticket is issued.
-- Trigger for updating seats

CREATE TRIGGER trg_UpdateSeatStatus
ON Tickets
AFTER INSERT
AS
BEGIN
    -- Update the Seats table when a new ticket is inserted
    UPDATE s
    SET s.IsReserved = 1
    FROM Seats s
    INNER JOIN inserted i
        ON s.SeatNumber = i.Seat  -- Match the seat number from the inserted ticket
        AND s.FlightID = i.FlightID;
END;

-- Insert a new ticket to test the trigger
INSERT INTO Tickets (Fare, Seat, Class, FlightID, ReservationID, EmployeeID, EBoardingNumber) 
VALUES (250.00, 'E2', 'Economy', 1, 1, 1, 'EBN002');

-- Get the count of remaining available seats for each flight after trigger
SELECT
    f.FlightNumber,
    s.SeatClass,
    COUNT(s.SeatID) AS TotalSeats,
    SUM(CASE WHEN s.IsReserved = 0 THEN 1 ELSE 0 END) AS AvailableSeats
FROM
    Flights f
JOIN
    Seats s ON f.FlightID = s.FlightID
GROUP BY
    f.FlightNumber, s.SeatClass
ORDER BY
    f.FlightNumber, s.SeatClass;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 7. You should provide a function or view which allows the ticketing system to identify the total number of baggage’s (which are checkedin) made on a specified date for a specific flight.

CREATE VIEW CheckedInBaggage AS
SELECT 
    f.FlightNumber,
    CAST(r.ReservationDate AS DATE) AS ReservationDate,
    COUNT(b.BaggageID) AS TotalCheckedInBags
FROM 
    Baggage b
JOIN 
    Tickets t ON b.TicketID = t.TicketID
JOIN 
    Reservations r ON t.ReservationID = r.ReservationID
JOIN 
    Flights f ON t.FlightID = f.FlightID
WHERE 
    b.Status = 'CheckedIn'
GROUP BY 
    f.FlightNumber, CAST(r.ReservationDate AS DATE);

-- Using view to check Baggage
SELECT * FROM CheckedInBaggage
WHERE FlightNumber = 'FL001' AND ReservationDate = '2025-04-23';
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--8 ADDITIONAL QUERY
-- a, listing all services availed for ticket
CREATE FUNCTION fn_GetServicesForTicket (@TicketID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        ServiceType,
        Fee
    FROM Services
    WHERE TicketID = @TicketID
);

SELECT * FROM dbo.fn_GetServicesForTicket(1);

-- b, checking availabel seats on active flights
CREATE VIEW vw_ActiveFlightsAvailableSeats AS
SELECT 
    f.FlightNumber,
    f.Origin,
    f.Destination,
    f.DepartureTime,
    DATENAME(WEEKDAY, f.DepartureTime) AS DayOfWeek,  -- Adds the day of the week
    s.SeatClass,
    COUNT(s.SeatID) AS AvailableSeats
FROM Flights f
INNER JOIN Seats s ON f.FlightID = s.FlightID
WHERE s.IsReserved = 0
AND CAST(f.DepartureTime AS DATE) >= CAST(GETDATE() AS DATE)  -- Only future or today's flights
GROUP BY f.FlightNumber, f.Origin, f.Destination, f.DepartureTime, s.SeatClass;

SELECT * FROM vw_ActiveFlightsAvailableSeats;


