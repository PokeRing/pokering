# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.20)
# Database: pokering
# Generation Time: 2014-10-26 20:27:20 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

USE `pokering`;

DELETE FROM `users`;

# Dump of table users
# ------------------------------------------------------------

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `username`, `pin`, `favorite_hand`, `avatar_url`, `phone`, `city`, `state`, `notify_via`, `bio`, `status`, `date_created`, `date_updated`)
VALUES
	(1,'Penny','Lane','pennylane@getpokering.com','pennylane',1234,'4 of a kind',NULL,'1235550987','Memphis','TN','email',NULL,'active','2014-10-04 12:34:55','2014-10-07 04:34:55'),
	(2,'George','Bladell','g.blad@getpokering.com','g.blad',1234,NULL,NULL,NULL,NULL,NULL,'mobile',NULL,'active','2014-10-05 01:22:41','2014-10-05 01:22:41'),
	(3,'Vinny','Goombots','vgooms@getpokering.com','vgooms',1234,'Royal Flush',NULL,'1235554387','New York','NY','email','Hey, my name is Vinny!  I\'ve been made fun of my whole life because of my last name, so I\'ve decided to become good at something to get back at everyone.  And that something is poker.  Are you ready to play me?  Because I bet I will beat you.  I have years and years of turmoil to prove it.','active','2014-10-05 10:13:00','2014-10-14 09:45:08'),
	(4,NULL,NULL,'kate.grainger@getpokering.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'invited','2014-10-06 07:14:00','2014-10-06 07:14:00'),
	(5,'Manny','Thomas','mmthomas@getpokering.com','mmthomas',1234,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'inactive','2014-10-09 10:12:56','2014-10-19 12:56:00');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
