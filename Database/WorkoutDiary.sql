-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Server-versjon: 5.7.17-0ubuntu0.16.04.1
-- PHP Version: 7.0.15-0ubuntu0.16.04.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET NAMES utf8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `WorkoutDiary`
--

-- --------------------------------------------------------

--
-- Table structure for table `Exercise`
--

DROP TABLE IF EXISTS `Exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Exercise` (
  `exerciseID` int(10) NOT NULL AUTO_INCREMENT,
  `exerciseName` varchar(30) NOT NULL,
  `description` text,
  `totRepetitions` int DEFAULT NULL,
  `totSets` int DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `load` int DEFAULT NULL,
  `distance` varchar(10) DEFAULT NULL,
  `duration` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`exerciseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Exercise`
--

LOCK TABLES `Exercise` WRITE;
/*!40000 ALTER TABLE `Exercise` DISABLE KEYS */;
/*!40000 ALTER TABLE `Exercise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Goal`
--

DROP TABLE IF EXISTS `Goal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Goal` (
  `goalID` int NOT NULL AUTO_INCREMENT,
  `creationDate` timestamp NOT NULL AUTO_INCREMENT,
  `achievedDate` timestamp NOT NULL AUTO_INCREMENT,
  `exerciseID` int(10) NOT NULL,
  PRIMARY KEY (`goalID`,`exerciseID`),
  KEY `gruppe_id` (`goalID`),
  CONSTRAINT `Goal` FOREIGN KEY (`exerciseID`) REFERENCES `Exercise` (`exerciseID`) ON DELETE CASCADE ON UPDATE CASCADE,
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Goal`
--

LOCK TABLES `Goal` WRITE;
/*!40000 ALTER TABLE `Goal` DISABLE KEYS */;
/*!40000 ALTER TABLE `Goal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GroupCategories`
--

DROP TABLE IF EXISTS `GroupCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GroupCategories` (
  `groupID` varchar(30) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(30) NOT NULL,
  `exerciseID` int(10) NOT NULL,
  PRIMARY KEY (`groupID`),
  KEY `exerciseID` (`exerciseID`),
  CONSTRAINT `GroupCategories` FOREIGN KEY (`exerciseID`) REFERENCES `Excercise` (`exerciseID`) ON DELETE CASCADE ON UPDATE CASCADE,
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GroupCategories`
--

LOCK TABLES `GroupCategories` WRITE;
/*!40000 ALTER TABLE `GroupCategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `GroupCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExerciseReplacement`
--

DROP TABLE IF EXISTS `ExerciseReplacement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ExerciseReplacement` (
  `replacementID` int(10) NOT NULL,
  `exerciseID` int(10) NOT NULL,
  PRIMARY KEY (`replacementID`,`exerciseID`),
  KEY `Exercise_id` (`exerciseID`),
  CONSTRAINT `ExerciseReplacement` FOREIGN KEY (`exerciseID`) REFERENCES `Exercise` (`exerciseID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExerciseReplacement`
--

LOCK TABLES `ExerciseReplacement` WRITE;
/*!40000 ALTER TABLE `ExerciseReplacement` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExerciseReplacement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ResultLog`
--

DROP TABLE IF EXISTS `ResultLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ResultLog` (
  `goalPeriod` varchar(15) NOT NULL,
  `period` timestamp NOT NULL,
  'bestResult' varchar(15),
  PRIMARY KEY (`goalPeriod`),
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ResultLog`
--

LOCK TABLES `ResultLog` WRITE;
/*!40000 ALTER TABLE `ResultLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `ResultLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Results`
--

DROP TABLE IF EXISTS `Results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Results` (
  `resultID` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gruppe`
--

LOCK TABLES `gruppe` WRITE;
/*!40000 ALTER TABLE `gruppe` DISABLE KEYS */;
/*!40000 ALTER TABLE `gruppe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mål`
--

DROP TABLE IF EXISTS `mål`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mål` (
  `ExerciseID` int(11) NOT NULL,
  `opprettet_tid` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `belastning` int(11) DEFAULT NULL,
  `repetisjoner` smallint(6) DEFAULT NULL,
  `sett` smallint(6) DEFAULT NULL,
  `utholdenhet_distanse` decimal(5,2) DEFAULT NULL,
  `utholdenhet_varighet` int(11) DEFAULT NULL,
  `oppnådd_tid` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ExerciseID`,`opprettet_tid`),
  CONSTRAINT `mål_ibfk_1` FOREIGN KEY (`ExerciseID`) REFERENCES `Exercise` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mål`
--

LOCK TABLES `mål` WRITE;
/*!40000 ALTER TABLE `mål` DISABLE KEYS */;
/*!40000 ALTER TABLE `mål` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mal`
--

DROP TABLE IF EXISTS `mal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mal` (
  `name` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mal`
--

LOCK TABLES `mal` WRITE;
/*!40000 ALTER TABLE `mal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultat`
--

DROP TABLE IF EXISTS `resultat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultat` (
  `trening_id` int(11) NOT NULL,
  `Exercise_id` int(11) NOT NULL,
  `belastning` int(11) DEFAULT NULL,
  `repetisjoner` smallint(6) DEFAULT NULL,
  `sett` smallint(6) DEFAULT NULL,
  `utholdenhet_distanse` decimal(5,2) DEFAULT NULL,
  `utholdenhet_varighet` int(11) DEFAULT NULL,
  PRIMARY KEY (`trening_id`,`Exercise_id`),
  KEY `resultat_ibfk_2` (`Exercise_id`),
  CONSTRAINT `resultat_ibfk_2` FOREIGN KEY (`Exercise_id`) REFERENCES `Exercise` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resultat_ibfk_1` FOREIGN KEY (`trening_id`) REFERENCES `treningsøkt` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultat`
--

LOCK TABLES `resultat` WRITE;
/*!40000 ALTER TABLE `resultat` DISABLE KEYS */;
/*!40000 ALTER TABLE `resultat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treningsøkt`
--

DROP TABLE IF EXISTS `treningsøkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treningsøkt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tidspunkt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `varighet` smallint(5) unsigned DEFAULT NULL,
  `personlig_form` tinyint(4) DEFAULT NULL,
  `prestasjon` tinyint(4) DEFAULT NULL,
  `notat` text,
  `innendørs` tinyint(1) DEFAULT '0',
  `luftscore` tinyint(4) DEFAULT NULL,
  `antall_tilskuere` mediumint(8) unsigned DEFAULT '0',
  `ute_værtype` varchar(30) DEFAULT NULL,
  `ute_temperatur` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treningsøkt`
--

LOCK TABLES `treningsøkt` WRITE;
/*!40000 ALTER TABLE `treningsøkt` DISABLE KEYS */;
/*!40000 ALTER TABLE `treningsøkt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undergruppe`
--

DROP TABLE IF EXISTS `undergruppe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `undergruppe` (
  `subgruppe_id` int(11) NOT NULL,
  `supergruppe_id` int(11) NOT NULL,
  PRIMARY KEY (`subgruppe_id`,`supergruppe_id`),
  KEY `supergruppe_id` (`supergruppe_id`),
  CONSTRAINT `undergruppe_ibfk_1` FOREIGN KEY (`subgruppe_id`) REFERENCES `gruppe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `undergruppe_ibfk_2` FOREIGN KEY (`supergruppe_id`) REFERENCES `gruppe` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undergruppe`
--

LOCK TABLES `undergruppe` WRITE;
/*!40000 ALTER TABLE `undergruppe` DISABLE KEYS */;
/*!40000 ALTER TABLE `undergruppe` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
