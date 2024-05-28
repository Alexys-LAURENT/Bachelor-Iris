-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: syncpro
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Current Database: `syncpro`
--

/*!40000 DROP DATABASE IF EXISTS `syncpro`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `syncpro` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `syncpro`;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `idAdmin` int NOT NULL,
  `role` enum('Super Admin','Admin') NOT NULL,
  PRIMARY KEY (`idAdmin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications` (
  `idApplication` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  PRIMARY KEY (`idApplication`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (1,'ChatSphere'),(2,'Sprintify'),(3,'CloudNest'),(4,'HelpDesk'),(5,'NoteFlow'),(6,'TaskMate'),(7,'Plateforme Centralisée');
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `idCategorie` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `hex` varchar(255) NOT NULL,
  PRIMARY KEY (`idCategorie`),
  KEY `FK_CATEGORIES_USER` (`idUser`),
  CONSTRAINT `FK_CATEGORIES_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,1,'Perso','#FF0000'),(2,1,'Ecole','#00FF00'),(3,1,'Travail','#0000FF');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `idClient` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `siret` varchar(255) NOT NULL,
  PRIMARY KEY (`idClient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussions`
--

DROP TABLE IF EXISTS `discussions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discussions` (
  `idDiscussion` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) DEFAULT NULL,
  `createdBy` int DEFAULT NULL,
  PRIMARY KEY (`idDiscussion`),
  KEY `FK_DISCUSSIONS_USER` (`createdBy`),
  CONSTRAINT `FK_DISCUSSIONS_USER` FOREIGN KEY (`createdBy`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussions`
--

LOCK TABLES `discussions` WRITE;
/*!40000 ALTER TABLE `discussions` DISABLE KEYS */;
INSERT INTO `discussions` VALUES (1,NULL,NULL),(2,'équipe 1',1),(3,NULL,NULL);
/*!40000 ALTER TABLE `discussions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussions_users`
--

DROP TABLE IF EXISTS `discussions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discussions_users` (
  `idUser` int NOT NULL,
  `idDiscussion` int NOT NULL,
  PRIMARY KEY (`idUser`,`idDiscussion`),
  KEY `FK_DISCUSSIONS_USER_DISCUSSION` (`idDiscussion`),
  CONSTRAINT `FK_DISCUSSIONS_USER_DISCUSSION` FOREIGN KEY (`idDiscussion`) REFERENCES `discussions` (`idDiscussion`) ON DELETE CASCADE,
  CONSTRAINT `FK_DISCUSSIONS_USER_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussions_users`
--

LOCK TABLES `discussions_users` WRITE;
/*!40000 ALTER TABLE `discussions_users` DISABLE KEYS */;
INSERT INTO `discussions_users` VALUES (1,1),(2,1),(1,2),(3,2),(4,2),(5,2),(1,3),(5,3);
/*!40000 ALTER TABLE `discussions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dossiers`
--

DROP TABLE IF EXISTS `dossiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dossiers` (
  `idDossier` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `nom` varchar(255) NOT NULL,
  PRIMARY KEY (`idDossier`),
  KEY `FK_DOSSIERS_USER` (`idUser`),
  CONSTRAINT `FK_DOSSIERS_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dossiers`
--

LOCK TABLES `dossiers` WRITE;
/*!40000 ALTER TABLE `dossiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dossiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entreprises`
--

DROP TABLE IF EXISTS `entreprises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entreprises` (
  `idEntreprise` int NOT NULL AUTO_INCREMENT,
  `idSecteur` int NOT NULL,
  `nom` varchar(50) NOT NULL,
  `adresse` varchar(50) NOT NULL,
  `codePostal` varchar(50) NOT NULL,
  `ville` varchar(50) NOT NULL,
  `siret` varchar(50) NOT NULL,
  PRIMARY KEY (`idEntreprise`),
  KEY `FK_ENTREPRISES_SECTEURS` (`idSecteur`),
  CONSTRAINT `FK_ENTREPRISES_SECTEURS` FOREIGN KEY (`idSecteur`) REFERENCES `secteurs` (`idSecteur`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entreprises`
--

LOCK TABLES `entreprises` WRITE;
/*!40000 ALTER TABLE `entreprises` DISABLE KEYS */;
INSERT INTO `entreprises` VALUES (1,1,'Tech Solutions','123 Main Street','12345','Techville','SIRET12345'),(2,1,'Data Systems','456 Oak Avenue','67890','Datatown','SIRET67890'),(3,1,'Web Services Inc.','789 Elm Road','54321','Webville','SIRET54321');
/*!40000 ALTER TABLE `entreprises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fichiers`
--

DROP TABLE IF EXISTS `fichiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fichiers` (
  `idFichier` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idDossier` int DEFAULT NULL,
  `nom` varchar(255) NOT NULL,
  PRIMARY KEY (`idFichier`),
  KEY `FK_FICHIERS_DOSSIER` (`idDossier`),
  KEY `FK_FICHIERS_USER` (`idUser`),
  CONSTRAINT `FK_FICHIERS_DOSSIER` FOREIGN KEY (`idDossier`) REFERENCES `dossiers` (`idDossier`),
  CONSTRAINT `FK_FICHIERS_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fichiers`
--

LOCK TABLES `fichiers` WRITE;
/*!40000 ALTER TABLE `fichiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `fichiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managers` (
  `idManager` int NOT NULL,
  PRIMARY KEY (`idManager`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_reads`
--

DROP TABLE IF EXISTS `message_reads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_reads` (
  `idMessageRead` int NOT NULL AUTO_INCREMENT,
  `idMessage` int NOT NULL,
  `idUser` int NOT NULL,
  `timestamp` timestamp NOT NULL,
  PRIMARY KEY (`idMessageRead`),
  KEY `FK_MESSAGES_READS` (`idMessage`),
  KEY `FK_MESSAGES_READS2` (`idUser`),
  CONSTRAINT `FK_MESSAGES_READS` FOREIGN KEY (`idMessage`) REFERENCES `messages` (`idMessage`) ON DELETE CASCADE,
  CONSTRAINT `FK_MESSAGES_READS2` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_reads`
--

LOCK TABLES `message_reads` WRITE;
/*!40000 ALTER TABLE `message_reads` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_reads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `idMessage` int NOT NULL AUTO_INCREMENT,
  `idDiscussion` int NOT NULL,
  `idUser` int NOT NULL,
  `content` varchar(255) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMessage`),
  KEY `FK_MESSAGES_DISCUSSION` (`idDiscussion`),
  KEY `FK_MESSAGES_USER` (`idUser`),
  CONSTRAINT `FK_MESSAGES_DISCUSSION` FOREIGN KEY (`idDiscussion`) REFERENCES `discussions` (`idDiscussion`) ON DELETE CASCADE,
  CONSTRAINT `FK_MESSAGES_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,1,'Bonjour, comment ça va ?','2024-01-02 16:43:38'),(2,1,2,'Salut, ça va et toi ?','2024-01-02 16:43:38'),(3,1,1,'Ça va bien merci !','2024-01-02 16:43:38'),(4,1,2,'Super !','2024-01-02 16:43:38'),(5,1,1,'Tu as vu le nouveau projet ?','2024-01-02 16:43:38'),(6,1,2,'Oui, il a l\'air super !','2024-01-02 16:43:38'),(7,1,1,'Oui, j\'ai hâte de commencer !','2024-01-02 16:43:38'),(8,1,2,'Moi aussi !','2024-01-02 16:43:38'),(9,2,3,'Bonjour, je suis nouveau ici !','2024-01-02 16:43:38'),(10,2,4,'Bienvenue !','2024-01-02 16:43:38'),(11,2,3,'Merci !','2024-01-02 16:43:38'),(12,3,5,'Je viens tout juste de finir le projet !','2024-01-02 16:43:38');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages_tickets`
--

DROP TABLE IF EXISTS `messages_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages_tickets` (
  `idMessageTicket` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idTicket` int NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `content` longtext NOT NULL,
  PRIMARY KEY (`idMessageTicket`),
  KEY `FK_MESSAGES_TICKETS_USER` (`idUser`),
  KEY `FK_MESSAGES_TICKETS_TICKET` (`idTicket`),
  CONSTRAINT `FK_MESSAGES_TICKETS_TICKET` FOREIGN KEY (`idTicket`) REFERENCES `tickets` (`idTicket`) ON DELETE CASCADE,
  CONSTRAINT `FK_MESSAGES_TICKETS_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages_tickets`
--

LOCK TABLES `messages_tickets` WRITE;
/*!40000 ALTER TABLE `messages_tickets` DISABLE KEYS */;
INSERT INTO `messages_tickets` VALUES (22,2,20,'2024-05-15 21:26:02','Bonjour, pouvez vous m\'aider ?'),(23,32,20,'2024-05-15 21:27:33','Bonjour, oui un instant'),(24,32,20,'2024-05-15 21:28:27','Suivez ces étapes : - - - -- -');
/*!40000 ALTER TABLE `messages_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missions`
--

DROP TABLE IF EXISTS `missions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `missions` (
  `idMission` int NOT NULL AUTO_INCREMENT,
  `idSprint` int NOT NULL,
  `titre` varchar(255) NOT NULL,
  `etat` enum('En cours','Terminé','Bloqué','A faire') NOT NULL DEFAULT 'A faire',
  PRIMARY KEY (`idMission`),
  KEY `FK_MISSIONS_SPRINT` (`idSprint`),
  CONSTRAINT `FK_MISSIONS_SPRINT` FOREIGN KEY (`idSprint`) REFERENCES `sprints` (`idSprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missions`
--

LOCK TABLES `missions` WRITE;
/*!40000 ALTER TABLE `missions` DISABLE KEYS */;
/*!40000 ALTER TABLE `missions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missions_users`
--

DROP TABLE IF EXISTS `missions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `missions_users` (
  `idMission` int NOT NULL,
  `idUser` int NOT NULL,
  PRIMARY KEY (`idMission`,`idUser`),
  KEY `FK_MISSIONS_USERS_USER` (`idUser`),
  CONSTRAINT `FK_MISSIONS_USERS_MISSION` FOREIGN KEY (`idMission`) REFERENCES `missions` (`idMission`),
  CONSTRAINT `FK_MISSIONS_USERS_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missions_users`
--

LOCK TABLES `missions_users` WRITE;
/*!40000 ALTER TABLE `missions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `missions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `idNote` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idCategorie` int DEFAULT NULL,
  `titre` varchar(255) NOT NULL,
  `isFavorite` tinyint(1) NOT NULL DEFAULT '0',
  `content` longtext NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idNote`),
  KEY `FK_NOTES_USER` (`idUser`),
  KEY `FK_NOTES_CATEGORIE` (`idCategorie`),
  CONSTRAINT `FK_NOTES_CATEGORIE` FOREIGN KEY (`idCategorie`) REFERENCES `categories` (`idCategorie`),
  CONSTRAINT `FK_NOTES_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (1,1,1,'Ma première note',0,'\'{\"time\":1702981067980,\"blocks\":[],\"version\":\"2.28.2\"}\'','2024-01-02 16:43:38'),(2,1,1,'Ma deuxième note',1,'\'{\"time\":1702981067980,\"blocks\":[],\"version\":\"2.28.2\"}\'','2024-01-02 16:43:38'),(3,1,1,'Ma troisième note',0,'\'{\"time\":1702981067980,\"blocks\":[],\"version\":\"2.28.2\"}\'','2024-01-02 16:43:38');
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partages_dossiers`
--

DROP TABLE IF EXISTS `partages_dossiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partages_dossiers` (
  `idPartageDossier` int NOT NULL AUTO_INCREMENT,
  `idDossier` int NOT NULL,
  `insertions` tinyint(1) NOT NULL,
  `modifications` tinyint(1) NOT NULL,
  `dateDebut` timestamp NOT NULL,
  `dateFin` timestamp NOT NULL,
  PRIMARY KEY (`idPartageDossier`),
  KEY `FK_PARTAGES_DOSSIERS_DOSSIER` (`idDossier`),
  CONSTRAINT `FK_PARTAGES_DOSSIERS_DOSSIER` FOREIGN KEY (`idDossier`) REFERENCES `dossiers` (`idDossier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partages_dossiers`
--

LOCK TABLES `partages_dossiers` WRITE;
/*!40000 ALTER TABLE `partages_dossiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `partages_dossiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partages_dossiers_users`
--

DROP TABLE IF EXISTS `partages_dossiers_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partages_dossiers_users` (
  `idPartageDossier` int NOT NULL,
  `idUser` int NOT NULL,
  PRIMARY KEY (`idPartageDossier`,`idUser`),
  KEY `FK_PARTAGES_DOSSIERS_USERS_USER` (`idUser`),
  CONSTRAINT `FK_PARTAGES_DOSSIERS_USERS_PARTAGE` FOREIGN KEY (`idPartageDossier`) REFERENCES `partages_dossiers` (`idPartageDossier`),
  CONSTRAINT `FK_PARTAGES_DOSSIERS_USERS_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partages_dossiers_users`
--

LOCK TABLES `partages_dossiers_users` WRITE;
/*!40000 ALTER TABLE `partages_dossiers_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `partages_dossiers_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partages_fichiers`
--

DROP TABLE IF EXISTS `partages_fichiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partages_fichiers` (
  `idPartageFichier` int NOT NULL AUTO_INCREMENT,
  `idFichier` int NOT NULL,
  `dateDebut` timestamp NOT NULL,
  `dateFin` timestamp NOT NULL,
  PRIMARY KEY (`idPartageFichier`),
  KEY `FK_PARTAGES_FICHIERS_FICHIER` (`idFichier`),
  CONSTRAINT `FK_PARTAGES_FICHIERS_FICHIER` FOREIGN KEY (`idFichier`) REFERENCES `fichiers` (`idFichier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partages_fichiers`
--

LOCK TABLES `partages_fichiers` WRITE;
/*!40000 ALTER TABLE `partages_fichiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `partages_fichiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partages_fichiers_users`
--

DROP TABLE IF EXISTS `partages_fichiers_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partages_fichiers_users` (
  `idPartageFichier` int NOT NULL,
  `idUser` int NOT NULL,
  PRIMARY KEY (`idPartageFichier`,`idUser`),
  KEY `FK_PARTAGES_FICHIERS_USERS_USER` (`idUser`),
  CONSTRAINT `FK_PARTAGES_FICHIERS_USERS_PARTAGE` FOREIGN KEY (`idPartageFichier`) REFERENCES `partages_fichiers` (`idPartageFichier`),
  CONSTRAINT `FK_PARTAGES_FICHIERS_USERS_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partages_fichiers_users`
--

LOCK TABLES `partages_fichiers_users` WRITE;
/*!40000 ALTER TABLE `partages_fichiers_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `partages_fichiers_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projets`
--

DROP TABLE IF EXISTS `projets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projets` (
  `idProjet` int NOT NULL AUTO_INCREMENT,
  `idClient` int NOT NULL,
  `idManager` int NOT NULL,
  `titre` varchar(255) NOT NULL,
  `dateDebut` timestamp NOT NULL,
  `dateFin` timestamp NOT NULL,
  PRIMARY KEY (`idProjet`),
  KEY `FK_PROJETS_CLIENT` (`idClient`),
  KEY `FK_PROJETS_MANAGER` (`idManager`),
  CONSTRAINT `FK_PROJETS_CLIENT` FOREIGN KEY (`idClient`) REFERENCES `clients` (`idClient`),
  CONSTRAINT `FK_PROJETS_MANAGER` FOREIGN KEY (`idManager`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projets`
--

LOCK TABLES `projets` WRITE;
/*!40000 ALTER TABLE `projets` DISABLE KEYS */;
/*!40000 ALTER TABLE `projets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `secteurs`
--

DROP TABLE IF EXISTS `secteurs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `secteurs` (
  `idSecteur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  PRIMARY KEY (`idSecteur`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secteurs`
--

LOCK TABLES `secteurs` WRITE;
/*!40000 ALTER TABLE `secteurs` DISABLE KEYS */;
INSERT INTO `secteurs` VALUES (1,'Informatique'),(2,'Finance'),(3,'Marketing'),(4,'Communication'),(5,'Ressources Humaines'),(6,'Juridique'),(7,'Santé'),(8,'Enseignement'),(9,'Commerce'),(10,'Transport'),(11,'Tourisme'),(12,'Hôtellerie'),(13,'Restauration'),(14,'Immobilier'),(15,'BTP'),(16,'Industrie'),(17,'Agriculture'),(18,'Artisanat'),(19,'Autre');
/*!40000 ALTER TABLE `secteurs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sharednotes`
--

DROP TABLE IF EXISTS `sharednotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sharednotes` (
  `idShare` int NOT NULL AUTO_INCREMENT,
  `idNote` int DEFAULT NULL,
  `idOwner` int DEFAULT NULL,
  `idShared` int DEFAULT NULL,
  `permissions` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idShare`),
  KEY `idNote` (`idNote`),
  KEY `idOwner` (`idOwner`),
  KEY `idShared` (`idShared`),
  CONSTRAINT `sharednotes_ibfk_1` FOREIGN KEY (`idNote`) REFERENCES `notes` (`idNote`) ON DELETE CASCADE,
  CONSTRAINT `sharednotes_ibfk_2` FOREIGN KEY (`idOwner`) REFERENCES `users` (`idUser`),
  CONSTRAINT `sharednotes_ibfk_3` FOREIGN KEY (`idShared`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sharednotes`
--

LOCK TABLES `sharednotes` WRITE;
/*!40000 ALTER TABLE `sharednotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `sharednotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprints`
--

DROP TABLE IF EXISTS `sprints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sprints` (
  `idSprint` int NOT NULL AUTO_INCREMENT,
  `idProjet` int NOT NULL,
  `titre` varchar(255) NOT NULL,
  `dateDebut` timestamp NOT NULL,
  `dateFin` timestamp NOT NULL,
  PRIMARY KEY (`idSprint`),
  KEY `FK_SPRINTS_PROJET` (`idProjet`),
  CONSTRAINT `FK_SPRINTS_PROJET` FOREIGN KEY (`idProjet`) REFERENCES `projets` (`idProjet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprints`
--

LOCK TABLES `sprints` WRITE;
/*!40000 ALTER TABLE `sprints` DISABLE KEYS */;
/*!40000 ALTER TABLE `sprints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprints_users`
--

DROP TABLE IF EXISTS `sprints_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sprints_users` (
  `idSprint` int NOT NULL,
  `idUser` int NOT NULL,
  PRIMARY KEY (`idSprint`,`idUser`),
  KEY `FK_SPRINTS_USERS_USER` (`idUser`),
  CONSTRAINT `FK_SPRINTS_USERS_SPRINT` FOREIGN KEY (`idSprint`) REFERENCES `sprints` (`idSprint`),
  CONSTRAINT `FK_SPRINTS_USERS_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprints_users`
--

LOCK TABLES `sprints_users` WRITE;
/*!40000 ALTER TABLE `sprints_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `sprints_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supports`
--

DROP TABLE IF EXISTS `supports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supports` (
  `idSupport` int NOT NULL,
  `qualification` varchar(150) NOT NULL,
  PRIMARY KEY (`idSupport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supports`
--

LOCK TABLES `supports` WRITE;
/*!40000 ALTER TABLE `supports` DISABLE KEYS */;
INSERT INTO `supports` VALUES (1,'BAC'),(31,'titre'),(32,'Technicien Support');
/*!40000 ALTER TABLE `supports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `idTicket` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `idApplication` int NOT NULL,
  `titre` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `etat` enum('En cours','Terminé') NOT NULL DEFAULT 'En cours',
  `idTechnicien` int DEFAULT NULL,
  `messageResolution` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`idTicket`),
  KEY `FK_TICKETS_USER` (`idUser`),
  KEY `FK_TICKETS_APPLICATION` (`idApplication`),
  CONSTRAINT `FK_TICKETS_APPLICATION` FOREIGN KEY (`idApplication`) REFERENCES `applications` (`idApplication`),
  CONSTRAINT `FK_TICKETS_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (19,2,1,'ticket 1','Je n\'arrives plus à envoyer des messages sur chatsphere','En cours',NULL,NULL),(20,2,3,'ticket 2','je ne vois plus mes documents sur cloudnest','Terminé',32,'problème résolu');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todos`
--

DROP TABLE IF EXISTS `todos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `todos` (
  `idToDo` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `description` varchar(255) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `etat` enum('En cours','Terminé') NOT NULL DEFAULT 'En cours',
  PRIMARY KEY (`idToDo`),
  KEY `FK_TODOS_USER` (`idUser`),
  CONSTRAINT `FK_TODOS_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todos`
--

LOCK TABLES `todos` WRITE;
/*!40000 ALTER TABLE `todos` DISABLE KEYS */;
INSERT INTO `todos` VALUES (1,31,'Boire de l\'eau','2024-05-21 22:00:00','En cours'),(2,31,'Boire du jus','2024-05-21 22:00:00','En cours');
/*!40000 ALTER TABLE `todos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `idToken` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `token` varchar(255) NOT NULL,
  `expireAt` timestamp NOT NULL DEFAULT ((now() + interval 1 day)),
  PRIMARY KEY (`idToken`),
  KEY `FK_TOKEN_USER` (`idUser`),
  CONSTRAINT `FK_TOKEN_USER` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
INSERT INTO `token` VALUES (1,1,'H4d58uy484k8ua4da4dsqdiazi1d2a31d5za15da','2030-12-31 23:00:00'),(2,2,'zdaz78d78zacd1za8c74d8917a484s8ax247dza','2030-12-31 23:00:00'),(3,32,'O4dd8udzay484k8ua4das4dsqdiazi1d2a31d5za15da','2030-12-31 23:00:00');
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `idUser` int NOT NULL AUTO_INCREMENT,
  `idEntreprise` int DEFAULT NULL,
  `idManager` int DEFAULT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `hashedPass` varchar(50) NOT NULL,
  `metier` varchar(50) NOT NULL,
  `pp` varchar(255) DEFAULT 'default.webp',
  `theme` varchar(5) NOT NULL DEFAULT 'dark',
  `statut` enum('Absent','En ligne','Occupé','Hors ligne') NOT NULL DEFAULT 'Hors ligne',
  PRIMARY KEY (`idUser`),
  KEY `FK_USER_ENTREPRISE` (`idEntreprise`),
  KEY `FK_USER_MANAGER` (`idManager`),
  CONSTRAINT `FK_USER_ENTREPRISE` FOREIGN KEY (`idEntreprise`) REFERENCES `entreprises` (`idEntreprise`),
  CONSTRAINT `FK_USER_MANAGER` FOREIGN KEY (`idManager`) REFERENCES `managers` (`idManager`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,NULL,'Doe','John','johndoe@email.com','123','Développeur Web','John-Doe.webp','dark','Hors ligne'),(2,1,NULL,'Smith','Alice','alicesmith@email.com','123','Administrateur Systèmes','Alice-Smith.webp','light','Hors ligne'),(3,1,NULL,'Doe','Jane','janedoe@email.com','123','Développeur Full-Stack','default.webp','dark','Hors ligne'),(4,1,NULL,'Smith','Bob','bobsmith@email.com','123','Développeur Front-End','default.webp','dark','Hors ligne'),(5,1,NULL,'Clark','Michael','michaelclark@email.com','1234','Développeur Back-End','Michael-Clark.webp','dark','Hors ligne'),(6,1,NULL,'Davis','Ella','elladavis@email.com','123','Développeur Full-Stack','Ella-Davis.webp','dark','Hors ligne'),(7,1,NULL,'Johnson','Robert','robertjohnson@email.com','123','Développeur Front-End','Robert-Jonhson.webp','dark','Hors ligne'),(8,1,NULL,'Laurent','Alexys','alexyslaurent@email.com','123','Chef de projet','Alexys-Laurent.webp','dark','Hors ligne'),(9,1,NULL,'Durand','Sophie','sophiedurand@email.com','123','Responsable RH','default.webp','dark','En ligne'),(10,1,NULL,'Martin','Louis','louismartin@email.com','123','Développeur Full-Stack','default.webp','dark','Occupé'),(11,1,NULL,'Bernard','Emilie','emiliebernard@email.com','123','Développeur Back-End','default.webp','dark','Absent'),(12,1,NULL,'Petit','Thomas','thomaspetit@email.com','123','Manager','default.webp','dark','En ligne'),(13,1,NULL,'Leroy','Julie','julieleroy@email.com','123','Directeur Technique','default.webp','dark','Occupé'),(14,1,NULL,'Moreau','Nicolas','nicolasmoreau@email.com','123','Analyste Sécurité','default.webp','dark','Hors ligne'),(15,1,NULL,'Simon','Laura','laurasimon@email.com','123','Ingénieur Système','default.webp','dark','En ligne'),(16,1,NULL,'Lefebvre','Maxime','maximelefebvre@email.com','123','Designer UX/UI','default.webp','dark','Absent'),(17,1,NULL,'Michel','Clara','claramichel@email.com','123','Spécialiste SEO','default.webp','dark','Occupé'),(18,1,NULL,'Garcia','Alexandre','alexandregarcia@email.com','123','Chef de Projet Digital','default.webp','dark','Hors ligne'),(19,1,NULL,'Dupont','Marie','mariedupont@email.com','123','Chargée de Recrutement','default.webp','dark','En ligne'),(20,1,NULL,'Lopez','David','davidlopez@email.com','123','Analyste Financier','default.webp','dark','Absent'),(21,1,NULL,'Girard','Anne','annegirard@email.com','123','Responsable Commercial','default.webp','dark','En ligne'),(22,1,NULL,'Roux','Julien','julienroux@email.com','123','Consultant IT','default.webp','dark','Occupé'),(23,1,NULL,'Fournier','Élise','elisefournier@email.com','123','Responsable Marketing','default.webp','dark','Absent'),(24,1,NULL,'Morel','Pierre','pierremorel@email.com','123','Expert Cyber-sécurité','default.webp','dark','En ligne'),(25,1,NULL,'Laurent','Stéphanie','stephanielaurent@email.com','123','Directrice Artistique','default.webp','dark','Occupé'),(26,1,NULL,'Simon','Éric','ericsimon@email.com','123','Responsable de Production','default.webp','dark','Hors ligne'),(27,1,NULL,'Michel','Patricia','patriciamichel@email.com','123','Coach Agile','default.webp','dark','En ligne'),(28,1,NULL,'Lefevre','Brice','bricelefevre@email.com','123','Architecte Logiciel','default.webp','dark','Absent'),(29,2,NULL,'Johnson','Robert','robertjohnson@email.com','123','Analyste de Données','default.webp','dark','Hors ligne'),(30,2,NULL,'Davis','Ella','elladavis@email.com','123','Ingénieur en Données','default.webp','dark','Hors ligne'),(31,3,NULL,'Clark','Michael','michaelclark@email.com','123','Développeur Full-Stack','default.webp','dark','Hors ligne'),(32,NULL,NULL,'Marcelin','Bruno','brunomarcelin@email.com','123','Technicien Support','default.webp','dark','En ligne');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'syncpro'
--

--
-- Dumping routines for database 'syncpro'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-28 11:44:51
