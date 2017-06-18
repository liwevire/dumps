-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tm_report
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
-- Table structure for table `daily`
--

DROP TABLE IF EXISTS `daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily` (
  `date` date NOT NULL,
  `principal` decimal(13,3) unsigned zerofill NOT NULL DEFAULT '0000000000.000',
  `roi` decimal(13,3) unsigned zerofill NOT NULL DEFAULT '0000000000.000',
  `rop` decimal(13,3) unsigned zerofill NOT NULL DEFAULT '0000000000.000',
  `firstMonthInterest` decimal(13,3) unsigned zerofill NOT NULL DEFAULT '0000000000.000',
  `appraisalCharges` decimal(13,3) unsigned zerofill NOT NULL DEFAULT '0000000000.000',
  `closingBalance` decimal(13,3) unsigned zerofill NOT NULL DEFAULT '0000000000.000',
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily`
--

LOCK TABLES `daily` WRITE;
/*!40000 ALTER TABLE `daily` DISABLE KEYS */;
INSERT INTO `daily` VALUES ('2017-05-21',0000000000.000,0000000000.000,0000000000.000,0000000000.000,0000000000.000,0000100000.000),('2017-05-22',0000000000.000,0000000000.000,0000000000.000,0000000000.000,0000000000.000,0000100000.000),('2017-05-23',0000000000.000,0000000000.000,0000000000.000,0000000000.000,0000000000.000,0000100000.000),('2017-05-24',0000010000.000,0000000000.000,0000000000.000,0000000200.000,0000000005.000,0000090205.000),('2017-05-25',0000005000.000,0000000000.000,0000000000.000,0000000125.000,0000000005.000,0000085335.000),('2017-05-26',0000000000.000,0000000000.000,0000004000.000,0000000000.000,0000000000.000,0000089335.000),('2017-05-27',0000005000.000,0000000000.000,0000000000.000,0000000125.000,0000000005.000,0000084465.000);
/*!40000 ALTER TABLE `daily` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-15 21:07:19
