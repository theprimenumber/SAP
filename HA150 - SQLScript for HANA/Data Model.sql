-- Data Model File
-- Description   : This is the sample data model described in "HA150 - SQLScript for HANA" training from SAP Guides. 
-- Written by    : YM
-- Last Updated  : 2025-April-24


-- Scenario
-- The database of a fictional registration office serves as the basis for further explanations.
-- The tables in this database have been specifically tailored to the SQL course and are not an example of good database design.
-- The officials working in the fictional registration office have a manager.
-- Each vehicle is registered for exactly one owner (or is unregistered).
-- There is a list of vehicles that have been reported stolen.
-- Owners, who have at least three vehicles registered, are assigned to one or multiple contacts.

-- NOTE: If facing any issue due to Auto Commit DDL is ON, wrap the code in a Anonymous Procedure block, so that DDL Commit will be Off.

DO
  BEGIN
  -- Table Definition: Official
  CREATE COLUMN TABLE Official(
    PNR VARCHAR(3) PRIMARY KEY,
    Name VARCHAR(20),
    Overtime INTEGER,
    Salary VARCHAR(3),
    Manager VARCHAR(3),
    FOREIGN KEY(Manager) REFERENCES Official(PNR) INITIALLY DEFERRED
  );

  -- Data Setup for Table 'Official'
  INSERT INTO Official VALUES ('P01','Mr A','10','A09','P04');
  INSERT INTO Official VALUES ('P02','Mr B','10','A10','P04');
  INSERT INTO Official VALUES ('P03','Ms C','20','A09','P04');
  INSERT INTO Official VALUES ('P04','Ms D',NULL,'A12','P09');
  INSERT INTO Official VALUES ('P05','Mr E','10','A08','P08');
  INSERT INTO Official VALUES ('P06','Mr F','18','A09','P08');
  INSERT INTO Official VALUES ('P07','Ms G','22','A11','P08');
  INSERT INTO Official VALUES ('P08','Ms H',NULL,'A13','P09');
  INSERT INTO Official VALUES ('P09','Mr I',NULL,'A14',NULL);

-- Owner Registration is done in table 'Owner'. Note that owners who are people have a birthday, but owners that are companies do not (There is no mechanism for it, so it should be on common sense).
-- Table Definition: Owner
  CREATE COLUMN TABLE Owner(
    OwnerID VARCHAR(3) PRIMARY KEY,
    Name VARCHAR(20),
    Birthday DATE,
    City VARCHAR(20)
  );

-- Data Setup for Table 'Owner'
  INSERT INTO Owner VALUES('H01','Ms T','1934-06-20','Wiesloch');
  INSERT INTO Owner VALUES('H02','Ms U','1966-05-11','Hockenheim');
  INSERT INTO Owner VALUES('H03','SAP AG',NULL,'Walldorf');
  INSERT INTO Owner VALUES('H04','HDM AG',NULL,'Heidelberg');
  INSERT INTO Owner VALUES('H05','Mr V','1952-04-21','Leimen');
  INSERT INTO Owner VALUES('H06','Ms W','1957-06-01','Wiesloch');
  INSERT INTO Owner VALUES('H07','IKEA',NULL,'Walldorf');
  INSERT INTO Owner VALUES('H08','Mr X','1986-08-30','Walldorf');
  INSERT INTO Owner VALUES('H09','Ms Y','1986-02-10','Sinsheim');
  INSERT INTO Owner VALUES('H10','Mr Z','1986-02-03','Ladenburg');

-- The Car database table relates the Cars to their owners and unregistered cars are not assigned to any owner, where NULL is used.
-- Table Definition: Car
  CREATE COLUMN TABLE Car(
    CarID VARCHAR(3) PRIMARY KEY,
    PlateNumber VARCHAR(10) UNIQUE,
    Brand VARCHAR(20),
    Color VARCHAR(10),
    HP INTEGER,
    Owner VARCHAR(3),
    FOREIGN KEY(Owner) REFERENCES Owner(OwnerID) INITIALLY IMMEDIATE
  );

-- Data Setup for table 'Car'
  INSERT INTO Car VALUES('F01','HD-V 106','Fiat','red','75','H06');
  INSERT INTO Car VALUES('F02','HD-VW 4711','VW','black','120','H03');
  INSERT INTO Car VALUES('F03','HD-JA 1972','BMW','blue','184','H03');
  INSERT INTO Car VALUES('F04','HD-AL 1002','Mercedes','white','136','H07');
  INSERT INTO Car VALUES('F05','HD-MM 3206','Mercedes','black','170','H03');
  INSERT INTO Car VALUES('F06','HD-VW 1999','Audi','yellow','260','H05');
  INSERT INTO Car VALUES('F07','HD-ML 3206','Audi','blue','116','H03');
  INSERT INTO Car VALUES('F08','HD-IK 1002','VW','black','160','H07');
  INSERT INTO Car VALUES('F09','HD-UP 13','Skoda','red','105','H02');
  INSERT INTO Car VALUES('F10','HD-MT 507','BMW','black','140','H04');
  INSERT INTO Car VALUES('F11','HD-MM 208','BMW','green','184','H02');
  INSERT INTO Car VALUES('F12','HD-XY 4711','Skoda','red','105','H04');
  INSERT INTO Car VALUES('F13','HD-IK 1001','Renault','red','136','H07');
  INSERT INTO Car VALUES('F14','HD-MM 1977','Mercedes','white','170','H03');
  INSERT INTO Car VALUES('F15','HD-MB 3030','Skoda','black','136','H03');
  INSERT INTO Car VALUES('F16',NULL,'Opel','green','120',NULL);
  INSERT INTO Car VALUES('F17','HD-Y 333','Audi','orange','184','H09');
  INSERT INTO Car VALUES('F18','HD-MQ 2006','Renault','red','90','H03');
  INSERT INTO Car VALUES('F19','HD-VW 2012','VW','black','125','H01');
  INSERT INTO Car VALUES('F20',NULL,'Audi','green','184',NULL);

-- The Contact database table relates a car owner owning more than two cars to the officials who are the respective contact persons. (There is no mechanism to verify for it, but it is possible by grouping)
-- Table Definition: Contact
  CREATE COLUMN TABLE Contact(
    PersNumber VARCHAR(3),
    Owner VARCHAR(3),
    FOREIGN KEY(PersNumber) REFERENCES Official(PNR) INITIALLY IMMEDIATE,
    FOREIGN KEY(Owner)      REFERENCES Owner(OwnerID) INITIALLY IMMEDIATE
  );

-- Data Setup for Table 'Contact'
  INSERT INTO Contact VALUES('P01','H03');
  INSERT INTO Contact VALUES('P01','H04');
  INSERT INTO Contact VALUES('P01','H07');
  INSERT INTO Contact VALUES('P04','H03');
  INSERT INTO Contact VALUES('P04','H04');
  INSERT INTO Contact VALUES('P08','H04');
  INSERT INTO Contact VALUES('P08','H07');
  INSERT INTO Contact VALUES('P09','H03');

-- The Stolen database table contains stolen cars and their reported dates.
-- Table Definition: Stolen
  CREATE COLUMN TABLE Stolen(
    PlateNumber VARCHAR(10),
    Reported_At DATE,
    FOREIGN KEY(PlateNumber) REFERENCES Car(PlateNumber) INITIALLY IMMEDIATE
  );

-- Data Setup for Table 'Stolen'
  INSERT INTO Stolen VALUES('HD-VW 1999','2012-06-20');
  INSERT INTO Stolen VALUES('HD-V 106','2012-06-01');
  INSERT INTO Stolen VALUES('HD-Y 333','2012-05-21');

END;
