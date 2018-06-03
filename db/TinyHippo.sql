-- MySQL Script generated by MySQL Workbench
-- Sun May 20 03:18:22 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema TINYHIPPO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TINYHIPPO
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TINYHIPPO` DEFAULT CHARACTER SET utf8 ;
USE `TINYHIPPO` ;

-- -----------------------------------------------------
-- Table `TINYHIPPO`.`Resturant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TINYHIPPO`.`Resturant` (
  `resturantID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `resturantName` VARCHAR(50) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`resturantID`),
  UNIQUE INDEX `resturantID_UNIQUE` (`resturantID` ASC),
  UNIQUE INDEX `resturantName_UNIQUE` (`resturantName` ASC));


-- -----------------------------------------------------
-- Table `TINYHIPPO`.`ResturantTable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TINYHIPPO`.`ResturantTable` (
  `tableID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tableNumber` INT UNSIGNED NOT NULL,
  `currentOrderNumber` INT NOT NULL,
  `resturantID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`tableID`, `resturantID`),
  UNIQUE INDEX `tableID_UNIQUE` (`tableID` ASC),
  INDEX `fk_Table_Resturant1_idx` (`resturantID` ASC),
  CONSTRAINT `fk_Table_Resturant1`
    FOREIGN KEY (`resturantID`)
    REFERENCES `TINYHIPPO`.`Resturant` (`resturantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `TINYHIPPO`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TINYHIPPO`.`Customer` (
  `customerID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customerName` VARCHAR(20) NOT NULL,
  `tableID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`customerID`, `tableID`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customerID` ASC),
  INDEX `fk_Customer_Table1_idx` (`tableID` ASC),
  UNIQUE INDEX `customerName_UNIQUE` (`customerName` ASC),
  CONSTRAINT `fk_Customer_Table1`
    FOREIGN KEY (`tableID`)
    REFERENCES `TINYHIPPO`.`ResturantTable` (`tableID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `TINYHIPPO`.`OrderList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TINYHIPPO`.`OrderList` (
  `orderID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `orderNumber` INT NOT NULL,
  `orderDetail` VARCHAR(500) NOT NULL,
  `total` FLOAT NOT NULL,
  `status` VARCHAR(10) NOT NULL,
  `isPaid` TINYINT NOT NULL,
  `editedTime` DATETIME NOT NULL,
  `tableID` INT UNSIGNED NOT NULL,
  `customerID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`orderID`, `tableID`, `customerID`),
  UNIQUE INDEX `orderID_UNIQUE` (`orderID` ASC),
  INDEX `fk_OrderList_Table1_idx` (`tableID` ASC),
  INDEX `fk_OrderList_Customer1_idx` (`customerID` ASC),
  CONSTRAINT `fk_OrderList_Table1`
    FOREIGN KEY (`tableID`)
    REFERENCES `TINYHIPPO`.`ResturantTable` (`tableID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderList_Customer1`
    FOREIGN KEY (`customerID`)
    REFERENCES `TINYHIPPO`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `TINYHIPPO`.`QRlink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TINYHIPPO`.`QRlink` (
  `linkID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `linkImageURL` VARCHAR(255) NOT NULL,
  `tableID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`linkID`, `tableID`),
  UNIQUE INDEX `linkID_UNIQUE` (`linkID` ASC),
  INDEX `fk_QRlink_ResturantTable1_idx` (`tableID` ASC),
  CONSTRAINT `fk_QRlink_ResturantTable1`
    FOREIGN KEY (`tableID`)
    REFERENCES `TINYHIPPO`.`ResturantTable` (`tableID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `TINYHIPPO`.`DishType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TINYHIPPO`.`DishType` (
  `dishTypeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dishTypeName` VARCHAR(255) NOT NULL,
  `resturantID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`dishTypeID`, `resturantID`),
  UNIQUE INDEX `dishTypeID_UNIQUE` (`dishTypeID` ASC),
  INDEX `fk_DishType_Resturant1_idx` (`resturantID` ASC),
  CONSTRAINT `fk_DishType_Resturant1`
    FOREIGN KEY (`resturantID`)
    REFERENCES `TINYHIPPO`.`Resturant` (`resturantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `TINYHIPPO`.`Dish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TINYHIPPO`.`Dish` (
  `dishID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dishName` VARCHAR(255) NOT NULL,
  `dishDescription` VARCHAR(255) NOT NULL,
  `onSale` TINYINT NOT NULL,
  `price` FLOAT NOT NULL,
  `dishImageURL` VARCHAR(255) NOT NULL,
  `dishComment` VARCHAR(255) NOT NULL,
  `dishHot` TINYINT UNSIGNED NOT NULL,
  `monthlySales` INT UNSIGNED NOT NULL,
  `resturantID` INT UNSIGNED NOT NULL,
  `dishTypeID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`dishID`, `resturantID`, `dishTypeID`),
  UNIQUE INDEX `dishID_UNIQUE` (`dishID` ASC),
  INDEX `fk_Dish_Resturant1_idx` (`resturantID` ASC),
  INDEX `fk_Dish_DishType1_idx` (`dishTypeID` ASC),
  CONSTRAINT `fk_Dish_Resturant1`
    FOREIGN KEY (`resturantID`)
    REFERENCES `TINYHIPPO`.`Resturant` (`resturantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dish_DishType1`
    FOREIGN KEY (`dishTypeID`)
    REFERENCES `TINYHIPPO`.`DishType` (`dishTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;