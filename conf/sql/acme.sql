-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 18 juin 2022 à 16:51
-- Version du serveur : 8.0.27
-- Version de PHP : 7.4.26

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
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
CREATE TABLE IF NOT EXISTS `article`
(
    `article_id`    int UNSIGNED  NOT NULL AUTO_INCREMENT,
    `code_article`  varchar(45)            DEFAULT 'CONCAT(label, ''_'', category_id)',
    `label`         varchar(45)   NOT NULL,
    `prix`          double(10, 2) NOT NULL,
    `date_created`  timestamp              DEFAULT CURRENT_TIMESTAMP,
    `description`   text,
    `enabled`       bit(1)        NOT NULL DEFAULT b'1',
    `last_modified` timestamp     NULL     DEFAULT NULL,
    `category_id`   int           NOT NULL,
    `property_id`   int           NOT NULL,
    PRIMARY KEY (`article_id`),
    KEY `article_article_id_index` (`article_id`),
    KEY `fk_article_category1_idx` (`category_id`),
    KEY `fk_article_pokemon_properties1_idx` (`property_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`article_id`, `code_article`, `label`, `prix`, `date_created`, `description`, `enabled`,
                       `last_modified`, `category_id`, `property_id`)
VALUES (1, 'POKE_0001', 'Bulbizarre', 120.23, '2022-06-12 13:46:47', '\'un pokemon de type plante, niveau 10\'', b'1',
        '2022-06-12 13:46:48', 1, 1),
       (2, 'POKE_0002', 'Herbizarre', 180.78, '2022-06-03 03:50:33', '\'un pokemone de type plante, rang2, niveau 30\'',
        b'1', NULL, 1, 2),
       (3, 'POKE_0003', 'Florizarre', 350.00, '2022-05-29 06:34:32', '\'un pokemone de type plante, rang3, niveau 52\'',
        b'1', NULL, 1, 3),
       (4, 'TEST_0001', 'Salamèche', 122.00, '2022-06-04 22:04:34', 'Type feu, Nivaeu 12', b'1', NULL, 1, 6);

-- --------------------------------------------------------

--
-- Structure de la table `article_has_props`
--

DROP TABLE IF EXISTS `article_has_props`;
CREATE TABLE IF NOT EXISTS `article_has_props`
(
    `article_id`  int UNSIGNED NOT NULL,
    `property_id` int          NOT NULL,
    PRIMARY KEY (`article_id`, `property_id`),
    KEY `fk_article_has_pokemon_properties_article1_idx` (`article_id`),
    KEY `fk_article_has_props_pokemon_properties1_idx` (`property_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `article_has_props`
--

INSERT INTO `article_has_props` (`article_id`, `property_id`)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 6);

-- --------------------------------------------------------

--
-- Structure de la table `cart`
--

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart`
(
    `cart_id`      int NOT NULL AUTO_INCREMENT,
    `date_created` timestamp DEFAULT CURRENT_TIMESTAMP,
    `last_user`    int       DEFAULT NULL,
    `customer_id`  int NOT NULL,
    PRIMARY KEY (`cart_id`, `customer_id`),
    KEY `cart_cart_id_customer_id_index` (`cart_id`),
    KEY `fk_cart_customer1_idx` (`customer_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 208
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `cart`
--

INSERT INTO `cart` (`cart_id`, `date_created`, `last_user`, `customer_id`)
VALUES (195, '2022-06-06 17:12:50', NULL, 1),
       (196, '2022-06-06 17:12:50', NULL, 2),
       (197, '2022-06-06 17:12:50', NULL, 3),
       (198, '2022-06-06 17:51:22', NULL, 4),
       (200, '2022-06-07 07:42:17', NULL, 5),
       (201, '2022-06-12 11:41:26', NULL, 6),
       (202, '2022-06-06 17:12:50', NULL, 1),
       (203, '2022-06-06 17:12:50', NULL, 2),
       (204, '2022-06-06 17:12:50', NULL, 3),
       (205, '2022-06-06 17:51:22', NULL, 4),
       (206, '2022-06-07 07:42:17', NULL, 5),
       (207, '2022-06-12 11:41:26', NULL, 6);

-- --------------------------------------------------------

--
-- Structure de la table `cart_has_article`
--

DROP TABLE IF EXISTS `cart_has_article`;
CREATE TABLE IF NOT EXISTS `cart_has_article`
(
    `cart_id`    int          NOT NULL,
    `article_id` int UNSIGNED NOT NULL,
    KEY `cart_has_article_article_article_id_fk` (`article_id`),
    KEY `cart_has_article_cart_cart_id_fk` (`cart_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `cart_has_article`
--

INSERT INTO `cart_has_article` (`cart_id`, `article_id`)
VALUES (196, 1),
       (201, 4),
       (201, 4),
       (201, 4),
       (201, 2);

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category`
(
    `category_id` int          NOT NULL,
    `label`       varchar(255) NOT NULL,
    `taxes`       double(5, 2) DEFAULT NULL,
    PRIMARY KEY (`category_id`),
    UNIQUE KEY `category_id_UNIQUE` (`category_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`category_id`, `label`, `taxes`)
VALUES (1, 'Pokemon', 20.00),
       (2, 'Pokedex', 17.53),
       (3, 'PokeBall', 16.00),
       (4, 'Vitamine', 5.50),
       (5, 'Ticket', 12.00);

-- --------------------------------------------------------

--
-- Structure de la table `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city`
(
    `id`         int         NOT NULL AUTO_INCREMENT,
    `country_id` int         NOT NULL,
    `label`      varchar(50) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `cities_label_uindex` (`label`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `commercial_has_customer`
--

DROP TABLE IF EXISTS `commercial_has_customer`;
CREATE TABLE IF NOT EXISTS `commercial_has_customer`
(
    `customer_id`   int          NOT NULL,
    `creation_date` timestamp DEFAULT CURRENT_TIMESTAMP,
    `change_date`   timestamp DEFAULT NULL,
    `user_id`       int UNSIGNED NOT NULL,
    KEY `commercial_has_customer_customer_customer_id_fk` (`customer_id`),
    KEY `fk_commercial_has_customer_user1_idx` (`user_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `commercial_has_customer`
--

INSERT INTO `commercial_has_customer` (`customer_id`, `creation_date`, `change_date`, `user_id`)
VALUES (6, '2022-06-11 21:00:01', NULL, 4);

-- --------------------------------------------------------

--
-- Structure de la table `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country`
(
    `id`       int         NOT NULL AUTO_INCREMENT,
    `iso`      char(2)     NOT NULL,
    `name`     varchar(80) NOT NULL,
    `nicename` varchar(80) NOT NULL,
    `iso3`     char(3) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = MyISAM
  AUTO_INCREMENT = 240
  DEFAULT CHARSET = latin1;

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

-- --------------------------------------------------------

--
-- Structure de la table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer`
(
    `customer_id`   int          NOT NULL AUTO_INCREMENT,
    `first_name`    varchar(30)  NOT NULL,
    `last_name`     varchar(30)  NOT NULL,
    `email`         varchar(255)          DEFAULT NULL,
    `phone`         varchar(20)           DEFAULT NULL,
    `country`       varchar(255) NOT NULL,
    `city`          varchar(255) NOT NULL,
    `postal_code`   varchar(12)  NOT NULL,
    `way_number`    int                   DEFAULT NULL,
    `way_type`      varchar(30)  NOT NULL,
    `way_name`      varchar(255) NOT NULL,
    `create_time`   timestamp    NULL     DEFAULT NULL,
    `last_modified` timestamp             DEFAULT CURRENT_TIMESTAMP,
    `enabled`       tinyint(1)   NOT NULL DEFAULT '1',
    `added_by`      int          NOT NULL,
    PRIMARY KEY (`customer_id`),
    UNIQUE KEY `Customers_pk_2` (`first_name`, `last_name`),
    UNIQUE KEY `customer_email_uindex` (`email`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `email`, `phone`, `country`, `city`, `postal_code`,
                        `way_number`, `way_type`, `way_name`, `create_time`, `last_modified`, `enabled`, `added_by`)
VALUES (2, 'pro', 'ste', 'b.1@G.c', '0708090909', 'FR', 'Rennes', '35000', 42, 'Avenue', 'Artisitde Briand',
        '2022-06-11 20:54:56', '2022-06-11 20:55:08', 1, 10),
       (3, 'Chauveau', 'Manu', 'mau@manu.fr', '0707070707', 'France', 'Saint Malo', '', 123, 'xxx', 'xxx',
        '2022-06-11 20:55:00', '2022-06-11 20:55:10', 1, 10),
       (4, 'la fripouille', 'toto', 'toto@toto.com', '0609109109', 'US', 'New York', '12380', 1, 'sq', 'Time',
        '2022-06-11 20:55:03', '2022-06-11 20:55:13', 1, 10),
       (5, '\'; TRUNCATE *;', '<$ alert(‘Executed\');%>', 'titi@titi.com', '0909090909', 'France', 'Rennes', '35000',
        120, 'Avenue', 'des poneys', '2022-06-11 20:55:04', '2022-06-11 20:55:15', 1, 10),
       (6, 'helix', 'mastaz', 'helixmastaz@gmail.com', '6666666666', 'ANY', 'ANY', '000000', 18, 'Vallée',
        'des hackerzz', '2022-06-11 21:00:02', '2022-06-11 21:00:01', 1, 12);

-- --------------------------------------------------------

--
-- Structure de la table `customer_has_order`
--

DROP TABLE IF EXISTS `customer_has_order`;
CREATE TABLE IF NOT EXISTS `customer_has_order`
(
    `customer_id` int NOT NULL,
    `order_id`    int NOT NULL,
    KEY `fk_customer_has_order_customer1_idx` (`customer_id`),
    KEY `fk_customer_has_order_order_1_idx` (`order_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

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
       (5, 34),
       (5, 35);

-- --------------------------------------------------------

--
-- Structure de la table `order_`
--

DROP TABLE IF EXISTS `order_`;
CREATE TABLE IF NOT EXISTS `order_`
(
    `order_id`      int           NOT NULL AUTO_INCREMENT,
    `date_created`  timestamp DEFAULT CURRENT_TIMESTAMP,
    `TVA`           double(10, 2) NOT NULL,
    `prix_ttc`      double(10, 2) NOT NULL,
    `status_id`     int       DEFAULT '1',
    `date_modified` timestamp     NOT NULL ON UPDATE CURRENT_TIMESTAMP,
    `customer_id`   int           NOT NULL,
    PRIMARY KEY (`order_id`),
    KEY `order_id_customer_id_index` (`customer_id`),
    KEY `order__status_id_index` (`status_id`),
    KEY `order_status_status_id_index` (`status_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 36
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `order_`
--

INSERT INTO `order_` (`order_id`, `date_created`, `TVA`, `prix_ttc`, `status_id`, `date_modified`, `customer_id`)
VALUES (1, '2022-06-10 15:05:25', 81.33, 488.00, 1, '2022-06-10 15:13:33', 2),
       (2, '2022-06-10 15:05:25', 187.17, 1123.01, 1, '2022-06-10 15:13:33', 4),
       (3, '2022-06-10 15:05:25', 291.67, 1750.00, 1, '2022-06-10 15:13:33', 3),
       (4, '2022-06-10 15:05:25', 20.04, 120.23, 1, '2022-06-10 15:13:33', 4),
       (5, '2022-06-10 15:05:25', 100.49, 602.92, 1, '2022-06-10 15:13:33', 4),
       (6, '2022-06-10 15:05:25', 60.12, 360.69, 1, '2022-06-10 15:13:33', 2),
       (7, '2022-06-10 15:05:25', 98.70, 592.23, 1, '2022-06-10 15:13:33', 2),
       (8, '2022-06-10 15:05:25', 80.30, 481.79, 1, '2022-06-10 15:13:33', 3),
       (9, '2022-06-10 15:05:25', 136.70, 820.23, 1, '2022-06-10 15:13:33', 4),
       (10, '2022-06-10 15:05:25', 20.04, 120.23, 1, '2022-06-10 15:13:33', 4),
       (11, '2022-06-10 15:05:25', 20.04, 120.23, 1, '2022-06-10 15:13:33', 3),
       (12, '2022-06-10 15:05:25', 50.17, 301.01, 1, '2022-06-10 15:13:33', 5),
       (13, '2022-06-10 15:05:25', 40.08, 240.46, 1, '2022-06-10 15:13:33', 4),
       (14, '2022-06-10 15:05:25', 60.41, 362.46, 1, '2022-06-10 15:13:33', 5),
       (15, '2022-06-10 15:05:25', 160.31, 961.84, 1, '2022-06-10 15:13:33', 3),
       (16, '2022-06-10 15:05:25', 122.00, 732.00, 1, '2022-06-10 15:13:33', 4),
       (17, '2022-06-14 04:13:51', 120.46, 360.69, 1, '2022-06-11 20:20:50', 3),
       (18, '2022-06-14 04:13:51', 197.94, 845.15, 1, '2022-06-12 11:43:29', 2),
       (19, '2022-06-14 04:13:51', 878.81, 4394.03, 1, '2022-06-12 13:45:09', 4),
       (20, '2022-06-14 04:13:51', 295.27, 1265.46, 1, '2022-06-13 21:38:17', 5),
       (21, '2022-06-13 21:39:00', 30.13, 180.78, 1, '2022-06-13 21:39:00', 6),
       (22, '2022-06-14 04:21:18', 317.93, 1907.58, 1, '2022-06-14 04:21:18', 3),
       (23, '2022-06-14 08:45:46', 60.26, 361.56, 1, '2022-06-14 08:45:46', 6),
       (24, '2022-06-14 09:03:44', 40.08, 240.46, 1, '2022-06-14 09:03:44', 5),
       (25, '2022-06-14 09:05:47', 20.33, 122.00, 1, '2022-06-14 09:05:47', 4),
       (26, '2022-06-14 18:01:50', 101.37, 608.23, 1, '2022-06-14 18:01:50', 3),
       (27, '2022-06-14 18:17:55', 150.65, 903.90, 1, '2022-06-14 18:17:55', 5),
       (28, '2022-06-14 18:34:14', 100.19, 601.15, 1, '2022-06-14 18:34:14', 6),
       (29, '2022-06-14 18:34:27', 270.88, 1625.28, 1, '2022-06-14 18:34:27', 5),
       (30, '2022-06-14 18:34:34', 80.15, 480.92, 1, '2022-06-14 18:34:34', 3),
       (31, '2022-06-14 19:36:37', 327.88, 1967.26, 1, '2022-06-14 19:36:37', 5),
       (32, '2022-06-14 19:36:55', 60.11, 360.69, 1, '2022-06-14 19:36:55', 4),
       (35, '2022-06-18 16:45:13', 60.11, 360.69, 1, '0000-00-00 00:00:00', 5);

-- --------------------------------------------------------

--
-- Structure de la table `order_has_article`
--

DROP TABLE IF EXISTS `order_has_article`;
CREATE TABLE IF NOT EXISTS `order_has_article`
(
    `order_id`   int          NOT NULL,
    `article_id` int UNSIGNED NOT NULL,
    KEY `fk_order__has_article_article1_idx` (`article_id`),
    KEY `fk_order__has_article_order_1_idx` (`order_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

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
       (34, 1),
       (35, 1),
       (35, 1),
       (35, 1);

-- --------------------------------------------------------

--
-- Structure de la table `order_has_status`
--

DROP TABLE IF EXISTS `order_has_status`;
CREATE TABLE IF NOT EXISTS `order_has_status`
(
    `status_id` int NOT NULL,
    `order_id`  int NOT NULL,
    `date`      timestamp DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`status_id`, `order_id`),
    KEY `fk_order_status_has_order__order_1_idx` (`order_id`),
    KEY `fk_order_status_has_order__order_status1_idx` (`status_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `order_has_status`
--

INSERT INTO `order_has_status` (`status_id`, `order_id`, `date`)
VALUES (1, 1, '2022-06-14 16:44:25'),
       (1, 2, '2022-06-14 16:44:25'),
       (1, 3, '2022-06-14 16:44:25'),
       (1, 4, '2022-06-14 16:44:25'),
       (1, 5, '2022-06-14 16:44:25'),
       (1, 6, '2022-06-14 16:44:25'),
       (1, 7, '2022-06-14 16:44:25'),
       (1, 8, '2022-06-14 16:44:25'),
       (1, 9, '2022-06-14 16:44:25'),
       (1, 10, '2022-06-14 16:44:25'),
       (1, 11, '2022-06-14 16:44:25'),
       (1, 12, '2022-06-14 16:44:25'),
       (1, 13, '2022-06-14 16:44:25'),
       (1, 14, '2022-06-14 16:44:25'),
       (1, 15, '2022-06-14 16:44:25'),
       (1, 16, '2022-06-14 16:44:25'),
       (1, 17, '2022-06-14 16:44:25'),
       (1, 18, '2022-06-14 16:44:25'),
       (1, 19, '2022-06-14 16:44:25'),
       (1, 20, '2022-06-14 16:44:25'),
       (1, 21, '2022-06-14 16:44:25'),
       (1, 22, '2022-06-14 16:44:25'),
       (1, 23, '2022-06-14 16:44:25'),
       (1, 24, '2022-06-14 16:44:25'),
       (1, 25, '2022-06-14 16:44:25');

-- --------------------------------------------------------

--
-- Structure de la table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
CREATE TABLE IF NOT EXISTS `order_status`
(
    `id`    int         NOT NULL AUTO_INCREMENT,
    `label` varchar(35) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `order_status_label_uindex` (`label`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 8
  DEFAULT CHARSET = utf8mb3;

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

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `pokemon`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `pokemon`;
CREATE TABLE IF NOT EXISTS `pokemon`
(
    `article_id`   int unsigned,
    `label`        varchar(45),
    `prix`         double(10, 2),
    `description`  text,
    `code_article` varchar(45),
    `date`         timestamp,
    `enabled`      bit(1),
    `props`        text,
    `category`     text
);

-- --------------------------------------------------------

--
-- Structure de la table `pokemon_properties`
--

DROP TABLE IF EXISTS `pokemon_properties`;
CREATE TABLE IF NOT EXISTS `pokemon_properties`
(
    `prop_id` int           NOT NULL AUTO_INCREMENT,
    `type`    varchar(255)  NOT NULL,
    `taille`  double(3, 1)  NOT NULL,
    `poids`   double(10, 2) NOT NULL,
    `Level`   int           NOT NULL DEFAULT '1',
    `Exp`     int           NOT NULL DEFAULT '0',
    `ATK`     int           NOT NULL,
    `DEF`     int           NOT NULL,
    `SPD`     int           NOT NULL,
    `ATKSPE`  int           NOT NULL,
    `DEFSPE`  int           NOT NULL,
    `PV`      int           NOT NULL DEFAULT '0',
    `PP`      int           NOT NULL DEFAULT '0',
    PRIMARY KEY (`prop_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `pokemon_properties`
--

INSERT INTO `pokemon_properties` (`prop_id`, `type`, `taille`, `poids`, `Level`, `Exp`, `ATK`, `DEF`, `SPD`, `ATKSPE`,
                                  `DEFSPE`, `PV`, `PP`)
VALUES (1, 'Plante', 0.7, 6904.00, 10, 1, 29, 35, 18, 38, 27, 25, 12),
       (2, 'Plante', 1.0, 13000.00, 30, 2, 49, 82, 29, 57, 58, 130, 27),
       (3, 'Plante', 2.0, 100000.00, 52, 3, 103, 132, 47, 153, 80, 430, 64),
       (6, 'Feu', 0.8, 2112.00, 12, 12, 12, 12, 12, 21, 12, 21, 12);

-- --------------------------------------------------------

--
-- Structure de la table `security_details`
--

DROP TABLE IF EXISTS `security_details`;
CREATE TABLE IF NOT EXISTS `security_details`
(
    `user_id`             int UNSIGNED NOT NULL,
    `account_locked`      binary(1)    NOT NULL DEFAULT '0',
    `credentials_expired` binary(1)    NOT NULL DEFAULT '0',
    `enabled`             binary(1)    NOT NULL DEFAULT '1',
    `account_expired`     binary(1)    NOT NULL DEFAULT '0',
    PRIMARY KEY (`user_id`),
    KEY `fk_security_details_user1_idx` (`user_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `street_type`
--

DROP TABLE IF EXISTS `street_type`;
CREATE TABLE IF NOT EXISTS `street_type`
(
    `id`    int          NOT NULL AUTO_INCREMENT,
    `label` varchar(100) NOT NULL,
    `abrev` varchar(5) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `street_type_label_uindex` (`label`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 12
  DEFAULT CHARSET = utf8mb3;

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

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user`
(
    `user_id`      int UNSIGNED NOT NULL AUTO_INCREMENT,
    `email`        varchar(60)  NOT NULL,
    `password`     varchar(60)  NOT NULL,
    `nickname`     varchar(45)           DEFAULT NULL,
    `date_created` timestamp             DEFAULT CURRENT_TIMESTAMP,
    `user_role`    varchar(15)  NOT NULL DEFAULT 'NOONE',
    `role_id`      int UNSIGNED NOT NULL DEFAULT '8',
    PRIMARY KEY (`user_id`, `role_id`),
    UNIQUE KEY `email_UNIQUE` (`email`),
    KEY `fk_user_user_role1_idx` (`role_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 13
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`user_id`, `email`, `password`, `nickname`, `date_created`, `user_role`, `role_id`)
VALUES (4, 'user@email.com', '$2a$10$O6nD1mex5dzDaO3wco6H4e9lB7ZPI7r9j88MEeXCNZNLvRxFwEcmq', 'Regis',
        '2022-06-14 18:49:32', 'ROLE_ADMIN', 8),
       (5, 'user1@email.com', '$2a$10$A21hBE6ZrS693m4/sRqddOb6yUS7k8UfvpGklS/RnD4sasGkb.4ce', 'Sacha',
        '2022-06-14 18:49:32', 'ROLE_USER', 8),
       (7, 'user2@email.com', '$2a$10$9aTXaqbdMI/jPsIIaZtod.WJsDMrg2ATmoxWKHIDKIP2PLA1yRWwe', 'Ondine',
        '2022-06-14 18:49:32', 'ROLE_USER', 8),
       (8, 'user3@email.com', '$2a$10$0sDNBSL.8qOvzis/qwg/Ze5EBBisQi.WDa.W/Vo5d3rCc6eoDXXem', 'Pierre',
        '2022-06-14 18:49:32', 'ROLE_USER', 8),
       (10, 'user5@email.com', '$2a$10$mo.CDF9.nOyTFU46uKERquZ5lzS1F5PQxKnAQDMSagE98rp9lOx1i', 'Marcel',
        '2022-06-14 18:49:32', 'ROLE_COMM', 8),
       (12, 'user4@email.com', '$2a$10$bC/Buy7PpKVSvgpSpMX/punzR9ixRcIRiXO0C8DUm6yBUb9fEgsgm', 'Geanice',
        '2022-06-14 18:49:32', 'ROLE_COMM', 8);

-- --------------------------------------------------------

--
-- Structure de la table `user_has_customer_rights`
--

DROP TABLE IF EXISTS `user_has_customer_rights`;
CREATE TABLE IF NOT EXISTS `user_has_customer_rights`
(
    `user_id`     int UNSIGNED NOT NULL,
    `customer_id` int          NOT NULL,
    KEY `fk_user_has_customer_rights_user1_idx` (`user_id`),
    KEY `fk_user_has_customer_rights_customer1_idx` (`customer_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

-- --------------------------------------------------------

--
-- Structure de la table `user_has_order`
--

DROP TABLE IF EXISTS `user_has_order`;
CREATE TABLE IF NOT EXISTS `user_has_order`
(
    `user_id`  int UNSIGNED NOT NULL,
    `order_id` int          NOT NULL,
    KEY `fk_user_has_order_user1_idx` (`user_id`),
    KEY `fk_user_has_order_order_1_idx` (`order_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `user_has_order`
--

INSERT INTO `user_has_order` (`user_id`, `order_id`)
VALUES (4, 10),
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
       (4, 26),
       (4, 27),
       (4, 28),
       (4, 29),
       (4, 30),
       (4, 31),
       (4, 32),
       (4, 33),
       (4, 34),
       (4, 35);

-- --------------------------------------------------------

--
-- Structure de la table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
CREATE TABLE IF NOT EXISTS `user_role`
(
    `role_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
    `label`   varchar(10) DEFAULT 'USER',
    PRIMARY KEY (`role_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 9
  DEFAULT CHARSET = utf8mb3;

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
       (8, 'NOONE');

-- --------------------------------------------------------

--
-- Structure de la table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE IF NOT EXISTS `warehouse`
(
    `warehouse_id` int         NOT NULL AUTO_INCREMENT,
    `label`        varchar(50) NOT NULL,
    `city_id`      int DEFAULT NULL,
    `country_id`   int DEFAULT NULL,
    PRIMARY KEY (`warehouse_id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `warehouse`
--

INSERT INTO `warehouse` (`warehouse_id`, `label`, `city_id`, `country_id`)
VALUES (1, 'Rennes', NULL, NULL),
       (2, 'Tours', NULL, NULL),
       (3, 'Paris', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `warehouse_has_article`
--

DROP TABLE IF EXISTS `warehouse_has_article`;
CREATE TABLE IF NOT EXISTS `warehouse_has_article`
(
    `article_id`   int UNSIGNED NOT NULL,
    `warehouse_id` int          NOT NULL,
    `quantity`     int          NOT NULL DEFAULT '0',
    KEY `fk_warehouse_has_article_warehouse1_idx` (`warehouse_id`),
    KEY `fk_warehouse_has_article_article1_idx` (`article_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb3;

--
-- Déchargement des données de la table `warehouse_has_article`
--

INSERT INTO `warehouse_has_article` (`article_id`, `warehouse_id`, `quantity`)
VALUES (1, 1, 0),
       (2, 1, 0),
       (3, 1, 0),
       (4, 2, 0),
       (3, 3, 0),
       (4, 3, 0);

-- --------------------------------------------------------

--
-- Structure de la vue `pokemon` exportée comme une table
--
DROP TABLE IF EXISTS `pokemon`;
CREATE TABLE IF NOT EXISTS `pokemon`
(
    `article_id`   int unsigned                        DEFAULT '0',
    `label`        varchar(45) COLLATE utf8_general_ci NOT NULL,
    `prix`         double(10, 2)                       NOT NULL,
    `description`  text COLLATE utf8_general_ci        DEFAULT NULL,
    `code_article` varchar(45) COLLATE utf8_general_ci DEFAULT 'CONCAT(label, \'_\', category_id)',
    `date`         timestamp                           DEFAULT CURRENT_TIMESTAMP,
    `enabled`      bit(1)                              DEFAULT TRUE,
    `props`        text COLLATE utf8_general_ci        NOT NULL,
    `category`     text COLLATE utf8_general_ci        NOT NULL
);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
    ADD CONSTRAINT `fk_article_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
    ADD CONSTRAINT `fk_article_pokemon_properties1` FOREIGN KEY (`property_id`) REFERENCES `pokemon_properties` (`prop_id`);

--
-- Contraintes pour la table `article_has_props`
--
ALTER TABLE `article_has_props`
    ADD CONSTRAINT `fk_article_has_pokemon_properties_article1` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`),
    ADD CONSTRAINT `fk_article_has_props_pokemon_properties1` FOREIGN KEY (`property_id`) REFERENCES `pokemon_properties` (`prop_id`);

--
-- Contraintes pour la table `cart`
--
ALTER TABLE `cart`
    ADD CONSTRAINT `fk_cart_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Contraintes pour la table `cart_has_article`
--
ALTER TABLE `cart_has_article`
    ADD CONSTRAINT `cart_has_article_article_article_id_fk` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`),
    ADD CONSTRAINT `cart_has_article_cart_cart_id_fk` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`);

--
-- Contraintes pour la table `commercial_has_customer`
--
ALTER TABLE `commercial_has_customer`
    ADD CONSTRAINT `commercial_has_customer_customer_customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
    ADD CONSTRAINT `fk_commercial_has_customer_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Contraintes pour la table `customer_has_order`
--
ALTER TABLE `customer_has_order`
    ADD CONSTRAINT `fk_customer_has_order_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
    ADD CONSTRAINT `fk_customer_has_order_order_1` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`);

--
-- Contraintes pour la table `order_has_article`
--
ALTER TABLE `order_has_article`
    ADD CONSTRAINT `fk_order__has_article_article1` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`),
    ADD CONSTRAINT `fk_order__has_article_order_1` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`);

--
-- Contraintes pour la table `order_has_status`
--
ALTER TABLE `order_has_status`
    ADD CONSTRAINT `fk_order_status_has_order__order_1` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`),
    ADD CONSTRAINT `fk_order_status_has_order__order_status1` FOREIGN KEY (`status_id`) REFERENCES `order_status` (`id`);

--
-- Contraintes pour la table `security_details`
--
ALTER TABLE `security_details`
    ADD CONSTRAINT `fk_security_details_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Contraintes pour la table `user`
--
ALTER TABLE `user`
    ADD CONSTRAINT `fk_user_user_role1` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`);

--
-- Contraintes pour la table `user_has_customer_rights`
--
ALTER TABLE `user_has_customer_rights`
    ADD CONSTRAINT `fk_user_has_customer_rights_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
    ADD CONSTRAINT `fk_user_has_customer_rights_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Contraintes pour la table `user_has_order`
--
ALTER TABLE `user_has_order`
    ADD CONSTRAINT `fk_user_has_order_order_1` FOREIGN KEY (`order_id`) REFERENCES `order_` (`order_id`),
    ADD CONSTRAINT `fk_user_has_order_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Contraintes pour la table `warehouse_has_article`
--
ALTER TABLE `warehouse_has_article`
    ADD CONSTRAINT `fk_warehouse_has_article_article1` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`),
    ADD CONSTRAINT `fk_warehouse_has_article_warehouse1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`warehouse_id`);
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
