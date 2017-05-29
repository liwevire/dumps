CREATE DATABASE  IF NOT EXISTS `tm_report` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `tm_report`;
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
-- Dumping routines for database 'tm_report'
--
/*!50003 DROP PROCEDURE IF EXISTS `calulateDailyReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tm_dbUser`@`%` PROCEDURE `calulateDailyReport`(IN calculationDate date)
BEGIN
	#Declarations
    declare l_principal decimal(13,3);
    declare l_roi decimal(13,3);
    declare l_rop decimal(13,3);
    declare l_firstMonthInterest decimal(13,3);
    declare l_appraisalCharges decimal(13,3);
    
    #Inserting new row if doesn't exists already
	if not exists(select * from tm_report.daily where tm_report.daily.date = date(calculationDate)) then
        insert into tm_report.daily (date) VALUES(date(calculationDate));
	end if;
    
    #Calculating totals for a day
    SELECT SUM(amount) into l_principal FROM tm_core.transaction where tm_core.transaction.category like 'principal' AND date(tm_core.transaction.date) = date(calculationDate);
    SELECT SUM(amount) into l_roi FROM tm_core.transaction where tm_core.transaction.category like 'return_on_interest' AND date(tm_core.transaction.date) = date(calculationDate);
    SELECT SUM(amount) into l_rop FROM tm_core.transaction where tm_core.transaction.category like 'return_on_principal' AND date(tm_core.transaction.date) = date(calculationDate);
    SELECT SUM(amount) into l_firstMonthInterest FROM tm_core.transaction where tm_core.transaction.category like 'first_month_interest' AND date(tm_core.transaction.date) = date(calculationDate);
    SELECT SUM(amount) into l_appraisalCharges FROM tm_core.transaction where tm_core.transaction.category like 'appraisal_charges' AND date(tm_core.transaction.date) = date(calculationDate);
    
    #Null check and replacing with 0 if value is null
    if (l_principal is null) then
		set l_principal = 0;
	end if;
    if (l_roi is null) then
		set l_roi = 0;
	end if;
    if (l_rop is null) then
		set l_rop = 0;
	end if;
    if (l_firstMonthInterest is null) then
		set l_firstMonthInterest = 0;
	end if;
    if (l_appraisalCharges is null) then
		set l_appraisalCharges = 0;
	end if;
    
    select l_principal, l_roi, l_rop, l_firstMonthInterest, l_appraisalCharges;
    
    update tm_report.daily set
		tm_report.daily.principal = l_principal,
		tm_report.daily.roi = l_roi,
        tm_report.daily.rop = l_rop,
        tm_report.daily.firstMonthInterest = l_firstMonthInterest,
        tm_report.daily.appraisalCharges = l_appraisalCharges
        where tm_report.daily.date = date(calculationDate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-29 22:06:13
