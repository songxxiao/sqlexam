-- Mysql

DELETE FROM Salesperson_T;
DELETE FROM DoesBusinessIn_T;
DELETE FROM Territory_T;
DELETE FROM OrderLine_T;
DELETE FROM Order_T;
DELETE FROM Customer_T;
DELETE FROM Supplies_T;
DELETE FROM Vendor_T;
DELETE FROM Uses_T;
DELETE FROM RawMaterial_T;
DELETE FROM ProducedIn_T;
DELETE FROM Product_T;
DELETE FROM ProductLine_T;
DELETE FROM WorksIn_T;
DELETE FROM WorkCenter_T;
DELETE FROM EmployeeSkills_T;
DELETE FROM Skill_T;
DELETE FROM Employee_T;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO Employee_T VALUES
 ('123-44-345', 'Phil Morris', '2134 Hilltop Rd', 'Knoxville', 'TN', '37920', '1999-12-06', '1957-01-05', '454-56-768'),
 ('334-45-667', 'Lawrence Haley', '5970 Spring Crest Rd', 'Nashville', 'TN', '54545', '1999-05-01', '1963-08-15', '454-56-768'),
 ('454-56-768', 'Robert Lewis', '17834 Deerfield Ln', 'Knoxville', 'TN', '55555', '1998-01-01', '1964-08-25', '123-44-345'),
 ('559-55-585', 'Mary Smith', '75 Jane Lane', 'Clearwater', 'FL', '33879', '2000-08-15', '1969-05-06', '334-45-667'),
 ('000-00-000', 'Laura Ellenburg', '5342 Picklied Trout Lane', 'Nashville', 'TN', '38010', '2000-02-20', null, '454-56-768');

INSERT INTO Skill_T VALUES
 ('BS12', '12in Band Saw'),
 ('QC1', 'Quality Control'),
 ('RT1', 'Router'),
 ('SO1', 'Sander-Orbital'),
 ('SB1', 'Sander-Belt'),
 ('TS10', '10in Table Saw'),
 ('TS12', '12in Table Saw'),
 ('UC1', 'Upholstery Cutter'),
 ('US1', 'Upholstery Sewer'),
 ('UT1', 'Upholstery Tacker');

INSERT INTO EmployeeSkills_T VALUES
 ('123-44-345', 'BS12'),
 ('123-44-345', 'RT1'),
 ('123-44-345', 'QC1'),
 ('123-44-345', 'TS10'),
 ('334-45-667', 'BS12'),
 ('334-45-667', 'TS10'),
 ('454-56-768', 'BS12'),
 ('454-56-768', 'RT1'),
 ('454-56-768', 'TS10'),
 ('000-00-000', 'UC1'),
 ('000-00-000', 'US1'),
 ('000-00-000', 'UT1');

INSERT INTO WorkCenter_T VALUES
 ('SM1', 'Main Saw Mill'),
 ('WR1', 'Warehouse and Receiving'),
 ('TW1', 'Tampa Warehouse');

INSERT INTO WorksIn_T VALUES
 ('123-44-345', 'SM1'),
 ('454-56-768', 'TW1');

INSERT INTO ProductLine_T VALUES
 (1, 'Basic'),
 (2, 'Antique'),
 (3, 'Modern'),
 (4, 'Classical'),
 (5, 'Rellville'),
 (6, 'Spanish Style'),
 (7, 'Gothic');

INSERT INTO Product_T VALUES
 (1, 1, 'Cherry End Table', 'Cherry', 175.00),
 (2, 1, 'Birch Coffee Tables', 'Birch', 200.00),
 (3, 1, 'Oak Computer Desk', 'Oak', 750.00),
 (4, 1, 'Entertainment Center', 'Cherry', 1650.00),
 (5, 2, 'Writer''s Desk', 'Oak', 325.00),
 (6, 1, '8-Drawer Dresser','Birch', 750.00),
 (7, 3, '48 Bookcase', 'Walnut', 150.00),
 (8, 3, '48 Bookcase', 'Oak', 175.00),
 (9, 3, '96 Bookcase', 'Walnut', 225.00),
 (10, 3, '96 Bookcase', 'Oak', 200.00),
 (11, 1, '4-Drawer Dresser', 'Oak', 500.00),
 (12, 1, '8-Drawer Dresser', 'Oak', 800.00),
 (13, 1, 'Nightstand', 'Cherry', 150.00),
 (14, 2, 'Writer''s Desk', 'Birch', 300.00),
 (17, 3, 'High Back Leather Chair', 'Leather', 362.00),
 (18, 4, '6'' Grandfather Clock', 'Oak', 890.00),
 (19, 4, '7'' Grandfather Clock', 'Oak', 1100.00),
 (20, 2, 'Amoire', 'Walnut', 1200.00),
 (21, 1, 'Pine End Table', 'Pine', 256.00);

INSERT INTO ProducedIn_T VALUES
 (1, 'TW1'),
 (2, 'TW1'),
 (3, 'TW1'),
 (4, 'TW1'),
 (5, 'TW1'),
 (6, 'TW1'),
 (7, 'TW1'),
 (8, 'TW1'),
 (9, 'TW1'),
 (10, 'TW1'),
 (11, 'TW1'),
 (12, 'TW1'),
 (13, 'TW1'),
 (14, 'TW1'),
 (17, 'WR1'),
 (18, 'WR1'),
 (19, 'WR1'),
 (20, 'WR1'),
 (21, 'WR1');

INSERT INTO Customer_T VALUES
 (1, 'Contemporary Casuals', '1355 S Hines Blvd', 'Gainesville', 'FL', '32601-2871'),
 (2, 'Value Furniture', '15145 S.W. 17th St.', 'Plano', 'TX', '75094-7743'),
 (3, 'Home Furnishings', '1900 Allard Ave.', 'Albany', 'NY', '12209-1125'),
 (4, 'Eastern Furniture', '1925 Beltline Rd.', 'Carteret', 'NJ', '07008-3188'),
 (5, 'Impressions', '5585 Westcott Ct.', 'Sacramento', 'CA', '94206-4056'),
 (6, 'Furniture Gallery', '325 Flatiron Dr.', 'Boulder', 'CO', '80514-4432'),
 (7, 'Period Furniture', '394 Rainbow Dr.', 'Seattle', 'WA', '97954-5589'),
 (8, 'California Classics', '816 Peach Rd.', 'Santa Clara', 'CA', '96915-7754'),
 (9, 'M and H Casual Furniture', '3709 First Street', 'Clearwater', 'FL', '34620-2314'),
 (10, 'Seminole Interiors', '2400 Rocky Point Dr.', 'Seminole', 'FL', '34646-4423'),
 (11, 'American Euro Lifestyles', '2424 Missouri Ave N.', 'Prospect Park', 'NJ', '07508-5621'),
 (12, 'Battle Creek Furniture', '345 Capitol Ave. SW', 'Battle Creek', 'MI', '49015-3401'),
 (13, 'Heritage Furnishings', '66789 College Ave.', 'Carlisle', 'PA', '17013-8834'),
 (14, 'Kaneohe Homes', '112 Kiowai St.', 'Kaneohe', 'HI', '96744-2537'),
 (15, 'Mountain Scenes', '4132 Main Street', 'Ogden', 'UT', '84403-4432');

INSERT INTO Order_T VALUES
 (1001, 1, '2010-10-21'),
 (1002, 8, '2010-10-21'),
 (1003, 15, '2010-10-22'),
 (1004, 5, '2010-10-22'),
 (1005, 3, '2010-10-24'),
 (1006, 2, '2010-10-24'),
 (1007, 11, '2010-10-27'),
 (1008, 12, '2010-10-30'),
 (1009, 4, '2010-11-05'),
 (1010, 1, '2010-11-05');

INSERT INTO OrderLine_T VALUES
 (1001, 1, 2),
 (1001, 2, 2),
 (1001, 4, 1),
 (1002, 3, 5),
 (1003, 3, 3),
 (1004, 6, 2),
 (1004, 8, 2),
 (1005, 4, 3),
 (1006, 4, 1),
 (1006, 5, 2),
 (1006, 7, 2),
 (1007, 1, 3),
 (1007, 2, 2),
 (1008, 3, 3),
 (1008, 8, 3),
 (1009, 4, 2),
 (1009, 7, 3),
 (1010, 8, 10);

INSERT INTO Territory_T VALUES
 (1, 'SouthEast'),
 (2, 'SouthWest'),
 (3, 'NorthEast'),
 (4, 'NorthWest'),
 (5, 'Central');

INSERT INTO DoesBusinessIn_T VALUES
 (1, 1),
 (1, 2),
 (2, 2),
 (3, 3),
 (4, 3),
 (5, 2),
 (6, 5);

INSERT INTO Salesperson_T VALUES
 (1, 'Doug Henny', '8134445555', '', 1),
 (2, 'Robert Lewis', '8139264006', '', 2),
 (3, 'William Strong', '5053821212', '', 3),
 (4, 'Julie Dawson', '4355346677', '', 4),
 (5, 'Jacob Winslow', '2238973498', '', 5);

COMMIT;

SELECT * FROM Salesperson_T;
SELECT * FROM DoesBusinessIn_T;
SELECT * FROM Territory_T;
SELECT * FROM OrderLine_T;
SELECT * FROM Order_T;
SELECT * FROM Customer_T;
SELECT * FROM Supplies_T;
SELECT * FROM Vendor_T;
SELECT * FROM Uses_T;
SELECT * FROM RawMaterial_T;
SELECT * FROM ProducedIn_T;
SELECT * FROM Product_T;
SELECT * FROM ProductLine_T;
SELECT * FROM WorksIn_T;
SELECT * FROM WorkCenter_T;
SELECT * FROM EmployeeSkills_T;
SELECT * FROM Skill_T;
SELECT * FROM Employee_T;
