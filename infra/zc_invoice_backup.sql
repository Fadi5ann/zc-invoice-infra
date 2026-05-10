-- MySQL dump 10.13  Distrib 8.4.8, for Linux (x86_64)
--
-- Host: localhost    Database: invoicing
-- ------------------------------------------------------
-- Server version	8.4.8

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
-- Table structure for table `_address`
--

DROP TABLE IF EXISTS `_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_address` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `countryId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_96f057e9420205691bbb03ba9be` (`countryId`),
  CONSTRAINT `FK_96f057e9420205691bbb03ba9be` FOREIGN KEY (`countryId`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_address`
--

LOCK TABLES `_address` WRITE;
/*!40000 ALTER TABLE `_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_article`
--

DROP TABLE IF EXISTS `_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_article` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_article`
--

LOCK TABLES `_article` WRITE;
/*!40000 ALTER TABLE `_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_interlocutor`
--

DROP TABLE IF EXISTS `_interlocutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_interlocutor` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `title` enum('Mr.','Mrs.','Miss','Ms.','Dr.','Prof.') DEFAULT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_interlocutor`
--

LOCK TABLES `_interlocutor` WRITE;
/*!40000 ALTER TABLE `_interlocutor` DISABLE KEYS */;
INSERT INTO `_interlocutor` VALUES ('2026-04-28 19:25:19.367552','2026-04-28 19:25:19.367552',NULL,0,1,'Mr.','Mollit impedit ad r','A est libero eos ut ','Nam nisi consequatur','womiwih@mailinator.com'),('2026-05-09 09:32:16.307740','2026-05-09 09:32:16.307740',NULL,0,2,'Mr.','Dolorum reprehenderi','Quia atque iure nemo','Molestiae rem offici','weqiveko@mailinator.com');
/*!40000 ALTER TABLE `_interlocutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_quotation`
--

DROP TABLE IF EXISTS `_quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_quotation` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `direction` enum('incoming','outgoing') NOT NULL,
  `date` datetime DEFAULT NULL,
  `dueDate` datetime DEFAULT NULL,
  `object` varchar(255) DEFAULT NULL,
  `generalConditions` text,
  `enterpriseId` int NOT NULL,
  `interlocutorId` int NOT NULL,
  `currencyId` int DEFAULT NULL,
  `bankAccountId` int NOT NULL,
  `status` enum('Draft','Validated','Sent','Accepted','Rejected','Invoiced') NOT NULL DEFAULT 'Draft',
  PRIMARY KEY (`id`),
  KEY `FK_7f9d073414a6475a3805e82af6c` (`enterpriseId`),
  KEY `FK_904f18352d150e8375212b338ef` (`interlocutorId`),
  KEY `FK_aac61d3c924b4d0bb70b68a7725` (`currencyId`),
  KEY `FK_cec5af67336dbe903c49ed88d30` (`bankAccountId`),
  CONSTRAINT `FK_7f9d073414a6475a3805e82af6c` FOREIGN KEY (`enterpriseId`) REFERENCES `enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_904f18352d150e8375212b338ef` FOREIGN KEY (`interlocutorId`) REFERENCES `_interlocutor` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_aac61d3c924b4d0bb70b68a7725` FOREIGN KEY (`currencyId`) REFERENCES `ref-param` (`id`),
  CONSTRAINT `FK_cec5af67336dbe903c49ed88d30` FOREIGN KEY (`bankAccountId`) REFERENCES `bank_account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_quotation`
--

LOCK TABLES `_quotation` WRITE;
/*!40000 ALTER TABLE `_quotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `_quotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES ('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,1,'Agence ou société commerciale'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,2,'Agriculture'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,3,'Art et design'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,4,'Industrie automobile'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,5,'Construction'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,6,'Biens de consommation'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,7,'Éducation'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,8,'Ingénierie'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,9,'Divertissement'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,10,'Services financiers'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,11,'Activités de restauration'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,12,'Jeux'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,13,'Fonction publique'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,14,'Services de santé'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,15,'Décoration d\'intérieur'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,16,'Interne'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,17,'Légal'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,18,'Industrie'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,19,'Commercialisation'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,20,'Exploitation minière et logistique'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,21,'Non lucratif'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,22,'Publication et médias Web'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,23,'Vente au détail (e-commerce et hors ligne)'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,24,'Immobilier'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,25,'Service'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,26,'Technologie'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,27,'Télécommunications'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,28,'Tourisme / hôtellerie'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,29,'Création de sites web'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,30,'Développement web'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,31,'Maroquinerie'),('2026-04-11 20:37:39.566522','2026-04-11 20:37:39.566522',NULL,0,32,'Pêche maritime'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,33,'Agence ou société commerciale'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,34,'Agriculture'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,35,'Art et design'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,36,'Industrie automobile'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,37,'Construction'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,38,'Biens de consommation'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,39,'Éducation'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,40,'Ingénierie'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,41,'Divertissement'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,42,'Services financiers'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,43,'Activités de restauration'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,44,'Jeux'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,45,'Fonction publique'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,46,'Services de santé'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,47,'Décoration d\'intérieur'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,48,'Interne'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,49,'Légal'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,50,'Industrie'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,51,'Commercialisation'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,52,'Exploitation minière et logistique'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,53,'Non lucratif'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,54,'Publication et médias Web'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,55,'Vente au détail (e-commerce et hors ligne)'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,56,'Immobilier'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,57,'Service'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,58,'Technologie'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,59,'Télécommunications'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,60,'Tourisme / hôtellerie'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,61,'Création de sites web'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,62,'Développement web'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,63,'Maroquinerie'),('2026-04-11 20:37:43.726577','2026-04-11 20:37:43.726577',NULL,0,64,'Pêche maritime'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,65,'Agence ou société commerciale'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,66,'Agriculture'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,67,'Art et design'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,68,'Industrie automobile'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,69,'Construction'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,70,'Biens de consommation'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,71,'Éducation'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,72,'Ingénierie'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,73,'Divertissement'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,74,'Services financiers'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,75,'Activités de restauration'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,76,'Jeux'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,77,'Fonction publique'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,78,'Services de santé'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,79,'Décoration d\'intérieur'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,80,'Interne'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,81,'Légal'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,82,'Industrie'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,83,'Commercialisation'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,84,'Exploitation minière et logistique'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,85,'Non lucratif'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,86,'Publication et médias Web'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,87,'Vente au détail (e-commerce et hors ligne)'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,88,'Immobilier'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,89,'Service'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,90,'Technologie'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,91,'Télécommunications'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,92,'Tourisme / hôtellerie'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,93,'Création de sites web'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,94,'Développement web'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,95,'Maroquinerie'),('2026-04-12 10:33:12.482761','2026-04-12 10:33:12.482761',NULL,0,96,'Pêche maritime'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,97,'Agence ou société commerciale'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,98,'Agriculture'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,99,'Art et design'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,100,'Industrie automobile'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,101,'Construction'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,102,'Biens de consommation'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,103,'Éducation'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,104,'Ingénierie'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,105,'Divertissement'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,106,'Services financiers'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,107,'Activités de restauration'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,108,'Jeux'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,109,'Fonction publique'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,110,'Services de santé'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,111,'Décoration d\'intérieur'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,112,'Interne'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,113,'Légal'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,114,'Industrie'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,115,'Commercialisation'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,116,'Exploitation minière et logistique'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,117,'Non lucratif'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,118,'Publication et médias Web'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,119,'Vente au détail (e-commerce et hors ligne)'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,120,'Immobilier'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,121,'Service'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,122,'Technologie'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,123,'Télécommunications'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,124,'Tourisme / hôtellerie'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,125,'Création de sites web'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,126,'Développement web'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,127,'Maroquinerie'),('2026-04-12 10:53:07.476603','2026-04-12 10:53:07.476603',NULL,0,128,'Pêche maritime');
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `region` varchar(255) NOT NULL,
  `countryId` int NOT NULL,
  `zipcode` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_d87215343c3a3a67e6a0b7f3ea9` (`countryId`),
  CONSTRAINT `FK_d87215343c3a3a67e6a0b7f3ea9` FOREIGN KEY (`countryId`) REFERENCES `ref-param` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES ('2026-04-28 19:25:19.301261','2026-04-28 19:25:19.301261',NULL,0,1,'Totam labore est lab','Qui placeat duis eu','Maiores inventore ha',200,18),('2026-04-28 19:25:19.337703','2026-04-28 19:25:19.337703',NULL,0,2,'Iure fugiat reiciend','Voluptates ea quam v','Velit laboris maiore',200,39),('2026-05-09 09:32:16.277096','2026-05-09 09:32:16.277096',NULL,0,3,'Vero eu exercitation','Dolorem quo voluptas','Esse dolores alias r',201,16),('2026-05-09 09:32:16.291762','2026-05-09 09:32:16.291762',NULL,0,4,'Et quasi corrupti e','Dolore dolor a corru','Amet anim quasi sae',207,24);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_config`
--

DROP TABLE IF EXISTS `app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_config` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_e53f3c7882ebd6e79931e0fa95` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_config`
--

LOCK TABLES `app_config` WRITE;
/*!40000 ALTER TABLE `app_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article-families`
--

DROP TABLE IF EXISTS `article-families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article-families` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article-families`
--

LOCK TABLES `article-families` WRITE;
/*!40000 ALTER TABLE `article-families` DISABLE KEYS */;
/*!40000 ALTER TABLE `article-families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article-invoice-entry`
--

DROP TABLE IF EXISTS `article-invoice-entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article-invoice-entry` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `unit_price` float DEFAULT NULL,
  `quantity` float DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `discount_type` enum('PERCENTAGE','AMOUNT') DEFAULT NULL,
  `subTotal` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `articleId` int DEFAULT NULL,
  `invoiceId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_41934c555211897f86130ed2cf0` (`invoiceId`),
  KEY `FK_32d3344cf567f06962565a2f2e7` (`articleId`),
  CONSTRAINT `FK_32d3344cf567f06962565a2f2e7` FOREIGN KEY (`articleId`) REFERENCES `_article` (`id`),
  CONSTRAINT `FK_41934c555211897f86130ed2cf0` FOREIGN KEY (`invoiceId`) REFERENCES `invoice` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article-invoice-entry`
--

LOCK TABLES `article-invoice-entry` WRITE;
/*!40000 ALTER TABLE `article-invoice-entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `article-invoice-entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article-invoice-entry-tax`
--

DROP TABLE IF EXISTS `article-invoice-entry-tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article-invoice-entry-tax` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `articleInvoiceEntryId` int NOT NULL,
  `taxId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_beb757d511b38ad46f34d4629c1` (`articleInvoiceEntryId`),
  KEY `FK_26ebf625c7719822a93636d0ada` (`taxId`),
  CONSTRAINT `FK_26ebf625c7719822a93636d0ada` FOREIGN KEY (`taxId`) REFERENCES `tax` (`id`),
  CONSTRAINT `FK_beb757d511b38ad46f34d4629c1` FOREIGN KEY (`articleInvoiceEntryId`) REFERENCES `article-invoice-entry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article-invoice-entry-tax`
--

LOCK TABLES `article-invoice-entry-tax` WRITE;
/*!40000 ALTER TABLE `article-invoice-entry-tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `article-invoice-entry-tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article-quotation-entry`
--

DROP TABLE IF EXISTS `article-quotation-entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article-quotation-entry` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `unit_price` float DEFAULT NULL,
  `quantity` float DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `discount_type` enum('PERCENTAGE','AMOUNT') DEFAULT NULL,
  `subTotal` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `articleId` int DEFAULT NULL,
  `quotationId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_fc97876708a7474aa933ef988c5` (`quotationId`),
  KEY `FK_08841dad9817b98f1690e712389` (`articleId`),
  CONSTRAINT `FK_08841dad9817b98f1690e712389` FOREIGN KEY (`articleId`) REFERENCES `_article` (`id`),
  CONSTRAINT `FK_fc97876708a7474aa933ef988c5` FOREIGN KEY (`quotationId`) REFERENCES `quotation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article-quotation-entry`
--

LOCK TABLES `article-quotation-entry` WRITE;
/*!40000 ALTER TABLE `article-quotation-entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `article-quotation-entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article-quotation-entry-tax`
--

DROP TABLE IF EXISTS `article-quotation-entry-tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article-quotation-entry-tax` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `articleQuotationEntryId` int NOT NULL,
  `taxId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_d4abea97a489b96ffa67e78dc18` (`articleQuotationEntryId`),
  KEY `FK_414a3df8350d82e57ff4057c0af` (`taxId`),
  CONSTRAINT `FK_414a3df8350d82e57ff4057c0af` FOREIGN KEY (`taxId`) REFERENCES `tax` (`id`),
  CONSTRAINT `FK_d4abea97a489b96ffa67e78dc18` FOREIGN KEY (`articleQuotationEntryId`) REFERENCES `article-quotation-entry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article-quotation-entry-tax`
--

LOCK TABLES `article-quotation-entry-tax` WRITE;
/*!40000 ALTER TABLE `article-quotation-entry-tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `article-quotation-entry-tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `articleFamilyId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_85402173e838c0a4036d0ee4f7d` (`articleFamilyId`),
  CONSTRAINT `FK_85402173e838c0a4036d0ee4f7d` FOREIGN KEY (`articleFamilyId`) REFERENCES `article-families` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_account`
--

DROP TABLE IF EXISTS `bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_account` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `bic` varchar(11) DEFAULT NULL,
  `rib` varchar(20) DEFAULT NULL,
  `iban` varchar(30) DEFAULT NULL,
  `currencyId` int DEFAULT NULL,
  `isMain` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_f3223f8f2a8381de5561e77dd11` (`currencyId`),
  CONSTRAINT `FK_f3223f8f2a8381de5561e77dd11` FOREIGN KEY (`currencyId`) REFERENCES `ref-param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_account`
--

LOCK TABLES `bank_account` WRITE;
/*!40000 ALTER TABLE `bank_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cabinet`
--

DROP TABLE IF EXISTS `cabinet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cabinet` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `enterpriseName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `taxIdNumber` varchar(50) DEFAULT NULL,
  `activityId` int DEFAULT NULL,
  `currencyId` int DEFAULT NULL,
  `addressId` int DEFAULT NULL,
  `logoId` int DEFAULT NULL,
  `signatureId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_3c8c725e12e43c98b28e7749dc` (`enterpriseName`),
  UNIQUE KEY `IDX_87330127d97173d4e6932edd4c` (`taxIdNumber`),
  KEY `FK_9616f8c644a6ddd0c1084e51601` (`activityId`),
  KEY `FK_ae59fbad8dbbf3165c622e42f09` (`currencyId`),
  KEY `FK_7498bf0c5a3ea591ee040f748e6` (`logoId`),
  KEY `FK_4ad3b03797fd493330287971614` (`signatureId`),
  KEY `FK_ca441fffbbce05b5f01c2e8b465` (`addressId`),
  CONSTRAINT `FK_4ad3b03797fd493330287971614` FOREIGN KEY (`signatureId`) REFERENCES `storage` (`id`),
  CONSTRAINT `FK_7498bf0c5a3ea591ee040f748e6` FOREIGN KEY (`logoId`) REFERENCES `storage` (`id`),
  CONSTRAINT `FK_9616f8c644a6ddd0c1084e51601` FOREIGN KEY (`activityId`) REFERENCES `activity` (`id`),
  CONSTRAINT `FK_ae59fbad8dbbf3165c622e42f09` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`),
  CONSTRAINT `FK_ca441fffbbce05b5f01c2e8b465` FOREIGN KEY (`addressId`) REFERENCES `_address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabinet`
--

LOCK TABLES `cabinet` WRITE;
/*!40000 ALTER TABLE `cabinet` DISABLE KEYS */;
/*!40000 ALTER TABLE `cabinet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration-namespace`
--

DROP TABLE IF EXISTS `configuration-namespace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuration-namespace` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_4c0b737780dd31907237001c0fa` (`userId`),
  CONSTRAINT `FK_4c0b737780dd31907237001c0fa` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration-namespace`
--

LOCK TABLES `configuration-namespace` WRITE;
/*!40000 ALTER TABLE `configuration-namespace` DISABLE KEYS */;
INSERT INTO `configuration-namespace` VALUES ('c8ef3b44-0fc2-48fa-ae6b-f09b4cb904b1','core','core configuration',NULL),('efef117b-8279-4f8f-87d7-9665a492b111','test','test configuration',NULL);
/*!40000 ALTER TABLE `configuration-namespace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuration-param`
--

DROP TABLE IF EXISTS `configuration-param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuration-param` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `namespaceId` varchar(255) NOT NULL,
  `variant` enum('string','number','boolean','select') NOT NULL DEFAULT 'string',
  `value` varchar(255) DEFAULT NULL,
  `options` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_930e3128e80db91673edd2c1a2a` (`namespaceId`),
  CONSTRAINT `FK_930e3128e80db91673edd2c1a2a` FOREIGN KEY (`namespaceId`) REFERENCES `configuration-namespace` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuration-param`
--

LOCK TABLES `configuration-param` WRITE;
/*!40000 ALTER TABLE `configuration-param` DISABLE KEYS */;
INSERT INTO `configuration-param` VALUES (1,'company.name','Company name','c8ef3b44-0fc2-48fa-ae6b-f09b4cb904b1','string','SUPER COMPANY',NULL),(2,'company.support','Company support email','c8ef3b44-0fc2-48fa-ae6b-f09b4cb904b1','string','support@super.company',NULL),(3,'company.address','Company address','c8ef3b44-0fc2-48fa-ae6b-f09b4cb904b1','string','123 Main Street, Anytown',NULL),(4,'test1.var1','test var 1','efef117b-8279-4f8f-87d7-9665a492b111','number','0',NULL),(5,'test1.var2','test var 2','efef117b-8279-4f8f-87d7-9665a492b111','string','test',NULL),(6,'test2.var1','test var 1','efef117b-8279-4f8f-87d7-9665a492b111','number','0',NULL),(7,'test2.var2','test var 2','efef117b-8279-4f8f-87d7-9665a492b111','select','test','[{\"label\": \"Test\", \"value\": \"test\"}, {\"label\": \"Test 2\", \"value\": \"test2\"}]');
/*!40000 ALTER TABLE `configuration-param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL,
  `alpha2Code` varchar(2) DEFAULT NULL,
  `alpha3Code` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES ('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,1,'AF','AFG'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,2,'AX','ALA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,3,'AL','ALB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,4,'DZ','DZA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,5,'AS','ASM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,6,'AD','AND'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,7,'AO','AGO'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,8,'AI','AIA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,9,'AQ','ATA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,10,'AG','ATG'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,11,'AR','ARG'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,12,'AM','ARM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,13,'AW','ABW'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,14,'AU','AUS'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,15,'AT','AUT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,16,'AZ','AZE'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,17,'BS','BHS'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,18,'BH','BHR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,19,'BD','BGD'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,20,'BB','BRB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,21,'BY','BLR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,22,'BE','BEL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,23,'BZ','BLZ'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,24,'BJ','BEN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,25,'BM','BMU'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,26,'BT','BTN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,27,'BO','BOL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,28,'BQ','BES'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,29,'BA','BIH'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,30,'BW','BWA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,31,'BV','BVT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,32,'BR','BRA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,33,'IO','IOT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,34,'BN','BRN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,35,'BG','BGR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,36,'BF','BFA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,37,'BI','BDI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,38,'CV','CPV'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,39,'KH','KHM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,40,'CM','CMR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,41,'CA','CAN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,42,'KY','CYM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,43,'CF','CAF'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,44,'TD','TCD'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,45,'CL','CHL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,46,'CN','CHN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,47,'CX','CXR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,48,'CC','CCK'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,49,'CO','COL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,50,'KM','COM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,51,'CG','COG'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,52,'CD','COD'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,53,'CK','COK'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,54,'CR','CRI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,55,'CI','CIV'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,56,'HR','HRV'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,57,'CU','CUB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,58,'CW','CUW'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,59,'CY','CYP'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,60,'CZ','CZE'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,61,'DK','DNK'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,62,'DJ','DJI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,63,'DM','DMA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,64,'DO','DOM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,65,'EC','ECU'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,66,'EG','EGY'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,67,'SV','SLV'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,68,'GQ','GNQ'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,69,'ER','ERI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,70,'EE','EST'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,71,'SZ','SWZ'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,72,'ET','ETH'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,73,'FK','FLK'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,74,'FO','FRO'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,75,'FJ','FJI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,76,'FI','FIN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,77,'FR','FRA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,78,'GF','GUF'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,79,'PF','PYF'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,80,'TF','ATF'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,81,'GA','GAB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,82,'GM','GMB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,83,'GE','GEO'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,84,'DE','DEU'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,85,'GH','GHA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,86,'GI','GIB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,87,'GR','GRC'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,88,'GL','GRL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,89,'GD','GRD'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,90,'GP','GLP'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,91,'GU','GUM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,92,'GT','GTM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,93,'GG','GGY'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,94,'GN','GIN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,95,'GW','GNB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,96,'GY','GUY'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,97,'HT','HTI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,98,'HM','HMD'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,99,'VA','VAT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,100,'HN','HND'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,101,'HK','HKG'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,102,'HU','HUN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,103,'IS','ISL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,104,'IN','IND'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,105,'ID','IDN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,106,'IR','IRN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,107,'IQ','IRQ'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,108,'IE','IRL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,109,'IM','IMN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,110,'IL','ISR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,111,'IT','ITA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,112,'JM','JAM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,113,'JP','JPN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,114,'JE','JEY'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,115,'JO','JOR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,116,'KZ','KAZ'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,117,'KE','KEN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,118,'KI','KIR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,119,'KP','PRK'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,120,'KR','KOR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,121,'KW','KWT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,122,'KG','KGZ'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,123,'LA','LAO'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,124,'LV','LVA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,125,'LB','LBN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,126,'LS','LSO'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,127,'LR','LBR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,128,'LY','LBY'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,129,'LI','LIE'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,130,'LT','LTU'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,131,'LU','LUX'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,132,'MO','MAC'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,133,'MG','MDG'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,134,'MW','MWI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,135,'MY','MYS'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,136,'MV','MDV'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,137,'ML','MLI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,138,'MT','MLT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,139,'MH','MHL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,140,'MQ','MTQ'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,141,'MR','MRT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,142,'MU','MUS'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,143,'YT','MYT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,144,'MX','MEX'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,145,'FM','FSM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,146,'MD','MDA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,147,'MC','MCO'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,148,'MN','MNG'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,149,'ME','MNE'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,150,'MS','MSR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,151,'MA','MAR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,152,'MZ','MOZ'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,153,'MM','MMR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,154,'NA','NAM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,155,'NR','NRU'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,156,'NP','NPL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,157,'NL','NLD'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,158,'NC','NCL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,159,'NZ','NZL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,160,'NI','NIC'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,161,'NE','NER'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,162,'NG','NGA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,163,'NU','NIU'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,164,'NF','NFK'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,165,'MK','MKD'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,166,'MP','MNP'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,167,'NO','NOR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,168,'OM','OMN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,169,'PK','PAK'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,170,'PW','PLW'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,171,'PS','PSE'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,172,'PA','PAN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,173,'PG','PNG'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,174,'PY','PRY'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,175,'PE','PER'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,176,'PH','PHL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,177,'PN','PCN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,178,'PL','POL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,179,'PT','PRT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,180,'PR','PRI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,181,'QA','QAT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,182,'RE','REU'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,183,'RO','ROU'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,184,'RU','RUS'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,185,'RW','RWA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,186,'BL','BLM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,187,'SH','SHN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,188,'KN','KNA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,189,'LC','LCA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,190,'MF','MAF'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,191,'PM','SPM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,192,'VC','VCT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,193,'WS','WSM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,194,'SM','SMR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,195,'ST','STP'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,196,'SA','SAU'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,197,'SN','SEN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,198,'RS','SRB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,199,'SC','SYC'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,200,'SL','SLE'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,201,'SG','SGP'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,202,'SX','SXM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,203,'SK','SVK'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,204,'SI','SVN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,205,'SB','SLB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,206,'SO','SOM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,207,'ZA','ZAF'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,208,'GS','SGS'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,209,'SS','SSD'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,210,'ES','ESP'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,211,'LK','LKA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,212,'SD','SDN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,213,'SR','SUR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,214,'SJ','SJM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,215,'SE','SWE'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,216,'CH','CHE'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,217,'SY','SYR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,218,'TW','TWN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,219,'TJ','TJK'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,220,'TZ','TZA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,221,'TH','THA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,222,'TL','TLS'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,223,'TG','TGO'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,224,'TK','TKL'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,225,'TO','TON'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,226,'TT','TTO'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,227,'TN','TUN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,228,'TR','TUR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,229,'TM','TKM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,230,'TC','TCA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,231,'TV','TUV'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,232,'UG','UGA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,233,'UA','UKR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,234,'AE','ARE'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,235,'GB','GBR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,236,'US','USA'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,237,'UM','UMI'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,238,'UY','URY'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,239,'UZ','UZB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,240,'VU','VUT'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,241,'VE','VEN'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,242,'VN','VNM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,243,'VG','VGB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,244,'VI','VIR'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,245,'WF','WLF'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,246,'EH','ESH'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,247,'YE','YEM'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,248,'ZM','ZMB'),('2026-04-11 20:37:39.577601','2026-04-11 20:37:39.577601',NULL,0,249,'ZW','ZWE');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `label` varchar(255) NOT NULL,
  `code` varchar(3) NOT NULL,
  `symbol` varchar(10) DEFAULT NULL,
  `digitAfterComma` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES ('2026-03-04 08:05:55.020054','2026-03-04 08:05:55.020054',NULL,0,'Afghan afghani','AFN','؋',NULL,1),('2026-03-04 08:05:55.039976','2026-03-04 08:05:55.039976',NULL,0,'Albanian lek','ALL','L',NULL,2),('2026-03-04 08:05:55.045854','2026-03-04 08:05:55.045854',NULL,0,'Algerian dinar','DZD','د.ج',NULL,3),('2026-03-04 08:05:55.049130','2026-03-04 08:05:55.049130',NULL,0,'Angolan kwanza','AOA','Kz',NULL,4),('2026-03-04 08:05:55.053832','2026-03-04 08:05:55.053832',NULL,0,'Argentine peso','ARS','$',NULL,5),('2026-03-04 08:05:55.057991','2026-03-04 08:05:55.057991',NULL,0,'Armenian dram','AMD','֏',NULL,6),('2026-03-04 08:05:55.061840','2026-03-04 08:05:55.061840',NULL,0,'Aruban florin','AWG','ƒ',NULL,7),('2026-03-04 08:05:55.066499','2026-03-04 08:05:55.066499',NULL,0,'Australian dollar','AUD','$',NULL,8),('2026-03-04 08:05:55.070180','2026-03-04 08:05:55.070180',NULL,0,'Azerbaijani manat','AZN','₼',NULL,9),('2026-03-04 08:05:55.073218','2026-03-04 08:05:55.073218',NULL,0,'Bahamian dollar','BSD','$',NULL,10),('2026-03-04 08:05:55.076423','2026-03-04 08:05:55.076423',NULL,0,'Bahraini dinar','BHD','.د.ب',NULL,11),('2026-03-04 08:05:55.078883','2026-03-04 08:05:55.078883',NULL,0,'Bangladeshi taka','BDT','৳',NULL,12),('2026-03-04 08:05:55.081149','2026-03-04 08:05:55.081149',NULL,0,'Barbadian dollar','BBD','$',NULL,13),('2026-03-04 08:05:55.083384','2026-03-04 08:05:55.083384',NULL,0,'Belize dollar','BZD','$',NULL,14),('2026-03-04 08:05:55.085803','2026-03-04 08:05:55.085803',NULL,0,'Bermudian dollar','BMD','$',NULL,15),('2026-03-04 08:05:55.088210','2026-03-04 08:05:55.088210',NULL,0,'Bhutanese ngultrum','BTN','Nu.',NULL,16),('2026-03-04 08:05:55.090694','2026-03-04 08:05:55.090694',NULL,0,'Bolivian boliviano','BOB','Bs.',NULL,17),('2026-03-04 08:05:55.093096','2026-03-04 08:05:55.093096',NULL,0,'Bosnia and Herzegovina convertible mark','BAM','KM',NULL,18),('2026-03-04 08:05:55.095649','2026-03-04 08:05:55.095649',NULL,0,'Botswana pula','BWP','P',NULL,19),('2026-03-04 08:05:55.098526','2026-03-04 08:05:55.098526',NULL,0,'Brazilian real','BRL','R$',NULL,20),('2026-03-04 08:05:55.101272','2026-03-04 08:05:55.101272',NULL,0,'British pound','GBP','£',NULL,21),('2026-03-04 08:05:55.103504','2026-03-04 08:05:55.103504',NULL,0,'Brunei dollar','BND','$',NULL,22),('2026-03-04 08:05:55.106311','2026-03-04 08:05:55.106311',NULL,0,'Bulgarian lev','BGN','лв',NULL,23),('2026-03-04 08:05:55.108460','2026-03-04 08:05:55.108460',NULL,0,'Burmese kyat','MMK','Ks',NULL,24),('2026-03-04 08:05:55.110514','2026-03-04 08:05:55.110514',NULL,0,'Burundian franc','BIF','Fr',NULL,25),('2026-03-04 08:05:55.112866','2026-03-04 08:05:55.112866',NULL,0,'CFP franc','XPF','Fr',NULL,26),('2026-03-04 08:05:55.115583','2026-03-04 08:05:55.115583',NULL,0,'Cambodian riel','KHR','៛',NULL,27),('2026-03-04 08:05:55.117844','2026-03-04 08:05:55.117844',NULL,0,'Canadian dollar','CAD','$',NULL,28),('2026-03-04 08:05:55.120348','2026-03-04 08:05:55.120348',NULL,0,'Cape Verdean escudo','CVE','Esc',NULL,29),('2026-03-04 08:05:55.122846','2026-03-04 08:05:55.122846',NULL,0,'Cayman Islands dollar','KYD','$',NULL,30),('2026-03-04 08:05:55.124926','2026-03-04 08:05:55.124926',NULL,0,'Central African CFA franc','XAF','Fr',NULL,31),('2026-03-04 08:05:55.127024','2026-03-04 08:05:55.127024',NULL,0,'Chilean peso','CLP','$',NULL,32),('2026-03-04 08:05:55.129032','2026-03-04 08:05:55.129032',NULL,0,'Chinese yuan','CNY','¥',NULL,33),('2026-03-04 08:05:55.130904','2026-03-04 08:05:55.130904',NULL,0,'Colombian peso','COP','$',NULL,34),('2026-03-04 08:05:55.132793','2026-03-04 08:05:55.132793',NULL,0,'Comorian franc','KMF','Fr',NULL,35),('2026-03-04 08:05:55.135130','2026-03-04 08:05:55.135130',NULL,0,'Congolese franc','CDF','Fr',NULL,36),('2026-03-04 08:05:55.138265','2026-03-04 08:05:55.138265',NULL,0,'Costa Rican colón','CRC','₡',NULL,37),('2026-03-04 08:05:55.141045','2026-03-04 08:05:55.141045',NULL,0,'Cuban convertible peso','CUC','$',NULL,38),('2026-03-04 08:05:55.144019','2026-03-04 08:05:55.144019',NULL,0,'Czech koruna','CZK','Kč',NULL,39),('2026-03-04 08:05:55.145960','2026-03-04 08:05:55.145960',NULL,0,'Danish krone','DKK','kr',NULL,40),('2026-03-04 08:05:55.148488','2026-03-04 08:05:55.148488',NULL,0,'Djiboutian franc','DJF','Fr',NULL,41),('2026-03-04 08:05:55.150433','2026-03-04 08:05:55.150433',NULL,0,'Dominican peso','DOP','$',NULL,42),('2026-03-04 08:05:55.152482','2026-03-04 08:05:55.152482',NULL,0,'East Caribbean dollar','XCD','$',NULL,43),('2026-03-04 08:05:55.154486','2026-03-04 08:05:55.154486',NULL,0,'Egyptian pound','EGP','£',NULL,44),('2026-03-04 08:05:55.156449','2026-03-04 08:05:55.156449',NULL,0,'Eritrean nakfa','ERN','Nfk',NULL,45),('2026-03-04 08:05:55.159065','2026-03-04 08:05:55.159065',NULL,0,'Ethiopian birr','ETB','Br',NULL,46),('2026-03-04 08:05:55.161218','2026-03-04 08:05:55.161218',NULL,0,'Euro','EUR','€',NULL,47),('2026-03-04 08:05:55.163983','2026-03-04 08:05:55.163983',NULL,0,'Falkland Islands Pound','FKP','£',NULL,48),('2026-03-04 08:05:55.166110','2026-03-04 08:05:55.166110',NULL,0,'Fijian dollar','FJD','$',NULL,49),('2026-03-04 08:05:55.168270','2026-03-04 08:05:55.168270',NULL,0,'Gambian dalasi','GMD','D',NULL,50),('2026-03-04 08:05:55.170384','2026-03-04 08:05:55.170384',NULL,0,'Georgian Lari','GEL','ლ',NULL,51),('2026-03-04 08:05:55.172527','2026-03-04 08:05:55.172527',NULL,0,'Ghanaian cedi','GHS','₵',NULL,52),('2026-03-04 08:05:55.175276','2026-03-04 08:05:55.175276',NULL,0,'Gibraltar pound','GIP','£',NULL,53),('2026-03-04 08:05:55.177667','2026-03-04 08:05:55.177667',NULL,0,'Guatemalan quetzal','GTQ','Q',NULL,54),('2026-03-04 08:05:55.181916','2026-03-04 08:05:55.181916',NULL,0,'Guinean franc','GNF','Fr',NULL,55),('2026-03-04 08:05:55.184335','2026-03-04 08:05:55.184335',NULL,0,'Guyanese dollar','GYD','$',NULL,56),('2026-03-04 08:05:55.186660','2026-03-04 08:05:55.186660',NULL,0,'Haitian gourde','HTG','G',NULL,57),('2026-03-04 08:05:55.189322','2026-03-04 08:05:55.189322',NULL,0,'Honduran lempira','HNL','L',NULL,58),('2026-03-04 08:05:55.194016','2026-03-04 08:05:55.194016',NULL,0,'Hong Kong dollar','HKD','$',NULL,59),('2026-03-04 08:05:55.196480','2026-03-04 08:05:55.196480',NULL,0,'Hungarian forint','HUF','Ft',NULL,60),('2026-03-04 08:05:55.198784','2026-03-04 08:05:55.198784',NULL,0,'Icelandic króna','ISK','kr',NULL,61),('2026-03-04 08:05:55.201470','2026-03-04 08:05:55.201470',NULL,0,'Indian rupee','INR','₹',NULL,62),('2026-03-04 08:05:55.203765','2026-03-04 08:05:55.203765',NULL,0,'Indonesian rupiah','IDR','Rp',NULL,63),('2026-03-04 08:05:55.206358','2026-03-04 08:05:55.206358',NULL,0,'Iranian rial','IRR','﷼',NULL,64),('2026-03-04 08:05:55.208914','2026-03-04 08:05:55.208914',NULL,0,'Iraqi dinar','IQD','ع.د',NULL,65),('2026-03-04 08:05:55.211182','2026-03-04 08:05:55.211182',NULL,0,'Israeli new shekel','ILS','₪',NULL,66),('2026-03-04 08:05:55.213193','2026-03-04 08:05:55.213193',NULL,0,'Jamaican dollar','JMD','$',NULL,67),('2026-03-04 08:05:55.215226','2026-03-04 08:05:55.215226',NULL,0,'Japanese yen','JPY','¥',NULL,68),('2026-03-04 08:05:55.217260','2026-03-04 08:05:55.217260',NULL,0,'Jordanian dinar','JOD','د.ا',NULL,69),('2026-03-04 08:05:55.219409','2026-03-04 08:05:55.219409',NULL,0,'Kazakhstani tenge','KZT','₸',NULL,70),('2026-03-04 08:05:55.221880','2026-03-04 08:05:55.221880',NULL,0,'Kenyan shilling','KES','Sh',NULL,71),('2026-03-04 08:05:55.225738','2026-03-04 08:05:55.225738',NULL,0,'Kuwaiti dinar','KWD','د.ك',NULL,72),('2026-03-04 08:05:55.227909','2026-03-04 08:05:55.227909',NULL,0,'Kyrgyzstani som','KGS','с',NULL,73),('2026-03-04 08:05:55.229980','2026-03-04 08:05:55.229980',NULL,0,'Lao kip','LAK','₭',NULL,74),('2026-03-04 08:05:55.232018','2026-03-04 08:05:55.232018',NULL,0,'Lebanese pound','LBP','ل.ل',NULL,75),('2026-03-04 08:05:55.234169','2026-03-04 08:05:55.234169',NULL,0,'Lesotho loti','LSL','L',NULL,76),('2026-03-04 08:05:55.236466','2026-03-04 08:05:55.236466',NULL,0,'Liberian dollar','LRD','$',NULL,77),('2026-03-04 08:05:55.238671','2026-03-04 08:05:55.238671',NULL,0,'Libyan dinar','LYD','ل.د',NULL,78),('2026-03-04 08:05:55.240881','2026-03-04 08:05:55.240881',NULL,0,'Macanese pataca','MOP','P',NULL,79),('2026-03-04 08:05:55.243196','2026-03-04 08:05:55.243196',NULL,0,'Macedonian denar','MKD','ден',NULL,80),('2026-03-04 08:05:55.245070','2026-03-04 08:05:55.245070',NULL,0,'Malagasy ariary','MGA','Ar',NULL,81),('2026-03-04 08:05:55.246883','2026-03-04 08:05:55.246883',NULL,0,'Malawian kwacha','MWK','MK',NULL,82),('2026-03-04 08:05:55.248693','2026-03-04 08:05:55.248693',NULL,0,'Malaysian ringgit','MYR','RM',NULL,83),('2026-03-04 08:05:55.250566','2026-03-04 08:05:55.250566',NULL,0,'Maldivian rufiyaa','MVR','.ރ',NULL,84),('2026-03-04 08:05:55.252679','2026-03-04 08:05:55.252679',NULL,0,'Mauritanian ouguiya','MRO','UM',NULL,85),('2026-03-04 08:05:55.254766','2026-03-04 08:05:55.254766',NULL,0,'Mauritian rupee','MUR','₨',NULL,86),('2026-03-04 08:05:55.256707','2026-03-04 08:05:55.256707',NULL,0,'Mexican peso','MXN','$',NULL,87),('2026-03-04 08:05:55.258839','2026-03-04 08:05:55.258839',NULL,0,'Moldovan leu','MDL','L',NULL,88),('2026-03-04 08:05:55.262859','2026-03-04 08:05:55.262859',NULL,0,'Mongolian tögrög','MNT','₮',NULL,89),('2026-03-04 08:05:55.264908','2026-03-04 08:05:55.264908',NULL,0,'Moroccan dirham','MAD','د.م.',NULL,90),('2026-03-04 08:05:55.267019','2026-03-04 08:05:55.267019',NULL,0,'Mozambican metical','MZN','MT',NULL,91),('2026-03-04 08:05:55.268971','2026-03-04 08:05:55.268971',NULL,0,'Namibian dollar','NAD','$',NULL,92),('2026-03-04 08:05:55.270983','2026-03-04 08:05:55.270983',NULL,0,'Nepalese rupee','NPR','₨',NULL,93),('2026-03-04 08:05:55.273045','2026-03-04 08:05:55.273045',NULL,0,'Netherlands Antillean guilder','ANG','ƒ',NULL,94),('2026-03-04 08:05:55.274873','2026-03-04 08:05:55.274873',NULL,0,'New Belarusian ruble','BYN','Br',NULL,95),('2026-03-04 08:05:55.276721','2026-03-04 08:05:55.276721',NULL,0,'New Taiwan dollar','TWD','$',NULL,96),('2026-03-04 08:05:55.278706','2026-03-04 08:05:55.278706',NULL,0,'New Zealand dollar','NZD','$',NULL,97),('2026-03-04 08:05:55.280855','2026-03-04 08:05:55.280855',NULL,0,'Nicaraguan córdoba','NIO','C$',NULL,98),('2026-03-04 08:05:55.282883','2026-03-04 08:05:55.282883',NULL,0,'Nigerian naira','NGN','₦',NULL,99),('2026-03-04 08:05:55.284828','2026-03-04 08:05:55.284828',NULL,0,'North Korean won','KPW','₩',NULL,100),('2026-03-04 08:05:55.286696','2026-03-04 08:05:55.286696',NULL,0,'Norwegian krone','NOK','kr',NULL,101),('2026-03-04 08:05:55.288564','2026-03-04 08:05:55.288564',NULL,0,'Omani rial','OMR','ر.ع.',NULL,102),('2026-03-04 08:05:55.290470','2026-03-04 08:05:55.290470',NULL,0,'Pakistani rupee','PKR','₨',NULL,103),('2026-03-04 08:05:55.293227','2026-03-04 08:05:55.293227',NULL,0,'Panamanian balboa','PAB','B/.',NULL,104),('2026-03-04 08:05:55.295198','2026-03-04 08:05:55.295198',NULL,0,'Papua New Guinean kina','PGK','K',NULL,105),('2026-03-04 08:05:55.297018','2026-03-04 08:05:55.297018',NULL,0,'Paraguayan guaraní','PYG','₲',NULL,106),('2026-03-04 08:05:55.299003','2026-03-04 08:05:55.299003',NULL,0,'Peruvian sol','PEN','S/.',NULL,107),('2026-03-04 08:05:55.300905','2026-03-04 08:05:55.300905',NULL,0,'Philippine peso','PHP','₱',NULL,108),('2026-03-04 08:05:55.302969','2026-03-04 08:05:55.302969',NULL,0,'Polish złoty','PLN','zł',NULL,109),('2026-03-04 08:05:55.304795','2026-03-04 08:05:55.304795',NULL,0,'Qatari riyal','QAR','ر.ق',NULL,110),('2026-03-04 08:05:55.306930','2026-03-04 08:05:55.306930',NULL,0,'Romanian leu','RON','lei',NULL,111),('2026-03-04 08:05:55.308929','2026-03-04 08:05:55.308929',NULL,0,'Russian ruble','RUB','₽',NULL,112),('2026-03-04 08:05:55.310756','2026-03-04 08:05:55.310756',NULL,0,'Rwandan franc','RWF','Fr',NULL,113),('2026-03-04 08:05:55.312673','2026-03-04 08:05:55.312673',NULL,0,'Saint Helena pound','SHP','£',NULL,114),('2026-03-04 08:05:55.314738','2026-03-04 08:05:55.314738',NULL,0,'Samoan tālā','WST','T',NULL,115),('2026-03-04 08:05:55.317809','2026-03-04 08:05:55.317809',NULL,0,'Saudi riyal','SAR','ر.س',NULL,116),('2026-03-04 08:05:55.319761','2026-03-04 08:05:55.319761',NULL,0,'Serbian dinar','RSD','дин.',NULL,117),('2026-03-04 08:05:55.321593','2026-03-04 08:05:55.321593',NULL,0,'Seychellois rupee','SCR','₨',NULL,118),('2026-03-04 08:05:55.323394','2026-03-04 08:05:55.323394',NULL,0,'Sierra Leonean leone','SLL','Le',NULL,119),('2026-03-04 08:05:55.325195','2026-03-04 08:05:55.325195',NULL,0,'Singapore dollar','SGD','$',NULL,120),('2026-03-04 08:05:55.327134','2026-03-04 08:05:55.327134',NULL,0,'Solomon Islands dollar','SBD','$',NULL,121),('2026-03-04 08:05:55.329061','2026-03-04 08:05:55.329061',NULL,0,'Somali shilling','SOS','Sh',NULL,122),('2026-03-04 08:05:55.331044','2026-03-04 08:05:55.331044',NULL,0,'South African rand','ZAR','R',NULL,123),('2026-03-04 08:05:55.332941','2026-03-04 08:05:55.332941',NULL,0,'South Korean won','KRW','₩',NULL,124),('2026-03-04 08:05:55.334917','2026-03-04 08:05:55.334917',NULL,0,'South Sudanese pound','SSP','£',NULL,125),('2026-03-04 08:05:55.336904','2026-03-04 08:05:55.336904',NULL,0,'Sri Lankan rupee','LKR','Rs',NULL,126),('2026-03-04 08:05:55.338774','2026-03-04 08:05:55.338774',NULL,0,'Sudanese pound','SDG','ج.س.',NULL,127),('2026-03-04 08:05:55.340968','2026-03-04 08:05:55.340968',NULL,0,'Surinamese dollar','SRD','$',NULL,128),('2026-03-04 08:05:55.343168','2026-03-04 08:05:55.343168',NULL,0,'Swazi lilangeni','SZL','L',NULL,129),('2026-03-04 08:05:55.345352','2026-03-04 08:05:55.345352',NULL,0,'Swedish krona','SEK','kr',NULL,130),('2026-03-04 08:05:55.347227','2026-03-04 08:05:55.347227',NULL,0,'Swiss franc','CHF','Fr',NULL,131),('2026-03-04 08:05:55.349024','2026-03-04 08:05:55.349024',NULL,0,'Syrian pound','SYP','£',NULL,132),('2026-03-04 08:05:55.350923','2026-03-04 08:05:55.350923',NULL,0,'São Tomé and Príncipe dobra','STD','Db',NULL,133),('2026-03-04 08:05:55.352788','2026-03-04 08:05:55.352788',NULL,0,'Tajikistani somoni','TJS','ЅМ',NULL,134),('2026-03-04 08:05:55.354815','2026-03-04 08:05:55.354815',NULL,0,'Tanzanian shilling','TZS','Sh',NULL,135),('2026-03-04 08:05:55.356851','2026-03-04 08:05:55.356851',NULL,0,'Thai baht','THB','฿',NULL,136),('2026-03-04 08:05:55.359008','2026-03-04 08:05:55.359008',NULL,0,'Tongan paʻanga','TOP','T$',NULL,137),('2026-03-04 08:05:55.360814','2026-03-04 08:05:55.360814',NULL,0,'Trinidad and Tobago dollar','TTD','$',NULL,138),('2026-03-04 08:05:55.363680','2026-03-04 08:05:55.363680',NULL,0,'Turkish lira','TRY','₺',NULL,139),('2026-03-04 08:05:55.365801','2026-03-04 08:05:55.365801',NULL,0,'Turkmenistan manat','TMT','m',NULL,140),('2026-03-04 08:05:55.367533','2026-03-04 08:05:55.367533',NULL,0,'Ugandan shilling','UGX','Sh',NULL,141),('2026-03-04 08:05:55.369054','2026-03-04 08:05:55.369054',NULL,0,'Ukrainian hryvnia','UAH','₴',NULL,142),('2026-03-04 08:05:55.370493','2026-03-04 08:05:55.370493',NULL,0,'United Arab Emirates dirham','AED','د.إ',NULL,143),('2026-03-04 08:05:55.372063','2026-03-04 08:05:55.372063',NULL,0,'United States dollar','USD','$',NULL,144),('2026-03-04 08:05:55.373583','2026-03-04 08:05:55.373583',NULL,0,'Uruguayan peso','UYU','$',NULL,145),('2026-03-04 08:05:55.375121','2026-03-04 08:05:55.375121',NULL,0,'Vanuatu vatu','VUV','Vt',NULL,146),('2026-03-04 08:05:55.378937','2026-03-04 08:05:55.378937',NULL,0,'Venezuelan bolívar','VEF','Bs S',NULL,147),('2026-03-04 08:05:55.381452','2026-03-04 08:05:55.381452',NULL,0,'Vietnamese đồng','VND','₫',NULL,148),('2026-03-04 08:05:55.384181','2026-03-04 08:05:55.384181',NULL,0,'West African CFA franc','XOF','Fr',NULL,149),('2026-03-04 08:05:55.386915','2026-03-04 08:05:55.386915',NULL,0,'Yemeni rial','YER','﷼',NULL,150),('2026-03-04 08:05:55.388594','2026-03-04 08:05:55.388594',NULL,0,'Zambian kwacha','ZMW','ZK',NULL,151);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default-condition`
--

DROP TABLE IF EXISTS `default-condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `default-condition` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `document_type` enum('quotation','invoice') DEFAULT NULL,
  `activity_type` enum('selling','buying') DEFAULT NULL,
  `value` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default-condition`
--

LOCK TABLES `default-condition` WRITE;
/*!40000 ALTER TABLE `default-condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `default-condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise`
--

DROP TABLE IF EXISTS `enterprise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enterprise` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  `particular` tinyint NOT NULL DEFAULT '1',
  `taxId` varchar(255) NOT NULL,
  `notes` text,
  `system` tinyint NOT NULL DEFAULT '0',
  `activityId` int DEFAULT NULL,
  `currencyId` int DEFAULT NULL,
  `paymentConditionId` int DEFAULT NULL,
  `invoicingAddressId` int DEFAULT NULL,
  `deliveryAddressId` int DEFAULT NULL,
  `countryId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_044d5a5bfdfec09213550e44724` (`activityId`),
  KEY `FK_2def30b68b8e2207769ff8738ff` (`currencyId`),
  KEY `FK_9f6d4895f2dd7b32de47612a14d` (`paymentConditionId`),
  KEY `FK_578acecf13449b3035b70604c3b` (`invoicingAddressId`),
  KEY `FK_124f4fc24e8dc7cdae5676018ba` (`deliveryAddressId`),
  CONSTRAINT `FK_044d5a5bfdfec09213550e44724` FOREIGN KEY (`activityId`) REFERENCES `ref-param` (`id`),
  CONSTRAINT `FK_124f4fc24e8dc7cdae5676018ba` FOREIGN KEY (`deliveryAddressId`) REFERENCES `address` (`id`),
  CONSTRAINT `FK_2def30b68b8e2207769ff8738ff` FOREIGN KEY (`currencyId`) REFERENCES `ref-param` (`id`),
  CONSTRAINT `FK_578acecf13449b3035b70604c3b` FOREIGN KEY (`invoicingAddressId`) REFERENCES `address` (`id`),
  CONSTRAINT `FK_9f6d4895f2dd7b32de47612a14d` FOREIGN KEY (`paymentConditionId`) REFERENCES `ref-param` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise`
--

LOCK TABLES `enterprise` WRITE;
/*!40000 ALTER TABLE `enterprise` DISABLE KEYS */;
INSERT INTO `enterprise` VALUES ('2026-04-28 19:25:19.345520','2026-04-28 19:25:19.345520',NULL,0,1,'Tempor quia illo dol','Eiusmod dolor molest','https://www.nereqitypoliry.com',0,'Quasi beatae anim qu','\"{\\\"root\\\":{\\\"children\\\":[{\\\"children\\\":[{\\\"detail\\\":0,\\\"format\\\":0,\\\"mode\\\":\\\"normal\\\",\\\"style\\\":\\\"\\\",\\\"text\\\":\\\"AAA\\\",\\\"type\\\":\\\"text\\\",\\\"version\\\":1}],\\\"direction\\\":null,\\\"format\\\":\\\"\\\",\\\"indent\\\":0,\\\"type\\\":\\\"paragraph\\\",\\\"version\\\":1,\\\"textFormat\\\":0,\\\"textStyle\\\":\\\"\\\"}],\\\"direction\\\":null,\\\"format\\\":\\\"\\\",\\\"indent\\\":0,\\\"type\\\":\\\"root\\\",\\\"version\\\":1}}\"',0,176,7,194,2,1,NULL),('2026-05-09 09:32:16.300520','2026-05-09 09:32:16.300520',NULL,0,2,'Voluptatem est hic q','Quis numquam volupta','https://www.nimiqixususyza.ws',0,'Laborum ad ea volupt','\"{\\\"root\\\":{\\\"children\\\":[{\\\"children\\\":[{\\\"detail\\\":0,\\\"format\\\":0,\\\"mode\\\":\\\"normal\\\",\\\"style\\\":\\\"\\\",\\\"text\\\":\\\"qqq\\\",\\\"type\\\":\\\"text\\\",\\\"version\\\":1}],\\\"direction\\\":null,\\\"format\\\":\\\"\\\",\\\"indent\\\":0,\\\"type\\\":\\\"paragraph\\\",\\\"version\\\":1,\\\"textFormat\\\":0,\\\"textStyle\\\":\\\"\\\"}],\\\"direction\\\":null,\\\"format\\\":\\\"\\\",\\\"indent\\\":0,\\\"type\\\":\\\"root\\\",\\\"version\\\":1}}\"',0,157,5,196,4,3,NULL);
/*!40000 ALTER TABLE `enterprise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_interlocutor`
--

DROP TABLE IF EXISTS `enterprise_interlocutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enterprise_interlocutor` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `enterpriseId` int NOT NULL,
  `interlocutorId` int NOT NULL,
  `main` tinyint NOT NULL DEFAULT '0',
  `position` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_996785c4f16896bcb085c3f7281` (`enterpriseId`),
  KEY `FK_392c77dd87f8bc7444d76dec46b` (`interlocutorId`),
  CONSTRAINT `FK_392c77dd87f8bc7444d76dec46b` FOREIGN KEY (`interlocutorId`) REFERENCES `_interlocutor` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_996785c4f16896bcb085c3f7281` FOREIGN KEY (`enterpriseId`) REFERENCES `enterprise` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_interlocutor`
--

LOCK TABLES `enterprise_interlocutor` WRITE;
/*!40000 ALTER TABLE `enterprise_interlocutor` DISABLE KEYS */;
INSERT INTO `enterprise_interlocutor` VALUES ('2026-04-28 19:25:19.383460','2026-04-28 19:25:19.383460',NULL,0,1,1,1,1,'Recusandae Dignissi'),('2026-05-09 09:32:16.318560','2026-05-09 09:32:16.318560',NULL,0,2,2,2,1,'Quas fuga Unde aut ');
/*!40000 ALTER TABLE `enterprise_interlocutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firm`
--

DROP TABLE IF EXISTS `firm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `firm` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `website` varchar(255) NOT NULL,
  `isPerson` tinyint NOT NULL DEFAULT '1',
  `taxIdNumber` varchar(50) DEFAULT NULL,
  `notes` varchar(1024) NOT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `activityId` int DEFAULT NULL,
  `currencyId` int DEFAULT NULL,
  `paymentConditionId` int DEFAULT NULL,
  `invoicingAddressId` int DEFAULT NULL,
  `deliveryAddressId` int DEFAULT NULL,
  `cabinetId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_b23239b12a4a4554d27163c9b0b` (`activityId`),
  KEY `FK_b35597d6e34b34af5917905cdfb` (`paymentConditionId`),
  KEY `FK_982254fd97c76f2d14d70287817` (`cabinetId`),
  KEY `FK_db0a8c88d6ff243ec8c393c1a9e` (`currencyId`),
  KEY `FK_f266791630e3eeb15820105a58b` (`invoicingAddressId`),
  KEY `FK_9e34e2b217d3af2d8c7ee1f74de` (`deliveryAddressId`),
  CONSTRAINT `FK_982254fd97c76f2d14d70287817` FOREIGN KEY (`cabinetId`) REFERENCES `cabinet` (`id`),
  CONSTRAINT `FK_9e34e2b217d3af2d8c7ee1f74de` FOREIGN KEY (`deliveryAddressId`) REFERENCES `_address` (`id`),
  CONSTRAINT `FK_b23239b12a4a4554d27163c9b0b` FOREIGN KEY (`activityId`) REFERENCES `activity` (`id`),
  CONSTRAINT `FK_b35597d6e34b34af5917905cdfb` FOREIGN KEY (`paymentConditionId`) REFERENCES `payment_condition` (`id`),
  CONSTRAINT `FK_db0a8c88d6ff243ec8c393c1a9e` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`),
  CONSTRAINT `FK_f266791630e3eeb15820105a58b` FOREIGN KEY (`invoicingAddressId`) REFERENCES `_address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firm`
--

LOCK TABLES `firm` WRITE;
/*!40000 ALTER TABLE `firm` DISABLE KEYS */;
/*!40000 ALTER TABLE `firm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firm_bank_account`
--

DROP TABLE IF EXISTS `firm_bank_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `firm_bank_account` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `bic` varchar(11) DEFAULT NULL,
  `rib` varchar(20) DEFAULT NULL,
  `iban` varchar(30) DEFAULT NULL,
  `currencyId` int DEFAULT NULL,
  `isMain` tinyint NOT NULL DEFAULT '1',
  `firmId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_9651d0a4379a2d4e6c4cda5f3da` (`firmId`),
  KEY `FK_517322ff5dd7bb8b6dfa7f3700a` (`currencyId`),
  CONSTRAINT `FK_517322ff5dd7bb8b6dfa7f3700a` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`),
  CONSTRAINT `FK_9651d0a4379a2d4e6c4cda5f3da` FOREIGN KEY (`firmId`) REFERENCES `firm` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firm_bank_account`
--

LOCK TABLES `firm_bank_account` WRITE;
/*!40000 ALTER TABLE `firm_bank_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `firm_bank_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firm_interlocutor_entry`
--

DROP TABLE IF EXISTS `firm_interlocutor_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `firm_interlocutor_entry` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `firmId` int NOT NULL,
  `interlocutorId` int NOT NULL,
  `isMain` tinyint NOT NULL DEFAULT '0',
  `position` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_9e31cea967d0dbbdac75e186b4d` (`firmId`),
  KEY `FK_65639b560b45d898a4aba65bc67` (`interlocutorId`),
  CONSTRAINT `FK_65639b560b45d898a4aba65bc67` FOREIGN KEY (`interlocutorId`) REFERENCES `interlocutor` (`id`),
  CONSTRAINT `FK_9e31cea967d0dbbdac75e186b4d` FOREIGN KEY (`firmId`) REFERENCES `firm` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firm_interlocutor_entry`
--

LOCK TABLES `firm_interlocutor_entry` WRITE;
/*!40000 ALTER TABLE `firm_interlocutor_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `firm_interlocutor_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interlocutor`
--

DROP TABLE IF EXISTS `interlocutor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interlocutor` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `title` enum('Mr.','Mrs.','Miss','Ms.','Dr.','Prof.') DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interlocutor`
--

LOCK TABLES `interlocutor` WRITE;
/*!40000 ALTER TABLE `interlocutor` DISABLE KEYS */;
/*!40000 ALTER TABLE `interlocutor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `sequential` varchar(25) NOT NULL,
  `date` datetime DEFAULT NULL,
  `dueDate` datetime DEFAULT NULL,
  `object` varchar(255) DEFAULT NULL,
  `generalConditions` varchar(1024) DEFAULT NULL,
  `status` enum('invoice.status.non_existent','invoice.status.draft','invoice.status.sent','invoice.status.validated','invoice.status.paid','invoice.status.partially_paid','invoice.status.unpaid','invoice.status.expired','quotation.status.archived') DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `discount_type` enum('PERCENTAGE','AMOUNT') DEFAULT NULL,
  `subTotal` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `amountPaid` float DEFAULT NULL,
  `currencyId` int NOT NULL,
  `firmId` int NOT NULL,
  `cabinetId` int NOT NULL DEFAULT '1',
  `interlocutorId` int NOT NULL,
  `notes` varchar(1024) DEFAULT NULL,
  `bankAccountId` int NOT NULL,
  `quotationId` int DEFAULT NULL,
  `taxStampId` int DEFAULT NULL,
  `taxWithholdingId` int DEFAULT NULL,
  `taxWithholdingAmount` float DEFAULT NULL,
  `invoiceMetaDataId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_b13dd6906f988f8b1280a8273b` (`sequential`),
  UNIQUE KEY `REL_2df639cc708ec1ab0aa3afa2d1` (`invoiceMetaDataId`),
  KEY `FK_b88d9f16251056b51793f620bdd` (`firmId`),
  KEY `FK_1482785fa2f32bc62d382a6f64e` (`interlocutorId`),
  KEY `FK_67b8b6f7e0b300e4fdcd983222e` (`cabinetId`),
  KEY `FK_34f006be9a86dc760de97834d6e` (`bankAccountId`),
  KEY `FK_89325ca6a370b57fe394c182225` (`quotationId`),
  KEY `FK_067e3ac3269ee40283af78b4b14` (`taxWithholdingId`),
  KEY `FK_45184bf71860b1e17cb683b746c` (`currencyId`),
  KEY `FK_f80a6a80cd341b838dd92fc7e3b` (`taxStampId`),
  CONSTRAINT `FK_067e3ac3269ee40283af78b4b14` FOREIGN KEY (`taxWithholdingId`) REFERENCES `tax-withholding` (`id`),
  CONSTRAINT `FK_1482785fa2f32bc62d382a6f64e` FOREIGN KEY (`interlocutorId`) REFERENCES `interlocutor` (`id`),
  CONSTRAINT `FK_2df639cc708ec1ab0aa3afa2d15` FOREIGN KEY (`invoiceMetaDataId`) REFERENCES `invoice_meta_data` (`id`),
  CONSTRAINT `FK_34f006be9a86dc760de97834d6e` FOREIGN KEY (`bankAccountId`) REFERENCES `bank_account` (`id`),
  CONSTRAINT `FK_45184bf71860b1e17cb683b746c` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`),
  CONSTRAINT `FK_67b8b6f7e0b300e4fdcd983222e` FOREIGN KEY (`cabinetId`) REFERENCES `cabinet` (`id`),
  CONSTRAINT `FK_89325ca6a370b57fe394c182225` FOREIGN KEY (`quotationId`) REFERENCES `quotation` (`id`),
  CONSTRAINT `FK_b88d9f16251056b51793f620bdd` FOREIGN KEY (`firmId`) REFERENCES `firm` (`id`),
  CONSTRAINT `FK_f80a6a80cd341b838dd92fc7e3b` FOREIGN KEY (`taxStampId`) REFERENCES `tax` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice-upload`
--

DROP TABLE IF EXISTS `invoice-upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice-upload` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `invoiceId` int NOT NULL,
  `uploadId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_1361d63a4951c411963be4451bf` (`invoiceId`),
  KEY `FK_9f8ac1ee6da02b5f74cf5eeec0d` (`uploadId`),
  CONSTRAINT `FK_1361d63a4951c411963be4451bf` FOREIGN KEY (`invoiceId`) REFERENCES `invoice` (`id`),
  CONSTRAINT `FK_9f8ac1ee6da02b5f74cf5eeec0d` FOREIGN KEY (`uploadId`) REFERENCES `storage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice-upload`
--

LOCK TABLES `invoice-upload` WRITE;
/*!40000 ALTER TABLE `invoice-upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice-upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_meta_data`
--

DROP TABLE IF EXISTS `invoice_meta_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_meta_data` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `showInvoiceAddress` tinyint NOT NULL DEFAULT '1',
  `showDeliveryAddress` tinyint NOT NULL DEFAULT '1',
  `showArticleDescription` tinyint NOT NULL DEFAULT '1',
  `hasBankingDetails` tinyint NOT NULL DEFAULT '1',
  `hasGeneralConditions` tinyint NOT NULL DEFAULT '1',
  `hasTaxStamp` tinyint NOT NULL DEFAULT '1',
  `hasTaxWithholding` tinyint NOT NULL DEFAULT '1',
  `taxSummary` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_meta_data`
--

LOCK TABLES `invoice_meta_data` WRITE;
/*!40000 ALTER TABLE `invoice_meta_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_meta_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `event` enum('signin','register','user_created','user_updated','user_deleted','user_activated','user_deactivated','role_created','role_updated','role_deleted','role_duplicated','firm_created','firm_updated','firm_deleted','interlocutor_created','interlocutor_updated','interlocutor_deleted','interlocutor_promoted','quotation_created','quotation_updated','quotation_deleted','quotation_printed','quotation_invoiced','quotation_duplicated','invoice_created','invoice_updated','invoice_deleted','invoice_printed','invoice_duplicated','payment_created','payment_updated','payment_deleted','activity_created','activity_updated','activity_deleted','bank_account_created','bank_account_updated','bank_account_deleted','default_condition_created','default_condition_updated','default_conditions_updated','default_condition_deleted','payment_condition_created','payment_condition_updated','payment_condition_deleted','tax_withholding_created','tax_withholding_updated','tax_withholding_deleted','tax_created','tax_updated','tax_deleted','template_category_created','template_category_updated','template_category_deleted','firm_bank_account_created','firm_bank_account_updated','firm_bank_account_deleted','sequence_updated','REF_TYPE_CREATE','REF_TYPE_UPDATE','REF_TYPE_DELETE','REF_PARAM_CREATE','REF_PARAM_UPDATE','REF_PARAM_DELETE','enterprise_created','enterprise_updated','enterprise_deleted','_quotation_created','_quotation_updated','_quotation_deleted','_article_created','_article_updated','_article_deleted','_article_family_created','_article_family_updated','_article_family_deleted','_tax_rate_created','_tax_rate_updated','_tax_rate_deleted','template_created','template_updated','template_deleted') DEFAULT NULL,
  `api` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `logInfo` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cea2ed3a494729d4b21edbd2983` (`userId`),
  CONSTRAINT `FK_cea2ed3a494729d4b21edbd2983` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES ('2026-03-04 08:10:17.248480','2026-03-04 08:10:17.248480',NULL,0,1,'signin','/public/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-03-04 09:35:17.665778','2026-03-04 09:35:17.665778',NULL,0,2,'signin','/public/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-03-04 10:00:06.824680','2026-03-04 10:00:06.824680',NULL,0,3,'signin','/public/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-03-04 10:00:06.840564','2026-03-04 10:00:06.840564',NULL,0,4,'signin','/public/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-03-09 10:46:43.174089','2026-03-09 10:46:43.174089',NULL,0,5,'signin','/public/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-03-17 08:04:27.034253','2026-03-17 08:04:27.034253',NULL,0,6,'signin','/public/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-03-18 09:07:36.764720','2026-03-18 09:07:36.764720',NULL,0,7,'signin','/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-03-31 14:24:59.565224','2026-03-31 14:24:59.565224',NULL,0,8,'signin','/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-04-07 13:52:44.165071','2026-04-07 13:52:44.165071',NULL,0,9,'signin','/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-04-11 16:59:45.252498','2026-04-11 16:59:45.252498',NULL,0,10,'signin','/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-04-21 12:34:47.183615','2026-04-21 12:34:47.183615',NULL,0,11,'signin','/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-04-28 10:04:26.241314','2026-04-28 10:04:26.241314',NULL,0,12,'signin','/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-04-28 19:25:19.423552','2026-04-28 19:25:19.423552',NULL,0,13,'enterprise_created','/enterprise','POST','de929660-80f7-47b2-afcf-483a04bbcf50','{\"id\": 1}'),('2026-05-08 16:58:11.366630','2026-05-08 16:58:11.366630',NULL,0,14,'signin','/auth/sign-in','POST',NULL,'{\"userId\": \"de929660-80f7-47b2-afcf-483a04bbcf50\", \"fullname\": \"Super$ Admin$\"}'),('2026-05-09 09:32:16.334725','2026-05-09 09:32:16.334725',NULL,0,15,'enterprise_created','/enterprise','POST','de929660-80f7-47b2-afcf-483a04bbcf50','{\"id\": 2}');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `checksum` int DEFAULT NULL,
  `script` varchar(255) NOT NULL,
  `success` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES ('2026-04-11 20:37:39.465720','2026-04-11 20:37:39.000000',NULL,0,1,'1.1.0','init_schema',-46329570,'V1_1__init_schema.sql',1),('2026-04-11 20:37:39.558625','2026-04-11 20:37:39.558625',NULL,0,2,'1.2.0','seed_primitives',-1252465372,'V1_2__seed_primitives.sql',0);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` float DEFAULT NULL,
  `fee` float DEFAULT NULL,
  `convertionRate` float DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `mode` enum('payment.payment_mode.cash','payment.payment_mode.credit_card','payment.payment_mode.check','payment.payment_mode.bank_transfer','payment.payment_mode.wire_transfer') DEFAULT NULL,
  `notes` varchar(1024) DEFAULT NULL,
  `currencyId` int DEFAULT NULL,
  `firmId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_fa8bdeebb7c3e9b04cf1d2cb2f5` (`firmId`),
  KEY `FK_8bd02879aabfa095f531e9482f3` (`currencyId`),
  CONSTRAINT `FK_8bd02879aabfa095f531e9482f3` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`),
  CONSTRAINT `FK_fa8bdeebb7c3e9b04cf1d2cb2f5` FOREIGN KEY (`firmId`) REFERENCES `firm` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment-invoice_entry`
--

DROP TABLE IF EXISTS `payment-invoice_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment-invoice_entry` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `paymentId` int NOT NULL,
  `invoiceId` int NOT NULL,
  `amount` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_5a0661bddb1ba33d72001238a88` (`paymentId`),
  KEY `FK_57b01ee74e8ea8de3b23273c53d` (`invoiceId`),
  CONSTRAINT `FK_57b01ee74e8ea8de3b23273c53d` FOREIGN KEY (`invoiceId`) REFERENCES `invoice` (`id`),
  CONSTRAINT `FK_5a0661bddb1ba33d72001238a88` FOREIGN KEY (`paymentId`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment-invoice_entry`
--

LOCK TABLES `payment-invoice_entry` WRITE;
/*!40000 ALTER TABLE `payment-invoice_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment-invoice_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment-upload`
--

DROP TABLE IF EXISTS `payment-upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment-upload` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `paymentId` int NOT NULL,
  `uploadId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bf2292a4894821c6fd1ed975370` (`paymentId`),
  KEY `FK_dab11cba45fcc9332a260f209c5` (`uploadId`),
  CONSTRAINT `FK_bf2292a4894821c6fd1ed975370` FOREIGN KEY (`paymentId`) REFERENCES `payment` (`id`),
  CONSTRAINT `FK_dab11cba45fcc9332a260f209c5` FOREIGN KEY (`uploadId`) REFERENCES `storage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment-upload`
--

LOCK TABLES `payment-upload` WRITE;
/*!40000 ALTER TABLE `payment-upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment-upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_condition`
--

DROP TABLE IF EXISTS `payment_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_condition` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_condition`
--

LOCK TABLES `payment_condition` WRITE;
/*!40000 ALTER TABLE `payment_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_1d269eed4300a2aa85a201c527` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES ('2026-03-04 08:05:10.478746','2026-03-04 08:05:10.478746',NULL,0,'create-invoice','CREATE_INVOICE','This permission is for create invoice'),('2026-03-04 08:05:10.567610','2026-03-04 08:05:10.567610',NULL,0,'create-payment','CREATE_PAYMENT','This permission is for create payment'),('2026-03-04 08:05:10.359524','2026-03-04 08:05:10.359524',NULL,0,'create-profile','CREATE_PROFILE','This permission is for create profile'),('2026-03-04 08:05:10.526120','2026-03-04 08:05:10.526120',NULL,0,'create-quotation','CREATE_QUOTATION','This permission is for create quotation'),('2026-03-04 08:05:10.420440','2026-03-04 08:05:10.420440',NULL,0,'create-role','CREATE_ROLE','This permission is for create role'),('2026-03-04 08:05:10.656334','2026-03-04 08:05:10.656334',NULL,0,'create-template','CREATE_TEMPLATE','This permission is for create template'),('2026-03-04 08:05:10.289781','2026-03-04 08:05:10.289781',NULL,0,'create-user','CREATE_USER','This permission is for create user'),('2026-03-04 08:05:10.515583','2026-03-04 08:05:10.515583',NULL,0,'delete-invoice','DELETE_INVOICE','This permission is for delete invoice'),('2026-03-04 08:05:10.625735','2026-03-04 08:05:10.625735',NULL,0,'delete-payment','DELETE_PAYMENT','This permission is for delete payment'),('2026-03-04 08:05:10.405909','2026-03-04 08:05:10.405909',NULL,0,'delete-profile','DELETE_PROFILE','This permission is for delete profile'),('2026-03-04 08:05:10.556247','2026-03-04 08:05:10.556247',NULL,0,'delete-quotation','DELETE_QUOTATION','This permission is for delete quotation'),('2026-03-04 08:05:10.463826','2026-03-04 08:05:10.463826',NULL,0,'delete-role','DELETE_ROLE','This permission is for delete role'),('2026-03-04 08:05:10.754087','2026-03-04 08:05:10.754087',NULL,0,'delete-template','DELETE_TEMPLATE','This permission is for delete template'),('2026-03-04 08:05:10.344991','2026-03-04 08:05:10.344991',NULL,0,'delete-user','DELETE_USER','This permission is for delete user'),('2026-03-04 08:05:10.492836','2026-03-04 08:05:10.492836',NULL,0,'read-invoice','READ_INVOICE','This permission is for read invoice'),('2026-03-04 08:05:10.579467','2026-03-04 08:05:10.579467',NULL,0,'read-payment','READ_PAYMENT','This permission is for read payment'),('2026-03-04 08:05:10.376899','2026-03-04 08:05:10.376899',NULL,0,'read-profile','READ_PROFILE','This permission is for read profile'),('2026-03-04 08:05:10.536497','2026-03-04 08:05:10.536497',NULL,0,'read-quotation','READ_QUOTATION','This permission is for read quotation'),('2026-03-04 08:05:10.438249','2026-03-04 08:05:10.438249',NULL,0,'read-role','READ_ROLE','This permission is for read role'),('2026-03-04 08:05:10.687878','2026-03-04 08:05:10.687878',NULL,0,'read-template','READ_TEMPLATE','This permission is for read template'),('2026-03-04 08:05:10.310789','2026-03-04 08:05:10.310789',NULL,0,'read-user','READ_USER','This permission is for read user'),('2026-03-04 08:05:10.506006','2026-03-04 08:05:10.506006',NULL,0,'update-invoice','UPDATE_INVOICE','This permission is for update invoice'),('2026-03-04 08:05:10.597260','2026-03-04 08:05:10.597260',NULL,0,'update-payment','UPDATE_PAYMENT','This permission is for update payment'),('2026-03-04 08:05:10.391405','2026-03-04 08:05:10.391405',NULL,0,'update-profile','UPDATE_PROFILE','This permission is for update profile'),('2026-03-04 08:05:10.545664','2026-03-04 08:05:10.545664',NULL,0,'update-quotation','UPDATE_QUOTATION','This permission is for update quotation'),('2026-03-04 08:05:10.451610','2026-03-04 08:05:10.451610',NULL,0,'update-role','UPDATE_ROLE','This permission is for update role'),('2026-03-04 08:05:10.724561','2026-03-04 08:05:10.724561',NULL,0,'update-template','UPDATE_TEMPLATE','This permission is for update template'),('2026-03-04 08:05:10.325448','2026-03-04 08:05:10.325448',NULL,0,'update-user','UPDATE_USER','This permission is for update user');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) DEFAULT NULL,
  `cin` varchar(255) DEFAULT NULL,
  `bio` text,
  `gender` enum('Male','Female') DEFAULT NULL,
  `isPrivate` tinyint NOT NULL DEFAULT '0',
  `regionId` int DEFAULT NULL,
  `pictureId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_6ca5cd9bacd921599be9d92097` (`phone`),
  UNIQUE KEY `IDX_81a7ccecddaae7a7ec3f25e52a` (`cin`),
  KEY `FK_361219bcc19b8cb0aac6f91b4cb` (`pictureId`),
  CONSTRAINT `FK_361219bcc19b8cb0aac6f91b4cb` FOREIGN KEY (`pictureId`) REFERENCES `storage` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES ('2026-03-04 08:05:40.568475','2026-03-04 08:05:40.568475',NULL,0,1,NULL,'123456789','I am a super admin','Male',0,NULL,NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotation`
--

DROP TABLE IF EXISTS `quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotation` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `sequential` varchar(25) NOT NULL,
  `date` datetime DEFAULT NULL,
  `dueDate` datetime DEFAULT NULL,
  `object` varchar(255) DEFAULT NULL,
  `generalConditions` varchar(1024) DEFAULT NULL,
  `status` enum('quotation.status.non_existent','quotation.status.expired','quotation.status.draft','quotation.status.validated','quotation.status.sent','quotation.status.accepted','quotation.status.rejected','quotation.status.invoiced','quotation.status.archived') DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `discount_type` enum('PERCENTAGE','AMOUNT') DEFAULT NULL,
  `subTotal` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `currencyId` int NOT NULL,
  `firmId` int NOT NULL,
  `cabinetId` int NOT NULL DEFAULT '1',
  `interlocutorId` int NOT NULL,
  `notes` varchar(1024) DEFAULT NULL,
  `bankAccountId` int NOT NULL,
  `quotationMetaDataId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_88824cf54d3381086a040f6771` (`sequential`),
  UNIQUE KEY `REL_75285b4cbccade7e137ffa96af` (`quotationMetaDataId`),
  KEY `FK_2aadd1c80bd38ea2bcc4a97365f` (`firmId`),
  KEY `FK_50a00388815040419b42b1fd6f9` (`interlocutorId`),
  KEY `FK_4caf0ac9a8e835acc79c3da639c` (`cabinetId`),
  KEY `FK_864846192abb075965c786dfc56` (`bankAccountId`),
  KEY `FK_ef5cd42304e8de7db855305191e` (`currencyId`),
  CONSTRAINT `FK_2aadd1c80bd38ea2bcc4a97365f` FOREIGN KEY (`firmId`) REFERENCES `firm` (`id`),
  CONSTRAINT `FK_4caf0ac9a8e835acc79c3da639c` FOREIGN KEY (`cabinetId`) REFERENCES `cabinet` (`id`),
  CONSTRAINT `FK_50a00388815040419b42b1fd6f9` FOREIGN KEY (`interlocutorId`) REFERENCES `interlocutor` (`id`),
  CONSTRAINT `FK_75285b4cbccade7e137ffa96af4` FOREIGN KEY (`quotationMetaDataId`) REFERENCES `quotation_meta_data` (`id`),
  CONSTRAINT `FK_864846192abb075965c786dfc56` FOREIGN KEY (`bankAccountId`) REFERENCES `bank_account` (`id`),
  CONSTRAINT `FK_ef5cd42304e8de7db855305191e` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotation`
--

LOCK TABLES `quotation` WRITE;
/*!40000 ALTER TABLE `quotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotation-articles`
--

DROP TABLE IF EXISTS `quotation-articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotation-articles` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `quotationId` int NOT NULL,
  `articleId` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `unitPrice` decimal(10,2) DEFAULT NULL,
  `discountType` enum('rate','fixed') NOT NULL DEFAULT 'rate',
  `discountValue` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_31c722b17a070712879989a25c9` (`quotationId`),
  KEY `FK_2c9038a13838aac06e7ab45214b` (`articleId`),
  CONSTRAINT `FK_2c9038a13838aac06e7ab45214b` FOREIGN KEY (`articleId`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_31c722b17a070712879989a25c9` FOREIGN KEY (`quotationId`) REFERENCES `_quotation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotation-articles`
--

LOCK TABLES `quotation-articles` WRITE;
/*!40000 ALTER TABLE `quotation-articles` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation-articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotation-upload`
--

DROP TABLE IF EXISTS `quotation-upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotation-upload` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `quotationId` int NOT NULL,
  `uploadId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_3d6abc7176867c61ca4baaee369` (`quotationId`),
  KEY `FK_1e8313639f95c0c9e0804bf6afb` (`uploadId`),
  CONSTRAINT `FK_1e8313639f95c0c9e0804bf6afb` FOREIGN KEY (`uploadId`) REFERENCES `storage` (`id`),
  CONSTRAINT `FK_3d6abc7176867c61ca4baaee369` FOREIGN KEY (`quotationId`) REFERENCES `quotation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotation-upload`
--

LOCK TABLES `quotation-upload` WRITE;
/*!40000 ALTER TABLE `quotation-upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation-upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotation_article_taxes`
--

DROP TABLE IF EXISTS `quotation_article_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotation_article_taxes` (
  `quotationArticleId` int NOT NULL,
  `taxRateId` int NOT NULL,
  PRIMARY KEY (`quotationArticleId`,`taxRateId`),
  KEY `IDX_2f78c101dcdbbc8b4a78ebffea` (`quotationArticleId`),
  KEY `IDX_e91bda5e465131b339e0c7611f` (`taxRateId`),
  CONSTRAINT `FK_2f78c101dcdbbc8b4a78ebffead` FOREIGN KEY (`quotationArticleId`) REFERENCES `quotation-articles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_e91bda5e465131b339e0c7611f6` FOREIGN KEY (`taxRateId`) REFERENCES `tax-rates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotation_article_taxes`
--

LOCK TABLES `quotation_article_taxes` WRITE;
/*!40000 ALTER TABLE `quotation_article_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation_article_taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotation_meta_data`
--

DROP TABLE IF EXISTS `quotation_meta_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotation_meta_data` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `showInvoiceAddress` tinyint NOT NULL DEFAULT '1',
  `showDeliveryAddress` tinyint NOT NULL DEFAULT '1',
  `showArticleDescription` tinyint NOT NULL DEFAULT '1',
  `hasBankingDetails` tinyint NOT NULL DEFAULT '1',
  `hasGeneralConditions` tinyint NOT NULL DEFAULT '1',
  `taxSummary` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotation_meta_data`
--

LOCK TABLES `quotation_meta_data` WRITE;
/*!40000 ALTER TABLE `quotation_meta_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotation_meta_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref-param`
--

DROP TABLE IF EXISTS `ref-param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref-param` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `refTypeId` varchar(255) NOT NULL,
  `extras` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_2a50b7a51767c844b927d7fb1a4` (`refTypeId`),
  CONSTRAINT `FK_2a50b7a51767c844b927d7fb1a4` FOREIGN KEY (`refTypeId`) REFERENCES `ref-type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=446 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref-param`
--

LOCK TABLES `ref-param` WRITE;
/*!40000 ALTER TABLE `ref-param` DISABLE KEYS */;
INSERT INTO `ref-param` VALUES ('2026-04-28 13:34:33.737374','2026-04-28 13:34:33.737374',NULL,0,1,'Afghan afghani','Description for Afghan afghani','currency','{\"code\": \"AFN\", \"symbol\": \"؋\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:33.750200','2026-04-28 13:34:33.750200',NULL,0,2,'Albanian lek','Description for Albanian lek','currency','{\"code\": \"ALL\", \"symbol\": \"L\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:33.764612','2026-04-28 13:34:33.764612',NULL,0,3,'Algerian dinar','Description for Algerian dinar','currency','{\"code\": \"DZD\", \"symbol\": \"د.ج\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:33.786437','2026-04-28 13:34:33.786437',NULL,0,4,'Angolan kwanza','Description for Angolan kwanza','currency','{\"code\": \"AOA\", \"symbol\": \"Kz\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:33.820325','2026-04-28 13:34:33.820325',NULL,0,5,'Argentine peso','Description for Argentine peso','currency','{\"code\": \"ARS\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:33.854500','2026-04-28 13:34:33.854500',NULL,0,6,'Armenian dram','Description for Armenian dram','currency','{\"code\": \"AMD\", \"symbol\": \"֏\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:33.898954','2026-04-28 13:34:33.898954',NULL,0,7,'Aruban florin','Description for Aruban florin','currency','{\"code\": \"AWG\", \"symbol\": \"ƒ\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:33.947210','2026-04-28 13:34:33.947210',NULL,0,8,'Australian dollar','Description for Australian dollar','currency','{\"code\": \"AUD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.003704','2026-04-28 13:34:34.003704',NULL,0,9,'Azerbaijani manat','Description for Azerbaijani manat','currency','{\"code\": \"AZN\", \"symbol\": \"₼\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.043608','2026-04-28 13:34:34.043608',NULL,0,10,'Bahamian dollar','Description for Bahamian dollar','currency','{\"code\": \"BSD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.064049','2026-04-28 13:34:34.064049',NULL,0,11,'Bahraini dinar','Description for Bahraini dinar','currency','{\"code\": \"BHD\", \"symbol\": \".د.ب\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.083175','2026-04-28 13:34:34.083175',NULL,0,12,'Bangladeshi taka','Description for Bangladeshi taka','currency','{\"code\": \"BDT\", \"symbol\": \"৳\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.102041','2026-04-28 13:34:34.102041',NULL,0,13,'Barbadian dollar','Description for Barbadian dollar','currency','{\"code\": \"BBD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.118248','2026-04-28 13:34:34.118248',NULL,0,14,'Belize dollar','Description for Belize dollar','currency','{\"code\": \"BZD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.135047','2026-04-28 13:34:34.135047',NULL,0,15,'Bermudian dollar','Description for Bermudian dollar','currency','{\"code\": \"BMD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.150169','2026-04-28 13:34:34.150169',NULL,0,16,'Bhutanese ngultrum','Description for Bhutanese ngultrum','currency','{\"code\": \"BTN\", \"symbol\": \"Nu.\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.165185','2026-04-28 13:34:34.165185',NULL,0,17,'Bolivian boliviano','Description for Bolivian boliviano','currency','{\"code\": \"BOB\", \"symbol\": \"Bs.\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.183017','2026-04-28 13:34:34.183017',NULL,0,18,'Bosnia and Herzegovina convertible mark','Description for Bosnia and Herzegovina convertible mark','currency','{\"code\": \"BAM\", \"symbol\": \"KM\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.201736','2026-04-28 13:34:34.201736',NULL,0,19,'Botswana pula','Description for Botswana pula','currency','{\"code\": \"BWP\", \"symbol\": \"P\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.220160','2026-04-28 13:34:34.220160',NULL,0,20,'Brazilian real','Description for Brazilian real','currency','{\"code\": \"BRL\", \"symbol\": \"R$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.238703','2026-04-28 13:34:34.238703',NULL,0,21,'British pound','Description for British pound','currency','{\"code\": \"GBP\", \"symbol\": \"£\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.253441','2026-04-28 13:34:34.253441',NULL,0,22,'Brunei dollar','Description for Brunei dollar','currency','{\"code\": \"BND\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.270294','2026-04-28 13:34:34.270294',NULL,0,23,'Bulgarian lev','Description for Bulgarian lev','currency','{\"code\": \"BGN\", \"symbol\": \"лв\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.289167','2026-04-28 13:34:34.289167',NULL,0,24,'Burmese kyat','Description for Burmese kyat','currency','{\"code\": \"MMK\", \"symbol\": \"Ks\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.309119','2026-04-28 13:34:34.309119',NULL,0,25,'Burundian franc','Description for Burundian franc','currency','{\"code\": \"BIF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.327680','2026-04-28 13:34:34.327680',NULL,0,26,'CFP franc','Description for CFP franc','currency','{\"code\": \"XPF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.343079','2026-04-28 13:34:34.343079',NULL,0,27,'Cambodian riel','Description for Cambodian riel','currency','{\"code\": \"KHR\", \"symbol\": \"៛\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.360512','2026-04-28 13:34:34.360512',NULL,0,28,'Canadian dollar','Description for Canadian dollar','currency','{\"code\": \"CAD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.382582','2026-04-28 13:34:34.382582',NULL,0,29,'Cape Verdean escudo','Description for Cape Verdean escudo','currency','{\"code\": \"CVE\", \"symbol\": \"Esc\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.398525','2026-04-28 13:34:34.398525',NULL,0,30,'Cayman Islands dollar','Description for Cayman Islands dollar','currency','{\"code\": \"KYD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.414636','2026-04-28 13:34:34.414636',NULL,0,31,'Central African CFA franc','Description for Central African CFA franc','currency','{\"code\": \"XAF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.431752','2026-04-28 13:34:34.431752',NULL,0,32,'Chilean peso','Description for Chilean peso','currency','{\"code\": \"CLP\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.446241','2026-04-28 13:34:34.446241',NULL,0,33,'Chinese yuan','Description for Chinese yuan','currency','{\"code\": \"CNY\", \"symbol\": \"¥\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.462666','2026-04-28 13:34:34.462666',NULL,0,34,'Colombian peso','Description for Colombian peso','currency','{\"code\": \"COP\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.480745','2026-04-28 13:34:34.480745',NULL,0,35,'Comorian franc','Description for Comorian franc','currency','{\"code\": \"KMF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.511498','2026-04-28 13:34:34.511498',NULL,0,36,'Congolese franc','Description for Congolese franc','currency','{\"code\": \"CDF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.532542','2026-04-28 13:34:34.532542',NULL,0,37,'Costa Rican colón','Description for Costa Rican colón','currency','{\"code\": \"CRC\", \"symbol\": \"₡\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.550957','2026-04-28 13:34:34.550957',NULL,0,38,'Cuban convertible peso','Description for Cuban convertible peso','currency','{\"code\": \"CUC\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.571496','2026-04-28 13:34:34.571496',NULL,0,39,'Czech koruna','Description for Czech koruna','currency','{\"code\": \"CZK\", \"symbol\": \"Kč\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.596968','2026-04-28 13:34:34.596968',NULL,0,40,'Danish krone','Description for Danish krone','currency','{\"code\": \"DKK\", \"symbol\": \"kr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.619464','2026-04-28 13:34:34.619464',NULL,0,41,'Djiboutian franc','Description for Djiboutian franc','currency','{\"code\": \"DJF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.641506','2026-04-28 13:34:34.641506',NULL,0,42,'Dominican peso','Description for Dominican peso','currency','{\"code\": \"DOP\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.663788','2026-04-28 13:34:34.663788',NULL,0,43,'East Caribbean dollar','Description for East Caribbean dollar','currency','{\"code\": \"XCD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.695515','2026-04-28 13:34:34.695515',NULL,0,44,'Egyptian pound','Description for Egyptian pound','currency','{\"code\": \"EGP\", \"symbol\": \"£\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.722465','2026-04-28 13:34:34.722465',NULL,0,45,'Eritrean nakfa','Description for Eritrean nakfa','currency','{\"code\": \"ERN\", \"symbol\": \"Nfk\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.750632','2026-04-28 13:34:34.750632',NULL,0,46,'Ethiopian birr','Description for Ethiopian birr','currency','{\"code\": \"ETB\", \"symbol\": \"Br\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.779986','2026-04-28 13:34:34.779986',NULL,0,47,'Euro','Description for Euro','currency','{\"code\": \"EUR\", \"symbol\": \"€\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.797246','2026-04-28 13:34:34.797246',NULL,0,48,'Falkland Islands Pound','Description for Falkland Islands Pound','currency','{\"code\": \"FKP\", \"symbol\": \"£\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.806851','2026-04-28 13:34:34.806851',NULL,0,49,'Fijian dollar','Description for Fijian dollar','currency','{\"code\": \"FJD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.817349','2026-04-28 13:34:34.817349',NULL,0,50,'Gambian dalasi','Description for Gambian dalasi','currency','{\"code\": \"GMD\", \"symbol\": \"D\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.826682','2026-04-28 13:34:34.826682',NULL,0,51,'Georgian Lari','Description for Georgian Lari','currency','{\"code\": \"GEL\", \"symbol\": \"ლ\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.836319','2026-04-28 13:34:34.836319',NULL,0,52,'Ghanaian cedi','Description for Ghanaian cedi','currency','{\"code\": \"GHS\", \"symbol\": \"₵\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.846005','2026-04-28 13:34:34.846005',NULL,0,53,'Gibraltar pound','Description for Gibraltar pound','currency','{\"code\": \"GIP\", \"symbol\": \"£\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.857614','2026-04-28 13:34:34.857614',NULL,0,54,'Guatemalan quetzal','Description for Guatemalan quetzal','currency','{\"code\": \"GTQ\", \"symbol\": \"Q\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.868618','2026-04-28 13:34:34.868618',NULL,0,55,'Guinean franc','Description for Guinean franc','currency','{\"code\": \"GNF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.886732','2026-04-28 13:34:34.886732',NULL,0,56,'Guyanese dollar','Description for Guyanese dollar','currency','{\"code\": \"GYD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.915812','2026-04-28 13:34:34.915812',NULL,0,57,'Haitian gourde','Description for Haitian gourde','currency','{\"code\": \"HTG\", \"symbol\": \"G\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.942201','2026-04-28 13:34:34.942201',NULL,0,58,'Honduran lempira','Description for Honduran lempira','currency','{\"code\": \"HNL\", \"symbol\": \"L\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.965583','2026-04-28 13:34:34.965583',NULL,0,59,'Hong Kong dollar','Description for Hong Kong dollar','currency','{\"code\": \"HKD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:34.993527','2026-04-28 13:34:34.993527',NULL,0,60,'Hungarian forint','Description for Hungarian forint','currency','{\"code\": \"HUF\", \"symbol\": \"Ft\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.029911','2026-04-28 13:34:35.029911',NULL,0,61,'Icelandic króna','Description for Icelandic króna','currency','{\"code\": \"ISK\", \"symbol\": \"kr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.058096','2026-04-28 13:34:35.058096',NULL,0,62,'Indian rupee','Description for Indian rupee','currency','{\"code\": \"INR\", \"symbol\": \"₹\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.086298','2026-04-28 13:34:35.086298',NULL,0,63,'Indonesian rupiah','Description for Indonesian rupiah','currency','{\"code\": \"IDR\", \"symbol\": \"Rp\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.118917','2026-04-28 13:34:35.118917',NULL,0,64,'Iranian rial','Description for Iranian rial','currency','{\"code\": \"IRR\", \"symbol\": \"﷼\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.158046','2026-04-28 13:34:35.158046',NULL,0,65,'Iraqi dinar','Description for Iraqi dinar','currency','{\"code\": \"IQD\", \"symbol\": \"ع.د\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.201240','2026-04-28 13:34:35.201240',NULL,0,66,'Israeli new shekel','Description for Israeli new shekel','currency','{\"code\": \"ILS\", \"symbol\": \"₪\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.248991','2026-04-28 13:34:35.248991',NULL,0,67,'Jamaican dollar','Description for Jamaican dollar','currency','{\"code\": \"JMD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.264823','2026-04-28 13:34:35.264823',NULL,0,68,'Japanese yen','Description for Japanese yen','currency','{\"code\": \"JPY\", \"symbol\": \"¥\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.277725','2026-04-28 13:34:35.277725',NULL,0,69,'Jordanian dinar','Description for Jordanian dinar','currency','{\"code\": \"JOD\", \"symbol\": \"د.ا\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.288137','2026-04-28 13:34:35.288137',NULL,0,70,'Kazakhstani tenge','Description for Kazakhstani tenge','currency','{\"code\": \"KZT\", \"symbol\": \"₸\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.299961','2026-04-28 13:34:35.299961',NULL,0,71,'Kenyan shilling','Description for Kenyan shilling','currency','{\"code\": \"KES\", \"symbol\": \"Sh\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.310616','2026-04-28 13:34:35.310616',NULL,0,72,'Kuwaiti dinar','Description for Kuwaiti dinar','currency','{\"code\": \"KWD\", \"symbol\": \"د.ك\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.322152','2026-04-28 13:34:35.322152',NULL,0,73,'Kyrgyzstani som','Description for Kyrgyzstani som','currency','{\"code\": \"KGS\", \"symbol\": \"с\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.332293','2026-04-28 13:34:35.332293',NULL,0,74,'Lao kip','Description for Lao kip','currency','{\"code\": \"LAK\", \"symbol\": \"₭\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.342024','2026-04-28 13:34:35.342024',NULL,0,75,'Lebanese pound','Description for Lebanese pound','currency','{\"code\": \"LBP\", \"symbol\": \"ل.ل\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.351543','2026-04-28 13:34:35.351543',NULL,0,76,'Lesotho loti','Description for Lesotho loti','currency','{\"code\": \"LSL\", \"symbol\": \"L\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.361298','2026-04-28 13:34:35.361298',NULL,0,77,'Liberian dollar','Description for Liberian dollar','currency','{\"code\": \"LRD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.370522','2026-04-28 13:34:35.370522',NULL,0,78,'Libyan dinar','Description for Libyan dinar','currency','{\"code\": \"LYD\", \"symbol\": \"ل.د\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.379526','2026-04-28 13:34:35.379526',NULL,0,79,'Macanese pataca','Description for Macanese pataca','currency','{\"code\": \"MOP\", \"symbol\": \"P\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.388342','2026-04-28 13:34:35.388342',NULL,0,80,'Macedonian denar','Description for Macedonian denar','currency','{\"code\": \"MKD\", \"symbol\": \"ден\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.397157','2026-04-28 13:34:35.397157',NULL,0,81,'Malagasy ariary','Description for Malagasy ariary','currency','{\"code\": \"MGA\", \"symbol\": \"Ar\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.406454','2026-04-28 13:34:35.406454',NULL,0,82,'Malawian kwacha','Description for Malawian kwacha','currency','{\"code\": \"MWK\", \"symbol\": \"MK\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.417723','2026-04-28 13:34:35.417723',NULL,0,83,'Malaysian ringgit','Description for Malaysian ringgit','currency','{\"code\": \"MYR\", \"symbol\": \"RM\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.428609','2026-04-28 13:34:35.428609',NULL,0,84,'Maldivian rufiyaa','Description for Maldivian rufiyaa','currency','{\"code\": \"MVR\", \"symbol\": \".ރ\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.438496','2026-04-28 13:34:35.438496',NULL,0,85,'Mauritanian ouguiya','Description for Mauritanian ouguiya','currency','{\"code\": \"MRO\", \"symbol\": \"UM\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.451096','2026-04-28 13:34:35.451096',NULL,0,86,'Mauritian rupee','Description for Mauritian rupee','currency','{\"code\": \"MUR\", \"symbol\": \"₨\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.460557','2026-04-28 13:34:35.460557',NULL,0,87,'Mexican peso','Description for Mexican peso','currency','{\"code\": \"MXN\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.470397','2026-04-28 13:34:35.470397',NULL,0,88,'Moldovan leu','Description for Moldovan leu','currency','{\"code\": \"MDL\", \"symbol\": \"L\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.479841','2026-04-28 13:34:35.479841',NULL,0,89,'Mongolian tögrög','Description for Mongolian tögrög','currency','{\"code\": \"MNT\", \"symbol\": \"₮\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.493029','2026-04-28 13:34:35.493029',NULL,0,90,'Moroccan dirham','Description for Moroccan dirham','currency','{\"code\": \"MAD\", \"symbol\": \"د.م.\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.501750','2026-04-28 13:34:35.501750',NULL,0,91,'Mozambican metical','Description for Mozambican metical','currency','{\"code\": \"MZN\", \"symbol\": \"MT\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.511767','2026-04-28 13:34:35.511767',NULL,0,92,'Namibian dollar','Description for Namibian dollar','currency','{\"code\": \"NAD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.521189','2026-04-28 13:34:35.521189',NULL,0,93,'Nepalese rupee','Description for Nepalese rupee','currency','{\"code\": \"NPR\", \"symbol\": \"₨\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.530486','2026-04-28 13:34:35.530486',NULL,0,94,'Netherlands Antillean guilder','Description for Netherlands Antillean guilder','currency','{\"code\": \"ANG\", \"symbol\": \"ƒ\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.539936','2026-04-28 13:34:35.539936',NULL,0,95,'New Belarusian ruble','Description for New Belarusian ruble','currency','{\"code\": \"BYN\", \"symbol\": \"Br\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.549152','2026-04-28 13:34:35.549152',NULL,0,96,'New Taiwan dollar','Description for New Taiwan dollar','currency','{\"code\": \"TWD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.561087','2026-04-28 13:34:35.561087',NULL,0,97,'New Zealand dollar','Description for New Zealand dollar','currency','{\"code\": \"NZD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.587098','2026-04-28 13:34:35.587098',NULL,0,98,'Nicaraguan córdoba','Description for Nicaraguan córdoba','currency','{\"code\": \"NIO\", \"symbol\": \"C$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.624208','2026-04-28 13:34:35.624208',NULL,0,99,'Nigerian naira','Description for Nigerian naira','currency','{\"code\": \"NGN\", \"symbol\": \"₦\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.674737','2026-04-28 13:34:35.674737',NULL,0,100,'North Korean won','Description for North Korean won','currency','{\"code\": \"KPW\", \"symbol\": \"₩\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.715682','2026-04-28 13:34:35.715682',NULL,0,101,'Norwegian krone','Description for Norwegian krone','currency','{\"code\": \"NOK\", \"symbol\": \"kr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.750440','2026-04-28 13:34:35.750440',NULL,0,102,'Omani rial','Description for Omani rial','currency','{\"code\": \"OMR\", \"symbol\": \"ر.ع.\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.786227','2026-04-28 13:34:35.786227',NULL,0,103,'Pakistani rupee','Description for Pakistani rupee','currency','{\"code\": \"PKR\", \"symbol\": \"₨\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.812702','2026-04-28 13:34:35.812702',NULL,0,104,'Panamanian balboa','Description for Panamanian balboa','currency','{\"code\": \"PAB\", \"symbol\": \"B/.\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.844398','2026-04-28 13:34:35.844398',NULL,0,105,'Papua New Guinean kina','Description for Papua New Guinean kina','currency','{\"code\": \"PGK\", \"symbol\": \"K\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.876957','2026-04-28 13:34:35.876957',NULL,0,106,'Paraguayan guaraní','Description for Paraguayan guaraní','currency','{\"code\": \"PYG\", \"symbol\": \"₲\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.902413','2026-04-28 13:34:35.902413',NULL,0,107,'Peruvian sol','Description for Peruvian sol','currency','{\"code\": \"PEN\", \"symbol\": \"S/.\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.925797','2026-04-28 13:34:35.925797',NULL,0,108,'Philippine peso','Description for Philippine peso','currency','{\"code\": \"PHP\", \"symbol\": \"₱\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.969132','2026-04-28 13:34:35.969132',NULL,0,109,'Polish złoty','Description for Polish złoty','currency','{\"code\": \"PLN\", \"symbol\": \"zł\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:35.992819','2026-04-28 13:34:35.992819',NULL,0,110,'Qatari riyal','Description for Qatari riyal','currency','{\"code\": \"QAR\", \"symbol\": \"ر.ق\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.019098','2026-04-28 13:34:36.019098',NULL,0,111,'Romanian leu','Description for Romanian leu','currency','{\"code\": \"RON\", \"symbol\": \"lei\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.052800','2026-04-28 13:34:36.052800',NULL,0,112,'Russian ruble','Description for Russian ruble','currency','{\"code\": \"RUB\", \"symbol\": \"₽\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.081138','2026-04-28 13:34:36.081138',NULL,0,113,'Rwandan franc','Description for Rwandan franc','currency','{\"code\": \"RWF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.104585','2026-04-28 13:34:36.104585',NULL,0,114,'Saint Helena pound','Description for Saint Helena pound','currency','{\"code\": \"SHP\", \"symbol\": \"£\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.134388','2026-04-28 13:34:36.134388',NULL,0,115,'Samoan tālā','Description for Samoan tālā','currency','{\"code\": \"WST\", \"symbol\": \"T\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.187604','2026-04-28 13:34:36.187604',NULL,0,116,'Saudi riyal','Description for Saudi riyal','currency','{\"code\": \"SAR\", \"symbol\": \"ر.س\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.209234','2026-04-28 13:34:36.209234',NULL,0,117,'Serbian dinar','Description for Serbian dinar','currency','{\"code\": \"RSD\", \"symbol\": \"дин.\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.221828','2026-04-28 13:34:36.221828',NULL,0,118,'Seychellois rupee','Description for Seychellois rupee','currency','{\"code\": \"SCR\", \"symbol\": \"₨\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.232021','2026-04-28 13:34:36.232021',NULL,0,119,'Sierra Leonean leone','Description for Sierra Leonean leone','currency','{\"code\": \"SLL\", \"symbol\": \"Le\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.241268','2026-04-28 13:34:36.241268',NULL,0,120,'Singapore dollar','Description for Singapore dollar','currency','{\"code\": \"SGD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.250700','2026-04-28 13:34:36.250700',NULL,0,121,'Solomon Islands dollar','Description for Solomon Islands dollar','currency','{\"code\": \"SBD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.260646','2026-04-28 13:34:36.260646',NULL,0,122,'Somali shilling','Description for Somali shilling','currency','{\"code\": \"SOS\", \"symbol\": \"Sh\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.270664','2026-04-28 13:34:36.270664',NULL,0,123,'South African rand','Description for South African rand','currency','{\"code\": \"ZAR\", \"symbol\": \"R\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.282893','2026-04-28 13:34:36.282893',NULL,0,124,'South Korean won','Description for South Korean won','currency','{\"code\": \"KRW\", \"symbol\": \"₩\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.292773','2026-04-28 13:34:36.292773',NULL,0,125,'South Sudanese pound','Description for South Sudanese pound','currency','{\"code\": \"SSP\", \"symbol\": \"£\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.302379','2026-04-28 13:34:36.302379',NULL,0,126,'Sri Lankan rupee','Description for Sri Lankan rupee','currency','{\"code\": \"LKR\", \"symbol\": \"Rs\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.313459','2026-04-28 13:34:36.313459',NULL,0,127,'Sudanese pound','Description for Sudanese pound','currency','{\"code\": \"SDG\", \"symbol\": \"ج.س.\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.335367','2026-04-28 13:34:36.335367',NULL,0,128,'Surinamese dollar','Description for Surinamese dollar','currency','{\"code\": \"SRD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.369538','2026-04-28 13:34:36.369538',NULL,0,129,'Swazi lilangeni','Description for Swazi lilangeni','currency','{\"code\": \"SZL\", \"symbol\": \"L\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.406652','2026-04-28 13:34:36.406652',NULL,0,130,'Swedish krona','Description for Swedish krona','currency','{\"code\": \"SEK\", \"symbol\": \"kr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.430642','2026-04-28 13:34:36.430642',NULL,0,131,'Swiss franc','Description for Swiss franc','currency','{\"code\": \"CHF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.458243','2026-04-28 13:34:36.458243',NULL,0,132,'Syrian pound','Description for Syrian pound','currency','{\"code\": \"SYP\", \"symbol\": \"£\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.480311','2026-04-28 13:34:36.480311',NULL,0,133,'São Tomé and Príncipe dobra','Description for São Tomé and Príncipe dobra','currency','{\"code\": \"STD\", \"symbol\": \"Db\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.513893','2026-04-28 13:34:36.513893',NULL,0,134,'Tajikistani somoni','Description for Tajikistani somoni','currency','{\"code\": \"TJS\", \"symbol\": \"ЅМ\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.557131','2026-04-28 13:34:36.557131',NULL,0,135,'Tanzanian shilling','Description for Tanzanian shilling','currency','{\"code\": \"TZS\", \"symbol\": \"Sh\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.597667','2026-04-28 13:34:36.597667',NULL,0,136,'Thai baht','Description for Thai baht','currency','{\"code\": \"THB\", \"symbol\": \"฿\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.624938','2026-04-28 13:34:36.624938',NULL,0,137,'Tongan paʻanga','Description for Tongan paʻanga','currency','{\"code\": \"TOP\", \"symbol\": \"T$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.660729','2026-04-28 13:34:36.660729',NULL,0,138,'Trinidad and Tobago dollar','Description for Trinidad and Tobago dollar','currency','{\"code\": \"TTD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.677265','2026-04-28 13:34:36.677265',NULL,0,139,'Turkish lira','Description for Turkish lira','currency','{\"code\": \"TRY\", \"symbol\": \"₺\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.693115','2026-04-28 13:34:36.693115',NULL,0,140,'Turkmenistan manat','Description for Turkmenistan manat','currency','{\"code\": \"TMT\", \"symbol\": \"m\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.702324','2026-04-28 13:34:36.702324',NULL,0,141,'Ugandan shilling','Description for Ugandan shilling','currency','{\"code\": \"UGX\", \"symbol\": \"Sh\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.710341','2026-04-28 13:34:36.710341',NULL,0,142,'Ukrainian hryvnia','Description for Ukrainian hryvnia','currency','{\"code\": \"UAH\", \"symbol\": \"₴\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.720804','2026-04-28 13:34:36.720804',NULL,0,143,'United Arab Emirates dirham','Description for United Arab Emirates dirham','currency','{\"code\": \"AED\", \"symbol\": \"د.إ\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.730496','2026-04-28 13:34:36.730496',NULL,0,144,'United States dollar','Description for United States dollar','currency','{\"code\": \"USD\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.744978','2026-04-28 13:34:36.744978',NULL,0,145,'Uruguayan peso','Description for Uruguayan peso','currency','{\"code\": \"UYU\", \"symbol\": \"$\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.754235','2026-04-28 13:34:36.754235',NULL,0,146,'Vanuatu vatu','Description for Vanuatu vatu','currency','{\"code\": \"VUV\", \"symbol\": \"Vt\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.763055','2026-04-28 13:34:36.763055',NULL,0,147,'Venezuelan bolívar','Description for Venezuelan bolívar','currency','{\"code\": \"VEF\", \"symbol\": \"Bs S\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.771655','2026-04-28 13:34:36.771655',NULL,0,148,'Vietnamese đồng','Description for Vietnamese đồng','currency','{\"code\": \"VND\", \"symbol\": \"₫\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.780821','2026-04-28 13:34:36.780821',NULL,0,149,'West African CFA franc','Description for West African CFA franc','currency','{\"code\": \"XOF\", \"symbol\": \"Fr\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.792855','2026-04-28 13:34:36.792855',NULL,0,150,'Yemeni rial','Description for Yemeni rial','currency','{\"code\": \"YER\", \"symbol\": \"﷼\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:36.807520','2026-04-28 13:34:36.807520',NULL,0,151,'Zambian kwacha','Description for Zambian kwacha','currency','{\"code\": \"ZMW\", \"symbol\": \"ZK\", \"digitsAfterComma\": 2}'),('2026-04-28 13:34:58.673683','2026-04-28 13:34:58.673683',NULL,0,152,'Agence ou société commerciale','Description for Agence ou société commerciale','activity','{}'),('2026-04-28 13:34:58.707787','2026-04-28 13:34:58.707787',NULL,0,153,'Agriculture','Description for Agriculture','activity','{}'),('2026-04-28 13:34:58.735124','2026-04-28 13:34:58.735124',NULL,0,154,'Art et design','Description for Art et design','activity','{}'),('2026-04-28 13:34:58.761174','2026-04-28 13:34:58.761174',NULL,0,155,'Industrie automobile','Description for Industrie automobile','activity','{}'),('2026-04-28 13:34:58.837085','2026-04-28 13:34:58.837085',NULL,0,156,'Construction','Description for Construction','activity','{}'),('2026-04-28 13:34:58.855105','2026-04-28 13:34:58.855105',NULL,0,157,'Biens de consommation','Description for Biens de consommation','activity','{}'),('2026-04-28 13:34:58.878518','2026-04-28 13:34:58.878518',NULL,0,158,'Éducation','Description for Éducation','activity','{}'),('2026-04-28 13:34:58.896833','2026-04-28 13:34:58.896833',NULL,0,159,'Ingénierie','Description for Ingénierie','activity','{}'),('2026-04-28 13:34:58.918751','2026-04-28 13:34:58.918751',NULL,0,160,'Divertissement','Description for Divertissement','activity','{}'),('2026-04-28 13:34:58.938277','2026-04-28 13:34:58.938277',NULL,0,161,'Services financiers','Description for Services financiers','activity','{}'),('2026-04-28 13:34:58.952645','2026-04-28 13:34:58.952645',NULL,0,162,'Activités de restauration','Description for Activités de restauration','activity','{}'),('2026-04-28 13:34:58.972123','2026-04-28 13:34:58.972123',NULL,0,163,'Jeux','Description for Jeux','activity','{}'),('2026-04-28 13:34:58.995094','2026-04-28 13:34:58.995094',NULL,0,164,'Fonction publique','Description for Fonction publique','activity','{}'),('2026-04-28 13:34:59.013318','2026-04-28 13:34:59.013318',NULL,0,165,'Services de santé','Description for Services de santé','activity','{}'),('2026-04-28 13:34:59.031244','2026-04-28 13:34:59.031244',NULL,0,166,'Décoration d\'intérieur','Description for Décoration d\'intérieur','activity','{}'),('2026-04-28 13:34:59.050421','2026-04-28 13:34:59.050421',NULL,0,167,'Interne','Description for Interne','activity','{}'),('2026-04-28 13:34:59.066779','2026-04-28 13:34:59.066779',NULL,0,168,'Légal','Description for Légal','activity','{}'),('2026-04-28 13:34:59.084636','2026-04-28 13:34:59.084636',NULL,0,169,'Industrie','Description for Industrie','activity','{}'),('2026-04-28 13:34:59.107073','2026-04-28 13:34:59.107073',NULL,0,170,'Commercialisation','Description for Commercialisation','activity','{}'),('2026-04-28 13:34:59.134569','2026-04-28 13:34:59.134569',NULL,0,171,'Exploitation minière et logistique','Description for Exploitation minière et logistique','activity','{}'),('2026-04-28 13:34:59.172845','2026-04-28 13:34:59.172845',NULL,0,172,'Non lucratif','Description for Non lucratif','activity','{}'),('2026-04-28 13:34:59.193938','2026-04-28 13:34:59.193938',NULL,0,173,'Publication et médias Web','Description for Publication et médias Web','activity','{}'),('2026-04-28 13:34:59.218861','2026-04-28 13:34:59.218861',NULL,0,174,'Vente au détail (e-commerce et hors ligne)','Description for Vente au détail (e-commerce et hors ligne)','activity','{}'),('2026-04-28 13:34:59.246699','2026-04-28 13:34:59.246699',NULL,0,175,'Immobilier','Description for Immobilier','activity','{}'),('2026-04-28 13:34:59.270298','2026-04-28 13:34:59.270298',NULL,0,176,'Service','Description for Service','activity','{}'),('2026-04-28 13:34:59.301961','2026-04-28 13:34:59.301961',NULL,0,177,'Technologie','Description for Technologie','activity','{}'),('2026-04-28 13:34:59.320602','2026-04-28 13:34:59.320602',NULL,0,178,'Télécommunications','Description for Télécommunications','activity','{}'),('2026-04-28 13:34:59.341484','2026-04-28 13:34:59.341484',NULL,0,179,'Tourisme / hôtellerie','Description for Tourisme / hôtellerie','activity','{}'),('2026-04-28 13:34:59.373580','2026-04-28 13:34:59.373580',NULL,0,180,'Création de sites web','Description for Création de sites web','activity','{}'),('2026-04-28 13:34:59.402944','2026-04-28 13:34:59.402944',NULL,0,181,'Développement web','Description for Développement web','activity','{}'),('2026-04-28 13:34:59.432998','2026-04-28 13:34:59.432998',NULL,0,182,'Maroquinerie','Description for Maroquinerie','activity','{}'),('2026-04-28 13:34:59.459539','2026-04-28 13:34:59.459539',NULL,0,183,'Pêche maritime','Description for Pêche maritime','activity','{}'),('2026-04-28 13:35:22.817725','2026-04-28 13:35:22.817725',NULL,0,184,'Frais - Régime forfaitaire','Description for Frais - Régime forfaitaire','tax-withholding','{\"rate\": 10}'),('2026-04-28 13:35:22.829183','2026-04-28 13:35:22.829183',NULL,0,185,'Frais - Régime forfaitaire','Description for Frais - Régime forfaitaire','tax-withholding','{\"rate\": 15}'),('2026-04-28 13:35:22.839608','2026-04-28 13:35:22.839608',NULL,0,186,'Frais - Régime réel','Description for Frais - Régime réel','tax-withholding','{\"rate\": 3}'),('2026-04-28 13:35:22.849662','2026-04-28 13:35:22.849662',NULL,0,187,'Frais - Régime réel','Description for Frais - Régime réel','tax-withholding','{\"rate\": 5}'),('2026-04-28 13:35:22.861524','2026-04-28 13:35:22.861524',NULL,0,188,'Loyer - Frais spéciaux - Société exportation','Description for Loyer - Frais spéciaux - Société exportation','tax-withholding','{\"rate\": 2.5}'),('2026-04-28 13:35:22.875749','2026-04-28 13:35:22.875749',NULL,0,189,'Marché - Frais généraux','Description for Marché - Frais généraux','tax-withholding','{\"rate\": 1}'),('2026-04-28 13:35:22.911729','2026-04-28 13:35:22.911729',NULL,0,190,'Marché - Frais généraux','Description for Marché - Frais généraux','tax-withholding','{\"rate\": 1.5}'),('2026-04-28 13:35:22.963527','2026-04-28 13:35:22.963527',NULL,0,191,'Marché - Frais spéciaux - Société exportation','Description for Marché - Frais spéciaux - Société exportation','tax-withholding','{\"rate\": 0.5}'),('2026-04-28 13:35:23.010886','2026-04-28 13:35:23.010886',NULL,0,192,'Revenus des comptes épargne spéciaux','Description for Revenus des comptes épargne spéciaux','tax-withholding','{\"rate\": 20}'),('2026-04-28 13:35:53.227537','2026-04-28 13:35:53.227537',NULL,0,193,'Payable à réception','Description for Payable à réception','payment-conditions','{}'),('2026-04-28 13:35:53.241293','2026-04-28 13:35:53.241293',NULL,0,194,'Echéance à la fin du mois','Description for Echéance à la fin du mois','payment-conditions','{}'),('2026-04-28 13:35:53.254996','2026-04-28 13:35:53.254996',NULL,0,195,'Echéance à la fin du mois prochain','Description for Echéance à la fin du mois prochain','payment-conditions','{}'),('2026-04-28 13:35:53.270873','2026-04-28 13:35:53.270873',NULL,0,196,'Personnalisé','Description for Personnalisé','payment-conditions','{}'),('2026-04-28 13:36:27.446533','2026-04-28 13:36:27.446533',NULL,0,197,'AF','Description for AF','country','{\"alpha3Code\": \"AFG\"}'),('2026-04-28 13:36:27.460742','2026-04-28 13:36:27.460742',NULL,0,198,'AX','Description for AX','country','{\"alpha3Code\": \"ALA\"}'),('2026-04-28 13:36:27.475294','2026-04-28 13:36:27.475294',NULL,0,199,'AL','Description for AL','country','{\"alpha3Code\": \"ALB\"}'),('2026-04-28 13:36:27.486585','2026-04-28 13:36:27.486585',NULL,0,200,'DZ','Description for DZ','country','{\"alpha3Code\": \"DZA\"}'),('2026-04-28 13:36:27.501851','2026-04-28 13:36:27.501851',NULL,0,201,'AS','Description for AS','country','{\"alpha3Code\": \"ASM\"}'),('2026-04-28 13:36:27.515585','2026-04-28 13:36:27.515585',NULL,0,202,'AD','Description for AD','country','{\"alpha3Code\": \"AND\"}'),('2026-04-28 13:36:27.527496','2026-04-28 13:36:27.527496',NULL,0,203,'AO','Description for AO','country','{\"alpha3Code\": \"AGO\"}'),('2026-04-28 13:36:27.541965','2026-04-28 13:36:27.541965',NULL,0,204,'AI','Description for AI','country','{\"alpha3Code\": \"AIA\"}'),('2026-04-28 13:36:27.554088','2026-04-28 13:36:27.554088',NULL,0,205,'AQ','Description for AQ','country','{\"alpha3Code\": \"ATA\"}'),('2026-04-28 13:36:27.567776','2026-04-28 13:36:27.567776',NULL,0,206,'AG','Description for AG','country','{\"alpha3Code\": \"ATG\"}'),('2026-04-28 13:36:27.578360','2026-04-28 13:36:27.578360',NULL,0,207,'AR','Description for AR','country','{\"alpha3Code\": \"ARG\"}'),('2026-04-28 13:36:27.592444','2026-04-28 13:36:27.592444',NULL,0,208,'AM','Description for AM','country','{\"alpha3Code\": \"ARM\"}'),('2026-04-28 13:36:27.605833','2026-04-28 13:36:27.605833',NULL,0,209,'AW','Description for AW','country','{\"alpha3Code\": \"ABW\"}'),('2026-04-28 13:36:27.619690','2026-04-28 13:36:27.619690',NULL,0,210,'AU','Description for AU','country','{\"alpha3Code\": \"AUS\"}'),('2026-04-28 13:36:27.631902','2026-04-28 13:36:27.631902',NULL,0,211,'AT','Description for AT','country','{\"alpha3Code\": \"AUT\"}'),('2026-04-28 13:36:27.646060','2026-04-28 13:36:27.646060',NULL,0,212,'AZ','Description for AZ','country','{\"alpha3Code\": \"AZE\"}'),('2026-04-28 13:36:27.661471','2026-04-28 13:36:27.661471',NULL,0,213,'BS','Description for BS','country','{\"alpha3Code\": \"BHS\"}'),('2026-04-28 13:36:27.676174','2026-04-28 13:36:27.676174',NULL,0,214,'BH','Description for BH','country','{\"alpha3Code\": \"BHR\"}'),('2026-04-28 13:36:27.693526','2026-04-28 13:36:27.693526',NULL,0,215,'BD','Description for BD','country','{\"alpha3Code\": \"BGD\"}'),('2026-04-28 13:36:27.704228','2026-04-28 13:36:27.704228',NULL,0,216,'BB','Description for BB','country','{\"alpha3Code\": \"BRB\"}'),('2026-04-28 13:36:27.717414','2026-04-28 13:36:27.717414',NULL,0,217,'BY','Description for BY','country','{\"alpha3Code\": \"BLR\"}'),('2026-04-28 13:36:27.728480','2026-04-28 13:36:27.728480',NULL,0,218,'BE','Description for BE','country','{\"alpha3Code\": \"BEL\"}'),('2026-04-28 13:36:27.740682','2026-04-28 13:36:27.740682',NULL,0,219,'BZ','Description for BZ','country','{\"alpha3Code\": \"BLZ\"}'),('2026-04-28 13:36:27.750353','2026-04-28 13:36:27.750353',NULL,0,220,'BJ','Description for BJ','country','{\"alpha3Code\": \"BEN\"}'),('2026-04-28 13:36:27.762076','2026-04-28 13:36:27.762076',NULL,0,221,'BM','Description for BM','country','{\"alpha3Code\": \"BMU\"}'),('2026-04-28 13:36:27.776152','2026-04-28 13:36:27.776152',NULL,0,222,'BT','Description for BT','country','{\"alpha3Code\": \"BTN\"}'),('2026-04-28 13:36:27.786968','2026-04-28 13:36:27.786968',NULL,0,223,'BO','Description for BO','country','{\"alpha3Code\": \"BOL\"}'),('2026-04-28 13:36:27.801475','2026-04-28 13:36:27.801475',NULL,0,224,'BQ','Description for BQ','country','{\"alpha3Code\": \"BES\"}'),('2026-04-28 13:36:27.813889','2026-04-28 13:36:27.813889',NULL,0,225,'BA','Description for BA','country','{\"alpha3Code\": \"BIH\"}'),('2026-04-28 13:36:27.825507','2026-04-28 13:36:27.825507',NULL,0,226,'BW','Description for BW','country','{\"alpha3Code\": \"BWA\"}'),('2026-04-28 13:36:27.842783','2026-04-28 13:36:27.842783',NULL,0,227,'BV','Description for BV','country','{\"alpha3Code\": \"BVT\"}'),('2026-04-28 13:36:27.854749','2026-04-28 13:36:27.854749',NULL,0,228,'BR','Description for BR','country','{\"alpha3Code\": \"BRA\"}'),('2026-04-28 13:36:27.871649','2026-04-28 13:36:27.871649',NULL,0,229,'IO','Description for IO','country','{\"alpha3Code\": \"IOT\"}'),('2026-04-28 13:36:27.885841','2026-04-28 13:36:27.885841',NULL,0,230,'BN','Description for BN','country','{\"alpha3Code\": \"BRN\"}'),('2026-04-28 13:36:27.911774','2026-04-28 13:36:27.911774',NULL,0,231,'BG','Description for BG','country','{\"alpha3Code\": \"BGR\"}'),('2026-04-28 13:36:27.926789','2026-04-28 13:36:27.926789',NULL,0,232,'BF','Description for BF','country','{\"alpha3Code\": \"BFA\"}'),('2026-04-28 13:36:27.943511','2026-04-28 13:36:27.943511',NULL,0,233,'BI','Description for BI','country','{\"alpha3Code\": \"BDI\"}'),('2026-04-28 13:36:27.954522','2026-04-28 13:36:27.954522',NULL,0,234,'CV','Description for CV','country','{\"alpha3Code\": \"CPV\"}'),('2026-04-28 13:36:27.968670','2026-04-28 13:36:27.968670',NULL,0,235,'KH','Description for KH','country','{\"alpha3Code\": \"KHM\"}'),('2026-04-28 13:36:27.981808','2026-04-28 13:36:27.981808',NULL,0,236,'CM','Description for CM','country','{\"alpha3Code\": \"CMR\"}'),('2026-04-28 13:36:27.995642','2026-04-28 13:36:27.995642',NULL,0,237,'CA','Description for CA','country','{\"alpha3Code\": \"CAN\"}'),('2026-04-28 13:36:28.009889','2026-04-28 13:36:28.009889',NULL,0,238,'KY','Description for KY','country','{\"alpha3Code\": \"CYM\"}'),('2026-04-28 13:36:28.032509','2026-04-28 13:36:28.032509',NULL,0,239,'CF','Description for CF','country','{\"alpha3Code\": \"CAF\"}'),('2026-04-28 13:36:28.076670','2026-04-28 13:36:28.076670',NULL,0,240,'TD','Description for TD','country','{\"alpha3Code\": \"TCD\"}'),('2026-04-28 13:36:28.116204','2026-04-28 13:36:28.116204',NULL,0,241,'CL','Description for CL','country','{\"alpha3Code\": \"CHL\"}'),('2026-04-28 13:36:28.173046','2026-04-28 13:36:28.173046',NULL,0,242,'CN','Description for CN','country','{\"alpha3Code\": \"CHN\"}'),('2026-04-28 13:36:28.217559','2026-04-28 13:36:28.217559',NULL,0,243,'CX','Description for CX','country','{\"alpha3Code\": \"CXR\"}'),('2026-04-28 13:36:28.278304','2026-04-28 13:36:28.278304',NULL,0,244,'CC','Description for CC','country','{\"alpha3Code\": \"CCK\"}'),('2026-04-28 13:36:28.294994','2026-04-28 13:36:28.294994',NULL,0,245,'CO','Description for CO','country','{\"alpha3Code\": \"COL\"}'),('2026-04-28 13:36:28.309677','2026-04-28 13:36:28.309677',NULL,0,246,'KM','Description for KM','country','{\"alpha3Code\": \"COM\"}'),('2026-04-28 13:36:28.323892','2026-04-28 13:36:28.323892',NULL,0,247,'CG','Description for CG','country','{\"alpha3Code\": \"COG\"}'),('2026-04-28 13:36:28.339636','2026-04-28 13:36:28.339636',NULL,0,248,'CD','Description for CD','country','{\"alpha3Code\": \"COD\"}'),('2026-04-28 13:36:28.357211','2026-04-28 13:36:28.357211',NULL,0,249,'CK','Description for CK','country','{\"alpha3Code\": \"COK\"}'),('2026-04-28 13:36:28.372562','2026-04-28 13:36:28.372562',NULL,0,250,'CR','Description for CR','country','{\"alpha3Code\": \"CRI\"}'),('2026-04-28 13:36:28.383812','2026-04-28 13:36:28.383812',NULL,0,251,'CI','Description for CI','country','{\"alpha3Code\": \"CIV\"}'),('2026-04-28 13:36:28.396777','2026-04-28 13:36:28.396777',NULL,0,252,'HR','Description for HR','country','{\"alpha3Code\": \"HRV\"}'),('2026-04-28 13:36:28.410312','2026-04-28 13:36:28.410312',NULL,0,253,'CU','Description for CU','country','{\"alpha3Code\": \"CUB\"}'),('2026-04-28 13:36:28.421830','2026-04-28 13:36:28.421830',NULL,0,254,'CW','Description for CW','country','{\"alpha3Code\": \"CUW\"}'),('2026-04-28 13:36:28.434014','2026-04-28 13:36:28.434014',NULL,0,255,'CY','Description for CY','country','{\"alpha3Code\": \"CYP\"}'),('2026-04-28 13:36:28.450940','2026-04-28 13:36:28.450940',NULL,0,256,'CZ','Description for CZ','country','{\"alpha3Code\": \"CZE\"}'),('2026-04-28 13:36:28.463661','2026-04-28 13:36:28.463661',NULL,0,257,'DK','Description for DK','country','{\"alpha3Code\": \"DNK\"}'),('2026-04-28 13:36:28.480021','2026-04-28 13:36:28.480021',NULL,0,258,'DJ','Description for DJ','country','{\"alpha3Code\": \"DJI\"}'),('2026-04-28 13:36:28.497916','2026-04-28 13:36:28.497916',NULL,0,259,'DM','Description for DM','country','{\"alpha3Code\": \"DMA\"}'),('2026-04-28 13:36:28.512881','2026-04-28 13:36:28.512881',NULL,0,260,'DO','Description for DO','country','{\"alpha3Code\": \"DOM\"}'),('2026-04-28 13:36:28.526624','2026-04-28 13:36:28.526624',NULL,0,261,'EC','Description for EC','country','{\"alpha3Code\": \"ECU\"}'),('2026-04-28 13:36:28.537197','2026-04-28 13:36:28.537197',NULL,0,262,'EG','Description for EG','country','{\"alpha3Code\": \"EGY\"}'),('2026-04-28 13:36:28.549766','2026-04-28 13:36:28.549766',NULL,0,263,'SV','Description for SV','country','{\"alpha3Code\": \"SLV\"}'),('2026-04-28 13:36:28.561255','2026-04-28 13:36:28.561255',NULL,0,264,'GQ','Description for GQ','country','{\"alpha3Code\": \"GNQ\"}'),('2026-04-28 13:36:28.571868','2026-04-28 13:36:28.571868',NULL,0,265,'ER','Description for ER','country','{\"alpha3Code\": \"ERI\"}'),('2026-04-28 13:36:28.583839','2026-04-28 13:36:28.583839',NULL,0,266,'EE','Description for EE','country','{\"alpha3Code\": \"EST\"}'),('2026-04-28 13:36:28.594397','2026-04-28 13:36:28.594397',NULL,0,267,'SZ','Description for SZ','country','{\"alpha3Code\": \"SWZ\"}'),('2026-04-28 13:36:28.607007','2026-04-28 13:36:28.607007',NULL,0,268,'ET','Description for ET','country','{\"alpha3Code\": \"ETH\"}'),('2026-04-28 13:36:28.620586','2026-04-28 13:36:28.620586',NULL,0,269,'FK','Description for FK','country','{\"alpha3Code\": \"FLK\"}'),('2026-04-28 13:36:28.635427','2026-04-28 13:36:28.635427',NULL,0,270,'FO','Description for FO','country','{\"alpha3Code\": \"FRO\"}'),('2026-04-28 13:36:28.656488','2026-04-28 13:36:28.656488',NULL,0,271,'FJ','Description for FJ','country','{\"alpha3Code\": \"FJI\"}'),('2026-04-28 13:36:28.676721','2026-04-28 13:36:28.676721',NULL,0,272,'FI','Description for FI','country','{\"alpha3Code\": \"FIN\"}'),('2026-04-28 13:36:28.690721','2026-04-28 13:36:28.690721',NULL,0,273,'FR','Description for FR','country','{\"alpha3Code\": \"FRA\"}'),('2026-04-28 13:36:28.705798','2026-04-28 13:36:28.705798',NULL,0,274,'GF','Description for GF','country','{\"alpha3Code\": \"GUF\"}'),('2026-04-28 13:36:28.718422','2026-04-28 13:36:28.718422',NULL,0,275,'PF','Description for PF','country','{\"alpha3Code\": \"PYF\"}'),('2026-04-28 13:36:28.730150','2026-04-28 13:36:28.730150',NULL,0,276,'TF','Description for TF','country','{\"alpha3Code\": \"ATF\"}'),('2026-04-28 13:36:28.741646','2026-04-28 13:36:28.741646',NULL,0,277,'GA','Description for GA','country','{\"alpha3Code\": \"GAB\"}'),('2026-04-28 13:36:28.753526','2026-04-28 13:36:28.753526',NULL,0,278,'GM','Description for GM','country','{\"alpha3Code\": \"GMB\"}'),('2026-04-28 13:36:28.765709','2026-04-28 13:36:28.765709',NULL,0,279,'GE','Description for GE','country','{\"alpha3Code\": \"GEO\"}'),('2026-04-28 13:36:28.776697','2026-04-28 13:36:28.776697',NULL,0,280,'DE','Description for DE','country','{\"alpha3Code\": \"DEU\"}'),('2026-04-28 13:36:28.787482','2026-04-28 13:36:28.787482',NULL,0,281,'GH','Description for GH','country','{\"alpha3Code\": \"GHA\"}'),('2026-04-28 13:36:28.801721','2026-04-28 13:36:28.801721',NULL,0,282,'GI','Description for GI','country','{\"alpha3Code\": \"GIB\"}'),('2026-04-28 13:36:28.812022','2026-04-28 13:36:28.812022',NULL,0,283,'GR','Description for GR','country','{\"alpha3Code\": \"GRC\"}'),('2026-04-28 13:36:28.831958','2026-04-28 13:36:28.831958',NULL,0,284,'GL','Description for GL','country','{\"alpha3Code\": \"GRL\"}'),('2026-04-28 13:36:28.883758','2026-04-28 13:36:28.883758',NULL,0,285,'GD','Description for GD','country','{\"alpha3Code\": \"GRD\"}'),('2026-04-28 13:36:28.932445','2026-04-28 13:36:28.932445',NULL,0,286,'GP','Description for GP','country','{\"alpha3Code\": \"GLP\"}'),('2026-04-28 13:36:28.985475','2026-04-28 13:36:28.985475',NULL,0,287,'GU','Description for GU','country','{\"alpha3Code\": \"GUM\"}'),('2026-04-28 13:36:29.027223','2026-04-28 13:36:29.027223',NULL,0,288,'GT','Description for GT','country','{\"alpha3Code\": \"GTM\"}'),('2026-04-28 13:36:29.063535','2026-04-28 13:36:29.063535',NULL,0,289,'GG','Description for GG','country','{\"alpha3Code\": \"GGY\"}'),('2026-04-28 13:36:29.082528','2026-04-28 13:36:29.082528',NULL,0,290,'GN','Description for GN','country','{\"alpha3Code\": \"GIN\"}'),('2026-04-28 13:36:29.105620','2026-04-28 13:36:29.105620',NULL,0,291,'GW','Description for GW','country','{\"alpha3Code\": \"GNB\"}'),('2026-04-28 13:36:29.140735','2026-04-28 13:36:29.140735',NULL,0,292,'GY','Description for GY','country','{\"alpha3Code\": \"GUY\"}'),('2026-04-28 13:36:29.166404','2026-04-28 13:36:29.166404',NULL,0,293,'HT','Description for HT','country','{\"alpha3Code\": \"HTI\"}'),('2026-04-28 13:36:29.179480','2026-04-28 13:36:29.179480',NULL,0,294,'HM','Description for HM','country','{\"alpha3Code\": \"HMD\"}'),('2026-04-28 13:36:29.196213','2026-04-28 13:36:29.196213',NULL,0,295,'VA','Description for VA','country','{\"alpha3Code\": \"VAT\"}'),('2026-04-28 13:36:29.211267','2026-04-28 13:36:29.211267',NULL,0,296,'HN','Description for HN','country','{\"alpha3Code\": \"HND\"}'),('2026-04-28 13:36:29.226270','2026-04-28 13:36:29.226270',NULL,0,297,'HK','Description for HK','country','{\"alpha3Code\": \"HKG\"}'),('2026-04-28 13:36:29.240885','2026-04-28 13:36:29.240885',NULL,0,298,'HU','Description for HU','country','{\"alpha3Code\": \"HUN\"}'),('2026-04-28 13:36:29.255794','2026-04-28 13:36:29.255794',NULL,0,299,'IS','Description for IS','country','{\"alpha3Code\": \"ISL\"}'),('2026-04-28 13:36:29.268480','2026-04-28 13:36:29.268480',NULL,0,300,'IN','Description for IN','country','{\"alpha3Code\": \"IND\"}'),('2026-04-28 13:36:29.278787','2026-04-28 13:36:29.278787',NULL,0,301,'ID','Description for ID','country','{\"alpha3Code\": \"IDN\"}'),('2026-04-28 13:36:29.288910','2026-04-28 13:36:29.288910',NULL,0,302,'IR','Description for IR','country','{\"alpha3Code\": \"IRN\"}'),('2026-04-28 13:36:29.304034','2026-04-28 13:36:29.304034',NULL,0,303,'IQ','Description for IQ','country','{\"alpha3Code\": \"IRQ\"}'),('2026-04-28 13:36:29.315703','2026-04-28 13:36:29.315703',NULL,0,304,'IE','Description for IE','country','{\"alpha3Code\": \"IRL\"}'),('2026-04-28 13:36:29.328483','2026-04-28 13:36:29.328483',NULL,0,305,'IM','Description for IM','country','{\"alpha3Code\": \"IMN\"}'),('2026-04-28 13:36:29.346403','2026-04-28 13:36:29.346403',NULL,0,306,'IL','Description for IL','country','{\"alpha3Code\": \"ISR\"}'),('2026-04-28 13:36:29.362065','2026-04-28 13:36:29.362065',NULL,0,307,'IT','Description for IT','country','{\"alpha3Code\": \"ITA\"}'),('2026-04-28 13:36:29.380516','2026-04-28 13:36:29.380516',NULL,0,308,'JM','Description for JM','country','{\"alpha3Code\": \"JAM\"}'),('2026-04-28 13:36:29.399022','2026-04-28 13:36:29.399022',NULL,0,309,'JP','Description for JP','country','{\"alpha3Code\": \"JPN\"}'),('2026-04-28 13:36:29.415734','2026-04-28 13:36:29.415734',NULL,0,310,'JE','Description for JE','country','{\"alpha3Code\": \"JEY\"}'),('2026-04-28 13:36:29.430050','2026-04-28 13:36:29.430050',NULL,0,311,'JO','Description for JO','country','{\"alpha3Code\": \"JOR\"}'),('2026-04-28 13:36:29.462372','2026-04-28 13:36:29.462372',NULL,0,312,'KZ','Description for KZ','country','{\"alpha3Code\": \"KAZ\"}'),('2026-04-28 13:36:29.485252','2026-04-28 13:36:29.485252',NULL,0,313,'KE','Description for KE','country','{\"alpha3Code\": \"KEN\"}'),('2026-04-28 13:36:29.498343','2026-04-28 13:36:29.498343',NULL,0,314,'KI','Description for KI','country','{\"alpha3Code\": \"KIR\"}'),('2026-04-28 13:36:29.516285','2026-04-28 13:36:29.516285',NULL,0,315,'KP','Description for KP','country','{\"alpha3Code\": \"PRK\"}'),('2026-04-28 13:36:29.529856','2026-04-28 13:36:29.529856',NULL,0,316,'KR','Description for KR','country','{\"alpha3Code\": \"KOR\"}'),('2026-04-28 13:36:29.541087','2026-04-28 13:36:29.541087',NULL,0,317,'KW','Description for KW','country','{\"alpha3Code\": \"KWT\"}'),('2026-04-28 13:36:29.551059','2026-04-28 13:36:29.551059',NULL,0,318,'KG','Description for KG','country','{\"alpha3Code\": \"KGZ\"}'),('2026-04-28 13:36:29.568635','2026-04-28 13:36:29.568635',NULL,0,319,'LA','Description for LA','country','{\"alpha3Code\": \"LAO\"}'),('2026-04-28 13:36:29.580421','2026-04-28 13:36:29.580421',NULL,0,320,'LV','Description for LV','country','{\"alpha3Code\": \"LVA\"}'),('2026-04-28 13:36:29.593270','2026-04-28 13:36:29.593270',NULL,0,321,'LB','Description for LB','country','{\"alpha3Code\": \"LBN\"}'),('2026-04-28 13:36:29.604230','2026-04-28 13:36:29.604230',NULL,0,322,'LS','Description for LS','country','{\"alpha3Code\": \"LSO\"}'),('2026-04-28 13:36:29.615184','2026-04-28 13:36:29.615184',NULL,0,323,'LR','Description for LR','country','{\"alpha3Code\": \"LBR\"}'),('2026-04-28 13:36:29.627744','2026-04-28 13:36:29.627744',NULL,0,324,'LY','Description for LY','country','{\"alpha3Code\": \"LBY\"}'),('2026-04-28 13:36:29.641678','2026-04-28 13:36:29.641678',NULL,0,325,'LI','Description for LI','country','{\"alpha3Code\": \"LIE\"}'),('2026-04-28 13:36:29.652948','2026-04-28 13:36:29.652948',NULL,0,326,'LT','Description for LT','country','{\"alpha3Code\": \"LTU\"}'),('2026-04-28 13:36:29.663837','2026-04-28 13:36:29.663837',NULL,0,327,'LU','Description for LU','country','{\"alpha3Code\": \"LUX\"}'),('2026-04-28 13:36:29.673581','2026-04-28 13:36:29.673581',NULL,0,328,'MO','Description for MO','country','{\"alpha3Code\": \"MAC\"}'),('2026-04-28 13:36:29.684206','2026-04-28 13:36:29.684206',NULL,0,329,'MG','Description for MG','country','{\"alpha3Code\": \"MDG\"}'),('2026-04-28 13:36:29.696010','2026-04-28 13:36:29.696010',NULL,0,330,'MW','Description for MW','country','{\"alpha3Code\": \"MWI\"}'),('2026-04-28 13:36:29.711551','2026-04-28 13:36:29.711551',NULL,0,331,'MY','Description for MY','country','{\"alpha3Code\": \"MYS\"}'),('2026-04-28 13:36:29.723591','2026-04-28 13:36:29.723591',NULL,0,332,'MV','Description for MV','country','{\"alpha3Code\": \"MDV\"}'),('2026-04-28 13:36:29.742453','2026-04-28 13:36:29.742453',NULL,0,333,'ML','Description for ML','country','{\"alpha3Code\": \"MLI\"}'),('2026-04-28 13:36:29.760048','2026-04-28 13:36:29.760048',NULL,0,334,'MT','Description for MT','country','{\"alpha3Code\": \"MLT\"}'),('2026-04-28 13:36:29.771050','2026-04-28 13:36:29.771050',NULL,0,335,'MH','Description for MH','country','{\"alpha3Code\": \"MHL\"}'),('2026-04-28 13:36:29.786516','2026-04-28 13:36:29.786516',NULL,0,336,'MQ','Description for MQ','country','{\"alpha3Code\": \"MTQ\"}'),('2026-04-28 13:36:29.799348','2026-04-28 13:36:29.799348',NULL,0,337,'MR','Description for MR','country','{\"alpha3Code\": \"MRT\"}'),('2026-04-28 13:36:29.812299','2026-04-28 13:36:29.812299',NULL,0,338,'MU','Description for MU','country','{\"alpha3Code\": \"MUS\"}'),('2026-04-28 13:36:29.825404','2026-04-28 13:36:29.825404',NULL,0,339,'YT','Description for YT','country','{\"alpha3Code\": \"MYT\"}'),('2026-04-28 13:36:29.838268','2026-04-28 13:36:29.838268',NULL,0,340,'MX','Description for MX','country','{\"alpha3Code\": \"MEX\"}'),('2026-04-28 13:36:29.852012','2026-04-28 13:36:29.852012',NULL,0,341,'FM','Description for FM','country','{\"alpha3Code\": \"FSM\"}'),('2026-04-28 13:36:29.863547','2026-04-28 13:36:29.863547',NULL,0,342,'MD','Description for MD','country','{\"alpha3Code\": \"MDA\"}'),('2026-04-28 13:36:29.877500','2026-04-28 13:36:29.877500',NULL,0,343,'MC','Description for MC','country','{\"alpha3Code\": \"MCO\"}'),('2026-04-28 13:36:29.888819','2026-04-28 13:36:29.888819',NULL,0,344,'MN','Description for MN','country','{\"alpha3Code\": \"MNG\"}'),('2026-04-28 13:36:29.901812','2026-04-28 13:36:29.901812',NULL,0,345,'ME','Description for ME','country','{\"alpha3Code\": \"MNE\"}'),('2026-04-28 13:36:29.912828','2026-04-28 13:36:29.912828',NULL,0,346,'MS','Description for MS','country','{\"alpha3Code\": \"MSR\"}'),('2026-04-28 13:36:29.923548','2026-04-28 13:36:29.923548',NULL,0,347,'MA','Description for MA','country','{\"alpha3Code\": \"MAR\"}'),('2026-04-28 13:36:29.939300','2026-04-28 13:36:29.939300',NULL,0,348,'MZ','Description for MZ','country','{\"alpha3Code\": \"MOZ\"}'),('2026-04-28 13:36:29.953499','2026-04-28 13:36:29.953499',NULL,0,349,'MM','Description for MM','country','{\"alpha3Code\": \"MMR\"}'),('2026-04-28 13:36:29.967731','2026-04-28 13:36:29.967731',NULL,0,350,'NA','Description for NA','country','{\"alpha3Code\": \"NAM\"}'),('2026-04-28 13:36:29.983707','2026-04-28 13:36:29.983707',NULL,0,351,'NR','Description for NR','country','{\"alpha3Code\": \"NRU\"}'),('2026-04-28 13:36:29.995463','2026-04-28 13:36:29.995463',NULL,0,352,'NP','Description for NP','country','{\"alpha3Code\": \"NPL\"}'),('2026-04-28 13:36:30.009344','2026-04-28 13:36:30.009344',NULL,0,353,'NL','Description for NL','country','{\"alpha3Code\": \"NLD\"}'),('2026-04-28 13:36:30.020256','2026-04-28 13:36:30.020256',NULL,0,354,'NC','Description for NC','country','{\"alpha3Code\": \"NCL\"}'),('2026-04-28 13:36:30.034573','2026-04-28 13:36:30.034573',NULL,0,355,'NZ','Description for NZ','country','{\"alpha3Code\": \"NZL\"}'),('2026-04-28 13:36:30.047177','2026-04-28 13:36:30.047177',NULL,0,356,'NI','Description for NI','country','{\"alpha3Code\": \"NIC\"}'),('2026-04-28 13:36:30.059715','2026-04-28 13:36:30.059715',NULL,0,357,'NE','Description for NE','country','{\"alpha3Code\": \"NER\"}'),('2026-04-28 13:36:30.071187','2026-04-28 13:36:30.071187',NULL,0,358,'NG','Description for NG','country','{\"alpha3Code\": \"NGA\"}'),('2026-04-28 13:36:30.082929','2026-04-28 13:36:30.082929',NULL,0,359,'NU','Description for NU','country','{\"alpha3Code\": \"NIU\"}'),('2026-04-28 13:36:30.095797','2026-04-28 13:36:30.095797',NULL,0,360,'NF','Description for NF','country','{\"alpha3Code\": \"NFK\"}'),('2026-04-28 13:36:30.107228','2026-04-28 13:36:30.107228',NULL,0,361,'MK','Description for MK','country','{\"alpha3Code\": \"MKD\"}'),('2026-04-28 13:36:30.119221','2026-04-28 13:36:30.119221',NULL,0,362,'MP','Description for MP','country','{\"alpha3Code\": \"MNP\"}'),('2026-04-28 13:36:30.133449','2026-04-28 13:36:30.133449',NULL,0,363,'NO','Description for NO','country','{\"alpha3Code\": \"NOR\"}'),('2026-04-28 13:36:30.147800','2026-04-28 13:36:30.147800',NULL,0,364,'OM','Description for OM','country','{\"alpha3Code\": \"OMN\"}'),('2026-04-28 13:36:30.162073','2026-04-28 13:36:30.162073',NULL,0,365,'PK','Description for PK','country','{\"alpha3Code\": \"PAK\"}'),('2026-04-28 13:36:30.176249','2026-04-28 13:36:30.176249',NULL,0,366,'PW','Description for PW','country','{\"alpha3Code\": \"PLW\"}'),('2026-04-28 13:36:30.187669','2026-04-28 13:36:30.187669',NULL,0,367,'PS','Description for PS','country','{\"alpha3Code\": \"PSE\"}'),('2026-04-28 13:36:30.203105','2026-04-28 13:36:30.203105',NULL,0,368,'PA','Description for PA','country','{\"alpha3Code\": \"PAN\"}'),('2026-04-28 13:36:30.216154','2026-04-28 13:36:30.216154',NULL,0,369,'PG','Description for PG','country','{\"alpha3Code\": \"PNG\"}'),('2026-04-28 13:36:30.230531','2026-04-28 13:36:30.230531',NULL,0,370,'PY','Description for PY','country','{\"alpha3Code\": \"PRY\"}'),('2026-04-28 13:36:30.248986','2026-04-28 13:36:30.248986',NULL,0,371,'PE','Description for PE','country','{\"alpha3Code\": \"PER\"}'),('2026-04-28 13:36:30.265710','2026-04-28 13:36:30.265710',NULL,0,372,'PH','Description for PH','country','{\"alpha3Code\": \"PHL\"}'),('2026-04-28 13:36:30.280018','2026-04-28 13:36:30.280018',NULL,0,373,'PN','Description for PN','country','{\"alpha3Code\": \"PCN\"}'),('2026-04-28 13:36:30.295741','2026-04-28 13:36:30.295741',NULL,0,374,'PL','Description for PL','country','{\"alpha3Code\": \"POL\"}'),('2026-04-28 13:36:30.311900','2026-04-28 13:36:30.311900',NULL,0,375,'PT','Description for PT','country','{\"alpha3Code\": \"PRT\"}'),('2026-04-28 13:36:30.332204','2026-04-28 13:36:30.332204',NULL,0,376,'PR','Description for PR','country','{\"alpha3Code\": \"PRI\"}'),('2026-04-28 13:36:30.359674','2026-04-28 13:36:30.359674',NULL,0,377,'QA','Description for QA','country','{\"alpha3Code\": \"QAT\"}'),('2026-04-28 13:36:30.385497','2026-04-28 13:36:30.385497',NULL,0,378,'RE','Description for RE','country','{\"alpha3Code\": \"REU\"}'),('2026-04-28 13:36:30.414679','2026-04-28 13:36:30.414679',NULL,0,379,'RO','Description for RO','country','{\"alpha3Code\": \"ROU\"}'),('2026-04-28 13:36:30.438631','2026-04-28 13:36:30.438631',NULL,0,380,'RU','Description for RU','country','{\"alpha3Code\": \"RUS\"}'),('2026-04-28 13:36:30.468425','2026-04-28 13:36:30.468425',NULL,0,381,'RW','Description for RW','country','{\"alpha3Code\": \"RWA\"}'),('2026-04-28 13:36:30.485954','2026-04-28 13:36:30.485954',NULL,0,382,'BL','Description for BL','country','{\"alpha3Code\": \"BLM\"}'),('2026-04-28 13:36:30.514728','2026-04-28 13:36:30.514728',NULL,0,383,'SH','Description for SH','country','{\"alpha3Code\": \"SHN\"}'),('2026-04-28 13:36:30.533861','2026-04-28 13:36:30.533861',NULL,0,384,'KN','Description for KN','country','{\"alpha3Code\": \"KNA\"}'),('2026-04-28 13:36:30.553187','2026-04-28 13:36:30.553187',NULL,0,385,'LC','Description for LC','country','{\"alpha3Code\": \"LCA\"}'),('2026-04-28 13:36:30.578410','2026-04-28 13:36:30.578410',NULL,0,386,'MF','Description for MF','country','{\"alpha3Code\": \"MAF\"}'),('2026-04-28 13:36:30.620374','2026-04-28 13:36:30.620374',NULL,0,387,'PM','Description for PM','country','{\"alpha3Code\": \"SPM\"}'),('2026-04-28 13:36:30.636319','2026-04-28 13:36:30.636319',NULL,0,388,'VC','Description for VC','country','{\"alpha3Code\": \"VCT\"}'),('2026-04-28 13:36:30.653131','2026-04-28 13:36:30.653131',NULL,0,389,'WS','Description for WS','country','{\"alpha3Code\": \"WSM\"}'),('2026-04-28 13:36:30.672702','2026-04-28 13:36:30.672702',NULL,0,390,'SM','Description for SM','country','{\"alpha3Code\": \"SMR\"}'),('2026-04-28 13:36:30.686508','2026-04-28 13:36:30.686508',NULL,0,391,'ST','Description for ST','country','{\"alpha3Code\": \"STP\"}'),('2026-04-28 13:36:30.702502','2026-04-28 13:36:30.702502',NULL,0,392,'SA','Description for SA','country','{\"alpha3Code\": \"SAU\"}'),('2026-04-28 13:36:30.719738','2026-04-28 13:36:30.719738',NULL,0,393,'SN','Description for SN','country','{\"alpha3Code\": \"SEN\"}'),('2026-04-28 13:36:30.736184','2026-04-28 13:36:30.736184',NULL,0,394,'RS','Description for RS','country','{\"alpha3Code\": \"SRB\"}'),('2026-04-28 13:36:30.758213','2026-04-28 13:36:30.758213',NULL,0,395,'SC','Description for SC','country','{\"alpha3Code\": \"SYC\"}'),('2026-04-28 13:36:30.779453','2026-04-28 13:36:30.779453',NULL,0,396,'SL','Description for SL','country','{\"alpha3Code\": \"SLE\"}'),('2026-04-28 13:36:30.797410','2026-04-28 13:36:30.797410',NULL,0,397,'SG','Description for SG','country','{\"alpha3Code\": \"SGP\"}'),('2026-04-28 13:36:30.815110','2026-04-28 13:36:30.815110',NULL,0,398,'SX','Description for SX','country','{\"alpha3Code\": \"SXM\"}'),('2026-04-28 13:36:30.828286','2026-04-28 13:36:30.828286',NULL,0,399,'SK','Description for SK','country','{\"alpha3Code\": \"SVK\"}'),('2026-04-28 13:36:30.840166','2026-04-28 13:36:30.840166',NULL,0,400,'SI','Description for SI','country','{\"alpha3Code\": \"SVN\"}'),('2026-04-28 13:36:30.853254','2026-04-28 13:36:30.853254',NULL,0,401,'SB','Description for SB','country','{\"alpha3Code\": \"SLB\"}'),('2026-04-28 13:36:30.868060','2026-04-28 13:36:30.868060',NULL,0,402,'SO','Description for SO','country','{\"alpha3Code\": \"SOM\"}'),('2026-04-28 13:36:30.883472','2026-04-28 13:36:30.883472',NULL,0,403,'ZA','Description for ZA','country','{\"alpha3Code\": \"ZAF\"}'),('2026-04-28 13:36:30.897845','2026-04-28 13:36:30.897845',NULL,0,404,'GS','Description for GS','country','{\"alpha3Code\": \"SGS\"}'),('2026-04-28 13:36:30.912518','2026-04-28 13:36:30.912518',NULL,0,405,'SS','Description for SS','country','{\"alpha3Code\": \"SSD\"}'),('2026-04-28 13:36:30.935124','2026-04-28 13:36:30.935124',NULL,0,406,'ES','Description for ES','country','{\"alpha3Code\": \"ESP\"}'),('2026-04-28 13:36:30.951480','2026-04-28 13:36:30.951480',NULL,0,407,'LK','Description for LK','country','{\"alpha3Code\": \"LKA\"}'),('2026-04-28 13:36:30.966572','2026-04-28 13:36:30.966572',NULL,0,408,'SD','Description for SD','country','{\"alpha3Code\": \"SDN\"}'),('2026-04-28 13:36:30.979611','2026-04-28 13:36:30.979611',NULL,0,409,'SR','Description for SR','country','{\"alpha3Code\": \"SUR\"}'),('2026-04-28 13:36:30.998526','2026-04-28 13:36:30.998526',NULL,0,410,'SJ','Description for SJ','country','{\"alpha3Code\": \"SJM\"}'),('2026-04-28 13:36:31.014042','2026-04-28 13:36:31.014042',NULL,0,411,'SE','Description for SE','country','{\"alpha3Code\": \"SWE\"}'),('2026-04-28 13:36:31.029579','2026-04-28 13:36:31.029579',NULL,0,412,'CH','Description for CH','country','{\"alpha3Code\": \"CHE\"}'),('2026-04-28 13:36:31.046353','2026-04-28 13:36:31.046353',NULL,0,413,'SY','Description for SY','country','{\"alpha3Code\": \"SYR\"}'),('2026-04-28 13:36:31.060943','2026-04-28 13:36:31.060943',NULL,0,414,'TW','Description for TW','country','{\"alpha3Code\": \"TWN\"}'),('2026-04-28 13:36:31.075650','2026-04-28 13:36:31.075650',NULL,0,415,'TJ','Description for TJ','country','{\"alpha3Code\": \"TJK\"}'),('2026-04-28 13:36:31.088818','2026-04-28 13:36:31.088818',NULL,0,416,'TZ','Description for TZ','country','{\"alpha3Code\": \"TZA\"}'),('2026-04-28 13:36:31.101807','2026-04-28 13:36:31.101807',NULL,0,417,'TH','Description for TH','country','{\"alpha3Code\": \"THA\"}'),('2026-04-28 13:36:31.114366','2026-04-28 13:36:31.114366',NULL,0,418,'TL','Description for TL','country','{\"alpha3Code\": \"TLS\"}'),('2026-04-28 13:36:31.125929','2026-04-28 13:36:31.125929',NULL,0,419,'TG','Description for TG','country','{\"alpha3Code\": \"TGO\"}'),('2026-04-28 13:36:31.139191','2026-04-28 13:36:31.139191',NULL,0,420,'TK','Description for TK','country','{\"alpha3Code\": \"TKL\"}'),('2026-04-28 13:36:31.152442','2026-04-28 13:36:31.152442',NULL,0,421,'TO','Description for TO','country','{\"alpha3Code\": \"TON\"}'),('2026-04-28 13:36:31.166618','2026-04-28 13:36:31.166618',NULL,0,422,'TT','Description for TT','country','{\"alpha3Code\": \"TTO\"}'),('2026-04-28 13:36:31.181322','2026-04-28 13:36:31.181322',NULL,0,423,'TN','Description for TN','country','{\"alpha3Code\": \"TUN\"}'),('2026-04-28 13:36:31.197011','2026-04-28 13:36:31.197011',NULL,0,424,'TR','Description for TR','country','{\"alpha3Code\": \"TUR\"}'),('2026-04-28 13:36:31.211232','2026-04-28 13:36:31.211232',NULL,0,425,'TM','Description for TM','country','{\"alpha3Code\": \"TKM\"}'),('2026-04-28 13:36:31.221651','2026-04-28 13:36:31.221651',NULL,0,426,'TC','Description for TC','country','{\"alpha3Code\": \"TCA\"}'),('2026-04-28 13:36:31.232689','2026-04-28 13:36:31.232689',NULL,0,427,'TV','Description for TV','country','{\"alpha3Code\": \"TUV\"}'),('2026-04-28 13:36:31.241685','2026-04-28 13:36:31.241685',NULL,0,428,'UG','Description for UG','country','{\"alpha3Code\": \"UGA\"}'),('2026-04-28 13:36:31.252182','2026-04-28 13:36:31.252182',NULL,0,429,'UA','Description for UA','country','{\"alpha3Code\": \"UKR\"}'),('2026-04-28 13:36:31.263149','2026-04-28 13:36:31.263149',NULL,0,430,'AE','Description for AE','country','{\"alpha3Code\": \"ARE\"}'),('2026-04-28 13:36:31.273966','2026-04-28 13:36:31.273966',NULL,0,431,'GB','Description for GB','country','{\"alpha3Code\": \"GBR\"}'),('2026-04-28 13:36:31.283648','2026-04-28 13:36:31.283648',NULL,0,432,'US','Description for US','country','{\"alpha3Code\": \"USA\"}'),('2026-04-28 13:36:31.293869','2026-04-28 13:36:31.293869',NULL,0,433,'UM','Description for UM','country','{\"alpha3Code\": \"UMI\"}'),('2026-04-28 13:36:31.302873','2026-04-28 13:36:31.302873',NULL,0,434,'UY','Description for UY','country','{\"alpha3Code\": \"URY\"}'),('2026-04-28 13:36:31.312576','2026-04-28 13:36:31.312576',NULL,0,435,'UZ','Description for UZ','country','{\"alpha3Code\": \"UZB\"}'),('2026-04-28 13:36:31.322064','2026-04-28 13:36:31.322064',NULL,0,436,'VU','Description for VU','country','{\"alpha3Code\": \"VUT\"}'),('2026-04-28 13:36:31.334448','2026-04-28 13:36:31.334448',NULL,0,437,'VE','Description for VE','country','{\"alpha3Code\": \"VEN\"}'),('2026-04-28 13:36:31.347427','2026-04-28 13:36:31.347427',NULL,0,438,'VN','Description for VN','country','{\"alpha3Code\": \"VNM\"}'),('2026-04-28 13:36:31.368858','2026-04-28 13:36:31.368858',NULL,0,439,'VG','Description for VG','country','{\"alpha3Code\": \"VGB\"}'),('2026-04-28 13:36:31.387413','2026-04-28 13:36:31.387413',NULL,0,440,'VI','Description for VI','country','{\"alpha3Code\": \"VIR\"}'),('2026-04-28 13:36:31.420892','2026-04-28 13:36:31.420892',NULL,0,441,'WF','Description for WF','country','{\"alpha3Code\": \"WLF\"}'),('2026-04-28 13:36:31.443653','2026-04-28 13:36:31.443653',NULL,0,442,'EH','Description for EH','country','{\"alpha3Code\": \"ESH\"}'),('2026-04-28 13:36:31.461046','2026-04-28 13:36:31.461046',NULL,0,443,'YE','Description for YE','country','{\"alpha3Code\": \"YEM\"}'),('2026-04-28 13:36:31.486012','2026-04-28 13:36:31.486012',NULL,0,444,'ZM','Description for ZM','country','{\"alpha3Code\": \"ZMB\"}'),('2026-04-28 13:36:31.508195','2026-04-28 13:36:31.508195',NULL,0,445,'ZW','Description for ZW','country','{\"alpha3Code\": \"ZWE\"}');
/*!40000 ALTER TABLE `ref-param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref-type`
--

DROP TABLE IF EXISTS `ref-type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref-type` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `parentId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_b97283beab082b5b015af4be4a` (`label`),
  KEY `FK_d412cdb2bb90bbc2fc9adaf017a` (`parentId`),
  CONSTRAINT `FK_d412cdb2bb90bbc2fc9adaf017a` FOREIGN KEY (`parentId`) REFERENCES `ref-type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref-type`
--

LOCK TABLES `ref-type` WRITE;
/*!40000 ALTER TABLE `ref-type` DISABLE KEYS */;
INSERT INTO `ref-type` VALUES ('2026-04-28 13:34:58.608481','2026-04-28 13:34:58.608481',NULL,0,'activity','Activity','Parent reference type for all activities',NULL),('2026-04-28 13:36:27.402388','2026-04-28 13:36:27.402388',NULL,0,'country','Country','Parent reference type for all countries',NULL),('2026-04-28 13:34:33.716861','2026-04-28 13:34:33.716861',NULL,0,'currency','Currency','Parent reference type for all currencies',NULL),('2026-04-28 13:35:53.203044','2026-04-28 13:35:53.203044',NULL,0,'payment-conditions','Payment Conditions','Parent reference type for all payment conditions',NULL),('2026-04-28 13:35:22.800937','2026-04-28 13:35:22.800937',NULL,0,'tax-withholding','Tax Withholding','Parent reference type for all tax withholding',NULL);
/*!40000 ALTER TABLE `ref-type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `roleId` varchar(255) NOT NULL,
  `permissionId` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_b4599f8b8f548d35850afa2d12c` (`roleId`),
  KEY `FK_06792d0c62ce6b0203c03643cdd` (`permissionId`),
  CONSTRAINT `FK_06792d0c62ce6b0203c03643cdd` FOREIGN KEY (`permissionId`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_b4599f8b8f548d35850afa2d12c` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
INSERT INTO `role_permissions` VALUES ('2026-03-04 08:05:25.222268','2026-03-04 08:05:25.222268',NULL,0,1,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','create-invoice'),('2026-03-04 08:05:25.231658','2026-03-04 08:05:25.231658',NULL,0,2,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','create-payment'),('2026-03-04 08:05:25.235060','2026-03-04 08:05:25.235060',NULL,0,3,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','create-profile'),('2026-03-04 08:05:25.239827','2026-03-04 08:05:25.239827',NULL,0,4,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','create-quotation'),('2026-03-04 08:05:25.244510','2026-03-04 08:05:25.244510',NULL,0,5,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','create-role'),('2026-03-04 08:05:25.247633','2026-03-04 08:05:25.247633',NULL,0,6,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','create-template'),('2026-03-04 08:05:25.250665','2026-03-04 08:05:25.250665',NULL,0,7,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','create-user'),('2026-03-04 08:05:25.253445','2026-03-04 08:05:25.253445',NULL,0,8,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','delete-invoice'),('2026-03-04 08:05:25.258155','2026-03-04 08:05:25.258155',NULL,0,9,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','delete-payment'),('2026-03-04 08:05:25.260568','2026-03-04 08:05:25.260568',NULL,0,10,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','delete-profile'),('2026-03-04 08:05:25.264379','2026-03-04 08:05:25.264379',NULL,0,11,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','delete-quotation'),('2026-03-04 08:05:25.268592','2026-03-04 08:05:25.268592',NULL,0,12,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','delete-role'),('2026-03-04 08:05:25.272118','2026-03-04 08:05:25.272118',NULL,0,13,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','delete-template'),('2026-03-04 08:05:25.275036','2026-03-04 08:05:25.275036',NULL,0,14,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','delete-user'),('2026-03-04 08:05:25.277754','2026-03-04 08:05:25.277754',NULL,0,15,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','read-invoice'),('2026-03-04 08:05:25.279995','2026-03-04 08:05:25.279995',NULL,0,16,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','read-payment'),('2026-03-04 08:05:25.282011','2026-03-04 08:05:25.282011',NULL,0,17,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','read-profile'),('2026-03-04 08:05:25.284264','2026-03-04 08:05:25.284264',NULL,0,18,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','read-quotation'),('2026-03-04 08:05:25.286212','2026-03-04 08:05:25.286212',NULL,0,19,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','read-role'),('2026-03-04 08:05:25.289423','2026-03-04 08:05:25.289423',NULL,0,20,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','read-template'),('2026-03-04 08:05:25.291185','2026-03-04 08:05:25.291185',NULL,0,21,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','read-user'),('2026-03-04 08:05:25.292877','2026-03-04 08:05:25.292877',NULL,0,22,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','update-invoice'),('2026-03-04 08:05:25.294789','2026-03-04 08:05:25.294789',NULL,0,23,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','update-payment'),('2026-03-04 08:05:25.297010','2026-03-04 08:05:25.297010',NULL,0,24,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','update-profile'),('2026-03-04 08:05:25.298824','2026-03-04 08:05:25.298824',NULL,0,25,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','update-quotation'),('2026-03-04 08:05:25.300958','2026-03-04 08:05:25.300958',NULL,0,26,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','update-role'),('2026-03-04 08:05:25.302740','2026-03-04 08:05:25.302740',NULL,0,27,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','update-template'),('2026-03-04 08:05:25.304463','2026-03-04 08:05:25.304463',NULL,0,28,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','update-user');
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` varchar(36) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_54dfc4a418c052c458703ae7d8` (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES ('2026-03-04 08:05:25.209995','2026-03-04 08:05:25.209995',NULL,0,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70','admin','This role is for admin users'),('2026-03-04 08:05:25.211452','2026-03-04 08:05:25.211452',NULL,0,'f59db60f-0e6a-47fa-87b2-68d8bda92a5d','standard-user','This role is for standard users');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequences` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `prefix` varchar(3) DEFAULT NULL,
  `dateFormat` enum('YYYY','YYMM','YYYYMM') NOT NULL DEFAULT 'YYYY',
  `next` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_9de8fcc70bfcb893b6d6df44b9` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
INSERT INTO `sequences` VALUES ('2026-05-08 14:33:28.951936','2026-05-08 14:33:28.951936',NULL,0,1,'INVOICE','INV','YYYY',1),('2026-05-08 14:33:28.955305','2026-05-08 14:33:28.955305',NULL,0,2,'QUOTATION','QUO','YYYY',1);
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage`
--

DROP TABLE IF EXISTS `storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(1024) NOT NULL,
  `filename` varchar(1024) NOT NULL,
  `relativePath` text NOT NULL,
  `mimeType` varchar(255) NOT NULL,
  `size` int NOT NULL,
  `isTemporary` tinyint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage`
--

LOCK TABLES `storage` WRITE;
/*!40000 ALTER TABLE `storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `value` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax`
--

DROP TABLE IF EXISTS `tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `isSpecial` tinyint NOT NULL DEFAULT '0',
  `value` float DEFAULT NULL,
  `isRate` tinyint NOT NULL DEFAULT '1',
  `currencyId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_6d84c7a3af30bb39cb5058bb833` (`currencyId`),
  CONSTRAINT `FK_6d84c7a3af30bb39cb5058bb833` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax`
--

LOCK TABLES `tax` WRITE;
/*!40000 ALTER TABLE `tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax-rates`
--

DROP TABLE IF EXISTS `tax-rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax-rates` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `value` float NOT NULL,
  `type` enum('rate','fixed') NOT NULL DEFAULT 'rate',
  `special` tinyint NOT NULL DEFAULT '0',
  `currencyId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_d1fbc433d5daf707de7fbc727ee` (`currencyId`),
  CONSTRAINT `FK_d1fbc433d5daf707de7fbc727ee` FOREIGN KEY (`currencyId`) REFERENCES `ref-param` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax-rates`
--

LOCK TABLES `tax-rates` WRITE;
/*!40000 ALTER TABLE `tax-rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax-rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax-withholding`
--

DROP TABLE IF EXISTS `tax-withholding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax-withholding` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `rate` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax-withholding`
--

LOCK TABLES `tax-withholding` WRITE;
/*!40000 ALTER TABLE `tax-withholding` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax-withholding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template-category`
--

DROP TABLE IF EXISTS `template-category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `template-category` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template-category`
--

LOCK TABLES `template-category` WRITE;
/*!40000 ALTER TABLE `template-category` DISABLE KEYS */;
/*!40000 ALTER TABLE `template-category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template-styles`
--

DROP TABLE IF EXISTS `template-styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `template-styles` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_f89caee9b323abfc0abaeea8b8` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template-styles`
--

LOCK TABLES `template-styles` WRITE;
/*!40000 ALTER TABLE `template-styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `template-styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_template_styles`
--

DROP TABLE IF EXISTS `template_template_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `template_template_styles` (
  `templateId` varchar(36) NOT NULL,
  `styleId` varchar(36) NOT NULL,
  PRIMARY KEY (`templateId`,`styleId`),
  KEY `IDX_17694cf06ef5a0e0dcc8fac049` (`templateId`),
  KEY `IDX_da6b0f561e3324d22e771e5af4` (`styleId`),
  CONSTRAINT `FK_17694cf06ef5a0e0dcc8fac0494` FOREIGN KEY (`templateId`) REFERENCES `templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_da6b0f561e3324d22e771e5af41` FOREIGN KEY (`styleId`) REFERENCES `template-styles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_template_styles`
--

LOCK TABLES `template_template_styles` WRITE;
/*!40000 ALTER TABLE `template_template_styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `template_template_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templates` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `templateType` enum('quotation','invoice') NOT NULL,
  `documentId` int DEFAULT NULL,
  `variables` json DEFAULT NULL,
  `backupVariables` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_5f35ae77278bc45ff7f6a7ffbfe` (`documentId`),
  CONSTRAINT `FK_5f35ae77278bc45ff7f6a7ffbfe` FOREIGN KEY (`documentId`) REFERENCES `storage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload`
--

DROP TABLE IF EXISTS `upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upload` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `relativePath` varchar(255) NOT NULL,
  `mimetype` varchar(255) NOT NULL,
  `size` int NOT NULL,
  `isTemporary` tinyint NOT NULL DEFAULT '0',
  `isPrivate` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload`
--

LOCK TABLES `upload` WRITE;
/*!40000 ALTER TABLE `upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` datetime(6) DEFAULT NULL,
  `isDeletionRestricted` tinyint NOT NULL DEFAULT '0',
  `id` varchar(36) NOT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `dateOfBirth` datetime DEFAULT NULL,
  `isActive` tinyint NOT NULL DEFAULT '0',
  `isApproved` tinyint DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `emailVerified` timestamp NULL DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `roleId` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `bio` text,
  `gender` enum('Male','Female') DEFAULT NULL,
  `pictureId` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_fe0bb3f6520ee0469504521e71` (`username`),
  UNIQUE KEY `IDX_97672ac88f789774dd47f7c8be` (`email`),
  UNIQUE KEY `IDX_a000cca60bcf04454e72769949` (`phone`),
  KEY `IDX_94e2000b5f7ee1f9c491f0f8a8` (`type`),
  KEY `FK_368e146b785b574f42ae9e53d5e` (`roleId`),
  KEY `FK_ded12396ab7ff578ac34eba5b9f` (`pictureId`),
  CONSTRAINT `FK_368e146b785b574f42ae9e53d5e` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ded12396ab7ff578ac34eba5b9f` FOREIGN KEY (`pictureId`) REFERENCES `storage` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('2026-03-04 08:05:40.712952','2026-05-08 16:56:15.531664',NULL,0,'de929660-80f7-47b2-afcf-483a04bbcf50','Super$','Admin$',NULL,1,1,'$2a$12$R9h/LIPzIf5v11uUs90.DuGZbGY12IFnyE6u2E8S.O1.y8p/Lp9u.','superadmin','superadmin@example.com',NULL,NULL,'f1f2a70f-7ba7-4bb8-afdb-05aeb1f0ad70',NULL,NULL,NULL,NULL,'UserEntity');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-10 10:26:19
