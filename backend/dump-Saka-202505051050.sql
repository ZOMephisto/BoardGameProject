-- MySQL dump 10.13  Distrib 9.3.0, for macos15.2 (arm64)
--
-- Host: localhost    Database: Saka
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `available_games`
--

DROP TABLE IF EXISTS `available_games`;
/*!50001 DROP VIEW IF EXISTS `available_games`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `available_games` AS SELECT 
 1 AS `ID_Game`,
 1 AS `Name`,
 1 AS `Description`,
 1 AS `Price_per_Day`,
 1 AS `Minimum_Age`,
 1 AS `Minimum_Number_of_Players`,
 1 AS `Maximum_Number_of_Players`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Belongs`
--

DROP TABLE IF EXISTS `Belongs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Belongs` (
  `ID_USER` varchar(50) NOT NULL,
  `ID_Group` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_USER`,`ID_Group`),
  KEY `ID_Group` (`ID_Group`),
  CONSTRAINT `belongs_ibfk_1` FOREIGN KEY (`ID_USER`) REFERENCES `Player` (`ID_USER`),
  CONSTRAINT `belongs_ibfk_2` FOREIGN KEY (`ID_Group`) REFERENCES `Team` (`ID_Group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Belongs`
--

LOCK TABLES `Belongs` WRITE;
/*!40000 ALTER TABLE `Belongs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Belongs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Borrow`
--

DROP TABLE IF EXISTS `Borrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Borrow` (
  `ID_Game` varchar(50) NOT NULL,
  `Duration` date DEFAULT NULL,
  `ID_USER` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_Game`),
  UNIQUE KEY `ID_USER` (`ID_USER`),
  CONSTRAINT `borrow_ibfk_1` FOREIGN KEY (`ID_Game`) REFERENCES `Game` (`ID_Game`),
  CONSTRAINT `borrow_ibfk_2` FOREIGN KEY (`ID_USER`) REFERENCES `Player` (`ID_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Borrow`
--

LOCK TABLES `Borrow` WRITE;
/*!40000 ALTER TABLE `Borrow` DISABLE KEYS */;
/*!40000 ALTER TABLE `Borrow` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `log_rental_activity` AFTER INSERT ON `borrow` FOR EACH ROW BEGIN
    INSERT INTO Rental_Activity_Log (ID_Game, ID_USER, Rental_Date, Duration)
    VALUES (NEW.ID_Game, NEW.ID_USER, NOW(), NEW.Duration);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_inventory_on_rent` AFTER INSERT ON `borrow` FOR EACH ROW BEGIN
    UPDATE Game
    SET Current_Number_of_Players = Current_Number_of_Players + 1
    WHERE ID_Game = NEW.ID_Game;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_inventory_on_return` AFTER INSERT ON `borrow` FOR EACH ROW BEGIN
    UPDATE Game
    SET Current_Number_of_Members = Current_Number_of_Members + 1
    WHERE ID_Game = NEW.ID_Game;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Game`
--

DROP TABLE IF EXISTS `Game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Game` (
  `ID_Game` varchar(50) NOT NULL,
  `Price_per_Day` decimal(15,2) DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `Minimum_Number_of_Players` int DEFAULT NULL,
  `Maximum_Number_of_Players` int DEFAULT NULL,
  `Minimum_Age` int DEFAULT NULL,
  `Image` varchar(50) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `ID_Group` varchar(50) NOT NULL,
  `ID_USER` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_Game`),
  KEY `ID_Group` (`ID_Group`),
  KEY `ID_USER` (`ID_USER`),
  KEY `idx_game_name` (`Name`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`ID_Group`) REFERENCES `Team` (`ID_Group`),
  CONSTRAINT `game_ibfk_2` FOREIGN KEY (`ID_USER`) REFERENCES `Player` (`ID_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Game`
--

LOCK TABLES `Game` WRITE;
/*!40000 ALTER TABLE `Game` DISABLE KEYS */;
/*!40000 ALTER TABLE `Game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Player`
--

DROP TABLE IF EXISTS `Player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Player` (
  `ID_USER` varchar(50) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  PRIMARY KEY (`ID_USER`),
  KEY `idx_user_email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Player`
--

LOCK TABLES `Player` WRITE;
/*!40000 ALTER TABLE `Player` DISABLE KEYS */;
/*!40000 ALTER TABLE `Player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Team`
--

DROP TABLE IF EXISTS `Team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Team` (
  `ID_Group` varchar(50) NOT NULL,
  `Current_Number_of_Members` varchar(50) DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_Group`),
  KEY `idx_team_description` (`Description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Team`
--

LOCK TABLES `Team` WRITE;
/*!40000 ALTER TABLE `Team` DISABLE KEYS */;
/*!40000 ALTER TABLE `Team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_rental_history`
--

DROP TABLE IF EXISTS `user_rental_history`;
/*!50001 DROP VIEW IF EXISTS `user_rental_history`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_rental_history` AS SELECT 
 1 AS `ID_USER`,
 1 AS `Name`,
 1 AS `Email`,
 1 AS `Game_Name`,
 1 AS `Duration`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'Saka'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_rental_cost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_rental_cost`(game_price DECIMAL(15,2), rental_duration INT) RETURNS decimal(15,2)
    DETERMINISTIC
BEGIN
    DECLARE total_cost DECIMAL(15,2);
    SET total_cost = game_price * rental_duration;
    RETURN total_cost;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_game_availability` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `check_game_availability`(game_id VARCHAR(50)) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE available_count INT;

    SELECT COUNT(*)
    INTO available_count
    FROM Game
    WHERE ID_Game = game_id
    AND ID_Game NOT IN (SELECT ID_Game FROM Borrow WHERE Duration IS NULL);

    RETURN available_count > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_user_rental_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_rental_count`(user_id VARCHAR(50)) RETURNS int
    READS SQL DATA
BEGIN
    DECLARE rental_count INT;
    SELECT COUNT(*)
    INTO rental_count
    FROM Borrow
    WHERE ID_USER = user_id;
    RETURN rental_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_new_game` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_game`(
    IN p_ID_Game VARCHAR(50),
    IN p_Price_per_Day DECIMAL(15,2),
    IN p_Description VARCHAR(50),
    IN p_Minimum_Number_of_Players INT,
    IN p_Maximum_Number_of_Players INT,
    IN p_Minimum_Age INT,
    IN p_Image VARCHAR(50),
    IN p_Name VARCHAR(50),
    IN p_ID_Group VARCHAR(50),
    IN p_ID_USER VARCHAR(50)
)
BEGIN
    INSERT INTO Game (ID_Game, Price_per_Day, Description, Minimum_Number_of_Players, Maximum_Number_of_Players, Minimum_Age, Image, Name, ID_Group, ID_USER)
    VALUES (p_ID_Game, p_Price_per_Day, p_Description, p_Minimum_Number_of_Players, p_Maximum_Number_of_Players, p_Minimum_Age, p_Image, p_Name, p_ID_Group, p_ID_USER);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rent_game` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rent_game`(IN p_ID_Game VARCHAR(50), IN p_ID_USER VARCHAR(50), IN p_Duration DATE)
BEGIN
    DECLARE v_Price_per_Day DECIMAL(15,2);
    DECLARE v_Availability INT;

    CALL check_game_availability_function(p_ID_Game, @v_Availability);
    
    IF v_Availability = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Game is not available for rent';
    ELSE
        SELECT Price_per_Day INTO v_Price_per_Day FROM Game WHERE ID_Game = p_ID_Game;

        INSERT INTO Borrow (ID_Game, Duration, ID_USER) VALUES (p_ID_Game, p_Duration, p_ID_USER);

        CALL update_inventory_on_rent(p_ID_Game);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `return_game` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `return_game`(IN p_ID_Game VARCHAR(50), IN p_ID_USER VARCHAR(50))
BEGIN
    DECLARE v_Duration DATE;
    
    -- Check if the game is currently rented by the user
    SELECT Duration INTO v_Duration
    FROM Borrow
    WHERE ID_Game = p_ID_Game AND ID_USER = p_ID_USER;

    IF v_Duration IS NOT NULL THEN
        -- Update the Borrow table to remove the record
        DELETE FROM Borrow
        WHERE ID_Game = p_ID_Game AND ID_USER = p_ID_USER;

        -- Optionally, update the Game table or inventory status here
        -- For example, increment the available count of the game

        SELECT 'Game returned successfully.' AS Message;
    ELSE
        SELECT 'No rental record found for this game and user.' AS Message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `available_games`
--

/*!50001 DROP VIEW IF EXISTS `available_games`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `available_games` AS select `g`.`ID_Game` AS `ID_Game`,`g`.`Name` AS `Name`,`g`.`Description` AS `Description`,`g`.`Price_per_Day` AS `Price_per_Day`,`g`.`Minimum_Age` AS `Minimum_Age`,`g`.`Minimum_Number_of_Players` AS `Minimum_Number_of_Players`,`g`.`Maximum_Number_of_Players` AS `Maximum_Number_of_Players` from (`game` `g` left join `borrow` `b` on((`g`.`ID_Game` = `b`.`ID_Game`))) where (`b`.`ID_Game` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_rental_history`
--

/*!50001 DROP VIEW IF EXISTS `user_rental_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_rental_history` AS select `p`.`ID_USER` AS `ID_USER`,`p`.`Name` AS `Name`,`p`.`Email` AS `Email`,`g`.`Name` AS `Game_Name`,`b`.`Duration` AS `Duration` from ((`player` `p` join `borrow` `b` on((`p`.`ID_USER` = `b`.`ID_USER`))) join `game` `g` on((`b`.`ID_Game` = `g`.`ID_Game`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-05 10:50:24
