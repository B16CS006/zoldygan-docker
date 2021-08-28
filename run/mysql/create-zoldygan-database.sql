-- drop database if exists
-- DROP DATABASE IF EXISTS `zoldygan`;
-- create a database
-- CREATE DATABASE `zoldygan`;

USE `zoldygan`;

-- create a table for  email
-- CREATE TABLE `EMAIL` (`id` INT NOT NULL AUTO_INCREMENT UNIQUE, `email` VARCHAR(255) NOT NULL UNIQUE, PRIMARY KEY(`id`));
-- create a table for mobile number
-- CREATE TABLE `PHONE` ( `id` INT NOT NULL AUTO_INCREMENT UNIQUE, `phone` varchar(20) NOT NULL UNIQUE, PRIMARY KEY(`id`));
-- create a table to store user info
CREATE TABLE `USER` (
  `id` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `username` VARCHAR(20) NOT NULL UNIQUE,
  `password` VARCHAR(20) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `nickname` varchar(10),
  `dob` DATE NOT NULL,
  `email` VARCHAR(50) UNIQUE,
  `phone` CHAR(10) UNIQUE,
  `state` ENUM("active", "blocked"),
  `status` ENUM("guest", "user", "maintainer", "owner", "god"),
  `gender` ENUM("unknown", "female", "mail", "other"),
  `address` VARCHAR(255),
  -- CONSTRAINT `fk_phone` FOREIGN KEY (`phone`) REFERENCES PHONE(`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  -- CONSTRAINT `fk_email` FOREIGN KEY (`email`) REFERENCES EMAIL(`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  PRIMARY KEY (`id`)
);

-- create sample user
-- INSERT INTO `EMAIL`(`email`) VALUES("zoldygan@gmail.com");
-- INSERT INTO `USER`(`username`, `name`, `dob`, `email`, `password`) VALUES('zoldygan', 'Killua Zoldyck', DATE '1998-03-19', (SELECT `id` FROM `EMAIL` WHERE `email`='zoldygan@gmail.com'), 'qazwsx');

INSERT INTO `USER`(`username`, `name`, `dob`, `email`, `password`) VALUES('zoldygan', 'Killua Zoldyck', DATE '1998-03-19', 'zoldygan@gmail.com', 'qazwsx');



-- ALTER COMMAND
-- ALTER TABLE `USER` ADD COLUMN `password` VARCHAR(20) NOT NULL;