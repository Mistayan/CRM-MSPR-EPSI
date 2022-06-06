-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 30 mai 2022 à 14:56
-- Version du serveur : 8.0.27
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `acme`
--
CREATE DATABASE IF NOT EXISTS `acme` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `acme`;

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `code_article` varchar(45) DEFAULT NULL,
  `label` varchar(45) NOT NULL,
  `prix` double NOT NULL,
  `date_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `description` text,
  `category_id` int UNSIGNED NOT NULL,
  `property_id` int NOT NULL,
  PRIMARY KEY (`article_id`),
  KEY `article_article_id_index` (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`article_id`, `code_article`, `label`, `prix`, `date_created`, `description`, `category_id`, `property_id`) VALUES
(1, 'POKE_0001', 'Bulbizarre', 120.23, '2022-05-29 08:34:32', '\'un pokemon de type plante, niveau 10\'', 1, 1),
(2, 'POKE_0002', 'Herbizarre', 180.78, '2022-05-29 08:34:32', '\'un pokemone de type plante, rang2, niveau 30\'', 1, 2),
(3, 'POKE_0003', 'Florizarre', 350, '2022-05-29 08:34:32', '\'un pokemone de type plante, rang3, niveau 52\'', 1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `article_comment`
--

DROP TABLE IF EXISTS `article_comment`;
CREATE TABLE IF NOT EXISTS `article_comment` (
  `comment_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `article_id` int UNSIGNED NOT NULL,
  `article_comment` text NOT NULL,
  `date_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  UNIQUE KEY `id_UNIQUE` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `article_has_category`
--

DROP TABLE IF EXISTS `article_has_category`;
CREATE TABLE IF NOT EXISTS `article_has_category` (
  `article_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  UNIQUE KEY `article_has_category_pk` (`article_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `article_has_props`
--

DROP TABLE IF EXISTS `article_has_props`;
CREATE TABLE IF NOT EXISTS `article_has_props` (
  `article_id` int NOT NULL,
  `property_id` int NOT NULL,
  PRIMARY KEY (`article_id`,`property_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `article_has_props`
--

INSERT INTO `article_has_props` (`article_id`, `property_id`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Structure de la table `cart`
--

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `cart`
--

INSERT INTO `cart` (`cart_id`, `date_created`) VALUES
(1, '2022-05-27 22:29:15'),
(2, '2022-05-27 22:40:23'),
(3, '2022-05-27 22:51:07'),
(4, '2022-05-27 23:10:20'),
(5, '2022-05-27 23:12:17'),
(6, '2022-05-27 23:12:23'),
(7, '2022-05-28 13:04:42'),
(8, '2022-05-28 13:04:49'),
(9, '2022-05-28 13:07:42'),
(10, '2022-05-28 16:45:59'),
(11, '2022-05-28 16:47:42'),
(12, '2022-05-28 16:49:05'),
(13, '2022-05-28 16:51:46'),
(14, '2022-05-28 16:51:48'),
(15, '2022-05-28 16:51:52'),
(16, '2022-05-28 16:52:00'),
(17, '2022-05-28 16:53:12'),
(18, '2022-05-28 19:03:35'),
(19, '2022-05-28 20:19:09'),
(20, '2022-05-28 22:09:52'),
(21, '2022-05-28 22:10:01'),
(22, '2022-05-28 22:22:29'),
(23, '2022-05-29 08:29:09'),
(24, '2022-05-29 11:50:03'),
(25, '2022-05-29 11:50:12'),
(26, '2022-05-29 11:52:12'),
(27, '2022-05-29 11:53:26'),
(28, '2022-05-29 11:54:06'),
(29, '2022-05-29 11:55:13'),
(30, '2022-05-30 08:20:26'),
(31, '2022-05-30 08:20:37'),
(32, '2022-05-30 09:04:07'),
(33, '2022-05-30 09:07:48'),
(34, '2022-05-30 09:08:00'),
(35, '2022-05-30 09:11:25'),
(36, '2022-05-30 09:11:45'),
(37, '2022-05-30 11:44:38'),
(38, '2022-05-30 11:44:45'),
(39, '2022-05-30 12:08:26');

-- --------------------------------------------------------

--
-- Structure de la table `cart_has_article`
--

DROP TABLE IF EXISTS `cart_has_article`;
CREATE TABLE IF NOT EXISTS `cart_has_article` (
  `cart_id` int NOT NULL,
  `article_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `cart_has_article`
--

INSERT INTO `cart_has_article` (`cart_id`, `article_id`) VALUES
(6, 1),
(6, 2),
(6, 3),
(6, 2),
(6, 1),
(6, 1),
(6, 1),
(6, 1),
(6, 2),
(6, 2),
(6, 2),
(6, 3),
(6, 3),
(6, 3),
(6, 3),
(6, 3),
(29, 1);

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int NOT NULL,
  `label` varchar(255) NOT NULL,
  `taxes` double(5,2) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_id_UNIQUE` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`category_id`, `label`, `taxes`) VALUES
(1, 'Pokemons', 20.00),
(2, 'Pokedexs', 17.53),
(3, 'PokeBalls', 16.00),
(4, 'Vitamines', 5.50),
(5, 'Tickets', 12.00);

-- --------------------------------------------------------

--
-- Structure de la table `customer_address`
--

DROP TABLE IF EXISTS `customer_address`;
CREATE TABLE IF NOT EXISTS `customer_address` (
  `user_id` int UNSIGNED NOT NULL,
  `full_address` varchar(150) NOT NULL COMMENT 'obligatoire pour la livraison',
  `country` varchar(45) NOT NULL COMMENT 'obligatoire pour la livraison',
  `address_name` varchar(45) NOT NULL COMMENT 'obligatoire pour la livraison\n',
  `phone_number` varchar(45) DEFAULT NULL COMMENT 'Non obligatoire. Uniquement si l''utilisateur souhaite être contacté par le livreur.',
  `date_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `order_`
--

DROP TABLE IF EXISTS `order_`;
CREATE TABLE IF NOT EXISTS `order_` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int UNSIGNED NOT NULL,
  `TVA` double(10,2) NOT NULL,
  `prix_ttc` double(10,2) NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `order_`
--

INSERT INTO `order_` (`order_id`, `date_created`, `user_id`, `TVA`, `prix_ttc`) VALUES
(3, '2022-05-28 18:29:40', 5, 50.23, 963.58),
(4, '2022-05-28 19:10:56', 5, 54.74, 1050.00),
(5, '2022-05-28 22:13:52', 4, 18.25, 350.00),
(6, '2022-05-28 22:22:37', 4, 9.42, 180.78);

-- --------------------------------------------------------

--
-- Structure de la table `order_has_article`
--

DROP TABLE IF EXISTS `order_has_article`;
CREATE TABLE IF NOT EXISTS `order_has_article` (
  `order_id` int DEFAULT NULL,
  `article_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `order_has_article`
--

INSERT INTO `order_has_article` (`order_id`, `article_id`) VALUES
(3, 1),
(3, 1),
(3, 2),
(3, 2),
(3, 2),
(3, 2),
(4, 3),
(4, 3),
(4, 3),
(5, 3),
(6, 2);

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_properties`
--

DROP TABLE IF EXISTS `pokemon_properties`;
CREATE TABLE IF NOT EXISTS `pokemon_properties` (
  `prop_id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `taille` double(3,1) NOT NULL,
  `poids` double(10,2) NOT NULL,
  `Level` int NOT NULL DEFAULT '1',
  `Exp` int NOT NULL DEFAULT '0',
  `ATK` int NOT NULL,
  `DEF` int NOT NULL,
  `SPD` int NOT NULL,
  `ATKSPE` int NOT NULL,
  `DEFSPE` int NOT NULL,
  `PV` int NOT NULL DEFAULT '0',
  `PP` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`prop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `pokemon_properties`
--

INSERT INTO `pokemon_properties` (`prop_id`, `type`, `taille`, `poids`, `Level`, `Exp`, `ATK`, `DEF`, `SPD`, `ATKSPE`, `DEFSPE`, `PV`, `PP`) VALUES
(1, 'Plante', 0.7, 6900.00, 10, 1, 29, 35, 18, 38, 27, 25, 12),
(2, 'Plante', 1.0, 13000.00, 30, 2, 49, 82, 29, 57, 58, 130, 27),
(3, 'Plante', 2.0, 100000.00, 52, 3, 103, 132, 47, 153, 80, 430, 64);

-- --------------------------------------------------------

--
-- Structure de la table `security_details`
--

DROP TABLE IF EXISTS `security_details`;
CREATE TABLE IF NOT EXISTS `security_details` (
  `user_id` int UNSIGNED NOT NULL,
  `account_locked` binary(1) NOT NULL DEFAULT '0',
  `credentials_expired` binary(1) NOT NULL DEFAULT '0',
  `enabled` binary(1) NOT NULL DEFAULT '1',
  `account_expired` binary(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL,
  `nickname` varchar(45) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_role` varchar(15) NOT NULL DEFAULT 'NOONE',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`user_id`, `email`, `password`, `nickname`, `date_created`, `user_role`) VALUES
(4, 'user', '$2a$10$O6nD1mex5dzDaO3wco6H4e9lB7ZPI7r9j88MEeXCNZNLvRxFwEcmq', NULL, '2022-05-27 23:48:29', 'ROLE_USER'),
(5, 'user1', '$2a$10$A21hBE6ZrS693m4/sRqddOb6yUS7k8UfvpGklS/RnD4sasGkb.4ce', NULL, '2022-05-28 16:56:50', 'ROLE_USER'),
(7, 'user2', '$2a$10$9aTXaqbdMI/jPsIIaZtod.WJsDMrg2ATmoxWKHIDKIP2PLA1yRWwe', NULL, '2022-05-28 17:14:06', 'ROLE_USER'),
(8, 'user3', '$2a$10$0sDNBSL.8qOvzis/qwg/Ze5EBBisQi.WDa.W/Vo5d3rCc6eoDXXem', NULL, '2022-05-28 17:22:11', 'ROLE_USER');

-- --------------------------------------------------------

--
-- Structure de la table `user_has_article_comment`
--

DROP TABLE IF EXISTS `user_has_article_comment`;
CREATE TABLE IF NOT EXISTS `user_has_article_comment` (
  `user_id` int UNSIGNED NOT NULL,
  `article_comment_id` int UNSIGNED NOT NULL,
  PRIMARY KEY (`user_id`,`article_comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `user_has_order`
--

DROP TABLE IF EXISTS `user_has_order`;
CREATE TABLE IF NOT EXISTS `user_has_order` (
  `user_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `user_has_order`
--

INSERT INTO `user_has_order` (`user_id`, `order_id`) VALUES
(5, 3),
(5, 4),
(4, 5),
(4, 6);

-- --------------------------------------------------------

--
-- Structure de la table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE IF NOT EXISTS `user_role` (
  `role_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `label` varchar(10) DEFAULT 'USER',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `id_UNIQUE` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `user_role`
--

INSERT INTO `user_role` (`role_id`, `label`) VALUES
(1, 'USER'),
(2, 'MODERATOR'),
(3, 'ADMIN'),
(4, 'COMPTA'),
(5, 'IT'),
(6, 'TROUFION'),
(7, 'RANDOM'),
(8, 'USER');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
