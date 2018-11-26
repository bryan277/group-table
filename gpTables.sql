DROP DATABASE IF EXISTS gp_tables;

CREATE DATABASE gp_tables;

USE gp_tables;

CREATE TABLE CAR (
	Vin       			Varchar (17) 	    NOT NULL,	-- Int to Varchar (17)
	Model       		Varchar (255) 	    NOT NULL,
	Make          		Varchar (255)       NOT NULL,
	Color    	  		Varchar (255) 	    NOT NULL,
	LicenseNumber     	Varchar (255) 	    NOT NULL,
	SizeType  	    	Varchar (255)    	NOT NULL,
    InsuranceNo			Varchar (255)		NOT NULL,
    DateReserved		Datetime			NOT NULL,
	Availabe 			Tinyint (1)			NULL,
	CONSTRAINT 		    CAR_PK 				PRIMARY KEY (Vin)
 -- CONSTRAINT			CAR_INS_FK			FOREIGN KEY (InsuranceNo)
-- 								REFERENCES INSURANCE (InsuranceNo)
-- 	
);

CREATE TABLE INSURANCE (
	InsuranceNo	       	Integer 	    	NOT NULL,
    Vin					Varchar (17)		NOT NULL,
    InvoiceNo			Integer 			NOT NULL, -- There is no primary key for InvoiceNO?
    CarCondition		Varchar (255) 		NOT NULL, 
    RepairType			Varchar (255) 		NOT NULL,
    CONSTRAINT			INVENTORY_PK		PRIMARY KEY (Vin, InsuranceNo),
    CONSTRAINT			INVENTORY_VIN_FK	FOREIGN KEY (Vin)
									REFERENCES CAR (Vin)
);

ALTER TABLE CAR ADD FOREIGN KEY (InsuranceNo) REFERENCES INSURANCE(InsuranceNo);
-- The fake inserts worked before referencing primary and foreign keys. 
-- Trouble with primary and foreign keys. For example. I'm getting an Error Code: 1824. Failed to open the referenced table ' INSURANCE', because the table wasn't created before CAR table, vice versa if i place INSURANCE before CAR, I get the same error. Failed to open the referenced table 'CAR'.
-- Tried the alter method and i get an error code: 1822. Failded to add the foreign key constraint. Missing index for constraint 'car_ibfk_1' in the referenced table 'INSURANCE'.

-- A few other things. I changed Vin Integer to Varchar(17), Name to EmployyeeName, Position to EmpPosition. InvoiceNo has no primary key under INSURANCE table.


CREATE TABLE EMPLOYEE (
	EmployyeeID	       	Integer 	    	NOT NULL,
	EmployyeeName       Varchar	(255) 	    NOT NULL,	-- Name to EmployyeeName
	EmpPosition	        Varchar (255)       NOT NULL,	-- Position to EmpPosition
	Manager    	  		Varchar (255) 	    NOT NULL,   
	YearsOfService     	Datetime 	    	NOT NULL,   -- I entered the starting date.
	SocialSecurity   	Varchar (9)    		NOT NULL,
    Salary				Float				NOT NULL,
    Bonus				Float				NULL,
	CONSTRAINT 		    EMPLOYYEE_PK 		PRIMARY KEY (EmployyeeID)
	); 


CREATE TABLE INVENTORY (
	ParkingSpaceNo	       	Integer 	    	NOT NULL,
    Vin						Varchar (17)		NOT NULL,
    DateUse					Datetime			NOT NULL,
    DateReturn				Datetime			NOT NULL,
    Available				Tinyint(1)			NOT NULL,
    CONSTRAINT 				INVENTORY_PK		PRIMARY KEY (Vin, ParkingSpaceNo),
    CONSTRAINT				INVENTORY_VIN_FK	FOREIGN KEY	(Vin)
									REFERENCES CAR (Vin)
);

CREATE TABLE BADGE (
	BadgeID	       	Integer 	    	NOT NULL,
    EmployyeeID		Integer				NOT NULL,
    Clearance		Varchar (45)		NOT NULL,
    CONSTRAINT		BADGE_PK			PRIMARY KEY (EmployyeeID, BadgeID),
    CONSTRAINT 		BADGE_EMP_FK 		FOREIGN KEY (EmployyeeID)
							REFERENCES  EMPLOYEE (EmployyeeID)
	);



CREATE TABLE MAINTENANCE (
	MaintenanceNo 		Integer  			NOT NULL,
    DateOfService		Datetime			NOT NULL,
    Vin					Varchar (17) 		NOT NULL,
    Mileage				Integer			 	NULL,
    TypeOfService 		Varchar (255)		NOT NULL,
    MaintComment		Varchar (255)		NOT NULL,
    CONSTRAINT			MAINTENANCE_PK		PRIMARY KEY (Vin, MaintenanceNo),
	CONSTRAINT			INVENTORY_VIN_FK	FOREIGN KEY (Vin)
									REFERENCES CAR (Vin)
);

CREATE TABLE RENTALPRICE (
		SizeorType 		Integer  			NOT NULL,
        Price			Float				NULL,
        Vin				Varchar (17)		NOT NULL,
        CONSTRAINT 		RENTAL_PK			PRIMARY KEY (Vin),
        CONSTRAINT		RENTAL_VIN_FK		FOREIGN KEY (Vin)
									REFERENCES CAR (Vin)
);

INSERT INTO RENTAL_CAR VALUES (
	'5XYKWDA74EG536509', 'GT-R', 'NISSAN', 'WHITE', '7BZV628', 'Sedan', 'Geico', '2018-01-14 09:30:00
',1);

INSERT INTO EMPLOYEE VALUES (
	123, 'Arthur Morgan', 'Agent', 'No', '2015-01-14 09:30:00','558515277', 35000.00, null);
    
INSERT INTO BADGE VALUES (
	1, 123, 'No clearance required'
);

INSERT INTO INVENTORY VALUES ( 
	45, '5XYKWDA74EG536509', '2018-01-14 09:30:00', '2018-01-15 09:28:00', 2
);

INSERT INTO INSURANCE VALUES (
	1, '5XYKWDA74EG536509', 2, 'Flawless', 'No repairment required' 
);

INSERT INTO MAINTENANCE VALUES (
	1, '2018-01-14 09:30:00', '5XYKWDA74EG536509', 4232, 'No service required', 'No comment'
);




