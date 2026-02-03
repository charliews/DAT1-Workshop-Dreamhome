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
DOB TEXT,
salary TEXT,
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
clientNo TEXT, 
fName TEXT, 
lName TEXT, 
telNo TEXT, 
prefType TEXT, 
maxRent TEXT, 
email TEXT
);

INSERT INTO Client (clientNo, fName, lName, telNo, prefType, maxRent, email) VALUES
('CR76', 'John', 'Kay', '0207-774-5632', 'Flat', 425, 'j.kay@gmail.com'),
('CR56', 'Aline', 'Stewart', '0141-848-1825', 'Flat', 350, 'a.stewart@yahoo.co.uk'),
('CR74', 'Mike', 'Ritchie', '01475-983179', 'House', 750, 'mritchie01@hotmail.com'),
('CR62', 'Mary', 'Tregear', '01224-196720', 'Flat', 600, 'm.tregear@hotmail.co.uk');
