-- MySQL Script generated by MySQL Workbench
-- Thu Apr 24 11:03:33 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`customers` (
  `customers_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `post_code` VARCHAR(5) NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  `region` VARCHAR(20) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`customers_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`shops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`shops` (
  `shop_id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `post_code` VARCHAR(5) NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  `region` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`shop_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employees` (
  `employee_id` INT NOT NULL,
  `name` VARCHAR(15) NOT NULL,
  `surname` VARCHAR(15) NOT NULL,
  `NIF` VARCHAR(12) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `type` ENUM('cuiner', 'repartidor') NOT NULL,
  `shops_shop_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `shops_shop_id`),
  INDEX `fk_employees_shops1_idx` (`shops_shop_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_shops1`
    FOREIGN KEY (`shops_shop_id`)
    REFERENCES `pizzeria`.`shops` (`shop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `type` ENUM('Pick-up', 'Delivery') NOT NULL,
  `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customers_customers_id` INT NOT NULL,
  `shops_shop_id` INT NOT NULL,
  `employees_employee_id` INT NULL DEFAULT NULL,
  `order_delivery_time` TIMESTAMP(2) NULL,
  PRIMARY KEY (`order_id`, `customers_customers_id`, `shops_shop_id`),
  INDEX `fk_orders_customers_idx` (`customers_customers_id` ASC) VISIBLE,
  INDEX `fk_orders_shops1_idx` (`shops_shop_id` ASC) VISIBLE,
  INDEX `fk_orders_employees1_idx` (`employees_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customers_customers_id`)
    REFERENCES `pizzeria`.`customers` (`customers_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_shops1`
    FOREIGN KEY (`shops_shop_id`)
    REFERENCES `pizzeria`.`shops` (`shop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_employees1`
    FOREIGN KEY (`employees_employee_id`)
    REFERENCES `pizzeria`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(15) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `image` BLOB NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  `type` ENUM('burger', 'beguda', 'pizza') NULL,
  `pizza_categories_category_id` INT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_products_pizza_categories1_idx` (`pizza_categories_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_pizza_categories1`
    FOREIGN KEY (`pizza_categories_category_id`)
    REFERENCES `pizzeria`.`pizza_categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order_items` (
  `order_item_id` INT NOT NULL AUTO_INCREMENT,
  `orders_order_id` INT NOT NULL,
  `products_product_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`order_item_id`, `orders_order_id`, `products_product_id`),
  INDEX `fk_order_content_products1_idx` (`products_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_content_orders1`
    FOREIGN KEY (`orders_order_id`)
    REFERENCES `pizzeria`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_content_products1`
    FOREIGN KEY (`products_product_id`)
    REFERENCES `pizzeria`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
