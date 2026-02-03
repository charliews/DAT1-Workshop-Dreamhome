.open dreamhomev2.db
.mode box

DROP TABLE IF EXISTS Branch;

CREATE TABLE Branch
(
branchNo TEXT,
street TEXT,
city TEXT,
postcode TEXT
);

INSERT INTO Branch (branchNo,street,city,postcode) VALUES
('B005', '22 Deer Rd', 'London', 'SW1 4EH'),
('B003', '163 Main St', 'Glasgow', 'G11 9QX'),
('B004', '32 Manse Rd', 'Bristol', 'BS99 1NZ'),
('B002', '56 Clover Dr', 'London', 'NW10 6EU');
