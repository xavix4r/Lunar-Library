CREATE DATABASE  IF NOT EXISTS `lunar_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lunar_db`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: lunar_db
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
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `publication_date` date NOT NULL,
  `isbn` varchar(20) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `rating` decimal(3,2) DEFAULT NULL,
  `description` text,
  `image_url` varchar(255) NOT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'The Fellowship Of The Ring','J.R.R. Tolkien',9.99,2,'George Allen & Unwin','1954-07-29','9780618346257','Fantasy',4.50,'A group of diverse individuals as they embark on a perilous journey to destroy a powerful ring and save Middle-earth from the clutches of darkness.','/imgs/p101.jpg'),(2,'A Magic Steeped in Poison','Judy I. Lin',12.99,5,'Enigma Books','2022-02-01','9781234567017','Fantasy',3.90,'A book based on Chinese mythology and the traditional art of tea-making, and beautifully weaves in magical elements for a spellbinding story.','/imgs/p102.jpg'),(3,'The Midnight Library','Matt Haig',18.85,3,'Canongate Books','2021-02-01','9781234567024','Fantasy',4.00,'The Midnight Library tells the story of Nora, a depressed woman in her 30s, who, on the day she decides to die, finds herself in a library full of lives she could have lived, where she discovers there is a lot more to life, even her current one, than she had ever imagined.','/imgs/p103.jpg'),(4,'The Mystery of Black Hollow Lane','Julia Nobel',10.99,12,'Sourcebooks Young Readers','2019-04-01','9781492699191','Mystery',4.50,'A determined girl named Emmy uncovers dark secrets and navigates a web of mystery and intrigue at her mysterious boarding school.','/imgs/p104.jpg'),(5,'Till We Become Monsters','Amanda Headlee',11.99,6,'Nightfall Publications','2022-05-01','9781234567048','Mystery',3.90,'An accident along the way separates the hunters in the dark forests of Minnesota during the threat of an oncoming blizzard. As the stranded hunters search for each other and safety, an ancient evil wakes.','/imgs/p105.jpg'),(6,'Murder Most Unladylike','Robin Stevens',13.99,3,'Enigma Books','2014-06-05','9781234567055','Mystery',4.70,'A thrilling and witty middle-grade mystery novel by Robin Stevens, featuring two best friends and amateur detectives, Daisy Wells and Hazel Wong, as they investigate a murder at their boarding school and unravel a web of secrets and suspects.','/imgs/p106.jpg'),(7,'All Systems Red','Martha Wells',8.99,15,'Tor.com Publishing','2017-05-02','9781234567062','Science Fiction',4.60,'A gripping science fiction novella by Martha Wells, introducing a self-aware and anxiety-ridden android named Murderbot who becomes unexpectedly entangled in a dangerous mission while trying to protect its own freedom.','/imgs/p107.jpg'),(8,'A Memory Called Empire','Arkady Martine',11.99,7,'Tor Books','2019-03-26','9781234567079','Science Fiction',4.40,'A diplomat from a small space station navigates political intrigue in a vast interstellar empire while grappling with her own identity and memories.','/imgs/p108.jpg'),(15,'This Is How You Lose the Time War','Max Gladstone',13.99,2,'Saga Press','2019-07-16','9781234567086','Science Fiction',4.90,'Two rival time-traveling agents engage in a clandestine love affair while altering the fabric of history across different eras.','/imgs/p109.jpg');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `book_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cart_user` (`user_id`),
  KEY `fk_cart_book` (`book_id`),
  CONSTRAINT `fk_cart_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (61,15,3,1),(62,15,15,1),(63,16,5,1),(64,16,7,1),(65,4,2,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_inquiries`
--

DROP TABLE IF EXISTS `customer_inquiries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_inquiries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `inquiry_type` varchar(50) DEFAULT NULL,
  `inquiry_text` text,
  `require_response` tinyint(1) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `customer_inquiries_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_inquiries`
--

LOCK TABLES `customer_inquiries` WRITE;
/*!40000 ALTER TABLE `customer_inquiries` DISABLE KEYS */;
INSERT INTO `customer_inquiries` VALUES (1,1,'Books','I want a book called ewhbfduiwebdfa',1,'ewvfhwe@gmail.com');
/*!40000 ALTER TABLE `customer_inquiries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `book_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`book_id`),
  CONSTRAINT `fk_inventory_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_address`
--

DROP TABLE IF EXISTS `order_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `address_line1` varchar(255) NOT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `postal` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_address_orderid_idx` (`order_id`),
  CONSTRAINT `fk_order_address_orderid` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_address`
--

LOCK TABLES `order_address` WRITE;
/*!40000 ALTER TABLE `order_address` DISABLE KEYS */;
INSERT INTO `order_address` VALUES (2,6,'123 Thomson Rd.',NULL,308123),(3,7,'123 Thomson Rd.',NULL,308123),(4,8,'123 Thomson Rd.',NULL,308123),(5,9,'123 Thomson Rd.',NULL,308123),(6,10,'123 Thomson Rd.',NULL,308123),(7,11,'123 Thomson Rd.',NULL,308123);
/*!40000 ALTER TABLE `order_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `book_id` int NOT NULL,
  `quantityOrdered` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_items_bookid_idx` (`book_id`),
  KEY `fk_order_items_orderid_idx` (`order_id`),
  CONSTRAINT `fk_order_items_bookid` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_orderid` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (8,6,2,1),(9,6,3,1),(10,7,6,1),(11,7,8,1),(12,8,8,1),(13,9,3,1),(14,9,15,1),(15,10,5,1),(16,10,7,1),(17,11,2,1);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `order_date` datetime NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_user_id_idx` (`user_id`),
  CONSTRAINT `fk_orders_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (6,4,'2023-07-15 15:57:21',34.39),(7,4,'2023-07-27 12:34:33',28.06),(8,4,'2023-07-27 12:37:57',12.95),(9,15,'2023-07-28 00:03:25',35.47),(10,16,'2023-07-28 00:03:55',22.66),(11,4,'2023-07-30 10:23:14',14.03);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` enum('admin','member','owner') NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'janedoe','Jane','Doe','rocket@','jane@gmail.com','admin'),(3,'bookw0rm','Chris','Kyle','i0wn','kyle@gmail.com','owner'),(4,'johndoe','john','doe','gro0t','john@gmail.com','member'),(15,'bharatian','sundar','bharath','123456','bharath@gmail.com','member'),(16,'nattie','nathaniel','gobard','123456','nat@gmail.com','member');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_address`
--

DROP TABLE IF EXISTS `users_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_address` (
  `user_id` int NOT NULL,
  `address_line1` varchar(255) NOT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `postal` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_userid` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_address`
--

LOCK TABLES `users_address` WRITE;
/*!40000 ALTER TABLE `users_address` DISABLE KEYS */;
INSERT INTO `users_address` VALUES (4,'Tampines Street 43 Blk 473','','739473'),(15,'99 Irrawaddy Rd ','','329568'),(16,'2 Jln Rajawali, Grand Chateau','','598435');
/*!40000 ALTER TABLE `users_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_contact`
--

DROP TABLE IF EXISTS `users_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_contact` (
  `user_id` int NOT NULL,
  `contactNo` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_user_idx` (`user_id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_contact`
--

LOCK TABLES `users_contact` WRITE;
/*!40000 ALTER TABLE `users_contact` DISABLE KEYS */;
INSERT INTO `users_contact` VALUES (1,'98793393'),(3,'98478323'),(4,'99999999');
/*!40000 ALTER TABLE `users_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `book_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wishlist_user_idx` (`user_id`),
  KEY `fk_wishlist_book_idx` (`book_id`),
  CONSTRAINT `fk_wishlist_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wishlist_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-30 19:49:02
