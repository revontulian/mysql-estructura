-- MySQL Workbench Synchronization
-- Generated: 2025-04-17 20:59
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: a

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `Cul_dAmpolla` DEFAULT CHARACTER SET utf8mb4 ;

CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`address` (
  `id_address` SMALLINT(0) UNSIGNED NOT NULL,
  `street_name` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `number` SMALLINT(0) UNSIGNED NOT NULL,
  `floor` TINYINT(0) NOT NULL,
  `door` TINYINT(0) UNSIGNED NULL DEFAULT NULL,
  `city` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `postal_code` CHAR(5) NOT NULL,
  `country` VARCHAR(40) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  PRIMARY KEY (`id_address`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`providers` (
  `id` SMALLINT(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `phone` MEDIUMINT(0) UNSIGNED NOT NULL,
  `fax` MEDIUMINT(0) NULL DEFAULT NULL,
  `NIF` CHAR(9) NOT NULL,
  `address_id_address` SMALLINT(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `address_id_address`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  INDEX `fk_providers_address1_idx` (`address_id_address` ASC) VISIBLE,
  CONSTRAINT `fk_providers_address1`
    FOREIGN KEY (`address_id_address`)
    REFERENCES `Cul_dAmpolla`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`glasses` (
  `model` INT(10) UNSIGNED NOT NULL,
  `brand` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `left_glass_graduation` FLOAT(11) NOT NULL,
  `right_glass_graduation` FLOAT(11) NOT NULL,
  `type` ENUM('flotant', 'pasta', 'metal·lica') NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `left_glass_color` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `right_glass_color` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `price` FLOAT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`model`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`customers` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `phone` MEDIUMINT(0) NOT NULL,
  `email` VARCHAR(40) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci' NOT NULL,
  `register_date` DATE NOT NULL,
  `recommender_id` SMALLINT(0) NULL DEFAULT NULL,
  `address_id_address` SMALLINT(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `address_id_address`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_customers_address1_idx` (`address_id_address` ASC) VISIBLE,
  CONSTRAINT `fk_customers_address1`
    FOREIGN KEY (`address_id_address`)
    REFERENCES `Cul_dAmpolla`.`address` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`sales` (
  `transaction_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `employees_employee_id` INT(11) NOT NULL,
  `customers_id` INT(10) UNSIGNED NOT NULL,
  `glasses_model` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`transaction_id`, `employees_employee_id`, `customers_id`, `glasses_model`),
  INDEX `fk_sales_employees1_idx` (`employees_employee_id` ASC) VISIBLE,
  INDEX `fk_sales_customers1_idx` (`customers_id` ASC) VISIBLE,
  INDEX `fk_sales_glasses1_idx` (`glasses_model` ASC) VISIBLE,
  CONSTRAINT `fk_sales_employees1`
    FOREIGN KEY (`employees_employee_id`)
    REFERENCES `Cul_dAmpolla`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `Cul_dAmpolla`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_glasses1`
    FOREIGN KEY (`glasses_model`)
    REFERENCES `Cul_dAmpolla`.`glasses` (`model`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`provider_has_glasses` (
  `po_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `glasses_model` INT(10) UNSIGNED NOT NULL,
  `providers_id` SMALLINT(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`po_id`, `glasses_model`, `providers_id`),
  INDEX `fk_provider_has_glasses_glasses1_idx` (`glasses_model` ASC) VISIBLE,
  INDEX `fk_provider_has_glasses_providers1_idx` (`providers_id` ASC) VISIBLE,
  CONSTRAINT `fk_provider_has_glasses_glasses1`
    FOREIGN KEY (`glasses_model`)
    REFERENCES `Cul_dAmpolla`.`glasses` (`model`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provider_has_glasses_providers1`
    FOREIGN KEY (`providers_id`)
    REFERENCES `Cul_dAmpolla`.`providers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Cul_dAmpolla`.`employees` (
  `employee_id` INT(11) NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
