# Airport_Ticketing_System
Airport Ticketing System — Database Project

Overview

This project implements a relational database management system (RDBMS) designed to manage the end-to-end processes of an airport ticketing operation. The system handles workflows including passenger reservations, ticket issuance, baggage management, service bookings, employee login tracking, and operational reporting.

Built on Microsoft SQL Server, the system enforces data integrity, concurrency control, and security through mechanisms like constraints, triggers, views, stored procedures, and role-based access control.

Features

Passenger Reservations
Supports reservations for current or future dates only.
Enforced via check constraints to maintain data validity.
Ticket Issuance & Seat Allotment
Issues tickets linking flights, passengers, and employees.
Automatically reserves and updates assigned seats using AFTER INSERT triggers.
Baggage Management
Tracks baggage status (e.g., CheckedIn, Loaded) along with weight and applicable fees.
Associates each baggage entry with a passenger ticket for operational tracking.
Service Management
Records optional services such as meals, lounge access, and extra baggage.
Services linked to ticket IDs for accurate billing and reporting.
Employee Login Logs
Captures employee login and logout timestamps.
Enables system usage auditing and access tracking.
Reporting & Views
Provides predefined views for:

Active flights with available seat counts.
Total checked-in baggage per flight and date.
Revenue reports categorized by employee.
Service charge summaries per ticket.
Stored Procedures & Functions
Key operations include:

Searching passengers by last name.
Listing business class passengers with meal preferences for the current date.
Adding new employee records.
Updating passenger details, conditional on existing reservations.
Retrieving service fees associated with a ticket.
Entity-Relationship Structure

The database is fully normalized to Third Normal Form (3NF), ensuring:

No redundant or transitive dependencies.
Consistent, efficient, and scalable data storage.
Primary Entities:

Passengers
Reservations
Flights
Tickets
Baggage
Services
Employees
Seats
LoginLogs
Entities are linked via primary and foreign keys to uphold referential integrity throughout the system.

Data Integrity, Concurrency, and Security

The system enforces strict data governance through:

Check constraints to validate permissible values and logical conditions.
Triggers to automate post-transaction processes such as seat allotment.
Role-based access control restricting sensitive operations by user role.
Audit logs recording employee system usage activity.
Transaction control mechanisms to ensure data consistency and resolve concurrency conflicts.
Backup & Restore Instructions

Backup Procedure
In SQL Server Management Studio (SSMS), right-click the database.
Navigate to Tasks → Backup.
Remove any existing path and specify a new destination path with a .bak filename.
Under Options, enable compressed backup if desired.
Set an expiry date for the backup set if required.
Execute and confirm the success message.
Restore Procedure
In SSMS, right-click Databases → Restore Database.
Select Device and locate the required .bak backup file.
Add the backup set to the restore plan.
Confirm settings and initiate the restore process.
Verify restoration success through the completion message.
Conclusion

The Airport Ticketing System delivers a robust, scalable, and secure data management solution for managing passenger, ticketing, and baggage operations. It ensures:

Accurate, constraint-driven data validation.
Automated operational updates like real-time seat allotment.
Role-based, secure access to data and system functions.
Comprehensive financial and operational reporting.
Reliable backup and disaster recovery processes.
This project serves as a solid foundation for expanding and integrating airport management operations within a relational database framework.

Notes

All stored procedures, triggers, views, and functions are documented within the project files.
The database was developed and tested on Microsoft SQL Server.
Includes data simulation scripts with a variety of test cases for operational and reporting validation.
