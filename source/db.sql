-- Active: 1668065856987@@127.0.0.1@3306
DROP SCHEMA IF EXISTS `project`;

CREATE SCHEMA IF NOT EXISTS `project` DEFAULT CHARACTER SET utf8;
USE `project`;

CREATE TABLE user
(USER_ID   INT AUTO_INCREMENT,
FIRST_NAME  VARCHAR(20),
LAST_NAME   VARCHAR(20),
PHONE_NUMBER VARCHAR(20),
REGION     VARCHAR(20),
COUNTRY_NAME VARCHAR(10),
PROVINCE   VARCHAR(25),
ROLE  VARCHAR(10),
STREET_ADDRESS VARCHAR(40),
PASSWARD VARCHAR(40),
PRIMARY KEY(USER_ID));

CREATE TABLE package
(USER_ID   INT,
PACKAGE_ID  INT AUTO_INCREMENT,
BUDGET  DEC(6,2),
CREATE_TIME DATETIME,
DEADLINE  DATETIME,
PRIMARY KEY(PACKAGE_ID),
FOREIGN KEY(USER_ID) REFERENCES user(USER_ID));

CREATE TABLE state
(PACKAGE_ID  INT,
START_TIME DATETIME,
END_TIME DATETIME,
NAME VARCHAR(20),
FOREIGN KEY(PACKAGE_ID) REFERENCES package(PACKAGE_ID));

CREATE TABLE machine_type
(MACHINE_NAME VARCHAR(20),
MACHINE_VERSION  INT,
PRICE  INT,
PRIMARY KEY(MACHINE_NAME,MACHINE_VERSION));

CREATE TABLE plant
(PLANT_ID  INT AUTO_INCREMENT,
PLANT_NAME VARCHAR(20),
PHONE_NUMBER VARCHAR(20),
BOSS_ID  INT,
COUNTRY_NAME VARCHAR(10),
PROVINCE  VARCHAR(25),
STREET_ADDRESS  VARCHAR(40),
PRIMARY KEY(PLANT_ID));

CREATE TABLE machine
(MACHINE_NAME VARCHAR(20),
MACHINE_VERSION  INT,
PLANT_ID  INT,
MACHINE_ID  INT AUTO_INCREMENT,
PLANT_LABEL  VARCHAR(10),
PRIMARY KEY(MACHINE_ID),
FOREIGN KEY(MACHINE_NAME,MACHINE_VERSION) REFERENCES machine_type(MACHINE_NAME,MACHINE_VERSION),
FOREIGN KEY(PLANT_ID) REFERENCES plant(PLANT_ID));

CREATE TABLE chip_type
(CHIP_NAME  VARCHAR(20),
CHIP_VERSION  VARCHAR(20),
PRIMARY KEY(CHIP_NAME,CHIP_VERSION));

CREATE TABLE chip
(CHIP_NAME  VARCHAR(20),
CHIP_VERSION  VARCHAR(20),
PACKAGE_ID  INT,
CHIP_ID  INT AUTO_INCREMENT,
PRIMARY KEY(CHIP_ID),
FOREIGN KEY(CHIP_NAME,CHIP_VERSION) REFERENCES chip_type(CHIP_NAME,CHIP_VERSION),
FOREIGN KEY(PACKAGE_ID) REFERENCES package(PACKAGE_ID));

CREATE TABLE operation_type
(OPERATION_NAME  VARCHAR(20),
PRIMARY KEY(OPERATION_NAME));

CREATE TABLE operation
(OPERATION_NAME  VARCHAR(20),
OPERATION_ID  INT AUTO_INCREMENT,
START_TIME  DATETIME,
END_TIME  DATETIME,
PRIMARY KEY(OPERATION_ID),
FOREIGN KEY(OPERATION_NAME) REFERENCES operation_type(OPERATION_NAME));

CREATE TABLE operation_with_machine
(OPERATION_ID  INT,
MACHINE_ID INT,
START_TIME  DATETIME,
END_TIME  DATETIME,
PRIMARY KEY(OPERATION_ID,MACHINE_ID),
FOREIGN KEY(OPERATION_ID) REFERENCES operation(OPERATION_ID),
FOREIGN KEY(MACHINE_ID) REFERENCES machine(MACHINE_ID));

CREATE TABLE plant_with_package
(PACKAGE_ID  INT,
PLANT_ID  INT,
PRIMARY KEY(PACKAGE_ID,PLANT_ID),
FOREIGN KEY(PACKAGE_ID) REFERENCES package(PACKAGE_ID),
FOREIGN KEY(PLANT_ID) REFERENCES plant(PLANT_ID));

CREATE TABLE chip_type_with_operation_type
(ORDER_OP  INT,
OPERATION_NAME  VARCHAR(20),
CHIP_NAME  VARCHAR(20),
CHIP_VERSION  VARCHAR(20),
PRIMARY KEY(OPERATION_NAME,CHIP_NAME,CHIP_VERSION),
FOREIGN KEY(OPERATION_NAME) REFERENCES operation_type(OPERATION_NAME),
FOREIGN KEY(CHIP_NAME, CHIP_VERSION) REFERENCES chip_type(CHIP_NAME,CHIP_VERSION));

CREATE TABLE machine_type_with_operation_type
(OPERATION_NAME  VARCHAR(20),
MACHINE_NAME VARCHAR(20),
MACHINE_VERSION  INT,
EXPENSE  INT,
DURATION  INT,
PRIMARY KEY(OPERATION_NAME,MACHINE_NAME,MACHINE_VERSION),
FOREIGN KEY(OPERATION_NAME) REFERENCES operation_type(OPERATION_NAME),
FOREIGN KEY(MACHINE_NAME,MACHINE_VERSION) REFERENCES machine_type(MACHINE_NAME,MACHINE_VERSION));



/* INSERT INTO `user` (`USER_ID`, `FIRST_NAME`, `LAST_NAME`,`PHONE_NUMBER`,`REGION`,`COUNTRY_NAME`,`PROVINCE`,`STREET_ADDRESS`,`PASSWARD`) VALUES
('100','Steven','King','515.123.4567','Europe','France','Pairs','1297 Via Cola di Rie','12345');
INSERT INTO `package` (`PACKAGE_ID`, `BUDGET`, `CREATE_TIME`,`DEADLINE`) VALUES
('001','1000','2022-12-6 13:02:23','2022-12-13 13:02:23');
INSERT INTO `state` (`START_TIME`, `END_TIME`, `NAME`) VALUES
('2022-12-6 14:02:23','2022-12-7 13:02:23','FINISHED');
INSERT INTO `plant` (`PLANT_ID`, `PLANT_NAME`, `PHONE_NUMBER`,`BOSS_ID`,`COUNTRY_NAME`,`PROVINCE`,`STREET_ADDRESS`) VALUES
('001','A','515.123.4588','200','France','Pairs','1230 Via Cola di Rie');
INSERT INTO `machine_type` (`MACHINE_NAME`, `MACHINE_VERSION`, `PRICE`) VALUES
('welding machine','001','12000');
INSERT INTO `machine` (`MACHINE_ID`, `PLANT_LABEL`) VALUES
('00001','A');
INSERT INTO `chip_type` (`CHIP_NAME`, `CHIP_VERSION`) VALUES
('ARM','001');
INSERT INTO `chip` (`CHIP_ID`) VALUES
('000001');
INSERT INTO `operation_type` (`OPERATION_NAME`) VALUES
('weld');
INSERT INTO `operation` (`OPERATION_ID`, `START_TIME`, `END_TIME`) VALUES
('0011','2022-12-6 14:02:23','2022-12-7 13:02:23');
INSERT INTO `plant_with_machine_type` (`PLANT_ID`,`MACHINE_NAME`,`MACHINE_VERSION`) VALUES
('001','welding machine','001'); */

