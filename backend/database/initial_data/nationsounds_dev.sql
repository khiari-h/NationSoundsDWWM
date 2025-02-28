-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 27 fév. 2025 à 19:01
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `nationsounds_dev`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE IF NOT EXISTS `admin_users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `admin_users`
--

INSERT INTO `admin_users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'hamdane.khiari@gmail.com', '$2y$12$XLXUkUZ38OT0kqRtFlzZNOPdjLkfW/mE2cYOSww2uLa1OiT6WXZJO', NULL, '2025-02-23 16:04:32', '2025-02-23 16:04:32');

-- --------------------------------------------------------

--
-- Structure de la table `artists`
--

DROP TABLE IF EXISTS `artists`;
CREATE TABLE IF NOT EXISTS `artists` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genre` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `artists`
--

INSERT INTO `artists` (`id`, `name`, `description`, `image_url`, `genre`, `created_at`, `updated_at`) VALUES
(1, 'Afternoon', 'Artiste électro connu pour ses performances au coucher du soleil', '/images/artists/afternoon.webp', 'Électro', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(2, 'Bars', 'Groupe de rock alternatif avec une énergie débordante', '/images/artists/bars.webp', 'Rock', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(3, 'Cars', 'Duo pop rock qui enflamme les scènes', '/images/artists/cars.webp', 'Pop Rock', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(4, 'Cas', 'Producteur de musique électronique avant-gardiste', '/images/artists/cas.webp', 'EDM', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(5, 'Fars', 'Artiste rap de la nouvelle génération', '/images/artists/fars.webp', 'Rap', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(6, 'Sraf', 'Groupe de rock énergique', '/images/artists/sraf.webp', 'Rock', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(7, 'Fine', 'Chanteuse pop aux mélodies envoûtantes', '/images/artists/fine.webp', 'Pop', '2025-02-23 07:17:34', '2025-02-23 07:17:34');

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `concerts`
--

DROP TABLE IF EXISTS `concerts`;
CREATE TABLE IF NOT EXISTS `concerts` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `venue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `concerts`
--

INSERT INTO `concerts` (`id`, `name`, `description`, `image_url`, `date`, `start_time`, `end_time`, `venue`, `type`, `created_at`, `updated_at`) VALUES
(16, 'Concert Test 1740517833305', 'Description de test', '/images/concerts/crazy.webp', '2025-09-15', '19:30:00', '22:30:00', 'Salle de Test', 'Rock', '2025-02-25 20:10:40', '2025-02-25 20:10:40'),
(3, 'Crazy Show', 'Le show le plus fou du festival', '/images/concerts/crazy.webp', '2025-07-17', '19:00:00', '22:30:00', 'Scène Rock', 'Concert', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(4, 'Easy Time', 'Moment de détente musicale', '/images/concerts/easy.webp', '2025-07-18', '18:30:00', '22:00:00', 'Scène Pop', 'Concert', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(5, 'Icy Mix', 'Sessions DJ rafraîchissantes', '/images/concerts/icy.webp', '2025-07-19', '22:00:00', '04:00:00', 'Scène Électro', 'DJ Set', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(6, 'Morning Vibes', 'Concert matinal énergisant', '/images/concerts/morning.webp', '2025-07-20', '11:00:00', '14:00:00', 'Scène Principale', 'Concert', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(7, 'Spicy Beats', 'Rythmes endiablés et ambiance festive', '/images/concerts/spicy.webp', '2025-07-20', '20:00:00', '23:00:00', 'Scène Urbaine', 'Concert', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(8, 'test', 'ok', 'http://localhost:3000/admin/concerts', '2025-02-16', '18:00:00', '22:00:00', 'ok', 'test', '2025-02-23 18:52:47', '2025-02-23 18:52:47'),
(9, 'Concert Test 1740511037596', 'Ceci est un concert de test créé par Cypress', 'https://example.com/image.jpg', '2025-09-15', '19:30:00', '22:30:00', 'Salle de Test', 'Rock', '2025-02-25 18:17:29', '2025-02-25 18:17:29'),
(13, 'Concert Test 1740514317874', 'Description de test', NULL, '2025-09-15', '19:30:00', '22:30:00', 'Salle de Test', 'Rock', '2025-02-25 19:12:08', '2025-02-25 19:12:08'),
(10, 'Concert Test 1740512903300', 'Description de test', NULL, '2025-09-15', '19:30:00', '22:30:00', 'Salle de Test', 'Rock', '2025-02-25 18:48:29', '2025-02-25 18:48:29'),
(11, 'Concert Test 1740513442202', 'Description de test', NULL, '2025-09-15', '19:30:00', '22:30:00', 'Salle de Test', 'Rock', '2025-02-25 18:57:28', '2025-02-25 18:57:28'),
(12, 'Concert Test 1740513485241', 'Description de test', NULL, '2025-09-15', '19:30:00', '22:30:00', 'Salle de Test', 'Rock', '2025-02-25 18:58:25', '2025-02-25 18:58:25');

-- --------------------------------------------------------

--
-- Structure de la table `concert_artist`
--

DROP TABLE IF EXISTS `concert_artist`;
CREATE TABLE IF NOT EXISTS `concert_artist` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `artist_id` bigint UNSIGNED NOT NULL,
  `concert_id` bigint UNSIGNED NOT NULL,
  `is_headliner` tinyint(1) NOT NULL DEFAULT '0',
  `performance_order` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `concert_artist_artist_id_concert_id_unique` (`artist_id`,`concert_id`),
  KEY `concert_artist_concert_id_foreign` (`concert_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `meetings`
--

DROP TABLE IF EXISTS `meetings`;
CREATE TABLE IF NOT EXISTS `meetings` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `artist_id` bigint UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `venue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `meetings_artist_id_foreign` (`artist_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `meetings`
--

INSERT INTO `meetings` (`id`, `artist_id`, `title`, `description`, `date`, `start_time`, `end_time`, `venue`, `type`, `created_at`, `updated_at`) VALUES
(12, 1, 'Rencontre Test 1740517006465', 'Description de la rencontre', '2024-08-15', '14:00:00', '16:00:00', 'Lieu de test', 'Meet & Greet', '2025-02-25 19:56:41', '2025-02-25 19:56:51'),
(4, 4, 'Cas Production', 'Masterclass production avec Cas', '2025-07-18', '15:00:00', '16:30:00', 'Studio Production', 'Masterclass', '2025-02-23 07:17:35', '2025-02-23 07:17:35'),
(5, 5, 'Fars Writing', 'Session d\'écriture rap avec Fars', '2025-07-19', '14:00:00', '15:30:00', 'Studio', 'Workshop', '2025-02-23 07:17:35', '2025-02-23 07:17:35'),
(6, 6, 'Sraf Live', 'Session live avec Sraf', '2025-07-20', '11:00:00', '12:30:00', 'Scène B', 'Showcase', '2025-02-23 07:17:35', '2025-02-23 07:17:35'),
(7, 7, 'Fine Acoustic', 'Session acoustique avec Fine', '2025-07-20', '16:00:00', '17:30:00', 'Studio Acoustique', 'Showcase', '2025-02-23 07:17:35', '2025-02-23 07:17:35'),
(8, 1, 'Rencontre Test 1740512040986', 'Description de test', '2025-06-15', '14:00:00', '15:30:00', 'Lieu de Test', 'Workshop', '2025-02-25 18:34:08', '2025-02-25 18:34:08');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2024_08_17_201647_create_participants_table', 1),
(4, '2024_08_17_201841_create_events_table', 1),
(5, '2024_08_17_205443_create_news_table', 1),
(6, '2024_08_17_205558_create_subscribers_table', 1),
(7, '2025_02_21_150819_create_partners_table', 1),
(8, '2025_02_21_150822_create_concerts_table', 1),
(9, '2025_02_21_150823_create_artists_table', 1),
(10, '2025_02_21_150824_create_meetings_table', 1),
(11, '2025_02_21_150826_create_concert_artist_table', 1),
(12, '2025_02_22_055721_create_admin_users_table', 1),
(13, '2025_02_23_173329_create_personal_access_tokens_table', 2),
(14, '2025_02_25_180058_create_concert_artist_table', 3);

-- --------------------------------------------------------

--
-- Structure de la table `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `importance` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `news`
--

INSERT INTO `news` (`id`, `title`, `description`, `category`, `importance`, `created_at`, `updated_at`) VALUES
(8, 'Ouverture buvette', 'A l\'accueil ouverture de la buvette jusqu\'à minuit', 'Festival', 1, '2025-02-25 19:43:54', '2025-02-25 19:43:54'),
(9, 'Partenariat exclusif', 'Description détaillée pour le test de création d\'actualité', 'Festival', 1, '2025-02-25 19:56:04', '2025-02-25 19:56:04'),
(6, 'Partenariat exclusif', 'Un nouveau partenaire rejoint l\'aventure du festival.', 'Partenariat', 2, '2025-02-23 12:29:53', '2025-02-23 12:29:53');

-- --------------------------------------------------------

--
-- Structure de la table `participants`
--

DROP TABLE IF EXISTS `participants`;
CREATE TABLE IF NOT EXISTS `participants` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `participants_email_unique` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `partners`
--

DROP TABLE IF EXISTS `partners`;
CREATE TABLE IF NOT EXISTS `partners` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `partners`
--

INSERT INTO `partners` (`id`, `name`, `description`, `logo_url`, `website_url`, `category`, `created_at`, `updated_at`) VALUES
(1, 'Coffee', 'Fournisseur officiel de café du festival', '/images/partners/coffee.webp', 'https://coffee.com', 'Boisson', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(2, 'CoffeeTime', 'Espace détente et rafraîchissement', '/images/partners/coffeetime.webp', 'https://coffeetime.com', 'Restaurant', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(3, 'Yummy', 'Restauration de qualité pour les festivaliers', '/images/partners/yummy.webp', 'https://yummy.com', 'Food', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(4, 'Fish', 'Restaurant de fruits de mer du festival', '/images/partners/fish.webp', 'https://fish.com', 'Restaurant', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(5, 'Gamer', 'Espace gaming et détente', '/images/partners/gamer.webp', 'https://gamer.com', 'Entertainment', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(6, 'Gaming', 'Animations vidéoludiques', '/images/partners/gaming.webp', 'https://gaming.com', 'Entertainment', '2025-02-23 07:17:34', '2025-02-23 07:17:34'),
(7, 'Yums', 'Street food et snacks', '/images/partners/yums.webp', 'https://yums.com', 'Food', '2025-02-23 07:17:34', '2025-02-23 07:17:34');

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=MyISAM AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\AdminUser', 1, 'admin-token', '34bcfa9d767c5103c6c83f50d85dad07801a416656d9a09d60d13cf66b16fd2f', '[\"*\"]', NULL, NULL, '2025-02-23 16:33:45', '2025-02-23 16:33:45'),
(2, 'App\\Models\\AdminUser', 1, 'admin-token', '5a3cd6953a60ca51092a42ea018d1e18e7ddf979fe57fac2207e213a980a5c84', '[\"*\"]', '2025-02-23 16:33:51', NULL, '2025-02-23 16:33:47', '2025-02-23 16:33:51'),
(3, 'App\\Models\\AdminUser', 1, 'admin-token', '26a5227055d761a9881cabfc97a54cb9e0469b3d8245e1604c66820ef734864e', '[\"*\"]', NULL, NULL, '2025-02-23 16:33:48', '2025-02-23 16:33:48'),
(4, 'App\\Models\\AdminUser', 1, 'admin-token', '2aec9943085e79a67fb53869ae9c1f341fa5f4149ca91af6a8c43dd64f145de3', '[\"*\"]', NULL, NULL, '2025-02-23 17:29:59', '2025-02-23 17:29:59'),
(5, 'App\\Models\\AdminUser', 1, 'admin-token', '582af8f65e42f83a8a6add37d06e5b0dd2ca9e112cd48b0bc37995b896f7c2d4', '[\"*\"]', NULL, NULL, '2025-02-23 17:30:10', '2025-02-23 17:30:10'),
(6, 'App\\Models\\AdminUser', 1, 'admin-token', '1b7db25388be38c18ec43b7952b5a039aefeb9b4355f1c06c4299bbde088abff', '[\"*\"]', NULL, NULL, '2025-02-23 17:30:51', '2025-02-23 17:30:51'),
(7, 'App\\Models\\AdminUser', 1, 'admin-token', '679416753b24e5b01f4500e28faad4ce373ae36f344dbf90515905184d03e931', '[\"*\"]', NULL, NULL, '2025-02-23 17:32:00', '2025-02-23 17:32:00'),
(8, 'App\\Models\\AdminUser', 1, 'admin-token', '91a3e7c8147bf792301b55c240eae7f1b08a494907178f9ca43c5a650dde7c9b', '[\"*\"]', NULL, NULL, '2025-02-23 17:34:54', '2025-02-23 17:34:54'),
(9, 'App\\Models\\AdminUser', 1, 'admin-token', '29a496fce41ba0911f08b9f6889cff47cd090bcd8b852f6843aa70f3a21d7f63', '[\"*\"]', NULL, NULL, '2025-02-23 18:04:39', '2025-02-23 18:04:39'),
(10, 'App\\Models\\AdminUser', 1, 'admin-token', 'a8a44e0b6c90c23c74f75918e92d7fec38fa91207497c3797c41a227bf9cb2cb', '[\"*\"]', NULL, NULL, '2025-02-23 18:09:31', '2025-02-23 18:09:31'),
(11, 'App\\Models\\AdminUser', 1, 'admin-token', 'e5fd008a12346b437faf320384330e4ba754ec3c5229e97c4106463080338515', '[\"*\"]', '2025-02-25 16:09:12', NULL, '2025-02-23 18:13:53', '2025-02-25 16:09:12'),
(12, 'App\\Models\\AdminUser', 1, 'admin-token', '41237c4dadc87de426f6479b4e12bd898f268e4547901beb6e177dee792b2078', '[\"*\"]', NULL, NULL, '2025-02-24 21:13:14', '2025-02-24 21:13:14'),
(13, 'App\\Models\\AdminUser', 1, 'admin-token', '8ae9baf6a88bdce9e6dfa0cc7de13c6f5e5610ab4e8a1b9ac62e09c0f9b1674c', '[\"*\"]', '2025-02-24 21:13:22', NULL, '2025-02-24 21:13:19', '2025-02-24 21:13:22'),
(14, 'App\\Models\\AdminUser', 1, 'admin-token', '6d847195f3122597881d352e6b58db05cb28701061a95a7c91968f2c30c5e464', '[\"*\"]', '2025-02-24 21:13:36', NULL, '2025-02-24 21:13:30', '2025-02-24 21:13:36'),
(15, 'App\\Models\\AdminUser', 1, 'admin-token', '6b07a39b3bb1ed58e0a0e9084091e07a3262e218f49488c1287b02a4a237545b', '[\"*\"]', '2025-02-24 21:14:49', NULL, '2025-02-24 21:14:48', '2025-02-24 21:14:49'),
(16, 'App\\Models\\AdminUser', 1, 'admin-token', 'd0e0dbf73104169b4b12c8020710d4d657f55f80462e993c42e64f9bd1594156', '[\"*\"]', '2025-02-24 21:14:51', NULL, '2025-02-24 21:14:50', '2025-02-24 21:14:51'),
(17, 'App\\Models\\AdminUser', 1, 'admin-token', '80f62043f11938c45bc6be2ce290831ec97b413fb7db929c922757e037166891', '[\"*\"]', '2025-02-24 21:14:59', NULL, '2025-02-24 21:14:55', '2025-02-24 21:14:59'),
(18, 'App\\Models\\AdminUser', 1, 'admin-token', 'a87bd7d66613e54e51423203fb82bee5cfb96e239921302452279aed7da0b5c9', '[\"*\"]', NULL, NULL, '2025-02-25 15:44:41', '2025-02-25 15:44:41'),
(19, 'App\\Models\\AdminUser', 1, 'admin-token', 'aae1e1bf28a659b043a44ca7c957e6b05055376551eeea125e6ad3d643b3b628', '[\"*\"]', '2025-02-25 15:44:53', NULL, '2025-02-25 15:44:50', '2025-02-25 15:44:53'),
(20, 'App\\Models\\AdminUser', 1, 'admin-token', '96879a8beff1ea799eb44ef4d2a75373be39c524b193400c2a77c62dc5553707', '[\"*\"]', '2025-02-25 16:09:18', NULL, '2025-02-25 16:09:17', '2025-02-25 16:09:18'),
(21, 'App\\Models\\AdminUser', 1, 'admin-token', '4efa7ded02b8f8d437091c768dcfd1ca62775a08e864c5aeac486cdd5f054f7b', '[\"*\"]', '2025-02-25 16:09:38', NULL, '2025-02-25 16:09:36', '2025-02-25 16:09:38'),
(22, 'App\\Models\\AdminUser', 1, 'admin-token', 'c4b7254a4f6e6cbdd80dde8c94fc86a4b3a3dd9c31d698f3defbbcf5811be996', '[\"*\"]', NULL, NULL, '2025-02-25 17:35:15', '2025-02-25 17:35:15'),
(23, 'App\\Models\\AdminUser', 1, 'admin-token', 'c0cebb959de6229905ae04dbf3b07d5f285c139b1a2a6bdbcf92393e2153993c', '[\"*\"]', '2025-02-25 17:35:20', NULL, '2025-02-25 17:35:19', '2025-02-25 17:35:20'),
(24, 'App\\Models\\AdminUser', 1, 'admin-token', '533c2f928f26c2ab5be62b0fef6f25218db12ba31675f3cf989e46b63912c08f', '[\"*\"]', '2025-02-25 17:35:29', NULL, '2025-02-25 17:35:23', '2025-02-25 17:35:29'),
(25, 'App\\Models\\AdminUser', 1, 'admin-token', '1fc3be8f243ea24af5e6ec1145882866065efa6405a271d91d4a9209b25eb255', '[\"*\"]', '2025-02-25 17:36:30', NULL, '2025-02-25 17:36:28', '2025-02-25 17:36:30'),
(26, 'App\\Models\\AdminUser', 1, 'admin-token', '6a20b6d21193bc2230eff20c93b4ad54e4ad91bee8a99694df4936b0789dd934', '[\"*\"]', NULL, NULL, '2025-02-25 17:36:35', '2025-02-25 17:36:35'),
(27, 'App\\Models\\AdminUser', 1, 'admin-token', '5dcddd6fade29017e32804069e61e5a46533277b60090d8e7e71bd56f5769013', '[\"*\"]', '2025-02-25 19:46:29', NULL, '2025-02-25 17:56:53', '2025-02-25 19:46:29'),
(28, 'App\\Models\\AdminUser', 1, 'admin-token', '883f8bdf04c5fbbb51dfdf979942e63fe843dc09a84ccd4c04d37d6766d0466e', '[\"*\"]', NULL, NULL, '2025-02-25 18:02:41', '2025-02-25 18:02:41'),
(29, 'App\\Models\\AdminUser', 1, 'admin-token', '799813eb4043fe60686a392fdb5ec549a8f719437513ed77766560dab8decd8e', '[\"*\"]', '2025-02-25 18:04:00', NULL, '2025-02-25 18:03:55', '2025-02-25 18:04:00'),
(30, 'App\\Models\\AdminUser', 1, 'admin-token', '47ba0987bca4c53199fca1be8ef7760193d7a716a5e5aa09a96859a152f50159', '[\"*\"]', NULL, NULL, '2025-02-25 18:08:27', '2025-02-25 18:08:27'),
(31, 'App\\Models\\AdminUser', 1, 'admin-token', '2e435949d682067ea69a25a1d44fe78b8184584ef53dc75ae358c829442fa692', '[\"*\"]', '2025-02-25 18:16:08', NULL, '2025-02-25 18:16:03', '2025-02-25 18:16:08'),
(32, 'App\\Models\\AdminUser', 1, 'admin-token', '179ee3174ba72a25cb932e7c32afb6b4a9f80c47b81fdd0d2809877802b4094c', '[\"*\"]', '2025-02-25 18:16:16', NULL, '2025-02-25 18:16:13', '2025-02-25 18:16:16'),
(33, 'App\\Models\\AdminUser', 1, 'admin-token', 'f7ebf4d7e9c56ea4be23c68e0be8aec245086f4a227b15d2c1540bd04d6fe90c', '[\"*\"]', '2025-02-25 18:16:39', NULL, '2025-02-25 18:16:22', '2025-02-25 18:16:39'),
(34, 'App\\Models\\AdminUser', 1, 'admin-token', '2c94e78625f89f1d4ad8656a0a84561e118193f233472b75b4f60ad70c3abc9d', '[\"*\"]', '2025-02-25 18:16:49', NULL, '2025-02-25 18:16:45', '2025-02-25 18:16:49'),
(35, 'App\\Models\\AdminUser', 1, 'admin-token', '77303edc39c6c431aac496a6cd8de2e29fddb3a9bff39085ad45a66286a411bf', '[\"*\"]', '2025-02-25 18:16:58', NULL, '2025-02-25 18:16:54', '2025-02-25 18:16:58'),
(36, 'App\\Models\\AdminUser', 1, 'admin-token', '6567dd6c656d989eb25eb3dd2d2c95fe54d3c1f9b8c2b4a034c3bb9afdc3035d', '[\"*\"]', '2025-02-25 18:17:25', NULL, '2025-02-25 18:17:11', '2025-02-25 18:17:25'),
(37, 'App\\Models\\AdminUser', 1, 'admin-token', '168e66f2eafcce43bae43c292a53084e9e413014cd3c87dd59336a75168944f8', '[\"*\"]', NULL, NULL, '2025-02-25 18:17:43', '2025-02-25 18:17:43'),
(38, 'App\\Models\\AdminUser', 1, 'admin-token', '9cf0d7c05b12e35b6844869aa0b035bf896d155d29a2965d58fbf98da9985ce2', '[\"*\"]', '2025-02-25 18:25:25', NULL, '2025-02-25 18:25:21', '2025-02-25 18:25:25'),
(39, 'App\\Models\\AdminUser', 1, 'admin-token', 'e7157e08d437fdbfe508ed1badb13673c8080fd9255cef83dcd2c84942194405', '[\"*\"]', '2025-02-25 18:25:37', NULL, '2025-02-25 18:25:34', '2025-02-25 18:25:37'),
(40, 'App\\Models\\AdminUser', 1, 'admin-token', 'dd5dceb63d721c3124cf9b8f273b0239258124932f63a4d91f80920416f37ad7', '[\"*\"]', '2025-02-25 18:25:59', NULL, '2025-02-25 18:25:53', '2025-02-25 18:25:59'),
(41, 'App\\Models\\AdminUser', 1, 'admin-token', '51b345d2305ba297aec4dfc25068ddfe7dbef39b8efdb03374253265e6317519', '[\"*\"]', '2025-02-25 18:33:47', NULL, '2025-02-25 18:33:38', '2025-02-25 18:33:47'),
(42, 'App\\Models\\AdminUser', 1, 'admin-token', '4713aa542c83b2d1b4786875b35e79a759101e24d3ad895a812cfb011ffc8be0', '[\"*\"]', '2025-02-25 18:34:08', NULL, '2025-02-25 18:33:56', '2025-02-25 18:34:08'),
(43, 'App\\Models\\AdminUser', 1, 'admin-token', '88029c0265171274d2e4ab206de214b2e064eb394970298a01c012b893149788', '[\"*\"]', '2025-02-25 18:34:22', NULL, '2025-02-25 18:34:16', '2025-02-25 18:34:22'),
(44, 'App\\Models\\AdminUser', 1, 'admin-token', '4c5c91d750f147f6e6759519db0430eef5410a091ab723670a31cd999a9cdb8b', '[\"*\"]', '2025-02-25 18:34:46', NULL, '2025-02-25 18:34:41', '2025-02-25 18:34:46'),
(45, 'App\\Models\\AdminUser', 1, 'admin-token', '1ae9c577354b5f48680a270064b400ce274c49b0f85362ad6ae7544ea5ce56a3', '[\"*\"]', '2025-02-25 18:34:57', NULL, '2025-02-25 18:34:52', '2025-02-25 18:34:57'),
(46, 'App\\Models\\AdminUser', 1, 'admin-token', '26182fbcc68fddf1068025d23482b2f87431d9b3cb40f7b8d2c1691e9e402006', '[\"*\"]', '2025-02-25 18:35:23', NULL, '2025-02-25 18:35:05', '2025-02-25 18:35:23'),
(47, 'App\\Models\\AdminUser', 1, 'admin-token', 'f1cedacc50399388eac4cfc86b83c0fac520c2e50ab0c11044cf78ed436885c7', '[\"*\"]', '2025-02-25 18:35:36', NULL, '2025-02-25 18:35:32', '2025-02-25 18:35:36'),
(48, 'App\\Models\\AdminUser', 1, 'admin-token', 'a78a0156054a9dc56b21e81940143db23e1914a9d7d53c871b7d00625e30d301', '[\"*\"]', '2025-02-25 18:35:45', NULL, '2025-02-25 18:35:41', '2025-02-25 18:35:45'),
(49, 'App\\Models\\AdminUser', 1, 'admin-token', '22fdb7e2b2a8ad75a2b2b9166bbff815c4fbf1ab834773ef3e6c8d6afcd82b3d', '[\"*\"]', '2025-02-25 18:36:04', NULL, '2025-02-25 18:36:00', '2025-02-25 18:36:04'),
(50, 'App\\Models\\AdminUser', 1, 'admin-token', '26edc336a6e0e0e783e83e3b24e9569024f0f5de67e63e54df6a1a5e46c35af7', '[\"*\"]', NULL, NULL, '2025-02-25 18:39:14', '2025-02-25 18:39:14'),
(51, 'App\\Models\\AdminUser', 1, 'admin-token', '03e59dc237a1b80fd87061be1ac3effd3b87006f31c1b0c676ebc29b2c5318f8', '[\"*\"]', '2025-02-25 18:39:41', NULL, '2025-02-25 18:39:34', '2025-02-25 18:39:41'),
(52, 'App\\Models\\AdminUser', 1, 'admin-token', '7e6333f8ab7d00bc7ded3aba0825f1722c58c0cc164defb6ab8e00fce7d43249', '[\"*\"]', '2025-02-25 18:39:52', NULL, '2025-02-25 18:39:47', '2025-02-25 18:39:52'),
(53, 'App\\Models\\AdminUser', 1, 'admin-token', '84bbd8c6cfa4d08c4372a6743f9cb4c73cc02da481181ad8b3fba8ddb58ca1cc', '[\"*\"]', '2025-02-25 18:40:17', NULL, '2025-02-25 18:40:09', '2025-02-25 18:40:17'),
(54, 'App\\Models\\AdminUser', 1, 'admin-token', 'b9a8ef5df5dcae4ff74c82015ea0f64a1b655ec4314a8a80e3d2ab6d45419a50', '[\"*\"]', '2025-02-25 18:40:28', NULL, '2025-02-25 18:40:25', '2025-02-25 18:40:28'),
(55, 'App\\Models\\AdminUser', 1, 'admin-token', 'a2519835483adfb519ef1f35d55fedca0fa04e31e0533bfd11982e24bf7ba5c4', '[\"*\"]', '2025-02-25 18:41:16', NULL, '2025-02-25 18:41:12', '2025-02-25 18:41:16'),
(56, 'App\\Models\\AdminUser', 1, 'admin-token', '7c6ff3765c5f4ecf31354d1d40428f29819aeb23b79c46d86440386a1e7284a9', '[\"*\"]', '2025-02-25 18:41:39', NULL, '2025-02-25 18:41:34', '2025-02-25 18:41:39'),
(57, 'App\\Models\\AdminUser', 1, 'admin-token', 'f92425cfd7640610faa213c764d8c71788b5f6c03dcd3eb1ae16882738de7c66', '[\"*\"]', '2025-02-25 18:42:04', NULL, '2025-02-25 18:41:57', '2025-02-25 18:42:04'),
(58, 'App\\Models\\AdminUser', 1, 'admin-token', '2da4c1ee5b7bd1d2d739d4aa062437194d102f0c9a42dee2cffc1edf812288f7', '[\"*\"]', '2025-02-25 18:42:20', NULL, '2025-02-25 18:42:11', '2025-02-25 18:42:20'),
(59, 'App\\Models\\AdminUser', 1, 'admin-token', 'c3a8ddbfffb5208a9a5539354569403879a007ce9e1602db74eadb4f1a9f9bdc', '[\"*\"]', NULL, NULL, '2025-02-25 18:46:33', '2025-02-25 18:46:33'),
(60, 'App\\Models\\AdminUser', 1, 'admin-token', '2558639180582f01ea98c4e5f7cdbaed4bc476eea711ceb348fbda2ddfc15f37', '[\"*\"]', '2025-02-25 18:47:03', NULL, '2025-02-25 18:46:57', '2025-02-25 18:47:03'),
(61, 'App\\Models\\AdminUser', 1, 'admin-token', '546afe03217e5552c57179e4a8608d280bc139f156d3322575ade99478477822', '[\"*\"]', '2025-02-25 18:47:31', NULL, '2025-02-25 18:47:20', '2025-02-25 18:47:31'),
(62, 'App\\Models\\AdminUser', 1, 'admin-token', 'f9b3637f1f9f0470f57718b6a70f9af6894f969fc6f050a9a82f954fc043e9fc', '[\"*\"]', '2025-02-25 18:47:44', NULL, '2025-02-25 18:47:37', '2025-02-25 18:47:44'),
(63, 'App\\Models\\AdminUser', 1, 'admin-token', '4803b56169da29a3b4bb7af14e3b37ab35ee1fc934ac66ca8e0c81b04e963fb1', '[\"*\"]', '2025-02-25 18:47:54', NULL, '2025-02-25 18:47:49', '2025-02-25 18:47:54'),
(64, 'App\\Models\\AdminUser', 1, 'admin-token', '53c82ddf51af83006dc2ad5c0c33e69800e55bf48fbdc7ff28106228f2c968c5', '[\"*\"]', '2025-02-25 18:48:13', NULL, '2025-02-25 18:48:09', '2025-02-25 18:48:13'),
(65, 'App\\Models\\AdminUser', 1, 'admin-token', 'eb9882a11a5ce89843f3da2d42f0cbc355355e2be433b36f1703b6abe8a73415', '[\"*\"]', '2025-02-25 18:48:28', NULL, '2025-02-25 18:48:19', '2025-02-25 18:48:28'),
(66, 'App\\Models\\AdminUser', 1, 'admin-token', '9514a5cdc6a86d49de01c704d2cb360dd1fe5a0f4e277cde74f06b123e55769e', '[\"*\"]', '2025-02-25 18:48:41', NULL, '2025-02-25 18:48:34', '2025-02-25 18:48:41'),
(67, 'App\\Models\\AdminUser', 1, 'admin-token', '9d44669af14e6a723f75e392d3a646d447068b4022eddd66dff4c60455345d43', '[\"*\"]', '2025-02-25 18:48:50', NULL, '2025-02-25 18:48:46', '2025-02-25 18:48:50'),
(68, 'App\\Models\\AdminUser', 1, 'admin-token', '3991f1758762a5d2f6e1bb884c1d93762313fb385fddfdff4c2bb849d35229cf', '[\"*\"]', '2025-02-25 18:49:16', NULL, '2025-02-25 18:49:13', '2025-02-25 18:49:16'),
(69, 'App\\Models\\AdminUser', 1, 'admin-token', '126d6d69738cd129a1bc53d67e851fa33d56b536a441a1ec665ceb9a21ecce22', '[\"*\"]', '2025-02-25 18:49:29', NULL, '2025-02-25 18:49:23', '2025-02-25 18:49:29'),
(70, 'App\\Models\\AdminUser', 1, 'admin-token', '4102e72a598c0e0b192c52f49d30a968f6aac83b7112f78e29868adcdd06fcc2', '[\"*\"]', '2025-02-25 18:50:03', NULL, '2025-02-25 18:50:00', '2025-02-25 18:50:03'),
(71, 'App\\Models\\AdminUser', 1, 'admin-token', '11634cc84d87883847d46a51a655178e09617eb3206fcbc8b5cc10596bed66d2', '[\"*\"]', '2025-02-25 18:50:15', NULL, '2025-02-25 18:50:09', '2025-02-25 18:50:15'),
(72, 'App\\Models\\AdminUser', 1, 'admin-token', '0be3be221d991caac4fbf35e7d0fd9935fd6f336ccbfcf1a0186b0222d5bee6c', '[\"*\"]', '2025-02-25 18:50:29', NULL, '2025-02-25 18:50:25', '2025-02-25 18:50:29'),
(73, 'App\\Models\\AdminUser', 1, 'admin-token', 'bda3571286524fd53e201651ef2ab92061c7704ba27706a8a440dd3ead33c48f', '[\"*\"]', NULL, NULL, '2025-02-25 18:50:41', '2025-02-25 18:50:41'),
(74, 'App\\Models\\AdminUser', 1, 'admin-token', '55e8284cc76dac689ecc4fe67c540c62b5de7d48769e7a29d6f6d39181c1ed6a', '[\"*\"]', '2025-02-25 18:50:54', NULL, '2025-02-25 18:50:52', '2025-02-25 18:50:54'),
(75, 'App\\Models\\AdminUser', 1, 'admin-token', '70237d83316f3a35b68684eab621d4f0dc7197696501e4d4aaa7d3575ebfdc10', '[\"*\"]', '2025-02-25 18:51:18', NULL, '2025-02-25 18:51:05', '2025-02-25 18:51:18'),
(76, 'App\\Models\\AdminUser', 1, 'admin-token', 'c3753b04584fa399f0a0958d4468e6390e7215439abf65e1ec6ae8ded19ac9a6', '[\"*\"]', '2025-02-25 18:51:38', NULL, '2025-02-25 18:51:27', '2025-02-25 18:51:38'),
(77, 'App\\Models\\AdminUser', 1, 'admin-token', 'cf6e0b6e40c630fcaccfe4c23ae2cf43ceaaa7d6ffa356b535870e7019470471', '[\"*\"]', '2025-02-25 18:51:51', NULL, '2025-02-25 18:51:46', '2025-02-25 18:51:51'),
(78, 'App\\Models\\AdminUser', 1, 'admin-token', '97efac0c58e17fc73583a9dab9ac08d1723c857ad8a4595350695bddaaa46ff5', '[\"*\"]', '2025-02-25 18:56:17', NULL, '2025-02-25 18:56:14', '2025-02-25 18:56:17'),
(79, 'App\\Models\\AdminUser', 1, 'admin-token', '10d265157566b8f52ce3d2010f9ea86a9636e14338bd05642a70216ec38a705f', '[\"*\"]', '2025-02-25 18:56:46', NULL, '2025-02-25 18:56:32', '2025-02-25 18:56:46'),
(80, 'App\\Models\\AdminUser', 1, 'admin-token', '93367641e7ad95a03681ca4b3d9a73e0f0f9bf62ccffc20bd2014b508bf355e6', '[\"*\"]', '2025-02-25 18:56:54', NULL, '2025-02-25 18:56:50', '2025-02-25 18:56:54'),
(81, 'App\\Models\\AdminUser', 1, 'admin-token', 'bcc249a4462e8d4e841c56337ae2b84b291f3496798550adef0a63be594645a9', '[\"*\"]', '2025-02-25 18:57:02', NULL, '2025-02-25 18:56:58', '2025-02-25 18:57:02'),
(82, 'App\\Models\\AdminUser', 1, 'admin-token', '0c45f50729ddc3d69ceea78663b30308ae417fbca3d4ba1e9d177fa9fb9ae9e7', '[\"*\"]', '2025-02-25 18:57:14', NULL, '2025-02-25 18:57:13', '2025-02-25 18:57:14'),
(83, 'App\\Models\\AdminUser', 1, 'admin-token', '70a50de5f1398a6ba8306e58e284dd8f08f5b5eb654c6a10c39cc5b59311a528', '[\"*\"]', '2025-02-25 18:57:28', NULL, '2025-02-25 18:57:20', '2025-02-25 18:57:28'),
(84, 'App\\Models\\AdminUser', 1, 'admin-token', '6ab66e1120d66771d06e60f0f898148b05b5a6528b4cd4b27c697bc022ed7c74', '[\"*\"]', '2025-02-25 18:57:36', NULL, '2025-02-25 18:57:31', '2025-02-25 18:57:36'),
(85, 'App\\Models\\AdminUser', 1, 'admin-token', '414e9255902b6ca993e7952b9f835788403a752fc1731a8076a1f7edd49382f1', '[\"*\"]', NULL, NULL, '2025-02-25 18:57:41', '2025-02-25 18:57:41'),
(86, 'App\\Models\\AdminUser', 1, 'admin-token', '0bca95c0c8f1b8d8560c8a020c556e988ce2a0767b7e7411434ece03f080ff8b', '[\"*\"]', '2025-02-25 18:57:53', NULL, '2025-02-25 18:57:50', '2025-02-25 18:57:53'),
(87, 'App\\Models\\AdminUser', 1, 'admin-token', 'ee16ac655f052d7300267a905f6ccce8b03f44e879faa9f261009c1a51cf1977', '[\"*\"]', '2025-02-25 18:58:25', NULL, '2025-02-25 18:58:02', '2025-02-25 18:58:25'),
(88, 'App\\Models\\AdminUser', 1, 'admin-token', '9d907023785331ce5746d00a517c0fb30abcccc60dfc74e45ddccdd4bfe70c10', '[\"*\"]', '2025-02-25 18:58:33', NULL, '2025-02-25 18:58:29', '2025-02-25 18:58:33'),
(89, 'App\\Models\\AdminUser', 1, 'admin-token', '97d8f9ca827e79077571fdd72372f7f1121fb5eeefc3fd3d814f542c83d4d621', '[\"*\"]', '2025-02-25 18:58:38', NULL, '2025-02-25 18:58:37', '2025-02-25 18:58:38'),
(90, 'App\\Models\\AdminUser', 1, 'admin-token', 'cb490ed4cae390d328e741c5f41eef2c9451690c53c59929635c79f19ff41b81', '[\"*\"]', '2025-02-25 19:06:20', NULL, '2025-02-25 19:06:03', '2025-02-25 19:06:20'),
(91, 'App\\Models\\AdminUser', 1, 'admin-token', 'a25fc787e89ca0ea6e83b99b68b9b78f206dc831bf851fc056a2c750b07d9539', '[\"*\"]', '2025-02-25 19:06:43', NULL, '2025-02-25 19:06:37', '2025-02-25 19:06:43'),
(92, 'App\\Models\\AdminUser', 1, 'admin-token', '144b085fe98b5661915d6a024596c4d0e1e5936cf08ba3006b58b2b433e9fa34', '[\"*\"]', '2025-02-25 19:07:13', NULL, '2025-02-25 19:07:08', '2025-02-25 19:07:13'),
(93, 'App\\Models\\AdminUser', 1, 'admin-token', '3444d6854ad61894ea7f08d7d38574cb04dae2a0469c38c16b1959608db48ddb', '[\"*\"]', '2025-02-25 19:07:49', NULL, '2025-02-25 19:07:47', '2025-02-25 19:07:49'),
(94, 'App\\Models\\AdminUser', 1, 'admin-token', '703cf937f50a4906c75654ad313d1a261786cbbdfe6a97957621e68c61385b5d', '[\"*\"]', '2025-02-25 19:08:10', NULL, '2025-02-25 19:07:57', '2025-02-25 19:08:10'),
(95, 'App\\Models\\AdminUser', 1, 'admin-token', '9e813e29513e7acebe87fbc990fdf4dc1061d0f191bddae953b5f1b2ec84240b', '[\"*\"]', '2025-02-25 19:08:38', NULL, '2025-02-25 19:08:31', '2025-02-25 19:08:38'),
(96, 'App\\Models\\AdminUser', 1, 'admin-token', 'dfaf52f2764a584757b470a48432b3ca02cb7f97758744f8950d7af4a2dfbfe0', '[\"*\"]', '2025-02-25 19:11:35', NULL, '2025-02-25 19:11:27', '2025-02-25 19:11:35'),
(97, 'App\\Models\\AdminUser', 1, 'admin-token', '788e012f39b1273eb0e3ec0580871b81113cccbec17d96066f671469dcf1dca7', '[\"*\"]', '2025-02-25 19:12:08', NULL, '2025-02-25 19:11:50', '2025-02-25 19:12:08'),
(98, 'App\\Models\\AdminUser', 1, 'admin-token', '103416da1af51adf4919fd1fa96e7bc9d2a80849f32f55772337e07cf91aedb7', '[\"*\"]', '2025-02-25 19:12:21', NULL, '2025-02-25 19:12:16', '2025-02-25 19:12:21'),
(99, 'App\\Models\\AdminUser', 1, 'admin-token', 'b89b50a67e45847498eda8ccd3d9ea679dde1ff16db17fc040e8dba6624810e5', '[\"*\"]', '2025-02-25 19:12:32', NULL, '2025-02-25 19:12:27', '2025-02-25 19:12:32'),
(100, 'App\\Models\\AdminUser', 1, 'admin-token', '9b2ee1f4252f04826f76e0626cc27d2258a97e5ed8a0e030b355cc653fdd106c', '[\"*\"]', '2025-02-25 19:12:56', NULL, '2025-02-25 19:12:54', '2025-02-25 19:12:56'),
(101, 'App\\Models\\AdminUser', 1, 'admin-token', '830e5143299f376bc60a28d9cf0eaa870378ba174fdd76f5c2155f35bb41f276', '[\"*\"]', '2025-02-25 19:13:13', NULL, '2025-02-25 19:13:01', '2025-02-25 19:13:13'),
(102, 'App\\Models\\AdminUser', 1, 'admin-token', '40e18195e8234f0ae1a3588cab9e9b7d4d13cb1fb340e8ca7fcb6fef59084742', '[\"*\"]', '2025-02-25 19:13:24', NULL, '2025-02-25 19:13:22', '2025-02-25 19:13:24'),
(103, 'App\\Models\\AdminUser', 1, 'admin-token', 'a4b228755043bd3c2f9ed62ce590c51168c83d9de1df586b28aaf5025ba15be2', '[\"*\"]', '2025-02-25 19:13:42', NULL, '2025-02-25 19:13:37', '2025-02-25 19:13:42'),
(104, 'App\\Models\\AdminUser', 1, 'admin-token', 'feaecf4166699918c7ae9e886630f22c07be014a192a750afcb5137b930ada8a', '[\"*\"]', '2025-02-25 19:17:12', NULL, '2025-02-25 19:17:02', '2025-02-25 19:17:12'),
(105, 'App\\Models\\AdminUser', 1, 'admin-token', 'dab07cbbfd7dce95549585ed3f5982030bf75f710a1b4c5df47148b8e70e2e2e', '[\"*\"]', '2025-02-25 19:17:33', NULL, '2025-02-25 19:17:22', '2025-02-25 19:17:33'),
(106, 'App\\Models\\AdminUser', 1, 'admin-token', '976bed48165caef0a774e8cca091d70bb27b7e23c18cf3a7d52f143c988a8eef', '[\"*\"]', '2025-02-25 19:17:40', NULL, '2025-02-25 19:17:39', '2025-02-25 19:17:40'),
(107, 'App\\Models\\AdminUser', 1, 'admin-token', 'e851f20ed54b15c241a8218bf810cae3430ab65e31e7768f65f205fea1bc00e1', '[\"*\"]', '2025-02-25 19:17:58', NULL, '2025-02-25 19:17:53', '2025-02-25 19:17:58'),
(108, 'App\\Models\\AdminUser', 1, 'admin-token', 'e811f4412cdfb445cf0c9f5da176c5740fd87a2f8520a3d3ff8ed55fe6ecbd97', '[\"*\"]', '2025-02-25 19:27:09', NULL, '2025-02-25 19:27:04', '2025-02-25 19:27:09'),
(109, 'App\\Models\\AdminUser', 1, 'admin-token', 'dc14ec6120de104939319c9ff7820ef7b117d21c92005db7c79cfd45a8d9955b', '[\"*\"]', '2025-02-25 19:28:29', NULL, '2025-02-25 19:27:28', '2025-02-25 19:28:29'),
(110, 'App\\Models\\AdminUser', 1, 'admin-token', 'aadfeec6ea9eb71f2fa758f29e6e2758290e9c3db9c15c26d854c9afad1969bf', '[\"*\"]', '2025-02-25 19:29:56', NULL, '2025-02-25 19:29:53', '2025-02-25 19:29:56'),
(111, 'App\\Models\\AdminUser', 1, 'admin-token', 'd1a87425d0faef2ecdee9ab88ef3c33e5ab454240c9d6e0d9905e3315ea9ce82', '[\"*\"]', '2025-02-25 19:30:45', NULL, '2025-02-25 19:30:13', '2025-02-25 19:30:45'),
(112, 'App\\Models\\AdminUser', 1, 'admin-token', '4feabd047be62939eaa2fa870cb68ee85b49327661524676209a41b3d9d4d9ae', '[\"*\"]', NULL, NULL, '2025-02-25 19:31:03', '2025-02-25 19:31:03'),
(113, 'App\\Models\\AdminUser', 1, 'admin-token', 'de15fb435674524d13436fc4d63dc1108a539ae6ee793460498ca4f95261034e', '[\"*\"]', NULL, NULL, '2025-02-25 19:33:10', '2025-02-25 19:33:10'),
(114, 'App\\Models\\AdminUser', 1, 'admin-token', 'bf3a5f70eae7e0f5b7be545d234cd797982a53a76ff3f99f64e047b9017ef44f', '[\"*\"]', '2025-02-25 19:35:23', NULL, '2025-02-25 19:35:18', '2025-02-25 19:35:23'),
(115, 'App\\Models\\AdminUser', 1, 'admin-token', '680f3a828645e184ba9ec0e0f6fd031f5e958f56eb16fce8177165db18420103', '[\"*\"]', '2025-02-25 19:36:11', NULL, '2025-02-25 19:35:38', '2025-02-25 19:36:11'),
(116, 'App\\Models\\AdminUser', 1, 'admin-token', '2d937667474f64385d4393fcb833f69ce75ade5c1922fce8729db4c00e35b69a', '[\"*\"]', '2025-02-25 19:36:25', NULL, '2025-02-25 19:36:23', '2025-02-25 19:36:25'),
(117, 'App\\Models\\AdminUser', 1, 'admin-token', 'ddaffa0c1ad5db47b398082593cee0357b38e8c092a9750b67323b70dfbe1b4f', '[\"*\"]', '2025-02-25 19:36:45', NULL, '2025-02-25 19:36:38', '2025-02-25 19:36:45'),
(118, 'App\\Models\\AdminUser', 1, 'admin-token', '82b0cdc6e6bd5ed2517c0f3c30e1b8e72a0bb5a1ab3e44b71d8a202f835f3df9', '[\"*\"]', '2025-02-25 19:37:21', NULL, '2025-02-25 19:37:14', '2025-02-25 19:37:21'),
(119, 'App\\Models\\AdminUser', 1, 'admin-token', '8aeb1c0017ddcfd9c85d852ed8962639f2850263f9be194e7735676788b87ba9', '[\"*\"]', '2025-02-25 19:48:20', NULL, '2025-02-25 19:48:18', '2025-02-25 19:48:20'),
(120, 'App\\Models\\AdminUser', 1, 'admin-token', '832bce55c6e20bd69ce0642be64e1e6d15e0a4f4094bbe407b792489b6ceb032', '[\"*\"]', '2025-02-25 19:48:33', NULL, '2025-02-25 19:48:27', '2025-02-25 19:48:33'),
(121, 'App\\Models\\AdminUser', 1, 'admin-token', '4157214a1a4401801fbe7c2b442a454a379051564616a21e8f12ca043c68582e', '[\"*\"]', '2025-02-25 19:48:42', NULL, '2025-02-25 19:48:37', '2025-02-25 19:48:42'),
(122, 'App\\Models\\AdminUser', 1, 'admin-token', 'f2cd21e646cc03ce329f6b96dbd4925eede031479a4ca10911f937bafe55717c', '[\"*\"]', '2025-02-25 19:48:49', NULL, '2025-02-25 19:48:45', '2025-02-25 19:48:49'),
(123, 'App\\Models\\AdminUser', 1, 'admin-token', 'e993913151848e942aca1ea33e2cb204b8d718aff5bf2e0bdf6f73eb4c963479', '[\"*\"]', '2025-02-25 19:56:04', NULL, '2025-02-25 19:55:57', '2025-02-25 19:56:04'),
(124, 'App\\Models\\AdminUser', 1, 'admin-token', 'a0e8da4690ab5d7ec254a69ab02051fd0c9f9acbc0d9a2250f5e00b401b2bada', '[\"*\"]', '2025-02-25 19:56:12', NULL, '2025-02-25 19:56:07', '2025-02-25 19:56:12'),
(125, 'App\\Models\\AdminUser', 1, 'admin-token', 'd3b3fcd74fa4cb19d98d5d2c91b544c8cd6aeb41d21e2f64991514a17eb362ac', '[\"*\"]', '2025-02-25 19:56:19', NULL, '2025-02-25 19:56:15', '2025-02-25 19:56:19'),
(126, 'App\\Models\\AdminUser', 1, 'admin-token', '6e10a6e8dce3dc47fb8e843f8b19b18f921d31b6bff614ad2405438daeec98c9', '[\"*\"]', '2025-02-25 19:56:41', NULL, '2025-02-25 19:56:34', '2025-02-25 19:56:41'),
(127, 'App\\Models\\AdminUser', 1, 'admin-token', '6b3c99181da9421522aa3f9babaef3f4b1a047a6da99d92c5f71479abb9c428d', '[\"*\"]', '2025-02-25 19:56:51', NULL, '2025-02-25 19:56:45', '2025-02-25 19:56:51'),
(128, 'App\\Models\\AdminUser', 1, 'admin-token', '917d2ea5a40c2e4f42d80cf40ed72fa7fc883689e34f1f22fc37e468e2f287dd', '[\"*\"]', '2025-02-25 19:57:31', NULL, '2025-02-25 19:57:24', '2025-02-25 19:57:31'),
(129, 'App\\Models\\AdminUser', 1, 'admin-token', '915b6459e25ac8b2efa24b009f6f58e07f1a85c3e5f8e253878c82b62c17083a', '[\"*\"]', '2025-02-25 19:57:39', NULL, '2025-02-25 19:57:35', '2025-02-25 19:57:39'),
(130, 'App\\Models\\AdminUser', 1, 'admin-token', 'a7064bbfa4cf78dd5a503d9fb34c3eaa8be7724fc831c5e45c4aec88b97691f0', '[\"*\"]', '2025-02-25 19:57:45', NULL, '2025-02-25 19:57:42', '2025-02-25 19:57:45'),
(131, 'App\\Models\\AdminUser', 1, 'admin-token', 'a33da81f221e941facf9958433055c89394dfdbb06932c6f73f2dff7c85cd796', '[\"*\"]', '2025-02-25 20:08:58', NULL, '2025-02-25 20:08:57', '2025-02-25 20:08:58'),
(132, 'App\\Models\\AdminUser', 1, 'admin-token', '88de92fd912564d35f5add8c137a0d8fda68a583e80e81b9051662e0dfe86018', '[\"*\"]', '2025-02-25 20:10:04', NULL, '2025-02-25 20:10:02', '2025-02-25 20:10:04'),
(133, 'App\\Models\\AdminUser', 1, 'admin-token', '17598707023a21510ed70ea06f10f92f798f8a446ec94e2dabfc85a1370301aa', '[\"*\"]', '2025-02-25 20:10:16', NULL, '2025-02-25 20:10:15', '2025-02-25 20:10:16'),
(134, 'App\\Models\\AdminUser', 1, 'admin-token', '1649e5a985dcf7dd24e9e6cc198c5f4c9cd9d5680561ca4f192355036d35aa2b', '[\"*\"]', '2025-02-25 20:10:40', NULL, '2025-02-25 20:10:31', '2025-02-25 20:10:40'),
(135, 'App\\Models\\AdminUser', 1, 'admin-token', '7ac36e747ef0633c794a3aeb7ad781c92ae5788605eeafefa00456738e460ed1', '[\"*\"]', NULL, NULL, '2025-02-25 20:10:44', '2025-02-25 20:10:44'),
(136, 'App\\Models\\AdminUser', 1, 'admin-token', 'fa266591edca8fd414d17c1d7303622c8e036959450fb40752d57118e25bcaf1', '[\"*\"]', '2025-02-25 20:10:57', NULL, '2025-02-25 20:10:53', '2025-02-25 20:10:57'),
(137, 'App\\Models\\AdminUser', 1, 'admin-token', '291458a355fc1d40a231f044c6843567037bbebf7e52515142339ef5635e416a', '[\"*\"]', '2025-02-25 20:37:41', NULL, '2025-02-25 20:37:39', '2025-02-25 20:37:41'),
(138, 'App\\Models\\AdminUser', 1, 'admin-token', '6dd103b0d863b396a85c2387a029c85218987ecf19c6d250f1b553627d75519e', '[\"*\"]', '2025-02-25 20:37:45', NULL, '2025-02-25 20:37:44', '2025-02-25 20:37:45'),
(139, 'App\\Models\\AdminUser', 1, 'admin-token', '5e5d5e70f34bce0cd234672de86bf86162f1122f081d701aff74ab527babf6f3', '[\"*\"]', '2025-02-25 20:37:54', NULL, '2025-02-25 20:37:49', '2025-02-25 20:37:54'),
(140, 'App\\Models\\AdminUser', 1, 'admin-token', '3d8963142a595739ee5307ae0bd572e7ce42febd8d76b550ec4beed13438d4a1', '[\"*\"]', '2025-02-25 20:38:00', NULL, '2025-02-25 20:37:59', '2025-02-25 20:38:00'),
(141, 'App\\Models\\AdminUser', 1, 'admin-token', '37fc382a76e997162d9398048fd7df563dad2a15068959b2917fe47fabe3de0f', '[\"*\"]', '2025-02-25 20:38:16', NULL, '2025-02-25 20:38:15', '2025-02-25 20:38:16'),
(142, 'App\\Models\\AdminUser', 1, 'admin-token', 'cab07acdbecc13d2813d90038b74534f92c29a4cc9dbe18fd4e91efa61a4217f', '[\"*\"]', '2025-02-25 20:49:50', NULL, '2025-02-25 20:49:48', '2025-02-25 20:49:50'),
(143, 'App\\Models\\AdminUser', 1, 'admin-token', 'd373f85bcdf98b13cda631be88c244b8484aec15bb613ee194396b65e0868dac', '[\"*\"]', '2025-02-25 20:50:06', NULL, '2025-02-25 20:49:58', '2025-02-25 20:50:06'),
(144, 'App\\Models\\AdminUser', 1, 'admin-token', 'e37a0845794732455193c30ece827a72601139f019e32fbed34cbf0883838bcf', '[\"*\"]', '2025-02-25 20:50:14', NULL, '2025-02-25 20:50:09', '2025-02-25 20:50:14'),
(145, 'App\\Models\\AdminUser', 1, 'admin-token', '71fb83937f54bae1d3f9d01654942d60d54720e5a92d21194e0593969222f61a', '[\"*\"]', '2025-02-25 20:50:20', NULL, '2025-02-25 20:50:17', '2025-02-25 20:50:20');

-- --------------------------------------------------------

--
-- Structure de la table `subscribers`
--

DROP TABLE IF EXISTS `subscribers`;
CREATE TABLE IF NOT EXISTS `subscribers` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscribers_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `subscribers`
--

INSERT INTO `subscribers` (`id`, `first_name`, `last_name`, `email`, `created_at`, `updated_at`) VALUES
(1, 'ok', 'ok', 'ko@ko.com', '2025-02-23 20:12:36', '2025-02-23 20:12:36'),
(2, 'aa', 'aa', 'a@a.com', '2025-02-23 20:13:11', '2025-02-23 20:13:11');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
