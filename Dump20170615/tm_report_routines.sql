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
/*!50003 DROP PROCEDURE IF EXISTS `calculateDailyReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`tm_dbUser`@`%` PROCEDURE `calculateDailyReport`(IN calculationDate date, IN recursionIndex tinyint)
BEGIN

	#Declarations
    declare l_principal decimal(13,3) default 0;
    declare l_roi decimal(13,3) default 0;
    declare l_rop decimal(13,3) default 0;
    declare l_firstMonthInterest decimal(13,3) default 0;
    declare l_appraisalCharges decimal(13,3) default 0;
    declare l_closingBalance decimal(13,3) default 0;
    declare l_previousBalance decimal(13,3) default 0;
    declare l_extDebit decimal(13,3) default 0;
    declare l_extCredit decimal(13,3) default 0;
    SET max_sp_recursion_depth=255;
    
	select recursionIndex;
    
    #Inserting new row if doesn't exists already
	if not exists(select * from tm_report.daily where tm_report.daily.date = date(calculationDate)) then
		insert into tm_report.daily (date) VALUES(date(calculationDate));
	end if;
    
    if not exists(select * from tm_report.daily where tm_report.daily.date = date_sub(date(calculationDate), interval 1 day)) then
		insert into tm_report.daily (date) VALUES(date_sub(date(calculationDate), interval 1 day));
	end if;
    
	#Closing balance of previous day is 0 and so it needs to be calculated
	if ((select closingBalance from tm_report.daily where tm_report.daily.date = date_sub(date(calculationDate), interval 1 day)) = 0) then
		#check for the recursion index and invoke the calculation for the previous day
		if (recursionIndex <= 30) then
			set recursionIndex = recursionIndex + 1;
			call calculateDailyReport(date_sub(date(calculationDate), interval 1 day), recursionIndex);
		end if;
	end if;
    
	#Calculating totals for current day
	SELECT SUM(amount) into l_principal FROM tm_core.transaction where tm_core.transaction.category like 'principal' AND date(tm_core.transaction.date) = date(calculationDate);
	SELECT SUM(amount) into l_roi FROM tm_core.transaction where tm_core.transaction.category like 'return_on_interest' AND date(tm_core.transaction.date) = date(calculationDate);
	SELECT SUM(amount) into l_rop FROM tm_core.transaction where tm_core.transaction.category like 'return_on_principal' AND date(tm_core.transaction.date) = date(calculationDate);
	SELECT SUM(amount) into l_firstMonthInterest FROM tm_core.transaction where tm_core.transaction.category like 'first_month_interest' AND date(tm_core.transaction.date) = date(calculationDate);
	SELECT SUM(amount) into l_appraisalCharges FROM tm_core.transaction where tm_core.transaction.category like 'appraisal_charges' AND date(tm_core.transaction.date) = date(calculationDate);
	
	#External transactions
	SELECT SUM(amount) into l_extDebit FROM tm_core.misctransactions where tm_core.misctransactions.transactionType = 0 AND date(tm_core.misctransactions.date) = date(calculationDate);
	SELECT SUM(amount) into l_extCredit FROM tm_core.misctransactions where tm_core.misctransactions.transactionType = 1 AND date(tm_core.misctransactions.date) = date(calculationDate);
	
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
	if (l_extCredit is null) then
		set l_extCredit = 0;
	end if;
	if (l_extDebit is null) then
		set l_extDebit = 0;
	end if;
	
	
	#Calculating closing balance
	select tm_report.daily.closingBalance into l_previousBalance from tm_report.daily where tm_report.daily.date = date_sub(date(calculationDate), interval 1 day);
	#select l_previousBalance, l_closingBalance,  date_sub(date(calculationDate), interval 1 day);
    
	#Null check
	if (l_previousBalance is null) then
		set l_previousBalance = 0;
	end if;
	if (l_closingBalance is null) then
		set l_closingBalance = 0;
	end if;
	
	#calculation
	set l_closingBalance = l_previousBalance +l_roi + l_rop+ l_firstMonthInterest + l_appraisalCharges - l_principal + l_extCredit - l_extDebit;
	
	
	
	#updating the Daily report table with the calculated values
	update tm_report.daily set
		tm_report.daily.principal = l_principal,
		tm_report.daily.roi = l_roi,
		tm_report.daily.rop = l_rop,
		tm_report.daily.firstMonthInterest = l_firstMonthInterest,
		tm_report.daily.appraisalCharges = l_appraisalCharges,
		tm_report.daily.closingBalance = l_closingBalance
		where tm_report.daily.date = date(calculationDate);
    #select l_closingBalance;
        
	#select * from tm_report.daily where date(tm_report.daily.date) = date(calculationDate);
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

-- Dump completed on 2017-06-15 21:07:20
