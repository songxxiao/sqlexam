-- Script from 9780132662253 11e
-- ERD Figures 2-22, A-1, A-2, A-4, A-5
-- Revised 2014.9.12 AL
-- Revised 2015.9.24 AL
-- Revised 2018.10.2 AL
-- Revised 2020.10.7 AL

USE BUDT703_DB_Student_nnn;

BEGIN TRANSACTION;

CREATE TABLE Employee_T
 (employeeID           VARCHAR(10) NOT NULL,
  employeeName         VARCHAR(25),
  employeeAddress      VARCHAR(30),
  employeeCity         VARCHAR(20),
  employeeState        CHAR(2),
  employeeZipCode      VARCHAR(10),
  employeeDateHired    DATE,
  employeeBirthDate    DATE,
  employeeSupervisor   VARCHAR(10),
  CONSTRAINT pk_Employee_employeeID PRIMARY KEY (employeeID));

CREATE TABLE Skill_T
 (skillID              VARCHAR(12) NOT NULL,
  skillDescription     VARCHAR(30),
  CONSTRAINT pk_Skill_skillID PRIMARY KEY (skillID));

CREATE TABLE EmployeeSkills_T
 (employeeID           VARCHAR(10) NOT NULL,
  skillID              VARCHAR(12) NOT NULL,
  CONSTRAINT pk_EmployeeSkills_employeeID_skillID PRIMARY KEY (employeeID,skillID),
  CONSTRAINT fk_EmployeeSkills_skillID FOREIGN KEY (employeeID)
    REFERENCES Employee_T (employeeID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_EmployeeSkills_employeeID FOREIGN KEY (skillID)
    REFERENCES Skill_T (skillID) ON DELETE NO ACTION ON UPDATE NO ACTION);

CREATE TABLE WorkCenter_T
 (workCenterID         VARCHAR(12) NOT NULL,
  workCenterLocation   VARCHAR(30),
  CONSTRAINT pk_WorkCenter_workCenterID PRIMARY KEY (workCenterID));

CREATE TABLE WorksIn_T
 (employeeID           VARCHAR(10) NOT NULL,
  workCenterID         VARCHAR(12) NOT NULL,
  CONSTRAINT pk_WorksIn_employeeID_workCenterID PRIMARY KEY (employeeID,workCenterID),
  CONSTRAINT fk_WorksIn_employeeID FOREIGN KEY (employeeID)
    REFERENCES Employee_T (employeeID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_WorksIn_workCenterID FOREIGN KEY (workCenterID)
    REFERENCES WorkCenter_T (workCenterID) ON DELETE NO ACTION ON UPDATE NO ACTION);

CREATE TABLE ProductLine_T
 (productLineID        DECIMAL(11,0) NOT NULL,
  productLineName      VARCHAR(50),
  CONSTRAINT pk_ProductLine_productLineID PRIMARY KEY (productLineID));

CREATE TABLE Product_T
 (productID            DECIMAL(11,0) NOT NULL,
  productLineID        DECIMAL(11,0),
  productDescription   VARCHAR(50),
  productFinish        VARCHAR(20),
  productStandardPrice DECIMAL(6,2),
  CONSTRAINT pk_Product_productID PRIMARY KEY (productID),
  CONSTRAINT fk_Product_productLineID FOREIGN KEY (productLineID)
    REFERENCES ProductLine_T (productLineID) ON DELETE NO ACTION ON UPDATE NO ACTION);

CREATE TABLE ProducedIn_T
 (productID            DECIMAL(11,0) NOT NULL,
  workCenterID         VARCHAR(12) NOT NULL,
  CONSTRAINT pk_ProducedIn_productID_workCenterID PRIMARY KEY (productID,workCenterID),
  CONSTRAINT fk_ProducedIn_productID FOREIGN KEY (productID)
    REFERENCES Product_T (productID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_ProducedIn_workCenterID FOREIGN KEY (workCenterID)
    REFERENCES WorkCenter_T (workCenterID) ON DELETE NO ACTION ON UPDATE NO ACTION);

CREATE TABLE RawMaterial_T
 (materialID           VARCHAR(12) NOT NULL,
  materialName         VARCHAR(30),
  materialStandardCost DECIMAL(6,2),
  unitOfMeasure        VARCHAR(10),
  CONSTRAINT pk_RawMaterial_materialID PRIMARY KEY (materialID));

CREATE TABLE Uses_T
 (productID            DECIMAL(11,0) NOT NULL,
  materialID           VARCHAR(12) NOT NULL,
  goesIntoQuantity     INTEGER,
  CONSTRAINT pk_Uses_productID_materialID PRIMARY KEY (productID,materialID),
  CONSTRAINT fk_Uses_productID FOREIGN KEY (productID)
    REFERENCES Product_T (productID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_Uses_materialID FOREIGN KEY (materialID)
    REFERENCES RawMaterial_T (materialID) ON DELETE NO ACTION ON UPDATE NO ACTION);

CREATE TABLE Vendor_T
 (vendorID             DECIMAL(11,0) NOT NULL,
  vendorName           VARCHAR(25),
  vendorAddress        VARCHAR(30),
  vendorCity           VARCHAR(20),
  vendorState          CHAR(2),
  vendorZipcode        VARCHAR(50),
  vendorFax            VARCHAR(10),
  vendorPhone          VARCHAR(10),
  vendorContact        VARCHAR(50),
  vendorTaxID          VARCHAR(50),
  CONSTRAINT pk_Vendor_vendorID PRIMARY KEY (vendorID));

CREATE TABLE Supplies_T
 (vendorID             DECIMAL(11,0) NOT NULL,
  materialID           VARCHAR(12) NOT NULL,
  suppliesUnitPrice    DECIMAL(6,2),
  CONSTRAINT pk_Supplies_vendorID_materialID PRIMARY KEY (vendorID,materialID),
  CONSTRAINT fk_Supplies_vendorID FOREIGN KEY (materialId)
    REFERENCES RawMaterial_T (materialID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_Supplies_materialID FOREIGN KEY (vendorID)
    REFERENCES Vendor_T (vendorID) ON DELETE NO ACTION ON UPDATE NO ACTION);

CREATE TABLE Customer_T
 (customerID           DECIMAL(11,0)  NOT NULL,
  customerName         VARCHAR(25)    NOT NULL,
  customerAddress      VARCHAR(30),
  customerCity         VARCHAR(20),
  customerState        CHAR(2),
  customerPostalCode   VARCHAR(10),
  CONSTRAINT pk_Customer_customerID PRIMARY KEY (customerID));

CREATE TABLE Order_T
 (orderID              DECIMAL(11,0) NOT NULL,
  customerID           DECIMAL(11,0),
  orderDate            DATE,
  CONSTRAINT pk_Order_orderID PRIMARY KEY (orderID),
  CONSTRAINT fk_Order_customerID FOREIGN KEY (customerID)
    REFERENCES Customer_T (customerID) ON DELETE NO ACTION ON UPDATE NO ACTION);

CREATE TABLE OrderLine_T
 (orderID              DECIMAL(11,0) NOT NULL,
  productID            DECIMAL(11,0) NOT NULL,
  orderedQuantity      DECIMAL(11,0),
  CONSTRAINT pk_OrderLine_orderID_productID PRIMARY KEY (orderID,productID),
  CONSTRAINT fk_OrderLine_orderID FOREIGN KEY (orderID)
    REFERENCES Order_T (orderID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_OrderLine_productID FOREIGN KEY (productID)
    REFERENCES Product_T (productID) ON DELETE NO ACTION ON UPDATE NO ACTION);

CREATE TABLE Territory_T
 (territoryID          DECIMAL(11,0) NOT NULL,
  territoryName        VARCHAR(50),
  CONSTRAINT pk_Territory_territoryID PRIMARY KEY (territoryID));

CREATE TABLE DoesBusinessIn_T
 (customerID           DECIMAL(11,0) NOT NULL,
  territoryID          DECIMAL(11,0) NOT NULL,
  CONSTRAINT pk_DoesBusinessIn_customerID_territoryID PRIMARY KEY (customerID,territoryID),
  CONSTRAINT fk_DoesBusinessIn_customerID FOREIGN KEY (customerID)
    REFERENCES Customer_T (customerID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_DoesBusinessIn_territoryID FOREIGN KEY (territoryID)
    REFERENCES Territory_T (territoryID) ON DELETE NO ACTION ON UPDATE NO ACTION);

CREATE TABLE Salesperson_T
 (salespersonID        DECIMAL(11,0) NOT NULL,  
  salespersonName      VARCHAR(25),
  salespersonPhone     VARCHAR(50),
  salespersonFax       VARCHAR(50),
  territoryID          DECIMAL(11,0),
  CONSTRAINT pk_Salesperson_salespersonID PRIMARY KEY (salesPersonID),
  CONSTRAINT fk_Salesperson_territoryID FOREIGN KEY (territoryID)
    REFERENCES Territory_T (territoryID) ON DELETE NO ACTION ON UPDATE NO ACTION);

COMMIT;