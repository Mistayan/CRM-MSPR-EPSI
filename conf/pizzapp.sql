-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 23 mai 2022 à 22:32
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
DROP DATABASE IF EXISTS `pizzapp`;
CREATE DATABASE IF NOT EXISTS `pizzapp` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `pizzapp`;

-- --------------------------------------------------------

--
-- Structure de la table `ingredients`
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

DROP TABLE IF EXISTS `order_`;
CREATE TABLE IF NOT EXISTS `order_` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `TVA` double NOT NULL,
  `prix_ttc` double NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_status` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Tronquer la table avant d'insérer `order_`
--

TRUNCATE TABLE `order_`;
--
-- Déchargement des données de la table `order_`
--

INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`) VALUES
(35, 1, 2.97, 57.019999999999996, '2022-05-23 17:35:06', 1),
(36, 1, 5.8, 111.26000000000002, '2022-05-23 19:02:55', 1),
(37, 8, 3.23, 62.019999999999996, '2022-05-23 19:09:01', 1),
(38, 1, 5.74, 110.15999999999998, '2022-05-23 19:52:32', 1),
(39, 1, 2.92, 55.97999999999999, '2022-05-23 20:08:31', 1),
(40, 1, 2.04, 39.08, '2022-05-23 20:18:37', 1),
(41, 1, 1.82, 34.88, '2022-05-23 20:36:46', 1),
(42, 1, 1.19, 22.900000000000002, '2022-05-23 20:42:27', 1);

-- --------------------------------------------------------

--
-- Structure de la table `order_articles`
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
(35, 4),
(35, 4),
(35, 4),
(35, 4),
(35, 2),
(36, 5),
(36, 5),
(36, 4),
(36, 4),
(36, 5),
(36, 5),
(36, 5),
(36, 5),
(36, 5),
(36, 2),
(36, 5),
(36, 5),
(36, 2),
(36, 2),
(36, 5),
(37, 5),
(37, 5),
(37, 2),
(37, 2),
(37, 1),
(37, 5),
(37, 2),
(37, 2),
(37, 2),
(37, 2),
(37, 1),
(38, 2),
(38, 4),
(38, 4),
(38, 4),
(38, 5),
(38, 5),
(38, 4),
(38, 4),
(38, 4),
(38, 4),
(39, 5),
(39, 4),
(39, 4),
(39, 4),
(39, 2),
(39, 2),
(40, 5),
(40, 5),
(40, 5),
(40, 4),
(40, 2),
(41, 5),
(41, 4),
(41, 2),
(41, 2),
(41, 2),
(42, 2),
(42, 4),
(42, 2);

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--

DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timestamp` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

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
(13, '2022-05-18T09:16:12.6625577'),
(14, '2022-05-18T20:02:47.9942078'),
(15, '2022-05-19T00:39:55.809523'),
(16, '2022-05-19T00:39:58.7045448'),
(17, '2022-05-19T00:39:59.4676783'),
(18, '2022-05-19T00:40:00.2504573'),
(19, '2022-05-19T00:40:05.5673358'),
(20, '2022-05-19T00:40:54.7518117'),
(21, '2022-05-19T09:04:10.6745761'),
(22, '2022-05-19T09:04:11.2767717'),
(23, '2022-05-19T09:04:12.4521956'),
(24, '2022-05-19T09:04:14.0944195'),
(25, '2022-05-19T09:04:15.5746142'),
(26, '2022-05-19T09:04:17.8518178'),
(27, '2022-05-19T09:04:19.6261925'),
(28, '2022-05-19T12:29:40.7759178'),
(29, '2022-05-19T13:37:12.261535'),
(30, '2022-05-19T14:15:39.9223071'),
(31, '2022-05-19T14:42:10.6129765'),
(32, '2022-05-19T15:49:46.3696849'),
(33, '2022-05-19T15:53:50.6810818'),
(34, '2022-05-19T16:12:14.3871649'),
(35, '2022-05-19T16:12:19.5529413'),
(36, '2022-05-20T01:08:02.7351498'),
(37, '2022-05-20T01:08:04.6244878'),
(38, '2022-05-20T01:08:06.1872585'),
(39, '2022-05-20T01:08:06.6645801'),
(40, '2022-05-20T01:08:07.0207222'),
(41, '2022-05-20T01:08:07.5131509'),
(42, '2022-05-20T01:08:08.102466'),
(43, '2022-05-20T01:08:08.5010851'),
(44, '2022-05-20T01:08:08.8988655'),
(45, '2022-05-20T01:08:18.2172944'),
(46, '2022-05-20T01:08:37.9814069'),
(47, '2022-05-20T01:08:39.9663813'),
(48, '2022-05-20T01:14:56.2589892'),
(49, '2022-05-20T01:15:35.8762088'),
(50, '2022-05-23T16:35:47.3452514'),
(51, '2022-05-23T16:35:49.8485835'),
(52, '2022-05-23T16:35:52.4057348'),
(53, '2022-05-23T16:35:53.7469767'),
(54, '2022-05-23T16:36:33.7803608'),
(55, '2022-05-23T16:36:34.5676679'),
(56, '2022-05-23T16:36:36.6895611'),
(57, '2022-05-23T16:36:37.5279279'),
(58, '2022-05-23T16:36:38.4574033'),
(59, '2022-05-23T20:40:00.5967888'),
(60, '2022-05-23T20:41:41.7221154'),
(61, '2022-05-23T20:41:42.7738677'),
(62, '2022-05-23T20:41:42.9765267'),
(63, '2022-05-23T20:41:43.1933618'),
(64, '2022-05-23T20:41:43.8179341'),
(65, '2022-05-23T20:41:45.1471093'),
(66, '2022-05-23T20:41:46.8822943'),
(67, '2022-05-23T20:41:52.9545899'),
(68, '2022-05-23T20:58:08.6995298'),
(69, '2022-05-23T20:58:13.5184437'),
(70, '2022-05-23T20:58:15.1568474'),
(71, '2022-05-23T20:59:06.3590536'),
(72, '2022-05-23T20:59:09.2506292'),
(73, '2022-05-23T20:59:50.4765404'),
(74, '2022-05-23T21:08:37.1466309'),
(75, '2022-05-23T21:08:37.648461'),
(76, '2022-05-23T21:08:37.8515296'),
(77, '2022-05-23T21:08:37.9989609'),
(78, '2022-05-23T21:08:38.207447'),
(79, '2022-05-23T21:08:38.3784691'),
(80, '2022-05-23T21:08:40.4683407'),
(81, '2022-05-23T21:08:41.7773726'),
(82, '2022-05-23T21:09:18.7249614'),
(83, '2022-05-23T21:09:19.9220517'),
(84, '2022-05-23T21:52:39.588229'),
(85, '2022-05-23T22:08:41.3318844'),
(86, '2022-05-23T22:18:43.7059012'),
(87, '2022-05-23T22:36:51.8342047'),
(88, '2022-05-23T22:42:36.0582937');

-- --------------------------------------------------------

--
-- Structure de la table `panier_pizza`
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
(64, 4),
(63, 4),
(66, 4),
(62, 4),
(61, 4),
(60, 2),
(67, 4),
(70, 4),
(69, 2),
(88, 2),
(88, 4),
(67, 4),
(88, 4),
(88, 3),
(65, 5),
(72, 4),
(88, 1),
(88, 2),
(80, 2),
(79, 2),
(78, 2),
(77, 2),
(76, 2),
(75, 2),
(71, 5),
(82, 2),
(74, 2);

-- --------------------------------------------------------

--
-- Structure de la table `pizza`
--

DROP TABLE IF EXISTS `pizza`;
CREATE TABLE IF NOT EXISTS `pizza` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `label` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

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
(4, 'BBQ'),
(5, 'Belzebuth');

-- --------------------------------------------------------

--
-- Structure de la table `pizza_ingredient`
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
(4, 13),
(5, 1),
(5, 6),
(5, 7),
(5, 12),
(5, 12),
(5, 12),
(5, 11);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `password` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `userRole` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'ROLE_USER',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ifx_uq_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='utilisateurs';

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
(8, 'gael', '$2a$10$.fXcSDgRbzZUIk.ZC5td9u.Jxt460Nms6gKnKRY4Kdcz2DarcUbHy', 'ROLE_USER'),
(10, 'user123', '$2a$10$HCXGClRH1aJJZn8t/SUBW.uzUdswgtrAEWi3qpX/W2yFZ27m.OKZ6', 'ROLE_USER'),
(11, 'gealic', '$2a$10$SyeRhaDSMGJchPr4MbFZ3OFaFtOZqc5f5BBBNqBKTv52NwwToQ7t2', 'ROLE_USER'),
(12, '; OR 1=1', '$2a$10$07KMsiqu310EDJRpSZyP7.RW4qvNs.S7IbR7D80zY0tUrHaKqvI26', 'ROLE_USER');

-- --------------------------------------------------------

--
-- Structure de la table `user_order`
--

DROP TABLE IF EXISTS `user_order`;
CREATE TABLE IF NOT EXISTS `user_order` (
  `user_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

--
-- Tronquer la table avant d'insérer `user_order`
--

TRUNCATE TABLE `user_order`;
--
-- Déchargement des données de la table `user_order`
--

INSERT INTO `user_order` (`user_id`, `order_id`) VALUES
(1, 35),
(1, 36),
(8, 37),
(1, 38),
(1, 39),
(1, 40),
(1, 41),
(1, 42);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
