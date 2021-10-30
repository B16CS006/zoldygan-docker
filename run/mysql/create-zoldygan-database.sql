-- drop database if exists
-- DROP DATABASE IF EXISTS `zoldygan`;
-- create a database
CREATE DATABASE `zoldygan`;
CREATE DATABASE `games`;
CREATE DATABASE `resources`;

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
  `status` ENUM("guest", "user", "maintainer", "owner", "god") DEFAULT "guest",
  `gender` ENUM("unknown", "female", "male", "other") DEFAULT "unknown",
  `address` VARCHAR(255),
  -- CONSTRAINT `fk_phone` FOREIGN KEY (`phone`) REFERENCES PHONE(`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  -- CONSTRAINT `fk_email` FOREIGN KEY (`email`) REFERENCES EMAIL(`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

-- create sample user
-- INSERT INTO `EMAIL`(`email`) VALUES("zoldygan@gmail.com");
-- INSERT INTO `USER`(`username`, `name`, `dob`, `email`, `password`) VALUES('zoldygan', 'Killua Zoldyck', DATE '1998-03-19', (SELECT `id` FROM `EMAIL` WHERE `email`='zoldygan@gmail.com'), 'qazwsx');

INSERT INTO `USER`(`username`, `name`, `dob`, `email`, `password`, `status`) VALUES('zoldygan', 'Killua Zoldyck', DATE '1998-03-19', 'zoldygan@gmail.com', '109824803287', 'god');

-- |  1 | zoldygan     | qazwsx      | Killua Zoldyck   | NULL     | 1998-03-19 | zoldygan@gmail.com       | NULL       | NULL  | NULL   | NULL    | NULL                     |
-- |  5 | rjarwal40    | Rjarwal@123 | Ravi Kumar Meena | Jarwal   | 1999-04-07 | rjarwal40@gmail.com      | 8739910537 | NULL  | NULL   | unknown | Village dhigariya Kapoor |
-- |  6 | Bablu jarwal | bablu1122   | Bablu Jarwal     | Mr.Bob   | 1997-07-01 | meenabablu0000@gmail.com | 7891375059 | NULL  | NULL   | unknown | Vill.dhigariya Kapoor 

-- ALTER COMMAND
-- ALTER TABLE `USER` ADD COLUMN `password` VARCHAR(20) NOT NULL;

use `games`;

CREATE TABLE `LUDO` (
  `challenge_id` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `amount` INT NOT NULL,
  `room_code` VARCHAR(20) NOT NULL,
  `creator` VARCHAR(20) NOT NULL,
  `acceptor` VARCHAR(20),
  `win_state` ENUM("waiting", "accepted", "pending", "canceled", "dispute", "declared") NOT NULL,
  `winner` ENUM("FORFEIT", "CREATOR", "ACCEPTOR", "OWNER"),
  `creator_result` ENUM("FORFEIT", "CREATOR", "ACCEPTOR", "OWNER"),
  `acceptor_result` ENUM("FORFEIT", "CREATOR", "ACCEPTOR", "OWNER"),
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`challenge_id`)
);

CREATE TABLE `zoldygan`.`TRANSACTION` (
  `transaction_id` INT NOT NULL UNIQUE AUTO_INCREMENT,
  `amount` INT NOT NULL,
  `description` TEXT,
  `username` VARCHAR(20) NOT NULL,
  `type` ENUM("cash", "bonus", "win", "penalty", "other") NOT NULL,
  `status` ENUM("pending", "done") NOT NULL,
  `challenge_id` VARCHAR(50), -- you can make challenge_id and username together as unique, if type is cash -> transaction id, if type -> other, represent challenge id
  `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(`transaction_id`)
);
ALTER TABLE `TRANSACTION` ADD CONSTRAINT `uq_trans` UNIQUE(`username`, `challenge_id`);

CREATE TABLE `resources`.`IMAGE_TRANSACTION` (
  `transaction_id` VARCHAR(50) NOT NULL UNIQUE,
  `image` VARBINARY(MAX),
  PRIMARY KEY (`transaction_id`)
);



-- ALTERS
ALTER TABLE `zoldygan`.`TRANSACTION` MODIFY `transaction_id` INT NOT NULL UNIQUE AUTO_INCREMENT;