-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 24 mai 2022 à 20:57
-- Version du serveur : 8.0.27
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
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
CREATE TABLE IF NOT EXISTS `ingredients`
(
    `id`          int                                             NOT NULL AUTO_INCREMENT,
    `type`        varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `label`       varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `nb_calories` int                                             NOT NULL,
    `prix`        double                                          NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 14
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8_bin;

--
-- Déchargement des données de la table `ingredients`
--

INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (1, 'pate', 'pate fine', 120, 3);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (2, 'pate', 'pate épaisse', 130, 3.5);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (3, 'base', 'sauce tomate', 25, 1.33);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (4, 'base', 'sauce fromage', 230, 1.5);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (5, 'vert', 'roquette', 12, 0.5);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (6, 'vert', 'basilic', 10, 0.5);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (7, 'viande', 'poulet', 80, 2.22);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (8, 'viande', 'boeuf', 130, 1.35);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (9, 'viande', 'saucisse', 120, 1.15);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (10, 'fromage', 'mozzarella', 40, 0.3);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (11, 'fromage', 'emmental', 170, 0.3);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (12, 'fromage', 'roquefort', 164, 0.34);
INSERT INTO `ingredients` (`id`, `type`, `label`, `nb_calories`, `prix`)
VALUES (13, 'viande', 'Jambon', 140, 1.3);

-- --------------------------------------------------------

--
-- Structure de la table `order_`
--

DROP TABLE IF EXISTS `order_`;
CREATE TABLE IF NOT EXISTS `order_`
(
    `id`        bigint    NOT NULL AUTO_INCREMENT,
    `user_id`   int       NOT NULL,
    `TVA`       double    NOT NULL,
    `prix_ttc`  double    NOT NULL,
    `date`      timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `id_status` int       NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 47
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8_bin;

--
-- Déchargement des données de la table `order_`
--

INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (35, 1, 2.97, 57.019999999999996, '2022-05-23 17:35:06', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (36, 1, 5.8, 111.26000000000002, '2022-05-23 19:02:55', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (37, 8, 3.23, 62.019999999999996, '2022-05-23 19:09:01', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (38, 1, 5.74, 110.15999999999998, '2022-05-23 19:52:32', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (39, 1, 2.92, 55.97999999999999, '2022-05-23 20:08:31', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (40, 1, 2.04, 39.08, '2022-05-23 20:18:37', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (41, 1, 1.82, 34.88, '2022-05-23 20:36:46', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (42, 1, 1.19, 22.900000000000002, '2022-05-23 20:42:27', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (43, 8, 8.6, 165.01, '2022-05-24 14:47:20', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (44, 1, 20.16, 386.65000000000003, '2022-05-24 19:39:11', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (45, 8, 14.49, 277.94, '2022-05-24 20:19:14', 1);
INSERT INTO `order_` (`id`, `user_id`, `TVA`, `prix_ttc`, `date`, `id_status`)
VALUES (46, 8, 4.17, 79.91999999999999, '2022-05-24 20:21:58', 1);

-- --------------------------------------------------------

--
-- Structure de la table `order_articles`
--

DROP TABLE IF EXISTS `order_articles`;
CREATE TABLE IF NOT EXISTS `order_articles`
(
    `order_id` int NOT NULL,
    `pizza_id` int NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8_bin;

--
-- Déchargement des données de la table `order_articles`
--

INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (35, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (35, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (35, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (35, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (35, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (36, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 1);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (37, 1);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (38, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (39, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (39, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (39, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (39, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (39, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (39, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (40, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (40, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (40, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (40, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (40, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (41, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (41, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (41, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (41, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (41, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (42, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (42, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (42, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 1);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 1);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (43, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 3);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 5);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 1);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (44, 1);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (45, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (46, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (46, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (46, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (46, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (46, 4);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (46, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (46, 2);
INSERT INTO `order_articles` (`order_id`, `pizza_id`)
VALUES (46, 2);

-- --------------------------------------------------------

--
-- Structure de la table `panier`
--

DROP TABLE IF EXISTS `panier`;
CREATE TABLE IF NOT EXISTS `panier`
(
    `id`        int NOT NULL AUTO_INCREMENT,
    `timestamp` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 102
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8_bin;

--
-- Déchargement des données de la table `panier`
--

INSERT INTO `panier` (`id`, `timestamp`)
VALUES (1, '2022-05-14T11:03:46.2215818');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (2, '2022-05-15T22:33:50.9817542');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (3, '2022-05-15T22:33:55.4647728');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (4, '2022-05-15T22:33:56.358489');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (5, '2022-05-15T22:54:46.4045896');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (6, '2022-05-15T22:54:49.0452248');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (7, '2022-05-17T09:10:01.0712368');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (8, '2022-05-17T09:10:01.8199952');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (9, '2022-05-17T09:10:02.757614');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (10, '2022-05-17T09:10:04.7295788');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (11, '2022-05-17T09:10:05.5001671');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (12, '2022-05-18T09:16:11.5797325');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (13, '2022-05-18T09:16:12.6625577');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (14, '2022-05-18T20:02:47.9942078');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (15, '2022-05-19T00:39:55.809523');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (16, '2022-05-19T00:39:58.7045448');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (17, '2022-05-19T00:39:59.4676783');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (18, '2022-05-19T00:40:00.2504573');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (19, '2022-05-19T00:40:05.5673358');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (20, '2022-05-19T00:40:54.7518117');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (21, '2022-05-19T09:04:10.6745761');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (22, '2022-05-19T09:04:11.2767717');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (23, '2022-05-19T09:04:12.4521956');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (24, '2022-05-19T09:04:14.0944195');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (25, '2022-05-19T09:04:15.5746142');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (26, '2022-05-19T09:04:17.8518178');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (27, '2022-05-19T09:04:19.6261925');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (28, '2022-05-19T12:29:40.7759178');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (29, '2022-05-19T13:37:12.261535');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (30, '2022-05-19T14:15:39.9223071');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (31, '2022-05-19T14:42:10.6129765');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (32, '2022-05-19T15:49:46.3696849');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (33, '2022-05-19T15:53:50.6810818');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (34, '2022-05-19T16:12:14.3871649');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (35, '2022-05-19T16:12:19.5529413');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (36, '2022-05-20T01:08:02.7351498');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (37, '2022-05-20T01:08:04.6244878');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (38, '2022-05-20T01:08:06.1872585');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (39, '2022-05-20T01:08:06.6645801');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (40, '2022-05-20T01:08:07.0207222');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (41, '2022-05-20T01:08:07.5131509');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (42, '2022-05-20T01:08:08.102466');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (43, '2022-05-20T01:08:08.5010851');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (44, '2022-05-20T01:08:08.8988655');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (45, '2022-05-20T01:08:18.2172944');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (46, '2022-05-20T01:08:37.9814069');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (47, '2022-05-20T01:08:39.9663813');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (48, '2022-05-20T01:14:56.2589892');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (49, '2022-05-20T01:15:35.8762088');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (50, '2022-05-23T16:35:47.3452514');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (51, '2022-05-23T16:35:49.8485835');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (52, '2022-05-23T16:35:52.4057348');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (53, '2022-05-23T16:35:53.7469767');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (54, '2022-05-23T16:36:33.7803608');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (55, '2022-05-23T16:36:34.5676679');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (56, '2022-05-23T16:36:36.6895611');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (57, '2022-05-23T16:36:37.5279279');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (58, '2022-05-23T16:36:38.4574033');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (59, '2022-05-23T20:40:00.5967888');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (60, '2022-05-23T20:41:41.7221154');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (61, '2022-05-23T20:41:42.7738677');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (62, '2022-05-23T20:41:42.9765267');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (63, '2022-05-23T20:41:43.1933618');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (64, '2022-05-23T20:41:43.8179341');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (65, '2022-05-23T20:41:45.1471093');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (66, '2022-05-23T20:41:46.8822943');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (67, '2022-05-23T20:41:52.9545899');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (68, '2022-05-23T20:58:08.6995298');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (69, '2022-05-23T20:58:13.5184437');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (70, '2022-05-23T20:58:15.1568474');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (71, '2022-05-23T20:59:06.3590536');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (72, '2022-05-23T20:59:09.2506292');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (73, '2022-05-23T20:59:50.4765404');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (74, '2022-05-23T21:08:37.1466309');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (75, '2022-05-23T21:08:37.648461');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (76, '2022-05-23T21:08:37.8515296');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (77, '2022-05-23T21:08:37.9989609');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (78, '2022-05-23T21:08:38.207447');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (79, '2022-05-23T21:08:38.3784691');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (80, '2022-05-23T21:08:40.4683407');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (81, '2022-05-23T21:08:41.7773726');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (82, '2022-05-23T21:09:18.7249614');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (83, '2022-05-23T21:09:19.9220517');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (84, '2022-05-23T21:52:39.588229');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (85, '2022-05-23T22:08:41.3318844');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (86, '2022-05-23T22:18:43.7059012');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (87, '2022-05-23T22:36:51.8342047');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (88, '2022-05-23T22:42:36.0582937');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (89, '2022-05-24T08:15:12.8514024');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (90, '2022-05-24T08:15:25.1126427');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (91, '2022-05-24T08:21:29.7844345');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (92, '2022-05-24T08:21:33.288932');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (93, '2022-05-24T16:38:16.6279627');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (94, '2022-05-24T16:38:23.1090181');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (95, '2022-05-24T16:42:31.5463314');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (96, '2022-05-24T16:47:31.7758247');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (97, '2022-05-24T18:45:14.7295549');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (98, '2022-05-24T21:40:15.3063721');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (99, '2022-05-24T21:43:51.6736034');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (100, '2022-05-24T22:21:47.1226462');
INSERT INTO `panier` (`id`, `timestamp`)
VALUES (101, '2022-05-24T22:28:20.3381976');

-- --------------------------------------------------------

--
-- Structure de la table `panier_pizza`
--

DROP TABLE IF EXISTS `panier_pizza`;
CREATE TABLE IF NOT EXISTS `panier_pizza`
(
    `panier_id` int NOT NULL,
    `pizza_id`  int NOT NULL
) ENGINE = MyISAM
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8_bin;

--
-- Déchargement des données de la table `panier_pizza`
--

INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (64, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (63, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (92, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (66, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (62, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (61, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (60, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (67, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (70, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (69, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (88, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (88, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (67, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (88, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (88, 3);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (65, 5);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (72, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 3);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (88, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (88, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (80, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 3);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (79, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (78, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (77, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 5);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (76, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (75, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 4);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (71, 5);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (82, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (74, 2);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);
INSERT INTO `panier_pizza` (`panier_id`, `pizza_id`)
VALUES (101, 1);

-- --------------------------------------------------------

--
-- Structure de la table `pizza`
--

DROP TABLE IF EXISTS `pizza`;
CREATE TABLE IF NOT EXISTS `pizza`
(
    `id`    int UNSIGNED                                    NOT NULL AUTO_INCREMENT,
    `label` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8_bin;

--
-- Déchargement des données de la table `pizza`
--

INSERT INTO `pizza` (`id`, `label`)
VALUES (1, 'Margharita');
INSERT INTO `pizza` (`id`, `label`)
VALUES (2, '4Fromages');
INSERT INTO `pizza` (`id`, `label`)
VALUES (3, 'Royale');
INSERT INTO `pizza` (`id`, `label`)
VALUES (4, 'BBQ');
INSERT INTO `pizza` (`id`, `label`)
VALUES (5, 'Belzebuth');

-- --------------------------------------------------------

--
-- Structure de la table `pizza_ingredient`
--

DROP TABLE IF EXISTS `pizza_ingredient`;
CREATE TABLE IF NOT EXISTS `pizza_ingredient`
(
    `pizza_id`      int UNSIGNED NOT NULL,
    `ingredient_id` int UNSIGNED NOT NULL
) ENGINE = MyISAM
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8_bin;

--
-- Déchargement des données de la table `pizza_ingredient`
--

INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (1, 1);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (1, 3);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (1, 5);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (1, 6);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (1, 10);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (2, 1);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (2, 5);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (2, 6);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (2, 10);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (2, 11);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (2, 12);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (3, 1);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (3, 3);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (3, 9);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (3, 8);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (3, 7);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (3, 12);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (3, 10);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (4, 2);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (4, 3);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (4, 6);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (4, 7);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (4, 7);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (4, 8);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (4, 10);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (4, 11);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (4, 13);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (5, 1);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (5, 6);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (5, 7);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (5, 12);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (5, 12);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (5, 12);
INSERT INTO `pizza_ingredient` (`pizza_id`, `ingredient_id`)
VALUES (5, 11);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user`
(
    `id`       int                                             NOT NULL AUTO_INCREMENT,
    `email`    varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `password` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
    `userRole` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'ROLE_USER',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ifx_uq_email` (`email`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 13
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8_bin COMMENT ='utilisateurs';

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `userRole`)
VALUES (1, 'user', '$2a$10$RDilYQ7Mi8VsN/wV2jmB1O.METkqETxjzLrNMX9s/ebZQHFGhCp2G', 'ROLE_ADMIN');
INSERT INTO `user` (`id`, `email`, `password`, `userRole`)
VALUES (5, 'user2', '$2a$10$uJcfmMWygag4y5Bm2o8I/OgmpYUJldIm6nJtBfadaBJvIpveXA3ba', 'ROLE_USER');
INSERT INTO `user` (`id`, `email`, `password`, `userRole`)
VALUES (8, 'gael', '$2a$10$.fXcSDgRbzZUIk.ZC5td9u.Jxt460Nms6gKnKRY4Kdcz2DarcUbHy', 'ROLE_USER');
INSERT INTO `user` (`id`, `email`, `password`, `userRole`)
VALUES (10, 'user123', '$2a$10$HCXGClRH1aJJZn8t/SUBW.uzUdswgtrAEWi3qpX/W2yFZ27m.OKZ6', 'ROLE_USER');
INSERT INTO `user` (`id`, `email`, `password`, `userRole`)
VALUES (11, 'gealic', '$2a$10$SyeRhaDSMGJchPr4MbFZ3OFaFtOZqc5f5BBBNqBKTv52NwwToQ7t2', 'ROLE_USER');
INSERT INTO `user` (`id`, `email`, `password`, `userRole`)
VALUES (12, '; OR 1=1', '$2a$10$07KMsiqu310EDJRpSZyP7.RW4qvNs.S7IbR7D80zY0tUrHaKqvI26', 'ROLE_USER');

-- --------------------------------------------------------

--
-- Structure de la table `user_order`
--

DROP TABLE IF EXISTS `user_order`;
CREATE TABLE IF NOT EXISTS `user_order`
(
    `user_id`  int DEFAULT NULL,
    `order_id` int DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3
  COLLATE = utf8_bin;

--
-- Déchargement des données de la table `user_order`
--

INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (1, 35);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (1, 36);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (8, 37);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (1, 38);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (1, 39);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (1, 40);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (1, 41);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (1, 42);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (8, 43);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (1, 44);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (8, 45);
INSERT INTO `user_order` (`user_id`, `order_id`)
VALUES (8, 46);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
