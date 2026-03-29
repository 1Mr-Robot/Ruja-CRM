-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: blbobicm5ybh67kjinxc-mysql.services.clever-cloud.com    Database: blbobicm5ybh67kjinxc
-- ------------------------------------------------------
-- Server version	8.0.22-13

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
-- Table structure for table `agente`
--

DROP TABLE IF EXISTS `agente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agente` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidoPaterno` varchar(50) NOT NULL,
  `apellidoMaterno` varchar(50) NOT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `modificado` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aseguradora`
--

DROP TABLE IF EXISTS `aseguradora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aseguradora` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `imagen` varchar(100) NOT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `modificado` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apPaterno` varchar(50) NOT NULL,
  `apMaterno` varchar(50) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `RFC` char(13) NOT NULL,
  `CURP` char(18) NOT NULL,
  `generoID` int NOT NULL,
  `celular` char(10) NOT NULL,
  `telefono` char(10) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `codigoPostal` char(5) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `municipio` varchar(50) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  `colonia` varchar(50) NOT NULL,
  `calle` varchar(50) NOT NULL,
  `numCasa` varchar(50) NOT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `modificado` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `generoID` (`generoID`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`generoID`) REFERENCES `generoCliente` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `detalleAgAs`
--

DROP TABLE IF EXISTS `detalleAgAs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalleAgAs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agenteID` int NOT NULL,
  `aseguradoraID` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agenteID` (`agenteID`,`aseguradoraID`),
  KEY `aseguradoraID` (`aseguradoraID`),
  CONSTRAINT `detalleAgAs_ibfk_1` FOREIGN KEY (`agenteID`) REFERENCES `agente` (`ID`),
  CONSTRAINT `detalleAgAs_ibfk_2` FOREIGN KEY (`aseguradoraID`) REFERENCES `aseguradora` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `detalleAsTP`
--

DROP TABLE IF EXISTS `detalleAsTP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalleAsTP` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aseguradoraID` int NOT NULL,
  `tipoPolizaID` int NOT NULL,
  `comision` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `aseguradoraID` (`aseguradoraID`,`tipoPolizaID`),
  KEY `tipoPolizaID` (`tipoPolizaID`),
  CONSTRAINT `detalleAsTP_ibfk_1` FOREIGN KEY (`aseguradoraID`) REFERENCES `aseguradora` (`ID`),
  CONSTRAINT `detalleAsTP_ibfk_2` FOREIGN KEY (`tipoPolizaID`) REFERENCES `tipoPoliza` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formaPago`
--

DROP TABLE IF EXISTS `formaPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formaPago` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `forma` varchar(50) NOT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `modificado` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `generoCliente`
--

DROP TABLE IF EXISTS `generoCliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generoCliente` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `genero` varchar(50) NOT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `modificado` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metodoPago`
--

DROP TABLE IF EXISTS `metodoPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodoPago` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `metodo` varchar(50) NOT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `modificado` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `poliza`
--

DROP TABLE IF EXISTS `poliza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `poliza` (
  `id` varchar(15) NOT NULL,
  `aseguradoraID` int NOT NULL,
  `agenteID` int NOT NULL,
  `clienteID` int NOT NULL,
  `tipoPolizaID` int NOT NULL,
  `formaPagoID` int NOT NULL,
  `metodoPagoID` int NOT NULL,
  `prima` decimal(10,2) NOT NULL,
  `fechaInicio` datetime DEFAULT CURRENT_TIMESTAMP,
  `fechaFin` date NOT NULL,
  `modificado` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `aseguradoraID` (`aseguradoraID`),
  KEY `agenteID` (`agenteID`),
  KEY `clienteID` (`clienteID`),
  KEY `tipoPolizaID` (`tipoPolizaID`),
  KEY `formaPagoID` (`formaPagoID`),
  KEY `metodoPagoID` (`metodoPagoID`),
  CONSTRAINT `poliza_ibfk_1` FOREIGN KEY (`aseguradoraID`) REFERENCES `aseguradora` (`ID`),
  CONSTRAINT `poliza_ibfk_2` FOREIGN KEY (`agenteID`) REFERENCES `agente` (`ID`),
  CONSTRAINT `poliza_ibfk_3` FOREIGN KEY (`clienteID`) REFERENCES `cliente` (`id`),
  CONSTRAINT `poliza_ibfk_4` FOREIGN KEY (`tipoPolizaID`) REFERENCES `tipoPoliza` (`ID`),
  CONSTRAINT `poliza_ibfk_5` FOREIGN KEY (`formaPagoID`) REFERENCES `formaPago` (`ID`),
  CONSTRAINT `poliza_ibfk_6` FOREIGN KEY (`metodoPagoID`) REFERENCES `metodoPago` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipoPoliza`
--

DROP TABLE IF EXISTS `tipoPoliza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipoPoliza` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `imagen` varchar(100) NOT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `modificado` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-25 21:49:32