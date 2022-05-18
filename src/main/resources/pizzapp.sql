-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 18 mai 2022 à 13:57
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Tronquer la table avant d'insérer `ingredients`
--

TRUNCATE TABLE `ingredients`;
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
-- Structure de la table `order_`
--
-- Création : mar. 17 mai 2022 à 22:03
-- Dernière modification : mer. 18 mai 2022 à 07:43
--

DROP TABLE IF EXISTS `order_`;
CREATE TABLE IF NOT EXISTS `order_` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mail` varchar(120) COLLATE utf8_bin NOT NULL,
  `TVA` double NOT NULL,
  `prix_ttc` double NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Tronquer la table avant d'insérer `order_`
--

TRUNCATE TABLE `order_`;
--
-- Déchargement des données de la table `order_`
--

INSERT INTO `order_` (`id`, `mail`, `TVA`, `prix_ttc`, `date`) VALUES
(12, 'gael', 0.94, 17.96, '2022-05-18 10:20:08'),
(13, 'gael', 0.94, 17.96, '2022-05-18 10:28:14'),
(14, 'gael', 0.94, 17.96, '2022-05-18 10:29:00'),
(15, 'gael', 0.94, 17.96, '2022-05-18 10:33:46'),
(16, 'gael', 0.94, 17.96, '2022-05-18 11:20:51'),
(17, 'gael', 0.94, 17.96, '2022-05-18 11:33:17'),
(18, 'gael', 0.94, 17.96, '2022-05-18 11:33:50'),
(19, 'gael', 0.94, 17.96, '2022-05-18 11:40:32'),
(20, 'gael', 0.94, 17.96, '2022-05-18 11:44:32'),
(21, 'gael', 0.94, 17.96, '2022-05-18 11:45:35'),
(22, 'gael', 0.94, 17.96, '2022-05-18 11:46:48'),
(23, 'gael', 0.94, 17.96, '2022-05-18 11:47:54');

-- --------------------------------------------------------

--
-- Structure de la table `order_articles`
--
-- Création : mer. 18 mai 2022 à 09:42
--

DROP TABLE IF EXISTS `order_articles`;
CREATE TABLE IF NOT EXISTS `order_articles` (
  `order_id` int NOT NULL,
  `pizza_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Tronquer la table avant d'insérer `order_articles`
--

TRUNCATE TABLE `order_articles`;
--
-- Déchargement des données de la table `order_articles`
--

INSERT INTO `order_articles` (`order_id`, `pizza_id`) VALUES
(14, 4),
(14, 2),
(15, 4),
(15, 2),
(16, 4),
(16, 2),
(18, 4),
(18, 2),
(19, 4),
(19, 2),
(20, 4),
(20, 2),
(21, 4),
(21, 2),
(22, 4),
(22, 2),
(23, 4),
(23, 2);

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Tronquer la table avant d'insérer `panier`
--

TRUNCATE TABLE `panier`;
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
(11, '2022-05-17T09:10:05.5001671'),
(12, '2022-05-18T09:16:11.5797325'),
(13, '2022-05-18T09:16:12.6625577');

-- --------------------------------------------------------

--
-- Structure de la table `panier_pizza`
--
-- Création : sam. 14 mai 2022 à 18:37
-- Dernière modification : mar. 17 mai 2022 à 19:49
-- Dernière vérification : lun. 16 mai 2022 à 21:13
--

DROP TABLE IF EXISTS `panier_pizza`;
CREATE TABLE IF NOT EXISTS `panier_pizza` (
  `panier_id` int NOT NULL,
  `pizza_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Tronquer la table avant d'insérer `panier_pizza`
--

TRUNCATE TABLE `panier_pizza`;
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
(11, 3),
(10, 3),
(9, 3),
(8, 2),
(7, 1),
(11, 3),
(11, 3),
(11, 1),
(11, 2),
(11, 4),
(12, 2);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Tronquer la table avant d'insérer `pizza`
--

TRUNCATE TABLE `pizza`;
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
-- Tronquer la table avant d'insérer `pizza_ingredient`
--

TRUNCATE TABLE `pizza_ingredient`;
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
-- Tronquer la table avant d'insérer `user`
--

TRUNCATE TABLE `user`;
--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `userRole`) VALUES
(1, 'user', '$2a$10$RDilYQ7Mi8VsN/wV2jmB1O.METkqETxjzLrNMX9s/ebZQHFGhCp2G', 'ROLE_ADMIN'),
(5, 'user2', '$2a$10$uJcfmMWygag4y5Bm2o8I/OgmpYUJldIm6nJtBfadaBJvIpveXA3ba', 'ROLE_USER'),
(8, 'gael', '$2a$10$.fXcSDgRbzZUIk.ZC5td9u.Jxt460Nms6gKnKRY4Kdcz2DarcUbHy', 'ROLE_USER');

-- --------------------------------------------------------

--
-- Structure de la table `user_order`
--
-- Création : mer. 18 mai 2022 à 10:32
--

DROP TABLE IF EXISTS `user_order`;
CREATE TABLE IF NOT EXISTS `user_order` (
  `user_name` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `order_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Tronquer la table avant d'insérer `user_order`
--

TRUNCATE TABLE `user_order`;
--
-- Déchargement des données de la table `user_order`
--

INSERT INTO `user_order` (`user_name`, `order_id`) VALUES
('gael', 23);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
