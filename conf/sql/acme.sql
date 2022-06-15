-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema test_acme
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `test_acme` ;

-- -----------------------------------------------------
-- Schema test_acme
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `test_acme` DEFAULT CHARACTER SET utf8 ;
USE `test_acme` ;

-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `category_id` INT NOT NULL,
  `label` VARCHAR(255) NOT NULL,
  `taxes` DOUBLE(5,2) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `category_id_UNIQUE` ON `category` (`category_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pokemon_properties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pokemon_properties` ;

CREATE TABLE IF NOT EXISTS `pokemon_properties` (
  `prop_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(255) NOT NULL,
  `taille` DOUBLE(3,1) NOT NULL,
  `poids` DOUBLE(10,2) NOT NULL,
  `Level` INT NOT NULL DEFAULT '1',
  `Exp` INT NOT NULL DEFAULT '0',
  `ATK` INT NOT NULL,
  `DEF` INT NOT NULL,
  `SPD` INT NOT NULL,
  `ATKSPE` INT NOT NULL,
  `DEFSPE` INT NOT NULL,
  `PV` INT NOT NULL DEFAULT '0',
  `PP` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`prop_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `article` ;

CREATE TABLE IF NOT EXISTS `article` (
  `article_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `code_article` VARCHAR(45) NULL DEFAULT 'CONCAT(label, \'_\', category_id)',
  `label` VARCHAR(45) NOT NULL,
  `prix` DOUBLE(10,2) NOT NULL,
  `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` TEXT NULL DEFAULT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT b'1',
  `last_modified` TIMESTAMP NULL DEFAULT NULL,
  `category_id` INT NOT NULL,
  `property_id` INT NOT NULL,
  PRIMARY KEY (`article_id`),
  CONSTRAINT `fk_article_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_pokemon_properties1`
    FOREIGN KEY (`property_id`)
    REFERENCES `pokemon_properties` (`prop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `article_article_id_index` ON `article` (`article_id` ASC) VISIBLE;

CREATE INDEX `fk_article_category1_idx` ON `article` (`category_id` ASC) VISIBLE;

CREATE INDEX `fk_article_pokemon_properties1_idx` ON `article` (`property_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer` ;

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(30) NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `country` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `postal_code` VARCHAR(12) NOT NULL,
  `way_number` INT NULL DEFAULT NULL,
  `way_type` VARCHAR(30) NOT NULL,
  `way_name` VARCHAR(255) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `last_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` TINYINT(1) NOT NULL DEFAULT '1',
  `added_by` INT NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `Customers_pk_2` ON `customer` (`first_name` ASC, `last_name` ASC) VISIBLE;

CREATE UNIQUE INDEX `customer_email_uindex` ON `customer` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cart` ;

CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` INT NOT NULL AUTO_INCREMENT,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_user` INT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`cart_id`, `customer_id`),
  CONSTRAINT `fk_cart_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 202
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `cart_cart_id_customer_id_index` ON `cart` (`cart_id` ASC) VISIBLE;

CREATE INDEX `fk_cart_customer1_idx` ON `cart` (`customer_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `cart_has_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cart_has_article` ;

CREATE TABLE IF NOT EXISTS `cart_has_article` (
  `cart_id` INT NOT NULL,
  `article_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `cart_has_article_article_article_id_fk`
    FOREIGN KEY (`article_id`)
    REFERENCES `article` (`article_id`),
  CONSTRAINT `cart_has_article_cart_cart_id_fk`
    FOREIGN KEY (`cart_id`)
    REFERENCES `cart` (`cart_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `cart_has_article_article_article_id_fk` ON `cart_has_article` (`article_id` ASC) VISIBLE;

CREATE INDEX `cart_has_article_cart_cart_id_fk` ON `cart_has_article` (`cart_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `city` ;

CREATE TABLE IF NOT EXISTS `city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country_id` INT NOT NULL,
  `label` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `cities_label_uindex` ON `city` (`label` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_role` ;

CREATE TABLE IF NOT EXISTS `user_role` (
  `role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(10) NULL DEFAULT 'USER',
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `id_UNIQUE` ON `user_role` (`role_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(60) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `nickname` VARCHAR(45) NULL DEFAULT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_role` VARCHAR(15) NOT NULL DEFAULT 'NOONE',
  `role_id` INT UNSIGNED NOT NULL DEFAULT 8,
  PRIMARY KEY (`user_id`, `role_id`),
  CONSTRAINT `fk_user_user_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `user_role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `email_UNIQUE` ON `user` (`email` ASC) VISIBLE;

CREATE INDEX `fk_user_user_role1_idx` ON `user` (`role_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `commercial_has_customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `commercial_has_customer` ;

CREATE TABLE IF NOT EXISTS `commercial_has_customer` (
  `customer_id` INT NOT NULL,
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `change_date` TIMESTAMP NULL DEFAULT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `commercial_has_customer_customer_customer_id_fk`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`),
  CONSTRAINT `fk_commercial_has_customer_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `commercial_has_customer_customer_customer_id_fk` ON `commercial_has_customer` (`customer_id` ASC) VISIBLE;

CREATE INDEX `fk_commercial_has_customer_user1_idx` ON `commercial_has_customer` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country` ;

CREATE TABLE IF NOT EXISTS `country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `iso` CHAR(2) NOT NULL,
  `name` VARCHAR(80) NOT NULL,
  `nicename` VARCHAR(80) NOT NULL,
  `iso3` CHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
AUTO_INCREMENT = 240
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `order_`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_` ;

CREATE TABLE IF NOT EXISTS `order_` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TVA` DOUBLE(10,2) NOT NULL,
  `prix_ttc` DOUBLE(10,2) NOT NULL,
  `status_id` INT NULL DEFAULT '1',
  `date_modified` TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 35
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `order_id_customer_id_index` ON `order_` (`customer_id` ASC) VISIBLE;

CREATE INDEX `order__status_id_index` ON `order_` (`status_id` ASC) VISIBLE;

CREATE INDEX `order_status_status_id_index` ON `order_` (`status_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `customer_has_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer_has_order` ;

CREATE TABLE IF NOT EXISTS `customer_has_order` (
  `customer_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  CONSTRAINT `fk_customer_has_order_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_has_order_order_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `order_` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_customer_has_order_customer1_idx` ON `customer_has_order` (`customer_id` ASC) VISIBLE;

CREATE INDEX `fk_customer_has_order_order_1_idx` ON `customer_has_order` (`order_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `order_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_status` ;

CREATE TABLE IF NOT EXISTS `order_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(35) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `order_status_label_uindex` ON `order_status` (`label` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `security_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `security_details` ;

CREATE TABLE IF NOT EXISTS `security_details` (
  `user_id` INT UNSIGNED NOT NULL,
  `account_locked` BINARY(1) NOT NULL DEFAULT '0',
  `credentials_expired` BINARY(1) NOT NULL DEFAULT '0',
  `enabled` BINARY(1) NOT NULL DEFAULT '1',
  `account_expired` BINARY(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_security_details_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_security_details_user1_idx` ON `security_details` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `street_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `street_type` ;

CREATE TABLE IF NOT EXISTS `street_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(100) NOT NULL,
  `abrev` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `street_type_label_uindex` ON `street_type` (`label` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `user_has_customer_rights`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_customer_rights` ;

CREATE TABLE IF NOT EXISTS `user_has_customer_rights` (
  `user_id` INT UNSIGNED NOT NULL,
  `customer_id` INT NOT NULL,
  CONSTRAINT `fk_user_has_customer_rights_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_customer_rights_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_user_has_customer_rights_user1_idx` ON `user_has_customer_rights` (`user_id` ASC) VISIBLE;

CREATE INDEX `fk_user_has_customer_rights_customer1_idx` ON `user_has_customer_rights` (`customer_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `user_has_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_has_order` ;

CREATE TABLE IF NOT EXISTS `user_has_order` (
  `user_id` INT UNSIGNED NOT NULL,
  `order_id` INT NOT NULL,
  CONSTRAINT `fk_user_has_order_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_order_order_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `order_` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_user_has_order_user1_idx` ON `user_has_order` (`user_id` ASC) VISIBLE;

CREATE INDEX `fk_user_has_order_order_1_idx` ON `user_has_order` (`order_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouse` ;

CREATE TABLE IF NOT EXISTS `warehouse` (
  `warehouse_id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(50) NOT NULL,
  `city_id` INT NULL,
  `country_id` INT NULL,
  PRIMARY KEY (`warehouse_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `warehouse_has_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `warehouse_has_article` ;

CREATE TABLE IF NOT EXISTS `warehouse_has_article` (
  `article_id` INT UNSIGNED NOT NULL,
  `warehouse_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  CONSTRAINT `fk_warehouse_has_article_warehouse1`
    FOREIGN KEY (`warehouse_id`)
    REFERENCES `warehouse` (`warehouse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_warehouse_has_article_article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_warehouse_has_article_warehouse1_idx` ON `warehouse_has_article` (`warehouse_id` ASC) VISIBLE;

CREATE INDEX `fk_warehouse_has_article_article1_idx` ON `warehouse_has_article` (`article_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `article_has_props`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `article_has_props` ;

CREATE TABLE IF NOT EXISTS `article_has_props` (
  `article_id` INT UNSIGNED NOT NULL,
  `property_id` INT NOT NULL,
  PRIMARY KEY (`article_id`, `property_id`),
  CONSTRAINT `fk_article_has_pokemon_properties_article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_has_props_pokemon_properties1`
    FOREIGN KEY (`property_id`)
    REFERENCES `pokemon_properties` (`prop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_article_has_pokemon_properties_article1_idx` ON `article_has_props` (`article_id` ASC) VISIBLE;

CREATE INDEX `fk_article_has_props_pokemon_properties1_idx` ON `article_has_props` (`property_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `order_has_article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_has_article` ;

CREATE TABLE IF NOT EXISTS `order_has_article` (
  `order_id` INT NOT NULL,
  `article_id` INT UNSIGNED NOT NULL,
  CONSTRAINT `fk_order__has_article_order_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `order_` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order__has_article_article1`
    FOREIGN KEY (`article_id`)
    REFERENCES `article` (`article_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_order__has_article_article1_idx` ON `order_has_article` (`article_id` ASC) VISIBLE;

CREATE INDEX `fk_order__has_article_order_1_idx` ON `order_has_article` (`order_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `order_has_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `order_has_status` ;

CREATE TABLE IF NOT EXISTS `order_has_status` (
  `status_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`status_id`, `order_id`),
  CONSTRAINT `fk_order_status_has_order__order_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `order_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_status_has_order__order_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `order_` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_order_status_has_order__order_1_idx` ON `order_has_status` (`order_id` ASC) VISIBLE;

CREATE INDEX `fk_order_status_has_order__order_status1_idx` ON `order_has_status` (`status_id` ASC) VISIBLE;

USE `test_acme` ;

-- -----------------------------------------------------
-- Placeholder table for view `Pokemon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokemon` (`article_id` INT, `label` INT, `prix` INT, `description` INT, `code_article` INT, `date` INT, `enabled` INT, `props` INT, `category` INT);

-- -----------------------------------------------------
-- View `Pokemon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pokemon`;
DROP VIEW IF EXISTS `Pokemon` ;
USE `test_acme`;
CREATE  OR REPLACE VIEW `Pokemon` AS
SELECT a.article_id as article_id, a.label as label, a.prix as prix,
                a.description as description, a.code_article as code_article, a.date_created as date,
                a.enabled as enabled,
                GROUP_CONCAT(pokemon_properties.prop_id, ':', pokemon_properties.type,
                ':', pokemon_properties.taille, ':', pokemon_properties.poids,
                ':', pokemon_properties.Level, ':', pokemon_properties.Exp,
                '/', pokemon_properties.ATK, ':', pokemon_properties.DEF,
                ':', pokemon_properties.SPD,
                ':', pokemon_properties.ATKSPE, ':', pokemon_properties.DEFSPE,
                ':', pokemon_properties.PV, ':', pokemon_properties.PP) as props,
                GROUP_CONCAT(category.category_id, ':', category.label, ':', category.taxes) as category
                FROM article as a
                RIGHT JOIN article_has_props ON article_has_props.article_id = a.article_id
                LEFT JOIN pokemon_properties ON pokemon_properties.prop_id = a.property_id
                LEFT JOIN category ON category.category_id = 1
                GROUP BY a.article_id
                ;

--
-- Base de données : `test_acme`
--

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`article_id`, `code_article`, `label`, `prix`, `date_created`, `description`, `category_id`,
                       `property_id`, `enabled`, `last_modified`)
VALUES (1, 'POKE_0001', 'Bulbizarre', 120.23, '2022-06-12 15:46:47', '\'un pokemon de type plante, niveau 10\'', 1, 1,
        b'1', '2022-06-12 15:46:48'),
       (2, 'POKE_0002', 'Herbizarre', 180.78, '2022-06-03 05:50:33', '\'un pokemone de type plante, rang2, niveau 30\'',
        1, 2, b'1', NULL),
       (3, 'POKE_0003', 'Florizarre', 350, '2022-05-29 08:34:32', '\'un pokemone de type plante, rang3, niveau 52\'', 1,
        3, b'1', NULL),
       (4, 'TEST_0001', 'Salamèche', 122, '2022-06-05 00:04:34', 'Type feu, Nivaeu 12', 1, 6, b'1', NULL);

--
-- Déchargement des données de la table `article_has_props`
--

INSERT INTO `article_has_props` (`article_id`, `property_id`)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 6);

--
-- Déchargement des données de la table `cart`
--

INSERT INTO `cart` (`cart_id`, `date_created`, `customer_id`)
VALUES (195, '2022-06-06 19:12:50', 1),
       (196, '2022-06-06 19:12:50', 2),
       (197, '2022-06-06 19:12:50', 3),
       (198, '2022-06-06 19:51:22', 4),
       (200, '2022-06-07 09:42:17', 5),
       (201, '2022-06-12 13:41:26', 6),
       (202, '2022-06-06 19:12:50', 1),
       (203, '2022-06-06 19:12:50', 2),
       (204, '2022-06-06 19:12:50', 3),
       (205, '2022-06-06 19:51:22', 4),
       (206, '2022-06-07 09:42:17', 5),
       (207, '2022-06-12 13:41:26', 6);

--
-- Déchargement des données de la table `cart_has_article`
--

INSERT INTO `cart_has_article` (`cart_id`, `article_id`)
VALUES (196, 1),
       (201, 4),
       (201, 4),
       (201, 4),
       (201, 2);

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`category_id`, `label`, `taxes`)
VALUES (1, 'Pokemon', 20.00),
       (2, 'Pokedex', 17.53),
       (3, 'PokeBall', 16.00),
       (4, 'Vitamine', 5.50),
       (5, 'Ticket', 12.00);

--
-- Déchargement des données de la table `commercial_has_customer`
--

INSERT INTO `commercial_has_customer` (`customer_id`, `user_id`, `creation_date`, `change_date`)
VALUES (6, 4, '2022-06-11 23:00:01', NULL);

--
-- Déchargement des données de la table `country`
--

INSERT INTO `country` (`id`, `iso`, `name`, `nicename`, `iso3`)
VALUES (1, 'AF', 'AFGHANISTAN', 'Afghanistan', 'AFG'),
       (2, 'AL', 'ALBANIA', 'Albania', 'ALB'),
       (3, 'DZ', 'ALGERIA', 'Algeria', 'DZA'),
       (4, 'AS', 'AMERICAN SAMOA', 'American Samoa', 'ASM'),
       (5, 'AD', 'ANDORRA', 'Andorra', 'AND'),
       (6, 'AO', 'ANGOLA', 'Angola', 'AGO'),
       (7, 'AI', 'ANGUILLA', 'Anguilla', 'AIA'),
       (8, 'AQ', 'ANTARCTICA', 'Antarctica', NULL),
       (9, 'AG', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', 'ATG'),
       (10, 'AR', 'ARGENTINA', 'Argentina', 'ARG'),
       (11, 'AM', 'ARMENIA', 'Armenia', 'ARM'),
       (12, 'AW', 'ARUBA', 'Aruba', 'ABW'),
       (13, 'AU', 'AUSTRALIA', 'Australia', 'AUS'),
       (14, 'AT', 'AUSTRIA', 'Austria', 'AUT'),
       (15, 'AZ', 'AZERBAIJAN', 'Azerbaijan', 'AZE'),
       (16, 'BS', 'BAHAMAS', 'Bahamas', 'BHS'),
       (17, 'BH', 'BAHRAIN', 'Bahrain', 'BHR'),
       (18, 'BD', 'BANGLADESH', 'Bangladesh', 'BGD'),
       (19, 'BB', 'BARBADOS', 'Barbados', 'BRB'),
       (20, 'BY', 'BELARUS', 'Belarus', 'BLR'),
       (21, 'BE', 'BELGIUM', 'Belgium', 'BEL'),
       (22, 'BZ', 'BELIZE', 'Belize', 'BLZ'),
       (23, 'BJ', 'BENIN', 'Benin', 'BEN'),
       (24, 'BM', 'BERMUDA', 'Bermuda', 'BMU'),
       (25, 'BT', 'BHUTAN', 'Bhutan', 'BTN'),
       (26, 'BO', 'BOLIVIA', 'Bolivia', 'BOL'),
       (27, 'BA', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', 'BIH'),
       (28, 'BW', 'BOTSWANA', 'Botswana', 'BWA'),
       (29, 'BV', 'BOUVET ISLAND', 'Bouvet Island', NULL),
       (30, 'BR', 'BRAZIL', 'Brazil', 'BRA'),
       (31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', NULL),
       (32, 'BN', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', 'BRN'),
       (33, 'BG', 'BULGARIA', 'Bulgaria', 'BGR'),
       (34, 'BF', 'BURKINA FASO', 'Burkina Faso', 'BFA'),
       (35, 'BI', 'BURUNDI', 'Burundi', 'BDI'),
       (36, 'KH', 'CAMBODIA', 'Cambodia', 'KHM'),
       (37, 'CM', 'CAMEROON', 'Cameroon', 'CMR'),
       (38, 'CA', 'CANADA', 'Canada', 'CAN'),
       (39, 'CV', 'CAPE VERDE', 'Cape Verde', 'CPV'),
       (40, 'KY', 'CAYMAN ISLANDS', 'Cayman Islands', 'CYM'),
       (41, 'CF', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', 'CAF'),
       (42, 'TD', 'CHAD', 'Chad', 'TCD'),
       (43, 'CL', 'CHILE', 'Chile', 'CHL'),
       (44, 'CN', 'CHINA', 'China', 'CHN'),
       (45, 'CX', 'CHRISTMAS ISLAND', 'Christmas Island', NULL),
       (46, 'CC', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', NULL),
       (47, 'CO', 'COLOMBIA', 'Colombia', 'COL'),
       (48, 'KM', 'COMOROS', 'Comoros', 'COM'),
       (49, 'CG', 'CONGO', 'Congo', 'COG'),
       (50, 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'Congo, the Democratic Republic of the', 'COD'),
       (51, 'CK', 'COOK ISLANDS', 'Cook Islands', 'COK'),
       (52, 'CR', 'COSTA RICA', 'Costa Rica', 'CRI'),
       (53, 'CI', 'COTE D\'IVOIRE', 'Cote D\'Ivoire', 'CIV'),
       (54, 'HR', 'CROATIA', 'Croatia', 'HRV'),
       (55, 'CU', 'CUBA', 'Cuba', 'CUB'),
       (56, 'CY', 'CYPRUS', 'Cyprus', 'CYP'),
       (57, 'CZ', 'CZECH REPUBLIC', 'Czech Republic', 'CZE'),
       (58, 'DK', 'DENMARK', 'Denmark', 'DNK'),
       (59, 'DJ', 'DJIBOUTI', 'Djibouti', 'DJI'),
       (60, 'DM', 'DOMINICA', 'Dominica', 'DMA'),
       (61, 'DO', 'DOMINICAN REPUBLIC', 'Dominican Republic', 'DOM'),
       (62, 'EC', 'ECUADOR', 'Ecuador', 'ECU'),
       (63, 'EG', 'EGYPT', 'Egypt', 'EGY'),
       (64, 'SV', 'EL SALVADOR', 'El Salvador', 'SLV'),
       (65, 'GQ', 'EQUATORIAL GUINEA', 'Equatorial Guinea', 'GNQ'),
       (66, 'ER', 'ERITREA', 'Eritrea', 'ERI'),
       (67, 'EE', 'ESTONIA', 'Estonia', 'EST'),
       (68, 'ET', 'ETHIOPIA', 'Ethiopia', 'ETH'),
       (69, 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', 'FLK'),
       (70, 'FO', 'FAROE ISLANDS', 'Faroe Islands', 'FRO'),
       (71, 'FJ', 'FIJI', 'Fiji', 'FJI'),
       (72, 'FI', 'FINLAND', 'Finland', 'FIN'),
       (73, 'FR', 'FRANCE', 'France', 'FRA'),
       (74, 'GF', 'FRENCH GUIANA', 'French Guiana', 'GUF'),
       (75, 'PF', 'FRENCH POLYNESIA', 'French Polynesia', 'PYF'),
       (76, 'TF', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', NULL),
       (77, 'GA', 'GABON', 'Gabon', 'GAB'),
       (78, 'GM', 'GAMBIA', 'Gambia', 'GMB'),
       (79, 'GE', 'GEORGIA', 'Georgia', 'GEO'),
       (80, 'DE', 'GERMANY', 'Germany', 'DEU'),
       (81, 'GH', 'GHANA', 'Ghana', 'GHA'),
       (82, 'GI', 'GIBRALTAR', 'Gibraltar', 'GIB'),
       (83, 'GR', 'GREECE', 'Greece', 'GRC'),
       (84, 'GL', 'GREENLAND', 'Greenland', 'GRL'),
       (85, 'GD', 'GRENADA', 'Grenada', 'GRD'),
       (86, 'GP', 'GUADELOUPE', 'Guadeloupe', 'GLP'),
       (87, 'GU', 'GUAM', 'Guam', 'GUM'),
       (88, 'GT', 'GUATEMALA', 'Guatemala', 'GTM'),
       (89, 'GN', 'GUINEA', 'Guinea', 'GIN'),
       (90, 'GW', 'GUINEA-BISSAU', 'Guinea-Bissau', 'GNB'),
       (91, 'GY', 'GUYANA', 'Guyana', 'GUY'),
       (92, 'HT', 'HAITI', 'Haiti', 'HTI'),
       (93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island and Mcdonald Islands', NULL),
       (94, 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', 'VAT'),
       (95, 'HN', 'HONDURAS', 'Honduras', 'HND'),
       (96, 'HK', 'HONG KONG', 'Hong Kong', 'HKG'),
       (97, 'HU', 'HUNGARY', 'Hungary', 'HUN'),
       (98, 'IS', 'ICELAND', 'Iceland', 'ISL'),
       (99, 'IN', 'INDIA', 'India', 'IND'),
       (100, 'ID', 'INDONESIA', 'Indonesia', 'IDN'),
       (101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', 'IRN'),
       (102, 'IQ', 'IRAQ', 'Iraq', 'IRQ'),
       (103, 'IE', 'IRELAND', 'Ireland', 'IRL'),
       (104, 'IL', 'ISRAEL', 'Israel', 'ISR'),
       (105, 'IT', 'ITALY', 'Italy', 'ITA'),
       (106, 'JM', 'JAMAICA', 'Jamaica', 'JAM'),
       (107, 'JP', 'JAPAN', 'Japan', 'JPN'),
       (108, 'JO', 'JORDAN', 'Jordan', 'JOR'),
       (109, 'KZ', 'KAZAKHSTAN', 'Kazakhstan', 'KAZ'),
       (110, 'KE', 'KENYA', 'Kenya', 'KEN'),
       (111, 'KI', 'KIRIBATI', 'Kiribati', 'KIR'),
       (112, 'KP', 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF', 'Korea, Democratic People\'s Republic of', 'PRK'),
       (113, 'KR', 'KOREA, REPUBLIC OF', 'Korea, Republic of', 'KOR'),
       (114, 'KW', 'KUWAIT', 'Kuwait', 'KWT'),
       (115, 'KG', 'KYRGYZSTAN', 'Kyrgyzstan', 'KGZ'),
       (116, 'LA', 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', 'Lao People\'s Democratic Republic', 'LAO'),
       (117, 'LV', 'LATVIA', 'Latvia', 'LVA'),
       (118, 'LB', 'LEBANON', 'Lebanon', 'LBN'),
       (119, 'LS', 'LESOTHO', 'Lesotho', 'LSO'),
       (120, 'LR', 'LIBERIA', 'Liberia', 'LBR'),
       (121, 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'Libyan Arab Jamahiriya', 'LBY'),
       (122, 'LI', 'LIECHTENSTEIN', 'Liechtenstein', 'LIE'),
       (123, 'LT', 'LITHUANIA', 'Lithuania', 'LTU'),
       (124, 'LU', 'LUXEMBOURG', 'Luxembourg', 'LUX'),
       (125, 'MO', 'MACAO', 'Macao', 'MAC'),
       (126, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'Macedonia, the Former Yugoslav Republic of', 'MKD'),
       (127, 'MG', 'MADAGASCAR', 'Madagascar', 'MDG'),
       (128, 'MW', 'MALAWI', 'Malawi', 'MWI'),
       (129, 'MY', 'MALAYSIA', 'Malaysia', 'MYS'),
       (130, 'MV', 'MALDIVES', 'Maldives', 'MDV'),
       (131, 'ML', 'MALI', 'Mali', 'MLI'),
       (132, 'MT', 'MALTA', 'Malta', 'MLT'),
       (133, 'MH', 'MARSHALL ISLANDS', 'Marshall Islands', 'MHL'),
       (134, 'MQ', 'MARTINIQUE', 'Martinique', 'MTQ'),
       (135, 'MR', 'MAURITANIA', 'Mauritania', 'MRT'),
       (136, 'MU', 'MAURITIUS', 'Mauritius', 'MUS'),
       (137, 'YT', 'MAYOTTE', 'Mayotte', NULL),
       (138, 'MX', 'MEXICO', 'Mexico', 'MEX'),
       (139, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', 'FSM'),
       (140, 'MD', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', 'MDA'),
       (141, 'MC', 'MONACO', 'Monaco', 'MCO'),
       (142, 'MN', 'MONGOLIA', 'Mongolia', 'MNG'),
       (143, 'MS', 'MONTSERRAT', 'Montserrat', 'MSR'),
       (144, 'MA', 'MOROCCO', 'Morocco', 'MAR'),
       (145, 'MZ', 'MOZAMBIQUE', 'Mozambique', 'MOZ'),
       (146, 'MM', 'MYANMAR', 'Myanmar', 'MMR'),
       (147, 'NA', 'NAMIBIA', 'Namibia', 'NAM'),
       (148, 'NR', 'NAURU', 'Nauru', 'NRU'),
       (149, 'NP', 'NEPAL', 'Nepal', 'NPL'),
       (150, 'NL', 'NETHERLANDS', 'Netherlands', 'NLD'),
       (151, 'AN', 'NETHERLANDS ANTILLES', 'Netherlands Antilles', 'ANT'),
       (152, 'NC', 'NEW CALEDONIA', 'New Caledonia', 'NCL'),
       (153, 'NZ', 'NEW ZEALAND', 'New Zealand', 'NZL'),
       (154, 'NI', 'NICARAGUA', 'Nicaragua', 'NIC'),
       (155, 'NE', 'NIGER', 'Niger', 'NER'),
       (156, 'NG', 'NIGERIA', 'Nigeria', 'NGA'),
       (157, 'NU', 'NIUE', 'Niue', 'NIU'),
       (158, 'NF', 'NORFOLK ISLAND', 'Norfolk Island', 'NFK'),
       (159, 'MP', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', 'MNP'),
       (160, 'NO', 'NORWAY', 'Norway', 'NOR'),
       (161, 'OM', 'OMAN', 'Oman', 'OMN'),
       (162, 'PK', 'PAKISTAN', 'Pakistan', 'PAK'),
       (163, 'PW', 'PALAU', 'Palau', 'PLW'),
       (164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', NULL),
       (165, 'PA', 'PANAMA', 'Panama', 'PAN'),
       (166, 'PG', 'PAPUA NEW GUINEA', 'Papua New Guinea', 'PNG'),
       (167, 'PY', 'PARAGUAY', 'Paraguay', 'PRY'),
       (168, 'PE', 'PERU', 'Peru', 'PER'),
       (169, 'PH', 'PHILIPPINES', 'Philippines', 'PHL'),
       (170, 'PN', 'PITCAIRN', 'Pitcairn', 'PCN'),
       (171, 'PL', 'POLAND', 'Poland', 'POL'),
       (172, 'PT', 'PORTUGAL', 'Portugal', 'PRT'),
       (173, 'PR', 'PUERTO RICO', 'Puerto Rico', 'PRI'),
       (174, 'QA', 'QATAR', 'Qatar', 'QAT'),
       (175, 'RE', 'REUNION', 'Reunion', 'REU'),
       (176, 'RO', 'ROMANIA', 'Romania', 'ROM'),
       (177, 'RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS'),
       (178, 'RW', 'RWANDA', 'Rwanda', 'RWA'),
       (179, 'SH', 'SAINT HELENA', 'Saint Helena', 'SHN'),
       (180, 'KN', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', 'KNA'),
       (181, 'LC', 'SAINT LUCIA', 'Saint Lucia', 'LCA'),
       (182, 'PM', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', 'SPM'),
       (183, 'VC', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', 'VCT'),
       (184, 'WS', 'SAMOA', 'Samoa', 'WSM'),
       (185, 'SM', 'SAN MARINO', 'San Marino', 'SMR'),
       (186, 'ST', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', 'STP'),
       (187, 'SA', 'SAUDI ARABIA', 'Saudi Arabia', 'SAU'),
       (188, 'SN', 'SENEGAL', 'Senegal', 'SEN'),
       (189, 'CS', 'SERBIA AND MONTENEGRO', 'Serbia and Montenegro', NULL),
       (190, 'SC', 'SEYCHELLES', 'Seychelles', 'SYC'),
       (191, 'SL', 'SIERRA LEONE', 'Sierra Leone', 'SLE'),
       (192, 'SG', 'SINGAPORE', 'Singapore', 'SGP'),
       (193, 'SK', 'SLOVAKIA', 'Slovakia', 'SVK'),
       (194, 'SI', 'SLOVENIA', 'Slovenia', 'SVN'),
       (195, 'SB', 'SOLOMON ISLANDS', 'Solomon Islands', 'SLB'),
       (196, 'SO', 'SOMALIA', 'Somalia', 'SOM'),
       (197, 'ZA', 'SOUTH AFRICA', 'South Africa', 'ZAF'),
       (198, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands',
        NULL),
       (199, 'ES', 'SPAIN', 'Spain', 'ESP'),
       (200, 'LK', 'SRI LANKA', 'Sri Lanka', 'LKA'),
       (201, 'SD', 'SUDAN', 'Sudan', 'SDN'),
       (202, 'SR', 'SURINAME', 'Suriname', 'SUR'),
       (203, 'SJ', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', 'SJM'),
       (204, 'SZ', 'SWAZILAND', 'Swaziland', 'SWZ'),
       (205, 'SE', 'SWEDEN', 'Sweden', 'SWE'),
       (206, 'CH', 'SWITZERLAND', 'Switzerland', 'CHE'),
       (207, 'SY', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', 'SYR'),
       (208, 'TW', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', 'TWN'),
       (209, 'TJ', 'TAJIKISTAN', 'Tajikistan', 'TJK'),
       (210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', 'TZA'),
       (211, 'TH', 'THAILAND', 'Thailand', 'THA'),
       (212, 'TL', 'TIMOR-LESTE', 'Timor-Leste', NULL),
       (213, 'TG', 'TOGO', 'Togo', 'TGO'),
       (214, 'TK', 'TOKELAU', 'Tokelau', 'TKL'),
       (215, 'TO', 'TONGA', 'Tonga', 'TON'),
       (216, 'TT', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', 'TTO'),
       (217, 'TN', 'TUNISIA', 'Tunisia', 'TUN'),
       (218, 'TR', 'TURKEY', 'Turkey', 'TUR'),
       (219, 'TM', 'TURKMENISTAN', 'Turkmenistan', 'TKM'),
       (220, 'TC', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', 'TCA'),
       (221, 'TV', 'TUVALU', 'Tuvalu', 'TUV'),
       (222, 'UG', 'UGANDA', 'Uganda', 'UGA'),
       (223, 'UA', 'UKRAINE', 'Ukraine', 'UKR'),
       (224, 'AE', 'UNITED ARAB EMIRATES', 'United Arab Emirates', 'ARE'),
       (225, 'GB', 'UNITED KINGDOM', 'United Kingdom', 'GBR'),
       (226, 'US', 'UNITED STATES', 'United States', 'USA'),
       (227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', NULL),
       (228, 'UY', 'URUGUAY', 'Uruguay', 'URY'),
       (229, 'UZ', 'UZBEKISTAN', 'Uzbekistan', 'UZB'),
       (230, 'VU', 'VANUATU', 'Vanuatu', 'VUT'),
       (231, 'VE', 'VENEZUELA', 'Venezuela', 'VEN'),
       (232, 'VN', 'VIET NAM', 'Viet Nam', 'VNM'),
       (233, 'VG', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', 'VGB'),
       (234, 'VI', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.s.', 'VIR'),
       (235, 'WF', 'WALLIS AND FUTUNA', 'Wallis and Futuna', 'WLF'),
       (236, 'EH', 'WESTERN SAHARA', 'Western Sahara', 'ESH'),
       (237, 'YE', 'YEMEN', 'Yemen', 'YEM'),
       (238, 'ZM', 'ZAMBIA', 'Zambia', 'ZMB'),
       (239, 'ZW', 'ZIMBABWE', 'Zimbabwe', 'ZWE');

--
-- Déchargement des données de la table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `email`, `phone`, `country`, `city`, `postal_code`,
                        `way_number`, `way_type`, `way_name`, `create_time`, `last_modified`, `enabled`, `added_by`)
VALUES (2, 'pro', 'ste', 'b.1@G.c', '0708090909', 'FR', 'Rennes', '35000', 107, 'Avenue', 'Artisitde Briand',
        '2022-06-11 22:54:56', '2022-06-11 22:55:08', 1, 10),
       (3, 'Chauveau', 'Manu', 'mau@manu.fr', '0707070707', 'France', 'Saint Malo', '', 123, 'xxx', 'xxx',
        '2022-06-11 22:55:00', '2022-06-11 22:55:10', 1, 10),
       (4, 'la fripouille', 'toto', 'toto@toto.com', '0609109109', 'US', 'New York', '12380', 1, 'sq', 'Time',
        '2022-06-11 22:55:03', '2022-06-11 22:55:13', 1, 10),
       (5, '\'; TRUNCATE *;', '<%php alert(‘Executed\');%>', 'titi@titi.com', '0909090909', 'France', 'Rennes', '35000',
        120, 'Avenue', 'des poneys', '2022-06-11 22:55:04', '2022-06-11 22:55:15', 1, 10),
       (6, 'helix', 'mastaz', 'helixmastaz@gmail.com', '6666666666', 'ANY', 'ANY', '000000', 18, 'Vallée',
        'des hackerzz', '2022-06-11 23:00:02', '2022-06-11 23:00:01', 1, 12);

--
-- Déchargement des données de la table `customer_has_order`
--

INSERT INTO `customer_has_order` (`customer_id`, `order_id`)
VALUES (4, 1),
       (4, 2),
       (4, 3),
       (4, 4),
       (4, 5),
       (4, 6),
       (4, 7),
       (4, 8),
       (4, 9),
       (4, 10),
       (4, 11),
       (4, 12),
       (4, 13),
       (4, 14),
       (4, 15),
       (4, 16),
       (4, 17),
       (4, 18),
       (4, 19),
       (4, 20),
       (4, 21),
       (4, 22),
       (4, 23),
       (4, 24),
       (4, 25),
       (3, 26),
       (5, 27),
       (6, 28),
       (5, 29),
       (3, 30),
       (5, 31),
       (4, 32),
       (5, 33),
       (5, 34);

--
-- Déchargement des données de la table `order_`
--

INSERT INTO `order_` (`order_id`, `date_created`, `customer_id`, `TVA`, `prix_ttc`, `status_id`, `date_modified`)
VALUES (1, '2022-06-10 17:05:25', 2, 81.33, 488.00, 1, '2022-06-10 17:13:33'),
       (2, '2022-06-10 17:05:25', 4, 187.17, 1123.01, 1, '2022-06-10 17:13:33'),
       (3, '2022-06-10 17:05:25', 3, 291.67, 1750.00, 1, '2022-06-10 17:13:33'),
       (4, '2022-06-10 17:05:25', 4, 20.04, 120.23, 1, '2022-06-10 17:13:33'),
       (5, '2022-06-10 17:05:25', 4, 100.49, 602.92, 1, '2022-06-10 17:13:33'),
       (6, '2022-06-10 17:05:25', 2, 60.12, 360.69, 1, '2022-06-10 17:13:33'),
       (7, '2022-06-10 17:05:25', 2, 98.70, 592.23, 1, '2022-06-10 17:13:33'),
       (8, '2022-06-10 17:05:25', 3, 80.30, 481.79, 1, '2022-06-10 17:13:33'),
       (9, '2022-06-10 17:05:25', 4, 136.70, 820.23, 1, '2022-06-10 17:13:33'),
       (10, '2022-06-10 17:05:25', 4, 20.04, 120.23, 1, '2022-06-10 17:13:33'),
       (11, '2022-06-10 17:05:25', 3, 20.04, 120.23, 1, '2022-06-10 17:13:33'),
       (12, '2022-06-10 17:05:25', 5, 50.17, 301.01, 1, '2022-06-10 17:13:33'),
       (13, '2022-06-10 17:05:25', 4, 40.08, 240.46, 1, '2022-06-10 17:13:33'),
       (14, '2022-06-10 17:05:25', 5, 60.41, 362.46, 1, '2022-06-10 17:13:33'),
       (15, '2022-06-10 17:05:25', 3, 160.31, 961.84, 1, '2022-06-10 17:13:33'),
       (16, '2022-06-10 17:05:25', 4, 122.00, 732.00, 1, '2022-06-10 17:13:33'),
       (17, '2022-06-14 06:13:51', 3, 120.46, 360.69, 1, '2022-06-11 22:20:50'),
       (18, '2022-06-14 06:13:51', 2, 197.94, 845.15, 1, '2022-06-12 13:43:29'),
       (19, '2022-06-14 06:13:51', 4, 878.81, 4394.03, 1, '2022-06-12 15:45:09'),
       (20, '2022-06-14 06:13:51', 5, 295.27, 1265.46, 1, '2022-06-13 23:38:17'),
       (21, '2022-06-13 23:39:00', 6, 30.13, 180.78, 1, '2022-06-13 23:39:00'),
       (22, '2022-06-14 06:21:18', 3, 317.93, 1907.58, 1, '2022-06-14 06:21:18'),
       (23, '2022-06-14 10:45:46', 6, 60.26, 361.56, 1, '2022-06-14 10:45:46'),
       (24, '2022-06-14 11:03:44', 5, 40.08, 240.46, 1, '2022-06-14 11:03:44'),
       (25, '2022-06-14 11:05:47', 4, 20.33, 122.00, 1, '2022-06-14 11:05:47'),
       (26, '2022-06-14 20:01:50', 3, 101.37, 608.23, 1, '2022-06-14 20:01:50'),
       (27, '2022-06-14 20:17:55', 5, 150.65, 903.90, 1, '2022-06-14 20:17:55'),
       (28, '2022-06-14 20:34:14', 6, 100.19, 601.15, 1, '2022-06-14 20:34:14'),
       (29, '2022-06-14 20:34:27', 5, 270.88, 1625.28, 1, '2022-06-14 20:34:27'),
       (30, '2022-06-14 20:34:34', 3, 80.15, 480.92, 1, '2022-06-14 20:34:34'),
       (31, '2022-06-14 21:36:37', 5, 327.88, 1967.26, 1, '2022-06-14 21:36:37'),
       (32, '2022-06-14 21:36:55', 4, 60.11, 360.69, 1, '2022-06-14 21:36:55'),
       (33, '2022-06-14 22:01:36', 5, 60.11, 360.69, 1, '2022-06-14 22:01:36'),
       (34, '2022-06-14 22:47:45', 5, 80.15, 480.92, 1, '2022-06-14 22:47:45'),
       (35, '2022-06-10 17:05:25', 2, 81.33, 488.00, 1, '2022-06-10 17:13:33'),
       (36, '2022-06-10 17:05:25', 4, 187.17, 1123.01, 1, '2022-06-10 17:13:33'),
       (37, '2022-06-10 17:05:25', 3, 291.67, 1750.00, 1, '2022-06-10 17:13:33'),
       (38, '2022-06-10 17:05:25', 4, 20.04, 120.23, 1, '2022-06-10 17:13:33'),
       (39, '2022-06-10 17:05:25', 4, 100.49, 602.92, 1, '2022-06-10 17:13:33'),
       (40, '2022-06-10 17:05:25', 2, 60.12, 360.69, 1, '2022-06-10 17:13:33'),
       (41, '2022-06-10 17:05:25', 2, 98.70, 592.23, 1, '2022-06-10 17:13:33'),
       (42, '2022-06-10 17:05:25', 3, 80.30, 481.79, 1, '2022-06-10 17:13:33'),
       (43, '2022-06-10 17:05:25', 4, 136.70, 820.23, 1, '2022-06-10 17:13:33'),
       (44, '2022-06-10 17:05:25', 4, 20.04, 120.23, 1, '2022-06-10 17:13:33'),
       (45, '2022-06-10 17:05:25', 3, 20.04, 120.23, 1, '2022-06-10 17:13:33'),
       (46, '2022-06-10 17:05:25', 5, 50.17, 301.01, 1, '2022-06-10 17:13:33'),
       (47, '2022-06-10 17:05:25', 4, 40.08, 240.46, 1, '2022-06-10 17:13:33'),
       (48, '2022-06-10 17:05:25', 5, 60.41, 362.46, 1, '2022-06-10 17:13:33'),
       (49, '2022-06-10 17:05:25', 3, 160.31, 961.84, 1, '2022-06-10 17:13:33'),
       (50, '2022-06-10 17:05:25', 4, 122.00, 732.00, 1, '2022-06-10 17:13:33'),
       (51, '2022-06-14 06:13:51', 3, 120.46, 360.69, 1, '2022-06-11 22:20:50'),
       (52, '2022-06-14 06:13:51', 2, 197.94, 845.15, 1, '2022-06-12 13:43:29'),
       (53, '2022-06-14 06:13:51', 4, 878.81, 4394.03, 1, '2022-06-12 15:45:09'),
       (54, '2022-06-14 06:13:51', 5, 295.27, 1265.46, 1, '2022-06-13 23:38:17'),
       (55, '2022-06-13 23:39:00', 6, 30.13, 180.78, 1, '2022-06-13 23:39:00'),
       (56, '2022-06-14 06:21:18', 3, 317.93, 1907.58, 1, '2022-06-14 06:21:18'),
       (57, '2022-06-14 10:45:46', 6, 60.26, 361.56, 1, '2022-06-14 10:45:46'),
       (58, '2022-06-14 11:03:44', 5, 40.08, 240.46, 1, '2022-06-14 11:03:44'),
       (59, '2022-06-14 11:05:47', 4, 20.33, 122.00, 1, '2022-06-14 11:05:47'),
       (60, '2022-06-14 20:01:50', 3, 101.37, 608.23, 1, '2022-06-14 20:01:50'),
       (61, '2022-06-14 20:17:55', 5, 150.65, 903.90, 1, '2022-06-14 20:17:55'),
       (62, '2022-06-14 20:34:14', 6, 100.19, 601.15, 1, '2022-06-14 20:34:14'),
       (63, '2022-06-14 20:34:27', 5, 270.88, 1625.28, 1, '2022-06-14 20:34:27'),
       (64, '2022-06-14 20:34:34', 3, 80.15, 480.92, 1, '2022-06-14 20:34:34'),
       (65, '2022-06-14 21:36:37', 5, 327.88, 1967.26, 1, '2022-06-14 21:36:37'),
       (66, '2022-06-14 21:36:55', 4, 60.11, 360.69, 1, '2022-06-14 21:36:55'),
       (67, '2022-06-14 22:01:36', 5, 60.11, 360.69, 1, '2022-06-14 22:01:36'),
       (68, '2022-06-14 22:47:45', 5, 80.15, 480.92, 1, '2022-06-14 22:47:45');

--
-- Déchargement des données de la table `order_has_article`
--

INSERT INTO `order_has_article` (`order_id`, `article_id`)
VALUES (1, 4),
       (1, 4),
       (1, 4),
       (1, 4),
       (2, 4),
       (2, 3),
       (2, 3),
       (2, 1),
       (2, 2),
       (3, 3),
       (3, 3),
       (3, 3),
       (3, 3),
       (3, 3),
       (4, 1),
       (5, 4),
       (5, 1),
       (5, 1),
       (5, 1),
       (5, 1),
       (6, 1),
       (6, 1),
       (6, 1),
       (7, 3),
       (7, 4),
       (7, 1),
       (8, 1),
       (8, 2),
       (8, 2),
       (9, 1),
       (9, 3),
       (9, 3),
       (10, 1),
       (11, 1),
       (12, 1),
       (12, 2),
       (13, 1),
       (13, 1),
       (14, 1),
       (14, 1),
       (14, 4),
       (15, 1),
       (15, 1),
       (15, 1),
       (15, 1),
       (15, 1),
       (15, 1),
       (15, 1),
       (15, 1),
       (16, 4),
       (16, 4),
       (16, 4),
       (16, 4),
       (16, 4),
       (16, 4),
       (17, 1),
       (17, 1),
       (17, 1),
       (18, 4),
       (18, 4),
       (18, 1),
       (18, 1),
       (18, 1),
       (18, 1),
       (18, 1),
       (19, 2),
       (19, 2),
       (19, 2),
       (19, 2),
       (19, 1),
       (19, 4),
       (19, 4),
       (19, 4),
       (19, 3),
       (19, 3),
       (19, 3),
       (19, 2),
       (19, 2),
       (19, 2),
       (19, 2),
       (19, 2),
       (19, 2),
       (19, 3),
       (19, 3),
       (19, 3),
       (20, 2),
       (20, 2),
       (20, 2),
       (20, 2),
       (20, 2),
       (20, 2),
       (20, 2),
       (21, 2),
       (22, 2),
       (22, 2),
       (22, 1),
       (22, 1),
       (22, 4),
       (22, 4),
       (22, 3),
       (22, 3),
       (22, 2),
       (22, 2),
       (23, 2),
       (23, 2),
       (24, 1),
       (24, 1),
       (25, 4),
       (26, 1),
       (26, 4),
       (26, 4),
       (26, 4),
       (26, 4),
       (27, 2),
       (27, 2),
       (27, 2),
       (27, 2),
       (27, 2),
       (28, 1),
       (28, 1),
       (28, 1),
       (28, 1),
       (28, 1),
       (29, 1),
       (29, 1),
       (29, 1),
       (29, 1),
       (29, 1),
       (29, 1),
       (29, 2),
       (29, 2),
       (29, 2),
       (29, 2),
       (29, 2),
       (30, 1),
       (30, 1),
       (30, 1),
       (30, 1),
       (31, 1),
       (31, 1),
       (31, 1),
       (31, 1),
       (31, 2),
       (31, 2),
       (31, 2),
       (31, 3),
       (31, 3),
       (31, 4),
       (31, 4),
       (32, 1),
       (32, 1),
       (32, 1),
       (33, 1),
       (33, 1),
       (33, 1),
       (34, 1),
       (34, 1),
       (34, 1),
       (34, 1);

--
-- Déchargement des données de la table `order_has_status`
--

INSERT INTO `order_has_status` (`order_id`, `status_id`, `date`)
VALUES (1, 1, '2022-06-14 18:44:25'),
       (2, 1, '2022-06-14 18:44:25'),
       (3, 1, '2022-06-14 18:44:25'),
       (4, 1, '2022-06-14 18:44:25'),
       (5, 1, '2022-06-14 18:44:25'),
       (6, 1, '2022-06-14 18:44:25'),
       (7, 1, '2022-06-14 18:44:25'),
       (8, 1, '2022-06-14 18:44:25'),
       (9, 1, '2022-06-14 18:44:25'),
       (10, 1, '2022-06-14 18:44:25'),
       (11, 1, '2022-06-14 18:44:25'),
       (12, 1, '2022-06-14 18:44:25'),
       (13, 1, '2022-06-14 18:44:25'),
       (14, 1, '2022-06-14 18:44:25'),
       (15, 1, '2022-06-14 18:44:25'),
       (16, 1, '2022-06-14 18:44:25'),
       (17, 1, '2022-06-14 18:44:25'),
       (18, 1, '2022-06-14 18:44:25'),
       (19, 1, '2022-06-14 18:44:25'),
       (20, 1, '2022-06-14 18:44:25'),
       (21, 1, '2022-06-14 18:44:25'),
       (22, 1, '2022-06-14 18:44:25'),
       (23, 1, '2022-06-14 18:44:25'),
       (24, 1, '2022-06-14 18:44:25'),
       (25, 1, '2022-06-14 18:44:25');

--
-- Déchargement des données de la table `order_status`
--

INSERT INTO `order_status` (`id`, `label`)
VALUES (7, 'annulé'),
       (6, 'cloturé'),
       (3, 'emballé'),
       (4, 'expédié'),
       (1, 'non-acquité'),
       (2, 'payé'),
       (5, 'reçu');

--
-- Déchargement des données de la table `pokemon_properties`
--

INSERT INTO `pokemon_properties` (`prop_id`, `type`, `taille`, `poids`, `Level`, `Exp`, `ATK`, `DEF`, `SPD`, `ATKSPE`,
                                  `DEFSPE`, `PV`, `PP`)
VALUES (1, 'Plante', 0.7, 6904.00, 10, 1, 29, 35, 18, 38, 27, 25, 12),
       (2, 'Plante', 1.0, 13000.00, 30, 2, 49, 82, 29, 57, 58, 130, 27),
       (3, 'Plante', 2.0, 100000.00, 52, 3, 103, 132, 47, 153, 80, 430, 64),
       (6, 'Feu', 0.8, 2112.00, 12, 12, 12, 12, 12, 21, 12, 21, 12);

--
-- Déchargement des données de la table `street_type`
--

INSERT INTO `street_type` (`id`, `label`, `abrev`)
VALUES (5, 'rue', NULL),
       (6, 'avenue', 'av'),
       (7, 'chemin', 'ch'),
       (8, 'boulevard', 'bvd'),
       (9, 'impasse', 'imp'),
       (10, 'allée', 'via'),
       (11, 'street', 'st');

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`user_id`, `email`, `password`, `nickname`, `date_created`, `user_role`)
VALUES (4, 'user', '$2a$10$O6nD1mex5dzDaO3wco6H4e9lB7ZPI7r9j88MEeXCNZNLvRxFwEcmq', 'Regis', '2022-06-14 20:49:32',
        'ROLE_ADMIN'),
       (5, 'user1', '$2a$10$A21hBE6ZrS693m4/sRqddOb6yUS7k8UfvpGklS/RnD4sasGkb.4ce', 'Sacha', '2022-06-14 20:49:32',
        'ROLE_USER'),
       (7, 'user2', '$2a$10$9aTXaqbdMI/jPsIIaZtod.WJsDMrg2ATmoxWKHIDKIP2PLA1yRWwe', 'Ondine', '2022-06-14 20:49:32',
        'ROLE_USER'),
       (8, 'user3', '$2a$10$0sDNBSL.8qOvzis/qwg/Ze5EBBisQi.WDa.W/Vo5d3rCc6eoDXXem', 'Pierre', '2022-06-14 20:49:32',
        'ROLE_USER'),
       (10, 'user5', '$2a$10$mo.CDF9.nOyTFU46uKERquZ5lzS1F5PQxKnAQDMSagE98rp9lOx1i', 'Marcel', '2022-06-14 20:49:32',
        'ROLE_COMM'),
       (12, 'user4', '$2a$10$bC/Buy7PpKVSvgpSpMX/punzR9ixRcIRiXO0C8DUm6yBUb9fEgsgm', 'Geanice', '2022-06-14 20:49:32',
        'ROLE_COMM');

--
-- Déchargement des données de la table `user_has_order`
--

INSERT INTO `user_has_order` (`order_id`, `user_id`)
VALUES (10, 4),
       (11, 4),
       (12, 4),
       (13, 4),
       (14, 4),
       (15, 4),
       (16, 4),
       (17, 4),
       (18, 4),
       (19, 4),
       (20, 4),
       (21, 4),
       (22, 4),
       (23, 4),
       (24, 4),
       (25, 4),
       (26, 4),
       (27, 4),
       (28, 4),
       (29, 4),
       (30, 4),
       (31, 4),
       (32, 4),
       (33, 4),
       (34, 4);

--
-- Déchargement des données de la table `user_role`
--

INSERT INTO `user_role` (`role_id`, `label`)
VALUES (1, 'USER'),
       (2, 'MODERATOR'),
       (3, 'ADMIN'),
       (4, 'COMPTA'),
       (5, 'IT'),
       (6, 'TROUFION'),
       (7, 'RANDOM'),
       (8, 'USER_');

--
-- Déchargement des données de la table `warehouse`
--

INSERT INTO `warehouse` (`warehouse_id`, `label`)
VALUES (1, 'Rennes'),
       (2, 'Tours'),
       (3, 'Paris');

--
-- Déchargement des données de la table `warehouse_has_article`
--

INSERT INTO `warehouse_has_article` (`warehouse_id`, `article_id`)
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (2, 4),
       (3, 3),
       (3, 4);
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
