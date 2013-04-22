DROP DATABASE IF EXISTS `docomo`;
CREATE DATABASE `docomo`;
USE `docomo`;

-- -------------------------------------------------------

--
-- Table structure for table `product_update`
--
CREATE TABLE IF NOT EXISTS `product_update` (
	`id` int(11) NOT NULL auto_increment,
	`start_date` date NOT NULL default '0000-00-00',
	`model` varchar(255) NOT NULL default '',
	`approach` varchar(255) NOT NULL default '',
	`end_date` date NOT NULL default '0000-00-00',
	`other` varchar(255) NOT NULL default '',
	`acquisition_date` datetime NOT NULL default '0000-00-00 00:00:00',
	PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

