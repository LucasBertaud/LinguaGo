-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: linguago
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Current Database: `linguago`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `linguago` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `linguago`;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('035540a8-9c21-4bda-95df-f8e2c2ea7607','d55c0c205073d6316f94e1318b7920b32c9eae06fbc1d4e536081bd578bb1876','2025-03-04 11:09:17.257','20250304103559_add_db_text',NULL,NULL,'2025-03-04 11:09:16.921',1),('1021ae1c-83d9-4311-acaa-b4eeadbc78ef','9dbbd5330a2ff169151ce40ec3e59b8851004dbafb375f205e65bce4d0bb02c3','2025-03-04 11:09:16.595','20250304102931_add_db_text',NULL,NULL,'2025-03-04 11:09:16.309',1),('17eff5b2-e8ff-4ac7-ba27-9660626c734b','f62e0360d607e4bdd1e2c870c23074c04a1f24afb904d21f042bf408aa7d45b5','2025-03-04 11:09:16.297','20250304102520_init_mysql',NULL,NULL,'2025-03-04 11:09:13.851',1),('96186c15-4653-4212-9b3d-470e864c6700','163c90ca3a80c49c0da77ea9f4e52f1b67d4edb0d2b3cc7b07bf41d1af6dcc9c','2025-03-04 13:48:14.170','20250304104227_add_trigger',NULL,NULL,'2025-03-04 13:48:13.809',1),('c3454d83-298f-4cc1-9644-d0ce5e44b5b6','66ccd07eba1dd5c987a14ba8018ac8b8c5b155602ce4b71e7df17f0d5accfa80','2025-03-04 12:59:47.716','20250304103126_add_db_text',NULL,NULL,'2025-03-04 12:59:47.652',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avatar`
--

DROP TABLE IF EXISTS `avatar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avatar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `svg` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avatar`
--

LOCK TABLES `avatar` WRITE;
/*!40000 ALTER TABLE `avatar` DISABLE KEYS */;
INSERT INTO `avatar` VALUES (1,'<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 80 80\" fill=\"none\" shape-rendering=\"auto\" width=\"512\" height=\"512\"><metadata xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:dcterms=\"http://purl.org/dc/terms/\"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type=\"dcterms:URI\">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type=\"dcterms:URI\">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of „Dylan! The Avatar Generator” (https://www.figma.com/community/file/1356575240759683500) by „Natalia Spivak”, licensed under „CC BY 4.0” (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id=\"viewboxMask\"><rect width=\"80\" height=\"80\" rx=\"0\" ry=\"0\" x=\"0\" y=\"0\" fill=\"#fff\" /></mask><g mask=\"url(#viewboxMask)\"><rect fill=\"#29e051\" width=\"80\" height=\"80\" x=\"0\" y=\"0\" /><path d=\"M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64\" fill=\"#ffd6c0\"/><path d=\"m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1\" fill=\"black\"/><path d=\"M30.36 48.8c.6-.5 2.22-2.29 2.9-2.12.41.1 1.03 1.1 1.3 1.41l1.57 1.74c.48.53 1.2.28 1.57-.2.88-1.15 2.48-2 3.68-2.78l-1.21-.16c1.02 1.08 2.36 2.66 3.9 3.06 1.34.34 2.28-.9 3.12-1.7q.44-.47.87-.88.3-.28.58-.58.1-.2.28.28c.72.5 1.33 1.4 1.92 2.04.89.94 2.3-.48 1.4-1.4l-1.91-2.05c-.45-.47-.9-.97-1.62-1-.6 0-1.08.35-1.5.73-.7.65-1.35 1.36-2.02 2-.05.07-.52.63-.66.64-.08 0-.24-.16-.33-.2-.42-.17-.8-.58-1.13-.88q-.78-.72-1.5-1.5a1 1 0 0 0-1.2-.17c-1.52 1-3.28 2.04-4.4 3.5l1.57-.2-2.3-2.53c-.51-.57-1.04-1.17-1.84-1.3s-1.45.3-2.06.8l-2.41 2c-1 .82.43 2.23 1.4 1.4z\" fill=\"black\"/><path d=\"M19.51 30.42c16.36-4.9 20.13-15.57 20.13-15.57S51.18 29.46 60.6 30.5c0-.01.85-.03 2.57.15 0 0-3.22-21.28-23.36-20.56S18.19 30.61 18.19 30.61l1.32-.2z\" fill=\"#ffffff\"/></g></svg>'),(2,'<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 80 80\" fill=\"none\" shape-rendering=\"auto\" width=\"512\" height=\"512\"><metadata xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:dcterms=\"http://purl.org/dc/terms/\"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type=\"dcterms:URI\">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type=\"dcterms:URI\">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of „Dylan! The Avatar Generator” (https://www.figma.com/community/file/1356575240759683500) by „Natalia Spivak”, licensed under „CC BY 4.0” (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id=\"viewboxMask\"><rect width=\"80\" height=\"80\" rx=\"0\" ry=\"0\" x=\"0\" y=\"0\" fill=\"#fff\" /></mask><g mask=\"url(#viewboxMask)\"><rect fill=\"#ffa6e6\" width=\"80\" height=\"80\" x=\"0\" y=\"0\" /><path d=\"M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64\" fill=\"#ffd6c0\"/><path d=\"m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1\" fill=\"black\"/><path d=\"M35.7 42.4c-1.18 1.26-2.17 2.74-2.36 4.5a4.4 4.4 0 0 0 1.78 4.02c1.26.9 2.88.8 4.07-.13a5.5 5.5 0 0 0 1.87-3.88c.1-.97-1.46-1.38-1.86-.5-.75 1.63.16 3.26 1.34 4.42a3.9 3.9 0 0 0 4.13.98 4.6 4.6 0 0 0 2.93-3.14 6.6 6.6 0 0 0-.82-4.87c-.64-1.11-2.37-.11-1.73 1 .92 1.6 1.18 4-.7 5.02-.7.35-1.5.36-2.12-.12-.49-.39-1.63-1.55-1.3-2.26l-1.86-.5c-.14 1.34-1.44 3.63-2.97 2.23-1.74-1.59-.22-4 1.03-5.33.88-.94-.53-2.36-1.4-1.4z\" fill=\"black\"/><path d=\"M19.07 30.47s1.63 6 2.49 5.81c2.1-.36 4.15-17.25 4.15-17.25l30.03-.32s1.64 17.06 3.18 17.06 3.37-5.22 3.37-5.22 1.22-19.9-.27-21.9C59.7 5.58 20.28 5.12 19 9.9s.06 20.58.06 20.58z\" fill=\"#fff500\"/></g></svg>'),(3,'<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 80 80\" fill=\"none\" shape-rendering=\"auto\" width=\"512\" height=\"512\"><metadata xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:dcterms=\"http://purl.org/dc/terms/\"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type=\"dcterms:URI\">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type=\"dcterms:URI\">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of „Dylan! The Avatar Generator” (https://www.figma.com/community/file/1356575240759683500) by „Natalia Spivak”, licensed under „CC BY 4.0” (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id=\"viewboxMask\"><rect width=\"80\" height=\"80\" rx=\"0\" ry=\"0\" x=\"0\" y=\"0\" fill=\"#fff\" /></mask><g mask=\"url(#viewboxMask)\"><rect fill=\"#29e051\" width=\"80\" height=\"80\" x=\"0\" y=\"0\" /><path d=\"M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64\" fill=\"#ffd6c0\"/><path d=\"m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1\" fill=\"black\"/><path d=\"M30.5 32.66q.36-.4.77-.76l.09-.08.04-.03c-.12.09 0 0 .02 0l.12-.1.45-.3.44-.25.24-.12.14-.06c.03-.01.16-.07.02 0l.05-.02.1-.04.26-.1.55-.15c.5-.12.86-.73.7-1.23s-.7-.83-1.23-.7a8 8 0 0 0-4.17 2.52c-.34.4-.42 1.03 0 1.4.38.36 1.05.43 1.41 0m18.4-1.87q.9.15 1.8.43l.4.15.25.09.06.02-.06-.03c.02.04.19.08.23.1l.17.08.46.23c.46.25 1.1.13 1.37-.36.26-.5.13-1.1-.36-1.37a12 12 0 0 0-3.8-1.3c-.28-.03-.52-.04-.77.1a1 1 0 0 0-.46.6c-.1.49.15 1.15.7 1.24zM36.4 47.12a17 17 0 0 1 11.35-.1c1.22.4 1.74-1.52.53-1.94a18.8 18.8 0 0 0-12.4.1c-.5.19-.86.69-.7 1.24.12.49.71.88 1.22.7\" fill=\"black\"/><path d=\"M26.74 18.86s9.68 6.45 29.03 4.64c0 0-3.58 42.43 6.9 42.63s13.77-27.55 5.19-45.05C57.99.92 21.5-1.3 12.03 22.29c-9.47 23.6-.7 44.46 5.93 44.9 12.3.8 8.78-48.33 8.78-48.33\" fill=\"#fff500\"/></g></svg>'),(4,'<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 80 80\" fill=\"none\" shape-rendering=\"auto\" width=\"512\" height=\"512\"><metadata xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:dcterms=\"http://purl.org/dc/terms/\"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type=\"dcterms:URI\">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type=\"dcterms:URI\">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of „Dylan! The Avatar Generator” (https://www.figma.com/community/file/1356575240759683500) by „Natalia Spivak”, licensed under „CC BY 4.0” (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id=\"viewboxMask\"><rect width=\"80\" height=\"80\" rx=\"0\" ry=\"0\" x=\"0\" y=\"0\" fill=\"#fff\" /></mask><g mask=\"url(#viewboxMask)\"><rect fill=\"#619eff\" width=\"80\" height=\"80\" x=\"0\" y=\"0\" /><path d=\"M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64\" fill=\"#ffd6c0\"/><path d=\"m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1\" fill=\"black\"/><path d=\"m35.05 46.19-.5.03c-1.29.07-1.3 2.04 0 2l13.82-.4c1.28-.03 1.29-2.03 0-2l-13.83.4v2l.5-.03c1.29-.07 1.3-2.07 0-2\" fill=\"black\"/><path d=\"M26.74 18.86s9.68 6.45 29.03 4.64c0 0-3.58 42.43 6.9 42.63s13.77-27.55 5.19-45.05C57.99.92 21.5-1.3 12.03 22.29c-9.47 23.6-.7 44.46 5.93 44.9 12.3.8 8.78-48.33 8.78-48.33\" fill=\"#ffffff\"/></g></svg>'),(5,'<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 80 80\" fill=\"none\" shape-rendering=\"auto\" width=\"512\" height=\"512\"><metadata xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:dcterms=\"http://purl.org/dc/terms/\"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type=\"dcterms:URI\">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type=\"dcterms:URI\">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of „Dylan! The Avatar Generator” (https://www.figma.com/community/file/1356575240759683500) by „Natalia Spivak”, licensed under „CC BY 4.0” (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id=\"viewboxMask\"><rect width=\"80\" height=\"80\" rx=\"0\" ry=\"0\" x=\"0\" y=\"0\" fill=\"#fff\" /></mask><g mask=\"url(#viewboxMask)\"><rect fill=\"#29e051\" width=\"80\" height=\"80\" x=\"0\" y=\"0\" /><path d=\"M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64\" fill=\"#ffd6c0\"/><path d=\"m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1\" fill=\"black\"/><path d=\"M30.5 32.66q.36-.4.77-.76l.09-.08.04-.03c-.12.09 0 0 .02 0l.12-.1.45-.3.44-.25.24-.12.14-.06c.03-.01.16-.07.02 0l.05-.02.1-.04.26-.1.55-.15c.5-.12.86-.73.7-1.23s-.7-.83-1.23-.7a8 8 0 0 0-4.17 2.52c-.34.4-.42 1.03 0 1.4.38.36 1.05.43 1.41 0m18.4-1.87q.9.15 1.8.43l.4.15.25.09.06.02-.06-.03c.02.04.19.08.23.1l.17.08.46.23c.46.25 1.1.13 1.37-.36.26-.5.13-1.1-.36-1.37a12 12 0 0 0-3.8-1.3c-.28-.03-.52-.04-.77.1a1 1 0 0 0-.46.6c-.1.49.15 1.15.7 1.24zM36.4 47.12a17 17 0 0 1 11.35-.1c1.22.4 1.74-1.52.53-1.94a18.8 18.8 0 0 0-12.4.1c-.5.19-.86.69-.7 1.24.12.49.71.88 1.22.7\" fill=\"black\"/><path d=\"M18.49 30.45s.13 3.91 1.44 3.8c1.3-.1 3.05-12.59 3.05-12.59s18.07 4.66 33.19-.65c0 0 1.72 13.2 3.34 13.07 1.38-.12 2.4-3.57 2.4-3.57 0 .02 4.47-8.58-.62-17.85-7.93-14.45-29.74-11.22-35.44-.21 0 0-5.9-.94-8.3 6.35-2.38 7.29.94 11.67.94 11.67\" fill=\"#1d5dff\"/></g></svg>'),(6,'<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 80 80\" fill=\"none\" shape-rendering=\"auto\" width=\"512\" height=\"512\"><metadata xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:dcterms=\"http://purl.org/dc/terms/\"><rdf:RDF><rdf:Description><dc:title>Dylan! The Avatar Generator</dc:title><dc:creator>Natalia Spivak</dc:creator><dc:source xsi:type=\"dcterms:URI\">https://www.figma.com/community/file/1356575240759683500</dc:source><dcterms:license xsi:type=\"dcterms:URI\">https://creativecommons.org/licenses/by/4.0/</dcterms:license><dc:rights>Remix of „Dylan! The Avatar Generator” (https://www.figma.com/community/file/1356575240759683500) by „Natalia Spivak”, licensed under „CC BY 4.0” (https://creativecommons.org/licenses/by/4.0/)</dc:rights></rdf:Description></rdf:RDF></metadata><mask id=\"viewboxMask\"><rect width=\"80\" height=\"80\" rx=\"0\" ry=\"0\" x=\"0\" y=\"0\" fill=\"#fff\" /></mask><g mask=\"url(#viewboxMask)\"><rect fill=\"#ffa6e6\" width=\"80\" height=\"80\" x=\"0\" y=\"0\" /><path d=\"M19.07 30.47s1.57-20.23 21.59-20.23S62.3 30.55 62.3 30.55s9.43-.8 9.43 7.6c0 8.42-9.28 7.13-9.28 7.13S60.9 67.15 42.03 67.15c-21.11 0-23.4-20.8-23.4-20.8s-9 .72-9.93-6.25c-1.08-8.2 10.37-9.64 10.37-9.64\" fill=\"#ffd6c0\"/><path d=\"m64.3 39.49.46-.41.1-.09c.12-.1-.13.1-.02.02l.24-.17q.5-.35 1.06-.62l.26-.12.05-.02.05-.02.58-.21q.6-.18 1.2-.28c.52-.08.85-.76.7-1.23-.18-.56-.67-.8-1.23-.7a9.3 9.3 0 0 0-4.87 2.43c-.38.36-.4 1.06 0 1.4.4.36 1 .4 1.4 0zm-51.8-1.16.14.01c-.27-.02-.11-.01-.04 0l.3.05.52.14.28.09.12.05c.02 0 .22.09.06.02-.14-.1 0-.04.03-.03l.15.06.26.13.47.3.27.22q.47.38.83.83c.33.4 1.07.37 1.41 0 .4-.43.36-.98 0-1.4a7.3 7.3 0 0 0-4.84-2.53c-.52-.06-1.02.5-1 1 .03.59.44.94 1 1m18.3-1.9v4.54c0 .52.46 1.02 1 1s1-.44 1-1V36.4c0-.52-.46-1.02-1-1s-1 .44-1 1M49.2 36l-.15 4.81a1 1 0 0 0 1 1c.56-.02.98-.44 1-1l.15-4.8a1 1 0 0 0-1-1 1 1 0 0 0-1 1\" fill=\"black\"/><path d=\"M32.92 49.45c1.24-2.82 4.75-4.07 7.63-4.27 3.08-.2 6.1.67 8.56 2.52 1.03.77 2.03-.96 1-1.73a14.5 14.5 0 0 0-10.1-2.75c-3.36.36-7.37 1.9-8.82 5.21-.5 1.17 1.2 2.2 1.73 1zm15.8-19.37q.15-.33.36-.6l-.16.2q.25-.34.58-.6l-.2.17q.33-.25.71-.41l-.24.1q.37-.15.75-.21l-.27.04s.1 0 .15-.02q.4-.02.7-.3a1 1 0 0 0 .3-.7c-.01-.25-.1-.53-.3-.71s-.44-.32-.7-.3a4.1 4.1 0 0 0-3.42 2.3c-.1.27-.18.5-.1.79.06.23.24.48.46.6q.36.2.77.1c.23-.08.5-.23.6-.46zM31.65 28.9l.18.03-.27-.04q.57.08 1.09.3l-.24-.1q.53.22.98.57l-.2-.16q.34.27.63.59c.16.2.47.29.7.29s.55-.1.72-.29c.4-.42.37-.99 0-1.41q-.65-.73-1.52-1.2a6 6 0 0 0-2.07-.59 1 1 0 0 0-1 1c0 .25.1.53.3.71q.3.27.7.29z\" fill=\"black\"/><path d=\"M25.51 20.1c-.23.95-.21 2.72 0 3.67s1.46 1.17 2.44 1.15c1.01-.01 1.75-.93 2.22-1.83q.87-1.7 1.16-3.59c-.09 1.82.42 4.03 2.15 4.6 1.2.37 2.53-.25 3.34-1.2a10 10 0 0 0 1.6-3.39c-.1 1.13-.2 2.3.16 3.36.35 1.07 1.27 2.05 2.4 2.1.92.03 1.76-.53 2.4-1.2a7 7 0 0 0 1.8-3.93c-.54 2 1.15 4.27 3.21 4.34s3.9-2.1 3.48-4.13c.31 1.57 1.44 3.04 3 3.43 1.54.41 3.41-.58 3.68-2.16a16 16 0 0 0-.79 8.68c.17.92.5 1.91 1.32 2.33s2.1-.36 1.76-1.2a16.8 16.8 0 0 0-3.86 10.6c0 1.3.2 2.7 1.12 3.6.92.91 2.78.9 3.29-.3-1.68 1.32-2.76 6.96-2.81 9.1-.04 1.95 0 4 .94 5.7s2.98 2.98 4.83 2.37c2.1-.7 3.73-6.6 3.35-8.79-.32.2-.21.75.1.95.33.2.75.14 1.12.03a5.1 5.1 0 0 0 3.5-3.88 5.1 5.1 0 0 0-1.87-4.88c.06.62 1.02.5 1.5.1A7.2 7.2 0 0 0 74.39 38c-.33-.95-1.13-1.97-2.12-1.79 1.32-.17 1.98-1.72 2-3.05.06-3.83-2.17-8.5-6-8.3.96-2.2.86-5.1-.71-6.93-2.54-2.96-4.1-2.55-6.48-2.19A6.5 6.5 0 0 0 59.1 9.2a6.5 6.5 0 0 0-6.74-1C51.3 6 48.84 4.77 46.42 4.4a6 6 0 0 0-3.17.2c-1 .41-1.83 1.33-1.88 2.4a8.56 8.56 0 0 0-11.19-.16c-.55.5-.97 1.5-.3 1.84 0 0-6.66-1.62-9.49 2.62s-1.13 5.79-1.13 5.79-6.92.28-6.78 3.95 1.27 4.24 1.27 4.24-6.01-1.72-7.29 1.79c-1.04 2.82 1.79 4.42 1.79 4.42 0-.05-5.4 2.22-4.24 7.6.75 3.5 3.4 4.1 3.4 4.1s-2.41 6.6-.15 9 5.22.42 5.22.42-1.41 7.2 1.84 8.33 5.36-2.12 5.36-2.12-2.12 6.07 2.54 5.5c4.66-.55 7.46-9.6 3.4-13.68-.01 0 2.1-3.96 1.4-7.35s-3.25-5.79-3.25-5.79 1.98-1.12 1.7-3.94c-.3-2.82-3.26-4.38-3.26-4.38s3.4-3.1 3.53-9.18\" fill=\"#fff500\"/></g></svg>');
/*!40000 ALTER TABLE `avatar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise`
--

DROP TABLE IF EXISTS `exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `choices` json NOT NULL,
  `type` enum('MULTIPLE_CHOICE','TRANSLATION','TRUE_FALSE','TALK') COLLATE utf8mb4_unicode_ci NOT NULL,
  `serieId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Exercise_serieId_fkey` (`serieId`),
  CONSTRAINT `Exercise_serieId_fkey` FOREIGN KEY (`serieId`) REFERENCES `exercisesserie` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=432 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise`
--

LOCK TABLES `exercise` WRITE;
/*!40000 ALTER TABLE `exercise` DISABLE KEYS */;
INSERT INTO `exercise` VALUES (2,'Comment dit-on \"Merci\" en anglais ?','thank you','[\"Thank you\", \"Sorry\", \"Please\", \"Goodbye\"]','MULTIPLE_CHOICE',1),(3,'\"Hello\" signifie \"au revoir\" en anglais.','false','[]','TRUE_FALSE',1),(4,'Traduisez en anglais : \"Je m\'appelle Pierre.\"','my name is pierre','[]','TRANSLATION',1),(5,'Comment dit-on \"chat\" en anglais ?','cat','[\"Dog\", \"Cat\", \"Bird\", \"Elephant\"]','MULTIPLE_CHOICE',1),(6,'\"Good morning\" est utilisé pour dire \"bonne nuit\".','false','[]','TRUE_FALSE',1),(7,'Traduisez en anglais : \"Je suis étudiant.\"','i am a student','[]','TRANSLATION',1),(8,'Comment dit-on \"oui\" en anglais ?','yes','[\"No\", \"Maybe\", \"Yes\", \"Please\"]','MULTIPLE_CHOICE',1),(17,'Comment dit-on \"un\" en anglais ?','one','[\"Two\", \"One\", \"Three\", \"Four\"]','MULTIPLE_CHOICE',2),(18,'En anglais, \"March\" signifie le mois de février.','false','[]','TRUE_FALSE',2),(19,'Traduisez en anglais : \"Je suis né le 15 mars.\"','i was born on march 15th','[]','TRANSLATION',2),(20,'Quel est le nombre correspondant à \"ten\" en anglais ?','10','[\"5\", \"10\", \"15\", \"20\"]','MULTIPLE_CHOICE',2),(21,'En anglais, \"Wednesday\" est le troisième jour de la semaine.','true','[]','TRUE_FALSE',2),(22,'Traduisez en anglais : \"Aujourd\'hui c\'est lundi, 3 avril.\"','today is monday april 3rd','[]','TRANSLATION',2),(23,'Comment dit-on \"septembre\" en anglais ?','september','[\"August\", \"September\", \"October\", \"November\"]','MULTIPLE_CHOICE',2),(24,'Quelle est la traduction de \"rouge\" en anglais ?','red','[\"Blue\", \"Green\", \"Red\", \"Yellow\"]','MULTIPLE_CHOICE',3),(25,'La couleur \"black\" signifie \"blanc\" en français.','false','[]','TRUE_FALSE',3),(26,'Traduisez en anglais : \"Mon sac est bleu.\"','my bag is blue','[]','TRANSLATION',3),(27,'Comment dit-on \"chaise\" en anglais ?','chair','[\"Table\", \"Chair\", \"Sofa\", \"Bed\"]','MULTIPLE_CHOICE',3),(28,'L\'objet \"mirror\" est un miroir.','true','[]','TRUE_FALSE',3),(29,'Traduisez en anglais : \"Ce crayon est jaune.\"','this pencil is yellow','[]','TRANSLATION',3),(30,'Quelle est la couleur de l\'herbe en anglais ?','green','[\"Purple\", \"Blue\", \"Green\", \"Orange\"]','MULTIPLE_CHOICE',3),(31,'Quelle est la traduction du verbe \"manger\" en anglais ?','eat','[\"Run\", \"Eat\", \"Sleep\", \"Read\"]','MULTIPLE_CHOICE',4),(32,'Le verbe \"to sleep\" signifie \"dormir\" en français.','true','[]','TRUE_FALSE',4),(33,'Traduisez en anglais : \"Je bois un café.\"','i drink a coffee','[]','TRANSLATION',4),(34,'Comment dit-on \"écrire\" en anglais ?','write','[\"Read\", \"Talk\", \"Write\", \"Walk\"]','MULTIPLE_CHOICE',4),(35,'Le verbe \"to run\" signifie \"marcher\" en français.','false','[]','TRUE_FALSE',4),(36,'Traduisez en anglais : \"Il lit un livre.\"','he reads a book','[]','TRANSLATION',4),(37,'Comment dit-on \"Je m\'appelle...\" en anglais ?','my name is','[\"I am...\", \"My name is...\", \"I have...\", \"My age is...\"]','MULTIPLE_CHOICE',5),(38,'La phrase \"I am 25 years old\" signifie \"J\'ai 25 ans\".','true','[]','TRUE_FALSE',5),(39,'Traduisez en anglais : \"J\'habite à Paris.\"','i live in paris','[]','TRANSLATION',5),(40,'Comment demander à quelqu\'un son prénom en anglais ?','what is your name','[\"How are you?\", \"Where do you live?\", \"What is your name?\", \"How old are you?\"]','MULTIPLE_CHOICE',5),(41,'La phrase \"He is from England\" signifie \"Il vient d\'Espagne\".','false','[]','TRUE_FALSE',5),(42,'Traduisez en anglais : \"Je suis étudiant.\"','i am a student','[]','TRANSLATION',5),(43,'Comment dit-on \"Bonjour\" en anglais ?','hello','[\"Goodbye\", \"Hello\", \"Please\", \"Thank you\"]','MULTIPLE_CHOICE',6),(44,'La phrase \"Good evening\" signifie \"Bonne nuit\".','false','[]','TRUE_FALSE',6),(45,'Traduisez en anglais : \"Merci beaucoup.\"','thank you very much','[]','TRANSLATION',6),(46,'Comment dit-on \"Au revoir\" en anglais ?','goodbye','[\"Hello\", \"Please\", \"Goodbye\", \"Sorry\"]','MULTIPLE_CHOICE',6),(47,'La phrase \"Excuse me\" signifie \"Excusez-moi\".','true','[]','TRUE_FALSE',6),(48,'Traduisez en anglais : \"S\'il vous plaît.\"','please','[]','TRANSLATION',6),(49,'Comment dit-on \"Mère\" en anglais ?','mother','[\"Father\", \"Sister\", \"Mother\", \"Brother\"]','MULTIPLE_CHOICE',7),(50,'Le mot \"Uncle\" signifie \"Cousin\" en français.','false','[]','TRUE_FALSE',7),(51,'Traduisez en anglais : \"Mon frère\".','my brother','[]','TRANSLATION',7),(52,'Comment dit-on \"Grand-mère\" en anglais ?','grandmother','[\"Grandfather\", \"Grandmother\", \"Aunt\", \"Sister\"]','MULTIPLE_CHOICE',7),(53,'Le mot \"Nephew\" signifie \"Neveu\" en français.','true','[]','TRUE_FALSE',7),(54,'Traduisez en anglais : \"Ma tante\".','my aunt','[]','TRANSLATION',7),(55,'Comment dit-on \"Chien\" en anglais ?','dog','[\"Cat\", \"Rabbit\", \"Dog\", \"Cow\"]','MULTIPLE_CHOICE',8),(56,'Le mot \"Elephant\" signifie \"Tigre\" en français.','false','[]','TRUE_FALSE',8),(57,'Traduisez en anglais : \"Un oiseau\".','a bird','[]','TRANSLATION',8),(58,'Comment dit-on \"Chat\" en anglais ?','cat','[\"Dog\", \"Cat\", \"Mouse\", \"Horse\"]','MULTIPLE_CHOICE',8),(59,'Le mot \"Cow\" signifie \"Vache\" en français.','true','[]','TRUE_FALSE',8),(60,'Traduisez en anglais : \"Un poisson rouge\".','a goldfish','[]','TRANSLATION',8),(61,'Comment dit-on \"Cheval\" en anglais ?','horse','[\"Goat\", \"Horse\", \"Donkey\", \"Sheep\"]','MULTIPLE_CHOICE',8),(62,'Le mot \"Sheep\" signifie \"Chèvre\" en français.','false','[]','TRUE_FALSE',8),(63,'Comment dit-on \"Pomme\" en anglais ?','apple','[\"Banana\", \"Apple\", \"Grapes\", \"Pear\"]','MULTIPLE_CHOICE',9),(64,'Le mot \"Water\" signifie \"Eau\" en français.','true','[]','TRUE_FALSE',9),(65,'Traduisez en anglais : \"Un verre de lait\".','a glass of milk','[]','TRANSLATION',9),(66,'Comment dit-on \"Pain\" en anglais ?','bread','[\"Butter\", \"Bread\", \"Cheese\", \"Cake\"]','MULTIPLE_CHOICE',9),(67,'Le mot \"Juice\" signifie \"Lait\" en français.','false','[]','TRUE_FALSE',9),(68,'Traduisez en anglais : \"Un sandwich au jambon\".','a ham sandwich','[]','TRANSLATION',9),(69,'Comment dit-on \"Riz\" en anglais ?','rice','[\"Pasta\", \"Rice\", \"Soup\", \"Meat\"]','MULTIPLE_CHOICE',9),(70,'Le mot \"Cheese\" signifie \"Fromage\" en français.','true','[]','TRUE_FALSE',9),(71,'Traduisez en anglais : \"Une tasse de thé\".','a cup of tea','[]','TRANSLATION',9),(72,'Comment dit-on \"École\" en anglais ?','school','[\"Hospital\", \"School\", \"Park\", \"Restaurant\"]','MULTIPLE_CHOICE',10),(73,'Le mot \"Library\" signifie \"Bibliothèque\" en français.','true','[]','TRUE_FALSE',10),(74,'Traduisez en anglais : \"Un café\".','a coffee shop','[]','TRANSLATION',10),(75,'Comment dit-on \"Musée\" en anglais ?','museum','[\"Library\", \"Museum\", \"Cinema\", \"Park\"]','MULTIPLE_CHOICE',10),(76,'Le mot \"Post office\" signifie \"Bureau de poste\" en français.','true','[]','TRUE_FALSE',10),(77,'Traduisez en anglais : \"Une gare\".','a train station','[]','TRANSLATION',10),(78,'Comment dit-on \"Hôpital\" en anglais ?','hospital','[\"School\", \"Hospital\", \"Supermarket\", \"Restaurant\"]','MULTIPLE_CHOICE',10),(79,'Comment dit-on \"Comment ça va ?\" en anglais ?','how are you','[\"How are you?\", \"Where are you?\", \"What is up?\", \"How do you do?\"]','MULTIPLE_CHOICE',11),(80,'Traduisez en anglais : \"Je vais bien, merci.\"','im fine thank you','[]','TRANSLATION',11),(81,'Vrai ou Faux : En anglais, on dit \"How is it going ?\" pour demander à quelqu\'un comment il va.','true','[]','TRUE_FALSE',11),(82,'Comment dit-on \"Je m\'appelle...\" en anglais ?','my name is','[\"I am...\", \"My name is...\", \"It\'s me...\", \"I call myself...\"]','MULTIPLE_CHOICE',11),(83,'Traduisez en anglais : \"J\'habite à Paris.\"','i live in paris','[]','TRANSLATION',11),(84,'Vrai ou Faux : \"I work at home\" signifie que je travaille chez moi.','true','[]','TRUE_FALSE',11),(85,'Comment dit-on \"Combien ça coûte ?\" en anglais ?','how much does it cost','[\"How much is it?\", \"How much does it cost?\", \"What is the price?\", \"How much for this?\"]','MULTIPLE_CHOICE',12),(86,'Traduisez en anglais : \"Je voudrais acheter un livre.\"','i would like to buy a book','[]','TRANSLATION',12),(87,'Vrai ou Faux : En anglais, \"How much for this?\" veut dire \"Combien ça coûte ?\".','true','[]','TRUE_FALSE',12),(88,'Comment dit-on \"Je cherche un cadeau pour mon ami.\" en anglais ?','im looking for a gift for my friend','[\"I am finding a gift for my friend.\", \"I\'m looking for a gift for my friend.\", \"I seek a gift for my friend.\", \"I\'m shopping for a gift for my friend.\"]','MULTIPLE_CHOICE',12),(89,'Traduisez en anglais : \"C\'est trop cher.\"','its too expensive','[]','TRANSLATION',12),(90,'Comment dit-on \"Où est l’aéroport ?\" en anglais ?','where is the airport','[\"Where is the station?\", \"Where is the hotel?\", \"Where is the airport?\", \"Where is the bus stop?\"]','MULTIPLE_CHOICE',13),(91,'Traduisez en anglais : \"Je voudrais un billet aller-retour.\"','i would like a round-trip ticket','[]','TRANSLATION',13),(92,'Vrai ou Faux : \"Can you help me?\" veut dire \"Pouvez-vous m’aider ?\".','true','[]','TRUE_FALSE',13),(93,'Comment dit-on \"Quel est le prochain vol pour Londres ?\" en anglais ?','what is the next flight to london','[\"What is the flight to London?\", \"What is the next flight to London?\", \"When is the flight to London?\", \"Where is the flight to London?\"]','MULTIPLE_CHOICE',13),(94,'Traduisez en anglais : \"Je suis perdu, pouvez-vous m’aider ?\"','im lost can you help me','[]','TRANSLATION',13),(95,'Comment dit-on \"J’aime jouer au football\" en anglais ?','i like to play football','[\"I like playing football.\", \"I like to play football.\", \"I like to play soccer.\", \"I love playing football.\"]','MULTIPLE_CHOICE',14),(96,'Traduisez en anglais : \"Quel est ton passe-temps préféré ?\"','what is your favorite hobby','[]','TRANSLATION',14),(97,'Vrai ou Faux : \"I enjoy watching movies\" signifie \"J’aime regarder des films\".','true','[]','TRUE_FALSE',14),(98,'Comment dit-on \"Elle aime la lecture\" en anglais ?','she likes reading','[\"She loves reading.\", \"She likes reading.\", \"She likes to read.\", \"She loves to read.\"]','MULTIPLE_CHOICE',14),(99,'Traduisez en anglais : \"Je vais au gymnase trois fois par semaine.\"','i go to the gym three times a week','[]','TRANSLATION',14),(100,'Vrai ou Faux : \"They are playing tennis\" veut dire \"Ils jouent au tennis\".','true','[]','TRUE_FALSE',14),(101,'Traduisez en anglais : \"J’aime aller courir dans le parc.\"','i like to run in the park','[]','TRANSLATION',14),(102,'Quel est l’équivalent de \"I enjoy swimming\" en français ?','j’aime nager','[\"J’aime nager.\", \"J’aime la natation.\", \"Je nage bien.\", \"J’aime faire du sport.\"]','MULTIPLE_CHOICE',14),(103,'Traduisez en anglais : \"Il pleut beaucoup aujourd\'hui.\"','it’s raining a lot today','[]','TRANSLATION',15),(104,'Vrai ou Faux : \"It’s sunny\" signifie qu’il pleut.','false','[]','TRUE_FALSE',15),(105,'Comment dit-on \"Il neige en hiver\" en anglais ?','it snows in winter','[\"It snows in winter.\", \"It rains in winter.\", \"It’s sunny in winter.\", \"It’s cold in winter.\"]','MULTIPLE_CHOICE',15),(106,'Traduisez en anglais : \"La météo est chaude en été.\"','the weather is hot in summer','[]','TRANSLATION',15),(107,'Comment dit-on \"Il fait frais au printemps\" en anglais ?','it’s cool in spring','[\"It’s cold in spring.\", \"It’s hot in spring.\", \"It’s cool in spring.\", \"It’s windy in spring.\"]','MULTIPLE_CHOICE',15),(108,'Vrai ou Faux : \"In the autumn, the leaves fall from the trees.\" signifie \"En automne, les feuilles tombent des arbres.\"','true','[]','TRUE_FALSE',15),(109,'Comment dit-on \"Il y a un orage\" en anglais ?','there’s a storm','[\"It’s a storm.\", \"There’s a storm.\", \"It’s raining.\", \"There’s lightning.\"]','MULTIPLE_CHOICE',15),(110,'Comment dit-on \"Elle porte une robe rouge\" en anglais ?','she is wearing a red dress','[\"She wears a red dress.\", \"She is wearing a red dress.\", \"She has a red dress.\", \"She is dressed in a red dress.\"]','MULTIPLE_CHOICE',16),(111,'Vrai ou Faux : \"He has black hair\" signifie \"Il a les cheveux noirs\".','true','[]','TRUE_FALSE',16),(112,'Traduisez en anglais : \"Il porte des lunettes.\"','he is wearing glasses','[]','TRANSLATION',16),(113,'Comment dit-on \"Elle est grande et mince\" en anglais ?','she is tall and slim','[\"She is tall and slim.\", \"She is tall and thin.\", \"She is small and slim.\", \"She is tall and fat.\"]','MULTIPLE_CHOICE',16),(114,'Traduisez en anglais : \"Il a une barbe.\"','he has a beard','[]','TRANSLATION',16),(115,'Vrai ou Faux : \"She has blue eyes\" signifie \"Elle a les yeux verts\".','false','[]','TRUE_FALSE',16),(116,'Comment dit-on \"Je porte un t-shirt bleu\" en anglais ?','i am wearing a blue t-shirt','[\"I am wearing a blue t-shirt.\", \"I wear a blue t-shirt.\", \"I am dressed in a blue t-shirt.\", \"I have a blue t-shirt.\"]','MULTIPLE_CHOICE',16),(117,'Traduisez en anglais : \"Elle a de longs cheveux blonds.\"','she has long blonde hair','[]','TRANSLATION',16),(118,'Comment dit-on \"Je suis heureux\" en anglais ?','i am happy','[\"I am happy.\", \"I am glad.\", \"I am joy.\", \"I feel good.\"]','MULTIPLE_CHOICE',17),(119,'Vrai ou Faux : \"She feels sad\" signifie \"Elle se sent triste\".','true','[]','TRUE_FALSE',17),(120,'Traduisez en anglais : \"Il est en colère.\"','he is angry','[]','TRANSLATION',17),(121,'Comment dit-on \"Je suis fatigué\" en anglais ?','i am tired','[\"I am tired.\", \"I am sleepy.\", \"I feel exhausted.\", \"I am weak.\"]','MULTIPLE_CHOICE',17),(122,'Traduisez en anglais : \"Elle se sent nerveuse.\"','she feels nervous','[]','TRANSLATION',17),(123,'Vrai ou Faux : \"He is excited\" signifie \"Il est excité\".','true','[]','TRUE_FALSE',17),(124,'Comment dit-on \"Ils sont inquiets\" en anglais ?','they are worried','[\"They are worried.\", \"They are anxious.\", \"They are stressed.\", \"They are fearful.\"]','MULTIPLE_CHOICE',17),(125,'Traduisez en anglais : \"Je me sens heureux aujourd\'hui.\"','i feel happy today','[]','TRANSLATION',17),(126,'Comment dit-on \"Je voudrais une pizza, s\'il vous plaît\" en anglais ?','i would like a pizza please','[\"I would like a pizza, please.\", \"Can I have a pizza?\", \"I want a pizza.\", \"Give me a pizza.\"]','MULTIPLE_CHOICE',18),(127,'Vrai ou Faux : \"How much is the bill?\" signifie \"Combien coûte l\'addition ?\".','true','[]','TRUE_FALSE',18),(128,'Traduisez en anglais : \"Je voudrais un verre d\'eau.\"','i would like a glass of water','[]','TRANSLATION',18),(129,'Comment dit-on \"L\'addition, s\'il vous plaît\" en anglais ?','the check please','[\"The check, please.\", \"Can I have the bill?\", \"Please bring me the bill.\", \"Give me the check.\"]','MULTIPLE_CHOICE',18),(130,'Vrai ou Faux : \"What is the special?\" signifie \"Quel est le plat du jour ?\".','true','[]','TRUE_FALSE',18),(131,'Traduisez en anglais : \"J\'aimerais un dessert, s\'il vous plaît.\"','i would like a dessert please','[]','TRANSLATION',18),(132,'Comment dit-on \"Je n\'aime pas ce plat\" en anglais ?','i dont like this dish','[\"I don\'t like this dish.\", \"This dish is not good.\", \"I hate this meal.\", \"This food is bad.\"]','MULTIPLE_CHOICE',18),(133,'Comment dit-on \"Où est la station de métro ?\" en anglais ?','where is the subway station','[\"Where is the subway station?\", \"Where is the bus stop?\", \"How do I get to the subway?\", \"Where is the train station?\"]','MULTIPLE_CHOICE',19),(134,'Vrai ou Faux : \"I need a taxi.\" signifie \"J\'ai besoin d\'un taxi.\".','true','[]','TRUE_FALSE',19),(135,'Traduisez en anglais : \"Je voudrais acheter un billet de train.\"','i would like to buy a train ticket','[]','TRANSLATION',19),(136,'Comment dit-on \"Est-ce que ce bus va à la gare ?\" en anglais ?','does this bus go to the station','[\"Does this bus go to the station?\", \"Is this bus going to the train station?\", \"Where does this bus go?\", \"Is this bus on time?\"]','MULTIPLE_CHOICE',19),(137,'Vrai ou Faux : \"I’m looking for the airport.\" signifie \"Je cherche l’aéroport.\".','true','[]','TRUE_FALSE',19),(138,'Traduisez en anglais : \"Pouvez-vous me dire comment aller à l’hôtel ?\"','can you tell me how to get to the hotel','[]','TRANSLATION',19),(139,'Traduisez en anglais : \"Il mangea une pomme.\"','he ate an apple','[]','TRANSLATION',20),(140,'Vrai ou Faux : \"They played football yesterday.\" signifie \"Ils ont joué au football hier.\".','true','[]','TRUE_FALSE',20),(141,'Comment dit-on \"Elle arriva en retard.\" en anglais ?','she arrived late','[\"She arrived late.\", \"She arrive late.\", \"She arrives late.\", \"She was arriving late.\"]','MULTIPLE_CHOICE',20),(142,'Traduisez en anglais : \"Nous allâmes au cinéma hier.\"','we went to the cinema yesterday','[]','TRANSLATION',20),(143,'Vrai ou Faux : \"He see the movie yesterday.\" est correct.','false','[]','TRUE_FALSE',20),(144,'Complétez la phrase : \"They ______ (to visit) their grandmother last week.\"','visited','[\"visit\", \"visited\", \"visits\", \"will visit\"]','MULTIPLE_CHOICE',20),(145,'Traduisez en anglais : \"Elle parla très fort.\"','she spoke very loudly','[]','TRANSLATION',20),(146,'Vrai ou Faux : \"I was seeing a movie last night.\" signifie \"Je regardais un film hier soir.\".','false','[]','TRUE_FALSE',20),(147,'Complétez la phrase : \"He ______ (to be) happy at the party last night.\"','was','[\"was\", \"were\", \"be\", \"is\"]','MULTIPLE_CHOICE',20),(148,'Traduisez en anglais : \"Je me souviens de ma première journée à l\'école.\"','i remember my first day at school','[]','TRANSLATION',21),(149,'Vrai ou Faux : \"I was visiting Paris last year.\" signifie \"Je visitais Paris l\'année dernière.\".','false','[]','TRUE_FALSE',21),(150,'Comment dit-on \"J\'ai eu une expérience incroyable en voyageant.\" en anglais ?','i had an amazing experience while traveling','[\"I have an amazing experience while traveling.\", \"I had an amazing experience while traveling.\", \"I had amazing experience while traveling.\", \"I had an experience amazing while traveling.\"]','MULTIPLE_CHOICE',21),(151,'Complétez la phrase : \"I ______ (to meet) some amazing people during my trip.\"','met','[\"meet\", \"met\", \"meets\", \"meeting\"]','MULTIPLE_CHOICE',21),(152,'Traduisez en anglais : \"Nous avons fait un voyage incroyable en Italie.\"','we had an amazing trip to italy','[]','TRANSLATION',21),(153,'Vrai ou Faux : \"She was telling a story about her childhood.\" signifie \"Elle racontait une histoire sur son enfance.\".','true','[]','TRUE_FALSE',21),(154,'Complétez la phrase : \"Last summer, I ______ (to go) to the beach every day.\"','went','[\"go\", \"goes\", \"went\", \"gone\"]','MULTIPLE_CHOICE',21),(155,'Traduisez en anglais : \"Elle se souvient encore de ce moment.\"','she still remembers that moment','[]','TRANSLATION',21),(156,'Vrai ou Faux : \"They visited the museum last weekend.\" est correct.','true','[]','TRUE_FALSE',21),(157,'Traduisez en anglais : \"Je pense que c\'est une bonne idée.\"','i think its a good idea','[]','TRANSLATION',22),(158,'Traduisez en anglais : \"À mon avis, ce film est ennuyeux.\"','in my opinion this movie is boring','[]','TRANSLATION',22),(159,'Quelle phrase est correcte ?','i believe that its a great idea','[\"I believe that it\'s a great idea.\", \"I think that it\'s a great idea.\", \"I imagine that it\'s a great idea.\", \"I guess that it\'s a great idea.\"]','MULTIPLE_CHOICE',22),(160,'Est-ce que tu es d\'accord avec cette idée ?','yes i totally agree','[\"Yes, I totally agree.\", \"No, I don\'t agree.\", \"I\'m not sure.\", \"Maybe.\"]','TRUE_FALSE',22),(161,'Traduisez en anglais : \"Je ne suis pas sûr que ce soit une bonne solution.\"','im not sure its a good solution','[]','TRANSLATION',22),(162,'Traduisez en anglais : \"Je suis d\'accord avec toi, mais...\"','i agree with you but','[]','TRANSLATION',22),(163,'Complétez la phrase : \"In my opinion, ...\"','i think this is a great approach','[]','TRANSLATION',22),(164,'Vrai ou faux : \"You can express your opinion by saying \'I think\' or \'In my opinion\'\".','true','[]','TRUE_FALSE',22),(165,'Traduisez en anglais : \"Je ne suis pas d\'accord avec cette idée.\"','i dont agree with this idea','[]','TRANSLATION',22),(166,'Quelle phrase exprime mieux un avis personnel ?','in my opinion its a great idea','[\"In my opinion, it\'s a great idea.\", \"I think it\'s a great idea.\", \"I feel that it\'s a great idea.\", \"It\'s a great idea.\"]','MULTIPLE_CHOICE',22),(167,'Traduisez en anglais : \"Je vous écris pour vous informer que...\"','i am writing to inform you that','[]','TRANSLATION',23),(168,'Complétez l\'email formel : \"Dear Sir/Madam, I am writing to ___ you about the recent changes.\"','inform','[\"inform\", \"request\", \"ask\", \"remind\"]','MULTIPLE_CHOICE',23),(169,'Traduisez en anglais : \"Nous vous remercions pour votre réponse rapide.\"','we thank you for your prompt reply','[]','TRANSLATION',23),(170,'Quel est le ton d\'un email formel ?','polite and professional','[\"Casual and friendly\", \"Polite and professional\", \"Direct and harsh\", \"Personal and informal\"]','MULTIPLE_CHOICE',23),(171,'Vrai ou faux : \"Dans un email formel, il est important de commencer par une salutation appropriée.\"','true','[]','TRUE_FALSE',23),(172,'Complétez la phrase : \"I look forward to ___ from you soon.\"','hearing','[\"hearing\", \"listening\", \"speaking\", \"talking\"]','MULTIPLE_CHOICE',23),(173,'Traduisez en anglais : \"Je vous prie d\'agréer, Madame, l\'expression de mes salutations distinguées.\"','yours sincerely','[]','TRANSLATION',23),(174,'Quel est le but principal d\'un email formel ?','to communicate professionally and clearly','[\"To communicate professionally and clearly.\", \"To express personal feelings.\", \"To make informal requests.\", \"To write in a casual tone.\"]','MULTIPLE_CHOICE',23),(175,'Vrai ou faux : \"Les emails formels doivent toujours inclure un objet précis et clair.\"','true','[]','TRUE_FALSE',23),(176,'Traduisez en anglais : \"Je vous prie de bien vouloir trouver ci-joint le document demandé.\"','please find attached the requested document','[]','TRANSLATION',23),(177,'Traduisez en anglais : \"Il pleut des cordes.\"','its raining cats and dogs','[]','TRANSLATION',24),(178,'Complétez l\'expression : \"To be in hot ___\"','water','[\"water\", \"coffee\", \"trouble\", \"fire\"]','MULTIPLE_CHOICE',24),(179,'Vrai ou faux : L\'expression \'to break the ice\' signifie commencer une conversation dans un contexte social.','true','[]','TRUE_FALSE',24),(180,'Complétez l\'expression : \"To burn the midnight ___\"','oil','[\"oil\", \"light\", \"fire\", \"clock\"]','MULTIPLE_CHOICE',24),(181,'Traduisez en anglais : \"Avoir un chat dans la gorge.\"','to have a frog in ones throat','[]','TRANSLATION',24),(182,'Quel est le sens de l\'expression \'to hit the nail on the head\' ?','to describe exactly what is causing a situation or problem','[\"To describe exactly what is causing a situation or problem.\", \"To make a mistake.\", \"To be very tired.\", \"To explain something confusing.\"]','MULTIPLE_CHOICE',24),(183,'Complétez l\'expression : \"A piece of ___\"','cake','[\"cake\", \"pie\", \"bread\", \"chocolate\"]','MULTIPLE_CHOICE',24),(184,'Vrai ou faux : L\'expression \'to kick the bucket\' signifie mourir.','true','[]','TRUE_FALSE',24),(185,'Traduisez en anglais : \"Il est important de respecter les coutumes locales.\"','it is important to respect local customs','[]','TRANSLATION',25),(186,'Complétez l\'expression : \"When in Rome, do as the ___ do.\"','romans','[\"Romans\", \"French\", \"English\", \"Americans\"]','MULTIPLE_CHOICE',25),(187,'Vrai ou faux : L\'expression \'to break the ice\' est utilisée pour initier une conversation avec des inconnus dans une situation sociale.','true','[]','TRUE_FALSE',25),(188,'Quel pays célèbre-t-on généralement en novembre pour ses actions de grâce ?','les états-unis','[\"Les États-Unis\", \"Le Canada\", \"Le Royaume-Uni\", \"L\'Australie\"]','MULTIPLE_CHOICE',25),(189,'Traduisez en anglais : \"La politesse est essentielle dans les cultures asiatiques.\"','politeness is essential in asian cultures','[]','TRANSLATION',25),(190,'Complétez l\'expression : \"To make a ___ of oneself.\"','fool','[\"fool\", \"hero\", \"judge\", \"friend\"]','MULTIPLE_CHOICE',25),(191,'Vrai ou faux : En Chine, il est courtois d\'offrir un cadeau avec les deux mains.','true','[]','TRUE_FALSE',25),(192,'Quel est le principal repas de la journée dans de nombreux pays européens ?','le déjeuner','[\"Le dîner\", \"Le petit-déjeuner\", \"Le déjeuner\", \"Le goûter\"]','MULTIPLE_CHOICE',25),(193,'Traduisez en anglais : \"Elle est infirmière dans un hôpital.\"','she is a nurse in a hospital','[]','TRANSLATION',26),(194,'Quel est le métier de quelqu\'un qui conçoit des bâtiments ?','architect','[\"Chef\", \"Teacher\", \"Architect\", \"Mechanic\"]','MULTIPLE_CHOICE',26),(195,'Vrai ou faux : Un avocat est un professionnel qui défend des clients dans les tribunaux.','true','[]','TRUE_FALSE',26),(196,'Traduisez en anglais : \"Il travaille comme directeur marketing dans une grande entreprise.\"','he works as a marketing director in a large company','[]','TRANSLATION',26),(197,'Complétez l\'expression : \"To make a ___ of a living.\"','living','[\"dream\", \"life\", \"living\", \"fortune\"]','MULTIPLE_CHOICE',26),(198,'Vrai ou faux : Les médecins travaillent généralement dans des cabinets de consultation, des hôpitaux ou des cliniques.','true','[]','TRUE_FALSE',26),(199,'Quel métier est lié à la création de logiciels et de sites web ?','développeur informatique','[\"Médecin\", \"Ingénieur\", \"Développeur informatique\", \"Chef\"]','MULTIPLE_CHOICE',26),(200,'Traduisez en anglais : \"Il est à la retraite depuis deux ans.\"','he has been retired for two years','[]','TRANSLATION',26),(201,'Traduisez en anglais : \"J\'ai vu les dernières nouvelles à la télévision.\"','i saw the latest news on tv','[]','TRANSLATION',27),(202,'Quel est le rôle d\'un journaliste ?','un journaliste écrit et rapporte des informations','[\"Un médecin soigne les malades.\", \"Un journaliste écrit et rapporte des informations.\", \"Un professeur enseigne.\", \"Un avocat défend les clients.\"]','MULTIPLE_CHOICE',27),(203,'Vrai ou faux : Les médias sociaux ont remplacé les journaux traditionnels dans certains pays.','true','[]','TRUE_FALSE',27),(204,'Traduisez en anglais : \"Ils ont publié un article intéressant sur l\'environnement.\"','they published an interesting article about the environment','[]','TRANSLATION',27),(205,'Quel terme décrit un reportage vidéo ou un film court sur un sujet d\'actualité ?','documentary','[\"Article\", \"Ad\", \"Documentary\", \"Newsflash\"]','MULTIPLE_CHOICE',27),(206,'Vrai ou faux : La presse écrite est plus populaire que les sites d\'actualités en ligne.','false','[]','TRUE_FALSE',27),(207,'Traduisez en anglais : \"Elle suit tous les comptes d\'actualités sur Twitter.\"','she follows all the news accounts on twitter','[]','TRANSLATION',27),(208,'Quel média permet de diffuser de l\'information en direct et en continu ?','la télévision','[\"La télévision\", \"Le journal\", \"La radio\", \"L\'ordinateur\"]','MULTIPLE_CHOICE',27),(209,'Vrai ou faux : Un journaliste peut écrire des articles sur des sujets variés, de la politique à la culture.','true','[]','TRUE_FALSE',27),(210,'Traduisez en anglais : \"Allô, je suis à l\'autre bout du fil.\"','hello im on the other line','[]','TRANSLATION',28),(211,'Que signifie \'caller ID\' dans le contexte d\'un appel téléphonique ?','caller id means the phone number or name of the person calling','[\"It means the phone number or name of the person calling.\", \"It means the person\'s address.\", \"It is a type of phone number you can call.\", \"It means voicemail.\"]','MULTIPLE_CHOICE',28),(212,'Vrai ou faux : Pour répondre à un appel téléphonique, il faut dire \'Hello\'.','true','[]','TRUE_FALSE',28),(213,'Traduisez en anglais : \"Puis-je parler à M. Dupont, s\'il vous plaît ?\"','can i speak to mr dupont please','[]','TRANSLATION',28),(214,'Comment dire \'Je suis occupé en ce moment\' au téléphone ?','im busy at the moment','[\"I\'m free right now.\", \"I\'m busy at the moment.\", \"I don\'t have time.\", \"I\'m in a meeting.\"]','MULTIPLE_CHOICE',28),(215,'Vrai ou faux : Lorsque vous devez rappeler quelqu\'un, vous pouvez dire \'I will call you back\'.','true','[]','TRUE_FALSE',28),(216,'Traduisez en anglais : \"Pouvez-vous laisser un message après le bip ?\"','can you leave a message after the beep','[]','TRANSLATION',28),(217,'Que dire si vous ne pouvez pas entendre la personne pendant un appel téléphonique ?','can you repeat that i cant hear you','[\"Can you repeat that? I can\'t hear you.\", \"I didn\'t understand.\", \"Please speak louder.\", \"I\'m sorry, I missed your question.\"]','MULTIPLE_CHOICE',28),(218,'Vrai ou faux : Pour indiquer que l\'appel est terminé, vous pouvez dire \'Goodbye\'.','true','[]','TRUE_FALSE',28),(219,'Traduisez en anglais : \"Je suis désolé, mais il n\'est pas disponible pour le moment.\"','im sorry but hes not available at the moment','[]','TRANSLATION',28),(220,'Traduisez en anglais : \"Je voudrais réserver un vol pour Paris.\"','i would like to book a flight to paris','[]','TRANSLATION',29),(221,'Que signifie \'jet lag\' ?','jet lag refers to the fatigue caused by traveling across time zones','[\"Jet lag refers to the fatigue caused by traveling across time zones.\", \"Jet lag refers to a type of airplane.\", \"Jet lag is another term for travel sickness.\", \"Jet lag refers to a type of travel bag.\"]','MULTIPLE_CHOICE',29),(222,'Vrai ou faux : Pour réserver une chambre d\'hôtel, vous pouvez dire \'I\'d like to make a reservation.\'','true','[]','TRUE_FALSE',29),(223,'Traduisez en anglais : \"Quel est le prix d\'un billet pour le musée ?\"','what is the price of a ticket to the museum','[]','TRANSLATION',29),(224,'Comment demander son chemin dans une ville en anglais ?','excuse me can you tell me the way to the nearest bus stop','[\"Excuse me, can you tell me the way to the nearest bus stop?\", \"Excuse me, where is the airport?\", \"Could you show me the map?\", \"Is there a train station near here?\"]','MULTIPLE_CHOICE',29),(225,'Vrai ou faux : Si vous êtes perdu dans une ville, vous pouvez demander \'Where am I?\'','true','[]','TRUE_FALSE',29),(226,'Traduisez en anglais : \"Nous partons en voyage à Londres demain.\"','we are going on a trip to london tomorrow','[]','TRANSLATION',29),(227,'Quel est l\'objectif d\'un guide touristique ?','a tour guide provides information and guidance to tourists','[\"A tour guide provides information and guidance to tourists.\", \"A tour guide books flights for travelers.\", \"A tour guide helps with luggage.\", \"A tour guide organizes hotel rooms.\"]','MULTIPLE_CHOICE',29),(228,'Vrai ou faux : Lorsque vous vous enregistrez à l\'aéroport, vous devez montrer votre passeport.','true','[]','TRUE_FALSE',29),(229,'Traduisez en anglais : \"Est-ce que ce train va à Berlin ?\"','does this train go to berlin','[]','TRANSLATION',29),(230,'Traduisez en anglais : \"L\'argument le plus fort contre l\'utilisation de la technologie est la perte de vie privée.\"','the strongest argument against the use of technology is the loss of privacy','[]','TRANSLATION',30),(231,'Vrai ou faux : L\'expression \'On the other hand\' est utilisée pour ajouter un contre-argument.','true','[]','TRUE_FALSE',30),(232,'Traduisez en anglais : \"Certains disent que l\'intelligence artificielle peut remplacer des emplois, mais d\'autres pensent qu\'elle peut créer de nouvelles opportunités.\"','some say artificial intelligence can replace jobs but others believe it can create new opportunities','[]','TRANSLATION',30),(233,'Quel est le meilleur moyen de commencer une argumentation en anglais ?','a good way to start an argument is by saying i believe that or in my opinion','[\"A good way to start an argument is by saying \'I believe that...\' or \'In my opinion...\'\", \"The best way is to say \'I don\'t care about this topic.\'\", \"You should always start by saying \'You are wrong!\'\", \"There is no need to start an argument at all.\"]','MULTIPLE_CHOICE',30),(234,'Vrai ou faux : L\'expression \'to play devil\'s advocate\' signifie défendre une position que l\'on ne soutient pas pour tester l\'argumentation.','true','[]','TRUE_FALSE',30),(235,'Traduisez en anglais : \"Les deux côtés de ce débat ont des points valables, mais il faut aussi considérer les conséquences à long terme.\"','both sides of this debate have valid points but we must also consider the long-term consequences','[]','TRANSLATION',30),(236,'Quel est le but de l\'argumentation dans un débat ?','the goal of argumentation in a debate is to persuade others to accept your point of view using evidence and logic','[\"The goal of argumentation in a debate is to persuade others to accept your point of view using evidence and logic.\", \"To confuse people with complex words.\", \"To listen without providing any opinions.\", \"To criticize the other person\'s ideas without giving an explanation.\"]','MULTIPLE_CHOICE',30),(237,'Vrai ou faux : \'I see your point, but I disagree\' est une façon polie d\'exprimer un désaccord.','true','[]','TRUE_FALSE',30),(238,'Traduisez en anglais : \"Il est important de rester respectueux même quand on n\'est pas d\'accord.\"','it is important to remain respectful even when we disagree','[]','TRANSLATION',30),(239,'Comment réagir poliment lorsqu\'on n\'est pas d\'accord avec une opinion ?','you can say i understand your point but i would like to offer another perspective','[\"You can say, \'I understand your point, but I would like to offer another perspective.\'\", \"You can say, \'You\'re wrong, and that\'s it.\'\", \"You can say, \'That\'s not my problem.\'\", \"It\'s best to ignore the opinion.\"]','MULTIPLE_CHOICE',30),(240,'Vrai ou faux : \'In conclusion\' est une phrase utilisée pour résumer un argument dans un débat.','true','[]','TRUE_FALSE',30),(241,'Traduisez en anglais : \"Je dois préparer un rapport pour la réunion de demain.\"','i need to prepare a report for tomorrows meeting','[]','TRANSLATION',31),(242,'Vrai ou faux : L\'expression \'To take the lead\' signifie assumer la direction d\'un projet ou d\'une tâche.','true','[]','TRUE_FALSE',31),(243,'Traduisez en anglais : \"Je vais envoyer l\'email à mes collègues dès que possible.\"','i will send the email to my colleagues as soon as possible','[]','TRANSLATION',31),(244,'Quel est l\'objectif d\'un entretien professionnel ?','the goal of a job interview is to assess the candidates skills experience and fit for the role','[\"To assess the candidate\'s skills, experience, and fit for the role.\", \"To discuss personal matters unrelated to work.\", \"To compare the candidate with others based on their appearance.\", \"To focus only on the candidate\'s educational background.\"]','MULTIPLE_CHOICE',31),(245,'Vrai ou faux : L\'expression \'To meet a deadline\' signifie être en retard dans un projet.','false','[]','TRUE_FALSE',31),(246,'Traduisez en anglais : \"Nous devons respecter la date limite pour terminer ce projet.\"','we need to meet the deadline to finish this project','[]','TRANSLATION',31),(247,'Quel est le rôle d\'un manager dans une équipe ?','a manager is responsible for leading the team assigning tasks and ensuring the team meets its goals','[\"A manager is responsible for leading the team, assigning tasks, and ensuring the team meets its goals.\", \"A manager only makes coffee for the team.\", \"A manager\'s main job is to attend meetings and do nothing else.\", \"A manager should avoid communicating with the team.\"]','MULTIPLE_CHOICE',31),(248,'Vrai ou faux : \'To negotiate a deal\' signifie discuter des conditions d\'un contrat ou d\'une transaction.','true','[]','TRUE_FALSE',31),(249,'Traduisez en anglais : \"Elle a présenté un projet brillant lors de la réunion.\"','she presented an excellent project at the meeting','[]','TRANSLATION',31),(250,'Vrai ou faux : \'To work under pressure\' signifie être capable de travailler de manière détendue et sans stress.','false','[]','TRUE_FALSE',31),(251,'Comment dire en anglais : \"Je suis prêt à discuter des termes du contrat.\"','i am ready to discuss the terms of the contract','[\"I am ready to discuss the terms of the contract.\", \"I am ready to ignore the terms of the contract.\", \"I am ready to refuse to discuss anything.\", \"I am ready to leave the meeting.\"]','MULTIPLE_CHOICE',31),(252,'Traduisez en anglais : \"Le conférencier a présenté des arguments convaincants.\"','the speaker presented convincing arguments','[]','TRANSLATION',32),(253,'Vrai ou faux : Un discours académique est souvent plus informel et subjectif qu\'un discours professionnel.','false','[]','TRUE_FALSE',32),(254,'Qu\'est-ce qu\'un \'keynote speaker\' lors d\'une conférence ?','a keynote speaker is the main speaker who sets the tone and theme of the event','[\"A keynote speaker is the main speaker who sets the tone and theme of the event.\", \"A keynote speaker is someone who handles logistics during the event.\", \"A keynote speaker is a participant who asks the most questions.\", \"A keynote speaker is an assistant who helps with the technical setup.\"]','MULTIPLE_CHOICE',32),(255,'Vrai ou faux : \'To give a presentation\' signifie partager des informations avec un public.','true','[]','TRUE_FALSE',32),(256,'Traduisez en anglais : \"Elle a répondu aux questions du public après sa conférence.\"','she answered the audiences questions after her talk','[]','TRANSLATION',32),(257,'Quel est l\'objectif principal d\'une conférence professionnelle ?','the main goal of a professional conference is to share knowledge exchange ideas and network with other professionals','[\"To share knowledge, exchange ideas, and network with other professionals.\", \"To take a long break and relax.\", \"To watch movies and eat snacks.\", \"To focus only on socializing with colleagues.\"]','MULTIPLE_CHOICE',32),(258,'Vrai ou faux : L\'objectif principal d\'un discours est d\'informer, persuader ou divertir l\'audience.','true','[]','TRUE_FALSE',32),(259,'Traduisez en anglais : \"Le conférencier a utilisé des graphiques pour illustrer ses propos.\"','the speaker used charts to illustrate his points','[]','TRANSLATION',32),(260,'Vrai ou faux : \'To summarize a speech\' signifie répéter tout ce que le conférencier a dit sans changement.','false','[]','TRUE_FALSE',32),(261,'Quel est le rôle d\'un modérateur lors d\'une conférence ?','a moderators role is to manage the flow of the event introduce speakers and ensure the schedule is followed','[\"To manage the flow of the event, introduce speakers, and ensure the schedule is followed.\", \"To present a research paper instead of the main speaker.\", \"To create graphics and charts for the speakers.\", \"To answer all questions from the audience.\"]','MULTIPLE_CHOICE',32),(262,'Traduisez en anglais : \"Il a bien expliqué les concepts complexes lors de la conférence.\"','he explained complex concepts well during the conference','[]','TRANSLATION',32),(263,'Vrai ou faux : Un discours politique doit toujours être objectif et sans émotion.','false','[]','TRUE_FALSE',32),(264,'Vrai ou faux : \'To give a speech\' implique parler devant un public pour transmettre des informations ou des idées.','true','[]','TRUE_FALSE',32),(265,'Traduisez en anglais : \"Il a une grande bibliothèque chez lui.\"','he has a large library at home','[]','TRANSLATION',33),(266,'Vrai ou faux : Le mot \'actual\' en anglais signifie \'actuel\' en français.','false','[]','TRUE_FALSE',33),(267,'Choisissez la bonne traduction : \'Subir\' en anglais.','to suffer','[\"To suffer\", \"To submit\", \"To succeed\", \"To submit\"]','MULTIPLE_CHOICE',33),(268,'Traduisez en anglais : \"Il a une large expérience dans ce domaine.\"','he has extensive experience in this field','[]','TRANSLATION',33),(269,'Vrai ou faux : Le mot \'eventually\' en anglais signifie \'actuellement\'.','false','[]','TRUE_FALSE',33),(270,'Quel est le piège du mot \'library\' en anglais ?','library ne signifie pas librairie en français en anglais library désigne une bibliothèque (un lieu pour emprunter des livres)','[\"Library in English means a bookstore in French.\", \"Library in English means a place to borrow books.\", \"Library in English means a university.\", \"Library is the same in both languages.\"]','MULTIPLE_CHOICE',33),(271,'Traduisez en anglais : \"Nous avons fait une demande pour un prêt.\"','we made an application for a loan','[]','TRANSLATION',33),(272,'Vrai ou faux : Le mot \'actual\' en anglais peut être traduit par \'réel\'.','true','[]','TRUE_FALSE',33),(273,'Choisissez la bonne traduction : \'Sensible\' en anglais.','sensitive','[\"Sensitive\", \"Sensational\", \"Sensible\", \"Simple\"]','MULTIPLE_CHOICE',33),(274,'Traduisez en anglais : \"Il a fini par se tromper.\"','he ended up making a mistake','[]','TRANSLATION',33),(275,'Vrai ou faux : Dans un essai argumentatif, la thèse est l\'idée que vous allez défendre.','true','[]','TRUE_FALSE',34),(276,'Quel est le rôle de la conclusion dans un essai argumentatif ?','résumer les principaux points et réaffirmer la thèse','[\"Réintroduire le sujet.\", \"Présenter des arguments supplémentaires.\", \"Résumer les principaux points et réaffirmer la thèse.\", \"Écrire une citation célèbre.\"]','MULTIPLE_CHOICE',34),(277,'Traduisez en anglais : \"Il faut utiliser des exemples pertinents pour soutenir votre argumentation.\"','you must use relevant examples to support your argument','[]','TRANSLATION',34),(278,'Vrai ou faux : Un bon essai argumentatif doit inclure un contre-argument pour être équilibré.','true','[]','TRUE_FALSE',34),(279,'Choisissez la meilleure manière de commencer un essai argumentatif :','en posant une question ouverte sur le sujet','[\"En donnant une citation inspirante.\", \"En présentant une statistique choquante.\", \"En posant une question ouverte sur le sujet.\", \"En affirmant directement votre opinion.\"]','MULTIPLE_CHOICE',34),(280,'Quel est le but d\'un argument de transition dans un essai argumentatif ?','lier les idées entre elles pour rendre le texte fluide','[\"Éviter les répétitions.\", \"Lier les idées entre elles pour rendre le texte fluide.\", \"Ajouter des informations secondaires.\", \"Attirer l\'attention du lecteur.\"]','MULTIPLE_CHOICE',34),(281,'Traduisez en anglais : \"L\'argument principal soutient la thèse de manière claire et concise.\"','the main argument supports the thesis clearly and concisely','[]','TRANSLATION',34),(282,'Vrai ou faux : Un bon essai argumentatif doit comporter au moins trois arguments principaux.','true','[]','TRUE_FALSE',34),(283,'Choisissez la phrase la plus appropriée pour conclure un essai argumentatif :','to sum up the evidence clearly supports my point of view','[\"In conclusion, we can see that the topic is very complex and deserves further exploration.\", \"Finally, I would like to emphasize the importance of this topic in our daily lives.\", \"To sum up, the evidence clearly supports my point of view.\", \"In conclusion, I believe this is a great subject to talk about.\"]','MULTIPLE_CHOICE',34),(284,'Vrai ou faux : L\'introduction d\'un article de presse doit toujours résumer l\'article dans son ensemble.','false','[]','TRUE_FALSE',35),(285,'Quel est le principal objectif d\'une conclusion dans un article de presse ?','résumer les points principaux de larticle et offrir une perspective finale','[\"Répondre à toutes les questions possibles.\", \"Résumer les points principaux de l\'article et offrir une perspective finale.\", \"Introduire de nouvelles informations.\", \"Donner des détails personnels sur l\'auteur.\"]','MULTIPLE_CHOICE',35),(286,'Traduisez en anglais : \"L\'auteur présente des arguments solides pour soutenir son opinion.\"','the author presents strong arguments to support his opinion','[]','TRANSLATION',35),(287,'Quel est le but des sous-titres dans un article de presse ?','diviser larticle en sections claires et faciliter la lecture','[\"Rendre l\'article plus long.\", \"Diviser l\'article en sections claires et faciliter la lecture.\", \"Introduire de nouvelles idées non couvertes dans l\'article.\", \"Ajouter des éléments visuels.\"]','MULTIPLE_CHOICE',35),(288,'Vrai ou faux : Un article de presse objectif doit éviter d\'exprimer des opinions personnelles.','true','[]','TRUE_FALSE',35),(289,'Quel type de vocabulaire est généralement utilisé dans un article de presse ?','formel et précis','[\"Formel et précis.\", \"Familier et informel.\", \"Complexe et scientifique.\", \"Argumentatif et subjectif.\"]','MULTIPLE_CHOICE',35),(290,'Traduisez en anglais : \"L\'article aborde les enjeux environnementaux mondiaux.\"','the article addresses global environmental issues','[]','TRANSLATION',35),(291,'Vrai ou faux : Un bon résumé d\'article de presse doit inclure des détails spécifiques et des citations directes de l\'article.','false','[]','TRUE_FALSE',35),(292,'Quel est le rôle de la citation dans un article de presse ?','apporter des preuves ou des témoignages pour étayer un argument','[\"Ajouter des éléments humoristiques.\", \"Apporter des preuves ou des témoignages pour étayer un argument.\", \"Élargir le sujet de l\'article.\", \"Faire un lien vers des sources externes.\"]','MULTIPLE_CHOICE',35),(293,'Vrai ou faux : Un article de presse doit contenir des exemples concrets pour rendre les arguments plus convaincants.','true','[]','TRUE_FALSE',35),(294,'Complétez la phrase avec le bon temps verbal : \"By the time you arrive, I ___ (finish) my homework.\"','will have finished','[]','TRANSLATION',36),(295,'Quel est le temps correct pour exprimer une action qui a commencé dans le passé et continue dans le présent ?','present perfect','[\"Prétérit\", \"Present perfect\", \"Past perfect\", \"Future perfect\"]','MULTIPLE_CHOICE',36),(296,'Vrai ou faux : Le futur perfect est utilisé pour parler d\'une action qui sera terminée avant un moment donné dans le futur.','true','[]','TRUE_FALSE',36),(297,'Complétez la phrase avec la bonne structure : \"If I ___ (be) you, I wouldn\'t do that.\"','were','[]','TRANSLATION',36),(298,'Quel temps est utilisé pour parler de conditions irréelles dans le présent ou le futur ?','conditionnel présent','[\"Conditionnel passé\", \"Conditionnel présent\", \"Futur simple\", \"Prétérit\"]','MULTIPLE_CHOICE',36),(299,'Vrai ou faux : Le past perfect est utilisé pour indiquer qu\'une action s\'est produite avant une autre action passée.','true','[]','TRUE_FALSE',36),(300,'Complétez la phrase avec la forme correcte : \"I wish I ___ (know) how to speak French fluently.\"','knew','[]','TRANSLATION',36),(301,'Quel est le nom du temps utilisé pour parler de quelque chose qui se passera dans le futur avant un autre événement futur ?','futur perfect','[\"Futur perfect\", \"Futur simple\", \"Past perfect\", \"Present perfect\"]','MULTIPLE_CHOICE',36),(302,'Vrai ou faux : Le conditionnel passé exprime une situation hypothétique qui aurait pu se produire dans le passé, mais ne l\'a pas fait.','true','[]','TRUE_FALSE',36),(303,'Quel est le jeu de mots dans la phrase suivante : \"I\'m reading a book on anti-gravity. It\'s impossible to put down.\"','anti-gravity (impossible to put down)','[]','TRANSLATION',37),(304,'Vrai ou faux : L\'humour britannique est souvent plus subtil et ironique que l\'humour américain.','true','[]','TRUE_FALSE',37),(305,'Complétez la phrase avec un jeu de mots : \"Time flies like an arrow. Fruit flies like a ___.\"','banana','[]','TRANSLATION',37),(306,'Quel type d\'humour est utilisé dans la blague : \"Why don’t skeletons fight each other? They don’t have the guts.\" ?','jeu de mots','[\"Jeu de mots\", \"Ironie\", \"Humour noir\", \"Humour absurde\"]','MULTIPLE_CHOICE',37),(307,'Quel est le jeu de mots dans la phrase suivante : \"I used to be a baker, but I couldn\'t make enough dough.\"','dough (argent et pâte à pain)','[]','TRANSLATION',37),(308,'Vrai ou faux : L\'humour britannique utilise souvent des jeux de mots basés sur des double sens.','true','[]','TRUE_FALSE',37),(309,'Complétez la phrase avec un jeu de mots : \"I’m reading a book on the history of glue – I can’t seem to put it ___.\"','down','[]','TRANSLATION',37),(310,'Quel est le jeu de mots dans la phrase suivante : \"A bicycle can’t stand on its own because it’s two-tired.\"','two-tired (jeu sur tired qui signifie fatigué et two tires pour les roues)','[]','TRANSLATION',37),(311,'Quel genre d\'humour est présent dans la phrase suivante : \"I told my computer I needed a break, and now it won’t stop sending me Kit-Kats.\"','jeu de mots','[\"Humour absurde\", \"Ironie\", \"Humour technologique\", \"Jeu de mots\"]','MULTIPLE_CHOICE',37),(312,'Vrai ou faux : Les jeux de mots en anglais reposent souvent sur les homophones ou les multiples significations d\'un mot.','true','[]','TRUE_FALSE',37),(313,'Quel est le thème principal du passage suivant extrait de \"1984\" de George Orwell : \"War is peace. Freedom is slavery. Ignorance is strength.\" ?','contradiction et manipulation des idées','[]','TRANSLATION',39),(314,'Vrai ou faux : Le passage suivant de \"Pride and Prejudice\" de Jane Austen, \"It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.\" est une critique de la société de l\'époque.','true','[]','TRUE_FALSE',39),(315,'Quel est le principal conflit dans l\'extrait de \"Frankenstein\" de Mary Shelley, où le monstre parle de son créateur ?','conflit moral du monstre','[\"Conflit entre l\'homme et la nature\", \"Conflit interne du créateur\", \"Conflit moral du monstre\", \"Conflit entre la science et la religion\"]','MULTIPLE_CHOICE',39),(316,'Dans l\'extrait de \"Macbeth\" de William Shakespeare, que symbolise le sang ?','la culpabilité et la violence','[]','TRANSLATION',39),(317,'Vrai ou faux : Dans \"The Great Gatsby\" de F. Scott Fitzgerald, le personnage de Daisy symbolise l’illusion du rêve américain.','true','[]','TRUE_FALSE',39),(318,'Dans l\'extrait de \"Jane Eyre\" de Charlotte Brontë, quel rôle la maison de Thornfield joue-t-elle dans le développement du personnage principal ?','un symbole de la répression','[\"Un lieu de refuge\", \"Un lieu de confrontation avec les désirs\", \"Un symbole de la répression\", \"Un espace d\'indépendance\"]','MULTIPLE_CHOICE',39),(319,'Quel est le ton principal du passage suivant de \"Wuthering Heights\" d\'Emily Brontë : \"I am Heathcliff! He\'s always, always in my mind...\" ?','la passion et la souffrance','[]','TRANSLATION',39),(320,'Dans l\'extrait suivant de \"To Kill a Mockingbird\" de Harper Lee, quel message l\'auteur veut-elle transmettre à propos de la justice ?','la justice est biaisée par les préjugés sociaux','[\"La justice est aveugle\", \"La justice est biaisée par les préjugés sociaux\", \"La justice est une illusion\", \"La justice doit être réformée\"]','MULTIPLE_CHOICE',39),(321,'Dans le passage de \"Lord of the Flies\" de William Golding, quel est le rôle de l\'île comme métaphore ?','lîle représente la société humaine et ses conflits internes','[]','TRANSLATION',39),(322,'Vrai ou faux : Le personnage de Hamlet dans la pièce éponyme de Shakespeare est un exemple de personnage tragique en raison de son dilemme moral.','true','[]','TRUE_FALSE',39),(323,'Dans l\'extrait de \"The Catcher in the Rye\" de J.D. Salinger, comment Holden Caulfield perçoit-il le monde des adultes ?','il le trouve hypocrite et faux','[\"Il le trouve sincère et honnête\", \"Il le trouve hypocrite et faux\", \"Il le trouve encourageant et optimiste\", \"Il le trouve déconnecté et dénué de sens\"]','MULTIPLE_CHOICE',39),(324,'Quel mot signifie \"argument\" dans le contexte académique : \"L\'auteur présente plusieurs arguments pour soutenir sa thèse.\"','claim','[\"Debate\", \"Reasoning\", \"Point\", \"Claim\"]','MULTIPLE_CHOICE',40),(325,'Vrai ou faux : Le terme \"hypothesis\" dans un contexte académique désigne une proposition testable ou une supposition fondée sur des données.','true','[]','TRUE_FALSE',40),(326,'Traduisez en anglais : \"Une revue de littérature\".','a literature review','[]','TRANSLATION',40),(327,'Quel mot correspond à une \"discussion approfondie sur un sujet académique\" ?','analysis','[\"Debate\", \"Review\", \"Analysis\", \"Assessment\"]','MULTIPLE_CHOICE',40),(328,'Vrai ou faux : Dans un article académique, le terme \"abstract\" fait référence à un résumé court de l\'étude.','true','[]','TRUE_FALSE',40),(329,'Dans le contexte académique, quel est le rôle d\'un \"citation\" ?','fournir des preuves pour étayer une idée','[\"Fournir des preuves pour étayer une idée\", \"Réduire le volume d\'un texte\", \"Augmenter la longueur de l\'argumentation\", \"Faciliter la lecture\"]','MULTIPLE_CHOICE',40),(330,'Traduisez en anglais : \"Les résultats ont été surprenants et contraires à l\'hypothèse de départ.\"','the results were surprising and contrary to the initial hypothesis','[]','TRANSLATION',40),(331,'Quel mot désigne l\'analyse statistique des données dans un contexte académique ?','analysis','[\"Review\", \"Conclusion\", \"Analysis\", \"Methodology\"]','MULTIPLE_CHOICE',40),(332,'Vrai ou faux : Un \"appendix\" dans un texte académique désigne les sources citées dans le texte.','false','[]','TRUE_FALSE',40),(333,'Traduisez en anglais : \"Les données de l\'étude ont été collectées sur une période de six mois.\"','the data from the study were collected over a period of six months','[]','TRANSLATION',40),(334,'What is the main purpose of an introduction in an argumentative essay?','state the thesis','[\"Present examples\", \"State the thesis\", \"Make a conclusion\", \"Introduce statistical data\"]','MULTIPLE_CHOICE',41),(335,'True or false: In an argumentative essay, the body of the text should be divided into several paragraphs, each addressing a different aspect of the argument.','true','[]','TRUE_FALSE',41),(336,'What term refers to reasoning based on verifiable facts and objective data in an essay?','logical argument','[\"Emotion-based argument\", \"Logical argument\", \"Moral argument\", \"Personal argument\"]','MULTIPLE_CHOICE',41),(337,'Translate into English: \"L\'auteur soutient que l\'éducation est la clé pour réduire les inégalités sociales.\"','the author argues that education is the key to reducing social inequalities','[]','TRANSLATION',41),(338,'True or false: In an academic report, it is important to stick to facts and avoid expressing personal opinions.','true','[]','TRUE_FALSE',41),(339,'What is the role of a \"counter-argument\" in an essay?','show the other side of the issue','[\"Strengthen the thesis\", \"Demonstrate the weakness of the main argument\", \"Show the other side of the issue\", \"Present a new idea\"]','MULTIPLE_CHOICE',41),(340,'Translate into English: \"Cette recherche met en évidence l\'importance de la diversité culturelle dans le milieu professionnel.\"','this research highlights the importance of cultural diversity in the workplace','[]','TRANSLATION',41),(341,'True or false: In an argumentative essay, the conclusion should summarize the arguments without restating the thesis.','false','[]','TRUE_FALSE',41),(342,'What term refers to the main idea that you defend in an essay?','thesis','[\"Conclusion\", \"Thesis\", \"Introduction\", \"Argument\"]','MULTIPLE_CHOICE',41),(343,'Translate into English: \"Il est essentiel de présenter des preuves solides pour soutenir votre argumentation.\"','it is essential to provide solid evidence to support your argument','[]','TRANSLATION',41),(344,'What is the main purpose of using quotations in an essay?','give authority to the argumentation','[\"Increase the length of the essay\", \"Give authority to the argumentation\", \"Introduce examples without explaining them\", \"Simplify understanding of the ideas\"]','MULTIPLE_CHOICE',41),(345,'What is the purpose of the introduction in a presentation?','to introduce the speaker','[\"To introduce the speaker\", \"To provide a summary of the topic\", \"To present the main argument\", \"To conclude the speech\"]','MULTIPLE_CHOICE',42),(346,'True or false: It is important to maintain eye contact during a presentation to keep the audience engaged.','true','[]','TRUE_FALSE',42),(347,'What should you do when you don’t know the answer to a question during a presentation?','admit you dont know but offer to find out later','[\"Ignore the question\", \"Guess the answer\", \"Admit you don\'t know but offer to find out later\", \"Say something unrelated to the question\"]','MULTIPLE_CHOICE',42),(348,'Translate into English: \"Dans cette présentation, je vais discuter des avantages de l\'énergie solaire.\"','in this presentation i will discuss the benefits of solar energy','[]','TRANSLATION',42),(349,'True or false: It\'s acceptable to speak too quickly in a presentation if you want to cover a lot of content.','false','[]','TRUE_FALSE',42),(350,'What is the best way to start a presentation?','introduce yourself and your topic clearly','[\"Ask the audience a question\", \"Give a summary of your points\", \"Start with a joke\", \"Introduce yourself and your topic clearly\"]','MULTIPLE_CHOICE',42),(351,'What should you do if you lose your place during a presentation?','pause collect your thoughts and continue','[\"Continue without pausing\", \"Start over\", \"Pause, collect your thoughts, and continue\", \"Apologize and leave the room\"]','MULTIPLE_CHOICE',42),(352,'Translate into English: \"Laissez-moi commencer par vous poser une question.\"','let me start by asking you a question','[]','TRANSLATION',42),(353,'True or false: It’s a good idea to memorize your entire presentation word for word.','false','[]','TRUE_FALSE',42),(354,'What is the best way to handle questions during a presentation?','answer them at the end of the presentation','[\"Answer them at the end of the presentation\", \"Answer them immediately after each point\", \"Avoid answering them\", \"Only answer questions that are easy\"]','MULTIPLE_CHOICE',42),(355,'Translate into English: \"Merci de votre attention, je suis maintenant prêt à répondre à vos questions.\"','thank you for your attention i am now ready to answer your questions','[]','TRANSLATION',42),(356,'Which of the following sentences is an example of sarcasm?','oh great another monday just what i needed','[\"Oh great, another Monday. Just what I needed.\", \"I love your new jacket. It looks amazing.\", \"That\'s a fantastic idea, let\'s do it!\", \"I\'m so happy for you, really!\"]','MULTIPLE_CHOICE',43),(357,'True or false: Sarcasm is often used to express genuine compliments.','false','[]','TRUE_FALSE',43),(358,'What is the main purpose of sarcasm in communication?','to make a joke or show irony','[\"To express sincerity\", \"To make a joke or show irony\", \"To compliment someone\", \"To offer constructive feedback\"]','MULTIPLE_CHOICE',43),(359,'Translate into English: \"C\'est génial, encore une réunion.\"','oh great another meeting','[]','TRANSLATION',43),(360,'True or false: Sarcasm is usually easy to understand in written texts without the use of tone or body language.','false','[]','TRUE_FALSE',43),(361,'Which phrase could be said sarcastically if someone is failing at a task?','wow this is going so well','[\"You’re doing an amazing job!\", \"Wow, this is going so well!\", \"I couldn’t do it without you!\", \"I knew you’d be great at this!\"]','MULTIPLE_CHOICE',43),(362,'How would you say sarcastically in English: \"You’re really good at this.\"','wow youre such an expert','[\"You’re really good at this.\", \"Wow, you\'re such an expert!\", \"I can’t believe how good you are!\", \"You must be the best at this.\"]','MULTIPLE_CHOICE',43),(363,'True or false: Sarcasm can often make communication more humorous and engaging.','true','[]','TRUE_FALSE',43),(364,'What’s the tone of voice usually associated with sarcasm?','a mocking or exaggerated tone','[\"A very serious tone\", \"A cheerful, positive tone\", \"A mocking or exaggerated tone\", \"A neutral tone\"]','MULTIPLE_CHOICE',43),(365,'Translate into English: \"Oh, bien sûr, encore un cadeau de Noël...\"','oh of course another christmas gift','[]','TRANSLATION',43),(366,'Which situation would most likely involve sarcasm?','someone finds out they missed a deadline','[\"Someone gets a promotion at work.\", \"Someone finds out they missed a deadline.\", \"Someone wins a prize for best performance.\", \"Someone successfully completes a task.\"]','MULTIPLE_CHOICE',43),(367,'True or false: Sarcasm can be used to express frustration, irony, or humor.','true','[]','TRUE_FALSE',43),(368,'What is the term for a company that is owned by shareholders?','public limited company','[\"Limited company\", \"Sole proprietorship\", \"Public limited company\", \"Partnership\"]','MULTIPLE_CHOICE',44),(369,'True or false: A \'profit margin\' refers to the amount of profit a company makes relative to its revenue.','true','[]','TRUE_FALSE',44),(370,'What does \'ROI\' stand for in business?','return on investment','[\"Return on Interest\", \"Return on Investment\", \"Rate of Interest\", \"Revenue on Investment\"]','MULTIPLE_CHOICE',44),(371,'Translate into English: \"Une entreprise à but lucratif.\"','a for-profit company','[]','TRANSLATION',44),(372,'True or false: \'Assets\' are everything a company owns, including cash, property, and equipment.','true','[]','TRUE_FALSE',44),(373,'Which of these is a primary goal for most businesses?','to maximize profit','[\"To maximize profit\", \"To minimize costs\", \"To build partnerships\", \"To increase taxes\"]','MULTIPLE_CHOICE',44),(374,'What is the meaning of \'merger\' in business?','two companies combining into one','[\"A company buying another\", \"A company splitting into two\", \"Two companies combining into one\", \"A company closing down\"]','MULTIPLE_CHOICE',44),(375,'Translate into English: \"Le capital de l’entreprise.\"','the companys capital','[]','TRANSLATION',44),(376,'What is \'equity\' in terms of business?','money invested by the owners or shareholders','[\"Debt a company owes\", \"Total assets owned by a company\", \"Money invested by the owners or shareholders\", \"Money earned from sales\"]','MULTIPLE_CHOICE',44),(377,'True or false: \'Liabilities\' are debts and obligations a company has to pay.','true','[]','TRUE_FALSE',44),(378,'What is the meaning of \'profit and loss statement\'?','a statement showing a companys revenue and expenses','[\"A statement showing a company\'s revenue and expenses\", \"A report on a company\'s liabilities\", \"A document for tracking taxes\", \"A report for company stockholders\"]','MULTIPLE_CHOICE',44),(379,'Translate into English: \"Les tendances du marché.\"','market trends','[]','TRANSLATION',44),(380,'True or false: \'Liquidity\' refers to how easily assets can be converted into cash.','true','[]','TRUE_FALSE',44),(381,'What does the term \'capital gain\' refer to?','profit from the sale of assets or investments','[\"Profit from the sale of assets or investments\", \"Money borrowed from a bank\", \"Loss from selling assets\", \"Earnings from product sales\"]','MULTIPLE_CHOICE',44),(382,'Translate into English: \"Je dois partir à 18h demain.\"','i have to leave at 6 pm tomorrow','[]','TRANSLATION',45),(383,'True or false: The word \'interpretation\' refers to the act of translating written text.','false','[]','TRUE_FALSE',45),(384,'Translate into English: \"Pouvez-vous m’expliquer ce que cela signifie ?\"','can you explain what this means','[]','TRANSLATION',45),(385,'What is the correct translation of \'I will attend the meeting tomorrow\' in French?','je vais assister à la réunion demain','[\"Je vais assister à la réunion demain.\", \"Je vais à la réunion demain.\", \"Je vais d’assister à la réunion demain.\", \"J\'assisterai à la réunion demain.\"]','MULTIPLE_CHOICE',45),(386,'Translate into English: \"Je suis en train de lire un livre intéressant.\"','i am reading an interesting book','[]','TRANSLATION',45),(387,'True or false: Interpretation requires knowledge of both the source and target languages at a conversational level.','true','[]','TRUE_FALSE',45),(388,'Translate into English: \"Le gouvernement a annoncé une nouvelle politique.\"','the government announced a new policy','[]','TRANSLATION',45),(389,'What is the meaning of \'literal translation\'?','a translation that keeps the original wording intact','[\"A translation that conveys the exact meaning of a text\", \"A translation that keeps the original wording intact\", \"A translation that adapts cultural references\", \"A translation with changes to improve flow\"]','MULTIPLE_CHOICE',45),(390,'Translate into English: \"Je dois terminer ce travail avant la fin de la journée.\"','i need to finish this work by the end of the day','[]','TRANSLATION',45),(391,'True or false: In interpretation, the speaker’s tone and intent are not as important as the words used.','false','[]','TRUE_FALSE',45),(392,'Translate into English: \"Je vous remercie pour votre aide.\"','thank you for your help','[]','TRANSLATION',45),(393,'What is the meaning of \'contextual translation\'?','a translation that focuses on the cultural and situational context','[\"A translation that focuses on the cultural and situational context\", \"A translation that uses the exact words from the source language\", \"A translation that alters the meaning for ease of understanding\", \"A translation that simplifies difficult words\"]','MULTIPLE_CHOICE',45),(394,'Translate into English: \"Cette phrase n’a pas beaucoup de sens en français.\"','this sentence doesnt make much sense in french','[]','TRANSLATION',45),(395,'True or false: In a formal context, the phrase \'Wanna go?\' is acceptable.','false','[]','TRUE_FALSE',46),(396,'Translate into English (formal): \"Puis-je vous aider avec cela ?\"','may i assist you with this','[]','TRANSLATION',46),(397,'What is the most appropriate form of address in a formal letter to a colleague?','dear [name]','[\"Hey [name],\", \"Dear [name],\", \"Yo [name],\", \"Hi [name],\"]','MULTIPLE_CHOICE',46),(398,'True or false: In informal conversations, using contractions like \'I\'m\' and \'you\'re\' is perfectly fine.','true','[]','TRUE_FALSE',46),(399,'Translate into English (informal): \"Tu veux venir à ma fête ce soir ?\"','do you wanna come to my party tonight','[]','TRANSLATION',46),(400,'Choose the most appropriate sentence for a formal email: \"I hope you’re doing well!\" or \"I hope this message finds you well.\"','i hope this message finds you well','[\"I hope you’re doing well!\", \"I hope this message finds you well.\", \"Hey! How are you?\", \"What’s up?\"]','MULTIPLE_CHOICE',46),(401,'Translate into English (informal): \"Ça te dirait de sortir ce weekend ?\"','do you feel like going out this weekend','[]','TRANSLATION',46),(402,'True or false: Using slang is suitable for professional settings.','false','[]','TRUE_FALSE',46),(403,'Choose the correct phrase to use in a formal situation: \"Could you give me a hand?\" or \"Could you assist me?\"','could you assist me','[\"Could you give me a hand?\", \"Could you assist me?\", \"Can you help me?\", \"Do me a favor?\"]','MULTIPLE_CHOICE',46),(404,'Translate into English (formal): \"Veuillez agréer, Monsieur/Madame, l’expression de mes salutations distinguées.\"','yours sincerely','[]','TRANSLATION',46),(405,'Which of these phrases is more formal: \'I’ll do it later\' or \'I will handle it at your earliest convenience\'?','i will handle it at your earliest convenience','[\"I’ll do it later\", \"I will handle it at your earliest convenience\", \"I’ll take care of it soon\", \"I’ll deal with it later\"]','MULTIPLE_CHOICE',46),(406,'True or false: It is acceptable to use casual language when speaking to a superior in the workplace.','false','[]','TRUE_FALSE',46),(407,'True or false: In many American movies, \'How are you?\' is just a formal greeting, not necessarily asking about someone\'s well-being.','true','[]','TRUE_FALSE',47),(408,'Translate into English: \"Cette scène dans le film montre une grande tension entre les personnages.\"','this scene in the movie shows great tension between the characters','[]','TRANSLATION',47),(409,'Which of the following quotes could be from a classic action movie?','i will find you and i will kill you','[\"May the Force be with you.\", \"I will find you, and I will kill you.\", \"What’s in the box?\", \"I’m king of the world!\"]','MULTIPLE_CHOICE',47),(410,'True or false: In many British sitcoms, the humor relies heavily on sarcasm and irony.','true','[]','TRUE_FALSE',47),(411,'Translate into English: \"Le personnage principal utilise souvent l\'ironie pour exprimer ses opinions.\"','the main character often uses irony to express their opinions','[]','TRANSLATION',47),(412,'Which of the following is a common theme in many romantic comedies?','misunderstandings lead to drama and eventual love','[\"Underdog triumphs\", \"Misunderstandings lead to drama and eventual love\", \"Murder mystery\", \"Time travel\"]','MULTIPLE_CHOICE',47),(413,'Translate into English: \"Dans ce film, la musique joue un rôle crucial pour amplifier les émotions des personnages.\"','in this movie the music plays a crucial role in amplifying the characters emotions','[]','TRANSLATION',47),(414,'True or false: In American movies, villains are often portrayed as having strong accents to emphasize their foreignness.','true','[]','TRUE_FALSE',47),(415,'Which movie line reflects the classic \'hero\'s journey\' trope?','i’ll be back','[\"I’ll be back.\", \"That’s what I’m talking about.\", \"This is the start of a beautiful friendship.\", \"I have nothing to offer but blood, toil, tears, and sweat.\"]','MULTIPLE_CHOICE',47),(416,'Translate into English: \"La scène de la fin du film montre le sacrifice héroïque du personnage principal.\"','the final scene of the movie shows the main characters heroic sacrifice','[]','TRANSLATION',47),(417,'True or false: In many dramas, the character\'s inner conflict is often revealed through monologues or long speeches.','true','[]','TRUE_FALSE',47),(418,'Which of the following films is a well-known example of a \'revenge story\'?','the godfather','[\"The Godfather\", \"The Lion King\", \"Frozen\", \"Finding Nemo\"]','MULTIPLE_CHOICE',47),(419,'True or false: In political debates, candidates often avoid directly answering questions to stay on message.','true','[]','TRUE_FALSE',48),(420,'Translate into English: \"Le débat télévisé a porté sur les enjeux économiques et sociaux du pays.\"','the tv debate focused on the countrys economic and social issues','[]','TRANSLATION',48),(421,'Which rhetorical technique is commonly used in political debates to make a point seem more valid?','appeal to emotion','[\"Appeal to emotion\", \"Appeal to authority\", \"Circular reasoning\", \"Ad hominem attack\"]','MULTIPLE_CHOICE',48),(422,'True or false: In a televised political debate, each candidate usually speaks uninterrupted for long periods of time.','false','[]','TRUE_FALSE',48),(423,'Translate into English: \"Les arguments avancés par l\'opposition ont suscité une vive réaction du public.\"','the arguments put forward by the opposition sparked a strong reaction from the audience','[]','TRANSLATION',48),(424,'Which of the following is an example of a counterargument in a political debate?','you are right to mention the importance of healthcare but we need to consider the budget cuts in the education sector','[\"You are right to mention the importance of healthcare, but we need to consider the budget cuts in the education sector.\", \"Let me tell you why you are wrong about this.\", \"We cannot afford to discuss this further.\", \"I disagree with your opinion on this issue.\"]','MULTIPLE_CHOICE',48),(425,'Translate into English: \"Le président a répondu aux accusations de son adversaire en soulignant les réussites de son mandat.\"','the president responded to his opponents accusations by highlighting the successes of his term','[]','TRANSLATION',48),(426,'True or false: In political debates, candidates often use repetition to emphasize key points and make their arguments more memorable.','true','[]','TRUE_FALSE',48),(427,'Which of the following is a common tactic used by political candidates to undermine their opponent\'s argument?','highlighting past mistakes or failures of the opponent','[\"Using statistics to prove their point\", \"Highlighting past mistakes or failures of the opponent\", \"Offering solutions to the problem\", \"Building on a common agreement\"]','MULTIPLE_CHOICE',48),(428,'Translate into English: \"Le débat a révélé des divergences profondes sur la politique étrangère du pays.\"','the debate revealed deep differences on the countrys foreign policy','[]','TRANSLATION',48),(429,'True or false: Politicians often use rhetorical questions to make their audience think they have already provided an answer.','true','[]','TRUE_FALSE',48),(430,'Which of the following is an example of a rhetorical question used in a political debate?','how can we ignore the rising unemployment rate','[\"How can we ignore the rising unemployment rate?\", \"Isn\'t it time for change?\", \"Do you think this policy will work?\", \"What about the next generation?\"]','MULTIPLE_CHOICE',48),(431,'Translate into English: \"L\'argument principal de l\'intervenant est basé sur la nécessité de réformes urgentes.\"','the speakers main argument is based on the need for urgent reforms','[]','TRANSLATION',48);
/*!40000 ALTER TABLE `exercise` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_create_exercise_add_winablePoints_in_level` AFTER INSERT ON `exercise` FOR EACH ROW BEGIN

    DECLARE level_id INT;

    DECLARE points_per_exo INT;



    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = NEW.serieId LIMIT 1;

    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;



    UPDATE Level

    SET winablePoints = winablePoints + points_per_exo

    WHERE id = level_id;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_create_exercise_add_totalExercises_in_site_stats` AFTER INSERT ON `exercise` FOR EACH ROW BEGIN

    UPDATE SiteStats

    SET totalExercises = totalExercises + 1

    WHERE id = 1;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_create_exercise_add_totalPoints_in_site_stats` AFTER INSERT ON `exercise` FOR EACH ROW BEGIN

    DECLARE level_id INT;

    DECLARE points_per_exo INT;



    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = NEW.serieId LIMIT 1;

    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;



    UPDATE SiteStats

    SET totalPoints = totalPoints + points_per_exo

    WHERE id = 1;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_delete_exercise_subtract_winablePoints_in_level` AFTER DELETE ON `exercise` FOR EACH ROW BEGIN

    DECLARE level_id INT;

    DECLARE points_per_exo INT;



    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = OLD.serieId LIMIT 1;

    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;



    UPDATE Level

    SET winablePoints = winablePoints - points_per_exo

    WHERE id = level_id;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_delete_exercise_subtract_totalPoints_in_site_stats` AFTER DELETE ON `exercise` FOR EACH ROW BEGIN

    DECLARE level_id INT;

    DECLARE points_per_exo INT;



    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = OLD.serieId LIMIT 1;

    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;



    UPDATE SiteStats

    SET totalPoints = totalPoints - points_per_exo

    WHERE id = 1;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_delete_exercise_subtract_totalExercises_in_site_stats` AFTER DELETE ON `exercise` FOR EACH ROW BEGIN

    UPDATE SiteStats

    SET totalExercises = totalExercises - 1

    WHERE id = 1;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `exercisesserie`
--

DROP TABLE IF EXISTS `exercisesserie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercisesserie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `levelId` int NOT NULL,
  `type` enum('DEFAULT','TALK') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT',
  PRIMARY KEY (`id`),
  KEY `ExercisesSerie_levelId_fkey` (`levelId`),
  CONSTRAINT `ExercisesSerie_levelId_fkey` FOREIGN KEY (`levelId`) REFERENCES `level` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercisesserie`
--

LOCK TABLES `exercisesserie` WRITE;
/*!40000 ALTER TABLE `exercisesserie` DISABLE KEYS */;
INSERT INTO `exercisesserie` VALUES (1,'Premiers mots en anglais','Apprends le vocabulaire de base pour te présenter et parler de ton quotidien.','2025-02-19 19:09:16.183',1,'DEFAULT'),(2,'Les chiffres et les dates','Maîtrise les nombres, les heures et les dates en anglais pour parler du temps.','2025-02-19 19:09:27.347',1,'DEFAULT'),(3,'Les couleurs et les objets','Identifie et nomme les couleurs et objets courants de ton environnement.','2025-02-19 19:09:36.509',1,'DEFAULT'),(4,'Les verbes essentiels','Apprends les verbes de base pour exprimer des actions simples.','2025-02-19 19:09:45.137',1,'DEFAULT'),(5,'Se présenter en anglais','Savoir dire son nom, son âge, et parler de soi-même.','2025-02-19 19:09:54.204',1,'DEFAULT'),(6,'Les salutations et formules de politesse','Savoir dire bonjour, merci, et formuler des demandes polies.','2025-02-19 19:10:08.076',1,'DEFAULT'),(7,'Les membres de la famille','Apprends à parler de ta famille et des liens de parenté.','2025-02-19 19:10:22.541',1,'DEFAULT'),(8,'Les animaux courants','Apprends à nommer les animaux domestiques et sauvages.','2025-02-19 19:10:33.566',1,'DEFAULT'),(9,'La nourriture et les boissons','Découvre le vocabulaire des aliments et comment commander au restaurant.','2025-02-19 19:10:42.111',1,'DEFAULT'),(10,'Les lieux de la ville','Apprends à demander ton chemin et à nommer les endroits courants.','2025-02-19 19:10:51.074',1,'DEFAULT'),(11,'La vie quotidienne','Décris ta routine et tes activités habituelles.','2025-02-19 19:11:50.478',2,'DEFAULT'),(12,'Faire des achats','Savoir demander des prix, comparer des produits et acheter des objets.','2025-02-19 19:11:58.899',2,'DEFAULT'),(13,'Voyager à l’étranger','Apprends les phrases essentielles pour l’aéroport, l’hôtel et les transports.','2025-02-19 19:12:07.975',2,'DEFAULT'),(14,'Les loisirs et passe-temps','Parle de ce que tu aimes faire pendant ton temps libre.','2025-02-19 19:12:17.397',2,'DEFAULT'),(15,'La météo et les saisons','Décris le temps qu’il fait et les changements de saison.','2025-02-19 19:12:28.109',2,'DEFAULT'),(16,'Les descriptions physiques et vestimentaires','Apprends à décrire une personne et ses vêtements.','2025-02-19 19:12:38.832',2,'DEFAULT'),(17,'Les émotions et sentiments','Exprime comment tu te sens et décris les émotions des autres.','2025-02-19 19:12:49.378',2,'DEFAULT'),(18,'Commander au restaurant','Apprends à lire un menu, commander et payer l’addition.','2025-02-19 19:12:57.737',2,'DEFAULT'),(19,'Les transports et déplacements','Savoir demander son chemin et utiliser les transports en commun.','2025-02-19 19:13:07.415',2,'DEFAULT'),(20,'Les verbes au passé simple','Apprends à raconter ce que tu as fait hier ou la semaine dernière.','2025-02-19 19:13:20.836',2,'DEFAULT'),(21,'Raconter un souvenir ou une expérience','Apprends à parler d’un événement passé en détail.','2025-02-19 19:13:34.258',4,'DEFAULT'),(22,'Exprimer son opinion','Apprends à donner ton avis sur des sujets variés.','2025-02-19 19:15:22.342',4,'DEFAULT'),(23,'Comprendre et écrire un email formel','Apprends les bases des courriers professionnels et académiques.','2025-02-19 19:15:32.057',4,'DEFAULT'),(24,'Les expressions idiomatiques courantes','Découvre des expressions anglaises utilisées au quotidien.','2025-02-19 19:15:42.960',4,'DEFAULT'),(25,'Les différences culturelles','Parle des habitudes et traditions des pays anglophones.','2025-02-19 19:15:52.407',4,'DEFAULT'),(26,'Le travail et les métiers','Apprends à parler de ton emploi et du monde professionnel.','2025-02-19 19:16:04.593',4,'DEFAULT'),(27,'Les médias et les nouvelles','Apprends à comprendre et discuter des actualités.','2025-02-19 19:16:16.996',4,'DEFAULT'),(28,'Les conversations téléphoniques','Entraîne-toi à répondre et passer des appels en anglais.','2025-02-19 19:16:26.043',4,'DEFAULT'),(29,'Les voyages et aventures','Décris un voyage que tu as fait ou que tu aimerais faire.','2025-02-19 19:16:35.118',4,'DEFAULT'),(30,'Débats et argumentation','Apprends à défendre une opinion et contre-argumenter.','2025-02-19 19:18:41.717',5,'DEFAULT'),(31,'L’anglais dans le monde professionnel','Utilise l’anglais dans des situations de bureau et d’affaires.','2025-02-19 19:18:57.520',5,'DEFAULT'),(32,'Comprendre les discours et conférences','Analyse des vidéos et discours en anglais.','2025-02-19 19:19:05.713',5,'DEFAULT'),(33,'Les faux amis et pièges du vocabulaire','Identifie et évite les erreurs fréquentes en anglais.','2025-02-19 19:19:15.500',5,'DEFAULT'),(34,'Écrire un essai structuré','Apprends à rédiger un texte argumentatif bien organisé.','2025-02-19 19:19:23.623',5,'DEFAULT'),(35,'Analyser un article de presse','Comprends et résume un article complexe en anglais.','2025-02-19 19:19:31.989',5,'DEFAULT'),(36,'Les subtilités grammaticales avancées','Travaille sur les temps et structures grammaticales avancées.','2025-02-19 19:19:41.606',5,'DEFAULT'),(37,'Comprendre l’humour et les jeux de mots','Découvre l’humour anglais et ses subtilités.','2025-02-19 19:19:49.922',5,'DEFAULT'),(39,'Analyse de textes littéraires','Étudie des extraits d’œuvres en anglais.','2025-02-19 19:21:28.760',6,'DEFAULT'),(40,'L’anglais académique','Apprends le vocabulaire et les structures utilisées dans les études supérieures.','2025-02-19 19:21:36.732',6,'DEFAULT'),(41,'Rédaction et argumentation avancées','Maîtrise les nuances de la rédaction d’essais et de rapports.','2025-02-19 19:21:44.313',6,'DEFAULT'),(42,'Discours et présentations en anglais','Développe tes compétences en prise de parole.','2025-02-19 19:21:53.277',6,'DEFAULT'),(43,'Comprendre et utiliser le sarcasme','Découvre les nuances de l’humour et du ton en anglais.','2025-02-19 19:22:01.597',6,'DEFAULT'),(44,'L’anglais des affaires et de la finance','Apprends le vocabulaire de l’économie et des entreprises.','2025-02-19 19:22:10.640',6,'DEFAULT'),(45,'Traduction et interprétation','Exerce-toi à traduire des textes et à interpréter des discours.','2025-02-19 19:22:18.587',6,'DEFAULT'),(46,'Les registres de langue','Adapte ton langage en fonction du contexte (familier, formel, soutenu).','2025-02-19 19:22:28.878',6,'DEFAULT'),(47,'Analyse de films et séries en anglais','Étudie des dialogues et leur sous-texte culturel.','2025-02-19 19:22:39.983',6,'DEFAULT'),(48,'Comprendre un débat télévisé ou politique','Analyse des discussions complexes et des arguments avancés.','2025-02-19 19:22:48.676',6,'DEFAULT');
/*!40000 ALTER TABLE `exercisesserie` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_create_exercisesSerie_add_totalSeries_in_site_stats` AFTER INSERT ON `exercisesserie` FOR EACH ROW BEGIN

    UPDATE SiteStats

    SET totalSeries = totalSeries + 1

    WHERE id = 1;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_delete_exercisesSerie_subtract_totalSeries_in_site_stats` AFTER DELETE ON `exercisesserie` FOR EACH ROW BEGIN

    UPDATE SiteStats

    SET totalSeries = totalSeries - 1

    WHERE id = 1;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `level`
--

DROP TABLE IF EXISTS `level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` enum('A1','A2','B1','B2','C1') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `winablePoints` int NOT NULL DEFAULT '0',
  `pointsPerExo` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Level_title_key` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level`
--

LOCK TABLES `level` WRITE;
/*!40000 ALTER TABLE `level` DISABLE KEYS */;
INSERT INTO `level` VALUES (1,'A1','Débutant','Ce niveau est destiné aux personnes qui commencent tout juste à apprendre l’anglais. L’accent est mis sur le vocabulaire de base, la grammaire élémentaire et la compréhension de phrases simples. L’objectif est de pouvoir se présenter, poser des questions courantes et comprendre des conversations très basiques.',138,1),(2,'A2','Élémentaire','À ce niveau, les apprenants peuvent déjà comprendre et utiliser des expressions courantes de la vie quotidienne. Les exercices aident à construire des phrases plus complexes, à parler de ses expériences et à interagir dans des situations courantes (restaurant, voyages, achats).',276,2),(4,'B1','Intermédiaire','Ce niveau permet de s’exprimer avec plus d’aisance sur des sujets variés. On y apprend à raconter des événements passés, exprimer son opinion et comprendre des textes et des dialogues plus élaborés. Idéal pour ceux qui veulent devenir autonomes dans des conversations du quotidien.',492,3),(5,'B2','Avancé','Les apprenants à ce niveau peuvent comprendre et produire des textes et discours plus complexes. On travaille ici sur l’argumentation, les idiomes, l’anglais des médias et les discussions approfondies. L’objectif est d’avoir une communication fluide et nuancée.',664,4),(6,'C1','Autonome','Ce niveau s’adresse aux personnes qui maîtrisent déjà bien l’anglais et souhaitent affiner leur compréhension et leur expression. On y travaille la subtilité de la langue, l’anglais académique et professionnel, ainsi que l’analyse de contenus authentiques comme des conférences ou des articles spécialisés.',1190,5);
/*!40000 ALTER TABLE `level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isActivate` tinyint(1) NOT NULL DEFAULT '1',
  `subscription` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `frequency` enum('TODAY','ONE_DAY','TWO_DAYS','THREE_DAYS','FOUR_DAYS','FIVE_DAYS','SIX_DAYS','SEVEN_DAYS') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ONE_DAY',
  `notificationTime` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '17:00',
  `nextNotifyAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Notification_userId_key` (`userId`),
  CONSTRAINT `Notification_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (5,'b1c9b041-5145-4b65-950a-f4df1220edb7',1,'{\"endpoint\":\"https://fcm.googleapis.com/fcm/send/eUzRgD9vduA:APA91bFUkuvZR1sS4WIQp0oZgYspjiAiEGjR13LAyoETmr08nbhic17q8F9eUjNTPWUty1v0TxvbkVH529ZF4R_ODYfy8lf-2qcNxF6aAqd7f8UUI7Nc26ZvYY4JoKOHoIcH2cj6vlUk\",\"expirationTime\":null,\"keys\":{\"p256dh\":\"BN7FtAcBXT7yqW9gh0BBnHaWTb14WWHBBqV6QAsKjHzmmOmEqTMmFJheF4LkEuLoeIU0kMKqKNTPZUVn4Dq4leg\",\"auth\":\"fLUt5EHQs9otdiP9lo9P4w\"}}','TODAY','10:36','2025-03-17 10:36:00.000');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refreshtoken`
--

DROP TABLE IF EXISTS `refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refreshtoken` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `expiresAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `RefreshToken_userId_fkey` (`userId`),
  CONSTRAINT `RefreshToken_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refreshtoken`
--

LOCK TABLES `refreshtoken` WRITE;
/*!40000 ALTER TABLE `refreshtoken` DISABLE KEYS */;
INSERT INTO `refreshtoken` VALUES ('062693e7-7967-468f-80f4-19649c205d24','eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjM1N2EwNTgxLTYzMWUtNGJiMC05ZjFjLTU1Zjg1OWJkZDZhMiIsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJyb2xlIjoiQURNSU4iLCJwc2V1ZG8iOiJ1c2VyMTIzIiwiZmlyc3RUaW1lQ29ubmVjdGlvbiI6dHJ1ZSwiYXZhdGFySWQiOjQsImlhdCI6MTc0MTA5NjM0OSwiZXhwIjoxNzQxMTgyNzQ5LCJhdWQiOiJMaW5ndWFHby1jbGllbnQiLCJpc3MiOiJMaW5ndWFHbyJ9.xSwj96Zr2cwxgTgHsIwBHdZwI2AxQzlF7bT454Qpb3yXz0UPu5PzEUsDet3D81-osj-Ba0pjH-b3YhDiYCmOLA','357a0581-631e-4bb0-9f1c-55f859bdd6a2','2025-03-04 13:52:29.210','2025-03-05 13:52:29.209'),('13c8c0e4-a78d-403b-980a-a0154ef73235','eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImIxYzliMDQxLTUxNDUtNGI2NS05NTBhLWY0ZGYxMjIwZWRiNyIsImVtYWlsIjoibC5iZXJ0YXVkMTVAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJwc2V1ZG8iOiJSZWRTdW5TaGluZSIsImZpcnN0VGltZUNvbm5lY3Rpb24iOmZhbHNlLCJhdmF0YXJJZCI6NSwiaWF0IjoxNzQyMjA0MTIxLCJleHAiOjE3NDIyOTA1MjEsImF1ZCI6Ikxpbmd1YUdvLWNsaWVudCIsImlzcyI6Ikxpbmd1YUdvIn0.E2IUQ_Y1IjZQR9-DM_U2JWPKLQwpVebzTuEU8OpDjZVHuh4WZyzERv4ePT-g_Q5E3gH_xerMhrgCsb469K6ouA','b1c9b041-5145-4b65-950a-f4df1220edb7','2025-03-17 09:35:21.206','2025-03-18 09:35:21.205');
/*!40000 ALTER TABLE `refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitestats`
--

DROP TABLE IF EXISTS `sitestats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sitestats` (
  `id` int NOT NULL DEFAULT '1',
  `totalUsers` int NOT NULL DEFAULT '0',
  `totalExercises` int NOT NULL DEFAULT '0',
  `totalSeries` int NOT NULL DEFAULT '0',
  `totalPoints` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitestats`
--

LOCK TABLES `sitestats` WRITE;
/*!40000 ALTER TABLE `sitestats` DISABLE KEYS */;
INSERT INTO `sitestats` VALUES (1,2,422,47,1380);
/*!40000 ALTER TABLE `sitestats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pseudo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('USER','ADMIN') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USER',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `avatarId` int DEFAULT NULL,
  `firstTimeConnection` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_email_key` (`email`),
  KEY `User_avatarId_fkey` (`avatarId`),
  CONSTRAINT `User_avatarId_fkey` FOREIGN KEY (`avatarId`) REFERENCES `avatar` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('357a0581-631e-4bb0-9f1c-55f859bdd6a2','user123','test@gmail.com','$2b$10$n0KczyU9qWkCD4eOy2i3BODo4FKVqCoSyQCie/TUMvUu9WzjX2NyC','ADMIN','2025-03-04 13:51:15.827',4,1),('b1c9b041-5145-4b65-950a-f4df1220edb7','RedSunShine','l.bertaud15@gmail.com','$2b$10$tuCvwUWwZQcTOa7tKJ5HuusoRLFvLBpVzXlo9/lqCeAUuJHFbYFt2','USER','2025-03-04 11:49:25.201',5,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_create_user_add_totalUsers_in_site_stats` AFTER INSERT ON `user` FOR EACH ROW BEGIN

    UPDATE SiteStats

    SET totalUsers = totalUsers + 1

    WHERE id = 1;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_delete_user_subtract_totalUsers_in_site_stats` AFTER DELETE ON `user` FOR EACH ROW BEGIN

    UPDATE SiteStats

    SET totalUsers = totalUsers - 1

    WHERE id = 1;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usercompletedexercise`
--

DROP TABLE IF EXISTS `usercompletedexercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usercompletedexercise` (
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exerciseId` int NOT NULL,
  `completedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `serieId` int NOT NULL,
  `pointsWon` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`userId`,`exerciseId`),
  KEY `UserCompletedExercise_exerciseId_fkey` (`exerciseId`),
  CONSTRAINT `UserCompletedExercise_exerciseId_fkey` FOREIGN KEY (`exerciseId`) REFERENCES `exercise` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `UserCompletedExercise_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usercompletedexercise`
--

LOCK TABLES `usercompletedexercise` WRITE;
/*!40000 ALTER TABLE `usercompletedexercise` DISABLE KEYS */;
INSERT INTO `usercompletedexercise` VALUES ('b1c9b041-5145-4b65-950a-f4df1220edb7',2,'2025-03-06 14:54:01.809',1,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',3,'2025-03-06 15:29:01.111',1,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',4,'2025-03-06 15:29:06.200',1,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',5,'2025-03-04 13:03:03.728',1,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',6,'2025-03-06 15:29:12.145',1,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',7,'2025-03-06 15:29:17.738',1,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',8,'2025-03-06 15:29:19.669',1,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',17,'2025-03-04 13:46:36.350',2,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',18,'2025-03-04 13:47:25.821',2,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',19,'2025-03-06 15:21:36.332',2,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',20,'2025-03-06 15:28:20.585',2,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',21,'2025-03-06 15:28:24.869',2,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',22,'2025-03-06 15:28:39.082',2,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',23,'2025-03-06 15:28:41.002',2,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',24,'2025-03-04 13:48:58.569',3,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',25,'2025-03-06 14:54:12.449',3,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',26,'2025-03-06 15:15:53.065',3,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',27,'2025-03-06 15:16:06.121',3,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',28,'2025-03-06 15:16:09.021',3,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',29,'2025-03-06 15:20:06.133',3,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',30,'2025-03-06 15:17:54.518',3,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',31,'2025-03-06 15:29:32.461',4,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',32,'2025-03-06 15:29:36.024',4,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',33,'2025-03-06 15:29:47.625',4,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',34,'2025-03-06 15:31:15.657',4,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',35,'2025-03-06 15:31:17.768',4,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',36,'2025-03-06 15:31:28.023',4,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',37,'2025-03-06 15:34:56.173',5,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',38,'2025-03-06 15:35:00.888',5,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',39,'2025-03-06 16:49:47.275',5,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',40,'2025-03-06 15:35:18.932',5,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',41,'2025-03-06 16:48:00.589',5,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',43,'2025-03-06 15:35:56.472',6,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',44,'2025-03-06 15:36:01.723',6,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',45,'2025-03-06 15:36:07.226',6,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',46,'2025-03-06 15:36:11.451',6,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',47,'2025-03-06 15:36:14.487',6,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',48,'2025-03-06 15:36:17.213',6,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',49,'2025-03-06 15:36:28.164',7,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',50,'2025-03-06 15:36:30.195',7,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',51,'2025-03-06 15:36:34.306',7,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',52,'2025-03-06 15:36:37.654',7,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',53,'2025-03-06 15:36:41.375',7,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',54,'2025-03-06 15:36:45.549',7,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',59,'2025-03-06 16:29:38.045',8,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',63,'2025-03-06 16:38:13.914',9,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',64,'2025-03-06 16:38:16.578',9,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',65,'2025-03-06 16:40:53.253',9,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',66,'2025-03-06 16:41:00.063',9,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',67,'2025-03-06 16:41:02.388',9,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',68,'2025-03-06 16:41:26.153',9,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',69,'2025-03-06 16:41:38.364',9,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',70,'2025-03-06 16:41:43.436',9,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',71,'2025-03-06 16:43:54.170',9,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',72,'2025-03-06 16:42:45.987',10,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',73,'2025-03-06 16:42:48.653',10,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',74,'2025-03-06 16:42:55.877',10,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',75,'2025-03-06 16:42:59.306',10,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',76,'2025-03-06 16:43:02.950',10,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',77,'2025-03-06 16:43:08.941',10,1),('b1c9b041-5145-4b65-950a-f4df1220edb7',78,'2025-03-06 16:43:12.620',10,1);
/*!40000 ALTER TABLE `usercompletedexercise` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_create_userCompletedExercises` AFTER INSERT ON `usercompletedexercise` FOR EACH ROW BEGIN

    UPDATE UserStats

    SET successfullExercises = successfullExercises + 1

    WHERE userId = NEW.userId COLLATE utf8mb4_unicode_ci;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_create_userCompletedExercise_add_points_in_user_stats` AFTER INSERT ON `usercompletedexercise` FOR EACH ROW BEGIN

    DECLARE level_id INT;

    DECLARE points_per_exo INT;



    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = NEW.serieId LIMIT 1;

    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;



    UPDATE UserStats

    SET points = points + points_per_exo

    WHERE userId = NEW.userId COLLATE utf8mb4_unicode_ci;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_delete_userCompletedExercise_subtract_points_in_user_stats` AFTER DELETE ON `usercompletedexercise` FOR EACH ROW BEGIN

    DECLARE level_id INT;

    DECLARE points_per_exo INT;



    SELECT levelId INTO level_id FROM ExercisesSerie WHERE id = OLD.serieId LIMIT 1;

    SELECT pointsPerExo INTO points_per_exo FROM Level WHERE id = level_id LIMIT 1;



    UPDATE UserStats

    SET points = points - points_per_exo

    WHERE userId = OLD.userId COLLATE utf8mb4_unicode_ci;

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
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_delete_userCompletedExercise` AFTER DELETE ON `usercompletedexercise` FOR EACH ROW BEGIN

    UPDATE UserStats

    SET successfullExercises = successfullExercises - 1

    WHERE userId = OLD.userId COLLATE utf8mb4_unicode_ci;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usercompletedexercisesserie`
--

DROP TABLE IF EXISTS `usercompletedexercisesserie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usercompletedexercisesserie` (
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serieId` int NOT NULL,
  `completedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`userId`,`serieId`),
  KEY `UserCompletedExercisesSerie_serieId_fkey` (`serieId`),
  CONSTRAINT `UserCompletedExercisesSerie_serieId_fkey` FOREIGN KEY (`serieId`) REFERENCES `exercisesserie` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `UserCompletedExercisesSerie_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usercompletedexercisesserie`
--

LOCK TABLES `usercompletedexercisesserie` WRITE;
/*!40000 ALTER TABLE `usercompletedexercisesserie` DISABLE KEYS */;
INSERT INTO `usercompletedexercisesserie` VALUES ('b1c9b041-5145-4b65-950a-f4df1220edb7',1,'2025-03-06 15:29:28.763'),('b1c9b041-5145-4b65-950a-f4df1220edb7',2,'2025-03-06 15:28:54.380'),('b1c9b041-5145-4b65-950a-f4df1220edb7',3,'2025-03-06 15:20:45.175'),('b1c9b041-5145-4b65-950a-f4df1220edb7',4,'2025-03-06 15:34:51.409'),('b1c9b041-5145-4b65-950a-f4df1220edb7',5,'2025-03-06 16:44:40.614'),('b1c9b041-5145-4b65-950a-f4df1220edb7',6,'2025-03-06 15:36:23.790'),('b1c9b041-5145-4b65-950a-f4df1220edb7',7,'2025-03-06 15:36:51.100'),('b1c9b041-5145-4b65-950a-f4df1220edb7',8,'2025-03-06 15:40:25.450'),('b1c9b041-5145-4b65-950a-f4df1220edb7',9,'2025-03-06 16:43:55.807'),('b1c9b041-5145-4b65-950a-f4df1220edb7',10,'2025-03-06 16:43:13.900');
/*!40000 ALTER TABLE `usercompletedexercisesserie` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_create_UserCompletedExercisesSerie` AFTER INSERT ON `usercompletedexercisesserie` FOR EACH ROW BEGIN

    UPDATE UserStats

    SET completedSeries = completedSeries + 1

    WHERE userId = NEW.userId COLLATE utf8mb4_unicode_ci;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `userfavoriteserie`
--

DROP TABLE IF EXISTS `userfavoriteserie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userfavoriteserie` (
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serieId` int NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`userId`,`serieId`),
  KEY `UserFavoriteSerie_serieId_fkey` (`serieId`),
  CONSTRAINT `UserFavoriteSerie_serieId_fkey` FOREIGN KEY (`serieId`) REFERENCES `exercisesserie` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `UserFavoriteSerie_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userfavoriteserie`
--

LOCK TABLES `userfavoriteserie` WRITE;
/*!40000 ALTER TABLE `userfavoriteserie` DISABLE KEYS */;
/*!40000 ALTER TABLE `userfavoriteserie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userstats`
--

DROP TABLE IF EXISTS `userstats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userstats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `points` int NOT NULL DEFAULT '0',
  `successfullExercises` int NOT NULL DEFAULT '0',
  `failedExercises` int NOT NULL DEFAULT '0',
  `completedSeries` int NOT NULL DEFAULT '0',
  `timeSpentOnExercises` int NOT NULL DEFAULT '0',
  `level` enum('A1','A2','B1','B2','C1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'A1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserStats_userId_key` (`userId`),
  CONSTRAINT `UserStats_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userstats`
--

LOCK TABLES `userstats` WRITE;
/*!40000 ALTER TABLE `userstats` DISABLE KEYS */;
INSERT INTO `userstats` VALUES (1,'b1c9b041-5145-4b65-950a-f4df1220edb7',57,58,84,10,2069,'A1'),(2,'357a0581-631e-4bb0-9f1c-55f859bdd6a2',0,0,0,0,0,'A1');
/*!40000 ALTER TABLE `userstats` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `on_update_UserStats_check_user_level` AFTER UPDATE ON `userstats` FOR EACH ROW BEGIN

    DECLARE levelUser VARCHAR(255);



    -- Trouver le niveau correspondant au nouveau nombre de points

    SELECT title INTO levelUser 

    FROM Level 

    WHERE winablePoints >= NEW.points 

    ORDER BY winablePoints ASC 

    LIMIT 1;



    -- Mettre à jour le niveau si nécessaire

    IF levelUser IS NOT NULL AND levelUser != NEW.level THEN

        UPDATE UserStats 

        SET level = levelUser 

        WHERE userId = NEW.userId COLLATE utf8mb4_unicode_ci;

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'linguago'
--

--
-- Dumping routines for database 'linguago'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-17 12:16:59
