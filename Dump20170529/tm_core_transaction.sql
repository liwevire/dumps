CREATE DATABASE  IF NOT EXISTS `tm_core` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `tm_core`;
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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (33,'2017-01-02 00:00:00','principal',10000.000,1),(34,'2017-01-02 00:00:00','first_month_interest',200.000,1),(35,'2017-01-02 00:00:00','appraisal_charges',5.000,1),(36,'2017-02-02 00:00:00','return_on_principal',5000.000,1),(37,'2017-02-17 00:00:00','return_on_principal',3000.000,1),(38,'2017-03-17 00:00:00','return_on_principal',2000.000,1),(39,'2017-03-17 00:00:00','return_on_interest',125.000,1),(43,'2017-05-27 00:00:00','principal',5000.000,2),(44,'2017-05-27 00:00:00','first_month_interest',125.000,2),(45,'2017-05-27 00:00:00','appraisal_charges',5.000,2),(65,'2017-01-10 00:00:00','principal',10000.000,3),(66,'2017-01-10 00:00:00','first_month_interest',200.000,3),(67,'2017-01-10 00:00:00','appraisal_charges',5.000,3),(68,'2017-02-09 00:00:00','return_on_principal',9000.000,3),(69,'2017-05-29 00:00:00','principal',1000.000,5),(70,'2017-05-29 00:00:00','first_month_interest',30.000,5),(71,'2017-05-29 00:00:00','appraisal_charges',5.000,5);
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

-- Dump completed on 2017-05-29 22:06:14
