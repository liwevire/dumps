-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tm_core
-- ------------------------------------------------------
-- Server version	5.7.18-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `transaction_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `category` varchar(40) DEFAULT NULL,
  `amount` decimal(13,3) DEFAULT NULL,
  `loan_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `loan_fk` (`loan_id`),
  CONSTRAINT `transaction_loan_fk` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (12,'2017-01-11 00:00:00','principal',20000.000,14),(13,'2017-01-11 00:00:00','first_month_interest',400.000,14),(14,'2017-01-11 00:00:00','appraisal_charges',5.000,14),(15,'2017-03-09 00:00:00','return_on_interest',300.000,14),(16,'2017-03-09 00:00:00','return_on_principal',20000.000,14),(17,'2017-01-11 00:00:00','principal',14500.000,15),(18,'2017-01-11 00:00:00','first_month_interest',290.000,15),(19,'2017-01-11 00:00:00','appraisal_charges',5.000,15),(20,'2017-01-17 00:00:00','principal',20000.000,16),(21,'2017-01-17 00:00:00','first_month_interest',400.000,16),(22,'2017-01-17 00:00:00','appraisal_charges',5.000,16),(23,'2017-03-19 00:00:00','principal',12000.000,17),(24,'2017-03-19 00:00:00','first_month_interest',240.000,17),(25,'2017-03-19 00:00:00','appraisal_charges',5.000,17),(26,'2017-01-27 00:00:00','principal',30000.000,18),(27,'2017-01-27 00:00:00','first_month_interest',600.000,18),(28,'2017-01-27 00:00:00','appraisal_charges',5.000,18),(32,'2017-01-31 00:00:00','principal',10000.000,20),(33,'2017-01-31 00:00:00','first_month_interest',200.000,20),(34,'2017-01-31 00:00:00','appraisal_charges',5.000,20),(38,'2017-02-03 00:00:00','principal',25000.000,21),(39,'2017-02-03 00:00:00','first_month_interest',500.000,21),(40,'2017-02-03 00:00:00','appraisal_charges',5.000,21),(41,'2017-01-31 00:00:00','principal',25000.000,19),(42,'2017-01-31 00:00:00','first_month_interest',500.000,19),(43,'2017-01-31 00:00:00','appraisal_charges',5.000,19),(44,'2017-03-01 00:00:00','return_on_principal',10000.000,19),(45,'2017-01-11 00:00:00','principal',120000.000,13),(46,'2017-01-11 00:00:00','first_month_interest',2400.000,13),(47,'2017-01-11 00:00:00','appraisal_charges',5.000,13);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-15 21:07:20
