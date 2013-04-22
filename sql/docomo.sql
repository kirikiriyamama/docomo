DROP DATABASE IF EXISTS `docomo`;
CREATE DATABASE `docomo`;
USE `docomo`;

-- -------------------------------------------------------

--
-- Table structure for table `product_update_info`
--
CREATE TABLE IF NOT EXISTS `product_update_info` (
	`id` int(11) NOT NULL auto_increment,
	`update_start_date` datetime NOT NULL default '0000-00-00 00:00:00',
	`model_name` varchar(255) NOT NULL default '',
	`corresponding_method` varchar(255) NOT NULL default '',
	`update_term` datetime NOT NULL default '0000-00-00 00:00:00',
	`other` varchar(255) NOT NULL default '',
	`register_date` datetime NOT NULL default '0000-00-00 00:00:00',
	PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

