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
-- Table structure for table `admins`
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
-- Table structure for table `calender`
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
-- Table structure for table `clubs_and_societies`
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
-- Table structure for table `contact_details`
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
  UNIQUE KEY `email_address` (`email_address`),
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
-- Table structure for table `contents`
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
-- Table structure for table `events`
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
-- Table structure for table `FMS_Complaint`
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
-- Table structure for table `FMS_Request`
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
-- Table structure for table `interests`
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
-- Table structure for table `members`
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
-- Table structure for `Reviews`
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
-- Table structure for table `Service_Location`
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
-- Table structure for table `students`
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
-- Table structure for table `Subscribers`
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

-- select * from Subscribers;