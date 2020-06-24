CREATE DATABASE  IF NOT EXISTS `Project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `Project`;
-- MySQL dump 10.13  Distrib 8.0.19, for macos10.15 (x86_64)
--
-- Host: localhost    Database: Project
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins` i.e 2NF (Transitive dependancy i.e Name depends on students_id and student_id on admin_id)
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `club_id` varchar(20) NOT NULL,
  `club_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `student_id` (`student_id`,`club_id`),
  KEY `club_id` (`club_id`),
  KEY `club_name` (`club_name`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `admins_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `clubs_and_societies` (`club_id`) ON DELETE CASCADE,
  CONSTRAINT `admins_ibfk_3` FOREIGN KEY (`club_name`) REFERENCES `clubs_and_societies` (`club_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calender` i.e a BNCF
--

DROP TABLE IF EXISTS `calender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calender` (
  `cid` int NOT NULL auto_increment,
  `student_id` int NOT NULL,
  `datex` timestamp NOT NULL,
  `title` varchar(30) NOT NULL,
  `descriptions` varchar(1000) DEFAULT NULL,
  `venue` varchar(20) NOT NULL,
  PRIMARY KEY (`cid`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `calender_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calender`
--

LOCK TABLES `calender` WRITE;
/*!40000 ALTER TABLE `calender` DISABLE KEYS */;
/*!40000 ALTER TABLE `calender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clubs_and_societies` i.e a 3NF
--

DROP TABLE IF EXISTS `clubs_and_societies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubs_and_societies` (
  `club_id` varchar(20) NOT NULL,
  `club_name` varchar(50) NOT NULL,
  `calendar` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`club_id`),
  UNIQUE KEY `club_name` (`club_name`),
  UNIQUE KEY `calendar` (`calendar`),
  CONSTRAINT `clubs_and_societies_chk_1` CHECK ((length(`club_name`) >= 4))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubs_and_societies`
--

LOCK TABLES `clubs_and_societies` WRITE;
/*!40000 ALTER TABLE `clubs_and_societies` DISABLE KEYS */;
INSERT INTO `clubs_and_societies` VALUES ('by','byld',NULL),('cc','Cultural Committee',NULL),('el','elecroholics',NULL),('fb','foobar',NULL),('mt','MadToes',NULL);
/*!40000 ALTER TABLE `clubs_and_societies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_details` i.e. a BNCF/4NF
--

DROP TABLE IF EXISTS `contact_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_details` (
  `student_id` int NOT NULL,
  `telegram_handle` varchar(30) DEFAULT NULL,
  `github` varchar(30) DEFAULT NULL,
  `email_address` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `email_address` (`student_id`,`email_address`),
  CONSTRAINT `contact_details_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `contact_details_chk_1` CHECK ((`email_address` like _utf8mb4'%_@__%._%'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_details`
--

LOCK TABLES `contact_details` WRITE;
/*!40000 ALTER TABLE `contact_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contents` i.e BNCF/4NF
--

DROP TABLE IF EXISTS `contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contents` (
  `con_id` int NOT NULL AUTO_INCREMENT,
  `created_at` varchar(50) DEFAULT NULL,
  `student_id` int NOT NULL,
  `course_no` varchar(7) NOT NULL,
  `name_of_content` varchar(30) NOT NULL,
  `type_of_doc` varchar(30) NOT NULL,
  `link_of_doc` varchar(500) NOT NULL UNIQUE,
  PRIMARY KEY (`con_id`),
  UNIQUE KEY (`student_id`,`name_of_content`),
  CONSTRAINT `contents_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contents`
--

LOCK TABLES `contents` WRITE;
/*!40000 ALTER TABLE `contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events` i.e BNCF/4NF
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `club_id` varchar(20) NOT NULL,
  `photos_link` varchar(100) DEFAULT NULL,
  `date` timestamp NOT NULL,
  `event_updates` varchar(1000) DEFAULT NULL,
  `event_name` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `photos_link` (`photos_link`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs_and_societies` (`club_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'cc',NULL,"2020-11-23 23:00:56",NULL,'cadence',NULL),(2,'by',NULL,"2020-11-23 23:00:55",NULL,'hackathon',NULL),(3,'fb',NULL,"2020-11-23 23:01:56",NULL,'pro_sort',NULL),(4,'fb',NULL,"2020-11-23 22:00:56",NULL,'icpc_type_pro_sort',NULL),(5,'el',NULL,"2020-11-23 23:30:56",NULL,'tinker_hack',NULL),(6,'el',NULL,"2020-10-23 23:00:56",NULL,'tinker_hack',NULL);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FMS_Complaint` i.e BNCF
--

DROP TABLE IF EXISTS `FMS_Complaint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FMS_Complaint` (
  `Complaint_ID` int NOT NULL AUTO_INCREMENT,
  `Full_Name` varchar(250) NOT NULL,
  `Email` varchar(250) NOT NULL,
  `Phone_Number` char(10) NOT NULL,
  `Location_ID` int NOT NULL,
  `Room` varchar(50) NOT NULL,
  `Description` varchar(500) NOT NULL,
  `Status` varchar(4) NOT NULL,
  PRIMARY KEY (`Complaint_ID`),
  UNIQUE KEY `Complaint_ID` (`Complaint_ID`),
  KEY `Location_ID` (`Location_ID`),
  CONSTRAINT `fms_complaint_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `Service_Location` (`Location_ID`),
  CONSTRAINT `comp_ph_no_checker` check (`Phone_Number` REGEXP '^[0-9]*$'),
  CONSTRAINT `comp_ph_no_len_checker` check (length(`Phone_Number`)=10),
  CONSTRAINT `status_checker_comp` check (Status in ('Yes','No','None'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FMS_Complaint`
--

LOCK TABLES `FMS_Complaint` WRITE;
/*!40000 ALTER TABLE `FMS_Complaint` DISABLE KEYS */;
INSERT INTO `FMS_Complaint` VALUES (1,'Paarmita Jhalani','paarmita18353@iiitd.ac.in','9900887755',6,'C214','Broken Handle','No'),(2,'PARTH SINGH','parth18356@iiitd.ac.in','9898767676',10,'6','Water Cooler not working','No'),(3,'Pragya Gandhi','pragya18357@iiitd.ac.in','8800997766',7,'507','Tublight not working','No'),(4,'PRANAY JAIN','pranay18358@iiitd.ac.in','8800774483',7,'709','Tublight not working','No'),(5,'PRASHAM NARAYAN','prasham18359@iiitd.ac.in','9988554466',10,'708','AC not working','No'),(6,'JUHI PANDEY','juhi18393@iiitd.ac.in','9987765432',8,'A209','Pest ','No'),(7,'KARAN CHAWLA','karan18394@iiitd.ac.in','9876543210',8,'C306','Pest','No'),(8,'MANAV JAISWAL','manav18396@iiitd.ac.in','9876512340',9,'TT Room','AC not working','No'),(9,'MOHAMMAD ASAD','mohammad18397@iiitd.ac.in','9807060504',8,'B108','no hot water ','No'),(10,'MRINAL','mrinal18398@iiitd.ac.in','9876050505',7,'804','no hot water ','No');
/*!40000 ALTER TABLE `FMS_Complaint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FMS_Request` i.e BNCF
--

DROP TABLE IF EXISTS `FMS_Request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FMS_Request` (
  `request_ID` int NOT NULL AUTO_INCREMENT,
  `Full_Name` varchar(250) NOT NULL,
  `Email` varchar(250) NOT NULL,
  `Phone_Number` char(10) NOT NULL,
  `Location_ID` int NOT NULL,
  `Room` varchar(50) NOT NULL,
  `Description` varchar(500) NOT NULL,
  `Status` varchar(4) NOT NULL,
  PRIMARY KEY (`request_ID`),
  UNIQUE KEY `request_ID` (`request_ID`),
  KEY `Location_ID` (`Location_ID`),
  CONSTRAINT `fms_request_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `Service_Location` (`Location_ID`),
  CONSTRAINT `req_ph_no_checker` check (`Phone_Number` REGEXP '^[0-9]*$'),
  CONSTRAINT `req_ph_no_len_checker` check (length(`Phone_Number`)=10),
  CONSTRAINT `status_checker` check (Status in ('Yes','No','None'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FMS_Request`
--

LOCK TABLES `FMS_Request` WRITE;
/*!40000 ALTER TABLE `FMS_Request` DISABLE KEYS */;
INSERT INTO `FMS_Request` VALUES (1,'Advika Singh','advika18275@iiitd.ac.in','9932673280',6,'C214','Room Cleanup','No'),(2,'ANEESHA LAKRA','aneesha18277@iiitd.ac.in','9898767676',6,'6','Room Cleanup','No'),(3,'Arnav','arnav18278@iiitd.ac.in','8800997766',7,'507','Room Cleanup','No'),(4,'Arunesh','arunesh18279@iiitd.ac.in','8800774483',7,'709','Room Cleanup','No'),(5,'DHRUV YADAV','dhruv18281@iiitd.ac.in','9988554466',4,'C101','Cleanup','No'),(6,'Chirag Jain','chirag17041@iiitd.ac.in','9987765432',3,'A209','Room Cleanup','No'),(7,'Sarthak Negi','sarthak17097@iiitd.ac.in','9876543210',3,'C306','Room Cleanup','No'),(8,'Apoorv Kumar','apoorv17136@iiitd.ac.in','9876512340',3,'B201','Room Cleanup','No'),(9,'Himanshu','himanshu17153@iiitd.ac.in','9807060504',3,'B108','Room Cleanup','No'),(10,'Karamveer Singh','karamveer17156@iiitd.ac.in','9876050505',9,'Badminton Court ','Court Cleanup','No');
/*!40000 ALTER TABLE `FMS_Request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interests` i.e BNCF/4NF
--

DROP TABLE IF EXISTS `interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interests` (
  `int_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `interest` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`int_id`),
  UNIQUE KEY `student_id` (`student_id`,`interest`),
  CONSTRAINT `interests_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `interests_chk_1` CHECK ((length(`interest`) >= 4))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interests`
--

LOCK TABLES `interests` WRITE;
/*!40000 ALTER TABLE `interests` DISABLE KEYS */;
INSERT INTO `interests` VALUES (5,2017041,'Fashion'),(6,2017041,'Fashion&Dance'),(1,2018275,'Dance'),(2,2018278,'Design'),(4,2018279,'Dance'),(3,2018279,'Sports');
/*!40000 ALTER TABLE `interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members` i.e BNCF
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `mem_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `club_id` varchar(20) NOT NULL,
  `club_tag` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`mem_id`),
  UNIQUE KEY `student_id` (`student_id`,`club_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  CONSTRAINT `members_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `clubs_and_societies` (`club_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

-- 
-- Table structure for `Reviews` i.e BNCF
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `rev_id` int NOT NULL,
  `student_id` int NOT NULL,
  `rating` int NOT NULL,
  `comments` varchar(500),
  PRIMARY KEY (`rev_id`,`student_id`),
  FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `rev_ibfk_2` FOREIGN KEY (`rev_id`) REFERENCES `contents` (`con_id`) ON DELETE CASCADE,
  CONSTRAINT `rating_set` check (rating in (1,2,3,4,5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for reviews
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (2,2017041,4,"good");
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Service_Location` i.e 3NF
--

DROP TABLE IF EXISTS `Service_Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Service_Location` (
  `Location_ID` int NOT NULL AUTO_INCREMENT,
  `Location_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Location_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Service_Location`
--

LOCK TABLES `Service_Location` WRITE;
/*!40000 ALTER TABLE `Service_Location` DISABLE KEYS */;
INSERT INTO `Service_Location` VALUES (1,'R&D Block'),(2,'LibraryBuilding'),(3,'Old Academic Block'),(4,'Lecture Hall Complex'),(5,'Student Centre'),(6,'Girls Hostel'),(7,'H2 Boys Hostel'),(8,'Old Boys Hostel'),(9,'Sports Block'),(10,'H1 Boys Hostel');
/*!40000 ALTER TABLE `Service_Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students` i.e BNCF/4NF
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `student_id` int NOT NULL,
  `password` varchar(20) NOT NULL,
  `full_name` varchar(30) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `year_of_study` int NOT NULL,
  `branch` varchar(30) NOT NULL,
  PRIMARY KEY (`student_id`),
  CONSTRAINT `students_chk_1` CHECK (((`year_of_study` >= 2000) and (`year_of_study` <= 9999))),
  CONSTRAINT `students_chk_2` CHECK ((length(`full_name`) >= 2)),
  CONSTRAINT `students_chk_3` CHECK ((length(`branch`) >= 3))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (2017041,"asgf",'Chirag Jain',NULL,2017,'CSE'),(2018275,"tefh",'Advika Singh',NULL,2018,'CSD'),(2018277,"wdftb",'ANEESHA LAKRA',NULL,2018,'CSD'),(2018278,"tyhujk",'Arnav',NULL,2018,'CSD'),(2018279,"dfghjk",'Arunesh',NULL,2018,'CSD');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Subscribers` i.e BNCF/4NF
--

DROP TABLE IF EXISTS `Subscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Subscribers` (
  `sub_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `club_name` varchar(30) NOT NULL,
  PRIMARY KEY (`sub_id`),
  UNIQUE KEY `student_id` (`student_id`,`club_name`),
  KEY `club_name` (`club_name`),
  CONSTRAINT `subscribers_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `subscribers_ibfk_2` FOREIGN KEY (`club_name`) REFERENCES `clubs_and_societies` (`club_name`) ON DELETE CASCADE,
  CONSTRAINT `subscribers_chk_1` CHECK ((length(`club_name`) >= 4))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Subscribers`
--

LOCK TABLES `Subscribers` WRITE;
/*!40000 ALTER TABLE `Subscribers` DISABLE KEYS */;
INSERT INTO `Subscribers` VALUES (5,2017041,'byld'),(6,2018275,'byld'),(1,2018275,'Cultural Committee'),(2,2018275,'MadToes'),(4,2018278,'elecroholics'),(3,2018279,'Cultural Committee');
/*!40000 ALTER TABLE `Subscribers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-19 13:18:40x

-- Data Insertion:- 

-- Insertion into Students

-- select * from students;

insert into students values (2017097,'hdhk','Sarthak Negi', NULL, 2017, 'CSE'), 
(2017136, 'ukaj', 'Apoorv Kumar', NULL, 2017, 'CSE'), 
(2017153, 'jydll', 'Himanshu', NULL, 2017, 'CSE'), 
(2017156, 'jyhagjp', 'Karamveer Singh', NULL, 2017, 'CSE'), 
(2017170, 'iqghj', 'Nikhil Kumar', NULL, 2017, 'CSE'), 
(2017174, 'dfghjk', 'Pradeep Kumar', NULL, 2017, 'CSE'), 
(2017182, 'wertyuio', 'Rishav Raj', NULL, 2017, 'CSE'), 
(2017185, 'uiopp', 'Sachin', NULL, 2017, 'CSE'), 
(2017191, 'vbnm,', 'Shreya Prasad', NULL, 2017, 'CSE'), 
(2018353, 'zxcvbnm', 'Paarmita Jhalani', NULL, 2018, 'CSSS'), 
(2018356, 'rtyuio', 'PARTH SINGH', NULL, 2018, 'CSSS'), 
(2018035, 'kjhgjka', 'Pragya Gandhi', NULL, 2018, 'CSSS'), 
(2018358, 'shkas', 'PRANAY JAIN', NULL, 2018, 'CSSS'), 
(2016026,'yuahj', 'Ayushman Pandita', NULL, 2016, 'CSE'), 
(2016111,'yghkj','Vaibhav Goel', NULL, 2016, 'CSE'),  
(2016135, 'dhka','Anvit Mangal', NULL, 2016, 'CSE'), 
(2016106, 'dhkaj', 'Tanish Gupta', NULL, 2016, 'CSE'), 
(2016244, 'oiokk', 'Manvi Goel', NULL, 2016, 'CSE'), 
(2017085, 'iusiljl', 'Raunak Mokhasi', NULL, 2017, 'CSE'), 
(2017309, 'jgdha', 'Riya Singh', NULL, 2017, 'CSD');

-- Insertion into Clubs and Societies

-- select * from clubs_and_societies;

insert into clubs_and_societies values ('ms', 'Muse', NULL), 
('mk', 'Meraki', NULL), 
('sc', 'Student Council', NULL), 
('sp', 'Sports Council', NULL), 
('mc', 'Machaan', NULL), 
('ab', 'AudioBytes', NULL), 
('an', 'Astronuts', NULL), 
('tv', 'Trivialis', NULL), 
('sq', '65th Square', NULL), 
('ts', 'Tasveer', NULL);

-- Insertion into Contents

-- select * from contents;

insert into contents values
(null,"01:01:2020","2018275","cse123","Homework",".sql","https://drive.google.com/drive/u/1/folders/1ReziY3LhkzXPg4OcAcultK3EYYlK4qSi"),
(null,"02:01:2020","2018279","cse100","Homework",".sql","https://drive.google.com/drive/u/1/folders/2ReziY3LhkzXPg4OcAcultK3EYYlK4qSi"),
(null,"01:01:2020","2018279","eco234","Quiz",".pdf","https://drive.google.com/drive/u/1/folders/3ReziY3LhkzXPg4OcAcultK3EYYlK4qSi"),
(null,"01:01:2020","2018279","ece101","Worksheet",".pdf","https://drive.google.com/drive/u/1/folders/4ReziY3LhkzXPg4OcAcultK3EYYlK4qSi"),
(null,"20:04:2020","2017041","cse101","MidSem",".pdf","https://drive.google.com/drive/u/1/folders/5ReziY3LhkzXPg4OcAcultK3EYYlK4qSi"),
(null, NULL, 2017097, 'CSE301', 'Notes', 'ppt', 'https://drive.google.com/open?id=1hSAcdPbRrmtl9BpFpDy7CQs4kpUyZlus'), 
(null, "20:05:2020", 2017136, 'MTH201', 'Cheatsheet', 'doc', 'https://drive.google.com/drive/u/0/folders/1JJ2U-H4U4c9eyxeQVAREDr5pHry3iFR7'), 
(null, NULL, 2018353, 'SSH203', 'Notes', 'ppt', 'https://drive.google.com/drive/u/0/folders/1kJ_QF9HSXLwT1CrFzpJ1Q72mC1H37NrV'), 
(null, "01:12:2020", 2018356, 'MTH201', 'Cheatsheet', 'doc', 'https://drive.google.com/drive/u/0/folders/1UmJeG2XSgPRtjtdEC7XzD4v-BcUJwDMC'), 
(null, NULL, 2018358, 'ECE101', 'Notes', 'doc', 'https://drive.google.com/drive/u/0/folders/1CBJ767eoIGkfxcecHmM6cWgP70h3H4QZ');

-- Inserion into Admins

-- select * from admins;

insert into admins values (null, '2016106','Tanish Gupta','ts', 'Tasveer'), 
(null, '2017085','Raunak Mokhasi','tv', 'Trivialis'), 
(null, '2017174','Pradeep Kumar','ms', 'Muse'), 
(null, '2016244','Manvi Goel','sc', 'Student Council'), 
(null, '2016111','Vaibhav Goel','sp', 'Sports Council'),
(null, '2016026', 'Ayushman Pandita','mt','MadToes'),
(null, '2016135','Anvit Mangal', 'fb', 'foobar'),
(null, '2017041', 'Chiraj Jain','el', 'elecroholics'),
(null, '2017170','Nikhil Kumar','by','byld'),
(null, '2018358','PRANAY JAIN', 'ab','AudioBytes');

-- Insertion into 

-- select * from members;

insert into members values (null, 2017097, 'by', 'byld1'), 
(null, 2017136, 'by', 'byld'), 
(null, 2017153, 'fb', 'foobar2'), 
(null, 2017156, 'fb', 'foobar'), 
(null, 2018353, 'mk', 'meraki1'), 
(null, 2018035, 'tv', 'trivialis2'), 
(null, 2018358, 'cc', 'Cultural Committee1'),
(null, 2018278, 'fb', 'foobar2'),
(null, 2016026, 'el','electroholics3' ),
(null, 2018275, 'ms', 'Muse1'),
(null, 2016111, 'mc', 'Machaan2'),
(null, 2018356, 'mt', 'MadToes3');

-- Insertion into Fms_complaint,Fms_request,location_service already done:-

-- select * from Service_Location;
-- select * from FMS_Request;
-- select * from FMS_Complaint;

-- Insertion into subscribers

-- select * from Subscribers order by sub_id;

insert into Subscribers values (null, 2016026, 'Cultural Committee'), 
(null, 2016111, 'Cultural Committee'), 
(null, 2016135, 'Tasveer'), 
(null, 2016106,'Foobar'),
(null, 2017085,'Cultural Committee'), 
(null, 2018358, 'Muse');

-- Insertion into contact_details

-- select * from contact_details;

insert into contact_details values ("2016026","@ayushman","@ayushman","ayushman16026@iiitd.ac.in"),
("2016111","@vaibhav","@vaibhav","vaibhav16111@iiitd.ac.in"),
("2016135","@anvit","@anvit","anvit16135@iiitd.ac.in"),
("2016106","@tanish","@tanish","tanish16106@iiitd.ac.in"),
("2016244","@manvi","@manvi","manvi16244@iiitd.ac.in"),
(2017041, '@chirag','@chirag',"chirag17041@iiitd.ac.in"),
(2017085, '@raunak','@raunak',"raunak17085@iiitd.ac.in"),
(2017097, "@sarthak",'@sarthak',"sarthak17097@iiitd.ac.in"),
(2017136, "@apoorv","@apoorv","apoorv17136@iiitd.ac.in"),
(2017153, "@himanshu","@himanshu","himanshu17153@iiitd.ac.in"),
(2017156, "@karamveer", "@karamveer", "karamveer17156@iiitd.ac.in"),
(2017170,"@nikhil","@nikhil","nikhil17170@iiitd.ac.in"),
(2017174,"@pradeep","pradeep","pradeep17174@iiitd.ac.in"),
(2017182,"@rishiv","@rishiv","rishiv17182@iiitd.ac.in"),
(2017185,"@sachin","@sachin","sachin17185@iiitd.ac.in"),
(2017191,"@shreya","@shreya","shreya17191@iiitd.ac.in"),
(2017309, "@riya","@riya","riya17309@iiitd.ac.in"),
(2018035, "@pragya","@pragya","pragya18035@iiitd.ac.in"),
(2018275,"@advika","@advika","advika18275@iiitd.ac.in"),
(2018277,"@aneesha","@aneesha","aneehsa18277@iiitd.ac.in"),
(2018278,"arnav","@arnav","arnav18278@iiitd.ac.in"),
(2018279,"@arunesh","@arunesh","arunesh18279@iiitd.ac.in"),
(2018353,"@paarmita","@paarmita","paarmita18353@iiitd.ac.in"),
(2018356,"@parth","@parth","parth18356@iiitd.ac.in"),
(2018358,"pranay","@pranay","pranay18358@iiitd.ac.in");

-- Insertion into Interests

-- select * from interests order by int_id;

insert into interests values (null, 2016026, 'Dance'),
 (null, 2016111, 'Management'),
 (null, 2016135,'Photography'),
 (null, 2016106, 'Photography'),
 (null, 2016244, 'Management'),
 (null, 2017085, 'Quizzing'),
 (null, 2017309, 'Fashion');
 
insert into interests values (null,2018275,'Music'),
(null,2017041,'Sports'),
(null,2018358,'Competitive Programming'),
(null,2018356,'Software Development'),
(null,2018353,'Photography'),
(null,2018279,'Research');

-- Insertion into events
 
-- select * from events;

insert into events values (null, 'cc',NULL,"2020-11-23 23:00:56",NULL,'masquerade',NULL), 
(null, 'mt', NULL,"2020-11-23 23:00:56",NULL,'dance evening',NULL), 
(null, 'ms',NULL,"2020-11-23 23:00:56",NULL,'trashion',NULL), 
(null, 'mk',NULL,"2020-11-23 23:00:56",NULL,'oil painting workshop',NULL), 
(null, 'sp',NULL,"2020-11-23 23:00:56",NULL,'Joga Bonito',NULL), 
(null, 'mc',NULL,"2020-11-23 23:00:56",NULL,'stage play',NULL), 
(null, 'ab',NULL,"2020-11-23 23:00:56",NULL,'flashmob',NULL), 
(null, 'ts',NULL,"2020-11-23 23:00:56",NULL,'Ghar ki Tasveer',NULL), 
(null, 'an',NULL,"2020-11-23 23:00:56",NULL,'Star Gazing session',NULL), 
(null, 'tv',NULL,"2020-11-23 23:00:56",NULL,'quiz',NULL), 
(null, 'sq',NULL,"2020-11-23 23:00:56",NULL,'chess match',NULL);

-- Insertion into calendar

-- select * from calender;

insert into calender values(null,2018275,"2020-11-23 23:00:56",'trashion',null,'c101'),
(null,2018278,"2020-11-24 04:31:56",'pro_sort',null,'c01'),
(null,2017097,"2020-11-24 04:30:55",'hackathon',null,'c102'),
(null,2017136,"2020-11-24 04:30:55",'hackathon',null,'c102'),
(null,2017156,"2020-11-24 04:31:56",'pro_sort',null,'c01');

-- Insertion into Reviews

-- select * from reviews; 

insert into reviews values (1, 2017174, 4, "great"),
 (4, 2017156, 5, "awesome! Thank you!"),
 (2, 2018275, 2, "incomplete topic coverage"),
 (1, 2018277, 3, "good"),
 (3, 2016111, 5, "great!"),
 (3, 2016135, 1, "incomplete"),
 (3, 2016026, 4, "good"),
 (7, 2018358, 3, "good");
