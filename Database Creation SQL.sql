--Create name type
CREATE OR REPLACE TYPE name_typ AS OBJECT (
	title VARCHAR2(8),
	firstName VARCHAR2(20),
	surName VARCHAR2(20));

/

--Create address type
CREATE OR REPLACE TYPE address_typ AS OBJECT (
	street VARCHAR2(20),
	city VARCHAR2(20),
	p_code VARCHAR2(8));

/

--Create nested table of mobile phones
CREATE OR REPLACE TYPE mobilePhones_nested AS TABLE OF VARCHAR2(15)

/

--Create phone type
CREATE OR REPLACE TYPE phone_typ AS OBJECT (
	homePhone VARCHAR2(15)
	mobilePhone mobilePhones_nested);
		
/

--Create branch type for Branch table
CREATE OR REPLACE TYPE branch_typ AS OBJECT (
	bID NUMBER,
	bAddress address_typ,
	bPhone VARCHAR2(15));
		
/	

--Create job type
CREATE OR REPLACE TYPE job_typ AS OBJECT (
	position VARCHAR2(20),
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
	accType VARCHAR2(20),
	balance NUMBER,
	bID ref branch_typ
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
	CONSTRAINT bStreet_const CHECK (bAddress.street IS NOT NULL),
	CONSTRAINT bCity_const CHECK (bAddress.city IS NOT NULL),
	CONSTRAINT bP_code CHECK (bAddress.p_code IS NOT NULL)
	CONSTRAINT bPhone_const CHECK (bPhone IS NOT NULL));

/

--Create Account table
CREATE TABLE accountTable OF account_typ (
	accNum PRIMARY KEY,
	CONSTRAINT accType_const CHECK(accType IN ("current", "savings")),
	CONSTRAINT balance_const CHECK(balance IS NOT NULL),
	CONSTRAINT inRate_const CHECK(inRate IS NOT NULL),
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
	CONSTRAINT cNiNum_const UNIQUE(niNum));
	
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
	CONSTRAINT ePosition_const CHECK (eJob.position IN ("Head", "Manager", "Accountant", "Leader", "Cashier")),
	CONSTRAINT eSalary_const CHECK(eJob.salary IS NOT NULL),
	CONSTRAINT eJoinDate_const CHECK(eJob.joinDate IS NOT NULL));
	
/

insert into branchTable (bID, bAddress, bPhone) values (1, {'street':'Westerfield','city':'Zhenghu','p_code':'WN8 OW0'}, '86-(411)478-4891');
insert into branchTable (bID, bAddress, bPhone) values (2, {'street':'Commercial','city':'Santo Antônio do Monte','p_code':'BD9 HG2'}, '55-(243)128-8960');
insert into branchTable (bID, bAddress, bPhone) values (3, {'street':'Merry','city':'Alexandria','p_code':'ZP6 AI0'}, '20-(591)387-2220');
insert into branchTable (bID, bAddress, bPhone) values (4, {'street':'Scoville','city':'Buka','p_code':'IH0 XO9'}, '62-(163)129-5169');
insert into branchTable (bID, bAddress, bPhone) values (5, {'street':'Orin','city':'Jitan','p_code':'XI1 PB9'}, '86-(976)687-6109');
insert into branchTable (bID, bAddress, bPhone) values (6, {'street':'Basil','city':'Laval','p_code':'ND2 IQ7'}, '33-(959)617-6999');
insert into branchTable (bID, bAddress, bPhone) values (7, {'street':'Trailsway','city':'Yashalta','p_code':'NL5 QW0'}, '7-(273)645-9765');
insert into branchTable (bID, bAddress, bPhone) values (8, {'street':'Magdeline','city':'Sumqayıt','p_code':'KF6 RN6'}, '994-(567)573-1198');
insert into branchTable (bID, bAddress, bPhone) values (9, {'street':'Dryden','city':'Pittsburgh','p_code':'MB6 KV7'}, '1-(412)481-3007');
insert into branchTable (bID, bAddress, bPhone) values (10, {'street':'Hazelcrest','city':'Breu','p_code':'VG7 BD7'}, '51-(592)482-5606');
insert into branchTable (bID, bAddress, bPhone) values (11, {'street':'Linden','city':'Dengfang','p_code':'DG6 UT3'}, '86-(593)254-5941');
insert into branchTable (bID, bAddress, bPhone) values (12, {'street':'Armistice','city':'Bei','p_code':'CI3 VC0'}, '62-(944)990-9309');
insert into branchTable (bID, bAddress, bPhone) values (13, {'street':'Carioca','city':'Sarmanovo','p_code':'DO1 CX0'}, '7-(330)964-9719');
insert into branchTable (bID, bAddress, bPhone) values (14, {'street':'Mariners Cove','city':'Föglö','p_code':'RZ4 XA0'}, '358-(618)405-9497');
insert into branchTable (bID, bAddress, bPhone) values (15, {'street':'Corry','city':'Charlemagne','p_code':'MD1 VE5'}, '1-(940)810-7302');
insert into branchTable (bID, bAddress, bPhone) values (16, {'street':'Hauk','city':'Longjin','p_code':'GU6 FQ8'}, '86-(475)236-3250');
insert into branchTable (bID, bAddress, bPhone) values (17, {'street':'Northfield','city':'Rey','p_code':'ZS6 DK4'}, '98-(754)579-0060');
insert into branchTable (bID, bAddress, bPhone) values (18, {'street':'Moland','city':'Samashki','p_code':'AG6 JX8'}, '7-(317)754-6463');
insert into branchTable (bID, bAddress, bPhone) values (19, {'street':'Chive','city':'Vereya','p_code':'GD0 IQ8'}, '7-(840)591-1520');
insert into branchTable (bID, bAddress, bPhone) values (20, {'street':'Portage','city':'San José','p_code':'QU8 KP4'}, '506-(220)966-3351');