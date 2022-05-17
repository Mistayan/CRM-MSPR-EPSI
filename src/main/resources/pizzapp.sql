-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 17 mai 2022 à 17:43
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
-- Base de données : `pizzapp`
--
CREATE DATABASE IF NOT EXISTS `pizzapp` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `pizzapp`;

-- --------------------------------------------------------

--
-- Structure de la table `commande_has_article`
--
-- Création : mar. 17 mai 2022 à 07:06
-- Dernière modification : mar. 17 mai 2022 à 07:06
--

DROP TABLE IF EXISTS order_has_article;
CREATE TABLE IF NOT EXISTS `commande_has_article` (
  `commande_id` int DEFAULT NULL,
  `pizza_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Structure de la table `ingredients`
--
-- Création : sam. 14 mai 2022 à 13:32
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE IF NOT EXISTS `ingredients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `label` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `nb_calories` int NOT NULL,
  `prix` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `ingredients`
--

INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`) VALUES
(1, 'pate', 'pate fine', 120, 3),
(2, 'pate', 'pate épaisse', 130, 3.5),
(3, 'base', 'sauce tomate', 25, 1.33),
(4, 'base', 'sauce fromage', 230, 1.5),
(5, 'vert', 'roquette', 12, 0.5),
(6, 'vert', 'basilic', 10, 0.5),
(7, 'viande', 'poulet', 80, 2.22),
(8, 'viande', 'boeuf', 130, 1.35),
(9, 'viande', 'saucisse', 120, 1.15),
(10, 'fromage', 'mozzarella', 40, 0.3),
(11, 'fromage', 'emmental', 170, 0.3),
(12, 'fromage', 'roquefort', 164, 0.34),
(13, 'viande', 'Jambon', 140, 1.3);

-- --------------------------------------------------------

--
-- Structure de la table `order`
--
-- Création : lun. 16 mai 2022 à 22:27
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mail` varchar(120) COLLATE utf8_bin NOT NULL,
  `commande_uuid` varchar(128) COLLATE utf8_bin NOT NULL,
  `TVA` double NOT NULL,
  `prix_ttc` double NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `order`
--

INSERT INTO `order` (`id`, `mail`, `commande_uuid`, `TVA`, `prix_ttc`, `date`) VALUES
(4, 'gael', '{\"pizza\": \"Margharita\",\"prix\": \"5.63\",\"pizza\": \"Margharita\",\"prix\": \"5.63\",\"pizza\": \"4Fromages\",\"prix\": \"4.94\",\"pizza\": \"Marghar', 2.1483886255924176, 41.209999999999994, '2022-05-17 14:33:38'),
(5, 'gael', '{Margharita\",Royale}', 0.7986729857819892, 15.32, '2022-05-17 14:35:31');

-- --------------------------------------------------------

--
-- Structure de la table `order_articles`
--
-- Création : mar. 17 mai 2022 à 17:36
--

DROP TABLE IF EXISTS `order_articles`;
CREATE TABLE IF NOT EXISTS `order_articles` (
  `order_id` int NOT NULL,
  `pizza_id` int NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`,`pizza_id`),
  KEY `idx_order_date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--
-- Création : sam. 14 mai 2022 à 13:32
--

DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `panier`
--

INSERT INTO `panier` (`id`, `timestamp`) VALUES
(1, '2022-05-14T11:03:46.2215818'),
(2, '2022-05-15T22:33:50.9817542'),
(3, '2022-05-15T22:33:55.4647728'),
(4, '2022-05-15T22:33:56.358489'),
(5, '2022-05-15T22:54:46.4045896'),
(6, '2022-05-15T22:54:49.0452248'),
(7, '2022-05-17T09:10:01.0712368'),
(8, '2022-05-17T09:10:01.8199952'),
(9, '2022-05-17T09:10:02.757614'),
(10, '2022-05-17T09:10:04.7295788'),
(11, '2022-05-17T09:10:05.5001671');

-- --------------------------------------------------------

--
-- Structure de la table `panier_pizza`
--
-- Création : sam. 14 mai 2022 à 18:37
-- Dernière modification : dim. 15 mai 2022 à 23:18
--

DROP TABLE IF EXISTS `panier_pizza`;
CREATE TABLE IF NOT EXISTS `panier_pizza` (
  `panier_id` int NOT NULL,
  `pizza_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `panier_pizza`
--

INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`) VALUES
(4, 3),
(3, 3),
(2, 3),
(4, 1),
(4, 1),
(4, 3),
(5, 3),
(6, 1),
(10, 3),
(9, 3),
(8, 2),
(7, 1);

-- --------------------------------------------------------

--
-- Structure de la table `pizza`
--
-- Création : sam. 14 mai 2022 à 13:32
--

DROP TABLE IF EXISTS `pizza`;
CREATE TABLE IF NOT EXISTS `pizza` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `label` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `pizza`
--

INSERT INTO `pizza` (`id`, `label`) VALUES
(1, 'Margharita'),
(2, '4Fromages'),
(3, 'Royale'),
(4, 'BBQ');

-- --------------------------------------------------------

--
-- Structure de la table `pizza_ingredient`
--
-- Création : sam. 14 mai 2022 à 13:32
-- Dernière modification : mar. 17 mai 2022 à 08:01
--

DROP TABLE IF EXISTS `pizza_ingredient`;
CREATE TABLE IF NOT EXISTS `pizza_ingredient` (
  `pizza_id` int UNSIGNED NOT NULL,
  `ingredient_id` int UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `pizza_ingredient`
--

INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`) VALUES
(1, 1),
(1, 3),
(1, 5),
(1, 6),
(1, 10),
(2, 1),
(2, 5),
(2, 6),
(2, 10),
(2, 11),
(2, 12),
(3, 1),
(3, 3),
(3, 9),
(3, 8),
(3, 7),
(3, 12),
(3, 10),
(4, 2),
(4, 3),
(4, 6),
(4, 7),
(4, 7),
(4, 8),
(4, 10),
(4, 11),
(4, 13);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--
-- Création : sam. 14 mai 2022 à 13:32
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `password` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `userRole` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'ROLE_USER',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ifx_uq_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='utilisateurs';

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `userRole`) VALUES
(1, 'user', '$2a$10$RDilYQ7Mi8VsN/wV2jmB1O.METkqETxjzLrNMX9s/ebZQHFGhCp2G', 'ROLE_ADMIN'),
(5, 'user2', '$2a$10$uJcfmMWygag4y5Bm2o8I/OgmpYUJldIm6nJtBfadaBJvIpveXA3ba', 'ROLE_USER'),
(8, 'gael', '$2a$10$.fXcSDgRbzZUIk.ZC5td9u.Jxt460Nms6gKnKRY4Kdcz2DarcUbHy', 'ROLE_USER');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
