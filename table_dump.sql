-- MariaDB dump 10.19  Distrib 10.6.5-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: ppbilling
-- ------------------------------------------------------
-- Server version	10.6.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ticket_messages`
--

DROP TABLE IF EXISTS `ticket_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint(20) unsigned NOT NULL,
  `from_admin` int(10) unsigned NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` bigint(20) unsigned NOT NULL,
  `edited` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  CONSTRAINT `ticket_messages_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_messages`
--

LOCK TABLES `ticket_messages` WRITE;
/*!40000 ALTER TABLE `ticket_messages` DISABLE KEYS */;
INSERT INTO `ticket_messages` VALUES (15,6,1,'asdf',1645041558,NULL),(16,6,0,'asdf',1645041560,NULL),(17,6,1,'asdf',1645041609,NULL),(18,6,0,'asdf',1645041615,NULL),(19,6,1,'asdfasdf',1645041617,NULL),(20,6,0,'fasdfasdfasdfasdf',1645041620,NULL),(21,6,1,'Hi how are you',1645041626,NULL),(22,6,0,'No bad you',1645041631,NULL),(23,6,1,'Doihn brettgood',1645041640,NULL),(24,6,0,'asdf',1645041683,NULL),(25,6,1,'asdfasdf',1645041686,NULL),(26,6,0,'asdfasdf',1645041691,NULL),(27,6,0,'sdf',1645041821,NULL),(28,6,0,'sdfasdfasdf',1645041825,NULL),(29,6,1,'asdfasdf',1645041913,NULL),(30,6,0,'asdfasdf',1645041918,NULL),(31,6,0,'asdfasdfasdf',1645041921,NULL),(32,6,0,'asdfasdf',1645041972,NULL),(33,6,0,'asdfasdf',1645041986,NULL),(34,6,0,'sdf',1645042006,NULL),(35,6,0,'asdf',1645042011,NULL),(36,6,0,'asdfasdf',1645042036,NULL),(37,6,1,'asdfasdf',1645042043,NULL),(38,6,1,'asdfasdf',1645042048,NULL),(39,6,1,'fasdfasdf',1645042052,NULL),(40,6,0,'asdf',1645042088,NULL),(41,6,0,'asdf',1645042090,NULL),(42,6,0,'asdf',1645042092,NULL),(43,6,0,'asdf',1645042093,NULL),(44,6,0,'asdf',1645042095,NULL),(45,6,1,'asdf',1645042130,NULL),(46,6,1,'asdfasdf',1645042132,NULL),(47,6,1,'asdfasdfasdfasdf',1645042136,NULL),(48,6,0,'asdfasdfasdf',1645042139,NULL),(49,6,0,'fasdfasdfasf',1645043463,NULL),(50,6,0,'asdfasdf',1645043465,NULL),(51,6,0,'asdfasfd',1645043467,NULL),(52,6,0,'asdfasdf',1645043665,NULL),(53,6,0,'asdfasf',1645043765,NULL),(54,6,0,'dsfgsdfgsdfg',1645043771,NULL),(55,6,0,'asdfasdf',1645043773,NULL),(56,6,1,'asdf',1645043895,NULL),(57,6,1,'asdfasdf',1645043899,NULL),(58,6,0,'asdfasdfasdfasdf',1645043905,NULL),(59,6,0,'asfd',1645043911,NULL),(60,6,0,'sssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAv',1645043956,NULL),(61,6,1,'sssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAv',1645044066,NULL),(62,6,0,'asdfasdf',1645044256,NULL),(63,6,0,'asdfasdfasdfasdf',1645044285,NULL),(64,6,0,'sssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAsssAv',1645044346,NULL),(65,6,0,'asdfasdfasdf',1645044397,NULL),(66,6,0,'asdfasdf',1645044399,NULL),(67,6,1,'asdfasdfasdfasdfasdf',1645044401,NULL),(68,6,1,'dfaasdfasdfasdf',1645044403,NULL),(69,6,1,'asdfasdfasdfasdfasdfasdf\r\nasdf\r\nasdf\r\nasdfasdf',1645044408,NULL),(70,6,0,'asdfasdfasdf',1645044416,NULL);
/*!40000 ALTER TABLE `ticket_messages` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-16 18:43:12
