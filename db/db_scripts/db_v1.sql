-- MySQL Script generated by MySQL Workbench
-- Wed Jul 31 15:47:39 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema aermotion
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aermotion
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aermotion` DEFAULT CHARACTER SET utf8 ;
USE `aermotion` ;

-- -----------------------------------------------------
-- Table `aermotion`.`sets_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aermotion`.`sets_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aermotion`.`workout_sets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aermotion`.`workout_sets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `price` VARCHAR(45) NOT NULL,
  `type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `type_id_idx` (`type_id` ASC),
  CONSTRAINT `type_id`
    FOREIGN KEY (`type_id`)
    REFERENCES `aermotion`.`sets_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aermotion`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aermotion`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aermotion`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aermotion`.`videos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `video_url` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idvideos_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aermotion`.`video_set_connector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aermotion`.`video_set_connector` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `video_id` INT NULL,
  `workout_set_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `video_id_idx` (`video_id` ASC),
  INDEX `workout_sets_id_idx` (`workout_set_id` ASC),
  CONSTRAINT `video_id`
    FOREIGN KEY (`video_id`)
    REFERENCES `aermotion`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `workout_sets_id`
    FOREIGN KEY (`workout_set_id`)
    REFERENCES `aermotion`.`workout_sets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aermotion`.`users_set_connector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aermotion`.`users_set_connector` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `workout_sets_id` INT NULL,
  `users_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `users_id_idx` (`users_id` ASC),
  INDEX `workout_sets_id_idx` (`workout_sets_id` ASC),
  CONSTRAINT `users_id`
    FOREIGN KEY (`users_id`)
    REFERENCES `aermotion`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `workout_sets_id`
    FOREIGN KEY (`workout_sets_id`)
    REFERENCES `aermotion`.`workout_sets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `aermotion`.`sets_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `aermotion`;
INSERT INTO `aermotion`.`sets_types` (`id`, `type`) VALUES (1, 'set');
INSERT INTO `aermotion`.`sets_types` (`id`, `type`) VALUES (2, 'video');

COMMIT;


-- -----------------------------------------------------
-- Data for table `aermotion`.`workout_sets`
-- -----------------------------------------------------
START TRANSACTION;
USE `aermotion`;
INSERT INTO `aermotion`.`workout_sets` (`id`, `title`, `description`, `price`, `type_id`) VALUES (1, 'Dynamic Strenght', 'Aermotion members get exclusive access to our entire skills library proven technique guides and fresh weekly workouts', '15.00', 1);
INSERT INTO `aermotion`.`workout_sets` (`id`, `title`, `description`, `price`, `type_id`) VALUES (2, 'Static strength', NULL, '32.00', 1);
INSERT INTO `aermotion`.`workout_sets` (`id`, `title`, `description`, `price`, `type_id`) VALUES (3, 'How to Jump Hight', 'This video will teach you how to jump very good', '2.00', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `aermotion`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `aermotion`;
INSERT INTO `aermotion`.`users` (`id`, `username`, `password`) VALUES (1, 'dskrylev', 'paroll231');
INSERT INTO `aermotion`.`users` (`id`, `username`, `password`) VALUES (2, 'mnazarev', '23f2f3sda');

COMMIT;


-- -----------------------------------------------------
-- Data for table `aermotion`.`videos`
-- -----------------------------------------------------
START TRANSACTION;
USE `aermotion`;
INSERT INTO `aermotion`.`videos` (`id`, `video_url`) VALUES (1, 'video_1');
INSERT INTO `aermotion`.`videos` (`id`, `video_url`) VALUES (2, 'video_2');
INSERT INTO `aermotion`.`videos` (`id`, `video_url`) VALUES (3, 'video_3');
INSERT INTO `aermotion`.`videos` (`id`, `video_url`) VALUES (4, 'video_4');
INSERT INTO `aermotion`.`videos` (`id`, `video_url`) VALUES (5, 'video_5');
INSERT INTO `aermotion`.`videos` (`id`, `video_url`) VALUES (6, 'video_6');

COMMIT;


-- -----------------------------------------------------
-- Data for table `aermotion`.`video_set_connector`
-- -----------------------------------------------------
START TRANSACTION;
USE `aermotion`;
INSERT INTO `aermotion`.`video_set_connector` (`id`, `video_id`, `workout_set_id`) VALUES (1, 1, 1);
INSERT INTO `aermotion`.`video_set_connector` (`id`, `video_id`, `workout_set_id`) VALUES (2, 2, 1);

COMMIT;

