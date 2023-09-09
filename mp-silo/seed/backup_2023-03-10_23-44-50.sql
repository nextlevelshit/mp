-- MariaDB dump 10.19  Distrib 10.11.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: strapi
-- ------------------------------------------------------
-- Server version	10.11.2-MariaDB-1:10.11.2+maria~ubu2204

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
-- Table structure for table `admin_permissions`
--

DROP TABLE IF EXISTS `admin_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`properties`)),
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`conditions`)),
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_permissions_created_by_id_fk` (`created_by_id`),
  KEY `admin_permissions_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `admin_permissions_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `admin_permissions_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=429 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_permissions`
--

LOCK TABLES `admin_permissions` WRITE;
/*!40000 ALTER TABLE `admin_permissions` DISABLE KEYS */;
INSERT INTO `admin_permissions` VALUES
(1,'plugin::upload.read',NULL,'{}','[]','2023-02-20 17:34:24.609000','2023-02-20 17:34:24.609000',NULL,NULL),
(2,'plugin::upload.configure-view',NULL,'{}','[]','2023-02-20 17:34:24.620000','2023-02-20 17:34:24.620000',NULL,NULL),
(3,'plugin::upload.assets.create',NULL,'{}','[]','2023-02-20 17:34:24.628000','2023-02-20 17:34:24.628000',NULL,NULL),
(4,'plugin::upload.assets.update',NULL,'{}','[]','2023-02-20 17:34:24.637000','2023-02-20 17:34:24.637000',NULL,NULL),
(5,'plugin::upload.assets.download',NULL,'{}','[]','2023-02-20 17:34:24.646000','2023-02-20 17:34:24.646000',NULL,NULL),
(6,'plugin::upload.assets.copy-link',NULL,'{}','[]','2023-02-20 17:34:24.655000','2023-02-20 17:34:24.655000',NULL,NULL),
(7,'plugin::upload.read',NULL,'{}','[\"admin::is-creator\"]','2023-02-20 17:34:24.668000','2023-02-20 17:34:24.668000',NULL,NULL),
(8,'plugin::upload.configure-view',NULL,'{}','[]','2023-02-20 17:34:24.677000','2023-02-20 17:34:24.677000',NULL,NULL),
(9,'plugin::upload.assets.create',NULL,'{}','[]','2023-02-20 17:34:24.685000','2023-02-20 17:34:24.685000',NULL,NULL),
(10,'plugin::upload.assets.update',NULL,'{}','[\"admin::is-creator\"]','2023-02-20 17:34:24.693000','2023-02-20 17:34:24.693000',NULL,NULL),
(11,'plugin::upload.assets.download',NULL,'{}','[]','2023-02-20 17:34:24.701000','2023-02-20 17:34:24.701000',NULL,NULL),
(12,'plugin::upload.assets.copy-link',NULL,'{}','[]','2023-02-20 17:34:24.709000','2023-02-20 17:34:24.709000',NULL,NULL),
(13,'plugin::content-manager.explorer.create','plugin::users-permissions.user','{\"fields\":[\"username\",\"email\",\"provider\",\"password\",\"resetPasswordToken\",\"confirmationToken\",\"confirmed\",\"blocked\",\"role\"]}','[]','2023-02-20 17:34:24.764000','2023-02-20 17:34:24.764000',NULL,NULL),
(14,'plugin::content-manager.explorer.read','plugin::users-permissions.user','{\"fields\":[\"username\",\"email\",\"provider\",\"password\",\"resetPasswordToken\",\"confirmationToken\",\"confirmed\",\"blocked\",\"role\"]}','[]','2023-02-20 17:34:24.772000','2023-02-20 17:34:24.772000',NULL,NULL),
(15,'plugin::content-manager.explorer.update','plugin::users-permissions.user','{\"fields\":[\"username\",\"email\",\"provider\",\"password\",\"resetPasswordToken\",\"confirmationToken\",\"confirmed\",\"blocked\",\"role\"]}','[]','2023-02-20 17:34:24.780000','2023-02-20 17:34:24.780000',NULL,NULL),
(16,'plugin::content-manager.explorer.delete','plugin::users-permissions.user','{}','[]','2023-02-20 17:34:24.787000','2023-02-20 17:34:24.787000',NULL,NULL),
(17,'plugin::content-manager.single-types.configure-view',NULL,'{}','[]','2023-02-20 17:34:24.795000','2023-02-20 17:34:24.795000',NULL,NULL),
(18,'plugin::content-manager.collection-types.configure-view',NULL,'{}','[]','2023-02-20 17:34:24.807000','2023-02-20 17:34:24.807000',NULL,NULL),
(19,'plugin::content-manager.components.configure-layout',NULL,'{}','[]','2023-02-20 17:34:24.815000','2023-02-20 17:34:24.815000',NULL,NULL),
(20,'plugin::content-type-builder.read',NULL,'{}','[]','2023-02-20 17:34:24.823000','2023-02-20 17:34:24.823000',NULL,NULL),
(21,'plugin::email.settings.read',NULL,'{}','[]','2023-02-20 17:34:24.834000','2023-02-20 17:34:24.834000',NULL,NULL),
(22,'plugin::upload.read',NULL,'{}','[]','2023-02-20 17:34:24.848000','2023-02-20 17:34:24.848000',NULL,NULL),
(23,'plugin::upload.assets.create',NULL,'{}','[]','2023-02-20 17:34:24.857000','2023-02-20 17:34:24.857000',NULL,NULL),
(24,'plugin::upload.assets.update',NULL,'{}','[]','2023-02-20 17:34:24.870000','2023-02-20 17:34:24.870000',NULL,NULL),
(25,'plugin::upload.assets.download',NULL,'{}','[]','2023-02-20 17:34:24.878000','2023-02-20 17:34:24.878000',NULL,NULL),
(26,'plugin::upload.assets.copy-link',NULL,'{}','[]','2023-02-20 17:34:24.886000','2023-02-20 17:34:24.886000',NULL,NULL),
(27,'plugin::upload.configure-view',NULL,'{}','[]','2023-02-20 17:34:24.895000','2023-02-20 17:34:24.895000',NULL,NULL),
(28,'plugin::upload.settings.read',NULL,'{}','[]','2023-02-20 17:34:24.904000','2023-02-20 17:34:24.904000',NULL,NULL),
(29,'plugin::i18n.locale.create',NULL,'{}','[]','2023-02-20 17:34:24.912000','2023-02-20 17:34:24.912000',NULL,NULL),
(30,'plugin::i18n.locale.read',NULL,'{}','[]','2023-02-20 17:34:24.921000','2023-02-20 17:34:24.921000',NULL,NULL),
(31,'plugin::i18n.locale.update',NULL,'{}','[]','2023-02-20 17:34:24.930000','2023-02-20 17:34:24.930000',NULL,NULL),
(32,'plugin::i18n.locale.delete',NULL,'{}','[]','2023-02-20 17:34:24.938000','2023-02-20 17:34:24.938000',NULL,NULL),
(33,'plugin::users-permissions.roles.create',NULL,'{}','[]','2023-02-20 17:34:24.945000','2023-02-20 17:34:24.945000',NULL,NULL),
(34,'plugin::users-permissions.roles.read',NULL,'{}','[]','2023-02-20 17:34:24.951000','2023-02-20 17:34:24.951000',NULL,NULL),
(35,'plugin::users-permissions.roles.update',NULL,'{}','[]','2023-02-20 17:34:24.958000','2023-02-20 17:34:24.958000',NULL,NULL),
(36,'plugin::users-permissions.roles.delete',NULL,'{}','[]','2023-02-20 17:34:24.970000','2023-02-20 17:34:24.970000',NULL,NULL),
(37,'plugin::users-permissions.providers.read',NULL,'{}','[]','2023-02-20 17:34:24.978000','2023-02-20 17:34:24.978000',NULL,NULL),
(38,'plugin::users-permissions.providers.update',NULL,'{}','[]','2023-02-20 17:34:24.986000','2023-02-20 17:34:24.986000',NULL,NULL),
(39,'plugin::users-permissions.email-templates.read',NULL,'{}','[]','2023-02-20 17:34:24.993000','2023-02-20 17:34:24.993000',NULL,NULL),
(40,'plugin::users-permissions.email-templates.update',NULL,'{}','[]','2023-02-20 17:34:25.000000','2023-02-20 17:34:25.000000',NULL,NULL),
(41,'plugin::users-permissions.advanced-settings.read',NULL,'{}','[]','2023-02-20 17:34:25.008000','2023-02-20 17:34:25.008000',NULL,NULL),
(42,'plugin::users-permissions.advanced-settings.update',NULL,'{}','[]','2023-02-20 17:34:25.016000','2023-02-20 17:34:25.016000',NULL,NULL),
(43,'admin::marketplace.read',NULL,'{}','[]','2023-02-20 17:34:25.023000','2023-02-20 17:34:25.023000',NULL,NULL),
(44,'admin::marketplace.plugins.install',NULL,'{}','[]','2023-02-20 17:34:25.030000','2023-02-20 17:34:25.030000',NULL,NULL),
(45,'admin::marketplace.plugins.uninstall',NULL,'{}','[]','2023-02-20 17:34:25.042000','2023-02-20 17:34:25.042000',NULL,NULL),
(46,'admin::webhooks.create',NULL,'{}','[]','2023-02-20 17:34:25.050000','2023-02-20 17:34:25.050000',NULL,NULL),
(47,'admin::webhooks.read',NULL,'{}','[]','2023-02-20 17:34:25.066000','2023-02-20 17:34:25.066000',NULL,NULL),
(48,'admin::webhooks.update',NULL,'{}','[]','2023-02-20 17:34:25.077000','2023-02-20 17:34:25.077000',NULL,NULL),
(49,'admin::webhooks.delete',NULL,'{}','[]','2023-02-20 17:34:25.083000','2023-02-20 17:34:25.083000',NULL,NULL),
(50,'admin::users.create',NULL,'{}','[]','2023-02-20 17:34:25.093000','2023-02-20 17:34:25.093000',NULL,NULL),
(51,'admin::users.read',NULL,'{}','[]','2023-02-20 17:34:25.101000','2023-02-20 17:34:25.101000',NULL,NULL),
(52,'admin::users.update',NULL,'{}','[]','2023-02-20 17:34:25.108000','2023-02-20 17:34:25.108000',NULL,NULL),
(53,'admin::users.delete',NULL,'{}','[]','2023-02-20 17:34:25.116000','2023-02-20 17:34:25.116000',NULL,NULL),
(54,'admin::roles.create',NULL,'{}','[]','2023-02-20 17:34:25.123000','2023-02-20 17:34:25.123000',NULL,NULL),
(55,'admin::roles.read',NULL,'{}','[]','2023-02-20 17:34:25.131000','2023-02-20 17:34:25.131000',NULL,NULL),
(56,'admin::roles.update',NULL,'{}','[]','2023-02-20 17:34:25.141000','2023-02-20 17:34:25.141000',NULL,NULL),
(57,'admin::roles.delete',NULL,'{}','[]','2023-02-20 17:34:25.148000','2023-02-20 17:34:25.148000',NULL,NULL),
(58,'admin::api-tokens.access',NULL,'{}','[]','2023-02-20 17:34:25.156000','2023-02-20 17:34:25.156000',NULL,NULL),
(59,'admin::api-tokens.create',NULL,'{}','[]','2023-02-20 17:34:25.164000','2023-02-20 17:34:25.164000',NULL,NULL),
(60,'admin::api-tokens.read',NULL,'{}','[]','2023-02-20 17:34:25.171000','2023-02-20 17:34:25.171000',NULL,NULL),
(61,'admin::api-tokens.update',NULL,'{}','[]','2023-02-20 17:34:25.179000','2023-02-20 17:34:25.179000',NULL,NULL),
(62,'admin::api-tokens.regenerate',NULL,'{}','[]','2023-02-20 17:34:25.186000','2023-02-20 17:34:25.186000',NULL,NULL),
(63,'admin::api-tokens.delete',NULL,'{}','[]','2023-02-20 17:34:25.194000','2023-02-20 17:34:25.194000',NULL,NULL),
(64,'admin::project-settings.update',NULL,'{}','[]','2023-02-20 17:34:25.200000','2023-02-20 17:34:25.200000',NULL,NULL),
(65,'admin::project-settings.read',NULL,'{}','[]','2023-02-20 17:34:25.207000','2023-02-20 17:34:25.207000',NULL,NULL),
(69,'plugin::content-manager.explorer.delete','api::notebook.notebook','{}','[]','2023-02-20 22:44:58.941000','2023-02-20 22:44:58.941000',NULL,NULL),
(73,'plugin::content-manager.explorer.delete','api::pattern.pattern','{}','[]','2023-02-20 22:50:52.710000','2023-02-20 22:50:52.710000',NULL,NULL),
(89,'plugin::content-manager.explorer.delete','api::terms-of-condition.terms-of-condition','{}','[]','2023-02-21 13:05:04.981000','2023-02-21 13:05:04.981000',NULL,NULL),
(93,'plugin::content-manager.explorer.delete','api::privacy-policy.privacy-policy','{}','[]','2023-02-21 13:27:21.581000','2023-02-21 13:27:21.581000',NULL,NULL),
(106,'plugin::content-manager.explorer.delete','api::imprint.imprint','{}','[]','2023-02-21 13:48:06.354000','2023-02-21 13:48:06.354000',NULL,NULL),
(107,'plugin::content-manager.explorer.create','api::privacy-policy.privacy-policy','{\"fields\":[\"meta.description\",\"meta.keywords\",\"main.title\",\"main.text\",\"main.lastUpdated\"]}','[]','2023-02-21 13:54:03.714000','2023-02-21 13:54:03.714000',NULL,NULL),
(108,'plugin::content-manager.explorer.read','api::privacy-policy.privacy-policy','{\"fields\":[\"meta.description\",\"meta.keywords\",\"main.title\",\"main.text\",\"main.lastUpdated\"]}','[]','2023-02-21 13:54:03.728000','2023-02-21 13:54:03.728000',NULL,NULL),
(109,'plugin::content-manager.explorer.update','api::privacy-policy.privacy-policy','{\"fields\":[\"meta.description\",\"meta.keywords\",\"main.title\",\"main.text\",\"main.lastUpdated\"]}','[]','2023-02-21 13:54:03.736000','2023-02-21 13:54:03.736000',NULL,NULL),
(113,'plugin::content-manager.explorer.create','api::imprint.imprint','{\"fields\":[\"meta.description\",\"meta.keywords\",\"main.title\",\"main.text\",\"main.lastUpdated\"]}','[]','2023-02-21 14:02:05.205000','2023-02-21 14:02:05.205000',NULL,NULL),
(114,'plugin::content-manager.explorer.read','api::imprint.imprint','{\"fields\":[\"meta.description\",\"meta.keywords\",\"main.title\",\"main.text\",\"main.lastUpdated\"]}','[]','2023-02-21 14:02:05.219000','2023-02-21 14:02:05.219000',NULL,NULL),
(115,'plugin::content-manager.explorer.update','api::imprint.imprint','{\"fields\":[\"meta.description\",\"meta.keywords\",\"main.title\",\"main.text\",\"main.lastUpdated\"]}','[]','2023-02-21 14:02:05.233000','2023-02-21 14:02:05.233000',NULL,NULL),
(116,'plugin::content-manager.explorer.create','api::terms-of-condition.terms-of-condition','{\"fields\":[\"meta.description\",\"meta.keywords\",\"main.title\",\"main.text\",\"main.lastUpdated\"]}','[]','2023-02-21 14:29:09.098000','2023-02-21 14:29:09.098000',NULL,NULL),
(117,'plugin::content-manager.explorer.read','api::terms-of-condition.terms-of-condition','{\"fields\":[\"meta.description\",\"meta.keywords\",\"main.title\",\"main.text\",\"main.lastUpdated\"]}','[]','2023-02-21 14:29:09.112000','2023-02-21 14:29:09.112000',NULL,NULL),
(118,'plugin::content-manager.explorer.update','api::terms-of-condition.terms-of-condition','{\"fields\":[\"meta.description\",\"meta.keywords\",\"main.title\",\"main.text\",\"main.lastUpdated\"]}','[]','2023-02-21 14:29:09.121000','2023-02-21 14:29:09.121000',NULL,NULL),
(122,'plugin::content-manager.explorer.delete','api::invoice.invoice','{}','[]','2023-02-22 16:08:18.313000','2023-02-22 16:08:18.313000',NULL,NULL),
(127,'plugin::content-manager.explorer.delete','api::order.order','{}','[]','2023-02-22 16:13:52.619000','2023-02-22 16:13:52.619000',NULL,NULL),
(132,'plugin::content-manager.explorer.delete','api::payment.payment','{}','[]','2023-02-22 16:18:07.948000','2023-02-22 16:18:07.948000',NULL,NULL),
(140,'plugin::content-manager.explorer.delete','api::cart.cart','{}','[]','2023-02-22 16:34:13.763000','2023-02-22 16:34:13.763000',NULL,NULL),
(147,'plugin::content-manager.explorer.delete','api::event.event','{}','[]','2023-02-22 16:39:53.419000','2023-02-22 16:39:53.419000',NULL,NULL),
(151,'plugin::content-manager.explorer.delete','api::delivery.delivery','{}','[]','2023-02-22 16:47:38.023000','2023-02-22 16:47:38.023000',NULL,NULL),
(173,'plugin::content-manager.explorer.create','api::event.event','{\"fields\":[\"label\",\"category\",\"action\"]}','[]','2023-02-23 12:25:36.371000','2023-02-23 12:25:36.371000',NULL,NULL),
(174,'plugin::content-manager.explorer.read','api::event.event','{\"fields\":[\"label\",\"category\",\"action\"]}','[]','2023-02-23 12:25:36.383000','2023-02-23 12:25:36.383000',NULL,NULL),
(175,'plugin::content-manager.explorer.update','api::event.event','{\"fields\":[\"label\",\"category\",\"action\"]}','[]','2023-02-23 12:25:36.392000','2023-02-23 12:25:36.392000',NULL,NULL),
(197,'plugin::content-manager.explorer.delete','api::cover.cover','{}','[]','2023-02-23 12:34:06.974000','2023-02-23 12:34:06.974000',NULL,NULL),
(219,'plugin::content-manager.explorer.create','api::cover.cover','{\"fields\":[\"title\",\"notebooks\"]}','[]','2023-02-23 16:11:05.629000','2023-02-23 16:11:05.629000',NULL,NULL),
(221,'plugin::content-manager.explorer.read','api::cover.cover','{\"fields\":[\"title\",\"notebooks\"]}','[]','2023-02-23 16:11:05.652000','2023-02-23 16:11:05.652000',NULL,NULL),
(223,'plugin::content-manager.explorer.update','api::cover.cover','{\"fields\":[\"title\",\"notebooks\"]}','[]','2023-02-23 16:11:05.667000','2023-02-23 16:11:05.667000',NULL,NULL),
(231,'plugin::content-manager.explorer.create','api::pattern.pattern','{\"fields\":[\"category\",\"image\",\"label\",\"notebooks\"]}','[]','2023-02-23 16:48:05.461000','2023-02-23 16:48:05.461000',NULL,NULL),
(232,'plugin::content-manager.explorer.read','api::pattern.pattern','{\"fields\":[\"category\",\"image\",\"label\",\"notebooks\"]}','[]','2023-02-23 16:48:05.474000','2023-02-23 16:48:05.474000',NULL,NULL),
(233,'plugin::content-manager.explorer.update','api::pattern.pattern','{\"fields\":[\"category\",\"image\",\"label\",\"notebooks\"]}','[]','2023-02-23 16:48:05.482000','2023-02-23 16:48:05.482000',NULL,NULL),
(261,'plugin::content-manager.explorer.create','api::invoice.invoice','{\"fields\":[\"Rechnungsnummer\",\"address\",\"Rechnungsdatum\",\"sent\",\"paid\",\"order\"]}','[]','2023-02-23 17:20:01.753000','2023-02-23 17:20:01.753000',NULL,NULL),
(263,'plugin::content-manager.explorer.read','api::invoice.invoice','{\"fields\":[\"Rechnungsnummer\",\"address\",\"Rechnungsdatum\",\"sent\",\"paid\",\"order\"]}','[]','2023-02-23 17:20:01.776000','2023-02-23 17:20:01.776000',NULL,NULL),
(265,'plugin::content-manager.explorer.update','api::invoice.invoice','{\"fields\":[\"Rechnungsnummer\",\"address\",\"Rechnungsdatum\",\"sent\",\"paid\",\"order\"]}','[]','2023-02-23 17:20:01.795000','2023-02-23 17:20:01.795000',NULL,NULL),
(276,'plugin::content-manager.explorer.delete','api::tex.tex','{}','[]','2023-02-23 17:46:03.249000','2023-02-23 17:46:03.249000',NULL,NULL),
(281,'plugin::content-manager.explorer.create','api::payment.payment','{\"fields\":[\"title\",\"minTotal\",\"description\"]}','[]','2023-02-23 17:49:57.728000','2023-02-23 17:49:57.728000',NULL,NULL),
(282,'plugin::content-manager.explorer.read','api::payment.payment','{\"fields\":[\"title\",\"minTotal\",\"description\"]}','[]','2023-02-23 17:49:57.740000','2023-02-23 17:49:57.740000',NULL,NULL),
(283,'plugin::content-manager.explorer.update','api::payment.payment','{\"fields\":[\"title\",\"minTotal\",\"description\"]}','[]','2023-02-23 17:49:57.749000','2023-02-23 17:49:57.749000',NULL,NULL),
(284,'plugin::content-manager.explorer.publish','api::payment.payment','{}','[]','2023-02-23 17:49:57.759000','2023-02-23 17:49:57.759000',NULL,NULL),
(285,'plugin::content-manager.explorer.publish','api::notebook.notebook','{}','[]','2023-02-23 17:53:29.926000','2023-02-23 17:53:29.926000',NULL,NULL),
(295,'plugin::content-manager.explorer.delete','api::notebook-page.notebook-page','{}','[]','2023-02-23 18:50:36.307000','2023-02-23 18:50:36.307000',NULL,NULL),
(299,'plugin::content-manager.explorer.delete','api::notebook-paper.notebook-paper','{}','[]','2023-02-23 18:51:59.085000','2023-02-23 18:51:59.085000',NULL,NULL),
(300,'plugin::content-manager.explorer.create','api::notebook-page.notebook-page','{\"fields\":[\"label\",\"cost\"]}','[]','2023-02-23 18:52:27.044000','2023-02-23 18:52:27.044000',NULL,NULL),
(301,'plugin::content-manager.explorer.read','api::notebook-page.notebook-page','{\"fields\":[\"label\",\"cost\"]}','[]','2023-02-23 18:52:27.057000','2023-02-23 18:52:27.057000',NULL,NULL),
(302,'plugin::content-manager.explorer.update','api::notebook-page.notebook-page','{\"fields\":[\"label\",\"cost\"]}','[]','2023-02-23 18:52:27.068000','2023-02-23 18:52:27.068000',NULL,NULL),
(303,'plugin::content-manager.explorer.create','api::notebook-paper.notebook-paper','{\"fields\":[\"label\",\"cost\",\"multipliedCost\"]}','[]','2023-02-23 18:57:30.535000','2023-02-23 18:57:30.535000',NULL,NULL),
(304,'plugin::content-manager.explorer.read','api::notebook-paper.notebook-paper','{\"fields\":[\"label\",\"cost\",\"multipliedCost\"]}','[]','2023-02-23 18:57:30.547000','2023-02-23 18:57:30.547000',NULL,NULL),
(305,'plugin::content-manager.explorer.update','api::notebook-paper.notebook-paper','{\"fields\":[\"label\",\"cost\",\"multipliedCost\"]}','[]','2023-02-23 18:57:30.555000','2023-02-23 18:57:30.555000',NULL,NULL),
(315,'plugin::content-manager.explorer.delete','api::notebook-deliverability.notebook-deliverability','{}','[]','2023-02-23 19:27:57.905000','2023-02-23 19:27:57.905000',NULL,NULL),
(320,'plugin::content-manager.explorer.create','api::cover.cover','{\"fields\":[\"notebooks\",\"title\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.640000','2023-02-23 19:32:25.640000',NULL,NULL),
(321,'plugin::content-manager.explorer.read','api::cover.cover','{\"fields\":[\"notebooks\",\"title\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.654000','2023-02-23 19:32:25.654000',NULL,NULL),
(322,'plugin::content-manager.explorer.update','api::cover.cover','{\"fields\":[\"notebooks\",\"title\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.662000','2023-02-23 19:32:25.662000',NULL,NULL),
(323,'plugin::content-manager.explorer.delete','api::cover.cover','{}','[\"admin::is-creator\"]','2023-02-23 19:32:25.670000','2023-02-23 19:32:25.670000',NULL,NULL),
(324,'plugin::content-manager.explorer.create','api::delivery.delivery','{\"fields\":[\"cost\",\"freeDeliveryTotal\",\"minTotal\",\"title\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.678000','2023-02-23 19:32:25.678000',NULL,NULL),
(325,'plugin::content-manager.explorer.read','api::delivery.delivery','{\"fields\":[\"cost\",\"freeDeliveryTotal\",\"minTotal\",\"title\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.685000','2023-02-23 19:32:25.685000',NULL,NULL),
(326,'plugin::content-manager.explorer.update','api::delivery.delivery','{\"fields\":[\"cost\",\"freeDeliveryTotal\",\"minTotal\",\"title\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.694000','2023-02-23 19:32:25.694000',NULL,NULL),
(327,'plugin::content-manager.explorer.delete','api::delivery.delivery','{}','[\"admin::is-creator\"]','2023-02-23 19:32:25.701000','2023-02-23 19:32:25.701000',NULL,NULL),
(328,'plugin::content-manager.explorer.create','api::notebook.notebook','{\"fields\":[\"title\",\"pattern\",\"weight\",\"longTitle\",\"description\",\"meta.description\",\"meta.keywords\",\"cover\",\"bestSellers\",\"images\",\"price\",\"isShippable\",\"productCode\",\"pages\",\"paper\",\"deliverability\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.710000','2023-02-23 19:51:22.492000',NULL,NULL),
(329,'plugin::content-manager.explorer.read','api::notebook.notebook','{\"fields\":[\"title\",\"pattern\",\"weight\",\"longTitle\",\"description\",\"meta.description\",\"meta.keywords\",\"cover\",\"bestSellers\",\"images\",\"price\",\"isShippable\",\"productCode\",\"pages\",\"paper\",\"deliverability\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.720000','2023-02-23 19:51:22.492000',NULL,NULL),
(330,'plugin::content-manager.explorer.update','api::notebook.notebook','{\"fields\":[\"title\",\"pattern\",\"weight\",\"longTitle\",\"description\",\"meta.description\",\"meta.keywords\",\"cover\",\"bestSellers\",\"images\",\"price\",\"isShippable\",\"productCode\",\"pages\",\"paper\",\"deliverability\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.728000','2023-02-23 19:51:22.492000',NULL,NULL),
(331,'plugin::content-manager.explorer.delete','api::notebook.notebook','{}','[\"admin::is-creator\"]','2023-02-23 19:32:25.736000','2023-02-23 19:32:25.736000',NULL,NULL),
(332,'plugin::content-manager.explorer.create','api::notebook-deliverability.notebook-deliverability','{\"fields\":[\"label\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.745000','2023-02-23 19:32:25.745000',NULL,NULL),
(333,'plugin::content-manager.explorer.read','api::notebook-deliverability.notebook-deliverability','{\"fields\":[\"label\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.753000','2023-02-23 19:32:25.753000',NULL,NULL),
(334,'plugin::content-manager.explorer.update','api::notebook-deliverability.notebook-deliverability','{\"fields\":[\"label\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.763000','2023-02-23 19:32:25.763000',NULL,NULL),
(335,'plugin::content-manager.explorer.delete','api::notebook-deliverability.notebook-deliverability','{}','[\"admin::is-creator\"]','2023-02-23 19:32:25.771000','2023-02-23 19:32:25.771000',NULL,NULL),
(336,'plugin::content-manager.explorer.create','api::notebook-page.notebook-page','{\"fields\":[\"cost\",\"label\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.779000','2023-02-23 19:32:25.779000',NULL,NULL),
(337,'plugin::content-manager.explorer.read','api::notebook-page.notebook-page','{\"fields\":[\"cost\",\"label\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.788000','2023-02-23 19:32:25.788000',NULL,NULL),
(338,'plugin::content-manager.explorer.update','api::notebook-page.notebook-page','{\"fields\":[\"cost\",\"label\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.800000','2023-02-23 19:32:25.800000',NULL,NULL),
(339,'plugin::content-manager.explorer.delete','api::notebook-page.notebook-page','{}','[\"admin::is-creator\"]','2023-02-23 19:32:25.809000','2023-02-23 19:32:25.809000',NULL,NULL),
(340,'plugin::content-manager.explorer.create','api::notebook-paper.notebook-paper','{\"fields\":[\"cost\",\"label\",\"multipliedCost\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.817000','2023-02-23 19:32:25.817000',NULL,NULL),
(341,'plugin::content-manager.explorer.read','api::notebook-paper.notebook-paper','{\"fields\":[\"cost\",\"label\",\"multipliedCost\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.826000','2023-02-23 19:32:25.826000',NULL,NULL),
(342,'plugin::content-manager.explorer.update','api::notebook-paper.notebook-paper','{\"fields\":[\"cost\",\"label\",\"multipliedCost\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.834000','2023-02-23 19:32:25.834000',NULL,NULL),
(343,'plugin::content-manager.explorer.delete','api::notebook-paper.notebook-paper','{}','[\"admin::is-creator\"]','2023-02-23 19:32:25.844000','2023-02-23 19:32:25.844000',NULL,NULL),
(344,'plugin::content-manager.explorer.create','api::pattern.pattern','{\"fields\":[\"category\",\"image\",\"label\",\"notebooks\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.852000','2023-02-23 19:32:25.852000',NULL,NULL),
(345,'plugin::content-manager.explorer.read','api::pattern.pattern','{\"fields\":[\"category\",\"image\",\"label\",\"notebooks\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.861000','2023-02-23 19:32:25.861000',NULL,NULL),
(346,'plugin::content-manager.explorer.update','api::pattern.pattern','{\"fields\":[\"category\",\"image\",\"label\",\"notebooks\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.870000','2023-02-23 19:32:25.870000',NULL,NULL),
(347,'plugin::content-manager.explorer.delete','api::pattern.pattern','{}','[\"admin::is-creator\"]','2023-02-23 19:32:25.884000','2023-02-23 19:32:25.884000',NULL,NULL),
(348,'plugin::content-manager.explorer.create','api::payment.payment','{\"fields\":[\"description\",\"minTotal\",\"title\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.893000','2023-02-23 19:32:25.893000',NULL,NULL),
(349,'plugin::content-manager.explorer.read','api::payment.payment','{\"fields\":[\"description\",\"minTotal\",\"title\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.903000','2023-02-23 19:32:25.903000',NULL,NULL),
(350,'plugin::content-manager.explorer.update','api::payment.payment','{\"fields\":[\"description\",\"minTotal\",\"title\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.915000','2023-02-23 19:32:25.915000',NULL,NULL),
(351,'plugin::content-manager.explorer.delete','api::payment.payment','{}','[\"admin::is-creator\"]','2023-02-23 19:32:25.923000','2023-02-23 19:32:25.923000',NULL,NULL),
(352,'plugin::content-manager.explorer.create','api::tex.tex','{\"fields\":[\"amount\",\"label\",\"name\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.930000','2023-02-23 19:32:25.930000',NULL,NULL),
(353,'plugin::content-manager.explorer.read','api::tex.tex','{\"fields\":[\"amount\",\"label\",\"name\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.938000','2023-02-23 19:32:25.938000',NULL,NULL),
(354,'plugin::content-manager.explorer.update','api::tex.tex','{\"fields\":[\"amount\",\"label\",\"name\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.945000','2023-02-23 19:32:25.945000',NULL,NULL),
(355,'plugin::content-manager.explorer.delete','api::tex.tex','{}','[\"admin::is-creator\"]','2023-02-23 19:32:25.952000','2023-02-23 19:32:25.952000',NULL,NULL),
(356,'plugin::content-manager.explorer.create','api::imprint.imprint','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.963000','2023-02-23 19:32:25.963000',NULL,NULL),
(357,'plugin::content-manager.explorer.read','api::imprint.imprint','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.977000','2023-02-23 19:32:25.977000',NULL,NULL),
(358,'plugin::content-manager.explorer.update','api::imprint.imprint','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:25.995000','2023-02-23 19:32:25.995000',NULL,NULL),
(359,'plugin::content-manager.explorer.delete','api::imprint.imprint','{}','[\"admin::is-creator\"]','2023-02-23 19:32:26.010000','2023-02-23 19:32:26.010000',NULL,NULL),
(360,'plugin::content-manager.explorer.create','api::privacy-policy.privacy-policy','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:26.039000','2023-02-23 19:32:26.039000',NULL,NULL),
(361,'plugin::content-manager.explorer.read','api::privacy-policy.privacy-policy','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:26.050000','2023-02-23 19:32:26.050000',NULL,NULL),
(362,'plugin::content-manager.explorer.update','api::privacy-policy.privacy-policy','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:26.059000','2023-02-23 19:32:26.059000',NULL,NULL),
(363,'plugin::content-manager.explorer.delete','api::privacy-policy.privacy-policy','{}','[\"admin::is-creator\"]','2023-02-23 19:32:26.067000','2023-02-23 19:32:26.067000',NULL,NULL),
(364,'plugin::content-manager.explorer.create','api::terms-of-condition.terms-of-condition','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:26.076000','2023-02-23 19:32:26.076000',NULL,NULL),
(365,'plugin::content-manager.explorer.read','api::terms-of-condition.terms-of-condition','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:26.083000','2023-02-23 19:32:26.083000',NULL,NULL),
(366,'plugin::content-manager.explorer.update','api::terms-of-condition.terms-of-condition','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[\"admin::is-creator\"]','2023-02-23 19:32:26.091000','2023-02-23 19:32:26.091000',NULL,NULL),
(367,'plugin::content-manager.explorer.delete','api::terms-of-condition.terms-of-condition','{}','[\"admin::is-creator\"]','2023-02-23 19:32:26.099000','2023-02-23 19:32:26.099000',NULL,NULL),
(368,'plugin::content-manager.explorer.create','api::invoice.invoice','{\"fields\":[\"Rechnungsdatum\",\"Rechnungsnummer\",\"address\",\"order\",\"paid\",\"sent\"]}','[]','2023-02-23 19:33:12.430000','2023-02-23 19:33:12.430000',NULL,NULL),
(369,'plugin::content-manager.explorer.read','api::invoice.invoice','{\"fields\":[\"Rechnungsdatum\",\"Rechnungsnummer\",\"address\",\"order\",\"paid\",\"sent\"]}','[]','2023-02-23 19:33:12.445000','2023-02-23 19:33:12.445000',NULL,NULL),
(370,'plugin::content-manager.explorer.update','api::invoice.invoice','{\"fields\":[\"Rechnungsdatum\",\"Rechnungsnummer\",\"address\",\"order\",\"paid\",\"sent\"]}','[]','2023-02-23 19:33:12.454000','2023-02-23 19:33:12.454000',NULL,NULL),
(371,'plugin::content-manager.explorer.delete','api::invoice.invoice','{}','[]','2023-02-23 19:33:12.463000','2023-02-23 19:33:12.463000',NULL,NULL),
(372,'plugin::content-manager.explorer.create','api::notebook.notebook','{\"fields\":[\"title\",\"pattern\",\"weight\",\"longTitle\",\"description\",\"meta.description\",\"meta.keywords\",\"cover\",\"bestSellers\",\"images\",\"price\",\"isShippable\",\"productCode\",\"pages\",\"paper\",\"deliverability\"]}','[]','2023-02-23 19:33:12.473000','2023-02-23 19:51:22.492000',NULL,NULL),
(373,'plugin::content-manager.explorer.read','api::notebook.notebook','{\"fields\":[\"title\",\"pattern\",\"weight\",\"longTitle\",\"description\",\"meta.description\",\"meta.keywords\",\"cover\",\"bestSellers\",\"images\",\"price\",\"isShippable\",\"productCode\",\"pages\",\"paper\",\"deliverability\"]}','[]','2023-02-23 19:33:12.481000','2023-02-23 19:51:22.492000',NULL,NULL),
(374,'plugin::content-manager.explorer.update','api::notebook.notebook','{\"fields\":[\"title\",\"pattern\",\"weight\",\"longTitle\",\"description\",\"meta.description\",\"meta.keywords\",\"cover\",\"bestSellers\",\"images\",\"price\",\"isShippable\",\"productCode\",\"pages\",\"paper\",\"deliverability\"]}','[]','2023-02-23 19:33:12.491000','2023-02-23 19:51:22.492000',NULL,NULL),
(375,'plugin::content-manager.explorer.delete','api::notebook.notebook','{}','[]','2023-02-23 19:33:12.499000','2023-02-23 19:33:12.499000',NULL,NULL),
(376,'plugin::content-manager.explorer.publish','api::notebook.notebook','{}','[]','2023-02-23 19:33:12.511000','2023-02-23 19:33:12.511000',NULL,NULL),
(377,'plugin::content-manager.explorer.create','api::order.order','{\"fields\":[\"Bestellnummer\",\"address\",\"cart\",\"delivery\",\"invoice\",\"payment\"]}','[]','2023-02-23 19:33:12.520000','2023-02-23 19:33:12.520000',NULL,NULL),
(378,'plugin::content-manager.explorer.read','api::order.order','{\"fields\":[\"Bestellnummer\",\"address\",\"cart\",\"delivery\",\"invoice\",\"payment\"]}','[]','2023-02-23 19:33:12.532000','2023-02-23 19:33:12.532000',NULL,NULL),
(379,'plugin::content-manager.explorer.update','api::order.order','{\"fields\":[\"Bestellnummer\",\"address\",\"cart\",\"delivery\",\"invoice\",\"payment\"]}','[]','2023-02-23 19:33:12.540000','2023-02-23 19:33:12.540000',NULL,NULL),
(380,'plugin::content-manager.explorer.delete','api::order.order','{}','[]','2023-02-23 19:33:12.548000','2023-02-23 19:33:12.548000',NULL,NULL),
(381,'plugin::content-manager.explorer.create','api::payment.payment','{\"fields\":[\"description\",\"minTotal\",\"title\"]}','[]','2023-02-23 19:33:12.556000','2023-02-23 19:33:12.556000',NULL,NULL),
(382,'plugin::content-manager.explorer.read','api::payment.payment','{\"fields\":[\"description\",\"minTotal\",\"title\"]}','[]','2023-02-23 19:33:12.564000','2023-02-23 19:33:12.564000',NULL,NULL),
(383,'plugin::content-manager.explorer.update','api::payment.payment','{\"fields\":[\"description\",\"minTotal\",\"title\"]}','[]','2023-02-23 19:33:12.572000','2023-02-23 19:33:12.572000',NULL,NULL),
(384,'plugin::content-manager.explorer.delete','api::payment.payment','{}','[]','2023-02-23 19:33:12.580000','2023-02-23 19:33:12.580000',NULL,NULL),
(385,'plugin::content-manager.explorer.publish','api::payment.payment','{}','[]','2023-02-23 19:33:12.588000','2023-02-23 19:33:12.588000',NULL,NULL),
(386,'plugin::content-manager.explorer.create','api::tex.tex','{\"fields\":[\"amount\",\"label\",\"name\"]}','[]','2023-02-23 19:33:12.595000','2023-02-23 19:33:12.595000',NULL,NULL),
(387,'plugin::content-manager.explorer.read','api::tex.tex','{\"fields\":[\"amount\",\"label\",\"name\"]}','[]','2023-02-23 19:33:12.605000','2023-02-23 19:33:12.605000',NULL,NULL),
(388,'plugin::content-manager.explorer.update','api::tex.tex','{\"fields\":[\"amount\",\"label\",\"name\"]}','[]','2023-02-23 19:33:12.613000','2023-02-23 19:33:12.613000',NULL,NULL),
(389,'plugin::content-manager.explorer.delete','api::tex.tex','{}','[]','2023-02-23 19:33:12.621000','2023-02-23 19:33:12.621000',NULL,NULL),
(390,'plugin::content-manager.explorer.create','api::imprint.imprint','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[]','2023-02-23 19:33:12.628000','2023-02-23 19:33:12.628000',NULL,NULL),
(391,'plugin::content-manager.explorer.read','api::imprint.imprint','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[]','2023-02-23 19:33:12.637000','2023-02-23 19:33:12.637000',NULL,NULL),
(392,'plugin::content-manager.explorer.update','api::imprint.imprint','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[]','2023-02-23 19:33:12.648000','2023-02-23 19:33:12.648000',NULL,NULL),
(393,'plugin::content-manager.explorer.delete','api::imprint.imprint','{}','[]','2023-02-23 19:33:12.662000','2023-02-23 19:33:12.662000',NULL,NULL),
(394,'plugin::content-manager.explorer.create','api::privacy-policy.privacy-policy','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[]','2023-02-23 19:33:12.674000','2023-02-23 19:33:12.674000',NULL,NULL),
(395,'plugin::content-manager.explorer.read','api::privacy-policy.privacy-policy','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[]','2023-02-23 19:33:12.684000','2023-02-23 19:33:12.684000',NULL,NULL),
(396,'plugin::content-manager.explorer.update','api::privacy-policy.privacy-policy','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[]','2023-02-23 19:33:12.693000','2023-02-23 19:33:12.693000',NULL,NULL),
(397,'plugin::content-manager.explorer.delete','api::privacy-policy.privacy-policy','{}','[]','2023-02-23 19:33:12.703000','2023-02-23 19:33:12.703000',NULL,NULL),
(398,'plugin::content-manager.explorer.create','api::terms-of-condition.terms-of-condition','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[]','2023-02-23 19:33:12.712000','2023-02-23 19:33:12.712000',NULL,NULL),
(399,'plugin::content-manager.explorer.read','api::terms-of-condition.terms-of-condition','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[]','2023-02-23 19:33:12.721000','2023-02-23 19:33:12.721000',NULL,NULL),
(400,'plugin::content-manager.explorer.update','api::terms-of-condition.terms-of-condition','{\"fields\":[\"main.lastUpdated\",\"main.text\",\"main.title\",\"meta.description\",\"meta.keywords\"]}','[]','2023-02-23 19:33:12.730000','2023-02-23 19:33:12.730000',NULL,NULL),
(401,'plugin::content-manager.explorer.delete','api::terms-of-condition.terms-of-condition','{}','[]','2023-02-23 19:33:12.743000','2023-02-23 19:33:12.743000',NULL,NULL),
(402,'plugin::content-manager.explorer.create','api::notebook.notebook','{\"fields\":[\"title\",\"pattern\",\"weight\",\"longTitle\",\"description\",\"meta.description\",\"meta.keywords\",\"cover\",\"bestSellers\",\"images\",\"price\",\"isShippable\",\"productCode\",\"pages\",\"paper\",\"tax\",\"deliverability\"]}','[]','2023-02-23 19:51:22.266000','2023-02-23 19:51:22.266000',NULL,NULL),
(403,'plugin::content-manager.explorer.read','api::notebook.notebook','{\"fields\":[\"title\",\"pattern\",\"weight\",\"longTitle\",\"description\",\"meta.description\",\"meta.keywords\",\"cover\",\"bestSellers\",\"images\",\"price\",\"isShippable\",\"productCode\",\"pages\",\"paper\",\"tax\",\"deliverability\"]}','[]','2023-02-23 19:51:22.278000','2023-02-23 19:51:22.278000',NULL,NULL),
(404,'plugin::content-manager.explorer.update','api::notebook.notebook','{\"fields\":[\"title\",\"pattern\",\"weight\",\"longTitle\",\"description\",\"meta.description\",\"meta.keywords\",\"cover\",\"bestSellers\",\"images\",\"price\",\"isShippable\",\"productCode\",\"pages\",\"paper\",\"tax\",\"deliverability\"]}','[]','2023-02-23 19:51:22.287000','2023-02-23 19:51:22.287000',NULL,NULL),
(411,'plugin::content-manager.explorer.create','api::order.order','{\"fields\":[\"Bestellnummer\",\"payment\",\"cart\",\"delivery\",\"address\",\"invoice\",\"sent\",\"total\",\"tax\",\"taxAmount\",\"totalNetto\"]}','[]','2023-02-23 22:06:57.128000','2023-02-23 22:06:57.128000',NULL,NULL),
(412,'plugin::content-manager.explorer.read','api::order.order','{\"fields\":[\"Bestellnummer\",\"payment\",\"cart\",\"delivery\",\"address\",\"invoice\",\"sent\",\"total\",\"tax\",\"taxAmount\",\"totalNetto\"]}','[]','2023-02-23 22:06:57.141000','2023-02-23 22:06:57.141000',NULL,NULL),
(413,'plugin::content-manager.explorer.update','api::order.order','{\"fields\":[\"Bestellnummer\",\"payment\",\"cart\",\"delivery\",\"address\",\"invoice\",\"sent\",\"total\",\"tax\",\"taxAmount\",\"totalNetto\"]}','[]','2023-02-23 22:06:57.150000','2023-02-23 22:06:57.150000',NULL,NULL),
(414,'plugin::content-manager.explorer.create','api::delivery.delivery','{\"fields\":[\"title\",\"cost\",\"minTotal\",\"freeDeliveryTotal\",\"multipliedCost\"]}','[]','2023-02-24 12:14:56.862000','2023-02-24 12:14:56.862000',NULL,NULL),
(415,'plugin::content-manager.explorer.read','api::delivery.delivery','{\"fields\":[\"title\",\"cost\",\"minTotal\",\"freeDeliveryTotal\",\"multipliedCost\"]}','[]','2023-02-24 12:14:56.874000','2023-02-24 12:14:56.874000',NULL,NULL),
(416,'plugin::content-manager.explorer.update','api::delivery.delivery','{\"fields\":[\"title\",\"cost\",\"minTotal\",\"freeDeliveryTotal\",\"multipliedCost\"]}','[]','2023-02-24 12:14:56.884000','2023-02-24 12:14:56.884000',NULL,NULL),
(417,'plugin::content-manager.explorer.create','api::notebook-deliverability.notebook-deliverability','{\"fields\":[\"label\",\"notebooks\"]}','[]','2023-02-24 21:40:26.848000','2023-02-24 21:40:26.848000',NULL,NULL),
(418,'plugin::content-manager.explorer.read','api::notebook-deliverability.notebook-deliverability','{\"fields\":[\"label\",\"notebooks\"]}','[]','2023-02-24 21:40:26.861000','2023-02-24 21:40:26.861000',NULL,NULL),
(419,'plugin::content-manager.explorer.update','api::notebook-deliverability.notebook-deliverability','{\"fields\":[\"label\",\"notebooks\"]}','[]','2023-02-24 21:40:26.871000','2023-02-24 21:40:26.871000',NULL,NULL),
(423,'plugin::content-manager.explorer.create','api::tex.tex','{\"fields\":[\"name\",\"amount\",\"label\",\"included\"]}','[]','2023-03-01 21:15:11.007000','2023-03-01 21:15:11.007000',NULL,NULL),
(424,'plugin::content-manager.explorer.read','api::tex.tex','{\"fields\":[\"name\",\"amount\",\"label\",\"included\"]}','[]','2023-03-01 21:15:11.021000','2023-03-01 21:15:11.021000',NULL,NULL),
(425,'plugin::content-manager.explorer.update','api::tex.tex','{\"fields\":[\"name\",\"amount\",\"label\",\"included\"]}','[]','2023-03-01 21:15:11.030000','2023-03-01 21:15:11.030000',NULL,NULL),
(426,'plugin::content-manager.explorer.create','api::cart.cart','{\"fields\":[\"fingerprint\",\"wishlist\",\"products\",\"order\",\"totalGross\",\"totalVat\",\"total\"]}','[]','2023-03-03 21:41:35.707000','2023-03-03 21:41:35.707000',NULL,NULL),
(427,'plugin::content-manager.explorer.read','api::cart.cart','{\"fields\":[\"fingerprint\",\"wishlist\",\"products\",\"order\",\"totalGross\",\"totalVat\",\"total\"]}','[]','2023-03-03 21:41:35.721000','2023-03-03 21:41:35.721000',NULL,NULL),
(428,'plugin::content-manager.explorer.update','api::cart.cart','{\"fields\":[\"fingerprint\",\"wishlist\",\"products\",\"order\",\"totalGross\",\"totalVat\",\"total\"]}','[]','2023-03-03 21:41:35.729000','2023-03-03 21:41:35.729000',NULL,NULL);
/*!40000 ALTER TABLE `admin_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_permissions_role_links`
--

DROP TABLE IF EXISTS `admin_permissions_role_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_permissions_role_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `permission_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_permissions_role_links_unique` (`permission_id`,`role_id`),
  KEY `admin_permissions_role_links_fk` (`permission_id`),
  KEY `admin_permissions_role_links_inv_fk` (`role_id`),
  KEY `admin_permissions_role_links_order_inv_fk` (`permission_order`),
  CONSTRAINT `admin_permissions_role_links_fk` FOREIGN KEY (`permission_id`) REFERENCES `admin_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `admin_permissions_role_links_inv_fk` FOREIGN KEY (`role_id`) REFERENCES `admin_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=429 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_permissions_role_links`
--

LOCK TABLES `admin_permissions_role_links` WRITE;
/*!40000 ALTER TABLE `admin_permissions_role_links` DISABLE KEYS */;
INSERT INTO `admin_permissions_role_links` VALUES
(1,1,2,1),
(2,2,2,2),
(3,3,2,3),
(4,4,2,4),
(5,5,2,5),
(6,6,2,6),
(7,7,3,1),
(8,8,3,2),
(9,9,3,3),
(10,10,3,4),
(11,11,3,5),
(12,12,3,6),
(13,13,1,1),
(14,14,1,2),
(15,15,1,3),
(16,16,1,4),
(17,17,1,5),
(18,18,1,6),
(19,19,1,7),
(20,20,1,8),
(21,21,1,9),
(22,22,1,10),
(23,23,1,11),
(24,24,1,12),
(25,25,1,13),
(26,26,1,14),
(27,27,1,15),
(28,28,1,16),
(29,29,1,17),
(30,30,1,18),
(31,31,1,19),
(32,32,1,20),
(33,33,1,21),
(34,34,1,22),
(35,35,1,23),
(36,36,1,24),
(37,37,1,25),
(38,38,1,26),
(39,39,1,27),
(40,40,1,28),
(41,41,1,29),
(42,42,1,30),
(43,43,1,31),
(44,44,1,32),
(45,45,1,33),
(46,46,1,34),
(47,47,1,35),
(48,48,1,36),
(49,49,1,37),
(50,50,1,38),
(51,51,1,39),
(52,52,1,40),
(53,53,1,41),
(54,54,1,42),
(55,55,1,43),
(56,56,1,44),
(57,57,1,45),
(58,58,1,46),
(59,59,1,47),
(60,60,1,48),
(61,61,1,49),
(62,62,1,50),
(63,63,1,51),
(64,64,1,52),
(65,65,1,53),
(69,69,1,57),
(73,73,1,61),
(89,89,1,74),
(93,93,1,78),
(106,106,1,88),
(107,107,1,89),
(108,108,1,90),
(109,109,1,91),
(113,113,1,92),
(114,114,1,93),
(115,115,1,94),
(116,116,1,95),
(117,117,1,96),
(118,118,1,97),
(122,122,1,101),
(127,127,1,106),
(132,132,1,111),
(140,140,1,119),
(147,147,1,126),
(151,151,1,130),
(173,173,1,137),
(174,174,1,138),
(175,175,1,139),
(197,197,1,155),
(219,219,1,168),
(221,221,1,170),
(223,223,1,172),
(231,231,1,176),
(232,232,1,177),
(233,233,1,178),
(261,261,1,188),
(263,263,1,190),
(265,265,1,192),
(276,276,1,200),
(281,281,1,205),
(282,282,1,206),
(283,283,1,207),
(284,284,1,208),
(285,285,1,209),
(295,295,1,219),
(299,299,1,223),
(300,300,1,224),
(301,301,1,225),
(302,302,1,226),
(303,303,1,227),
(304,304,1,228),
(305,305,1,229),
(315,315,1,236),
(320,320,3,7),
(321,321,3,8),
(322,322,3,9),
(323,323,3,10),
(324,324,3,11),
(325,325,3,12),
(326,326,3,13),
(327,327,3,14),
(328,328,3,15),
(329,329,3,16),
(330,330,3,17),
(331,331,3,18),
(332,332,3,19),
(333,333,3,20),
(334,334,3,21),
(335,335,3,22),
(336,336,3,23),
(337,337,3,24),
(338,338,3,25),
(339,339,3,26),
(340,340,3,27),
(341,341,3,28),
(342,342,3,29),
(343,343,3,30),
(344,344,3,31),
(345,345,3,32),
(346,346,3,33),
(347,347,3,34),
(348,348,3,35),
(349,349,3,36),
(350,350,3,37),
(351,351,3,38),
(352,352,3,39),
(353,353,3,40),
(354,354,3,41),
(355,355,3,42),
(356,356,3,43),
(357,357,3,44),
(358,358,3,45),
(359,359,3,46),
(360,360,3,47),
(361,361,3,48),
(362,362,3,49),
(363,363,3,50),
(364,364,3,51),
(365,365,3,52),
(366,366,3,53),
(367,367,3,54),
(368,368,2,7),
(369,369,2,8),
(370,370,2,9),
(371,371,2,10),
(372,372,2,11),
(373,373,2,12),
(374,374,2,13),
(375,375,2,14),
(376,376,2,15),
(377,377,2,16),
(378,378,2,17),
(379,379,2,18),
(380,380,2,19),
(381,381,2,20),
(382,382,2,21),
(383,383,2,22),
(384,384,2,23),
(385,385,2,24),
(386,386,2,25),
(387,387,2,26),
(388,388,2,27),
(389,389,2,28),
(390,390,2,29),
(391,391,2,30),
(392,392,2,31),
(393,393,2,32),
(394,394,2,33),
(395,395,2,34),
(396,396,2,35),
(397,397,2,36),
(398,398,2,37),
(399,399,2,38),
(400,400,2,39),
(401,401,2,40),
(402,402,1,237),
(403,403,1,238),
(404,404,1,239),
(411,411,1,240),
(412,412,1,241),
(413,413,1,242),
(414,414,1,243),
(415,415,1,244),
(416,416,1,245),
(417,417,1,246),
(418,418,1,247),
(419,419,1,248),
(423,423,1,252),
(424,424,1,253),
(425,425,1,254),
(426,426,1,255),
(427,427,1,256),
(428,428,1,257);
/*!40000 ALTER TABLE `admin_permissions_role_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_roles`
--

DROP TABLE IF EXISTS `admin_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_roles_created_by_id_fk` (`created_by_id`),
  KEY `admin_roles_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `admin_roles_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `admin_roles_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_roles`
--

LOCK TABLES `admin_roles` WRITE;
/*!40000 ALTER TABLE `admin_roles` DISABLE KEYS */;
INSERT INTO `admin_roles` VALUES
(1,'Super Admin','strapi-super-admin','Super Admins can access and manage all features and settings.','2023-02-20 17:34:24.582000','2023-02-20 17:34:24.582000',NULL,NULL),
(2,'Controlling','strapi-editor','Editors can manage and publish contents including those of other users.','2023-02-20 17:34:24.594000','2023-02-23 19:33:12.281000',NULL,NULL),
(3,'Content Marketing','strapi-author','Authors can manage the content they have created.','2023-02-20 17:34:24.601000','2023-02-23 19:32:25.494000',NULL,NULL);
/*!40000 ALTER TABLE `admin_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `registration_token` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `prefered_language` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_users_created_by_id_fk` (`created_by_id`),
  KEY `admin_users_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `admin_users_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `admin_users_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES
(1,'Michael','Werner',NULL,'strapi@dailysh.it','$2a$10$irOW5OSvfZwG.2jWoBX1geVmV0sxQ/w.eRvbGc5GxzUpk4JLLStPq',NULL,NULL,1,0,NULL,'2023-02-20 22:33:15.267000','2023-02-20 22:33:15.267000',NULL,NULL);
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users_roles_links`
--

DROP TABLE IF EXISTS `admin_users_roles_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users_roles_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `role_order` double unsigned DEFAULT NULL,
  `user_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_roles_links_unique` (`user_id`,`role_id`),
  KEY `admin_users_roles_links_fk` (`user_id`),
  KEY `admin_users_roles_links_inv_fk` (`role_id`),
  KEY `admin_users_roles_links_order_fk` (`role_order`),
  KEY `admin_users_roles_links_order_inv_fk` (`user_order`),
  CONSTRAINT `admin_users_roles_links_fk` FOREIGN KEY (`user_id`) REFERENCES `admin_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `admin_users_roles_links_inv_fk` FOREIGN KEY (`role_id`) REFERENCES `admin_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users_roles_links`
--

LOCK TABLES `admin_users_roles_links` WRITE;
/*!40000 ALTER TABLE `admin_users_roles_links` DISABLE KEYS */;
INSERT INTO `admin_users_roles_links` VALUES
(1,1,1,1,1);
/*!40000 ALTER TABLE `admin_users_roles_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fingerprint` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `products` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`products`)),
  `total_gross` decimal(10,2) DEFAULT NULL,
  `total_vat` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carts_fingerprint_unique` (`fingerprint`),
  KEY `carts_created_by_id_fk` (`created_by_id`),
  KEY `carts_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `carts_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `carts_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES
(1,'djaslkjdlkjalksd98sadn98sa7da9s87dasd','2023-02-22 17:02:43.851000','2023-02-23 22:19:29.502000',1,1,'[{\"path\":\"api::notebook.notebook/1\",\"id\":1,\"count\":1},{\"path\":\"api::notebook.notebook/2\",\"id\":2,\"count\":1},{\"path\":\"api::notebook.notebook/4\",\"id\":4,\"count\":4}]',NULL,NULL,NULL),
(2,'2341318749','2023-02-24 07:08:26.982000','2023-02-24 07:08:26.982000',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'staging_1234','2023-02-24 07:11:33.135000','2023-02-24 07:36:12.550000',NULL,1,'[{\"id\":1,\"count\":3}]',NULL,NULL,NULL),
(4,'staging_2341318749','2023-02-24 07:17:08.662000','2023-03-03 21:11:45.841000',NULL,1,'[{\"id\":2,\"count\":6,\"total\":106.80000000000001,\"name\":\"Softcover Notizblock - blanko - 100% Recycling Papier - 3D Muster Kollektion\"}]',106.80,NULL,NULL),
(9,'staging_565295196','2023-02-24 12:21:06.167000','2023-02-26 20:36:41.474000',NULL,1,'[{\"id\":1,\"count\":9,\"total\":220.5,\"name\":\"Hardcover Notizblock - blanko - 100% Recycling Papier - Klassische Muster Kollektion\"},{\"id\":2,\"count\":3,\"total\":53.400000000000006,\"name\":\"Softcover Notizblock - blanko - 100% Recycling Papier - 3D Muster Kollektion\"}]',273.90,NULL,NULL),
(10,'staging_2169255087','2023-02-24 12:22:32.625000','2023-02-24 12:22:32.625000',NULL,NULL,NULL,NULL,NULL,NULL),
(11,'staging_518810299','2023-02-24 13:04:38.262000','2023-02-24 13:05:17.620000',NULL,1,'[{\"id\":1,\"count\":3}]',NULL,NULL,NULL),
(12,'staging_3677450245','2023-02-24 13:05:21.734000','2023-02-28 14:20:22.133000',NULL,1,'[{\"id\":1,\"count\":2,\"total\":null}]',NULL,NULL,NULL),
(13,'staging_3223647749','2023-02-24 21:10:19.532000','2023-02-24 21:10:19.532000',NULL,NULL,NULL,NULL,NULL,NULL),
(14,'staging_12345','2023-02-24 21:22:00.193000','2023-02-24 21:26:50.159000',NULL,NULL,'[{\"id\":1,\"count\":3}]',NULL,NULL,NULL),
(15,'staging_2013783092','2023-02-24 21:29:28.471000','2023-02-27 08:24:50.015000',NULL,NULL,'[{\"id\":1,\"count\":3}]',NULL,NULL,NULL),
(16,'staging_751265900','2023-02-26 13:34:07.964000','2023-02-26 13:34:07.964000',NULL,NULL,NULL,NULL,NULL,NULL),
(17,'staging_4110741662','2023-02-26 13:41:04.896000','2023-02-26 13:41:04.896000',NULL,NULL,NULL,NULL,NULL,NULL),
(18,'staging_4095825189','2023-03-01 08:13:29.308000','2023-03-01 20:19:37.473000',NULL,NULL,'[]',0.00,NULL,NULL),
(19,'staging_2104699030','2023-03-01 15:08:04.835000','2023-03-01 17:41:15.541000',NULL,NULL,'[{\"id\":8,\"count\":13,\"total\":231.4,\"name\":\"Softcover Notizblock - gepunktet - 120 Seiten\"},{\"id\":2,\"count\":8,\"total\":142.4,\"name\":\"Softcover Notizblock - blanko - 100% Recycling Papier - 3D Muster Kollektion\"},{\"id\":5,\"count\":12,\"total\":213.60000000000002,\"name\":\"Softcover Notizblock - kariert - 80 Seiten\"},{\"id\":1,\"count\":9,\"total\":220.5,\"name\":\"Hardcover Notizblock - blanko - 100% Recycling Papier - Klassische Muster Kollektion\"}]',807.90,NULL,NULL),
(20,'staging_255665968','2023-03-01 19:51:30.544000','2023-03-01 20:29:56.781000',NULL,NULL,'[{\"id\":1,\"count\":7,\"total\":171.5,\"name\":\"Hardcover Notizblock - blanko - 100% Recycling Papier - Klassische Muster Kollektion\"},{\"id\":2,\"count\":1,\"total\":17.8,\"name\":\"Softcover Notizblock - blanko - 100% Recycling Papier - 3D Muster Kollektion\"}]',189.30,NULL,NULL),
(21,'staging_3774946169','2023-03-01 21:02:58.753000','2023-03-01 21:02:58.753000',NULL,NULL,NULL,0.00,NULL,NULL),
(22,'staging_4104314808','2023-03-01 21:17:55.930000','2023-03-01 21:17:55.930000',NULL,NULL,NULL,0.00,NULL,NULL),
(23,'staging_1298334615','2023-03-01 21:18:18.575000','2023-03-02 09:54:49.707000',NULL,NULL,'[{\"id\":1,\"count\":10,\"total\":245,\"name\":\"Hardcover Notizblock - blanko - 100% Recycling Papier - Klassische Muster Kollektion\"},{\"id\":5,\"count\":6,\"total\":106.80000000000001,\"name\":\"Softcover Notizblock - kariert - 80 Seiten\"},{\"id\":7,\"count\":5,\"total\":89,\"name\":\"Softcover Notizblock - blanko - 160 Seiten \"}]',440.80,NULL,NULL),
(24,'staging_3166288717','2023-03-03 15:54:28.437000','2023-03-03 15:54:28.437000',NULL,NULL,NULL,0.00,NULL,NULL),
(25,'staging_259148362','2023-03-03 21:16:26.248000','2023-03-03 21:38:29.608000',NULL,NULL,'[{\"id\":1,\"count\":6,\"total\":147,\"name\":\"Hardcover Notizblock - blanko - 100% Recycling Papier - Klassische Muster Kollektion\"},{\"id\":5,\"count\":4,\"total\":71.2,\"name\":\"Softcover Notizblock - kariert - 80 Seiten\"}]',218.20,NULL,NULL),
(26,'staging_523272369','2023-03-03 21:41:19.327000','2023-03-03 21:41:19.327000',NULL,NULL,NULL,0.00,NULL,NULL),
(27,'staging_1631830836','2023-03-10 21:28:44.622000','2023-03-10 21:28:44.622000',NULL,NULL,NULL,0.00,NULL,NULL);
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts_wishlist_links`
--

DROP TABLE IF EXISTS `carts_wishlist_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts_wishlist_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int(10) unsigned DEFAULT NULL,
  `notebook_id` int(10) unsigned DEFAULT NULL,
  `notebook_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carts_wishlist_links_unique` (`cart_id`,`notebook_id`),
  KEY `carts_wishlist_links_fk` (`cart_id`),
  KEY `carts_wishlist_links_inv_fk` (`notebook_id`),
  KEY `carts_wishlist_links_order_fk` (`notebook_order`),
  CONSTRAINT `carts_wishlist_links_fk` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `carts_wishlist_links_inv_fk` FOREIGN KEY (`notebook_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts_wishlist_links`
--

LOCK TABLES `carts_wishlist_links` WRITE;
/*!40000 ALTER TABLE `carts_wishlist_links` DISABLE KEYS */;
INSERT INTO `carts_wishlist_links` VALUES
(1,1,3,2),
(2,1,2,1),
(3,3,4,1);
/*!40000 ALTER TABLE `carts_wishlist_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `components_content_seos`
--

DROP TABLE IF EXISTS `components_content_seos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `components_content_seos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` longtext DEFAULT NULL,
  `keywords` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `components_content_seos`
--

LOCK TABLES `components_content_seos` WRITE;
/*!40000 ALTER TABLE `components_content_seos` DISABLE KEYS */;
INSERT INTO `components_content_seos` VALUES
(1,'Muji\'s natural and simple design complements today\'s lifestyles perfectly.','muji, furniture, stationery, clothing, gifts, travel, living, household, filing, pens, pencils, notebooks, craft, bedroom, storage, laundry, utilities, glassware, bags, electronics');
/*!40000 ALTER TABLE `components_content_seos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `components_content_websites`
--

DROP TABLE IF EXISTS `components_content_websites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `components_content_websites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  `last_updated` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `components_content_websites`
--

LOCK TABLES `components_content_websites` WRITE;
/*!40000 ALTER TABLE `components_content_websites` DISABLE KEYS */;
INSERT INTO `components_content_websites` VALUES
(1,'Allgemeine Geschäftsbedingungen','<h4>muellerprints.</h4>\n<b>Inhaber:</b>\n<br/>Max Müller\n<br/>\n<br/>Rotenbergstraße 39\n<br/>70190 Stuttgart\n<br/>\n<br/>T + 49 (0)711 / 262 49 64\n<br/>F + 49 (0)711 / 262 48 60\n<br/>Email: muellerprints@t-online.de\n<br/>\n<br/>www.muellerprints.de\n<br/>\n<br/>Umsatzsteuer-Identifikationsnummer gemäß § 27 a Umsatzsteuergesetz: DE 147595459\n<br/>\n<br/>Plattform der EU-Kommission zur Online-Streitbeilegung: <a\nhref=\"https://ec.europa.eu/consumers/odr\">https://ec.europa.eu/consumers/odr</a>\n<br/>Wir sind zur Teilnahme an einem Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle weder\nverpflichtet noch bereit.\n<br/>\n<br/>\n<span className=\"glyphicon glyphicon-copyright-mark\"/> muellerprints. Stuttgart 2022\n<br/>\n<br/>',NULL),
(2,'Impressum','<h4>muellerprints.</h4>\n<b>Inhaber:</b>\n<br/>Max Müller\n<br/>\n<br/>Rotenbergstraße 39\n<br/>70190 Stuttgart\n<br/>\n<br/>T + 49 (0)711 / 262 49 64\n<br/>F + 49 (0)711 / 262 48 60\n<br/>Email: muellerprints@t-online.de\n<br/>\n<br/>www.muellerprints.de\n<br/>\n<br/>Umsatzsteuer-Identifikationsnummer gemäß § 27 a Umsatzsteuergesetz: DE 147595459\n<br/>\n<br/>Plattform der EU-Kommission zur Online-Streitbeilegung: <a\nhref=\"https://ec.europa.eu/consumers/odr\">https://ec.europa.eu/consumers/odr</a>\n<br/>Wir sind zur Teilnahme an einem Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle weder\nverpflichtet noch bereit.\n<br/>\n<br/>\n<span className=\"glyphicon glyphicon-copyright-mark\"/> muellerprints. Stuttgart 2022\n<br/>\n<br/>',NULL),
(3,'Datenschutzerklärung','<h2>Datenschutzerklärung</h2>\n<br/>\n<h4>1) Information über die Erhebung personenbezogener Daten und Kontaktdaten des Verantwortlichen</h4>\n\n<b>1.1</b> Wir freuen uns, dass Sie unsere Website besuchen und bedanken uns für Ihr Interesse. Im Folgenden\ninformieren wir Sie über den Umgang mit Ihren personenbezogenen Daten bei der Nutzung unserer Website.\nPersonenbezogene Daten sind hierbei alle Daten, mit denen Sie persönlich identifiziert werden können.\n<br/>\n<b>1.2</b> Verantwortlicher für die Datenverarbeitung auf dieser Website im Sinne der Datenschutz-Grundverordnung\n(DSGVO) ist Max Müller, Rotenbergstraße 39, 70190 Stuttgart, Deutschland, Tel.: + 49 (0)711 / 262 49 64, Fax: + 49\n(0)711 / 262 48 60, E-Mail: muellerprints@t-online.de. Der für die Verarbeitung von personenbezogenen Daten\nVerantwortliche ist diejenige natürliche oder juristische Person, die allein oder gemeinsam mit anderen über die\nZwecke und Mittel der Verarbeitung von personenbezogenen Daten entscheidet.\n<br/>\n<b>1.3</b> Diese Website nutzt aus Sicherheitsgründen und zum Schutz der Übertragung personenbezogener Daten und\nanderer vertraulicher Inhalte (z.B. Bestellungen oder Anfragen an den Verantwortlichen) eine SSL-bzw.\nTLS-Verschlüsselung. Sie können eine verschlüsselte Verbindung an der Zeichenfolge „https://“ und dem Schloss-Symbol\nin Ihrer Browserzeile erkennen.\n<br/>\n<br/>\n<h4>2) Datenerfassung beim Besuch unserer Website</h4> Bei der bloß informatorischen Nutzung unserer Website, also\nwenn Sie sich nicht registrieren oder uns anderweitig Informationen übermitteln, erheben wir nur solche Daten, die\nIhr Browser an unseren Server übermittelt (sog. „Server-Logfiles“). Wenn Sie unsere Website aufrufen, erheben wir\ndie folgenden Daten, die für uns technisch erforderlich sind, um Ihnen die Website anzuzeigen:\n<br/>\n<br/>\n<ul>\n	<li>Unsere besuchte Website</li>\n	<li>Datum und Uhrzeit zum Zeitpunkt des Zugriffes</li>\n	<li>Menge der gesendeten Daten in Byte</li>\n	<li>Quelle/Verweis, von welchem Sie auf die Seite gelangten</li>\n	<li>Verwendeter Browser</li>\n	<li>Verwendetes Betriebssystem</li>\n	<li>Verwendete IP-Adresse (ggf.: in anonymisierter Form)</li>\n	<br/>\n</ul>\nDie Verarbeitung erfolgt gemäß Art. 6 Abs. 1 lit. f DSGVO auf Basis unseres berechtigten Interesses an der\nVerbesserung der Stabilität und Funktionalität unserer Website. Eine Weitergabe oder anderweitige Verwendung der\nDaten findet nicht statt. Wir behalten uns allerdings vor, die Server-Logfiles nachträglich zu überprüfen, sollten\nkonkrete Anhaltspunkte auf eine rechtswidrige Nutzung hinweisen.\n<br/>\n<br/>\n<h4>3) Cookies</h4> Um den Besuch unserer Website attraktiv zu gestalten und die Nutzung bestimmter Funktionen zu\nermöglichen, verwenden wir auf verschiedenen Seiten sogenannte Cookies. Hierbei handelt es sich um kleine\nTextdateien, die auf Ihrem Endgerät abgelegt werden. Einige der von uns verwendeten Cookies werden nach dem Ende der\nBrowser-Sitzung, also nach Schließen Ihres Browsers, wieder gelöscht (sog. Sitzungs-Cookies). Andere Cookies\nverbleiben auf Ihrem Endgerät und ermöglichen uns oder unseren Partnerunternehmen (Cookies von Drittanbietern),\nIhren Browser beim nächsten Besuch wiederzuerkennen (sog. persistente Cookies). Werden Cookies gesetzt, erheben und\nverarbeiten diese im individuellen Umfang bestimmte Nutzerinformationen wie Browser- und Standortdaten sowie\nIP-Adresswerte. Persistente Cookies werden automatisiert nach einer vorgegebenen Dauer gelöscht, die sich je nach\nCookie unterscheiden kann.\n\n<br/>Teilweise dienen die Cookies dazu, durch Speicherung von Einstellungen den Bestellprozess zu vereinfachen (z.B.\nMerken des Inhalts eines virtuellen Warenkorbs für einen späteren Besuch auf der Website). Sofern durch einzelne von\nuns eingesetzte Cookies auch personenbezogene Daten verarbeitet werden, erfolgt die Verarbeitung gemäß Art. 6 Abs. 1\nlit. b DSGVO entweder zur Durchführung des Vertrages oder gemäß Art. 6 Abs. 1 lit. f DSGVO zur Wahrung unserer\nberechtigten Interessen an der bestmöglichen Funktionalität der Website sowie einer kundenfreundlichen und\neffektiven Ausgestaltung des Seitenbesuchs.\n\n<br/>Wir arbeiten unter Umständen mit Werbepartnern zusammen, die uns helfen, unser Internetangebot für Sie\ninteressanter zu gestalten. Zu diesem Zweck werden für diesen Fall bei Ihrem Besuch unserer Website auch Cookies von\nPartnerunternehmen auf Ihrer Festplatte gespeichert (Cookies von Drittanbietern). Wenn wir mit vorbenannten\nWerbepartnern zusammenarbeiten, werden Sie über den Einsatz derartiger Cookies und den Umfang der jeweils erhobenen\nInformationen innerhalb der nachstehenden Absätze individuell und gesondert informiert.\n\n<br/>Bitte beachten Sie, dass Sie Ihren Browser so einstellen können, dass Sie über das Setzen von Cookies\ninformiert werden und einzeln über deren Annahme entscheiden oder die Annahme von Cookies für bestimmte Fälle oder\ngenerell ausschließen können. Jeder Browser unterscheidet sich in der Art, wie er die Cookie-Einstellungen\nverwaltet. Diese ist in dem Hilfemenü jedes Browsers beschrieben, welches Ihnen erläutert, wie Sie Ihre\nCookie-Einstellungen ändern können. Diese finden Sie für die jeweiligen Browser unter den folgenden Links:\n<br/>\n<br/>Internet Explorer: <a\nhref=\" https://support.microsoft.com/de-de/help/17442/windows-internet-explorer-delete-manage-cookies\"> https://support.microsoft.com/de-de/help/17442/windows-internet-explorer-delete-manage-cookies</a>\n<br/>Firefox: <a\nhref=\"https://support.mozilla.org/de/kb/cookies-erlauben-und-ablehnen\">https://support.mozilla.org/de/kb/cookies-erlauben-und-ablehnen</a>\n<br/>Chrome: <a\nhref=\"https://support.google.com/chrome/answer/95647?hl=de&hlrm=en\">https://support.google.com/chrome/answer/95647?hl=de&hlrm=en</a>\n<br/>Safari: <a\nhref=\" https://support.apple.com/de-de/guide/safari/sfri11471/mac\"> https://support.apple.com/de-de/guide/safari/sfri11471/mac</a>\n<br/>Opera: <a\nhref=\" https://help.opera.com/en/latest/web-preferences/#cookies\"> https://help.opera.com/en/latest/web-preferences/#cookies</a>\n<br/>\n<br/>Bitte beachten Sie, dass bei Nichtannahme von Cookies die Funktionalität unserer Website eingeschränkt sein\nkann.\n<br/>\n<br/>\n<h4>4) Kontaktaufnahme</h4> Im Rahmen der Kontaktaufnahme mit uns (z.B. per Kontaktformular oder E-Mail) werden\npersonenbezogene Daten erhoben. Welche Daten im Falle eines Kontaktformulars erhoben werden, ist aus dem jeweiligen\nKontaktformular ersichtlich. Diese Daten werden ausschließlich zum Zweck der Beantwortung Ihres Anliegens bzw. für\ndie Kontaktaufnahme und die damit verbundene technische Administration gespeichert und verwendet. Rechtsgrundlage\nfür die Verarbeitung dieser Daten ist unser berechtigtes Interesse an der Beantwortung Ihres Anliegens gemäß Art. 6\nAbs. 1 lit. f DSGVO. Zielt Ihre Kontaktierung auf den Abschluss eines Vertrages ab, so ist zusätzliche\nRechtsgrundlage für die Verarbeitung Art. 6 Abs. 1 lit. b DSGVO. Ihre Daten werden nach abschließender Bearbeitung\nIhrer Anfrage gelöscht. Dies ist der Fall, wenn sich aus den Umständen entnehmen lässt, dass der betroffene\nSachverhalt abschließend geklärt ist und sofern keine gesetzlichen Aufbewahrungspflichten entgegenstehen.\n<br/>\n<br/>\n<h4>5) Datenverarbeitung bei Eröffnung eines Kundenkontos und zur Vertragsabwicklung</h4> Gemäß Art. 6 Abs. 1 lit. b\nDSGVO werden personenbezogene Daten weiterhin erhoben und verarbeitet, wenn Sie uns diese zur Durchführung eines\nVertrages oder bei der Eröffnung eines Kundenkontos mitteilen. Welche Daten erhoben werden, ist aus den jeweiligen\nEingabeformularen ersichtlich. Eine Löschung Ihres Kundenkontos ist jederzeit möglich und kann durch eine Nachricht\nan die o.g. Adresse des Verantwortlichen erfolgen. Wir speichern und verwenden die von Ihnen mitgeteilten Daten zur\nVertragsabwicklung. Nach vollständiger Abwicklung des Vertrages oder Löschung Ihres Kundenkontos werden Ihre Daten\nmit Rücksicht auf steuer- und handelsrechtliche Aufbewahrungsfristen gesperrt und nach Ablauf dieser Fristen\ngelöscht, sofern Sie nicht ausdrücklich in eine weitere Nutzung Ihrer Daten eingewilligt haben oder eine gesetzlich\nerlaubte weitere Datenverwendung von unserer Seite vorbehalten wurde.\n<br/>\n<br/>\n<h4>6) Datenverarbeitung zur Bestellabwicklung</h4> Zur Abwicklung Ihrer Bestellung arbeiten wir mit dem / den\nnachstehenden Dienstleistern zusammen, die uns ganz oder teilweise bei der Durchführung geschlossener Verträge\nunterstützen. An diese Dienstleister werden nach Maßgabe der folgenden Informationen gewisse personenbezogene Daten\nübermittelt.\n\n<br/>Die von uns erhobenen personenbezogenen Daten werden im Rahmen der Vertragsabwicklung an das mit der Lieferung\nbeauftragte Transportunternehmen weitergegeben, soweit dies zur Lieferung der Ware erforderlich ist. Ihre\nZahlungsdaten geben wir im Rahmen der Zahlungsabwicklung an das beauftragte Kreditinstitut weiter, sofern dies für\ndie Zahlungsabwicklung erforderlich ist. Sofern Zahlungsdienstleister eingesetzt werden, informieren wir Sie\nhierüber nachstehend explizit. Rechtsgrundlage für die Weitergabe der Daten ist Art. 6 Abs. 1 lit. b DSGVO.\n<br/>\n<br/>\n\n\n<h4>7) Webanalysedienste</h4>\n\n<p>Matomo (ehemals Piwik)</p>\n\n<p>Auf dieser Website werden unter Einsatz der Webanalysedienst-Software Matomo (www.matomo.org), einem Dienst des\n	Anbieters InnoCraft Ltd., 150 Willis St, 6011 Wellington, Neuseeland, (&bdquo;Matomo&ldquo;) auf Basis unseres\n	berechtigten Interesses an der statistischen Analyse des Nutzerverhaltens zu Optimierungs- und Marketingzwecken\n	gem&auml;&szlig; Art. 6 Abs. 1 lit. f DSGVO Daten gesammelt und gespeichert. Aus diesen Daten k&ouml;nnen zum\n	selben Zweck pseudonymisierte Nutzungsprofile erstellt und ausgewertet werden. Hierzu k&ouml;nnen Cookies\n	eingesetzt werden. Bei Cookies handelt es sich um kleine Textdateien, die lokal im Zwischenspeicher des\n	Internet-Browsers des Seitenbesuchers gespeichert werden. Die Cookies erm&ouml;glichen unter anderem die\n	Wiedererkennung des Internet-Browsers. Die mit der Matomo-Technologie erhobenen Daten (einschlie&szlig;lich Ihrer\n	pseudonymisierten IP-Adresse) werden auf unseren Servern verarbeitet.</p>\n\n<p>Die durch das Cookie erzeugten Informationen im pseudonymen Nutzerprofil werden nicht dazu benutzt, den Besucher\n	dieser Website pers&ouml;nlich zu identifizieren und nicht mit personenbezogenen Daten &uuml;ber den Tr&auml;ger\n	des Pseudonyms zusammengef&uuml;hrt.</p>\n\n<p>Wenn Sie mit der Speicherung und Auswertung dieser Daten aus Ihrem Besuch nicht einverstanden sind, dann\n	k&ouml;nnen Sie der Speicherung und Nutzung nachfolgend per Mausklick jederzeit widersprechen. In diesem Fall wird\n	in Ihrem Browser ein sog. Opt-Out-Cookie abgelegt, was zur Folge hat, dass Matomo keinerlei Sitzungsdaten erhebt.\n	Bitte beachten Sie, dass die vollst&auml;ndige L&ouml;schung Ihrer Cookies zur Folge hat, dass auch das\n	Opt-Out-Cookie gel&ouml;scht wird und ggf. von Ihnen erneut aktiviert werden muss.</p>\n\n<div className=\"row\">\n	<br/>\n	<div className=\"col-md-6\">\n		<a href=\"//picasso.uber.space/matomos/index.php?module=CoreAdminHome&action=optOut&language=de\">\n			<h5 style=\"border: solid 1px; padding: 5px; text-align: center\">Webanalysedienste konfigurieren, bzw.\n				widersprechen</h5>\n		</a>\n		<br/>\n	</div>\n</div>\n\n\n\n<h4>8) Rechte des Betroffenen</h4>\n\n<b>8.1</b> Das geltende Datenschutzrecht gewährt Ihnen gegenüber dem Verantwortlichen hinsichtlich der Verarbeitung\nIhrer personenbezogenen Daten umfassende Betroffenenrechte (Auskunfts- und Interventionsrechte), über die wir Sie\nnachstehend informieren:\n<br/>\n<br/>\n\n<ul>\n	<li>\n		Auskunftsrecht gemäß Art. 15 DSGVO: Sie haben insbesondere ein Recht auf Auskunft über Ihre von uns\n		verarbeiteten personenbezogenen Daten, die Verarbeitungszwecke, die Kategorien der verarbeiteten\n		personenbezogenen Daten, die Empfänger oder Kategorien\n		von Empfängern, gegenüber denen Ihre Daten offengelegt wurden oder werden, die geplante Speicherdauer bzw. die\n		Kriterien für die Festlegung der Speicherdauer, das Bestehen eines Rechts auf Berichtigung, Löschung,\n		Einschränkung der Verarbeitung,\n		Widerspruch gegen die Verarbeitung, Beschwerde bei einer Aufsichtsbehörde, die Herkunft Ihrer Daten, wenn diese\n		nicht durch uns bei Ihnen erhoben wurden, das Bestehen einer automatisierten Entscheidungsfindung einschließlich\n		Profiling und ggf. aussagekräftige\n		Informationen über die involvierte Logik und die Sie betreffende Tragweite und die angestrebten Auswirkungen\n		einer solchen Verarbeitung, sowie Ihr Recht auf Unterrichtung, welche Garantien gemäß Art. 46 DSGVO bei\n		Weiterleitung Ihrer Daten in Drittländer\n		bestehen;\n	</li>\n	<li>\n		Recht auf Berichtigung gemäß Art. 16 DSGVO: Sie haben ein Recht auf unverzügliche Berichtigung Sie betreffender\n		unrichtiger Daten und/oder Vervollständigung Ihrer bei uns gespeicherten unvollständigen Daten;\n	</li>\n	<li>\n		Recht auf Löschung gemäß Art. 17 DSGVO: Sie haben das Recht, die Löschung Ihrer personenbezogenen Daten bei\n		Vorliegen der Voraussetzungen des Art. 17 Abs. 1 DSGVO zu verlangen. Dieses Recht besteht jedoch insbesondere\n		dann nicht, wenn die Verarbeitung\n		zur Ausübung des Rechts auf freie Meinungsäußerung und Information, zur Erfüllung einer rechtlichen\n		Verpflichtung, aus Gründen des öffentlichen Interesses oder zur Geltendmachung, Ausübung oder Verteidigung von\n		Rechtsansprüchen erforderlich ist;\n	</li>\n	<li>\n		Recht auf Einschränkung der Verarbeitung gemäß Art. 18 DSGVO: Sie haben das Recht, die Einschränkung der\n		Verarbeitung Ihrer personenbezogenen Daten zu verlangen, solange die von Ihnen bestrittene Richtigkeit Ihrer\n		Daten überprüft wird, wenn Sie eine Löschung\n		Ihrer Daten wegen unzulässiger Datenverarbeitung ablehnen und stattdessen die Einschränkung der Verarbeitung\n		Ihrer Daten verlangen, wenn Sie Ihre Daten zur Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen\n		benötigen, nachdem wir diese\n		Daten nach Zweckerreichung nicht mehr benötigen oder wenn Sie Widerspruch aus Gründen Ihrer besonderen Situation\n		eingelegt haben, solange noch nicht feststeht, ob unsere berechtigten Gründe überwiegen;\n	</li>\n	<li>\n		Recht auf Unterrichtung gemäß Art. 19 DSGVO: Haben Sie das Recht auf Berichtigung, Löschung oder Einschränkung\n		der Verarbeitung gegenüber dem Verantwortlichen geltend gemacht, ist dieser verpflichtet, allen Empfängern,\n		denen die Sie betreffenden personenbezogenen\n		Daten offengelegt wurden, diese Berichtigung oder Löschung der Daten oder Einschränkung der Verarbeitung\n		mitzuteilen, es sei denn, dies erweist sich als unmöglich oder ist mit einem unverhältnismäßigen Aufwand\n		verbunden. Ihnen steht das Recht zu,\n		über diese Empfänger unterrichtet zu werden.\n	</li>\n	<li>\n		Recht auf Datenübertragbarkeit gemäß Art. 20 DSGVO: Sie haben das Recht, Ihre personenbezogenen Daten, die Sie\n		uns bereitgestellt haben, in einem strukturierten, gängigen und maschinenlesebaren Format zu erhalten oder die\n		Übermittlung an einen anderen\n		Verantwortlichen zu verlangen, soweit dies technisch machbar ist;\n	</li>\n	<li>\n		Recht auf Widerruf erteilter Einwilligungen gemäß Art. 7 Abs. 3 DSGVO: Sie haben das Recht, eine einmal erteilte\n		Einwilligung in die Verarbeitung von Daten jederzeit mit Wirkung für die Zukunft zu widerrufen. Im Falle des\n		Widerrufs werden wir die betroffenen\n		Daten unverzüglich löschen, sofern eine weitere Verarbeitung nicht auf eine Rechtsgrundlage zur\n		einwilligungslosen Verarbeitung gestützt werden kann. Durch den Widerruf der Einwilligung wird die\n		Rechtmäßigkeit der aufgrund der Einwilligung bis zum\n		Widerruf erfolgten Verarbeitung nicht berührt;\n	</li>\n	<li>\n		Recht auf Beschwerde gemäß Art. 77 DSGVO: Wenn Sie der Ansicht sind, dass die Verarbeitung der Sie betreffenden\n		personenbezogenen Daten gegen die DSGVO verstößt, haben Sie - unbeschadet eines anderweitigen\n		verwaltungsrechtlichen oder gerichtlichen Rechtsbehelfs\n		- das Recht auf Beschwerde bei einer Aufsichtsbehörde, insbesondere in dem Mitgliedstaat Ihres Aufenthaltsortes,\n		Ihres Arbeitsplatzes oder des Ortes des mutmaßlichen Verstoßes.\n	</li>\n</ul>\n\n<br/>\n<h4><span style=\"font-size: 15px\">8.2</span> Widerspruchsrecht</h4>WENN WIR IM RAHMEN EINER INTERESSENABWÄGUNG IHRE\nPERSONENBEZOGENEN DATEN AUFGRUND UNSERES ÜBERWIEGENDEN BERECHTIGTEN INTERESSES VERARBEITEN, HABEN SIE DAS\nJEDERZEITIGE RECHT, AUS GRÜNDEN, DIE SICH AUS IHRER BESONDEREN SITUATION ERGEBEN, GEGEN DIESE VERARBEITUNG\nWIDERSPRUCH MIT WIRKUNG FÜR DIE ZUKUNFT EINZULEGEN.\nMACHEN SIE VON IHREM WIDERSPRUCHSRECHT GEBRAUCH, BEENDEN WIR DIE VERARBEITUNG DER BETROFFENEN DATEN. EINE\nWEITERVERARBEITUNG BLEIBT ABER VORBEHALTEN, WENN WIR ZWINGENDE SCHUTZWÜRDIGE GRÜNDE FÜR DIE VERARBEITUNG NACHWEISEN\nKÖNNEN, DIE IHRE INTERESSEN, GRUNDRECHTE UND GRUNDFREIHEITEN ÜBERWIEGEN, ODER WENN DIE VERARBEITUNG DER\nGELTENDMACHUNG, AUSÜBUNG ODER VERTEIDIGUNG VON RECHTSANSPRÜCHEN DIENT.\n\nWERDEN IHRE PERSONENBEZOGENEN DATEN VON UNS VERARBEITET, UM DIREKTWERBUNG ZU BETREIBEN, HABEN SIE DAS RECHT,\nJEDERZEIT WIDERSPRUCH GEGEN DIE VERARBEITUNG SIE BETREFFENDER PERSONENBEZOGENER DATEN ZUM ZWECKE DERARTIGER WERBUNG\nEINZULEGEN. SIE KÖNNEN DEN WIDERSPRUCH WIE OBEN BESCHRIEBEN AUSÜBEN.\n\nMACHEN SIE VON IHREM WIDERSPRUCHSRECHT GEBRAUCH, BEENDEN WIR DIE VERARBEITUNG DER BETROFFENEN DATEN ZU\nDIREKTWERBEZWECKEN.\n<br/>\n<br/>\n<h4>9) Dauer der Speicherung personenbezogener Daten</h4> Die Dauer der Speicherung von personenbezogenen Daten\nbemisst sich anhand der jeweiligen Rechtsgrundlage, am Verarbeitungszweck und – sofern einschlägig – zusätzlich\nanhand der jeweiligen gesetzlichen Aufbewahrungsfrist (z.B. handels- und steuerrechtliche Aufbewahrungsfristen).\n<br/><br/>\nBei der Verarbeitung von personenbezogenen Daten auf Grundlage einer ausdrücklichen Einwilligung gemäß Art. 6 Abs. 1\nlit. a DSGVO werden diese Daten so lange gespeichert, bis der Betroffene seine Einwilligung widerruft.\n<br/><br/>\nExistieren gesetzliche Aufbewahrungsfristen für Daten, die im Rahmen rechtsgeschäftlicher bzw.\nrechtsgeschäftsähnlicher Verpflichtungen auf der Grundlage von Art. 6 Abs. 1 lit. b DSGVO verarbeitet werden, werden\ndiese Daten nach Ablauf der Aufbewahrungsfristen routinemäßig gelöscht, sofern sie nicht mehr zur Vertragserfüllung\noder Vertragsanbahnung erforderlich sind und/oder unsererseits kein berechtigtes Interesse an der Weiterspeicherung\nfortbesteht.\n<br/><br/>\nBei der Verarbeitung von personenbezogenen Daten auf Grundlage von Art. 6 Abs. 1 lit. f DSGVO werden diese Daten so\nlange gespeichert, bis der Betroffene sein Widerspruchsrecht nach Art. 21 Abs. 1 DSGVO ausübt, es sei denn, wir\nkönnen zwingende schutzwürdige Gründe für die Verarbeitung nachweisen, die die Interessen, Rechte und Freiheiten der\nbetroffenen Person überwiegen, oder die Verarbeitung dient der Geltendmachung, Ausübung oder Verteidigung von\nRechtsansprüchen.\n<br/><br/>\nBei der Verarbeitung von personenbezogenen Daten zum Zwecke der Direktwerbung auf Grundlage von Art. 6 Abs. 1 lit. f\nDSGVO werden diese Daten so lange gespeichert, bis der Betroffene sein Widerspruchsrecht nach Art. 21 Abs. 2 DSGVO\nausübt.\n<br/><br/>\nSofern sich aus den sonstigen Informationen dieser Erklärung über spezifische Verarbeitungssituationen nichts\nanderes ergibt, werden gespeicherte personenbezogene Daten im Übrigen dann gelöscht, wenn sie für die Zwecke, für\ndie sie erhoben oder auf sonstige Weise verarbeitet wurden, nicht mehr notwendig sind.\n',NULL);
/*!40000 ALTER TABLE `components_content_websites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `covers`
--

DROP TABLE IF EXISTS `covers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `covers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `covers_created_by_id_fk` (`created_by_id`),
  KEY `covers_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `covers_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `covers_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `covers`
--

LOCK TABLES `covers` WRITE;
/*!40000 ALTER TABLE `covers` DISABLE KEYS */;
INSERT INTO `covers` VALUES
(1,'Hardcover','2023-02-23 12:36:56.993000','2023-02-23 12:36:56.993000',1,1),
(2,'Softcover','2023-02-23 12:38:19.440000','2023-02-23 12:40:42.401000',1,1),
(3,'Heft','2023-02-23 12:38:32.564000','2023-02-23 12:40:52.636000',1,1);
/*!40000 ALTER TABLE `covers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliveries`
--

DROP TABLE IF EXISTS `deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliveries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `min_total` decimal(10,2) DEFAULT NULL,
  `free_delivery_total` decimal(10,2) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `multiplied_cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deliveries_created_by_id_fk` (`created_by_id`),
  KEY `deliveries_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `deliveries_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `deliveries_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveries`
--

LOCK TABLES `deliveries` WRITE;
/*!40000 ALTER TABLE `deliveries` DISABLE KEYS */;
INSERT INTO `deliveries` VALUES
(1,'DHL',3.50,10.00,25.00,'2023-02-22 16:59:55.843000','2023-02-22 16:59:55.843000',1,1,NULL),
(2,'Abholung',0.00,0.00,0.00,'2023-02-22 17:00:14.121000','2023-02-22 17:00:14.121000',1,1,NULL),
(3,'Hermes',12.00,0.00,NULL,'2023-02-23 12:40:10.167000','2023-02-23 12:40:10.167000',1,1,NULL);
/*!40000 ALTER TABLE `deliveries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `action` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `events_created_by_id_fk` (`created_by_id`),
  KEY `events_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `events_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `events_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES
(1,'click','2023-02-23 12:42:06.279000','2023-02-23 12:42:15.822000',1,1,'component-header','Clicked on Cart'),
(2,'error','2023-02-23 12:42:45.699000','2023-02-23 12:42:45.699000',1,1,'component-header','Exception ...'),
(3,'','2023-02-23 16:34:51.031000','2023-02-23 16:34:51.031000',NULL,NULL,'',''),
(4,'hover','2023-02-23 16:36:19.564000','2023-02-23 16:36:19.564000',NULL,NULL,'component-header','hovered profile icon'),
(5,'hover','2023-02-23 16:36:23.098000','2023-02-23 16:36:23.098000',NULL,NULL,'component-header','hovered profile icon'),
(6,'hover','2023-02-23 16:36:23.533000','2023-02-23 16:36:23.533000',NULL,NULL,'component-header','hovered profile icon'),
(7,'click','2023-02-23 16:36:30.919000','2023-02-23 16:36:30.919000',NULL,NULL,'component-header','clicked profile icon'),
(8,'click','2023-02-23 16:36:31.147000','2023-02-23 16:36:31.147000',NULL,NULL,'component-header','clicked profile icon'),
(9,'click','2023-02-23 16:36:31.362000','2023-02-23 16:36:31.362000',NULL,NULL,'component-header','clicked profile icon'),
(10,'click','2023-02-23 16:36:31.546000','2023-02-23 16:36:31.546000',NULL,NULL,'component-header','clicked profile icon'),
(11,'click','2023-03-10 21:27:51.361000','2023-03-10 21:27:51.361000',NULL,NULL,'component-header','clicked profile icon');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `alternative_text` varchar(255) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `formats` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`formats`)),
  `hash` varchar(255) DEFAULT NULL,
  `ext` varchar(255) DEFAULT NULL,
  `mime` varchar(255) DEFAULT NULL,
  `size` decimal(10,2) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `preview_url` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `provider_metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`provider_metadata`)),
  `folder_path` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `upload_files_folder_path_index` (`folder_path`),
  KEY `upload_files_created_at_index` (`created_at`),
  KEY `upload_files_updated_at_index` (`updated_at`),
  KEY `upload_files_name_index` (`name`),
  KEY `upload_files_size_index` (`size`),
  KEY `upload_files_ext_index` (`ext`),
  KEY `files_created_by_id_fk` (`created_by_id`),
  KEY `files_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `files_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `files_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES
(1,'3D-Muster-01.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_3D-Muster-01.jpg\",\"hash\":\"thumbnail_3_D_Muster_01_12de6259c5\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":9.76,\"url\":\"/uploads/thumbnail_3_D_Muster_01_12de6259c5.jpg\"}}','3_D_Muster_01_12de6259c5','.jpg','image/jpeg',12.89,'/uploads/3_D_Muster_01_12de6259c5.jpg',NULL,'local',NULL,'/','2023-02-21 13:29:58.608000','2023-02-21 13:30:18.469000',1,1),
(2,'3D-Muster-02.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_3D-Muster-02.jpg\",\"hash\":\"thumbnail_3_D_Muster_02_8222e79b1e\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":10.53,\"url\":\"/uploads/thumbnail_3_D_Muster_02_8222e79b1e.jpg\"}}','3_D_Muster_02_8222e79b1e','.jpg','image/jpeg',13.86,'/uploads/3_D_Muster_02_8222e79b1e.jpg',NULL,'local',NULL,'/','2023-02-21 13:29:58.611000','2023-02-21 13:29:58.611000',1,1),
(3,'class-Muster-01.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_class-Muster-01.jpg\",\"hash\":\"thumbnail_class_Muster_01_bcb17f6365\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":20.1,\"url\":\"/uploads/thumbnail_class_Muster_01_bcb17f6365.jpg\"}}','class_Muster_01_bcb17f6365','.jpg','image/jpeg',28.71,'/uploads/class_Muster_01_bcb17f6365.jpg',NULL,'local',NULL,'/','2023-02-21 13:34:55.683000','2023-02-21 13:34:55.683000',1,1),
(4,'class-Muster-02.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_class-Muster-02.jpg\",\"hash\":\"thumbnail_class_Muster_02_a19775649a\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":20.71,\"url\":\"/uploads/thumbnail_class_Muster_02_a19775649a.jpg\"}}','class_Muster_02_a19775649a','.jpg','image/jpeg',29.33,'/uploads/class_Muster_02_a19775649a.jpg',NULL,'local',NULL,'/','2023-02-21 13:34:55.695000','2023-02-21 13:34:55.695000',1,1),
(5,'class-Muster-04.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_class-Muster-04.jpg\",\"hash\":\"thumbnail_class_Muster_04_bad825941f\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":19.99,\"url\":\"/uploads/thumbnail_class_Muster_04_bad825941f.jpg\"}}','class_Muster_04_bad825941f','.jpg','image/jpeg',27.35,'/uploads/class_Muster_04_bad825941f.jpg',NULL,'local',NULL,'/','2023-02-21 13:36:04.175000','2023-02-21 13:36:04.175000',1,1),
(6,'class-Muster-05.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_class-Muster-05.jpg\",\"hash\":\"thumbnail_class_Muster_05_071adee9a2\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":18.6,\"url\":\"/uploads/thumbnail_class_Muster_05_071adee9a2.jpg\"}}','class_Muster_05_071adee9a2','.jpg','image/jpeg',27.27,'/uploads/class_Muster_05_071adee9a2.jpg',NULL,'local',NULL,'/','2023-02-21 13:36:04.180000','2023-02-21 13:36:04.180000',1,1),
(7,'class-Muster-06.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_class-Muster-06.jpg\",\"hash\":\"thumbnail_class_Muster_06_c4abd3b326\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":19.2,\"url\":\"/uploads/thumbnail_class_Muster_06_c4abd3b326.jpg\"}}','class_Muster_06_c4abd3b326','.jpg','image/jpeg',28.05,'/uploads/class_Muster_06_c4abd3b326.jpg',NULL,'local',NULL,'/','2023-02-21 13:36:04.191000','2023-02-21 13:36:04.191000',1,1),
(8,'class-Muster-03.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_class-Muster-03.jpg\",\"hash\":\"thumbnail_class_Muster_03_be4dbc8527\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":20.33,\"url\":\"/uploads/thumbnail_class_Muster_03_be4dbc8527.jpg\"}}','class_Muster_03_be4dbc8527','.jpg','image/jpeg',27.87,'/uploads/class_Muster_03_be4dbc8527.jpg',NULL,'local',NULL,'/','2023-02-21 13:36:04.195000','2023-02-21 13:36:04.195000',1,1),
(9,'class-Muster-07.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_class-Muster-07.jpg\",\"hash\":\"thumbnail_class_Muster_07_52fb02cb35\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":13.24,\"url\":\"/uploads/thumbnail_class_Muster_07_52fb02cb35.jpg\"}}','class_Muster_07_52fb02cb35','.jpg','image/jpeg',21.12,'/uploads/class_Muster_07_52fb02cb35.jpg',NULL,'local',NULL,'/','2023-02-21 13:36:04.260000','2023-02-21 13:36:04.260000',1,1),
(10,'class-Muster-08.jpg',NULL,NULL,300,198,'{\"thumbnail\":{\"name\":\"thumbnail_class-Muster-08.jpg\",\"hash\":\"thumbnail_class_Muster_08_96056fe867\",\"ext\":\".jpg\",\"mime\":\"image/jpeg\",\"path\":null,\"width\":236,\"height\":156,\"size\":18.78,\"url\":\"/uploads/thumbnail_class_Muster_08_96056fe867.jpg\"}}','class_Muster_08_96056fe867','.jpg','image/jpeg',29.73,'/uploads/class_Muster_08_96056fe867.jpg',NULL,'local',NULL,'/','2023-02-21 13:36:04.265000','2023-02-21 13:36:04.265000',1,1),
(11,'SOFT-3D-02.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_SOFT-3D-02.png\",\"hash\":\"thumbnail_SOFT_3_D_02_4ba08b7bf7\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":22.7,\"url\":\"/uploads/thumbnail_SOFT_3_D_02_4ba08b7bf7.png\"},\"small\":{\"name\":\"small_SOFT-3D-02.png\",\"hash\":\"small_SOFT_3_D_02_4ba08b7bf7\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":148.26,\"url\":\"/uploads/small_SOFT_3_D_02_4ba08b7bf7.png\"}}','SOFT_3_D_02_4ba08b7bf7','.png','image/png',96.16,'/uploads/SOFT_3_D_02_4ba08b7bf7.png',NULL,'local',NULL,'/','2023-02-23 22:12:48.758000','2023-02-23 22:12:48.758000',1,1),
(12,'HEFT-3D-02.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HEFT-3D-02.png\",\"hash\":\"thumbnail_HEFT_3_D_02_de4f2f6bb5\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":22.36,\"url\":\"/uploads/thumbnail_HEFT_3_D_02_de4f2f6bb5.png\"},\"small\":{\"name\":\"small_HEFT-3D-02.png\",\"hash\":\"small_HEFT_3_D_02_de4f2f6bb5\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":150.26,\"url\":\"/uploads/small_HEFT_3_D_02_de4f2f6bb5.png\"}}','HEFT_3_D_02_de4f2f6bb5','.png','image/png',99.95,'/uploads/HEFT_3_D_02_de4f2f6bb5.png',NULL,'local',NULL,'/','2023-02-23 22:12:48.808000','2023-02-23 22:12:48.808000',1,1),
(13,'SOFT-3D-01.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_SOFT-3D-01.png\",\"hash\":\"thumbnail_SOFT_3_D_01_b7b59c0c55\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":25.12,\"url\":\"/uploads/thumbnail_SOFT_3_D_01_b7b59c0c55.png\"},\"small\":{\"name\":\"small_SOFT-3D-01.png\",\"hash\":\"small_SOFT_3_D_01_b7b59c0c55\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":187.9,\"url\":\"/uploads/small_SOFT_3_D_01_b7b59c0c55.png\"}}','SOFT_3_D_01_b7b59c0c55','.png','image/png',114.35,'/uploads/SOFT_3_D_01_b7b59c0c55.png',NULL,'local',NULL,'/','2023-02-23 22:12:48.820000','2023-02-23 22:12:48.820000',1,1),
(14,'HEFT-3D-01.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HEFT-3D-01.png\",\"hash\":\"thumbnail_HEFT_3_D_01_e43cfbfde9\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":24.26,\"url\":\"/uploads/thumbnail_HEFT_3_D_01_e43cfbfde9.png\"},\"small\":{\"name\":\"small_HEFT-3D-01.png\",\"hash\":\"small_HEFT_3_D_01_e43cfbfde9\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":182.87,\"url\":\"/uploads/small_HEFT_3_D_01_e43cfbfde9.png\"}}','HEFT_3_D_01_e43cfbfde9','.png','image/png',105.38,'/uploads/HEFT_3_D_01_e43cfbfde9.png',NULL,'local',NULL,'/','2023-02-23 22:12:48.876000','2023-02-23 22:12:48.876000',1,1),
(15,'HARD-3D-01.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HARD-3D-01.png\",\"hash\":\"thumbnail_HARD_3_D_01_3fd6431a0c\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":24.2,\"url\":\"/uploads/thumbnail_HARD_3_D_01_3fd6431a0c.png\"},\"small\":{\"name\":\"small_HARD-3D-01.png\",\"hash\":\"small_HARD_3_D_01_3fd6431a0c\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":170.42,\"url\":\"/uploads/small_HARD_3_D_01_3fd6431a0c.png\"}}','HARD_3_D_01_3fd6431a0c','.png','image/png',99.10,'/uploads/HARD_3_D_01_3fd6431a0c.png',NULL,'local',NULL,'/','2023-02-23 22:20:25.341000','2023-02-23 22:20:25.341000',1,1),
(16,'HARD-3D-02.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HARD-3D-02.png\",\"hash\":\"thumbnail_HARD_3_D_02_2487a560a6\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":22.63,\"url\":\"/uploads/thumbnail_HARD_3_D_02_2487a560a6.png\"},\"small\":{\"name\":\"small_HARD-3D-02.png\",\"hash\":\"small_HARD_3_D_02_2487a560a6\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":154.54,\"url\":\"/uploads/small_HARD_3_D_02_2487a560a6.png\"}}','HARD_3_D_02_2487a560a6','.png','image/png',96.46,'/uploads/HARD_3_D_02_2487a560a6.png',NULL,'local',NULL,'/','2023-02-23 22:20:25.377000','2023-02-23 22:20:25.377000',1,1),
(17,'HARD-class-01.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HARD-class-01.png\",\"hash\":\"thumbnail_HARD_class_01_fb613192de\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":26.29,\"url\":\"/uploads/thumbnail_HARD_class_01_fb613192de.png\"},\"small\":{\"name\":\"small_HARD-class-01.png\",\"hash\":\"small_HARD_class_01_fb613192de\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":219.86,\"url\":\"/uploads/small_HARD_class_01_fb613192de.png\"}}','HARD_class_01_fb613192de','.png','image/png',150.27,'/uploads/HARD_class_01_fb613192de.png',NULL,'local',NULL,'/','2023-02-23 22:21:40.780000','2023-02-23 22:21:40.780000',1,1),
(18,'HARD-class-02.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HARD-class-02.png\",\"hash\":\"thumbnail_HARD_class_02_db850ddea6\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":26.22,\"url\":\"/uploads/thumbnail_HARD_class_02_db850ddea6.png\"},\"small\":{\"name\":\"small_HARD-class-02.png\",\"hash\":\"small_HARD_class_02_db850ddea6\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":222.28,\"url\":\"/uploads/small_HARD_class_02_db850ddea6.png\"}}','HARD_class_02_db850ddea6','.png','image/png',144.83,'/uploads/HARD_class_02_db850ddea6.png',NULL,'local',NULL,'/','2023-02-23 22:21:40.939000','2023-02-23 22:21:40.939000',1,1),
(19,'HEFT-class-02.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HEFT-class-02.png\",\"hash\":\"thumbnail_HEFT_class_02_9fa7c512c7\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":24.28,\"url\":\"/uploads/thumbnail_HEFT_class_02_9fa7c512c7.png\"},\"small\":{\"name\":\"small_HEFT-class-02.png\",\"hash\":\"small_HEFT_class_02_9fa7c512c7\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":196.89,\"url\":\"/uploads/small_HEFT_class_02_9fa7c512c7.png\"}}','HEFT_class_02_9fa7c512c7','.png','image/png',140.08,'/uploads/HEFT_class_02_9fa7c512c7.png',NULL,'local',NULL,'/','2023-02-23 22:21:40.955000','2023-02-23 22:21:40.955000',1,1),
(20,'HARD-class-03.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HARD-class-03.png\",\"hash\":\"thumbnail_HARD_class_03_562bfc79ea\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":27.56,\"url\":\"/uploads/thumbnail_HARD_class_03_562bfc79ea.png\"},\"small\":{\"name\":\"small_HARD-class-03.png\",\"hash\":\"small_HARD_class_03_562bfc79ea\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":213.56,\"url\":\"/uploads/small_HARD_class_03_562bfc79ea.png\"}}','HARD_class_03_562bfc79ea','.png','image/png',138.56,'/uploads/HARD_class_03_562bfc79ea.png',NULL,'local',NULL,'/','2023-02-23 22:21:40.986000','2023-02-23 22:21:40.986000',1,1),
(21,'HEFT-class-01.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HEFT-class-01.png\",\"hash\":\"thumbnail_HEFT_class_01_8e26bfff66\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":25.14,\"url\":\"/uploads/thumbnail_HEFT_class_01_8e26bfff66.png\"},\"small\":{\"name\":\"small_HEFT-class-01.png\",\"hash\":\"small_HEFT_class_01_8e26bfff66\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":215.16,\"url\":\"/uploads/small_HEFT_class_01_8e26bfff66.png\"}}','HEFT_class_01_8e26bfff66','.png','image/png',151.81,'/uploads/HEFT_class_01_8e26bfff66.png',NULL,'local',NULL,'/','2023-02-23 22:21:41.089000','2023-02-23 22:21:41.089000',1,1),
(22,'HEFT-class-03.png',NULL,NULL,400,700,'{\"thumbnail\":{\"name\":\"thumbnail_HEFT-class-03.png\",\"hash\":\"thumbnail_HEFT_class_03_464207f99d\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":89,\"height\":156,\"size\":26.43,\"url\":\"/uploads/thumbnail_HEFT_class_03_464207f99d.png\"},\"small\":{\"name\":\"small_HEFT-class-03.png\",\"hash\":\"small_HEFT_class_03_464207f99d\",\"ext\":\".png\",\"mime\":\"image/png\",\"path\":null,\"width\":286,\"height\":500,\"size\":210.15,\"url\":\"/uploads/small_HEFT_class_03_464207f99d.png\"}}','HEFT_class_03_464207f99d','.png','image/png',142.26,'/uploads/HEFT_class_03_464207f99d.png',NULL,'local',NULL,'/','2023-02-23 22:21:41.204000','2023-02-23 22:21:41.204000',1,1);
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files_folder_links`
--

DROP TABLE IF EXISTS `files_folder_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files_folder_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(10) unsigned DEFAULT NULL,
  `folder_id` int(10) unsigned DEFAULT NULL,
  `file_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `files_folder_links_unique` (`file_id`,`folder_id`),
  KEY `files_folder_links_fk` (`file_id`),
  KEY `files_folder_links_inv_fk` (`folder_id`),
  KEY `files_folder_links_order_inv_fk` (`file_order`),
  CONSTRAINT `files_folder_links_fk` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  CONSTRAINT `files_folder_links_inv_fk` FOREIGN KEY (`folder_id`) REFERENCES `upload_folders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files_folder_links`
--

LOCK TABLES `files_folder_links` WRITE;
/*!40000 ALTER TABLE `files_folder_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `files_folder_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files_related_morphs`
--

DROP TABLE IF EXISTS `files_related_morphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files_related_morphs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(10) unsigned DEFAULT NULL,
  `related_id` int(10) unsigned DEFAULT NULL,
  `related_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `files_related_morphs_fk` (`file_id`),
  CONSTRAINT `files_related_morphs_fk` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files_related_morphs`
--

LOCK TABLES `files_related_morphs` WRITE;
/*!40000 ALTER TABLE `files_related_morphs` DISABLE KEYS */;
INSERT INTO `files_related_morphs` VALUES
(1,1,1,'api::pattern.pattern','image',1),
(2,2,2,'api::pattern.pattern','image',1),
(3,3,3,'api::pattern.pattern','image',1),
(4,5,4,'api::pattern.pattern','image',1),
(5,14,3,'api::notebook.notebook','images',1),
(6,12,4,'api::notebook.notebook','images',1);
/*!40000 ALTER TABLE `files_related_morphs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `i18n_locale`
--

DROP TABLE IF EXISTS `i18n_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `i18n_locale` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `i18n_locale_created_by_id_fk` (`created_by_id`),
  KEY `i18n_locale_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `i18n_locale_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `i18n_locale_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `i18n_locale`
--

LOCK TABLES `i18n_locale` WRITE;
/*!40000 ALTER TABLE `i18n_locale` DISABLE KEYS */;
INSERT INTO `i18n_locale` VALUES
(1,'English (en)','en','2023-02-20 17:34:24.350000','2023-02-20 17:34:24.350000',NULL,NULL),
(2,'German (de)','de','2023-02-23 17:09:39.388000','2023-02-23 17:10:11.979000',1,1);
/*!40000 ALTER TABLE `i18n_locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imprints`
--

DROP TABLE IF EXISTS `imprints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imprints` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `imprints_created_by_id_fk` (`created_by_id`),
  KEY `imprints_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `imprints_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `imprints_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imprints`
--

LOCK TABLES `imprints` WRITE;
/*!40000 ALTER TABLE `imprints` DISABLE KEYS */;
INSERT INTO `imprints` VALUES
(1,'2023-02-23 16:45:04.405000','2023-02-23 16:45:04.405000',1,1);
/*!40000 ALTER TABLE `imprints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imprints_components`
--

DROP TABLE IF EXISTS `imprints_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imprints_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imprints_unique` (`entity_id`,`component_id`,`field`,`component_type`),
  KEY `imprints_field_index` (`field`),
  KEY `imprints_component_type_index` (`component_type`),
  KEY `imprints_entity_fk` (`entity_id`),
  CONSTRAINT `imprints_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `imprints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imprints_components`
--

LOCK TABLES `imprints_components` WRITE;
/*!40000 ALTER TABLE `imprints_components` DISABLE KEYS */;
INSERT INTO `imprints_components` VALUES
(1,1,2,'page.website','main',NULL);
/*!40000 ALTER TABLE `imprints_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rechnungsnummer` varchar(255) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `rechnungsdatum` date DEFAULT NULL,
  `sent` tinyint(1) DEFAULT NULL,
  `paid` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoices_rechnungsnummer_unique` (`rechnungsnummer`),
  KEY `invoices_created_by_id_fk` (`created_by_id`),
  KEY `invoices_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `invoices_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `invoices_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES
(1,'R20230001',NULL,'2023-02-08',1,1,'2023-02-23 12:58:25.082000','2023-02-24 12:16:56.791000',1,1);
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices_order_links`
--

DROP TABLE IF EXISTS `invoices_order_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices_order_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoices_order_links_unique` (`invoice_id`,`order_id`),
  KEY `invoices_order_links_fk` (`invoice_id`),
  KEY `invoices_order_links_inv_fk` (`order_id`),
  CONSTRAINT `invoices_order_links_fk` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoices_order_links_inv_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices_order_links`
--

LOCK TABLES `invoices_order_links` WRITE;
/*!40000 ALTER TABLE `invoices_order_links` DISABLE KEYS */;
INSERT INTO `invoices_order_links` VALUES
(2,1,2);
/*!40000 ALTER TABLE `invoices_order_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebook_deliverabilities`
--

DROP TABLE IF EXISTS `notebook_deliverabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebook_deliverabilities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notebook_deliverabilities_created_by_id_fk` (`created_by_id`),
  KEY `notebook_deliverabilities_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `notebook_deliverabilities_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `notebook_deliverabilities_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebook_deliverabilities`
--

LOCK TABLES `notebook_deliverabilities` WRITE;
/*!40000 ALTER TABLE `notebook_deliverabilities` DISABLE KEYS */;
INSERT INTO `notebook_deliverabilities` VALUES
(2,'lieferbar','2023-02-23 19:40:36.496000','2023-02-23 19:40:36.496000',1,1),
(3,'lieferbar (3-5 Werktag)','2023-02-23 19:41:03.597000','2023-02-23 19:41:03.597000',1,1),
(4,'nicht lieferbar','2023-02-23 19:41:13.960000','2023-02-23 19:41:13.960000',1,1),
(5,'auf Nachfrage','2023-02-23 19:41:24.236000','2023-02-23 19:41:24.236000',1,1);
/*!40000 ALTER TABLE `notebook_deliverabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebook_pages`
--

DROP TABLE IF EXISTS `notebook_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebook_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notebook_pages_created_by_id_fk` (`created_by_id`),
  KEY `notebook_pages_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `notebook_pages_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `notebook_pages_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebook_pages`
--

LOCK TABLES `notebook_pages` WRITE;
/*!40000 ALTER TABLE `notebook_pages` DISABLE KEYS */;
INSERT INTO `notebook_pages` VALUES
(1,'160 Seiten','2023-02-23 18:53:13.140000','2023-02-23 18:55:03.820000',1,1,1.20),
(2,'120 Seiten','2023-02-23 18:53:35.189000','2023-02-23 18:56:11.151000',1,1,1.00),
(3,'40 Seiten','2023-02-23 18:53:47.718000','2023-02-23 18:55:35.841000',1,1,0.00),
(4,'80 Seiten','2023-02-23 18:53:54.180000','2023-02-23 18:55:28.601000',1,1,0.60);
/*!40000 ALTER TABLE `notebook_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebook_papers`
--

DROP TABLE IF EXISTS `notebook_papers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebook_papers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `multiplied_cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notebook_papers_created_by_id_fk` (`created_by_id`),
  KEY `notebook_papers_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `notebook_papers_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `notebook_papers_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebook_papers`
--

LOCK TABLES `notebook_papers` WRITE;
/*!40000 ALTER TABLE `notebook_papers` DISABLE KEYS */;
INSERT INTO `notebook_papers` VALUES
(1,'gepunktet',0.50,'2023-02-23 18:58:39.207000','2023-02-23 18:58:39.207000',1,1,0.05),
(2,'liniert',0.50,'2023-02-23 18:59:00.697000','2023-02-23 18:59:00.697000',1,1,0.05),
(3,'kariert',0.50,'2023-02-23 18:59:09.891000','2023-02-23 18:59:09.891000',1,1,0.05),
(4,'blanko',0.00,'2023-02-23 18:59:20.750000','2023-02-23 18:59:20.750000',1,1,0.00);
/*!40000 ALTER TABLE `notebook_papers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebooks`
--

DROP TABLE IF EXISTS `notebooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` longtext DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `long_title` longtext DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `is_shippable` tinyint(1) DEFAULT NULL,
  `product_code` varchar(255) DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notebooks_created_by_id_fk` (`created_by_id`),
  KEY `notebooks_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `notebooks_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `notebooks_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebooks`
--

LOCK TABLES `notebooks` WRITE;
/*!40000 ALTER TABLE `notebooks` DISABLE KEYS */;
INSERT INTO `notebooks` VALUES
(1,'Description','2023-02-21 12:54:12.741000','2023-02-23 20:36:22.922000',1,1,200,'Hardcover Notizblock - blanko - 100% Recycling Papier - Klassische Muster Kollektion',NULL,24.50,1,'HDBLKL01S040','2023-02-21 12:54:12.741000'),
(2,'Description Softcover','2023-02-23 07:28:29.077000','2023-02-23 20:30:08.810000',1,1,120,'Softcover Notizblock - blanko - 100% Recycling Papier - 3D Muster Kollektion','Hergestellt in Deutschland mit 100% FSC zertifiziertem Recycling Papier × Handgebunden in Stuttgart ',17.80,1,'SFBL3D01S160','2023-02-23 07:28:29.077000'),
(3,'**Description Notizheft**\n\n# Was geht hier ab?\n\n','2023-02-23 07:28:57.924000','2023-02-23 22:13:13.263000',1,1,80,'Notizheft - blanko - 100% Recycling Papier - 3D Muster Kollektion','Hergestellt in Deutschland mit 100% FSC zertifiziertem Recycling Papier × Handgebunden in Stuttgart ',7.50,1,'HFBL3D02S040','2023-02-23 07:28:57.924000'),
(4,'Description Softcover','2023-02-23 16:25:25.195000','2023-02-23 22:14:19.499000',1,1,120,'Notizheft - kariert - 40 Seiten','Hergestellt in Deutschland mit 100% FSC zertifiziertem Recycling Papier · Handgebunden in Stuttgart · 3D Muster Kollektion',24.50,1,'HFKR3D02S040',NULL),
(5,'Description Softcover','2023-02-23 16:26:07.853000','2023-02-23 19:47:29.897000',1,1,120,'Softcover Notizblock - kariert - 80 Seiten','Hergestellt in Deutschland mit 100% FSC zertifiziertem Recycling Papier · Handgebunden in Stuttgart · 3D Muster Kollektion',17.80,NULL,'SFKR3D02S080','2023-02-23 16:26:07.853000'),
(6,'Description Softcover','2023-02-23 16:27:35.419000','2023-02-23 20:31:14.372000',1,1,120,'Softcover Notizblock - kariert - 100% Recycling Papier - 3D Muster Kollektion','Hergestellt in Deutschland mit 100% FSC zertifiziertem Recycling Papier × Handgebunden in Stuttgart ',17.80,NULL,'SFKR3D02S120',NULL),
(7,'Description Softcover','2023-02-23 16:27:58.378000','2023-02-23 20:30:15.324000',1,1,120,'Softcover Notizblock - blanko - 160 Seiten ','Hergestellt in Deutschland mit 100% FSC zertifiziertem Recycling Papier × Handgebunden in Stuttgart ',17.80,NULL,'SFBL3D02S160','2023-02-23 16:27:58.378000'),
(8,'Description Softcover','2023-02-23 16:28:37.842000','2023-02-23 20:30:21.134000',1,1,120,'Softcover Notizblock - gepunktet - 120 Seiten','Hergestellt in Deutschland mit 100% FSC zertifiziertem Recycling Papier · Handgebunden in Stuttgart · 3D Muster Kollektion',17.80,1,'SFGP3D02S120','2023-02-23 16:28:37.842000');
/*!40000 ALTER TABLE `notebooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebooks_best_sellers_links`
--

DROP TABLE IF EXISTS `notebooks_best_sellers_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebooks_best_sellers_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notebook_id` int(10) unsigned DEFAULT NULL,
  `inv_notebook_id` int(10) unsigned DEFAULT NULL,
  `notebook_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notebooks_best_sellers_links_unique` (`notebook_id`,`inv_notebook_id`),
  KEY `notebooks_best_sellers_links_fk` (`notebook_id`),
  KEY `notebooks_best_sellers_links_inv_fk` (`inv_notebook_id`),
  KEY `notebooks_best_sellers_links_order_fk` (`notebook_order`),
  CONSTRAINT `notebooks_best_sellers_links_fk` FOREIGN KEY (`notebook_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notebooks_best_sellers_links_inv_fk` FOREIGN KEY (`inv_notebook_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebooks_best_sellers_links`
--

LOCK TABLES `notebooks_best_sellers_links` WRITE;
/*!40000 ALTER TABLE `notebooks_best_sellers_links` DISABLE KEYS */;
INSERT INTO `notebooks_best_sellers_links` VALUES
(1,2,7,1),
(2,4,1,1),
(3,8,8,2),
(4,8,3,1),
(5,1,1,1),
(6,1,3,4),
(7,1,7,3),
(8,1,2,2),
(9,8,7,4),
(10,8,2,3),
(11,3,3,1),
(12,6,6,1);
/*!40000 ALTER TABLE `notebooks_best_sellers_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebooks_components`
--

DROP TABLE IF EXISTS `notebooks_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebooks_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notebooks_unique` (`entity_id`,`component_id`,`field`,`component_type`),
  KEY `notebooks_field_index` (`field`),
  KEY `notebooks_component_type_index` (`component_type`),
  KEY `notebooks_entity_fk` (`entity_id`),
  CONSTRAINT `notebooks_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebooks_components`
--

LOCK TABLES `notebooks_components` WRITE;
/*!40000 ALTER TABLE `notebooks_components` DISABLE KEYS */;
INSERT INTO `notebooks_components` VALUES
(1,1,1,'page.seo','meta',1);
/*!40000 ALTER TABLE `notebooks_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebooks_cover_links`
--

DROP TABLE IF EXISTS `notebooks_cover_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebooks_cover_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notebook_id` int(10) unsigned DEFAULT NULL,
  `cover_id` int(10) unsigned DEFAULT NULL,
  `notebook_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notebooks_cover_links_unique` (`notebook_id`,`cover_id`),
  KEY `notebooks_cover_links_fk` (`notebook_id`),
  KEY `notebooks_cover_links_inv_fk` (`cover_id`),
  KEY `notebooks_cover_links_order_inv_fk` (`notebook_order`),
  CONSTRAINT `notebooks_cover_links_fk` FOREIGN KEY (`notebook_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notebooks_cover_links_inv_fk` FOREIGN KEY (`cover_id`) REFERENCES `covers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebooks_cover_links`
--

LOCK TABLES `notebooks_cover_links` WRITE;
/*!40000 ALTER TABLE `notebooks_cover_links` DISABLE KEYS */;
INSERT INTO `notebooks_cover_links` VALUES
(1,1,1,1),
(2,3,3,1),
(3,2,2,1),
(5,5,2,2),
(6,6,2,3),
(7,7,2,4),
(8,8,2,5),
(10,4,3,2);
/*!40000 ALTER TABLE `notebooks_cover_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebooks_deliverability_links`
--

DROP TABLE IF EXISTS `notebooks_deliverability_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebooks_deliverability_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notebook_id` int(10) unsigned DEFAULT NULL,
  `notebook_deliverability_id` int(10) unsigned DEFAULT NULL,
  `notebook_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notebooks_deliverability_links_unique` (`notebook_id`,`notebook_deliverability_id`),
  KEY `notebooks_deliverability_links_fk` (`notebook_id`),
  KEY `notebooks_deliverability_links_inv_fk` (`notebook_deliverability_id`),
  KEY `notebooks_deliverability_links_order_inv_fk` (`notebook_order`),
  CONSTRAINT `notebooks_deliverability_links_fk` FOREIGN KEY (`notebook_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notebooks_deliverability_links_inv_fk` FOREIGN KEY (`notebook_deliverability_id`) REFERENCES `notebook_deliverabilities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebooks_deliverability_links`
--

LOCK TABLES `notebooks_deliverability_links` WRITE;
/*!40000 ALTER TABLE `notebooks_deliverability_links` DISABLE KEYS */;
INSERT INTO `notebooks_deliverability_links` VALUES
(1,1,2,NULL),
(2,5,2,NULL),
(3,3,2,NULL),
(4,2,2,NULL),
(5,7,2,NULL),
(6,8,2,NULL),
(7,6,2,NULL),
(8,4,2,NULL);
/*!40000 ALTER TABLE `notebooks_deliverability_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebooks_pages_links`
--

DROP TABLE IF EXISTS `notebooks_pages_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebooks_pages_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notebook_id` int(10) unsigned DEFAULT NULL,
  `notebook_page_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notebooks_pages_links_unique` (`notebook_id`,`notebook_page_id`),
  KEY `notebooks_pages_links_fk` (`notebook_id`),
  KEY `notebooks_pages_links_inv_fk` (`notebook_page_id`),
  CONSTRAINT `notebooks_pages_links_fk` FOREIGN KEY (`notebook_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notebooks_pages_links_inv_fk` FOREIGN KEY (`notebook_page_id`) REFERENCES `notebook_pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebooks_pages_links`
--

LOCK TABLES `notebooks_pages_links` WRITE;
/*!40000 ALTER TABLE `notebooks_pages_links` DISABLE KEYS */;
INSERT INTO `notebooks_pages_links` VALUES
(1,1,3),
(3,2,1),
(2,3,3),
(8,4,3),
(6,5,4),
(7,6,2),
(4,7,1),
(5,8,2);
/*!40000 ALTER TABLE `notebooks_pages_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebooks_paper_links`
--

DROP TABLE IF EXISTS `notebooks_paper_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebooks_paper_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notebook_id` int(10) unsigned DEFAULT NULL,
  `notebook_paper_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notebooks_paper_links_unique` (`notebook_id`,`notebook_paper_id`),
  KEY `notebooks_paper_links_fk` (`notebook_id`),
  KEY `notebooks_paper_links_inv_fk` (`notebook_paper_id`),
  CONSTRAINT `notebooks_paper_links_fk` FOREIGN KEY (`notebook_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notebooks_paper_links_inv_fk` FOREIGN KEY (`notebook_paper_id`) REFERENCES `notebook_papers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebooks_paper_links`
--

LOCK TABLES `notebooks_paper_links` WRITE;
/*!40000 ALTER TABLE `notebooks_paper_links` DISABLE KEYS */;
INSERT INTO `notebooks_paper_links` VALUES
(4,1,4),
(3,2,4),
(2,3,4),
(9,4,3),
(7,5,3),
(8,6,3),
(5,7,4),
(6,8,1);
/*!40000 ALTER TABLE `notebooks_paper_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebooks_pattern_links`
--

DROP TABLE IF EXISTS `notebooks_pattern_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebooks_pattern_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notebook_id` int(10) unsigned DEFAULT NULL,
  `pattern_id` int(10) unsigned DEFAULT NULL,
  `notebook_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notebooks_pattern_links_unique` (`notebook_id`,`pattern_id`),
  KEY `notebooks_pattern_links_fk` (`notebook_id`),
  KEY `notebooks_pattern_links_inv_fk` (`pattern_id`),
  KEY `notebooks_pattern_links_order_inv_fk` (`notebook_order`),
  CONSTRAINT `notebooks_pattern_links_fk` FOREIGN KEY (`notebook_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notebooks_pattern_links_inv_fk` FOREIGN KEY (`pattern_id`) REFERENCES `patterns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebooks_pattern_links`
--

LOCK TABLES `notebooks_pattern_links` WRITE;
/*!40000 ALTER TABLE `notebooks_pattern_links` DISABLE KEYS */;
INSERT INTO `notebooks_pattern_links` VALUES
(1,1,3,NULL),
(3,3,1,NULL),
(4,2,1,NULL),
(5,4,2,NULL),
(6,5,1,NULL),
(7,6,2,NULL),
(8,7,2,NULL),
(9,8,2,NULL);
/*!40000 ALTER TABLE `notebooks_pattern_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebooks_tax_links`
--

DROP TABLE IF EXISTS `notebooks_tax_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notebooks_tax_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notebook_id` int(10) unsigned DEFAULT NULL,
  `tex_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notebooks_tax_links_unique` (`notebook_id`,`tex_id`),
  KEY `notebooks_tax_links_fk` (`notebook_id`),
  KEY `notebooks_tax_links_inv_fk` (`tex_id`),
  CONSTRAINT `notebooks_tax_links_fk` FOREIGN KEY (`notebook_id`) REFERENCES `notebooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notebooks_tax_links_inv_fk` FOREIGN KEY (`tex_id`) REFERENCES `texes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebooks_tax_links`
--

LOCK TABLES `notebooks_tax_links` WRITE;
/*!40000 ALTER TABLE `notebooks_tax_links` DISABLE KEYS */;
INSERT INTO `notebooks_tax_links` VALUES
(2,1,1),
(3,2,1),
(1,3,1),
(7,4,1),
(6,6,1),
(4,7,1),
(5,8,1);
/*!40000 ALTER TABLE `notebooks_tax_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bestellnummer` varchar(255) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `sent` tinyint(1) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `total_netto` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_bestellnummer_unique` (`bestellnummer`),
  KEY `orders_created_by_id_fk` (`created_by_id`),
  KEY `orders_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `orders_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES
(1,'B202300001','Michael Czechowski\nSchnellweg 3\n70199 Stuttgart','2023-02-22 16:49:02.184000','2023-02-23 22:22:57.470000',1,1,1,100.00,19.00,119.00),
(2,'B202300002','Michael Czechowski\nSchnellweg 3\n70199 Stuttgart','2023-02-23 07:33:30.192000','2023-02-23 22:08:51.509000',1,1,1,100.00,19.00,119.00),
(3,NULL,NULL,'2023-03-03 21:43:05.675000','2023-03-03 21:43:05.675000',NULL,NULL,0,0.00,0.00,0.00),
(4,NULL,NULL,'2023-03-03 21:43:10.270000','2023-03-03 21:43:10.270000',NULL,NULL,0,0.00,0.00,0.00),
(5,NULL,NULL,'2023-03-03 21:43:11.309000','2023-03-03 21:43:11.309000',NULL,NULL,0,0.00,0.00,0.00),
(6,NULL,NULL,'2023-03-03 21:43:12.334000','2023-03-03 21:43:12.334000',NULL,NULL,0,0.00,0.00,0.00),
(7,NULL,NULL,'2023-03-03 21:43:45.583000','2023-03-03 21:43:45.583000',NULL,NULL,0,0.00,0.00,0.00),
(8,NULL,NULL,'2023-03-03 21:44:04.175000','2023-03-03 21:44:04.175000',NULL,NULL,0,0.00,0.00,0.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_cart_links`
--

DROP TABLE IF EXISTS `orders_cart_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_cart_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `cart_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_cart_links_unique` (`order_id`,`cart_id`),
  KEY `orders_cart_links_fk` (`order_id`),
  KEY `orders_cart_links_inv_fk` (`cart_id`),
  CONSTRAINT `orders_cart_links_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_cart_links_inv_fk` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_cart_links`
--

LOCK TABLES `orders_cart_links` WRITE;
/*!40000 ALTER TABLE `orders_cart_links` DISABLE KEYS */;
INSERT INTO `orders_cart_links` VALUES
(2,2,1),
(3,8,12);
/*!40000 ALTER TABLE `orders_cart_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_delivery_links`
--

DROP TABLE IF EXISTS `orders_delivery_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_delivery_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `delivery_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_delivery_links_unique` (`order_id`,`delivery_id`),
  KEY `orders_delivery_links_fk` (`order_id`),
  KEY `orders_delivery_links_inv_fk` (`delivery_id`),
  CONSTRAINT `orders_delivery_links_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_delivery_links_inv_fk` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_delivery_links`
--

LOCK TABLES `orders_delivery_links` WRITE;
/*!40000 ALTER TABLE `orders_delivery_links` DISABLE KEYS */;
INSERT INTO `orders_delivery_links` VALUES
(1,1,2),
(2,2,1);
/*!40000 ALTER TABLE `orders_delivery_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_payment_links`
--

DROP TABLE IF EXISTS `orders_payment_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_payment_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `payment_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_payment_links_unique` (`order_id`,`payment_id`),
  KEY `orders_payment_links_fk` (`order_id`),
  KEY `orders_payment_links_inv_fk` (`payment_id`),
  CONSTRAINT `orders_payment_links_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_payment_links_inv_fk` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_payment_links`
--

LOCK TABLES `orders_payment_links` WRITE;
/*!40000 ALTER TABLE `orders_payment_links` DISABLE KEYS */;
INSERT INTO `orders_payment_links` VALUES
(3,1,3),
(2,2,5);
/*!40000 ALTER TABLE `orders_payment_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_tax_links`
--

DROP TABLE IF EXISTS `orders_tax_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_tax_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `tex_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_tax_links_unique` (`order_id`,`tex_id`),
  KEY `orders_tax_links_fk` (`order_id`),
  KEY `orders_tax_links_inv_fk` (`tex_id`),
  CONSTRAINT `orders_tax_links_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_tax_links_inv_fk` FOREIGN KEY (`tex_id`) REFERENCES `texes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_tax_links`
--

LOCK TABLES `orders_tax_links` WRITE;
/*!40000 ALTER TABLE `orders_tax_links` DISABLE KEYS */;
INSERT INTO `orders_tax_links` VALUES
(1,2,1);
/*!40000 ALTER TABLE `orders_tax_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patterns`
--

DROP TABLE IF EXISTS `patterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patterns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patterns_created_by_id_fk` (`created_by_id`),
  KEY `patterns_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `patterns_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `patterns_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patterns`
--

LOCK TABLES `patterns` WRITE;
/*!40000 ALTER TABLE `patterns` DISABLE KEYS */;
INSERT INTO `patterns` VALUES
(1,'Koerper','2023-02-20 23:02:22.660000','2023-02-21 13:30:24.159000',1,1,'Körper - 01'),
(2,'Koerper','2023-02-21 12:18:07.256000','2023-02-21 13:30:36.075000',1,1,'Körper - 02'),
(3,'Klassisch','2023-02-21 12:29:17.554000','2023-02-21 13:36:47.561000',1,1,'Klassisch - 01'),
(4,'Klassisch','2023-02-21 12:29:33.759000','2023-02-21 13:39:35.640000',1,1,'Klassisch - 02');
/*!40000 ALTER TABLE `patterns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `min_total` double DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `published_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_created_by_id_fk` (`created_by_id`),
  KEY `payments_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `payments_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `payments_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES
(3,'BAR',0,NULL,'2023-02-22 16:58:51.490000','2023-02-22 16:58:51.490000',1,1,'2023-02-22 16:58:51.490000'),
(4,'VISA',10,NULL,'2023-02-22 16:59:03.785000','2023-02-23 17:51:53.207000',1,1,NULL),
(5,'PayPal',3,NULL,'2023-02-22 17:00:48.048000','2023-02-23 17:52:00.622000',1,1,NULL),
(6,'Auf Rechnung',0,NULL,'2023-02-23 12:26:23.870000','2023-02-23 12:26:23.870000',1,1,'2023-02-23 12:26:23.870000'),
(7,'Nachnahme',0,NULL,'2023-02-23 16:53:52.512000','2023-02-23 16:53:52.512000',1,1,'2023-02-23 16:53:52.512000'),
(8,'Vorkasse',NULL,NULL,'2023-02-23 16:54:05.941000','2023-02-23 16:54:05.941000',1,1,'2023-02-23 16:54:05.941000');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privacy_policies`
--

DROP TABLE IF EXISTS `privacy_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privacy_policies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `privacy_policies_created_by_id_fk` (`created_by_id`),
  KEY `privacy_policies_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `privacy_policies_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `privacy_policies_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacy_policies`
--

LOCK TABLES `privacy_policies` WRITE;
/*!40000 ALTER TABLE `privacy_policies` DISABLE KEYS */;
INSERT INTO `privacy_policies` VALUES
(1,'2023-02-23 16:52:54.573000','2023-02-23 16:52:54.573000',1,1);
/*!40000 ALTER TABLE `privacy_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privacy_policies_components`
--

DROP TABLE IF EXISTS `privacy_policies_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privacy_policies_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `privacy_policies_unique` (`entity_id`,`component_id`,`field`,`component_type`),
  KEY `privacy_policies_field_index` (`field`),
  KEY `privacy_policies_component_type_index` (`component_type`),
  KEY `privacy_policies_entity_fk` (`entity_id`),
  CONSTRAINT `privacy_policies_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `privacy_policies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacy_policies_components`
--

LOCK TABLES `privacy_policies_components` WRITE;
/*!40000 ALTER TABLE `privacy_policies_components` DISABLE KEYS */;
INSERT INTO `privacy_policies_components` VALUES
(1,1,3,'page.website','main',1);
/*!40000 ALTER TABLE `privacy_policies_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strapi_api_token_permissions`
--

DROP TABLE IF EXISTS `strapi_api_token_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strapi_api_token_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `strapi_api_token_permissions_created_by_id_fk` (`created_by_id`),
  KEY `strapi_api_token_permissions_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `strapi_api_token_permissions_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `strapi_api_token_permissions_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strapi_api_token_permissions`
--

LOCK TABLES `strapi_api_token_permissions` WRITE;
/*!40000 ALTER TABLE `strapi_api_token_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `strapi_api_token_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strapi_api_token_permissions_token_links`
--

DROP TABLE IF EXISTS `strapi_api_token_permissions_token_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strapi_api_token_permissions_token_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `api_token_permission_id` int(10) unsigned DEFAULT NULL,
  `api_token_id` int(10) unsigned DEFAULT NULL,
  `api_token_permission_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `strapi_api_token_permissions_token_links_unique` (`api_token_permission_id`,`api_token_id`),
  KEY `strapi_api_token_permissions_token_links_fk` (`api_token_permission_id`),
  KEY `strapi_api_token_permissions_token_links_inv_fk` (`api_token_id`),
  KEY `strapi_api_token_permissions_token_links_order_inv_fk` (`api_token_permission_order`),
  CONSTRAINT `strapi_api_token_permissions_token_links_fk` FOREIGN KEY (`api_token_permission_id`) REFERENCES `strapi_api_token_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `strapi_api_token_permissions_token_links_inv_fk` FOREIGN KEY (`api_token_id`) REFERENCES `strapi_api_tokens` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strapi_api_token_permissions_token_links`
--

LOCK TABLES `strapi_api_token_permissions_token_links` WRITE;
/*!40000 ALTER TABLE `strapi_api_token_permissions_token_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `strapi_api_token_permissions_token_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strapi_api_tokens`
--

DROP TABLE IF EXISTS `strapi_api_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strapi_api_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `access_key` varchar(255) DEFAULT NULL,
  `last_used_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `lifespan` bigint(20) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `strapi_api_tokens_created_by_id_fk` (`created_by_id`),
  KEY `strapi_api_tokens_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `strapi_api_tokens_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `strapi_api_tokens_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strapi_api_tokens`
--

LOCK TABLES `strapi_api_tokens` WRITE;
/*!40000 ALTER TABLE `strapi_api_tokens` DISABLE KEYS */;
INSERT INTO `strapi_api_tokens` VALUES
(1,'ROOT','','full-access','243c4cee23b5d607afed2897a03e726687aa522b45c7c2a0127f8f895c4bf8ecd89e92e576bfaade6c030c336888850f824e6013f70d26feae43dba6a54de7ca','2023-03-03 12:59:24.554000',NULL,NULL,'2023-02-23 16:57:31.510000','2023-03-03 12:59:24.554000',NULL,NULL);
/*!40000 ALTER TABLE `strapi_api_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strapi_core_store_settings`
--

DROP TABLE IF EXISTS `strapi_core_store_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strapi_core_store_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` longtext DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `environment` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strapi_core_store_settings`
--

LOCK TABLES `strapi_core_store_settings` WRITE;
/*!40000 ALTER TABLE `strapi_core_store_settings` DISABLE KEYS */;
INSERT INTO `strapi_core_store_settings` VALUES
(1,'strapi_content_types_schema','{\"admin::permission\":{\"collectionName\":\"admin_permissions\",\"info\":{\"name\":\"Permission\",\"description\":\"\",\"singularName\":\"permission\",\"pluralName\":\"permissions\",\"displayName\":\"Permission\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"subject\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":false},\"properties\":{\"type\":\"json\",\"configurable\":false,\"required\":false,\"default\":{}},\"conditions\":{\"type\":\"json\",\"configurable\":false,\"required\":false,\"default\":[]},\"role\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToOne\",\"inversedBy\":\"permissions\",\"target\":\"admin::role\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"admin_permissions\",\"info\":{\"name\":\"Permission\",\"description\":\"\",\"singularName\":\"permission\",\"pluralName\":\"permissions\",\"displayName\":\"Permission\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"subject\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":false},\"properties\":{\"type\":\"json\",\"configurable\":false,\"required\":false,\"default\":{}},\"conditions\":{\"type\":\"json\",\"configurable\":false,\"required\":false,\"default\":[]},\"role\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToOne\",\"inversedBy\":\"permissions\",\"target\":\"admin::role\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"permission\",\"connection\":\"default\",\"uid\":\"admin::permission\",\"plugin\":\"admin\",\"globalId\":\"AdminPermission\"},\"admin::user\":{\"collectionName\":\"admin_users\",\"info\":{\"name\":\"User\",\"description\":\"\",\"singularName\":\"user\",\"pluralName\":\"users\",\"displayName\":\"User\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"firstname\":{\"type\":\"string\",\"unique\":false,\"minLength\":1,\"configurable\":false,\"required\":false},\"lastname\":{\"type\":\"string\",\"unique\":false,\"minLength\":1,\"configurable\":false,\"required\":false},\"username\":{\"type\":\"string\",\"unique\":false,\"configurable\":false,\"required\":false},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true,\"unique\":true,\"private\":true},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"required\":false,\"private\":true},\"resetPasswordToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"registrationToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"isActive\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false,\"private\":true},\"roles\":{\"configurable\":false,\"private\":true,\"type\":\"relation\",\"relation\":\"manyToMany\",\"inversedBy\":\"users\",\"target\":\"admin::role\",\"collectionName\":\"strapi_users_roles\"},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false,\"private\":true},\"preferedLanguage\":{\"type\":\"string\",\"configurable\":false,\"required\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"admin_users\",\"info\":{\"name\":\"User\",\"description\":\"\",\"singularName\":\"user\",\"pluralName\":\"users\",\"displayName\":\"User\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"firstname\":{\"type\":\"string\",\"unique\":false,\"minLength\":1,\"configurable\":false,\"required\":false},\"lastname\":{\"type\":\"string\",\"unique\":false,\"minLength\":1,\"configurable\":false,\"required\":false},\"username\":{\"type\":\"string\",\"unique\":false,\"configurable\":false,\"required\":false},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true,\"unique\":true,\"private\":true},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"required\":false,\"private\":true},\"resetPasswordToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"registrationToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"isActive\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false,\"private\":true},\"roles\":{\"configurable\":false,\"private\":true,\"type\":\"relation\",\"relation\":\"manyToMany\",\"inversedBy\":\"users\",\"target\":\"admin::role\",\"collectionName\":\"strapi_users_roles\"},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false,\"private\":true},\"preferedLanguage\":{\"type\":\"string\",\"configurable\":false,\"required\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"user\",\"connection\":\"default\",\"uid\":\"admin::user\",\"plugin\":\"admin\",\"globalId\":\"AdminUser\"},\"admin::role\":{\"collectionName\":\"admin_roles\",\"info\":{\"name\":\"Role\",\"description\":\"\",\"singularName\":\"role\",\"pluralName\":\"roles\",\"displayName\":\"Role\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":1,\"unique\":true,\"configurable\":false,\"required\":true},\"code\":{\"type\":\"string\",\"minLength\":1,\"unique\":true,\"configurable\":false,\"required\":true},\"description\":{\"type\":\"string\",\"configurable\":false},\"users\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToMany\",\"mappedBy\":\"roles\",\"target\":\"admin::user\"},\"permissions\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"oneToMany\",\"mappedBy\":\"role\",\"target\":\"admin::permission\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"admin_roles\",\"info\":{\"name\":\"Role\",\"description\":\"\",\"singularName\":\"role\",\"pluralName\":\"roles\",\"displayName\":\"Role\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":1,\"unique\":true,\"configurable\":false,\"required\":true},\"code\":{\"type\":\"string\",\"minLength\":1,\"unique\":true,\"configurable\":false,\"required\":true},\"description\":{\"type\":\"string\",\"configurable\":false},\"users\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToMany\",\"mappedBy\":\"roles\",\"target\":\"admin::user\"},\"permissions\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"oneToMany\",\"mappedBy\":\"role\",\"target\":\"admin::permission\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"role\",\"connection\":\"default\",\"uid\":\"admin::role\",\"plugin\":\"admin\",\"globalId\":\"AdminRole\"},\"admin::api-token\":{\"collectionName\":\"strapi_api_tokens\",\"info\":{\"name\":\"Api Token\",\"singularName\":\"api-token\",\"pluralName\":\"api-tokens\",\"displayName\":\"Api Token\",\"description\":\"\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true,\"unique\":true},\"description\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":false,\"default\":\"\"},\"type\":{\"type\":\"enumeration\",\"enum\":[\"read-only\",\"full-access\",\"custom\"],\"configurable\":false,\"required\":true,\"default\":\"read-only\"},\"accessKey\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"lastUsedAt\":{\"type\":\"datetime\",\"configurable\":false,\"required\":false},\"permissions\":{\"type\":\"relation\",\"target\":\"admin::api-token-permission\",\"relation\":\"oneToMany\",\"mappedBy\":\"token\",\"configurable\":false,\"required\":false},\"expiresAt\":{\"type\":\"datetime\",\"configurable\":false,\"required\":false},\"lifespan\":{\"type\":\"biginteger\",\"configurable\":false,\"required\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"strapi_api_tokens\",\"info\":{\"name\":\"Api Token\",\"singularName\":\"api-token\",\"pluralName\":\"api-tokens\",\"displayName\":\"Api Token\",\"description\":\"\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true,\"unique\":true},\"description\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":false,\"default\":\"\"},\"type\":{\"type\":\"enumeration\",\"enum\":[\"read-only\",\"full-access\",\"custom\"],\"configurable\":false,\"required\":true,\"default\":\"read-only\"},\"accessKey\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"lastUsedAt\":{\"type\":\"datetime\",\"configurable\":false,\"required\":false},\"permissions\":{\"type\":\"relation\",\"target\":\"admin::api-token-permission\",\"relation\":\"oneToMany\",\"mappedBy\":\"token\",\"configurable\":false,\"required\":false},\"expiresAt\":{\"type\":\"datetime\",\"configurable\":false,\"required\":false},\"lifespan\":{\"type\":\"biginteger\",\"configurable\":false,\"required\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"api-token\",\"connection\":\"default\",\"uid\":\"admin::api-token\",\"plugin\":\"admin\",\"globalId\":\"AdminApiToken\"},\"admin::api-token-permission\":{\"collectionName\":\"strapi_api_token_permissions\",\"info\":{\"name\":\"API Token Permission\",\"description\":\"\",\"singularName\":\"api-token-permission\",\"pluralName\":\"api-token-permissions\",\"displayName\":\"API Token Permission\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"token\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToOne\",\"inversedBy\":\"permissions\",\"target\":\"admin::api-token\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"strapi_api_token_permissions\",\"info\":{\"name\":\"API Token Permission\",\"description\":\"\",\"singularName\":\"api-token-permission\",\"pluralName\":\"api-token-permissions\",\"displayName\":\"API Token Permission\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"minLength\":1,\"configurable\":false,\"required\":true},\"token\":{\"configurable\":false,\"type\":\"relation\",\"relation\":\"manyToOne\",\"inversedBy\":\"permissions\",\"target\":\"admin::api-token\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"api-token-permission\",\"connection\":\"default\",\"uid\":\"admin::api-token-permission\",\"plugin\":\"admin\",\"globalId\":\"AdminApiTokenPermission\"},\"plugin::upload.file\":{\"collectionName\":\"files\",\"info\":{\"singularName\":\"file\",\"pluralName\":\"files\",\"displayName\":\"File\",\"description\":\"\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"alternativeText\":{\"type\":\"string\",\"configurable\":false},\"caption\":{\"type\":\"string\",\"configurable\":false},\"width\":{\"type\":\"integer\",\"configurable\":false},\"height\":{\"type\":\"integer\",\"configurable\":false},\"formats\":{\"type\":\"json\",\"configurable\":false},\"hash\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"ext\":{\"type\":\"string\",\"configurable\":false},\"mime\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"size\":{\"type\":\"decimal\",\"configurable\":false,\"required\":true},\"url\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"previewUrl\":{\"type\":\"string\",\"configurable\":false},\"provider\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"provider_metadata\":{\"type\":\"json\",\"configurable\":false},\"related\":{\"type\":\"relation\",\"relation\":\"morphToMany\",\"configurable\":false},\"folder\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::upload.folder\",\"inversedBy\":\"files\",\"private\":true},\"folderPath\":{\"type\":\"string\",\"min\":1,\"required\":true,\"private\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"indexes\":[{\"name\":\"upload_files_folder_path_index\",\"columns\":[\"folder_path\"],\"type\":null},{\"name\":\"upload_files_created_at_index\",\"columns\":[\"created_at\"],\"type\":null},{\"name\":\"upload_files_updated_at_index\",\"columns\":[\"updated_at\"],\"type\":null},{\"name\":\"upload_files_name_index\",\"columns\":[\"name\"],\"type\":null},{\"name\":\"upload_files_size_index\",\"columns\":[\"size\"],\"type\":null},{\"name\":\"upload_files_ext_index\",\"columns\":[\"ext\"],\"type\":null}],\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"files\",\"info\":{\"singularName\":\"file\",\"pluralName\":\"files\",\"displayName\":\"File\",\"description\":\"\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"alternativeText\":{\"type\":\"string\",\"configurable\":false},\"caption\":{\"type\":\"string\",\"configurable\":false},\"width\":{\"type\":\"integer\",\"configurable\":false},\"height\":{\"type\":\"integer\",\"configurable\":false},\"formats\":{\"type\":\"json\",\"configurable\":false},\"hash\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"ext\":{\"type\":\"string\",\"configurable\":false},\"mime\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"size\":{\"type\":\"decimal\",\"configurable\":false,\"required\":true},\"url\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"previewUrl\":{\"type\":\"string\",\"configurable\":false},\"provider\":{\"type\":\"string\",\"configurable\":false,\"required\":true},\"provider_metadata\":{\"type\":\"json\",\"configurable\":false},\"related\":{\"type\":\"relation\",\"relation\":\"morphToMany\",\"configurable\":false},\"folder\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::upload.folder\",\"inversedBy\":\"files\",\"private\":true},\"folderPath\":{\"type\":\"string\",\"min\":1,\"required\":true,\"private\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"file\",\"connection\":\"default\",\"uid\":\"plugin::upload.file\",\"plugin\":\"upload\",\"globalId\":\"UploadFile\"},\"plugin::upload.folder\":{\"collectionName\":\"upload_folders\",\"info\":{\"singularName\":\"folder\",\"pluralName\":\"folders\",\"displayName\":\"Folder\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"min\":1,\"required\":true},\"pathId\":{\"type\":\"integer\",\"unique\":true,\"required\":true},\"parent\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::upload.folder\",\"inversedBy\":\"children\"},\"children\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::upload.folder\",\"mappedBy\":\"parent\"},\"files\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::upload.file\",\"mappedBy\":\"folder\"},\"path\":{\"type\":\"string\",\"min\":1,\"required\":true},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"indexes\":[{\"name\":\"upload_folders_path_id_index\",\"columns\":[\"path_id\"],\"type\":\"unique\"},{\"name\":\"upload_folders_path_index\",\"columns\":[\"path\"],\"type\":\"unique\"}],\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"upload_folders\",\"info\":{\"singularName\":\"folder\",\"pluralName\":\"folders\",\"displayName\":\"Folder\"},\"options\":{},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"min\":1,\"required\":true},\"pathId\":{\"type\":\"integer\",\"unique\":true,\"required\":true},\"parent\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::upload.folder\",\"inversedBy\":\"children\"},\"children\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::upload.folder\",\"mappedBy\":\"parent\"},\"files\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::upload.file\",\"mappedBy\":\"folder\"},\"path\":{\"type\":\"string\",\"min\":1,\"required\":true}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"folder\",\"connection\":\"default\",\"uid\":\"plugin::upload.folder\",\"plugin\":\"upload\",\"globalId\":\"UploadFolder\"},\"plugin::i18n.locale\":{\"info\":{\"singularName\":\"locale\",\"pluralName\":\"locales\",\"collectionName\":\"locales\",\"displayName\":\"Locale\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"min\":1,\"max\":50,\"configurable\":false},\"code\":{\"type\":\"string\",\"unique\":true,\"configurable\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"info\":{\"singularName\":\"locale\",\"pluralName\":\"locales\",\"collectionName\":\"locales\",\"displayName\":\"Locale\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"min\":1,\"max\":50,\"configurable\":false},\"code\":{\"type\":\"string\",\"unique\":true,\"configurable\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"locale\",\"connection\":\"default\",\"uid\":\"plugin::i18n.locale\",\"plugin\":\"i18n\",\"collectionName\":\"i18n_locale\",\"globalId\":\"I18NLocale\"},\"plugin::users-permissions.permission\":{\"collectionName\":\"up_permissions\",\"info\":{\"name\":\"permission\",\"description\":\"\",\"singularName\":\"permission\",\"pluralName\":\"permissions\",\"displayName\":\"Permission\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"role\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::users-permissions.role\",\"inversedBy\":\"permissions\",\"configurable\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"up_permissions\",\"info\":{\"name\":\"permission\",\"description\":\"\",\"singularName\":\"permission\",\"pluralName\":\"permissions\",\"displayName\":\"Permission\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"action\":{\"type\":\"string\",\"required\":true,\"configurable\":false},\"role\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::users-permissions.role\",\"inversedBy\":\"permissions\",\"configurable\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"permission\",\"connection\":\"default\",\"uid\":\"plugin::users-permissions.permission\",\"plugin\":\"users-permissions\",\"globalId\":\"UsersPermissionsPermission\"},\"plugin::users-permissions.role\":{\"collectionName\":\"up_roles\",\"info\":{\"name\":\"role\",\"description\":\"\",\"singularName\":\"role\",\"pluralName\":\"roles\",\"displayName\":\"Role\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":3,\"required\":true,\"configurable\":false},\"description\":{\"type\":\"string\",\"configurable\":false},\"type\":{\"type\":\"string\",\"unique\":true,\"configurable\":false},\"permissions\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::users-permissions.permission\",\"mappedBy\":\"role\",\"configurable\":false},\"users\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::users-permissions.user\",\"mappedBy\":\"role\",\"configurable\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"up_roles\",\"info\":{\"name\":\"role\",\"description\":\"\",\"singularName\":\"role\",\"pluralName\":\"roles\",\"displayName\":\"Role\"},\"pluginOptions\":{\"content-manager\":{\"visible\":false},\"content-type-builder\":{\"visible\":false}},\"attributes\":{\"name\":{\"type\":\"string\",\"minLength\":3,\"required\":true,\"configurable\":false},\"description\":{\"type\":\"string\",\"configurable\":false},\"type\":{\"type\":\"string\",\"unique\":true,\"configurable\":false},\"permissions\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::users-permissions.permission\",\"mappedBy\":\"role\",\"configurable\":false},\"users\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"plugin::users-permissions.user\",\"mappedBy\":\"role\",\"configurable\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"role\",\"connection\":\"default\",\"uid\":\"plugin::users-permissions.role\",\"plugin\":\"users-permissions\",\"globalId\":\"UsersPermissionsRole\"},\"plugin::users-permissions.user\":{\"collectionName\":\"up_users\",\"info\":{\"name\":\"user\",\"description\":\"\",\"singularName\":\"user\",\"pluralName\":\"users\",\"displayName\":\"User\"},\"options\":{\"draftAndPublish\":false,\"timestamps\":true},\"attributes\":{\"username\":{\"type\":\"string\",\"minLength\":3,\"unique\":true,\"configurable\":false,\"required\":true},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true},\"provider\":{\"type\":\"string\",\"configurable\":false},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"private\":true},\"resetPasswordToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"confirmationToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"confirmed\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"role\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::users-permissions.role\",\"inversedBy\":\"users\",\"configurable\":false},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"config\":{\"attributes\":{\"resetPasswordToken\":{\"hidden\":true},\"confirmationToken\":{\"hidden\":true},\"provider\":{\"hidden\":true}}},\"kind\":\"collectionType\",\"__schema__\":{\"collectionName\":\"up_users\",\"info\":{\"name\":\"user\",\"description\":\"\",\"singularName\":\"user\",\"pluralName\":\"users\",\"displayName\":\"User\"},\"options\":{\"draftAndPublish\":false,\"timestamps\":true},\"attributes\":{\"username\":{\"type\":\"string\",\"minLength\":3,\"unique\":true,\"configurable\":false,\"required\":true},\"email\":{\"type\":\"email\",\"minLength\":6,\"configurable\":false,\"required\":true},\"provider\":{\"type\":\"string\",\"configurable\":false},\"password\":{\"type\":\"password\",\"minLength\":6,\"configurable\":false,\"private\":true},\"resetPasswordToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"confirmationToken\":{\"type\":\"string\",\"configurable\":false,\"private\":true},\"confirmed\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"blocked\":{\"type\":\"boolean\",\"default\":false,\"configurable\":false},\"role\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"plugin::users-permissions.role\",\"inversedBy\":\"users\",\"configurable\":false}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"user\",\"connection\":\"default\",\"uid\":\"plugin::users-permissions.user\",\"plugin\":\"users-permissions\",\"globalId\":\"UsersPermissionsUser\"},\"api::cart.cart\":{\"kind\":\"collectionType\",\"collectionName\":\"carts\",\"info\":{\"singularName\":\"cart\",\"pluralName\":\"carts\",\"displayName\":\"Cart\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"fingerprint\":{\"type\":\"uid\"},\"wishlist\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\"},\"products\":{\"type\":\"json\"},\"order\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::order.order\",\"mappedBy\":\"cart\"},\"totalGross\":{\"type\":\"decimal\",\"default\":0},\"totalVat\":{\"type\":\"decimal\"},\"total\":{\"type\":\"decimal\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"carts\",\"info\":{\"singularName\":\"cart\",\"pluralName\":\"carts\",\"displayName\":\"Cart\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"fingerprint\":{\"type\":\"uid\"},\"wishlist\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\"},\"products\":{\"type\":\"json\"},\"order\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::order.order\",\"mappedBy\":\"cart\"},\"totalGross\":{\"type\":\"decimal\",\"default\":0},\"totalVat\":{\"type\":\"decimal\"},\"total\":{\"type\":\"decimal\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"cart\",\"connection\":\"default\",\"uid\":\"api::cart.cart\",\"apiName\":\"cart\",\"globalId\":\"Cart\",\"actions\":{},\"lifecycles\":{}},\"api::cover.cover\":{\"kind\":\"collectionType\",\"collectionName\":\"covers\",\"info\":{\"singularName\":\"cover\",\"pluralName\":\"covers\",\"displayName\":\"Cover\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\"},\"notebooks\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\",\"mappedBy\":\"cover\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"covers\",\"info\":{\"singularName\":\"cover\",\"pluralName\":\"covers\",\"displayName\":\"Cover\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\"},\"notebooks\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\",\"mappedBy\":\"cover\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"cover\",\"connection\":\"default\",\"uid\":\"api::cover.cover\",\"apiName\":\"cover\",\"globalId\":\"Cover\",\"actions\":{},\"lifecycles\":{}},\"api::delivery.delivery\":{\"kind\":\"collectionType\",\"collectionName\":\"deliveries\",\"info\":{\"singularName\":\"delivery\",\"pluralName\":\"deliveries\",\"displayName\":\"Delivery\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\"},\"cost\":{\"type\":\"decimal\"},\"minTotal\":{\"type\":\"decimal\",\"default\":0},\"freeDeliveryTotal\":{\"type\":\"decimal\"},\"multipliedCost\":{\"type\":\"decimal\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"deliveries\",\"info\":{\"singularName\":\"delivery\",\"pluralName\":\"deliveries\",\"displayName\":\"Delivery\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\"},\"cost\":{\"type\":\"decimal\"},\"minTotal\":{\"type\":\"decimal\",\"default\":0},\"freeDeliveryTotal\":{\"type\":\"decimal\"},\"multipliedCost\":{\"type\":\"decimal\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"delivery\",\"connection\":\"default\",\"uid\":\"api::delivery.delivery\",\"apiName\":\"delivery\",\"globalId\":\"Delivery\",\"actions\":{},\"lifecycles\":{}},\"api::event.event\":{\"kind\":\"collectionType\",\"collectionName\":\"events\",\"info\":{\"singularName\":\"event\",\"pluralName\":\"events\",\"displayName\":\"Event\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"label\":{\"type\":\"string\"},\"category\":{\"type\":\"string\"},\"action\":{\"type\":\"text\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"events\",\"info\":{\"singularName\":\"event\",\"pluralName\":\"events\",\"displayName\":\"Event\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"label\":{\"type\":\"string\"},\"category\":{\"type\":\"string\"},\"action\":{\"type\":\"text\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"event\",\"connection\":\"default\",\"uid\":\"api::event.event\",\"apiName\":\"event\",\"globalId\":\"Event\",\"actions\":{},\"lifecycles\":{}},\"api::imprint.imprint\":{\"kind\":\"singleType\",\"collectionName\":\"imprints\",\"info\":{\"singularName\":\"imprint\",\"pluralName\":\"imprints\",\"displayName\":\"Imprint\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"meta\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.seo\"},\"main\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.website\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"imprints\",\"info\":{\"singularName\":\"imprint\",\"pluralName\":\"imprints\",\"displayName\":\"Imprint\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"meta\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.seo\"},\"main\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.website\"}},\"kind\":\"singleType\"},\"modelType\":\"contentType\",\"modelName\":\"imprint\",\"connection\":\"default\",\"uid\":\"api::imprint.imprint\",\"apiName\":\"imprint\",\"globalId\":\"Imprint\",\"actions\":{},\"lifecycles\":{}},\"api::invoice.invoice\":{\"kind\":\"collectionType\",\"collectionName\":\"invoices\",\"info\":{\"singularName\":\"invoice\",\"pluralName\":\"invoices\",\"displayName\":\"Invoice\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"Rechnungsnummer\":{\"type\":\"uid\"},\"address\":{\"type\":\"richtext\"},\"Rechnungsdatum\":{\"type\":\"date\"},\"sent\":{\"type\":\"boolean\"},\"paid\":{\"type\":\"boolean\"},\"order\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::order.order\",\"inversedBy\":\"invoice\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"invoices\",\"info\":{\"singularName\":\"invoice\",\"pluralName\":\"invoices\",\"displayName\":\"Invoice\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"Rechnungsnummer\":{\"type\":\"uid\"},\"address\":{\"type\":\"richtext\"},\"Rechnungsdatum\":{\"type\":\"date\"},\"sent\":{\"type\":\"boolean\"},\"paid\":{\"type\":\"boolean\"},\"order\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::order.order\",\"inversedBy\":\"invoice\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"invoice\",\"connection\":\"default\",\"uid\":\"api::invoice.invoice\",\"apiName\":\"invoice\",\"globalId\":\"Invoice\",\"actions\":{},\"lifecycles\":{}},\"api::notebook.notebook\":{\"kind\":\"collectionType\",\"collectionName\":\"notebooks\",\"info\":{\"singularName\":\"notebook\",\"pluralName\":\"notebooks\",\"displayName\":\"Notebook\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\"},\"pattern\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"api::pattern.pattern\",\"inversedBy\":\"notebooks\"},\"weight\":{\"type\":\"integer\",\"default\":0},\"longTitle\":{\"type\":\"text\"},\"description\":{\"type\":\"richtext\"},\"meta\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.seo\"},\"cover\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"api::cover.cover\",\"inversedBy\":\"notebooks\"},\"bestSellers\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\"},\"images\":{\"type\":\"media\",\"multiple\":true,\"required\":false,\"allowedTypes\":[\"images\"]},\"price\":{\"type\":\"decimal\"},\"isShippable\":{\"type\":\"boolean\",\"default\":true},\"productCode\":{\"type\":\"string\",\"unique\":true},\"pages\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::notebook-page.notebook-page\"},\"paper\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::notebook-paper.notebook-paper\"},\"tax\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::tex.tex\"},\"deliverability\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"api::notebook-deliverability.notebook-deliverability\",\"inversedBy\":\"notebooks\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"notebooks\",\"info\":{\"singularName\":\"notebook\",\"pluralName\":\"notebooks\",\"displayName\":\"Notebook\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\"},\"pattern\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"api::pattern.pattern\",\"inversedBy\":\"notebooks\"},\"weight\":{\"type\":\"integer\",\"default\":0},\"longTitle\":{\"type\":\"text\"},\"description\":{\"type\":\"richtext\"},\"meta\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.seo\"},\"cover\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"api::cover.cover\",\"inversedBy\":\"notebooks\"},\"bestSellers\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\"},\"images\":{\"type\":\"media\",\"multiple\":true,\"required\":false,\"allowedTypes\":[\"images\"]},\"price\":{\"type\":\"decimal\"},\"isShippable\":{\"type\":\"boolean\",\"default\":true},\"productCode\":{\"type\":\"string\",\"unique\":true},\"pages\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::notebook-page.notebook-page\"},\"paper\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::notebook-paper.notebook-paper\"},\"tax\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::tex.tex\"},\"deliverability\":{\"type\":\"relation\",\"relation\":\"manyToOne\",\"target\":\"api::notebook-deliverability.notebook-deliverability\",\"inversedBy\":\"notebooks\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"notebook\",\"connection\":\"default\",\"uid\":\"api::notebook.notebook\",\"apiName\":\"notebook\",\"globalId\":\"Notebook\",\"actions\":{},\"lifecycles\":{}},\"api::notebook-deliverability.notebook-deliverability\":{\"kind\":\"collectionType\",\"collectionName\":\"notebook_deliverabilities\",\"info\":{\"singularName\":\"notebook-deliverability\",\"pluralName\":\"notebook-deliverabilities\",\"displayName\":\"NotebookDeliverability\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"label\":{\"type\":\"string\"},\"notebooks\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\",\"mappedBy\":\"deliverability\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"notebook_deliverabilities\",\"info\":{\"singularName\":\"notebook-deliverability\",\"pluralName\":\"notebook-deliverabilities\",\"displayName\":\"NotebookDeliverability\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"label\":{\"type\":\"string\"},\"notebooks\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\",\"mappedBy\":\"deliverability\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"notebook-deliverability\",\"connection\":\"default\",\"uid\":\"api::notebook-deliverability.notebook-deliverability\",\"apiName\":\"notebook-deliverability\",\"globalId\":\"NotebookDeliverability\",\"actions\":{},\"lifecycles\":{}},\"api::notebook-page.notebook-page\":{\"kind\":\"collectionType\",\"collectionName\":\"notebook_pages\",\"info\":{\"singularName\":\"notebook-page\",\"pluralName\":\"notebook-pages\",\"displayName\":\"NotebookPage\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"label\":{\"type\":\"string\"},\"cost\":{\"type\":\"decimal\",\"default\":0,\"min\":0},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"notebook_pages\",\"info\":{\"singularName\":\"notebook-page\",\"pluralName\":\"notebook-pages\",\"displayName\":\"NotebookPage\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"label\":{\"type\":\"string\"},\"cost\":{\"type\":\"decimal\",\"default\":0,\"min\":0}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"notebook-page\",\"connection\":\"default\",\"uid\":\"api::notebook-page.notebook-page\",\"apiName\":\"notebook-page\",\"globalId\":\"NotebookPage\",\"actions\":{},\"lifecycles\":{}},\"api::notebook-paper.notebook-paper\":{\"kind\":\"collectionType\",\"collectionName\":\"notebook_papers\",\"info\":{\"singularName\":\"notebook-paper\",\"pluralName\":\"notebook-papers\",\"displayName\":\"NotebookPaper\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"label\":{\"type\":\"string\"},\"cost\":{\"type\":\"decimal\",\"default\":0,\"min\":0},\"multipliedCost\":{\"type\":\"decimal\",\"default\":0},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"notebook_papers\",\"info\":{\"singularName\":\"notebook-paper\",\"pluralName\":\"notebook-papers\",\"displayName\":\"NotebookPaper\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"label\":{\"type\":\"string\"},\"cost\":{\"type\":\"decimal\",\"default\":0,\"min\":0},\"multipliedCost\":{\"type\":\"decimal\",\"default\":0}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"notebook-paper\",\"connection\":\"default\",\"uid\":\"api::notebook-paper.notebook-paper\",\"apiName\":\"notebook-paper\",\"globalId\":\"NotebookPaper\",\"actions\":{},\"lifecycles\":{}},\"api::order.order\":{\"kind\":\"collectionType\",\"collectionName\":\"orders\",\"info\":{\"singularName\":\"order\",\"pluralName\":\"orders\",\"displayName\":\"Order\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"Bestellnummer\":{\"type\":\"uid\"},\"payment\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::payment.payment\"},\"cart\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::cart.cart\",\"inversedBy\":\"order\"},\"delivery\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::delivery.delivery\"},\"address\":{\"type\":\"text\"},\"invoice\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::invoice.invoice\",\"mappedBy\":\"order\"},\"sent\":{\"type\":\"boolean\",\"default\":false},\"total\":{\"type\":\"decimal\",\"default\":0},\"tax\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::tex.tex\"},\"taxAmount\":{\"type\":\"decimal\",\"default\":0},\"totalNetto\":{\"type\":\"decimal\",\"default\":0},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"orders\",\"info\":{\"singularName\":\"order\",\"pluralName\":\"orders\",\"displayName\":\"Order\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"Bestellnummer\":{\"type\":\"uid\"},\"payment\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::payment.payment\"},\"cart\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::cart.cart\",\"inversedBy\":\"order\"},\"delivery\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::delivery.delivery\"},\"address\":{\"type\":\"text\"},\"invoice\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::invoice.invoice\",\"mappedBy\":\"order\"},\"sent\":{\"type\":\"boolean\",\"default\":false},\"total\":{\"type\":\"decimal\",\"default\":0},\"tax\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"api::tex.tex\"},\"taxAmount\":{\"type\":\"decimal\",\"default\":0},\"totalNetto\":{\"type\":\"decimal\",\"default\":0}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"order\",\"connection\":\"default\",\"uid\":\"api::order.order\",\"apiName\":\"order\",\"globalId\":\"Order\",\"actions\":{},\"lifecycles\":{}},\"api::pattern.pattern\":{\"kind\":\"collectionType\",\"collectionName\":\"patterns\",\"info\":{\"singularName\":\"pattern\",\"pluralName\":\"patterns\",\"displayName\":\"Pattern\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"category\":{\"type\":\"enumeration\",\"enum\":[\"Koerper\",\"Klassisch\",\"Floral\",\"Freestyle\",\"Geometrisch\",\"Linien\",\"Text\"]},\"image\":{\"type\":\"media\",\"multiple\":false,\"required\":false,\"allowedTypes\":[\"images\",\"files\",\"videos\",\"audios\"]},\"label\":{\"type\":\"string\"},\"notebooks\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\",\"mappedBy\":\"pattern\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"patterns\",\"info\":{\"singularName\":\"pattern\",\"pluralName\":\"patterns\",\"displayName\":\"Pattern\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"category\":{\"type\":\"enumeration\",\"enum\":[\"Koerper\",\"Klassisch\",\"Floral\",\"Freestyle\",\"Geometrisch\",\"Linien\",\"Text\"]},\"image\":{\"type\":\"media\",\"multiple\":false,\"required\":false,\"allowedTypes\":[\"images\",\"files\",\"videos\",\"audios\"]},\"label\":{\"type\":\"string\"},\"notebooks\":{\"type\":\"relation\",\"relation\":\"oneToMany\",\"target\":\"api::notebook.notebook\",\"mappedBy\":\"pattern\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"pattern\",\"connection\":\"default\",\"uid\":\"api::pattern.pattern\",\"apiName\":\"pattern\",\"globalId\":\"Pattern\",\"actions\":{},\"lifecycles\":{}},\"api::payment.payment\":{\"kind\":\"collectionType\",\"collectionName\":\"payments\",\"info\":{\"singularName\":\"payment\",\"pluralName\":\"payments\",\"displayName\":\"Payment\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\"},\"minTotal\":{\"type\":\"float\"},\"description\":{\"type\":\"richtext\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"publishedAt\":{\"type\":\"datetime\",\"configurable\":false,\"writable\":true,\"visible\":false},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"payments\",\"info\":{\"singularName\":\"payment\",\"pluralName\":\"payments\",\"displayName\":\"Payment\",\"description\":\"\"},\"options\":{\"draftAndPublish\":true},\"pluginOptions\":{},\"attributes\":{\"title\":{\"type\":\"string\"},\"minTotal\":{\"type\":\"float\"},\"description\":{\"type\":\"richtext\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"payment\",\"connection\":\"default\",\"uid\":\"api::payment.payment\",\"apiName\":\"payment\",\"globalId\":\"Payment\",\"actions\":{},\"lifecycles\":{}},\"api::privacy-policy.privacy-policy\":{\"kind\":\"singleType\",\"collectionName\":\"privacy_policies\",\"info\":{\"singularName\":\"privacy-policy\",\"pluralName\":\"privacy-policies\",\"displayName\":\"Privacy Policy\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"meta\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.seo\"},\"main\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.website\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"privacy_policies\",\"info\":{\"singularName\":\"privacy-policy\",\"pluralName\":\"privacy-policies\",\"displayName\":\"Privacy Policy\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"meta\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.seo\"},\"main\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.website\"}},\"kind\":\"singleType\"},\"modelType\":\"contentType\",\"modelName\":\"privacy-policy\",\"connection\":\"default\",\"uid\":\"api::privacy-policy.privacy-policy\",\"apiName\":\"privacy-policy\",\"globalId\":\"PrivacyPolicy\",\"actions\":{},\"lifecycles\":{}},\"api::terms-of-condition.terms-of-condition\":{\"kind\":\"singleType\",\"collectionName\":\"terms_of_conditions\",\"info\":{\"singularName\":\"terms-of-condition\",\"pluralName\":\"terms-of-conditions\",\"displayName\":\"Terms of Condition\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"meta\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.seo\"},\"main\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.website\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"terms_of_conditions\",\"info\":{\"singularName\":\"terms-of-condition\",\"pluralName\":\"terms-of-conditions\",\"displayName\":\"Terms of Condition\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"meta\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.seo\"},\"main\":{\"type\":\"component\",\"repeatable\":false,\"component\":\"page.website\"}},\"kind\":\"singleType\"},\"modelType\":\"contentType\",\"modelName\":\"terms-of-condition\",\"connection\":\"default\",\"uid\":\"api::terms-of-condition.terms-of-condition\",\"apiName\":\"terms-of-condition\",\"globalId\":\"TermsOfCondition\",\"actions\":{},\"lifecycles\":{}},\"api::tex.tex\":{\"kind\":\"collectionType\",\"collectionName\":\"texes\",\"info\":{\"singularName\":\"tex\",\"pluralName\":\"texes\",\"displayName\":\"Tax\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\"},\"amount\":{\"type\":\"decimal\"},\"label\":{\"type\":\"string\"},\"included\":{\"type\":\"boolean\"},\"createdAt\":{\"type\":\"datetime\"},\"updatedAt\":{\"type\":\"datetime\"},\"createdBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true},\"updatedBy\":{\"type\":\"relation\",\"relation\":\"oneToOne\",\"target\":\"admin::user\",\"configurable\":false,\"writable\":false,\"visible\":false,\"useJoinTable\":false,\"private\":true}},\"__schema__\":{\"collectionName\":\"texes\",\"info\":{\"singularName\":\"tex\",\"pluralName\":\"texes\",\"displayName\":\"Tax\",\"description\":\"\"},\"options\":{\"draftAndPublish\":false},\"pluginOptions\":{},\"attributes\":{\"name\":{\"type\":\"string\"},\"amount\":{\"type\":\"decimal\"},\"label\":{\"type\":\"string\"},\"included\":{\"type\":\"boolean\"}},\"kind\":\"collectionType\"},\"modelType\":\"contentType\",\"modelName\":\"tex\",\"connection\":\"default\",\"uid\":\"api::tex.tex\",\"apiName\":\"tex\",\"globalId\":\"Tex\",\"actions\":{},\"lifecycles\":{}}}','object',NULL,NULL),
(2,'plugin_content_manager_configuration_content_types::admin::permission','{\"uid\":\"admin::permission\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"action\",\"defaultSortBy\":\"action\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"action\":{\"edit\":{\"label\":\"action\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"action\",\"searchable\":true,\"sortable\":true}},\"subject\":{\"edit\":{\"label\":\"subject\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"subject\",\"searchable\":true,\"sortable\":true}},\"properties\":{\"edit\":{\"label\":\"properties\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"properties\",\"searchable\":false,\"sortable\":false}},\"conditions\":{\"edit\":{\"label\":\"conditions\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"conditions\",\"searchable\":false,\"sortable\":false}},\"role\":{\"edit\":{\"label\":\"role\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"role\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"action\",\"subject\",\"role\"],\"edit\":[[{\"name\":\"action\",\"size\":6},{\"name\":\"subject\",\"size\":6}],[{\"name\":\"properties\",\"size\":12}],[{\"name\":\"conditions\",\"size\":12}],[{\"name\":\"role\",\"size\":6}]]}}','object',NULL,NULL),
(3,'plugin_content_manager_configuration_content_types::admin::role','{\"uid\":\"admin::role\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"name\",\"searchable\":true,\"sortable\":true}},\"code\":{\"edit\":{\"label\":\"code\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"code\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"description\",\"searchable\":true,\"sortable\":true}},\"users\":{\"edit\":{\"label\":\"users\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"firstname\"},\"list\":{\"label\":\"users\",\"searchable\":false,\"sortable\":false}},\"permissions\":{\"edit\":{\"label\":\"permissions\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"action\"},\"list\":{\"label\":\"permissions\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"code\",\"description\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"code\",\"size\":6}],[{\"name\":\"description\",\"size\":6},{\"name\":\"users\",\"size\":6}],[{\"name\":\"permissions\",\"size\":6}]]}}','object',NULL,NULL),
(4,'plugin_content_manager_configuration_content_types::admin::api-token','{\"uid\":\"admin::api-token\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"name\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"description\",\"searchable\":true,\"sortable\":true}},\"type\":{\"edit\":{\"label\":\"type\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"type\",\"searchable\":true,\"sortable\":true}},\"accessKey\":{\"edit\":{\"label\":\"accessKey\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"accessKey\",\"searchable\":true,\"sortable\":true}},\"lastUsedAt\":{\"edit\":{\"label\":\"lastUsedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"lastUsedAt\",\"searchable\":true,\"sortable\":true}},\"permissions\":{\"edit\":{\"label\":\"permissions\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"action\"},\"list\":{\"label\":\"permissions\",\"searchable\":false,\"sortable\":false}},\"expiresAt\":{\"edit\":{\"label\":\"expiresAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"expiresAt\",\"searchable\":true,\"sortable\":true}},\"lifespan\":{\"edit\":{\"label\":\"lifespan\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"lifespan\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"description\",\"type\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"description\",\"size\":6}],[{\"name\":\"type\",\"size\":6},{\"name\":\"accessKey\",\"size\":6}],[{\"name\":\"lastUsedAt\",\"size\":6},{\"name\":\"permissions\",\"size\":6}],[{\"name\":\"expiresAt\",\"size\":6},{\"name\":\"lifespan\",\"size\":4}]]}}','object',NULL,NULL),
(5,'plugin_content_manager_configuration_content_types::admin::user','{\"uid\":\"admin::user\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"firstname\",\"defaultSortBy\":\"firstname\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"firstname\":{\"edit\":{\"label\":\"firstname\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"firstname\",\"searchable\":true,\"sortable\":true}},\"lastname\":{\"edit\":{\"label\":\"lastname\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"lastname\",\"searchable\":true,\"sortable\":true}},\"username\":{\"edit\":{\"label\":\"username\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"username\",\"searchable\":true,\"sortable\":true}},\"email\":{\"edit\":{\"label\":\"email\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"email\",\"searchable\":true,\"sortable\":true}},\"password\":{\"edit\":{\"label\":\"password\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"password\",\"searchable\":true,\"sortable\":true}},\"resetPasswordToken\":{\"edit\":{\"label\":\"resetPasswordToken\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"resetPasswordToken\",\"searchable\":true,\"sortable\":true}},\"registrationToken\":{\"edit\":{\"label\":\"registrationToken\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"registrationToken\",\"searchable\":true,\"sortable\":true}},\"isActive\":{\"edit\":{\"label\":\"isActive\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"isActive\",\"searchable\":true,\"sortable\":true}},\"roles\":{\"edit\":{\"label\":\"roles\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"roles\",\"searchable\":false,\"sortable\":false}},\"blocked\":{\"edit\":{\"label\":\"blocked\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"blocked\",\"searchable\":true,\"sortable\":true}},\"preferedLanguage\":{\"edit\":{\"label\":\"preferedLanguage\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"preferedLanguage\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"firstname\",\"lastname\",\"username\"],\"edit\":[[{\"name\":\"firstname\",\"size\":6},{\"name\":\"lastname\",\"size\":6}],[{\"name\":\"username\",\"size\":6},{\"name\":\"email\",\"size\":6}],[{\"name\":\"password\",\"size\":6},{\"name\":\"resetPasswordToken\",\"size\":6}],[{\"name\":\"registrationToken\",\"size\":6},{\"name\":\"isActive\",\"size\":4}],[{\"name\":\"roles\",\"size\":6},{\"name\":\"blocked\",\"size\":4}],[{\"name\":\"preferedLanguage\",\"size\":6}]]}}','object',NULL,NULL),
(6,'plugin_content_manager_configuration_content_types::plugin::upload.file','{\"uid\":\"plugin::upload.file\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"name\",\"searchable\":true,\"sortable\":true}},\"alternativeText\":{\"edit\":{\"label\":\"alternativeText\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"alternativeText\",\"searchable\":true,\"sortable\":true}},\"caption\":{\"edit\":{\"label\":\"caption\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"caption\",\"searchable\":true,\"sortable\":true}},\"width\":{\"edit\":{\"label\":\"width\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"width\",\"searchable\":true,\"sortable\":true}},\"height\":{\"edit\":{\"label\":\"height\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"height\",\"searchable\":true,\"sortable\":true}},\"formats\":{\"edit\":{\"label\":\"formats\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"formats\",\"searchable\":false,\"sortable\":false}},\"hash\":{\"edit\":{\"label\":\"hash\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"hash\",\"searchable\":true,\"sortable\":true}},\"ext\":{\"edit\":{\"label\":\"ext\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"ext\",\"searchable\":true,\"sortable\":true}},\"mime\":{\"edit\":{\"label\":\"mime\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"mime\",\"searchable\":true,\"sortable\":true}},\"size\":{\"edit\":{\"label\":\"size\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"size\",\"searchable\":true,\"sortable\":true}},\"url\":{\"edit\":{\"label\":\"url\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"url\",\"searchable\":true,\"sortable\":true}},\"previewUrl\":{\"edit\":{\"label\":\"previewUrl\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"previewUrl\",\"searchable\":true,\"sortable\":true}},\"provider\":{\"edit\":{\"label\":\"provider\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"provider\",\"searchable\":true,\"sortable\":true}},\"provider_metadata\":{\"edit\":{\"label\":\"provider_metadata\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"provider_metadata\",\"searchable\":false,\"sortable\":false}},\"folder\":{\"edit\":{\"label\":\"folder\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"folder\",\"searchable\":true,\"sortable\":true}},\"folderPath\":{\"edit\":{\"label\":\"folderPath\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"folderPath\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"alternativeText\",\"caption\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"alternativeText\",\"size\":6}],[{\"name\":\"caption\",\"size\":6},{\"name\":\"width\",\"size\":4}],[{\"name\":\"height\",\"size\":4}],[{\"name\":\"formats\",\"size\":12}],[{\"name\":\"hash\",\"size\":6},{\"name\":\"ext\",\"size\":6}],[{\"name\":\"mime\",\"size\":6},{\"name\":\"size\",\"size\":4}],[{\"name\":\"url\",\"size\":6},{\"name\":\"previewUrl\",\"size\":6}],[{\"name\":\"provider\",\"size\":6}],[{\"name\":\"provider_metadata\",\"size\":12}],[{\"name\":\"folder\",\"size\":6},{\"name\":\"folderPath\",\"size\":6}]]}}','object',NULL,NULL),
(7,'plugin_content_manager_configuration_content_types::plugin::upload.folder','{\"uid\":\"plugin::upload.folder\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"name\",\"searchable\":true,\"sortable\":true}},\"pathId\":{\"edit\":{\"label\":\"pathId\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"pathId\",\"searchable\":true,\"sortable\":true}},\"parent\":{\"edit\":{\"label\":\"parent\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"parent\",\"searchable\":true,\"sortable\":true}},\"children\":{\"edit\":{\"label\":\"children\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"children\",\"searchable\":false,\"sortable\":false}},\"files\":{\"edit\":{\"label\":\"files\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"files\",\"searchable\":false,\"sortable\":false}},\"path\":{\"edit\":{\"label\":\"path\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"path\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"pathId\",\"parent\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"pathId\",\"size\":4}],[{\"name\":\"parent\",\"size\":6},{\"name\":\"children\",\"size\":6}],[{\"name\":\"files\",\"size\":6},{\"name\":\"path\",\"size\":6}]]}}','object',NULL,NULL),
(8,'plugin_content_manager_configuration_content_types::plugin::i18n.locale','{\"uid\":\"plugin::i18n.locale\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"name\",\"searchable\":true,\"sortable\":true}},\"code\":{\"edit\":{\"label\":\"code\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"code\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"code\",\"createdAt\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"code\",\"size\":6}]]}}','object',NULL,NULL),
(9,'plugin_content_manager_configuration_content_types::plugin::users-permissions.permission','{\"uid\":\"plugin::users-permissions.permission\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"action\",\"defaultSortBy\":\"action\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"action\":{\"edit\":{\"label\":\"action\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"action\",\"searchable\":true,\"sortable\":true}},\"role\":{\"edit\":{\"label\":\"role\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"role\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"action\",\"role\",\"createdAt\"],\"edit\":[[{\"name\":\"action\",\"size\":6},{\"name\":\"role\",\"size\":6}]]}}','object',NULL,NULL),
(10,'plugin_content_manager_configuration_content_types::plugin::users-permissions.role','{\"uid\":\"plugin::users-permissions.role\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"name\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"name\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"description\",\"searchable\":true,\"sortable\":true}},\"type\":{\"edit\":{\"label\":\"type\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"type\",\"searchable\":true,\"sortable\":true}},\"permissions\":{\"edit\":{\"label\":\"permissions\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"action\"},\"list\":{\"label\":\"permissions\",\"searchable\":false,\"sortable\":false}},\"users\":{\"edit\":{\"label\":\"users\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"username\"},\"list\":{\"label\":\"users\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"name\",\"description\",\"type\"],\"edit\":[[{\"name\":\"name\",\"size\":6},{\"name\":\"description\",\"size\":6}],[{\"name\":\"type\",\"size\":6},{\"name\":\"permissions\",\"size\":6}],[{\"name\":\"users\",\"size\":6}]]}}','object',NULL,NULL),
(11,'plugin_content_manager_configuration_content_types::plugin::users-permissions.user','{\"uid\":\"plugin::users-permissions.user\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"username\",\"defaultSortBy\":\"username\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"username\":{\"edit\":{\"label\":\"username\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"username\",\"searchable\":true,\"sortable\":true}},\"email\":{\"edit\":{\"label\":\"email\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"email\",\"searchable\":true,\"sortable\":true}},\"provider\":{\"edit\":{\"label\":\"provider\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"provider\",\"searchable\":true,\"sortable\":true}},\"password\":{\"edit\":{\"label\":\"password\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"password\",\"searchable\":true,\"sortable\":true}},\"resetPasswordToken\":{\"edit\":{\"label\":\"resetPasswordToken\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"resetPasswordToken\",\"searchable\":true,\"sortable\":true}},\"confirmationToken\":{\"edit\":{\"label\":\"confirmationToken\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"confirmationToken\",\"searchable\":true,\"sortable\":true}},\"confirmed\":{\"edit\":{\"label\":\"confirmed\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"confirmed\",\"searchable\":true,\"sortable\":true}},\"blocked\":{\"edit\":{\"label\":\"blocked\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"blocked\",\"searchable\":true,\"sortable\":true}},\"role\":{\"edit\":{\"label\":\"role\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"role\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"username\",\"email\",\"confirmed\"],\"edit\":[[{\"name\":\"username\",\"size\":6},{\"name\":\"email\",\"size\":6}],[{\"name\":\"password\",\"size\":6},{\"name\":\"confirmed\",\"size\":4}],[{\"name\":\"blocked\",\"size\":4},{\"name\":\"role\",\"size\":6}]]}}','object',NULL,NULL),
(12,'plugin_content_manager_configuration_content_types::admin::api-token-permission','{\"uid\":\"admin::api-token-permission\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"action\",\"defaultSortBy\":\"action\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"action\":{\"edit\":{\"label\":\"action\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"action\",\"searchable\":true,\"sortable\":true}},\"token\":{\"edit\":{\"label\":\"token\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"name\"},\"list\":{\"label\":\"token\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"action\",\"token\",\"createdAt\"],\"edit\":[[{\"name\":\"action\",\"size\":6},{\"name\":\"token\",\"size\":6}]]}}','object',NULL,NULL),
(13,'plugin_upload_settings','{\"sizeOptimization\":true,\"responsiveDimensions\":true,\"autoOrientation\":false}','object',NULL,NULL),
(14,'plugin_upload_view_configuration','{\"pageSize\":10,\"sort\":\"createdAt:DESC\"}','object',NULL,NULL),
(15,'plugin_upload_metrics','{\"weeklySchedule\":\"24 39 17 * * 1\",\"lastWeeklyUpdate\":1678124364066}','object',NULL,NULL),
(16,'plugin_i18n_default_locale','\"de\"','string',NULL,NULL),
(17,'plugin_users-permissions_grant','{\"email\":{\"enabled\":true,\"icon\":\"envelope\"},\"discord\":{\"enabled\":false,\"icon\":\"discord\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/discord/callback\",\"scope\":[\"identify\",\"email\"]},\"facebook\":{\"enabled\":false,\"icon\":\"facebook-square\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/facebook/callback\",\"scope\":[\"email\"]},\"google\":{\"enabled\":false,\"icon\":\"google\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/google/callback\",\"scope\":[\"email\"]},\"github\":{\"enabled\":false,\"icon\":\"github\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/github/callback\",\"scope\":[\"user\",\"user:email\"]},\"microsoft\":{\"enabled\":false,\"icon\":\"windows\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/microsoft/callback\",\"scope\":[\"user.read\"]},\"twitter\":{\"enabled\":false,\"icon\":\"twitter\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/twitter/callback\"},\"instagram\":{\"enabled\":false,\"icon\":\"instagram\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/instagram/callback\",\"scope\":[\"user_profile\"]},\"vk\":{\"enabled\":false,\"icon\":\"vk\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/vk/callback\",\"scope\":[\"email\"]},\"twitch\":{\"enabled\":false,\"icon\":\"twitch\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/twitch/callback\",\"scope\":[\"user:read:email\"]},\"linkedin\":{\"enabled\":false,\"icon\":\"linkedin\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/linkedin/callback\",\"scope\":[\"r_liteprofile\",\"r_emailaddress\"]},\"cognito\":{\"enabled\":false,\"icon\":\"aws\",\"key\":\"\",\"secret\":\"\",\"subdomain\":\"my.subdomain.com\",\"callback\":\"api/auth/cognito/callback\",\"scope\":[\"email\",\"openid\",\"profile\"]},\"reddit\":{\"enabled\":false,\"icon\":\"reddit\",\"key\":\"\",\"secret\":\"\",\"state\":true,\"callback\":\"api/auth/reddit/callback\",\"scope\":[\"identity\"]},\"auth0\":{\"enabled\":false,\"icon\":\"\",\"key\":\"\",\"secret\":\"\",\"subdomain\":\"my-tenant.eu\",\"callback\":\"api/auth/auth0/callback\",\"scope\":[\"openid\",\"email\",\"profile\"]},\"cas\":{\"enabled\":false,\"icon\":\"book\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/cas/callback\",\"scope\":[\"openid email\"],\"subdomain\":\"my.subdomain.com/cas\"},\"patreon\":{\"enabled\":false,\"icon\":\"\",\"key\":\"\",\"secret\":\"\",\"callback\":\"api/auth/patreon/callback\",\"scope\":[\"identity\",\"identity[email]\"]}}','object',NULL,NULL),
(18,'plugin_users-permissions_email','{\"reset_password\":{\"display\":\"Email.template.reset_password\",\"icon\":\"sync\",\"options\":{\"from\":{\"name\":\"Administration Panel\",\"email\":\"no-reply@strapi.io\"},\"response_email\":\"\",\"object\":\"Reset password\",\"message\":\"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>\"}},\"email_confirmation\":{\"display\":\"Email.template.email_confirmation\",\"icon\":\"check-square\",\"options\":{\"from\":{\"name\":\"Administration Panel\",\"email\":\"no-reply@strapi.io\"},\"response_email\":\"\",\"object\":\"Account confirmation\",\"message\":\"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>\"}}}','object',NULL,NULL),
(19,'plugin_users-permissions_advanced','{\"unique_email\":true,\"allow_register\":false,\"email_confirmation\":false,\"email_reset_password\":null,\"email_confirmation_redirection\":\"\",\"default_role\":\"authenticated\"}','object',NULL,NULL),
(20,'core_admin_auth','{\"providers\":{\"autoRegister\":false,\"defaultRole\":null}}','object',NULL,NULL),
(21,'plugin_content_manager_configuration_content_types::api::notebook.notebook','{\"uid\":\"api::notebook.notebook\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":100,\"mainField\":\"title\",\"defaultSortBy\":\"productCode\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"title\":{\"edit\":{\"label\":\"Produktbezeichnung\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"title\",\"searchable\":true,\"sortable\":true}},\"pattern\":{\"edit\":{\"label\":\"Muster\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"label\"},\"list\":{\"label\":\"pattern\",\"searchable\":true,\"sortable\":true}},\"weight\":{\"edit\":{\"label\":\"Gewicht (g)\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"weight\",\"searchable\":true,\"sortable\":true}},\"longTitle\":{\"edit\":{\"label\":\"Kurzbeschreibung\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"longTitle\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"description\",\"searchable\":false,\"sortable\":false}},\"meta\":{\"edit\":{\"label\":\"meta\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"meta\",\"searchable\":false,\"sortable\":false}},\"cover\":{\"edit\":{\"label\":\"Cover\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"cover\",\"searchable\":true,\"sortable\":true}},\"bestSellers\":{\"edit\":{\"label\":\"Produktempfehlungen\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"bestSellers\",\"searchable\":false,\"sortable\":false}},\"images\":{\"edit\":{\"label\":\"images\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"images\",\"searchable\":false,\"sortable\":false}},\"price\":{\"edit\":{\"label\":\"Grundpreis\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"price\",\"searchable\":true,\"sortable\":true}},\"isShippable\":{\"edit\":{\"label\":\"Lieferbar\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"isShippable\",\"searchable\":true,\"sortable\":true}},\"productCode\":{\"edit\":{\"label\":\"Produktcode\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"productCode\",\"searchable\":true,\"sortable\":true}},\"pages\":{\"edit\":{\"label\":\"Seiten\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"label\"},\"list\":{\"label\":\"pages\",\"searchable\":true,\"sortable\":true}},\"paper\":{\"edit\":{\"label\":\"Papier\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"label\"},\"list\":{\"label\":\"paper\",\"searchable\":true,\"sortable\":true}},\"tax\":{\"edit\":{\"label\":\"Steuern\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"label\"},\"list\":{\"label\":\"tax\",\"searchable\":true,\"sortable\":true}},\"deliverability\":{\"edit\":{\"label\":\"Lieferbarkeit\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"label\"},\"list\":{\"label\":\"deliverability\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"productCode\",\"size\":4},{\"name\":\"title\",\"size\":8}],[{\"name\":\"deliverability\",\"size\":4},{\"name\":\"tax\",\"size\":4},{\"name\":\"price\",\"size\":4}],[{\"name\":\"cover\",\"size\":6},{\"name\":\"pattern\",\"size\":6}],[{\"name\":\"paper\",\"size\":6},{\"name\":\"pages\",\"size\":6}],[{\"name\":\"longTitle\",\"size\":12}],[{\"name\":\"bestSellers\",\"size\":12}],[{\"name\":\"description\",\"size\":12}],[{\"name\":\"images\",\"size\":12}],[{\"name\":\"meta\",\"size\":12}]],\"list\":[\"productCode\",\"images\",\"price\",\"cover\",\"pattern\",\"paper\",\"pages\"]}}','object',NULL,NULL),
(22,'plugin_content_manager_configuration_content_types::api::pattern.pattern','{\"uid\":\"api::pattern.pattern\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"label\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"category\":{\"edit\":{\"label\":\"category\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"category\",\"searchable\":true,\"sortable\":true}},\"image\":{\"edit\":{\"label\":\"image\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"image\",\"searchable\":false,\"sortable\":false}},\"label\":{\"edit\":{\"label\":\"label\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"label\",\"searchable\":true,\"sortable\":true}},\"notebooks\":{\"edit\":{\"label\":\"notebooks\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"notebooks\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"category\",\"image\",\"label\",\"notebooks\"],\"edit\":[[{\"name\":\"label\",\"size\":6},{\"name\":\"category\",\"size\":6}],[{\"name\":\"image\",\"size\":6},{\"name\":\"notebooks\",\"size\":6}]]}}','object',NULL,NULL),
(23,'plugin_content_manager_configuration_content_types::api::terms-of-condition.terms-of-condition','{\"uid\":\"api::terms-of-condition.terms-of-condition\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"id\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"meta\":{\"edit\":{\"label\":\"meta\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"meta\",\"searchable\":false,\"sortable\":false}},\"main\":{\"edit\":{\"label\":\"main\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"main\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"main\",\"size\":12}],[{\"name\":\"meta\",\"size\":12}]],\"list\":[\"id\",\"createdAt\",\"meta\",\"main\"]}}','object',NULL,NULL),
(24,'plugin_content_manager_configuration_content_types::api::privacy-policy.privacy-policy','{\"uid\":\"api::privacy-policy.privacy-policy\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"id\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"meta\":{\"edit\":{\"label\":\"meta\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"meta\",\"searchable\":false,\"sortable\":false}},\"main\":{\"edit\":{\"label\":\"main\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"main\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"main\",\"size\":12}],[{\"name\":\"meta\",\"size\":12}]],\"list\":[\"id\",\"createdAt\",\"meta\",\"main\"]}}','object',NULL,NULL),
(26,'plugin_content_manager_configuration_content_types::api::imprint.imprint','{\"uid\":\"api::imprint.imprint\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"id\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"main\":{\"edit\":{\"label\":\"main\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"main\",\"searchable\":false,\"sortable\":false}},\"meta\":{\"edit\":{\"label\":\"meta\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"meta\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"main\",\"createdAt\",\"updatedAt\"],\"edit\":[[{\"name\":\"main\",\"size\":12}],[{\"name\":\"meta\",\"size\":12}]]}}','object',NULL,NULL),
(28,'plugin_content_manager_configuration_components::page.website','{\"uid\":\"page.website\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"title\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":false,\"sortable\":false}},\"title\":{\"edit\":{\"label\":\"title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"title\",\"searchable\":true,\"sortable\":true}},\"text\":{\"edit\":{\"label\":\"text\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"text\",\"searchable\":false,\"sortable\":false}},\"lastUpdated\":{\"edit\":{\"label\":\"lastUpdated\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"lastUpdated\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"title\",\"lastUpdated\"],\"edit\":[[{\"name\":\"title\",\"size\":6},{\"name\":\"lastUpdated\",\"size\":4}],[{\"name\":\"text\",\"size\":12}]]},\"isComponent\":true}','object',NULL,NULL),
(29,'plugin_content_manager_configuration_components::page.seo','{\"uid\":\"page.seo\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"id\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":false,\"sortable\":false}},\"description\":{\"edit\":{\"label\":\"description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"description\",\"searchable\":true,\"sortable\":true}},\"keywords\":{\"edit\":{\"label\":\"keywords\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"keywords\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"id\",\"description\",\"keywords\"],\"edit\":[[{\"name\":\"description\",\"size\":6},{\"name\":\"keywords\",\"size\":6}]]},\"isComponent\":true}','object',NULL,NULL),
(30,'plugin_content_manager_configuration_content_types::api::invoice.invoice','{\"uid\":\"api::invoice.invoice\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":100,\"mainField\":\"Rechnungsnummer\",\"defaultSortBy\":\"Rechnungsdatum\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"Rechnungsnummer\":{\"edit\":{\"label\":\"Rechnungsnummer\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Rechnungsnummer\",\"searchable\":true,\"sortable\":true}},\"address\":{\"edit\":{\"label\":\"address\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"address\",\"searchable\":false,\"sortable\":false}},\"Rechnungsdatum\":{\"edit\":{\"label\":\"Rechnungsdatum\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Rechnungsdatum\",\"searchable\":true,\"sortable\":true}},\"sent\":{\"edit\":{\"label\":\"sent\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"sent\",\"searchable\":true,\"sortable\":true}},\"paid\":{\"edit\":{\"label\":\"paid\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"paid\",\"searchable\":true,\"sortable\":true}},\"order\":{\"edit\":{\"label\":\"Bestellung\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"Bestellnummer\"},\"list\":{\"label\":\"order\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"Rechnungsnummer\",\"size\":6}],[{\"name\":\"address\",\"size\":12}],[{\"name\":\"Rechnungsdatum\",\"size\":4},{\"name\":\"paid\",\"size\":4},{\"name\":\"order\",\"size\":4}]],\"list\":[\"Rechnungsnummer\",\"Rechnungsdatum\",\"order\",\"paid\",\"updatedAt\"]}}','object',NULL,NULL),
(31,'plugin_content_manager_configuration_content_types::api::order.order','{\"uid\":\"api::order.order\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":100,\"mainField\":\"Bestellnummer\",\"defaultSortBy\":\"createdAt\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"Bestellnummer\":{\"edit\":{\"label\":\"Bestellnummer\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"Bestellnummer\",\"searchable\":true,\"sortable\":true}},\"payment\":{\"edit\":{\"label\":\"Zahlungsart\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"payment\",\"searchable\":true,\"sortable\":true}},\"cart\":{\"edit\":{\"label\":\"Warenkorb\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"fingerprint\"},\"list\":{\"label\":\"cart\",\"searchable\":true,\"sortable\":true}},\"delivery\":{\"edit\":{\"label\":\"Versandart\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"delivery\",\"searchable\":true,\"sortable\":true}},\"address\":{\"edit\":{\"label\":\"Adresse\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"address\",\"searchable\":false,\"sortable\":false}},\"invoice\":{\"edit\":{\"label\":\"Rechnung\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"Rechnungsnummer\"},\"list\":{\"label\":\"invoice\",\"searchable\":true,\"sortable\":true}},\"sent\":{\"edit\":{\"label\":\"sent\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"sent\",\"searchable\":true,\"sortable\":true}},\"total\":{\"edit\":{\"label\":\"Gesamt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"total\",\"searchable\":true,\"sortable\":true}},\"tax\":{\"edit\":{\"label\":\"Steuern\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"label\"},\"list\":{\"label\":\"tax\",\"searchable\":true,\"sortable\":true}},\"taxAmount\":{\"edit\":{\"label\":\"Steuern insg.\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"taxAmount\",\"searchable\":true,\"sortable\":true}},\"totalNetto\":{\"edit\":{\"label\":\"Gesamt (netto)\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"totalNetto\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"Bestellnummer\",\"size\":4},{\"name\":\"sent\",\"size\":4},{\"name\":\"invoice\",\"size\":4}],[{\"name\":\"address\",\"size\":8},{\"name\":\"delivery\",\"size\":4}],[{\"name\":\"cart\",\"size\":8},{\"name\":\"payment\",\"size\":4}],[{\"name\":\"total\",\"size\":4},{\"name\":\"taxAmount\",\"size\":4},{\"name\":\"tax\",\"size\":4}],[{\"name\":\"totalNetto\",\"size\":4}]],\"list\":[\"Bestellnummer\",\"totalNetto\",\"payment\",\"delivery\",\"address\",\"cart\"]}}','object',NULL,NULL),
(32,'plugin_content_manager_configuration_content_types::api::payment.payment','{\"uid\":\"api::payment.payment\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"title\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"title\":{\"edit\":{\"label\":\"title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"title\",\"searchable\":true,\"sortable\":true}},\"minTotal\":{\"edit\":{\"label\":\"minTotal\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"minTotal\",\"searchable\":true,\"sortable\":true}},\"description\":{\"edit\":{\"label\":\"description\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"description\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"title\",\"size\":6},{\"name\":\"minTotal\",\"size\":4}],[{\"name\":\"description\",\"size\":12}]],\"list\":[\"title\",\"minTotal\",\"updatedAt\"]}}','object',NULL,NULL),
(33,'plugin_content_manager_configuration_content_types::api::cart.cart','{\"uid\":\"api::cart.cart\",\"settings\":{\"bulkable\":false,\"filterable\":true,\"searchable\":true,\"pageSize\":100,\"mainField\":\"fingerprint\",\"defaultSortBy\":\"updatedAt\",\"defaultSortOrder\":\"DESC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"fingerprint\":{\"edit\":{\"label\":\"fingerprint\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"fingerprint\",\"searchable\":true,\"sortable\":true}},\"wishlist\":{\"edit\":{\"label\":\"Wunschliste\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"wishlist\",\"searchable\":false,\"sortable\":false}},\"products\":{\"edit\":{\"label\":\"Warenkorb\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"products\",\"searchable\":false,\"sortable\":false}},\"order\":{\"edit\":{\"label\":\"Bestellung\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"Bestellnummer\"},\"list\":{\"label\":\"order\",\"searchable\":true,\"sortable\":true}},\"totalGross\":{\"edit\":{\"label\":\"totalGross\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"totalGross\",\"searchable\":true,\"sortable\":true}},\"totalVat\":{\"edit\":{\"label\":\"totalVat\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"totalVat\",\"searchable\":true,\"sortable\":true}},\"total\":{\"edit\":{\"label\":\"total\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"total\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"order\",\"fingerprint\",\"wishlist\",\"updatedAt\"],\"edit\":[[{\"name\":\"order\",\"size\":4},{\"name\":\"fingerprint\",\"size\":4}],[{\"name\":\"products\",\"size\":12}],[{\"name\":\"wishlist\",\"size\":12}],[{\"name\":\"totalGross\",\"size\":4},{\"name\":\"totalVat\",\"size\":4},{\"name\":\"total\",\"size\":4}]]}}','object',NULL,NULL),
(34,'plugin_content_manager_configuration_content_types::api::event.event','{\"uid\":\"api::event.event\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"category\",\"defaultSortBy\":\"category\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"label\":{\"edit\":{\"label\":\"label\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"label\",\"searchable\":true,\"sortable\":true}},\"category\":{\"edit\":{\"label\":\"category\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"category\",\"searchable\":true,\"sortable\":true}},\"action\":{\"edit\":{\"label\":\"action\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"action\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"category\",\"size\":6},{\"name\":\"label\",\"size\":6}],[{\"name\":\"action\",\"size\":6}]],\"list\":[\"category\",\"label\",\"action\",\"createdAt\"]}}','object',NULL,NULL),
(35,'plugin_content_manager_configuration_content_types::api::delivery.delivery','{\"uid\":\"api::delivery.delivery\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"title\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"title\":{\"edit\":{\"label\":\"title\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"title\",\"searchable\":true,\"sortable\":true}},\"cost\":{\"edit\":{\"label\":\"cost\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"cost\",\"searchable\":true,\"sortable\":true}},\"minTotal\":{\"edit\":{\"label\":\"minTotal\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"minTotal\",\"searchable\":true,\"sortable\":true}},\"freeDeliveryTotal\":{\"edit\":{\"label\":\"freeDeliveryTotal\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"freeDeliveryTotal\",\"searchable\":true,\"sortable\":true}},\"multipliedCost\":{\"edit\":{\"label\":\"multipliedCost\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"multipliedCost\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"title\",\"cost\",\"minTotal\",\"multipliedCost\"],\"edit\":[[{\"name\":\"title\",\"size\":6},{\"name\":\"cost\",\"size\":4}],[{\"name\":\"minTotal\",\"size\":4},{\"name\":\"freeDeliveryTotal\",\"size\":4},{\"name\":\"multipliedCost\",\"size\":4}]]}}','object',NULL,NULL),
(36,'core_admin_project-settings','{\"menuLogo\":{},\"authLogo\":{}}','object',NULL,NULL),
(37,'plugin_content_manager_configuration_content_types::api::cover.cover','{\"uid\":\"api::cover.cover\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"title\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"title\":{\"edit\":{\"label\":\"Bezeichnung\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"title\",\"searchable\":true,\"sortable\":true}},\"notebooks\":{\"edit\":{\"label\":\"Produkte\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"notebooks\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"title\",\"size\":6},{\"name\":\"notebooks\",\"size\":6}]],\"list\":[\"title\",\"notebooks\"]}}','object',NULL,NULL),
(38,'plugin_content_manager_configuration_content_types::api::tex.tex','{\"uid\":\"api::tex.tex\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"name\",\"defaultSortBy\":\"id\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"name\":{\"edit\":{\"label\":\"name\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"name\",\"searchable\":true,\"sortable\":true}},\"amount\":{\"edit\":{\"label\":\"amount\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"amount\",\"searchable\":true,\"sortable\":true}},\"label\":{\"edit\":{\"label\":\"label\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"label\",\"searchable\":true,\"sortable\":true}},\"included\":{\"edit\":{\"label\":\"included\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"included\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"name\",\"label\",\"amount\",\"included\"],\"edit\":[[{\"name\":\"name\",\"size\":4},{\"name\":\"label\",\"size\":4},{\"name\":\"amount\",\"size\":4}],[{\"name\":\"included\",\"size\":4}]]}}','object',NULL,NULL),
(39,'plugin_content_manager_configuration_content_types::api::notebook-page.notebook-page','{\"uid\":\"api::notebook-page.notebook-page\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"label\",\"defaultSortBy\":\"label\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"label\":{\"edit\":{\"label\":\"label\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"label\",\"searchable\":true,\"sortable\":true}},\"cost\":{\"edit\":{\"label\":\"cost\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"cost\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"label\",\"size\":6},{\"name\":\"cost\",\"size\":4}]],\"list\":[\"label\",\"cost\"]}}','object',NULL,NULL),
(40,'plugin_content_manager_configuration_content_types::api::notebook-paper.notebook-paper','{\"uid\":\"api::notebook-paper.notebook-paper\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"label\",\"defaultSortBy\":\"label\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"label\":{\"edit\":{\"label\":\"label\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"label\",\"searchable\":true,\"sortable\":true}},\"cost\":{\"edit\":{\"label\":\"Zusätzliche Kosten\",\"description\":\"\",\"placeholder\":\"0\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"cost\",\"searchable\":true,\"sortable\":true}},\"multipliedCost\":{\"edit\":{\"label\":\"Zusätzliche Kosten (multipliziert)\",\"description\":\"\",\"placeholder\":\"0\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"multipliedCost\",\"searchable\":true,\"sortable\":true}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"edit\":[[{\"name\":\"label\",\"size\":4},{\"name\":\"cost\",\"size\":4},{\"name\":\"multipliedCost\",\"size\":4}]],\"list\":[\"label\",\"cost\",\"multipliedCost\"]}}','object',NULL,NULL),
(41,'plugin_content_manager_configuration_content_types::api::notebook-deliverability.notebook-deliverability','{\"uid\":\"api::notebook-deliverability.notebook-deliverability\",\"settings\":{\"bulkable\":true,\"filterable\":true,\"searchable\":true,\"pageSize\":10,\"mainField\":\"label\",\"defaultSortBy\":\"label\",\"defaultSortOrder\":\"ASC\"},\"metadatas\":{\"id\":{\"edit\":{},\"list\":{\"label\":\"id\",\"searchable\":true,\"sortable\":true}},\"label\":{\"edit\":{\"label\":\"label\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true},\"list\":{\"label\":\"label\",\"searchable\":true,\"sortable\":true}},\"notebooks\":{\"edit\":{\"label\":\"notebooks\",\"description\":\"\",\"placeholder\":\"\",\"visible\":true,\"editable\":true,\"mainField\":\"title\"},\"list\":{\"label\":\"notebooks\",\"searchable\":false,\"sortable\":false}},\"createdAt\":{\"edit\":{\"label\":\"createdAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"createdAt\",\"searchable\":true,\"sortable\":true}},\"updatedAt\":{\"edit\":{\"label\":\"updatedAt\",\"description\":\"\",\"placeholder\":\"\",\"visible\":false,\"editable\":true},\"list\":{\"label\":\"updatedAt\",\"searchable\":true,\"sortable\":true}}},\"layouts\":{\"list\":[\"label\",\"notebooks\"],\"edit\":[[{\"name\":\"label\",\"size\":6},{\"name\":\"notebooks\",\"size\":6}]]}}','object',NULL,NULL);
/*!40000 ALTER TABLE `strapi_core_store_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strapi_database_schema`
--

DROP TABLE IF EXISTS `strapi_database_schema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strapi_database_schema` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `schema` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`schema`)),
  `time` datetime DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strapi_database_schema`
--

LOCK TABLES `strapi_database_schema` WRITE;
/*!40000 ALTER TABLE `strapi_database_schema` DISABLE KEYS */;
INSERT INTO `strapi_database_schema` VALUES
(79,'{\"tables\":[{\"name\":\"strapi_core_store_settings\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"key\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"value\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"environment\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"tag\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"strapi_webhooks\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"url\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"headers\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"events\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"enabled\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"strapi_ee_store_settings\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"key\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"value\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"admin_permissions\",\"indexes\":[{\"name\":\"admin_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"admin_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"admin_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"admin_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"action\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"subject\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"properties\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"conditions\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"admin_users\",\"indexes\":[{\"name\":\"admin_users_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"admin_users_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"admin_users_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"admin_users_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"firstname\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"lastname\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"username\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"email\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"password\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"reset_password_token\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"registration_token\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"is_active\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"blocked\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"prefered_language\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"admin_roles\",\"indexes\":[{\"name\":\"admin_roles_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"admin_roles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"admin_roles_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"admin_roles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"code\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"strapi_api_tokens\",\"indexes\":[{\"name\":\"strapi_api_tokens_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"strapi_api_tokens_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"strapi_api_tokens_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"strapi_api_tokens_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"access_key\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"last_used_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"expires_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"lifespan\",\"type\":\"bigInteger\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"strapi_api_token_permissions\",\"indexes\":[{\"name\":\"strapi_api_token_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"strapi_api_token_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"strapi_api_token_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"strapi_api_token_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"action\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"files\",\"indexes\":[{\"name\":\"upload_files_folder_path_index\",\"columns\":[\"folder_path\"],\"type\":null},{\"name\":\"upload_files_created_at_index\",\"columns\":[\"created_at\"],\"type\":null},{\"name\":\"upload_files_updated_at_index\",\"columns\":[\"updated_at\"],\"type\":null},{\"name\":\"upload_files_name_index\",\"columns\":[\"name\"],\"type\":null},{\"name\":\"upload_files_size_index\",\"columns\":[\"size\"],\"type\":null},{\"name\":\"upload_files_ext_index\",\"columns\":[\"ext\"],\"type\":null},{\"name\":\"files_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"files_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"files_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"files_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"alternative_text\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"caption\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"width\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"height\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"formats\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"hash\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"ext\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"mime\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"size\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"url\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"preview_url\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"provider\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"provider_metadata\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"folder_path\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"upload_folders\",\"indexes\":[{\"name\":\"upload_folders_path_id_index\",\"columns\":[\"path_id\"],\"type\":\"unique\"},{\"name\":\"upload_folders_path_index\",\"columns\":[\"path\"],\"type\":\"unique\"},{\"name\":\"upload_folders_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"upload_folders_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"upload_folders_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"upload_folders_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"path_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"path\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"i18n_locale\",\"indexes\":[{\"name\":\"i18n_locale_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"i18n_locale_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"i18n_locale_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"i18n_locale_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"code\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_permissions\",\"indexes\":[{\"name\":\"up_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"up_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"up_permissions_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"up_permissions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"action\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_roles\",\"indexes\":[{\"name\":\"up_roles_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"up_roles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"up_roles_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"up_roles_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_users\",\"indexes\":[{\"name\":\"up_users_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"up_users_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"up_users_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"up_users_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"username\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"email\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"provider\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"password\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"reset_password_token\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"confirmation_token\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"confirmed\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"blocked\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"carts\",\"indexes\":[{\"type\":\"unique\",\"name\":\"carts_fingerprint_unique\",\"columns\":[\"fingerprint\"]},{\"name\":\"carts_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"carts_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"carts_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"carts_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"fingerprint\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false,\"unique\":true},{\"name\":\"products\",\"type\":\"jsonb\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"total_gross\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"total_vat\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"total\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"covers\",\"indexes\":[{\"name\":\"covers_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"covers_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"covers_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"covers_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"deliveries\",\"indexes\":[{\"name\":\"deliveries_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"deliveries_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"deliveries_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"deliveries_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"cost\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"min_total\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"free_delivery_total\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"multiplied_cost\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"events\",\"indexes\":[{\"name\":\"events_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"events_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"events_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"events_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"label\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"category\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"action\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"imprints\",\"indexes\":[{\"name\":\"imprints_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"imprints_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"imprints_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"imprints_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"invoices\",\"indexes\":[{\"type\":\"unique\",\"name\":\"invoices_rechnungsnummer_unique\",\"columns\":[\"rechnungsnummer\"]},{\"name\":\"invoices_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"invoices_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"invoices_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"invoices_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"rechnungsnummer\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false,\"unique\":true},{\"name\":\"address\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"rechnungsdatum\",\"type\":\"date\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"sent\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"paid\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebooks\",\"indexes\":[{\"name\":\"notebooks_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"notebooks_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"notebooks_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"notebooks_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"weight\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"long_title\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"price\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"is_shippable\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"product_code\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebook_deliverabilities\",\"indexes\":[{\"name\":\"notebook_deliverabilities_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"notebook_deliverabilities_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"notebook_deliverabilities_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"notebook_deliverabilities_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"label\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebook_pages\",\"indexes\":[{\"name\":\"notebook_pages_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"notebook_pages_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"notebook_pages_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"notebook_pages_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"label\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"cost\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebook_papers\",\"indexes\":[{\"name\":\"notebook_papers_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"notebook_papers_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"notebook_papers_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"notebook_papers_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"label\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"cost\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"multiplied_cost\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"orders\",\"indexes\":[{\"type\":\"unique\",\"name\":\"orders_bestellnummer_unique\",\"columns\":[\"bestellnummer\"]},{\"name\":\"orders_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"orders_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"orders_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"orders_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"bestellnummer\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false,\"unique\":true},{\"name\":\"address\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"sent\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"total\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"tax_amount\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"total_netto\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"patterns\",\"indexes\":[{\"name\":\"patterns_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"patterns_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"patterns_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"patterns_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"category\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"label\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"payments\",\"indexes\":[{\"name\":\"payments_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"payments_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"payments_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"payments_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"min_total\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"description\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"published_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"privacy_policies\",\"indexes\":[{\"name\":\"privacy_policies_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"privacy_policies_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"privacy_policies_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"privacy_policies_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"terms_of_conditions\",\"indexes\":[{\"name\":\"terms_of_conditions_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"terms_of_conditions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"terms_of_conditions_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"terms_of_conditions_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"texes\",\"indexes\":[{\"name\":\"texes_created_by_id_fk\",\"columns\":[\"created_by_id\"]},{\"name\":\"texes_updated_by_id_fk\",\"columns\":[\"updated_by_id\"]}],\"foreignKeys\":[{\"name\":\"texes_created_by_id_fk\",\"columns\":[\"created_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"},{\"name\":\"texes_updated_by_id_fk\",\"columns\":[\"updated_by_id\"],\"referencedTable\":\"admin_users\",\"referencedColumns\":[\"id\"],\"onDelete\":\"SET NULL\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"name\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"amount\",\"type\":\"decimal\",\"args\":[10,2],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"label\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"included\",\"type\":\"boolean\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"updated_at\",\"type\":\"datetime\",\"args\":[{\"useTz\":false,\"precision\":6}],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"created_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"updated_by_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"components_content_seos\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"description\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"keywords\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"components_content_websites\",\"indexes\":[],\"foreignKeys\":[],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"title\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"text\",\"type\":\"text\",\"args\":[\"longtext\"],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"last_updated\",\"type\":\"date\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false}]},{\"name\":\"admin_permissions_role_links\",\"indexes\":[{\"name\":\"admin_permissions_role_links_fk\",\"columns\":[\"permission_id\"]},{\"name\":\"admin_permissions_role_links_inv_fk\",\"columns\":[\"role_id\"]},{\"name\":\"admin_permissions_role_links_unique\",\"columns\":[\"permission_id\",\"role_id\"],\"type\":\"unique\"},{\"name\":\"admin_permissions_role_links_order_inv_fk\",\"columns\":[\"permission_order\"]}],\"foreignKeys\":[{\"name\":\"admin_permissions_role_links_fk\",\"columns\":[\"permission_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"admin_permissions\",\"onDelete\":\"CASCADE\"},{\"name\":\"admin_permissions_role_links_inv_fk\",\"columns\":[\"role_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"admin_roles\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"permission_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"role_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"permission_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"admin_users_roles_links\",\"indexes\":[{\"name\":\"admin_users_roles_links_fk\",\"columns\":[\"user_id\"]},{\"name\":\"admin_users_roles_links_inv_fk\",\"columns\":[\"role_id\"]},{\"name\":\"admin_users_roles_links_unique\",\"columns\":[\"user_id\",\"role_id\"],\"type\":\"unique\"},{\"name\":\"admin_users_roles_links_order_fk\",\"columns\":[\"role_order\"]},{\"name\":\"admin_users_roles_links_order_inv_fk\",\"columns\":[\"user_order\"]}],\"foreignKeys\":[{\"name\":\"admin_users_roles_links_fk\",\"columns\":[\"user_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"admin_users\",\"onDelete\":\"CASCADE\"},{\"name\":\"admin_users_roles_links_inv_fk\",\"columns\":[\"role_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"admin_roles\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"user_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"role_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"role_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"user_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"strapi_api_token_permissions_token_links\",\"indexes\":[{\"name\":\"strapi_api_token_permissions_token_links_fk\",\"columns\":[\"api_token_permission_id\"]},{\"name\":\"strapi_api_token_permissions_token_links_inv_fk\",\"columns\":[\"api_token_id\"]},{\"name\":\"strapi_api_token_permissions_token_links_unique\",\"columns\":[\"api_token_permission_id\",\"api_token_id\"],\"type\":\"unique\"},{\"name\":\"strapi_api_token_permissions_token_links_order_inv_fk\",\"columns\":[\"api_token_permission_order\"]}],\"foreignKeys\":[{\"name\":\"strapi_api_token_permissions_token_links_fk\",\"columns\":[\"api_token_permission_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"strapi_api_token_permissions\",\"onDelete\":\"CASCADE\"},{\"name\":\"strapi_api_token_permissions_token_links_inv_fk\",\"columns\":[\"api_token_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"strapi_api_tokens\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"api_token_permission_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"api_token_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"api_token_permission_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"files_related_morphs\",\"indexes\":[{\"name\":\"files_related_morphs_fk\",\"columns\":[\"file_id\"]}],\"foreignKeys\":[{\"name\":\"files_related_morphs_fk\",\"columns\":[\"file_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"files\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"file_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"related_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"related_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"files_folder_links\",\"indexes\":[{\"name\":\"files_folder_links_fk\",\"columns\":[\"file_id\"]},{\"name\":\"files_folder_links_inv_fk\",\"columns\":[\"folder_id\"]},{\"name\":\"files_folder_links_unique\",\"columns\":[\"file_id\",\"folder_id\"],\"type\":\"unique\"},{\"name\":\"files_folder_links_order_inv_fk\",\"columns\":[\"file_order\"]}],\"foreignKeys\":[{\"name\":\"files_folder_links_fk\",\"columns\":[\"file_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"files\",\"onDelete\":\"CASCADE\"},{\"name\":\"files_folder_links_inv_fk\",\"columns\":[\"folder_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"upload_folders\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"file_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"folder_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"file_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"upload_folders_parent_links\",\"indexes\":[{\"name\":\"upload_folders_parent_links_fk\",\"columns\":[\"folder_id\"]},{\"name\":\"upload_folders_parent_links_inv_fk\",\"columns\":[\"inv_folder_id\"]},{\"name\":\"upload_folders_parent_links_unique\",\"columns\":[\"folder_id\",\"inv_folder_id\"],\"type\":\"unique\"},{\"name\":\"upload_folders_parent_links_order_inv_fk\",\"columns\":[\"folder_order\"]}],\"foreignKeys\":[{\"name\":\"upload_folders_parent_links_fk\",\"columns\":[\"folder_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"upload_folders\",\"onDelete\":\"CASCADE\"},{\"name\":\"upload_folders_parent_links_inv_fk\",\"columns\":[\"inv_folder_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"upload_folders\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"folder_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"inv_folder_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"folder_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_permissions_role_links\",\"indexes\":[{\"name\":\"up_permissions_role_links_fk\",\"columns\":[\"permission_id\"]},{\"name\":\"up_permissions_role_links_inv_fk\",\"columns\":[\"role_id\"]},{\"name\":\"up_permissions_role_links_unique\",\"columns\":[\"permission_id\",\"role_id\"],\"type\":\"unique\"},{\"name\":\"up_permissions_role_links_order_inv_fk\",\"columns\":[\"permission_order\"]}],\"foreignKeys\":[{\"name\":\"up_permissions_role_links_fk\",\"columns\":[\"permission_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"up_permissions\",\"onDelete\":\"CASCADE\"},{\"name\":\"up_permissions_role_links_inv_fk\",\"columns\":[\"role_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"up_roles\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"permission_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"role_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"permission_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"up_users_role_links\",\"indexes\":[{\"name\":\"up_users_role_links_fk\",\"columns\":[\"user_id\"]},{\"name\":\"up_users_role_links_inv_fk\",\"columns\":[\"role_id\"]},{\"name\":\"up_users_role_links_unique\",\"columns\":[\"user_id\",\"role_id\"],\"type\":\"unique\"},{\"name\":\"up_users_role_links_order_inv_fk\",\"columns\":[\"user_order\"]}],\"foreignKeys\":[{\"name\":\"up_users_role_links_fk\",\"columns\":[\"user_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"up_users\",\"onDelete\":\"CASCADE\"},{\"name\":\"up_users_role_links_inv_fk\",\"columns\":[\"role_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"up_roles\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"user_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"role_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"user_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"carts_wishlist_links\",\"indexes\":[{\"name\":\"carts_wishlist_links_fk\",\"columns\":[\"cart_id\"]},{\"name\":\"carts_wishlist_links_inv_fk\",\"columns\":[\"notebook_id\"]},{\"name\":\"carts_wishlist_links_unique\",\"columns\":[\"cart_id\",\"notebook_id\"],\"type\":\"unique\"},{\"name\":\"carts_wishlist_links_order_fk\",\"columns\":[\"notebook_order\"]}],\"foreignKeys\":[{\"name\":\"carts_wishlist_links_fk\",\"columns\":[\"cart_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"carts\",\"onDelete\":\"CASCADE\"},{\"name\":\"carts_wishlist_links_inv_fk\",\"columns\":[\"notebook_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"cart_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"notebook_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"notebook_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"imprints_components\",\"indexes\":[{\"name\":\"imprints_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"imprints_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"imprints_entity_fk\",\"columns\":[\"entity_id\"]},{\"name\":\"imprints_unique\",\"columns\":[\"entity_id\",\"component_id\",\"field\",\"component_type\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"imprints_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"imprints\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"invoices_order_links\",\"indexes\":[{\"name\":\"invoices_order_links_fk\",\"columns\":[\"invoice_id\"]},{\"name\":\"invoices_order_links_inv_fk\",\"columns\":[\"order_id\"]},{\"name\":\"invoices_order_links_unique\",\"columns\":[\"invoice_id\",\"order_id\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"invoices_order_links_fk\",\"columns\":[\"invoice_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"invoices\",\"onDelete\":\"CASCADE\"},{\"name\":\"invoices_order_links_inv_fk\",\"columns\":[\"order_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"orders\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"invoice_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"order_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebooks_components\",\"indexes\":[{\"name\":\"notebooks_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"notebooks_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"notebooks_entity_fk\",\"columns\":[\"entity_id\"]},{\"name\":\"notebooks_unique\",\"columns\":[\"entity_id\",\"component_id\",\"field\",\"component_type\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"notebooks_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebooks_pattern_links\",\"indexes\":[{\"name\":\"notebooks_pattern_links_fk\",\"columns\":[\"notebook_id\"]},{\"name\":\"notebooks_pattern_links_inv_fk\",\"columns\":[\"pattern_id\"]},{\"name\":\"notebooks_pattern_links_unique\",\"columns\":[\"notebook_id\",\"pattern_id\"],\"type\":\"unique\"},{\"name\":\"notebooks_pattern_links_order_inv_fk\",\"columns\":[\"notebook_order\"]}],\"foreignKeys\":[{\"name\":\"notebooks_pattern_links_fk\",\"columns\":[\"notebook_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"},{\"name\":\"notebooks_pattern_links_inv_fk\",\"columns\":[\"pattern_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"patterns\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"notebook_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"pattern_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"notebook_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebooks_cover_links\",\"indexes\":[{\"name\":\"notebooks_cover_links_fk\",\"columns\":[\"notebook_id\"]},{\"name\":\"notebooks_cover_links_inv_fk\",\"columns\":[\"cover_id\"]},{\"name\":\"notebooks_cover_links_unique\",\"columns\":[\"notebook_id\",\"cover_id\"],\"type\":\"unique\"},{\"name\":\"notebooks_cover_links_order_inv_fk\",\"columns\":[\"notebook_order\"]}],\"foreignKeys\":[{\"name\":\"notebooks_cover_links_fk\",\"columns\":[\"notebook_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"},{\"name\":\"notebooks_cover_links_inv_fk\",\"columns\":[\"cover_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"covers\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"notebook_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"cover_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"notebook_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebooks_best_sellers_links\",\"indexes\":[{\"name\":\"notebooks_best_sellers_links_fk\",\"columns\":[\"notebook_id\"]},{\"name\":\"notebooks_best_sellers_links_inv_fk\",\"columns\":[\"inv_notebook_id\"]},{\"name\":\"notebooks_best_sellers_links_unique\",\"columns\":[\"notebook_id\",\"inv_notebook_id\"],\"type\":\"unique\"},{\"name\":\"notebooks_best_sellers_links_order_fk\",\"columns\":[\"notebook_order\"]}],\"foreignKeys\":[{\"name\":\"notebooks_best_sellers_links_fk\",\"columns\":[\"notebook_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"},{\"name\":\"notebooks_best_sellers_links_inv_fk\",\"columns\":[\"inv_notebook_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"notebook_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"inv_notebook_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"notebook_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebooks_pages_links\",\"indexes\":[{\"name\":\"notebooks_pages_links_fk\",\"columns\":[\"notebook_id\"]},{\"name\":\"notebooks_pages_links_inv_fk\",\"columns\":[\"notebook_page_id\"]},{\"name\":\"notebooks_pages_links_unique\",\"columns\":[\"notebook_id\",\"notebook_page_id\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"notebooks_pages_links_fk\",\"columns\":[\"notebook_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"},{\"name\":\"notebooks_pages_links_inv_fk\",\"columns\":[\"notebook_page_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebook_pages\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"notebook_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"notebook_page_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebooks_paper_links\",\"indexes\":[{\"name\":\"notebooks_paper_links_fk\",\"columns\":[\"notebook_id\"]},{\"name\":\"notebooks_paper_links_inv_fk\",\"columns\":[\"notebook_paper_id\"]},{\"name\":\"notebooks_paper_links_unique\",\"columns\":[\"notebook_id\",\"notebook_paper_id\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"notebooks_paper_links_fk\",\"columns\":[\"notebook_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"},{\"name\":\"notebooks_paper_links_inv_fk\",\"columns\":[\"notebook_paper_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebook_papers\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"notebook_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"notebook_paper_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebooks_tax_links\",\"indexes\":[{\"name\":\"notebooks_tax_links_fk\",\"columns\":[\"notebook_id\"]},{\"name\":\"notebooks_tax_links_inv_fk\",\"columns\":[\"tex_id\"]},{\"name\":\"notebooks_tax_links_unique\",\"columns\":[\"notebook_id\",\"tex_id\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"notebooks_tax_links_fk\",\"columns\":[\"notebook_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"},{\"name\":\"notebooks_tax_links_inv_fk\",\"columns\":[\"tex_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"texes\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"notebook_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"tex_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"notebooks_deliverability_links\",\"indexes\":[{\"name\":\"notebooks_deliverability_links_fk\",\"columns\":[\"notebook_id\"]},{\"name\":\"notebooks_deliverability_links_inv_fk\",\"columns\":[\"notebook_deliverability_id\"]},{\"name\":\"notebooks_deliverability_links_unique\",\"columns\":[\"notebook_id\",\"notebook_deliverability_id\"],\"type\":\"unique\"},{\"name\":\"notebooks_deliverability_links_order_inv_fk\",\"columns\":[\"notebook_order\"]}],\"foreignKeys\":[{\"name\":\"notebooks_deliverability_links_fk\",\"columns\":[\"notebook_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebooks\",\"onDelete\":\"CASCADE\"},{\"name\":\"notebooks_deliverability_links_inv_fk\",\"columns\":[\"notebook_deliverability_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"notebook_deliverabilities\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"notebook_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"notebook_deliverability_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"notebook_order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"orders_payment_links\",\"indexes\":[{\"name\":\"orders_payment_links_fk\",\"columns\":[\"order_id\"]},{\"name\":\"orders_payment_links_inv_fk\",\"columns\":[\"payment_id\"]},{\"name\":\"orders_payment_links_unique\",\"columns\":[\"order_id\",\"payment_id\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"orders_payment_links_fk\",\"columns\":[\"order_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"orders\",\"onDelete\":\"CASCADE\"},{\"name\":\"orders_payment_links_inv_fk\",\"columns\":[\"payment_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"payments\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"order_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"payment_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"orders_cart_links\",\"indexes\":[{\"name\":\"orders_cart_links_fk\",\"columns\":[\"order_id\"]},{\"name\":\"orders_cart_links_inv_fk\",\"columns\":[\"cart_id\"]},{\"name\":\"orders_cart_links_unique\",\"columns\":[\"order_id\",\"cart_id\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"orders_cart_links_fk\",\"columns\":[\"order_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"orders\",\"onDelete\":\"CASCADE\"},{\"name\":\"orders_cart_links_inv_fk\",\"columns\":[\"cart_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"carts\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"order_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"cart_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"orders_delivery_links\",\"indexes\":[{\"name\":\"orders_delivery_links_fk\",\"columns\":[\"order_id\"]},{\"name\":\"orders_delivery_links_inv_fk\",\"columns\":[\"delivery_id\"]},{\"name\":\"orders_delivery_links_unique\",\"columns\":[\"order_id\",\"delivery_id\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"orders_delivery_links_fk\",\"columns\":[\"order_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"orders\",\"onDelete\":\"CASCADE\"},{\"name\":\"orders_delivery_links_inv_fk\",\"columns\":[\"delivery_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"deliveries\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"order_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"delivery_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"orders_tax_links\",\"indexes\":[{\"name\":\"orders_tax_links_fk\",\"columns\":[\"order_id\"]},{\"name\":\"orders_tax_links_inv_fk\",\"columns\":[\"tex_id\"]},{\"name\":\"orders_tax_links_unique\",\"columns\":[\"order_id\",\"tex_id\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"orders_tax_links_fk\",\"columns\":[\"order_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"orders\",\"onDelete\":\"CASCADE\"},{\"name\":\"orders_tax_links_inv_fk\",\"columns\":[\"tex_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"texes\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"order_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"tex_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"privacy_policies_components\",\"indexes\":[{\"name\":\"privacy_policies_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"privacy_policies_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"privacy_policies_entity_fk\",\"columns\":[\"entity_id\"]},{\"name\":\"privacy_policies_unique\",\"columns\":[\"entity_id\",\"component_id\",\"field\",\"component_type\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"privacy_policies_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"privacy_policies\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]},{\"name\":\"terms_of_conditions_components\",\"indexes\":[{\"name\":\"terms_of_conditions_field_index\",\"columns\":[\"field\"],\"type\":null},{\"name\":\"terms_of_conditions_component_type_index\",\"columns\":[\"component_type\"],\"type\":null},{\"name\":\"terms_of_conditions_entity_fk\",\"columns\":[\"entity_id\"]},{\"name\":\"terms_of_conditions_unique\",\"columns\":[\"entity_id\",\"component_id\",\"field\",\"component_type\"],\"type\":\"unique\"}],\"foreignKeys\":[{\"name\":\"terms_of_conditions_entity_fk\",\"columns\":[\"entity_id\"],\"referencedColumns\":[\"id\"],\"referencedTable\":\"terms_of_conditions\",\"onDelete\":\"CASCADE\"}],\"columns\":[{\"name\":\"id\",\"type\":\"increments\",\"args\":[{\"primary\":true,\"primaryKey\":true}],\"defaultTo\":null,\"notNullable\":true,\"unsigned\":false},{\"name\":\"entity_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_id\",\"type\":\"integer\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true},{\"name\":\"component_type\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"field\",\"type\":\"string\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":false},{\"name\":\"order\",\"type\":\"double\",\"args\":[],\"defaultTo\":null,\"notNullable\":false,\"unsigned\":true}]}]}','2023-03-03 21:41:34','dfa56bfc763b17e526a10308b60adbc5');
/*!40000 ALTER TABLE `strapi_database_schema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strapi_ee_store_settings`
--

DROP TABLE IF EXISTS `strapi_ee_store_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strapi_ee_store_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT NULL,
  `value` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strapi_ee_store_settings`
--

LOCK TABLES `strapi_ee_store_settings` WRITE;
/*!40000 ALTER TABLE `strapi_ee_store_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `strapi_ee_store_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strapi_migrations`
--

DROP TABLE IF EXISTS `strapi_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strapi_migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strapi_migrations`
--

LOCK TABLES `strapi_migrations` WRITE;
/*!40000 ALTER TABLE `strapi_migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `strapi_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strapi_webhooks`
--

DROP TABLE IF EXISTS `strapi_webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `strapi_webhooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` longtext DEFAULT NULL,
  `headers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`headers`)),
  `events` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`events`)),
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strapi_webhooks`
--

LOCK TABLES `strapi_webhooks` WRITE;
/*!40000 ALTER TABLE `strapi_webhooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `strapi_webhooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terms_of_conditions`
--

DROP TABLE IF EXISTS `terms_of_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terms_of_conditions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `terms_of_conditions_created_by_id_fk` (`created_by_id`),
  KEY `terms_of_conditions_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `terms_of_conditions_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `terms_of_conditions_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terms_of_conditions`
--

LOCK TABLES `terms_of_conditions` WRITE;
/*!40000 ALTER TABLE `terms_of_conditions` DISABLE KEYS */;
INSERT INTO `terms_of_conditions` VALUES
(1,'2023-02-23 16:44:48.297000','2023-02-23 16:44:48.297000',1,1);
/*!40000 ALTER TABLE `terms_of_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terms_of_conditions_components`
--

DROP TABLE IF EXISTS `terms_of_conditions_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terms_of_conditions_components` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `component_id` int(10) unsigned DEFAULT NULL,
  `component_type` varchar(255) DEFAULT NULL,
  `field` varchar(255) DEFAULT NULL,
  `order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `terms_of_conditions_unique` (`entity_id`,`component_id`,`field`,`component_type`),
  KEY `terms_of_conditions_field_index` (`field`),
  KEY `terms_of_conditions_component_type_index` (`component_type`),
  KEY `terms_of_conditions_entity_fk` (`entity_id`),
  CONSTRAINT `terms_of_conditions_entity_fk` FOREIGN KEY (`entity_id`) REFERENCES `terms_of_conditions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terms_of_conditions_components`
--

LOCK TABLES `terms_of_conditions_components` WRITE;
/*!40000 ALTER TABLE `terms_of_conditions_components` DISABLE KEYS */;
INSERT INTO `terms_of_conditions_components` VALUES
(1,1,1,'page.website','main',NULL);
/*!40000 ALTER TABLE `terms_of_conditions_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `texes`
--

DROP TABLE IF EXISTS `texes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `texes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `included` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `texes_created_by_id_fk` (`created_by_id`),
  KEY `texes_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `texes_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `texes_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `texes`
--

LOCK TABLES `texes` WRITE;
/*!40000 ALTER TABLE `texes` DISABLE KEYS */;
INSERT INTO `texes` VALUES
(1,'2023-02-23 17:48:13.089000','2023-02-23 19:16:13.940000',1,1,'Inklusive Mehrwertsteuer',0.00,'inkl. MwSt. (19%)',NULL),
(2,'2023-02-23 17:49:07.749000','2023-02-23 17:49:25.057000',1,1,'Steuerfrei',0.00,'steuerfrei',NULL),
(3,'2023-02-23 17:51:05.436000','2023-02-23 19:16:35.219000',1,1,'Zuzüglich Mehrwertsteuer',0.19,'zzgl. MwSt (19%)',NULL),
(4,'2023-02-23 19:17:08.056000','2023-02-23 19:17:08.056000',1,1,'Exklusive Steuern',0.00,'exkl. Steuern',NULL);
/*!40000 ALTER TABLE `texes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `up_permissions`
--

DROP TABLE IF EXISTS `up_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `up_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `up_permissions_created_by_id_fk` (`created_by_id`),
  KEY `up_permissions_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `up_permissions_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `up_permissions_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `up_permissions`
--

LOCK TABLES `up_permissions` WRITE;
/*!40000 ALTER TABLE `up_permissions` DISABLE KEYS */;
INSERT INTO `up_permissions` VALUES
(1,'plugin::users-permissions.user.me','2023-02-20 17:34:24.479000','2023-02-20 17:34:24.479000',NULL,NULL),
(2,'plugin::users-permissions.auth.changePassword','2023-02-20 17:34:24.479000','2023-02-20 17:34:24.479000',NULL,NULL),
(3,'plugin::users-permissions.auth.callback','2023-02-20 17:34:24.493000','2023-02-20 17:34:24.493000',NULL,NULL),
(4,'plugin::users-permissions.auth.connect','2023-02-20 17:34:24.493000','2023-02-20 17:34:24.493000',NULL,NULL),
(5,'plugin::users-permissions.auth.resetPassword','2023-02-20 17:34:24.494000','2023-02-20 17:34:24.494000',NULL,NULL),
(6,'plugin::users-permissions.auth.forgotPassword','2023-02-20 17:34:24.494000','2023-02-20 17:34:24.494000',NULL,NULL),
(7,'plugin::users-permissions.auth.emailConfirmation','2023-02-20 17:34:24.494000','2023-02-20 17:34:24.494000',NULL,NULL),
(8,'plugin::users-permissions.auth.register','2023-02-20 17:34:24.494000','2023-02-20 17:34:24.494000',NULL,NULL),
(9,'plugin::users-permissions.auth.sendEmailConfirmation','2023-02-20 17:34:24.494000','2023-02-20 17:34:24.494000',NULL,NULL),
(10,'api::cart.cart.findOne','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(11,'api::cart.cart.create','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(12,'api::cart.cart.update','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(13,'api::cover.cover.find','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(14,'api::cover.cover.findOne','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(15,'api::delivery.delivery.find','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(16,'api::delivery.delivery.findOne','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(17,'api::event.event.create','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(18,'api::imprint.imprint.find','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(19,'api::invoice.invoice.findOne','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(20,'api::notebook.notebook.find','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(21,'api::notebook.notebook.findOne','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(22,'api::order.order.findOne','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(23,'api::order.order.create','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(24,'api::order.order.update','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(25,'api::pattern.pattern.find','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(26,'api::pattern.pattern.findOne','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(27,'api::payment.payment.find','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(28,'api::payment.payment.findOne','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(29,'api::privacy-policy.privacy-policy.find','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(30,'api::terms-of-condition.terms-of-condition.find','2023-02-23 15:59:12.669000','2023-02-23 15:59:12.669000',NULL,NULL),
(31,'api::notebook-deliverability.notebook-deliverability.find','2023-02-23 20:29:25.461000','2023-02-23 20:29:25.461000',NULL,NULL),
(32,'api::notebook-deliverability.notebook-deliverability.findOne','2023-02-23 20:29:25.461000','2023-02-23 20:29:25.461000',NULL,NULL),
(33,'api::notebook-page.notebook-page.find','2023-02-23 20:29:25.461000','2023-02-23 20:29:25.461000',NULL,NULL),
(34,'api::notebook-page.notebook-page.findOne','2023-02-23 20:29:25.461000','2023-02-23 20:29:25.461000',NULL,NULL),
(35,'api::notebook-paper.notebook-paper.find','2023-02-23 20:29:25.461000','2023-02-23 20:29:25.461000',NULL,NULL),
(36,'api::notebook-paper.notebook-paper.findOne','2023-02-23 20:29:25.461000','2023-02-23 20:29:25.461000',NULL,NULL),
(37,'api::cart.cart.find','2023-02-24 07:15:56.258000','2023-02-24 07:15:56.258000',NULL,NULL);
/*!40000 ALTER TABLE `up_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `up_permissions_role_links`
--

DROP TABLE IF EXISTS `up_permissions_role_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `up_permissions_role_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `permission_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `up_permissions_role_links_unique` (`permission_id`,`role_id`),
  KEY `up_permissions_role_links_fk` (`permission_id`),
  KEY `up_permissions_role_links_inv_fk` (`role_id`),
  KEY `up_permissions_role_links_order_inv_fk` (`permission_order`),
  CONSTRAINT `up_permissions_role_links_fk` FOREIGN KEY (`permission_id`) REFERENCES `up_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `up_permissions_role_links_inv_fk` FOREIGN KEY (`role_id`) REFERENCES `up_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `up_permissions_role_links`
--

LOCK TABLES `up_permissions_role_links` WRITE;
/*!40000 ALTER TABLE `up_permissions_role_links` DISABLE KEYS */;
INSERT INTO `up_permissions_role_links` VALUES
(1,1,1,1),
(2,2,1,1),
(3,3,2,1),
(4,4,2,1),
(5,5,2,1),
(6,8,2,1),
(7,7,2,1),
(8,9,2,1),
(9,6,2,2),
(10,10,2,3),
(11,11,2,3),
(12,12,2,3),
(13,14,2,3),
(14,15,2,3),
(15,16,2,3),
(16,17,2,3),
(17,18,2,3),
(18,19,2,3),
(19,20,2,4),
(20,13,2,4),
(21,23,2,4),
(22,24,2,4),
(23,25,2,4),
(24,26,2,4),
(25,27,2,4),
(26,28,2,4),
(27,29,2,4),
(28,21,2,5),
(29,22,2,5),
(30,30,2,5),
(31,31,2,6),
(32,34,2,6),
(33,32,2,6),
(34,33,2,7),
(35,36,2,7),
(36,35,2,7),
(37,37,2,8);
/*!40000 ALTER TABLE `up_permissions_role_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `up_roles`
--

DROP TABLE IF EXISTS `up_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `up_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `up_roles_created_by_id_fk` (`created_by_id`),
  KEY `up_roles_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `up_roles_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `up_roles_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `up_roles`
--

LOCK TABLES `up_roles` WRITE;
/*!40000 ALTER TABLE `up_roles` DISABLE KEYS */;
INSERT INTO `up_roles` VALUES
(1,'Authenticated','Default role given to authenticated user.','authenticated','2023-02-20 17:34:24.458000','2023-02-20 17:34:24.458000',NULL,NULL),
(2,'REST API','Default REST API for unauthenticated users and visitors','public','2023-02-20 17:34:24.466000','2023-02-24 07:15:56.219000',NULL,NULL);
/*!40000 ALTER TABLE `up_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `up_users`
--

DROP TABLE IF EXISTS `up_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `up_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed` tinyint(1) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `up_users_created_by_id_fk` (`created_by_id`),
  KEY `up_users_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `up_users_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `up_users_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `up_users`
--

LOCK TABLES `up_users` WRITE;
/*!40000 ALTER TABLE `up_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `up_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `up_users_role_links`
--

DROP TABLE IF EXISTS `up_users_role_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `up_users_role_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `user_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `up_users_role_links_unique` (`user_id`,`role_id`),
  KEY `up_users_role_links_fk` (`user_id`),
  KEY `up_users_role_links_inv_fk` (`role_id`),
  KEY `up_users_role_links_order_inv_fk` (`user_order`),
  CONSTRAINT `up_users_role_links_fk` FOREIGN KEY (`user_id`) REFERENCES `up_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `up_users_role_links_inv_fk` FOREIGN KEY (`role_id`) REFERENCES `up_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `up_users_role_links`
--

LOCK TABLES `up_users_role_links` WRITE;
/*!40000 ALTER TABLE `up_users_role_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `up_users_role_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload_folders`
--

DROP TABLE IF EXISTS `upload_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_folders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `path_id` int(11) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(10) unsigned DEFAULT NULL,
  `updated_by_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `upload_folders_path_id_index` (`path_id`),
  UNIQUE KEY `upload_folders_path_index` (`path`),
  KEY `upload_folders_created_by_id_fk` (`created_by_id`),
  KEY `upload_folders_updated_by_id_fk` (`updated_by_id`),
  CONSTRAINT `upload_folders_created_by_id_fk` FOREIGN KEY (`created_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `upload_folders_updated_by_id_fk` FOREIGN KEY (`updated_by_id`) REFERENCES `admin_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload_folders`
--

LOCK TABLES `upload_folders` WRITE;
/*!40000 ALTER TABLE `upload_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `upload_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload_folders_parent_links`
--

DROP TABLE IF EXISTS `upload_folders_parent_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_folders_parent_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `folder_id` int(10) unsigned DEFAULT NULL,
  `inv_folder_id` int(10) unsigned DEFAULT NULL,
  `folder_order` double unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `upload_folders_parent_links_unique` (`folder_id`,`inv_folder_id`),
  KEY `upload_folders_parent_links_fk` (`folder_id`),
  KEY `upload_folders_parent_links_inv_fk` (`inv_folder_id`),
  KEY `upload_folders_parent_links_order_inv_fk` (`folder_order`),
  CONSTRAINT `upload_folders_parent_links_fk` FOREIGN KEY (`folder_id`) REFERENCES `upload_folders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `upload_folders_parent_links_inv_fk` FOREIGN KEY (`inv_folder_id`) REFERENCES `upload_folders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload_folders_parent_links`
--

LOCK TABLES `upload_folders_parent_links` WRITE;
/*!40000 ALTER TABLE `upload_folders_parent_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `upload_folders_parent_links` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-10 22:44:51
