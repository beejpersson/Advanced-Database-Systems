--Create name type
CREATE OR REPLACE TYPE name_typ AS OBJECT (
	title VARCHAR2(8),
	firstName VARCHAR2(30),
	surName VARCHAR2(30));

/

--Create address type
CREATE OR REPLACE TYPE address_typ AS OBJECT (
	street VARCHAR2(30),
	city VARCHAR2(30),
	p_code VARCHAR2(8));

/

--Create nested table of mobile phones
CREATE OR REPLACE TYPE mobilePhones_nested AS TABLE OF VARCHAR2(20)

/

--Create phone type
CREATE OR REPLACE TYPE phone_typ AS OBJECT (
	homePhone VARCHAR2(20),
	mobilePhone mobilePhones_nested);
		
/

--Create branch type for Branch table
CREATE OR REPLACE TYPE branch_typ AS OBJECT (
	bID NUMBER,
	bAddress address_typ,
	bPhone VARCHAR2(20));
		
/	

--Create job type
CREATE OR REPLACE TYPE job_typ AS OBJECT (
	position VARCHAR2(30),
	salary NUMBER,
	bID ref branch_typ,
	joinDate DATE);
	
/

--Create person type to be supertype to Customer and Employee
CREATE OR REPLACE TYPE person_typ AS OBJECT (
	pName name_typ,
	pAddress address_typ,
	pPhone phone_typ,
	niNum VARCHAR(20))
	NOT FINAL;
	
/

--Create customer subtype for Customer table
CREATE OR REPLACE TYPE customer_typ UNDER person_typ (
	custID NUMBER);
	
/

--Create employee subtype for Employee table
CREATE OR REPLACE TYPE employee_typ UNDER person_typ (
	empID NUMBER,
	supervisorID NUMBER,
	eJob job_typ);

/

--Create account type for Account table
CREATE OR REPLACE TYPE account_typ AS OBJECT (
	accNum NUMBER,
	accType VARCHAR2(30),
	balance NUMBER,
	bID ref branch_typ,
	inRate NUMBER,
	limitOfFreeOD NUMBER,
	openDate DATE);

/

--Create customerAccount type for CustomerAccount table
CREATE OR REPLACE TYPE customerAccount_typ AS OBJECT (
	custID ref customer_typ,
	accNum ref account_typ);

/

--Create Branch table
CREATE TABLE branchTable OF branch_typ (
	bID PRIMARY KEY,
	CONSTRAINT bStreet_const CHECK(bAddress.street IS NOT NULL),
	CONSTRAINT bCity_const CHECK(bAddress.city IS NOT NULL),
	CONSTRAINT bP_code CHECK(bAddress.p_code IS NOT NULL),
	CONSTRAINT bPhone_const CHECK(bPhone IS NOT NULL));

/

--Create Account table
CREATE TABLE accountTable OF account_typ (
	accNum PRIMARY KEY,
	CONSTRAINT accType_const CHECK(accType IN ('current', 'savings')),
	CONSTRAINT balance_const CHECK(balance IS NOT NULL),
	CONSTRAINT inRate_const CHECK(inRate IS NOT NULL),
    CONSTRAINT limitOfFreeOD_const CHECK(limitOfFreeOD IS NOT NULL),
	CONSTRAINT openDate_const CHECK(openDate IS NOT NULL));
	
/

--Create CustomerAccount table
CREATE TABLE customerAccountTable OF customerAccount_typ;

/

--Create Customer table
CREATE TABLE customerTable OF customer_typ (
	custID PRIMARY KEY,
	CONSTRAINT cTitle_const CHECK(pName.title IS NOT NULL),
	CONSTRAINT cFirstName_const CHECK(pName.firstName IS NOT NULL),
	CONSTRAINT cSurName_const CHECK(pName.surName IS NOT NULL),
	CONSTRAINT cStreet_const CHECK(pAddress.street IS NOT NULL),
	CONSTRAINT cCity_const CHECK(pAddress.city IS NOT NULL),
	CONSTRAINT cP_Code_const CHECK(pAddress.p_code IS NOT NULL),
	CONSTRAINT cNiNum_const UNIQUE(niNum))
    NESTED TABLE pPhone.mobilePhone STORE AS cMobilePhones_nested_table;
	
/

--Create Employee table
CREATE TABLE employeeTable OF employee_typ (
	empID PRIMARY KEY,
	CONSTRAINT supervisorID_const CHECK(supervisorID IS NOT NULL),
	CONSTRAINT eTitle_const CHECK(pName.title IS NOT NULL),
	CONSTRAINT eFirstName_const CHECK(pName.firstName IS NOT NULL),
	CONSTRAINT eSurName_const CHECK(pName.surName IS NOT NULL),
	CONSTRAINT eStreet_const CHECK(pAddress.street IS NOT NULL),
	CONSTRAINT eCity_const CHECK(pAddress.city IS NOT NULL),
	CONSTRAINT eP_Code_const CHECK(pAddress.p_code IS NOT NULL),
	CONSTRAINT eNiNum_const UNIQUE(niNum),
	CONSTRAINT ePosition_const CHECK (eJob.position IN ('Head', 'Manager', 'Accountant', 'Leader', 'Cashier')),
	CONSTRAINT eSalary_const CHECK(eJob.salary IS NOT NULL),
	CONSTRAINT eJoinDate_const CHECK(eJob.joinDate IS NOT NULL))
    NESTED TABLE pPhone.mobilePhone STORE AS eMobilePhones_nested_table;
	
/

--Insert Data into Branch Table
insert into branchTable values (1, address_typ('Westerfield', 'Zhenghu', 'WN8 OW0'), '86-(411)478-4891');
insert into branchTable values (2, address_typ('Commercial', 'Santo Antônio do Monte', 'BD9 HG2'), '55-(243)128-8960');
insert into branchTable values (3, address_typ('Merry', 'Alexandria', 'ZP6 AI0'), '20-(591)387-2220');
insert into branchTable values (4, address_typ('Scoville', 'Buka', 'IH0 XO9'), '62-(163)129-5169');
insert into branchTable values (5, address_typ('Orin', 'Jitan', 'XI1 PB9'), '86-(976)687-6109');
insert into branchTable values (6, address_typ('Basil', 'Laval', 'ND2 IQ7'), '33-(959)617-6999');
insert into branchTable values (7, address_typ('Trailsway', 'Yashalta', 'NL5 QW0'), '7-(273)645-9765');
insert into branchTable values (8, address_typ('Magdeline', 'Sumqayıt', 'KF6 RN6'), '994-(567)573-1198');
insert into branchTable values (9, address_typ('Dryden', 'Pittsburgh', 'MB6 KV7'), '1-(412)481-3007');
insert into branchTable values (10, address_typ('Hazelcrest', 'Breu', 'VG7 BD7'), '51-(592)482-5606');
insert into branchTable values (11, address_typ('Linden', 'Dengfang', 'DG6 UT3'), '86-(593)254-5941');
insert into branchTable values (12, address_typ('Armistice', 'Bei', 'CI3 VC0'), '62-(944)990-9309');
insert into branchTable values (13, address_typ('Carioca', 'Sarmanovo','DO1 CX0'), '7-(330)964-9719');
insert into branchTable values (14, address_typ('Mariners Cove', 'Föglö', 'RZ4 XA0'), '358-(618)405-9497');
insert into branchTable values (15, address_typ('Corry', 'Charlemagne', 'MD1 VE5'), '1-(940)810-7302');
insert into branchTable values (16, address_typ('Hauk', 'Longjin', 'GU6 FQ8'), '86-(475)236-3250');
insert into branchTable values (17, address_typ('Northfield', 'Rey', 'ZS6 DK4'), '98-(754)579-0060');
insert into branchTable values (18, address_typ('Moland', 'Samashki', 'AG6 JX8'), '7-(317)754-6463');
insert into branchTable values (19, address_typ('Chive', 'Vereya', 'GD0 IQ8'), '7-(840)591-1520');
insert into branchTable values (20, address_typ('Portage', 'San José', 'QU8 KP4'), '506-(220)966-3351');

--Insert Data into Account Table
insert into accountTable values (101, 'savings', 6376.8, (SELECT REF(b) FROM branchTable b WHERE b.bID = 1), 0.056, 497, '14-Dec-2000');
insert into accountTable values (102, 'savings', 5798.7, (SELECT REF(b) FROM branchTable b WHERE b.bID = 17), 0.197, 599, '19-Nov-2000');
insert into accountTable values (103, 'current', 6922.42, (SELECT REF(b) FROM branchTable b WHERE b.bID = 5), 0.021, 107, '13-Apr-2004');
insert into accountTable values (104, 'savings', 4780.39, (SELECT REF(b) FROM branchTable b WHERE b.bID = 1), 0.191, 123, '12-Jul-2011');
insert into accountTable values (105, 'current', 213.12, (SELECT REF(b) FROM branchTable b WHERE b.bID = 6), 1.798, 67, '15-May-2005');
insert into accountTable values (106, 'savings', 4047.7, (SELECT REF(b) FROM branchTable b WHERE b.bID = 19), 1.748, 331, '28-Sep-2005');
insert into accountTable values (107, 'savings', 3756.8, (SELECT REF(b) FROM branchTable b WHERE b.bID = 8), 1.573, 676, '02-Mar-2001');
insert into accountTable values (108, 'current', 2336.28, (SELECT REF(b) FROM branchTable b WHERE b.bID = 2), 0.652, 694, '03-Jul-2001');
insert into accountTable values (109, 'current', 9219.34, (SELECT REF(b) FROM branchTable b WHERE b.bID = 3), 0.713, 528, '13-Oct-2006');
insert into accountTable values (110, 'savings', 7693.28, (SELECT REF(b) FROM branchTable b WHERE b.bID = 8), 0.698, 261, '30-Mar-2016');
insert into accountTable values (111, 'current', 2059.5, (SELECT REF(b) FROM branchTable b WHERE b.bID = 15), 1.94, 981, '19-Dec-2003');
insert into accountTable values (112, 'savings', 737.47, (SELECT REF(b) FROM branchTable b WHERE b.bID = 14), 0.052, 696, '10-Aug-2006');
insert into accountTable values (113, 'savings', 7126.53, (SELECT REF(b) FROM branchTable b WHERE b.bID = 18), 0.527, 157, '28-Sep-2012');
insert into accountTable values (114, 'savings', 2849.39, (SELECT REF(b) FROM branchTable b WHERE b.bID = 4), 0.907, 145, '28-Feb-2014');
insert into accountTable values (115, 'current', 7880.63, (SELECT REF(b) FROM branchTable b WHERE b.bID = 6), 1.769, 852, '08-Nov-2011');
insert into accountTable values (116, 'savings', 2178.58, (SELECT REF(b) FROM branchTable b WHERE b.bID = 2), 0.615, 112, '29-Mar-2000');
insert into accountTable values (117, 'current', 6568.43, (SELECT REF(b) FROM branchTable b WHERE b.bID = 13), 0.047, 115, '24-Jun-2011');
insert into accountTable values (118, 'savings', 2552.88, (SELECT REF(b) FROM branchTable b WHERE b.bID = 16), 1.901, 51, '11-May-2012');
insert into accountTable values (119, 'current', 2878.95, (SELECT REF(b) FROM branchTable b WHERE b.bID = 11), 1.952, 927, '08-Oct-2006');
insert into accountTable values (120, 'savings', 1109.63, (SELECT REF(b) FROM branchTable b WHERE b.bID = 7), 0.725, 854, '27-Nov-2009');