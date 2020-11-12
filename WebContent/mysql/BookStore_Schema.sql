-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bookstore
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bookstore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bookstore` DEFAULT CHARACTER SET utf8 ;
USE `bookstore` ;

-- -----------------------------------------------------
-- Table `bookstore`.`Customer_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Customer_Status` (
  `code` VARCHAR(10) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`User_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`User_Type` (
  `code` VARCHAR(10) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`User` (
  `user_id` VARCHAR(45) NOT NULL,
  `password` BLOB NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `User_Type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_User_User_Type1_idx` (`User_Type` ASC) VISIBLE,
  CONSTRAINT `fk_User_User_Type1`
    FOREIGN KEY (`User_Type`)
    REFERENCES `bookstore`.`User_Type` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Customer` (
  `customer_id` INT NOT NULL,
  `user_id` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(45) NULL,
  `phone_number` VARCHAR(15) NULL,
  `status` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_Customer_CustomerStatus_idx` (`status` ASC) VISIBLE,
  INDEX `fk_Customer_User1_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `email_address_UNIQUE` (`email_address` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_CustomerStatus`
    FOREIGN KEY (`status`)
    REFERENCES `bookstore`.`Customer_Status` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bookstore`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Address_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Address_Type` (
  `code` VARCHAR(10) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Address` (
  `addess_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` INT NOT NULL,
  `address_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`addess_id`),
  INDEX `fk_Address_Customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Address_address_type1_idx` (`address_type` ASC) VISIBLE,
  CONSTRAINT `fk_Address_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `bookstore`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_address_type1`
    FOREIGN KEY (`address_type`)
    REFERENCES `bookstore`.`Address_Type` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Book_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Book_Category` (
  `code` VARCHAR(10) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Book` (
  `book_id` INT NOT NULL,
  `isbn` VARCHAR(20) NULL,
  `category` VARCHAR(10) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `edition` VARCHAR(20) NULL,
  `publisher` VARCHAR(45) NULL,
  `publication_year` INT NULL,
  `cover_picture` VARCHAR(100) NULL,
  PRIMARY KEY (`book_id`),
  INDEX `fk_Book_category1_idx` (`category` ASC) VISIBLE,
    CONSTRAINT `fk_Book_category1`
    FOREIGN KEY (`category`)
    REFERENCES `bookstore`.`Book_Category` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Promotion` (
  `promotion_id` INT NOT NULL,
  `promo_code` VARCHAR(20) NOT NULL,
  `percentage` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `delivered` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`promotion_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Card_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Card_Type` (
  `code` VARCHAR(10) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Payment_Card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Payment_Card` (
  `card_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `card_number` BLOB NULL DEFAULT NULL,
  `expiration_date` DATE NULL,
  `card_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`card_id`),
  INDEX `fk_PaymentCard_CardType1_idx` (`card_type` ASC) VISIBLE,
  INDEX `fk_PaymentCard_Customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_PaymentCard_CardType1`
    FOREIGN KEY (`card_type`)
    REFERENCES `bookstore`.`Card_Type` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentCard_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `bookstore`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Order` (
  `order_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `promotion_id` INT NULL,
  `card_id` INT NOT NULL,
  `date_created` DATE NOT NULL,
  `date_shipped` DATE NULL,
  `amount` DECIMAL(10,2) NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Order_Customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Order_Promotion1_idx` (`promotion_id` ASC) VISIBLE,
  INDEX `fk_Order_PaymentCard1_idx` (`card_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `bookstore`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Promotion1`
    FOREIGN KEY (`promotion_id`)
    REFERENCES `bookstore`.`Promotion` (`promotion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_PaymentCard1`
    FOREIGN KEY (`card_id`)
    REFERENCES `bookstore`.`Payment_Card` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Book_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Book_Status` (
  `code` VARCHAR(10) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Inventory` (
  `book_id` INT NOT NULL,
  `quantity` INT NULL,
  `price` DECIMAL(10,2) NULL,
  `Book_Status` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`book_id`),
  INDEX `fk_Inventory_Book1_idx` (`book_id` ASC) VISIBLE,
  INDEX `fk_Inventory_Book_Status1_idx` (`Book_Status` ASC) VISIBLE,
  CONSTRAINT `fk_Inventory_Book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `bookstore`.`Book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventory_Book_Status1`
    FOREIGN KEY (`Book_Status`)
    REFERENCES `bookstore`.`Book_Status` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Order_Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Order_Item` (
  `order_item_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`order_item_id`),
  INDEX `fk_OrderItems_Order1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_OrderItems_Book1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_OrderItems_Order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `bookstore`.`Order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderItems_Book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `bookstore`.`Book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Cart` (
  `customer_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_Cart_Book1_idx` (`book_id` ASC) VISIBLE,
  INDEX `fk_Cart_Customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cart_Book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `bookstore`.`Book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cart_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `bookstore`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`User_Session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`User_Session` (
  `user_id` VARCHAR(45) NOT NULL,
  `session_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_UserSession_User1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_UserSession_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bookstore`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bookstore`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookstore`.`Author` (
  `book_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  CONSTRAINT `fk_Author_Book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `bookstore`.`Book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
