PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS Branch;

CREATE TABLE Branch
(
branchNo TEXT PRIMARY KEY,
street TEXT,
city TEXT,
postcode TEXT
);

INSERT INTO Branch (branchNo, street, city, postcode) VALUES
('B005', '22 Deer Rd', 'London', 'SW1 4EH'),
('B003', '163 Main St', 'Glasgow', 'G11 9QX'),
('B004', '32 Manse Rd', 'Bristol', 'BS99 1NZ'),
('B002', '56 Clover Dr', 'London', 'NW10 6EU');

DROP TABLE IF EXISTS Staff;

CREATE TABLE Staff
(
staffNo TEXT PRIMARY KEY,
fName TEXT,
lName TEXT,
position TEXT,
sex TEXT,
DOB DATE,
salary REAL,
branchNo TEXT,
FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

INSERT INTO Staff (staffNo, fName, lName, position, sex, DOB, salary, branchNo) VALUES
('SL21', 'John', 'White', 'Manager', 'M', '1965-10-01', 30000, 'B005'),
('SG37', 'Ann', 'Beech', 'Assistant', 'F', '1980-11-10', 12000, 'B003'),
('SG14', 'David', 'Ford', 'Supervisor', 'M', '1978-03-24', 18000, 'B003'),
('SA9', 'Mary', 'Howe', 'Assistant', 'F', '1990-02-19', 9000, 'B002'),
('SG5', 'Susan', 'Brand', 'Manager', 'F', '1960-06-03', 24000, 'B003'),
('SL41', 'Julie', 'Lee', 'Assistant', 'F', '1963-06-05', 9000, 'B005');

DROP TABLE IF EXISTS Client;

CREATE TABLE Client
(
clientNo TEXT PRIMARY KEY, 
fName TEXT, 
lName TEXT, 
telNo TEXT, 
prefType TEXT, 
maxRent REAL, 
email TEXT
);

INSERT INTO Client (clientNo, fName, lName, telNo, prefType, maxRent, email) VALUES
('CR76', 'John', 'Kay', '0207-774-5632', 'Flat', 425, 'j.kay@gmail.com'),
('CR56', 'Aline', 'Stewart', '0141-848-1825', 'Flat', 350, 'a.stewart@yahoo.co.uk'),
('CR74', 'Mike', 'Ritchie', '01475-983179', 'House', 750, 'mritchie01@hotmail.com'),
('CR62', 'Mary', 'Tregear', '01224-196720', 'Flat', 600, 'm.tregear@hotmail.co.uk');

DROP TABLE IF EXISTS PrivateOwner;

CREATE TABLE PrivateOwner
(
ownerNo TEXT, 
fName TEXT, 
lName TEXT, 
address TEXT, 
telNo TEXT, 
email TEXT, 
password TEXT
);

INSERT INTO PrivateOwner(ownerNo, fName, lName, address, telNo, email, password) VALUES
('CO46', 'Joe', 'Keogh', '2 Fergus Dr, Aberdeen AB2 7SX', '01224-861212', 'j.keogh@gmail.com', '********'),
('CO87', 'Carol', 'Farrell', '6 Achray St, Glasgow G32 9DX', '0141-357-7419', 'c.farrell@hotmail.com', '********'),
('CO40', 'Tina', 'Murphy', '63 Well St, Glasgow G42 9FX', '0141-943-1728', 't.murphy@hotmail.com', '********'),
('CO93', 'Tony', 'Shaw', '12 Park Pl, Glasgow G4 6FF', '0141-225-7025', 't.shaw@hotmail.com', '********');

DROP TABLE IF EXISTS PropertyForRent;

CREATE TABLE PropertyForRent
(
propertyNo TEXT, 
street TEXT,
city TEXT, 
postcode TEXT, 
type TEXT, 
rooms INTEGER, 
rent REAL, 
ownerNo TEXT, 
staffNo TEXT,
branchNo TEXT
FOREIGN KEY (ownerNo) REFERENCES PrivateOwner(ownerNo),
FOREIGN KEY (staffNo) REFERENCES Staff(staffNo),
FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

INSERT INTO PropertyForRent (propertyNo, street, city, postcode, type, rooms, rent, ownerNo, staffNo, branchNo) VALUES
('PA14', '16 Holhead', 'Aberdeen', 'AB7 5SQ', 'House', 6, 650, 'CO46', 'SA9', 'B004'),
('PL94', '6 Argyll St', 'London', 'NW2', 'Flat', 4, 400, 'CO87', 'SL41', 'B005'),
('PG4', '6 Lawrence St', 'Glasgow', 'G11 9QX', 'Flat', 3, 350, 'CO40', 'SG14', 'B003'),
('PG36', '2 Manor Rd', 'Glasgow', 'G32 4QX', 'Flat', 3, 375, 'CO93', 'SG37', 'B003'),
('PG21', '18 Dale Rd', 'Glasgow', 'G12', 'House', 5, 600, 'CO87', 'SG37', 'B003'),
('PG16', '5 Novar Dr', 'Glasgow', 'G12 9AX', 'Flat', 4, 450, 'CO93', 'SG14', 'B003');

DROP TABLE IF EXISTS Viewing;

CREATE TABLE Viewing
(
clientNo TEXT, 
propertyNo TEXT, 
viewDate DATE, 
comment TEXT
FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
FOREIGN KEY (propertyNo) REFERENCES PropertyForRent(propertyNo)
);

INSERT INTO Viewing (clientNo, propertyNo, viewDate, comment) VALUES
('CR76', 'PA14', '2025-05-24', 'too small'),
('CR56', 'PG4', '2025-08-20', 'too remote'),
('CR74', 'PG36', '2025-04-14', NULL),
('CR62', 'PG16', '2025-05-26', 'no eating room'),
('CR56', 'PA14', '2025-05-14', NULL);

DROP TABLE IF EXISTS Registration;

CREATE TABLE Registration
(
clientNo TEXT, 
branchNo TEXT, 
staffNo TEXT, 
dateJoined DATE
FOREIGN KEY (clientNo) REFERENCES CLIENT(clientNo),
FOREIGN KEY (branchNo) REFERENCES Branch(branchNo),
FOREIGN KEY (staffNo) REFERENCES Staff(staffNo)
);

INSERT INTO Registration (clientNo, branchNo, staffNo, dateJoined) VALUES
('CR76', 'B005', 'SL41', '2025-11-12'),
('CR56', 'B003', 'SG37', '2025-04-20'),
('CR74', 'B003', 'SG14', '2025-10-16'),
('CR62', 'B004', 'SA9', '2025-03-07');
