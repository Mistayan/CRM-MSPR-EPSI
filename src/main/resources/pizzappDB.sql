-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 14 mai 2022 à 13:19
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
-- Structure de la table `ingredients`
--
-- Création : mar. 10 mai 2022 à 07:55
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE IF NOT EXISTS `ingredients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8_bin NOT NULL,
  `label` varchar(50) COLLATE utf8_bin NOT NULL,
  `nb_calories` int NOT NULL,
  `prix` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `ingredients`
--

INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`) VALUES
(1, 'pate', 'pate fine', 120, 3),
(2, 'pate', 'pate épaisse', 130, 3.5),
(3, 'base', 'sauce tomate', 25, 1),
(4, 'base', 'sauce fromage', 230, 1.5),
(5, 'vert', 'roquette', 12, 0.5),
(6, 'vert', 'basilic', 10, 0.5),
(7, 'viande', 'poulet', 80, 1),
(8, 'viande', 'boeuf', 130, 1),
(9, 'viande', 'saucisse', 120, 1.15),
(10, 'fromage', 'mozzarella', 40, 0.3),
(11, 'fromage', 'emmental', 170, 0.3),
(12, 'fromage', 'roquefort', 164, 0.34),
(13, 'viande', 'Jambon', 140, 1.3);

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--
-- Création : jeu. 12 mai 2022 à 14:03
--

DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `panier`
--

INSERT INTO `panier` (`id`, `timestamp`) VALUES
(1, '2022-05-14T11:03:46.2215818');

-- --------------------------------------------------------

--
-- Structure de la table `panier_pizza`
--
-- Création : jeu. 12 mai 2022 à 14:10
-- Dernière modification : sam. 14 mai 2022 à 12:06
--

DROP TABLE IF EXISTS `panier_pizza`;
CREATE TABLE IF NOT EXISTS `panier_pizza` (
  `panier_id` int NOT NULL,
  `pizza_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `panier_pizza`
--

INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`) VALUES
(1, 1),
(1, 3),
(1, 1),
(1, 3),
(1, 1),
(1, 1),
(1, 1),
(1, 1),
(1, 1),
(1, 3),
(1, 1),
(1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `pizza`
--
-- Création : mar. 10 mai 2022 à 08:16
--

DROP TABLE IF EXISTS `pizza`;
CREATE TABLE IF NOT EXISTS `pizza` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `label` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `pizza`
--

INSERT INTO `pizza` (`id`, `label`) VALUES
(1, 'Margharita'),
(2, '4Fromages'),
(3, 'Royale');

-- --------------------------------------------------------

--
-- Structure de la table `pizza_ingredient`
--
-- Création : mar. 10 mai 2022 à 08:16
-- Dernière modification : jeu. 12 mai 2022 à 09:13
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
(3, 10);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--
-- Création : mar. 10 mai 2022 à 13:18
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(60) COLLATE utf8_bin NOT NULL,
  `password` varchar(60) COLLATE utf8_bin NOT NULL,
  `userRole` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'ROLE_USER',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ifx_uq_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='utilisateurs';

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `userRole`) VALUES
(1, 'user', '$2a$10$RDilYQ7Mi8VsN/wV2jmB1O.METkqETxjzLrNMX9s/ebZQHFGhCp2G', 'ROLE_ADMIN'),
(5, 'user2', '$2a$10$uJcfmMWygag4y5Bm2o8I/OgmpYUJldIm6nJtBfadaBJvIpveXA3ba', 'ROLE_USER');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
