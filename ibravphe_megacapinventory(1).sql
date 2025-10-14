-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 13, 2025 at 02:28 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ibravphe_megacapinventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `alternative_phone` varchar(255) DEFAULT NULL,
  `state` bigint(20) NOT NULL,
  `area` bigint(20) NOT NULL,
  `address_details` text NOT NULL,
  `comment` text DEFAULT NULL,
  `address_type` enum('1','2') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `check_in` time DEFAULT NULL,
  `check_out` time DEFAULT NULL,
  `attendance_status` int(11) NOT NULL DEFAULT 1,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country_code` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `customer_id`, `name`, `country_code`, `phone`, `email`, `address`, `product_name`, `product_number`, `details`, `status`, `created_at`, `updated_at`) VALUES
(34, 4, 'kawsar', '+1', '1836310972', NULL, 'Dhaka', 'iPhone', '123456786y5t4rj', 'Test message here', '1', '2025-01-05 22:34:24', '2025-01-05 22:34:24'),
(35, 12, 'fgddgddg', '', '15555555550', 'shawonmahmodul12@gmail.com', 'hgchgcgh', 'xyz', '76567576', 'Hey team quickphonefixandmore.com,\r\n\r\nI would like to discuss SEO!\r\n\r\nI can help your website to get on first page of Google and increase the number of leads and sales you are getting from your website.\r\n\r\nMay I send you a quote & price list?\r\n\r\nWell wishes,\r\nPaul S\r\n+1 (949) 313-8897\r\nPaul S| Lets Get You Optimize\r\nSr SEO consultant\r\nwww.letsgetuoptimize.com\r\nPhone No: +1 (949) 313-8897', '1', '2024-12-21 21:21:11', '2024-12-21 21:21:11'),
(36, 4, 'rakib', '+1', '2674621981', NULL, '519 W Eighth St, B', 'iPhone', '0000000000000', 'screen brock', '1', '2025-01-05 22:26:12', '2025-01-05 22:26:12'),
(38, 4, 'Saddam', '+1', '3254645745', NULL, '1404 Newkirk Avenue, Brooklyn, NY-11226', 'iPhone', 'sfsdgdsgas', 'this is a test sms', '1', '2025-01-05 22:22:11', '2025-01-05 22:22:11'),
(39, 4, 'siraz', '+1', '2674621981', NULL, '819 shaw ave', 'iPhone', '123456789101112', 'my phone is not trun on', '1', '2025-01-04 21:32:03', '2025-01-04 21:32:03');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'sd', 1, '2025-06-01 08:25:44', '2025-06-01 08:25:44', NULL),
(3, 'HP', 1, '2025-06-01 08:39:06', '2025-06-01 08:39:06', NULL),
(4, 'Canon', 1, '2025-06-22 13:41:47', '2025-06-22 13:41:47', NULL),
(5, 'Epson', 1, '2025-06-30 03:53:57', '2025-06-30 03:53:57', NULL),
(6, 'Brother', 1, '2025-06-30 03:54:05', '2025-06-30 03:54:05', NULL),
(7, 'Zebra', 1, '2025-07-14 14:10:03', '2025-07-14 14:10:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `country_code` varchar(255) DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `address` text DEFAULT NULL,
  `images` varchar(255) DEFAULT NULL,
  `verification_code` int(11) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `billing_address` bigint(20) DEFAULT NULL,
  `shipping_address` bigint(20) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `country_code`, `phone`, `email`, `email_verified_at`, `address`, `images`, `verification_code`, `is_verified`, `billing_address`, `shipping_address`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Shellie Rodriguez', '', '677655578', 'xadyn@mailinator.com', NULL, 'Autem consequat Nul', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-06 22:12:07', '2024-12-06 22:12:07'),
(2, 'Sawyer Weaver', '', '765765777', 'puwu@mailinator.com', NULL, 'Irure voluptatem di', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-06 22:13:10', '2024-12-06 22:13:10'),
(3, 'Martena Holden', '', '54665576767', 'saruxes@mailinator.com', NULL, 'Est sint quia sunt e', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-09 00:56:33', '2024-12-09 00:56:33'),
(4, 'Thaddeus Beasley', '+33', '7567578587578', NULL, NULL, 'Quo temporibus eaque', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-11 22:02:29', '2025-01-10 16:45:02'),
(5, 'Alika Hansen', '', '8743785635', 'kanewujij@mailinator.com', NULL, 'Soluta exercitatione', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-11 22:03:23', '2024-12-11 22:03:23'),
(6, 'Ethan Anthony', '', '67576578587', 'muzulepibo@mailinator.com', NULL, 'Quos natus eaque com', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-11 22:05:48', '2024-12-11 22:05:48'),
(7, 'Tashya Dillard', '', '7676765755', 'pukac@mailinator.com', NULL, 'Labore incididunt al', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-16 19:25:43', '2024-12-16 19:25:43'),
(8, 'Deirdre Blankenship', '', '4354543', 'tudimob@mailinator.com', NULL, 'Dolor illum ut dolo', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-16 22:54:30', '2024-12-16 22:54:30'),
(9, 'Steven Houston', '', '45543543', 'rojazamoxo@mailinator.com', NULL, 'Blanditiis nulla vol', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-17 22:14:22', '2024-12-17 22:14:22'),
(10, 'Ishmael Lindsay', '', '4565464565', 'wybu@mailinator.com', NULL, 'Quod proident conse', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-17 22:15:29', '2024-12-17 22:15:29'),
(11, 'Erich Cox', '', '675757878', 'katekat@mailinator.com', NULL, 'Autem mollit tenetur', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-19 00:52:23', '2024-12-19 00:52:23'),
(12, 'Callie Roman', '+880', '1915797670', 'shawonmahmodul12@gmail.com', NULL, 'Nostrum atque adipis', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-20 00:06:49', '2025-01-11 02:31:43'),
(13, 'Hyatt Kirk', '', '76576575', 'fajofiry@mailinator.com', NULL, 'Ut ea distinctio Vo', NULL, NULL, 0, NULL, NULL, '1', NULL, '2024-12-29 23:10:15', '2024-12-29 23:10:15'),
(14, 'Garrett Brady', '+1', '4453097609', 'rarykuz@mailinator.com', NULL, 'Pariatur Doloribus', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-01-12 16:39:36', '2025-01-12 16:39:36'),
(15, 'Madonna Maynard', '+60', '87687687686', 'ququr@mailinator.com', NULL, 'Aut itaque eiusmod d', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-01-12 16:43:40', '2025-01-12 16:43:40'),
(16, 'Lucius Bernard', '+1', '765587587578', 'pyvafo@mailinator.com', NULL, 'Sequi qui sed nulla', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-01-12 16:44:10', '2025-01-12 16:46:04'),
(17, 'Jillian Lindsay', '+1', '67567567576', 'lihemo@mailinator.com', NULL, 'Omnis delectus haru', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-01-12 16:46:28', '2025-01-12 16:46:28'),
(18, 'MacKensie Castaneda', '+1', '9123813012', 'pymibazin@mailinator.com', NULL, 'Quaerat optio nostr', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-03-03 04:17:55', '2025-03-03 04:17:55'),
(24, 'fffffffffff', NULL, '87234435999', NULL, NULL, 'jvavsd jhasvdas', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-06-22 15:30:11', '2025-06-22 15:30:11'),
(25, 'Ibrahim Hossain', NULL, '01621816806', NULL, NULL, 'Dhanmondi,Dhaka', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-06-23 06:54:12', '2025-06-23 06:54:12'),
(26, 'SAwon', NULL, '01915797677', NULL, NULL, 'fghgfh gdfg', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-06-23 07:24:36', '2025-06-23 07:24:36'),
(27, 'uiiyui', NULL, '01915797670', NULL, NULL, 'hfgh dfg', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-06-23 07:28:09', '2025-06-23 07:28:09'),
(28, 'sduiohfdcsfsd', NULL, '87234435566', NULL, NULL, 'dsvavd asdvas', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-06-23 14:29:01', '2025-06-23 14:29:01'),
(29, 'wewef', NULL, '87234435566', NULL, NULL, 'sdfsdfsd', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-06-23 14:33:36', '2025-06-23 14:33:36'),
(30, 'MD IBRAHIM HOSSAIN', NULL, '01531385988', NULL, NULL, 'KH-24,KHILKHET', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-06-23 16:35:20', '2025-06-23 16:35:20'),
(31, 'Rahat', NULL, '01531385988', NULL, NULL, 'Rajshahi', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-06-30 04:06:23', '2025-06-30 04:06:23'),
(32, 'Rasel', NULL, '01794272173', NULL, NULL, 'Dhanmondi,Dhaka', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-07-14 14:16:48', '2025-07-14 14:16:48'),
(33, 'Nayeem', NULL, '01762897654', NULL, NULL, 'Sylhet', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-07-24 10:27:24', '2025-07-24 10:27:24'),
(34, 'Md Hasan', NULL, '22151252051', NULL, NULL, 'Dhaka', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-10-12 01:03:51', '2025-10-12 01:03:51'),
(35, 'Hasan2', NULL, '01351695847', NULL, NULL, 'Mirpur', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-10-12 01:07:43', '2025-10-12 01:07:43'),
(39, 'guykrtyk', NULL, '23184561654', NULL, NULL, 'gyjgdyj', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-10-12 20:32:29', '2025-10-12 20:32:29'),
(40, 'fhkfyuk', NULL, '23184561654', NULL, NULL, 'rtyktk', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-10-12 20:34:01', '2025-10-12 20:34:01'),
(41, 'adrgdsth', NULL, '01251845124', NULL, NULL, 'sdhehhd', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-10-12 20:41:01', '2025-10-12 20:41:01'),
(42, 'sdgsdfg', NULL, '23184561654', NULL, NULL, 'edrgearg', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-10-12 20:49:05', '2025-10-12 20:49:05'),
(43, 'rthjdrht', NULL, '22151252051', NULL, NULL, 'srfhfdht', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-10-12 20:51:30', '2025-10-12 20:51:30'),
(44, 'rthjdrht', NULL, '0123456789', NULL, NULL, 'srfhfdht', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-10-12 21:16:30', '2025-10-12 21:16:30'),
(45, 'fgnfdgn', NULL, '22151252051', NULL, NULL, 'fghsfdh', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-10-12 21:18:03', '2025-10-12 21:18:03');

-- --------------------------------------------------------

--
-- Table structure for table `daily_expenses`
--

CREATE TABLE `daily_expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `expense_category_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `spend_method` enum('cash','card','bank_transfer') NOT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_expenses`
--

INSERT INTO `daily_expenses` (`id`, `date`, `expense_category_id`, `amount`, `spend_method`, `remarks`, `created_at`, `updated_at`) VALUES
(1, '2025-06-27', 3, 460.00, 'cash', 'Lunch bill for office employee', '2025-06-28 04:40:34', '2025-06-28 04:40:34'),
(2, '2025-06-28', 4, 230.00, 'cash', 'TaDa for Mr. Rasel', '2025-06-28 05:09:53', '2025-06-28 05:09:53'),
(3, '2025-07-14', 3, 350.00, 'cash', 'guest snaks', '2025-07-14 14:23:52', '2025-07-14 14:23:52'),
(4, '2025-10-13', 3, 100.00, 'cash', 'test', '2025-10-12 00:58:08', '2025-10-12 00:58:08');

-- --------------------------------------------------------

--
-- Table structure for table `daily_sales`
--

CREATE TABLE `daily_sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `description` text DEFAULT NULL,
  `card_amount` decimal(8,2) DEFAULT NULL,
  `cash_amount` decimal(8,2) DEFAULT NULL,
  `others_amount` decimal(8,2) DEFAULT NULL,
  `total_amount` decimal(8,2) DEFAULT NULL,
  `assigned_person_id` text NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `daily_sales`
--

INSERT INTO `daily_sales` (`id`, `date`, `description`, `card_amount`, `cash_amount`, `others_amount`, `total_amount`, `assigned_person_id`, `status`, `created_at`, `updated_at`) VALUES
(2, '2024-12-31', 'dfdsfsd', 10.00, 0.00, 0.00, 10.00, '1', '1', '2024-12-31 19:07:55', '2024-12-31 19:18:22'),
(3, '2024-11-01', NULL, 70.00, 30.00, 0.00, 100.00, '1', '1', '2024-12-31 19:08:16', '2024-12-31 19:08:16'),
(4, '2024-11-01', NULL, 70.00, 30.00, 0.00, 100.00, '1', '1', '2024-12-31 19:09:02', '2024-12-31 19:09:02'),
(5, '2025-01-04', NULL, 0.00, 0.00, 0.00, 0.00, '1,2', '1', '2025-01-04 22:00:22', '2025-01-04 22:16:02');

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Monthly Salary', 1, '2025-06-19 04:33:28', '2025-06-19 04:33:28'),
(3, 'Food', 1, '2025-06-19 04:34:14', '2025-06-19 04:34:14'),
(4, 'TA-DA', 1, '2025-06-28 04:39:09', '2025-06-28 04:39:09');

-- --------------------------------------------------------

--
-- Table structure for table `extras`
--

CREATE TABLE `extras` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` decimal(8,2) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventories`
--

CREATE TABLE `inventories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `opening_stock` int(11) NOT NULL DEFAULT 0,
  `current_stock` int(11) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventories`
--

INSERT INTO `inventories` (`id`, `product_id`, `opening_stock`, `current_stock`, `notes`, `created_at`, `updated_at`) VALUES
(1, 14, 10, 14, 'Opening stock entry', '2025-06-28 04:31:49', '2025-10-12 21:32:05'),
(2, 13, 15, 34, 'Opening stock entry', '2025-06-30 03:58:33', '2025-10-12 21:32:05'),
(3, 11, 10, 9, 'Opening stock entry', '2025-06-30 04:01:44', '2025-06-30 04:06:23'),
(4, 15, 10, 2, 'Opening stock entry', '2025-07-14 14:13:22', '2025-10-12 20:34:01');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2014_10_12_100000_create_password_resets_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2024_02_29_144312_addresses', 1),
(7, '2024_03_13_022048_norifications', 1),
(8, '2024_11_10_034909_ditsricts', 1),
(9, '2024_11_10_034941_areas', 1),
(10, '2024_11_25_144630_customers', 1),
(11, '2024_11_25_164637_services', 1),
(13, '2024_12_03_143540_products', 1),
(14, '2024_12_05_152050_sales', 1),
(15, 'add_teams_fields', 1),
(16, 'create_permission_tables', 1),
(17, '2024_12_16_102327_payments', 2),
(18, '2024_12_01_091025_create_bookings_table', 3),
(20, '2024_12_31_090914_daily_sales', 4),
(22, '2025_05_29_103934_create_inventories_table', 6),
(23, '2025_06_01_140304_create_brands_table', 7),
(24, '2025_06_19_102048_create_expense_categories_table', 8),
(25, '2025_06_19_104401_create_daily_expenses_table', 9),
(30, '2024_12_06_013656_add_advanced_and_due_payment_to_sales_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `message` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `isSeen` enum('0','1') NOT NULL DEFAULT '0',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_for` int(11) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `sale_id` bigint(20) NOT NULL,
  `payment_method` enum('cash','card','bank_transfer') NOT NULL,
  `amount` double NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `payment_for`, `customer_id`, `sale_id`, `payment_method`, `amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 7, 5, 'cash', 200, '1', '2024-12-16 19:25:43', '2024-12-16 19:25:43'),
(3, 1, 7, 5, 'card', 100, '1', '2024-12-16 21:35:59', '2024-12-16 21:35:59'),
(4, 1, 3, 3, 'cash', 100, '1', '2024-12-16 22:04:41', '2024-12-16 22:05:25'),
(6, 2, 8, 3, 'card', 100, '1', '2024-12-16 23:19:35', '2024-12-16 23:21:24'),
(7, 2, 9, 4, '', 50, '1', '2024-12-17 22:14:22', '2024-12-17 22:14:22'),
(8, 2, 10, 5, 'cash', 1000, '1', '2024-12-17 22:15:29', '2024-12-17 22:15:29'),
(9, 2, 9, 4, 'card', 150, '1', '2024-12-17 22:15:57', '2024-12-17 22:15:57'),
(10, 1, 4, 6, 'cash', 500, '1', '2024-12-18 00:59:08', '2024-12-18 00:59:08'),
(11, 2, 11, 6, '', 59, '1', '2024-12-19 00:52:23', '2024-12-19 00:52:23'),
(12, 1, 12, 7, 'card', 200, '1', '2024-12-20 00:06:49', '2024-12-20 00:06:49'),
(13, 1, 12, 8, 'card', 2000, '1', '2024-12-20 00:08:55', '2024-12-20 00:08:55'),
(14, 1, 12, 9, 'cash', 20, '1', '2024-12-20 00:10:41', '2024-12-20 00:10:41'),
(15, 1, 12, 10, 'cash', 20, '1', '2024-12-20 00:17:20', '2024-12-20 00:17:20'),
(16, 1, 12, 11, 'cash', 20, '1', '2024-12-20 00:18:14', '2024-12-20 00:18:14'),
(17, 1, 12, 12, 'cash', 20, '1', '2024-12-20 00:27:31', '2024-12-20 00:27:31'),
(18, 1, 12, 13, 'cash', 20, '1', '2024-12-20 00:29:01', '2024-12-20 00:29:01'),
(19, 1, 12, 14, 'cash', 20, '1', '2024-12-20 00:30:06', '2024-12-20 00:30:06'),
(20, 1, 12, 15, 'cash', 20, '1', '2024-12-20 00:30:47', '2024-12-20 00:30:47'),
(21, 1, 12, 16, 'cash', 20, '1', '2024-12-20 00:36:16', '2024-12-20 00:36:16'),
(22, 1, 12, 17, 'cash', 20, '1', '2024-12-20 00:36:34', '2024-12-20 00:36:34'),
(23, 1, 12, 18, 'cash', 20, '1', '2024-12-20 00:36:50', '2024-12-20 00:36:50'),
(24, 1, 12, 19, 'cash', 20, '1', '2024-12-20 00:37:19', '2024-12-20 00:37:19'),
(25, 2, 12, 7, '', 28, '1', '2024-12-20 01:05:50', '2024-12-20 01:05:50'),
(26, 2, 12, 8, '', 28, '1', '2024-12-20 01:06:38', '2024-12-20 01:06:38'),
(27, 1, 12, 20, 'cash', 57, '1', '2024-12-20 23:26:18', '2024-12-20 23:26:18'),
(28, 1, 12, 23, 'card', 6, '1', '2024-12-21 21:21:11', '2024-12-21 21:21:11'),
(29, 2, 13, 9, 'cash', 63, '1', '2024-12-29 23:10:15', '2024-12-29 23:10:15'),
(30, 1, 12, 24, 'card', 43, '1', '2024-12-30 21:52:09', '2024-12-30 21:52:09'),
(31, 1, 12, 25, 'card', 43, '1', '2024-12-30 21:52:42', '2024-12-30 21:52:42'),
(32, 1, 12, 26, 'card', 43, '1', '2024-12-30 21:54:32', '2024-12-30 21:54:32'),
(33, 1, 12, 27, 'card', 43, '1', '2024-12-30 21:54:55', '2024-12-30 21:54:55'),
(34, 1, 12, 28, 'card', 43, '1', '2024-12-30 22:02:55', '2024-12-30 22:02:55'),
(35, 1, 12, 29, 'cash', 61, '1', '2024-12-30 23:43:55', '2024-12-30 23:43:55'),
(36, 1, 12, 30, 'cash', 61, '1', '2024-12-30 23:47:25', '2024-12-30 23:47:25'),
(37, 1, 12, 31, 'cash', 61, '1', '2024-12-30 23:53:48', '2024-12-30 23:53:48'),
(38, 1, 12, 33, '', 75, '1', '2025-01-05 21:42:08', '2025-01-05 21:42:08'),
(39, 2, 12, 10, '', 29, '1', '2025-01-05 22:08:41', '2025-01-05 22:08:41'),
(40, 2, 12, 11, '', 29, '1', '2025-01-05 22:11:32', '2025-01-05 22:11:32'),
(41, 1, 4, 35, 'cash', 55, '1', '2025-01-05 22:26:12', '2025-01-05 22:26:12'),
(42, 1, 4, 36, 'cash', 50, '1', '2025-01-05 22:34:24', '2025-01-05 22:34:24'),
(43, 1, 12, 37, 'cash', 500, '1', '2025-01-05 17:54:39', '2025-01-05 17:54:39'),
(44, 1, 12, 38, 'card', 98, '1', '2025-01-05 18:20:21', '2025-01-05 18:20:21'),
(45, 1, 12, 39, 'card', 98, '1', '2025-01-05 18:22:50', '2025-01-05 18:22:50'),
(46, 1, 12, 40, 'card', 98, '1', '2025-01-05 18:26:24', '2025-01-05 18:26:24'),
(47, 1, 12, 41, 'card', 98, '1', '2025-01-05 18:34:29', '2025-01-05 18:34:29'),
(48, 1, 4, 42, '', 3, '1', '2025-01-10 16:45:03', '2025-01-10 16:45:03'),
(49, 1, 12, 43, 'cash', 50, '1', '2025-01-10 16:56:52', '2025-01-10 16:56:52'),
(50, 1, 12, 44, 'cash', 86, '1', '2025-01-11 02:26:55', '2025-01-11 02:26:55'),
(51, 1, 18, 55, 'card', 83, '1', '2025-03-03 04:19:05', '2025-03-03 04:19:05'),
(52, 2, 35, 7, 'cash', 66500, '1', '2025-10-13 01:55:08', '2025-10-13 01:55:08');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Administration', 'web', '2024-12-06 02:20:41', '2024-12-06 02:20:41'),
(2, 'Booking', 'web', '2024-12-06 02:20:41', '2024-12-06 02:20:41'),
(3, 'Service Management', 'web', '2024-12-06 02:20:41', '2024-12-06 02:20:41'),
(4, 'Sales Management', 'web', '2024-12-06 02:20:41', '2024-12-06 02:20:41'),
(5, 'Settings', 'web', '2024-12-06 02:20:41', '2024-12-06 02:20:41'),
(6, 'Product Management', 'web', '2025-05-22 05:26:46', '2025-05-22 05:26:46'),
(7, 'Purchase Management', 'web', '2025-05-27 04:03:24', '2025-05-27 04:03:24'),
(8, 'Inventory Management', 'web', '2025-05-29 04:50:49', '2025-05-29 04:50:49'),
(9, 'Vendor Management', 'web', '2025-06-01 03:38:00', '2025-06-01 03:38:00'),
(10, 'Report Management', 'web', '2025-06-16 04:07:32', '2025-06-16 04:07:32'),
(11, 'Expense Management', 'web', '2025-06-19 04:15:19', '2025-06-19 04:15:19');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `warranty` int(11) NOT NULL DEFAULT 0 COMMENT 'in days',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `brand_id`, `name`, `model`, `price`, `warranty`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Oppo', NULL, 20, 0, '1', '2024-12-06 22:12:07', '2024-12-06 22:12:07'),
(2, NULL, 'Nokia', NULL, 0, 0, '1', '2024-12-06 22:13:10', '2024-12-06 22:13:10'),
(3, NULL, 'pppp', NULL, 0, 0, '1', '2024-12-11 22:02:29', '2024-12-11 22:02:29'),
(4, NULL, 'bbbbbb', NULL, 0, 0, '1', '2024-12-11 22:03:23', '2024-12-11 22:03:23'),
(5, NULL, 'xyz', NULL, 0, 0, '1', '2024-12-18 00:59:08', '2024-12-18 00:59:08'),
(7, NULL, 'NEW LIBRARY2', NULL, 0, 0, '1', '2024-12-21 23:40:58', '2024-12-21 23:47:54'),
(9, NULL, 'CCC2', NULL, 0, 0, '1', '2024-12-21 23:48:55', '2024-12-21 23:49:11'),
(11, 6, 'Brother HL-B2150W Single Function Laser Printer', 'HL-B2150W', 0, 180, '1', '2025-01-04 21:32:03', '2025-06-30 03:56:09'),
(12, 5, 'Epson EcoTank L130 Single Function InkTank Printer', 'L130', 0, 365, '1', '2025-05-22 05:56:35', '2025-06-30 03:55:02'),
(13, 3, 'HP Laser 1008a Single Function Mono Laser Printer', '1008a', 0, 100, '1', '2025-06-01 08:32:13', '2025-06-30 03:52:58'),
(14, 4, 'Canon Laser Printer', 'LBP6030', 0, 365, '1', '2025-06-22 13:43:06', '2025-06-22 13:43:06'),
(15, 7, 'Zebra printer', 'zxp3', 0, 365, '1', '2025-07-14 14:11:51', '2025-07-14 14:11:51');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `sub_price` decimal(10,2) DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `payment` decimal(10,2) DEFAULT NULL,
  `due` decimal(10,2) DEFAULT NULL,
  `vendor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `product_id`, `quantity`, `unit_price`, `sub_price`, `total_price`, `payment`, `due`, `vendor_id`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 14, 10, 15000.00, 150000.00, 148000.00, 140000.00, 8000.00, 2, 1, NULL, '2025-06-28 04:31:49', '2025-06-28 04:31:49'),
(2, 13, 15, 14000.00, 210000.00, 210000.00, 200000.00, 10000.00, 2, 1, NULL, '2025-06-30 03:58:33', '2025-06-30 03:58:33'),
(3, 11, 10, 21000.00, 210000.00, 210000.00, 210000.00, 0.00, 3, 1, NULL, '2025-06-30 04:01:44', '2025-06-30 04:01:44'),
(4, 14, 10, 15000.00, 150000.00, 150000.00, 150000.00, 0.00, 3, 1, NULL, '2025-06-30 04:03:57', '2025-06-30 04:03:57'),
(5, 13, 30, 14000.00, 420000.00, 420000.00, 420000.00, 0.00, 3, 1, NULL, '2025-06-30 04:04:28', '2025-06-30 04:04:28'),
(6, 15, 10, 5000.00, 50000.00, 50000.00, 45000.00, 5000.00, 3, 1, NULL, '2025-07-14 14:13:22', '2025-07-14 14:13:22');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'web', NULL, NULL),
(2, 'Manager', 'web', '2025-01-04 21:50:56', '2025-01-04 21:50:56'),
(3, 'Sales', 'web', '2025-07-14 14:07:40', '2025-07-14 14:07:40');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(4, 3),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `salaries`
--

CREATE TABLE `salaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `amount` double NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_no` varchar(255) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `bill` double NOT NULL DEFAULT 0,
  `advanced_payment` decimal(15,2) DEFAULT NULL,
  `due_payment` decimal(15,2) DEFAULT NULL,
  `discount` double NOT NULL DEFAULT 0,
  `payble` double NOT NULL DEFAULT 0,
  `sales_by` bigint(20) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `order_no`, `customer_id`, `bill`, `advanced_payment`, `due_payment`, `discount`, `payble`, `sales_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'INV-685F708E73CE0', 25, 33000, NULL, NULL, 500, 32500, 1, '1', '2025-06-28 04:33:18', '2025-06-28 04:33:18'),
(2, 'INV-68620D3FDCE02', 31, 23000, NULL, NULL, 500, 22500, 1, '1', '2025-06-30 04:06:23', '2025-06-30 04:06:23'),
(3, 'INV-6875115046505', 32, 12000, NULL, NULL, 500, 11500, 1, '1', '2025-07-14 14:16:48', '2025-07-14 14:16:48'),
(4, 'INV-68820A8C2BC73', 33, 9000, NULL, NULL, 500, 8500, 1, '1', '2025-07-24 10:27:24', '2025-07-24 10:27:24'),
(5, 'INV-68EA3AF0C9E50', 25, 28300, NULL, NULL, 1500, 26800, 1, '1', '2025-10-11 11:09:36', '2025-10-11 11:09:36'),
(6, 'INV-68EB8B179085A', 34, 1000, NULL, NULL, 0, 1000, 1, '1', '2025-10-12 01:03:51', '2025-10-12 01:03:51'),
(7, 'INV-68EB8BFF4F5C4', 35, 121500, 116500.00, 0.00, 5000, 116500, 1, '1', '2025-10-12 01:07:43', '2025-10-13 01:55:08');

-- --------------------------------------------------------

--
-- Table structure for table `sales_items`
--

CREATE TABLE `sales_items` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `unit_price` double NOT NULL,
  `warranty` int(11) NOT NULL DEFAULT 0 COMMENT 'in days',
  `qty` int(11) NOT NULL,
  `total_price` double NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales_items`
--

INSERT INTO `sales_items` (`id`, `order_id`, `product_id`, `unit_price`, `warranty`, `qty`, `total_price`, `updated_at`, `created_at`) VALUES
(1, 1, 14, 16500, 365, 2, 33000, '2025-06-28 04:33:18', '2025-06-28 04:33:18'),
(2, 2, 11, 23000, 180, 1, 23000, '2025-06-30 04:06:23', '2025-06-30 04:06:23'),
(3, 3, 15, 6000, 365, 2, 12000, '2025-07-14 14:16:48', '2025-07-14 14:16:48'),
(4, 4, 12, 4500, 365, 2, 9000, '2025-07-24 10:27:24', '2025-07-24 10:27:24'),
(5, 5, 15, 6000, 365, 2, 12000, '2025-10-11 11:09:36', '2025-10-11 11:09:36'),
(6, 5, 14, 16300, 365, 1, 16300, '2025-10-11 11:09:36', '2025-10-11 11:09:36'),
(7, 6, 2, 500, 0, 2, 1000, '2025-10-12 01:03:51', '2025-10-12 01:03:51'),
(20, 8, 15, 5500, 365, 2, 11000, '2025-10-12 20:32:29', '2025-10-12 20:32:29'),
(21, 9, 15, 5500, 365, 2, 11000, '2025-10-12 20:34:01', '2025-10-12 20:34:01'),
(22, 10, 13, 15000, 100, 2, 30000, '2025-10-12 20:41:01', '2025-10-12 20:41:01'),
(23, 11, 13, 15000, 100, 2, 30000, '2025-10-12 20:49:05', '2025-10-12 20:49:05'),
(28, 12, 13, 2222, 100, 2, 4444, '2025-10-12 21:22:52', '2025-10-12 21:22:52'),
(29, 7, 13, 15000, 100, 5, 75000, '2025-10-12 21:32:05', '2025-10-12 21:32:05'),
(30, 7, 14, 15500, 365, 3, 46500, '2025-10-12 21:32:05', '2025-10-12 21:32:05');

-- --------------------------------------------------------

--
-- Table structure for table `sales_target`
--

CREATE TABLE `sales_target` (
  `id` int(11) NOT NULL,
  `month` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales_target`
--

INSERT INTO `sales_target` (`id`, `month`, `amount`, `created_at`, `updated_at`) VALUES
(1, '2025-02', 232.00, '2025-02-21 21:54:32', '2025-02-21 21:54:32');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country_code` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `bill` double NOT NULL,
  `paid_amount` double NOT NULL DEFAULT 0,
  `due_amount` double NOT NULL DEFAULT 0,
  `discount` int(11) DEFAULT NULL,
  `warranty_duration` int(11) NOT NULL,
  `repaired_by` bigint(20) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `complated_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `customer_id`, `name`, `country_code`, `phone`, `email`, `address`, `product_name`, `product_number`, `details`, `bill`, `paid_amount`, `due_amount`, `discount`, `warranty_duration`, `repaired_by`, `rating`, `status`, `complated_date`, `created_at`, `updated_at`) VALUES
(3, 3, 'Martena Holden', '', '54665576767', 'saruxes@mailinator.com', 'Est sint quia sunt e', 'Nokia', '853', 'Dolor maiores omnis', 54, 100, 0, NULL, 95, 1, NULL, '1', '2024-12-08', '2024-12-09 00:56:33', '2024-12-16 22:05:25'),
(4, 6, 'Ethan Anthony', '', '67576578587', 'muzulepibo@mailinator.com', 'Quos natus eaque com', 'Oppo', '554', 'Tempor eu in sapient', 47, 0, 0, NULL, 91, 1, NULL, '0', NULL, '2024-12-11 22:05:48', '2024-12-11 22:05:48'),
(5, 7, 'Tashya Dillard', '', '7676765755', 'pukac@mailinator.com', 'Labore incididunt al', 'Oppo', '395', 'Autem sed quo invent', 600, 300, 300, NULL, 96, 1, NULL, '1', '2024-12-18', '2024-12-16 19:25:43', '2024-12-19 01:13:04'),
(6, 4, 'aaaaaaaaaaa', '', '1555555555', NULL, NULL, 'xyz', '453454534', 'Hey team quickphonefixandmore.com,\r\n\r\nHope your doing well!\r\n\r\nI just following your website and realized that despite having a good design; but it was not ranking high on any of the Search Engines (Google, Yahoo & Bing) for most of the keywords related to your business.\r\n\r\nWe can place your website on Google\'s 1st page.\r\n\r\n*  Top ranking on Google search!\r\n*  Improve website clicks and views!\r\n*  Increase Your Leads, clients & Revenue!\r\n\r\nInterested? Please provide your name, contact information, and email.\r\n\r\nWell wishes,\r\nPaul S\r\n+1 (949) 313-8897\r\nPaul S| Lets Get You Optimize\r\nSr SEO consultant\r\nwww.letsgetuoptimize.com\r\nPhone No: +1 (949) 313-8897', 1000, 500, 500, NULL, 545, 1, NULL, '1', '2024-12-18', '2024-12-18 00:59:08', '2024-12-19 01:12:55'),
(7, 12, 'Roth Wilson', '', '134545455456', 'shawonmahmodul12@gmail.com', 'Culpa explicabo Qu', 'Oppo', '834', 'Repellendus Qui vel', 1000, 200, 800, NULL, 76, 1, NULL, '0', NULL, '2024-12-20 00:06:49', '2024-12-20 00:06:49'),
(8, 12, 'Daryl Walters', '', '76786786876', 'shawonmahmodul12@gmail.com', 'Culpa tenetur ut fu', 'xyz', '59', 'Nihil necessitatibus', 5000, 2000, 3000, NULL, 60, 1, NULL, '0', NULL, '2024-12-20 00:08:55', '2024-12-20 00:08:55'),
(9, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:10:41', '2024-12-20 00:10:41'),
(10, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:17:20', '2024-12-20 00:17:20'),
(11, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:18:14', '2024-12-20 00:18:14'),
(12, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:27:31', '2024-12-20 00:27:31'),
(13, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:29:01', '2024-12-20 00:29:01'),
(14, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:30:06', '2024-12-20 00:30:06'),
(15, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:30:47', '2024-12-20 00:30:47'),
(16, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:36:16', '2024-12-20 00:36:16'),
(17, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:36:34', '2024-12-20 00:36:34'),
(18, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:36:50', '2024-12-20 00:36:50'),
(19, 12, 'Brenda Walls', '', '657576575', 'shawonmahmodul12@gmail.com', 'Rerum laudantium mi', 'xyz', '100', 'Atque labore asperio', 60, 20, 40, NULL, 22, 1, NULL, '0', NULL, '2024-12-20 00:37:19', '2024-12-20 00:37:19'),
(20, 12, 'Quinn Clayton', '', '67675765675', 'shawonmahmodul12@gmail.com', 'Voluptas consequatur', 'Nokia', '920', 'Nostrud molestiae cu', 52, 57, 0, NULL, 23, 1, NULL, '0', NULL, '2024-12-20 23:26:18', '2024-12-20 23:26:18'),
(21, 12, 'booking', '', '15555555550', 'shawonmahmodul12@gmail.com', 'jhddsahfsa', 'xyz', '76567567', 'Hey team quickphonefixandmore.com,\r\n\r\nI would like to discuss SEO!\r\n\r\nI can help your website to get on first page of Google and increase the number of leads and sales you are getting from your website.\r\n\r\nMay I send you a quote & price list?\r\n\r\nWell wishes,\r\nPaul S\r\n+1 (949) 313-8897\r\nPaul S| Lets Get You Optimize\r\nSr SEO consultant\r\nwww.letsgetuoptimize.com\r\nPhone No: +1 (949) 313-8897', 70, 40, 30, NULL, 6756, 1, NULL, '0', NULL, '2024-12-21 21:15:49', '2024-12-21 21:15:49'),
(22, 12, 'fgddgddg', '', '15555555550', 'shawonmahmodul12@gmail.com', 'hgchgcgh', 'xyz', '76567576', 'Hey team quickphonefixandmore.com,\r\n\r\nI would like to discuss SEO!\r\n\r\nI can help your website to get on first page of Google and increase the number of leads and sales you are getting from your website.\r\n\r\nMay I send you a quote & price list?\r\n\r\nWell wishes,\r\nPaul S\r\n+1 (949) 313-8897\r\nPaul S| Lets Get You Optimize\r\nSr SEO consultant\r\nwww.letsgetuoptimize.com\r\nPhone No: +1 (949) 313-8897', 654, 6, 648, NULL, 76, 1, NULL, '0', NULL, '2024-12-21 21:19:37', '2024-12-21 21:19:37'),
(23, 12, 'fgddgddg', '', '15555555550', 'shawonmahmodul12@gmail.com', 'hgchgcgh', 'xyz', '76567576', 'Hey team quickphonefixandmore.com,\r\n\r\nI would like to discuss SEO!\r\n\r\nI can help your website to get on first page of Google and increase the number of leads and sales you are getting from your website.\r\n\r\nMay I send you a quote & price list?\r\n\r\nWell wishes,\r\nPaul S\r\n+1 (949) 313-8897\r\nPaul S| Lets Get You Optimize\r\nSr SEO consultant\r\nwww.letsgetuoptimize.com\r\nPhone No: +1 (949) 313-8897', 654, 6, 648, NULL, 76, 1, NULL, '0', NULL, '2024-12-21 21:21:11', '2024-12-21 21:21:11'),
(24, 12, 'Shawon', '', '01915797670', 'shawonmahmodul12@gmail.com', 'Exercitation sit qu', 'Nokia', '451', 'Recusandae Voluptat', 85, 43, 42, NULL, 97, 1, NULL, '0', NULL, '2024-12-30 21:52:09', '2024-12-30 21:52:09'),
(25, 12, 'Shawon', '', '01915797670', 'shawonmahmodul12@gmail.com', 'Exercitation sit qu', 'Nokia', '451', 'Recusandae Voluptat', 85, 43, 42, NULL, 97, 1, NULL, '0', NULL, '2024-12-30 21:52:42', '2024-12-30 21:52:42'),
(26, 12, 'Shawon', '', '01915797670', 'shawonmahmodul12@gmail.com', 'Exercitation sit qu', 'Nokia', '451', 'Recusandae Voluptat', 85, 43, 42, NULL, 97, 1, NULL, '0', NULL, '2024-12-30 21:54:32', '2024-12-30 21:54:32'),
(27, 12, 'Shawon', '', '01915797670', 'shawonmahmodul12@gmail.com', 'Exercitation sit qu', 'Nokia', '451', 'Recusandae Voluptat', 85, 43, 42, NULL, 97, 1, NULL, '0', NULL, '2024-12-30 21:54:55', '2024-12-30 21:54:55'),
(28, 12, 'Shawon', '+1', '01915797670', 'shawonmahmodul12@gmail.com', 'Exercitation sit qu', 'Nokia', '451', 'Recusandae Voluptat', 85, 43, 42, NULL, 97, 1, NULL, '0', NULL, '2024-12-30 22:02:55', '2024-12-30 23:11:10'),
(29, 12, 'Abra Brady', '+880', '1836310972', 'shawonmahmodul12@gmail.com', 'Libero dolorem venia', 'Oppo', '225', 'Iste quam Nam elit', 89, 61, 28, NULL, 65, 1, NULL, '0', NULL, '2024-12-30 23:43:55', '2024-12-30 23:43:55'),
(30, 12, 'Abra Brady', '+880', '1836310972', 'shawonmahmodul12@gmail.com', 'Libero dolorem venia', 'Oppo', '225', 'Iste quam Nam elit', 89, 61, 28, NULL, 65, 1, NULL, '0', NULL, '2024-12-30 23:47:25', '2024-12-30 23:47:25'),
(31, 12, 'Abra Brady', '+880', '1836310972', 'shawonmahmodul12@gmail.com', 'Libero dolorem venia', 'Oppo', '225', 'Iste quam Nam elit', 89, 61, 28, NULL, 65, 1, NULL, '0', NULL, '2024-12-30 23:53:48', '2024-12-30 23:53:48'),
(32, 4, 'siraz', '+1', '2674621981', NULL, '819 shaw ave', 'iPhone', '123456789101112', 'my phone is not trun on', 77, 0, 77, NULL, 6, 1, NULL, '0', NULL, '2025-01-04 21:32:03', '2025-01-04 21:32:03'),
(33, 12, 'Sasha Cantu', '+880', '1915797670', 'shawonmahmodul12@gmail.com', 'Aut laudantium susc', 'iPhone', '956', 'Iure possimus sunt', 30, 75, 0, NULL, 67, 1, NULL, '0', NULL, '2025-01-05 21:42:08', '2025-01-05 22:05:06'),
(34, 4, 'Saddam', '+1', '3254645745', NULL, '1404 Newkirk Avenue, Brooklyn, NY-11226', 'iPhone', 'sfsdgdsgas', 'this is a test sms', 67, 0, 67, NULL, 67, 1, NULL, '0', NULL, '2025-01-05 22:22:11', '2025-01-05 22:22:11'),
(35, 4, 'rakib', '+1', '2674621981', NULL, '519 W Eighth St, B', 'iPhone', '0000000000000', 'screen brock', 60, 55, 5, NULL, 667567, 2, NULL, '0', NULL, '2025-01-05 22:26:12', '2025-01-05 22:26:12'),
(36, 4, 'kawsar', '+1', '1836310972', NULL, 'Dhaka', 'iPhone', '123456786y5t4rj', 'Test message here', 60, 50, 10, NULL, 667567, 2, NULL, '0', NULL, '2025-01-05 22:34:24', '2025-01-05 22:34:24'),
(37, 12, 'shawon', '+880', '1915797670', 'shawonmahmodul12@gmail.com', NULL, 'Oppo', NULL, NULL, 1000, 500, 500, NULL, 500, 2, NULL, '0', NULL, '2025-01-05 17:54:39', '2025-01-05 17:54:39'),
(38, 12, 'Paloma Harper', '+880', '1915797670', 'shawonmahmodul12@gmail.com', 'Necessitatibus possi', 'Oppo', '885', 'Quam qui sint aut o', 8, 98, 0, NULL, 28, 1, NULL, '0', NULL, '2025-01-05 18:20:21', '2025-01-05 18:20:21'),
(39, 12, 'Paloma Harper', '+880', '1915797670', 'shawonmahmodul12@gmail.com', 'Necessitatibus possi', 'Oppo', '885', 'Quam qui sint aut o', 8, 98, 0, NULL, 28, 1, NULL, '0', NULL, '2025-01-05 18:22:50', '2025-01-05 18:22:50'),
(40, 12, 'Paloma Harper', '+880', '1915797670', 'shawonmahmodul12@gmail.com', 'Necessitatibus possi', 'Oppo', '885', 'Quam qui sint aut o', 8, 98, 0, NULL, 28, 1, NULL, '0', NULL, '2025-01-05 18:26:24', '2025-01-05 18:26:24'),
(41, 12, 'Paloma Harper', '+880', '1915797670', 'shawonmahmodul12@gmail.com', 'Necessitatibus possi', 'Oppo', '885', 'Quam qui sint aut o', 8, 98, 0, NULL, 28, 1, NULL, '0', NULL, '2025-01-05 18:34:29', '2025-01-05 18:34:29'),
(42, 4, 'Thaddeus Beasley', '+33', '7567578587578', NULL, 'Quo temporibus eaque', 'Nokia', '192', 'Odio lorem sed sed e', 74, 3, 71, NULL, 30, 3, NULL, '0', NULL, '2025-01-10 16:45:02', '2025-01-10 16:45:02'),
(43, 12, 'Callie Roman', '+880', '1915797670', 'shawonmahmodul12@gmail.com', 'Nostrum atque adipis', 'Oppo', '212', 'Consequatur illo con', 73, 50, 23, NULL, 16, 1, NULL, '1', '2025-01-10', '2025-01-10 16:56:52', '2025-01-11 02:31:43'),
(44, 12, 'Beck Cash', '+880', '1915797670', 'shawonmahmodul12@gmail.com', 'Temporibus vitae mag', 'Nokia', '573', 'Delectus enim conse', 81, 86, 0, NULL, 26, 1, NULL, '1', '2025-01-10', '2025-01-11 02:26:55', '2025-01-11 02:27:46'),
(45, 14, 'Garrett Brady', '+1', '4453097609', 'rarykuz@mailinator.com', 'Pariatur Doloribus', 'iPhone', '980', 'Dicta est adipisci d', 21, 98, 0, NULL, 60, 3, NULL, '0', NULL, '2025-01-12 16:39:36', '2025-01-12 16:39:36'),
(46, 14, 'Garrett Brady', '+1', '4453097609', 'rarykuz@mailinator.com', 'Pariatur Doloribus', 'iPhone', '980', 'Dicta est adipisci d', 21, 98, 0, NULL, 60, 3, NULL, '0', NULL, '2025-01-12 16:39:53', '2025-01-12 16:39:53'),
(47, 15, 'Madonna Maynard', '+60', '87687687686', 'ququr@mailinator.com', 'Aut itaque eiusmod d', 'Nokia', '81', 'Corporis et qui dist', 13, 0, 13, NULL, 77, 3, NULL, '0', NULL, '2025-01-12 16:43:40', '2025-01-12 16:43:40'),
(48, 16, 'Lucius Bernard', '+61', '765587587578', 'pyvafo@mailinator.com', 'Sequi qui sed nulla', 'Oppo', '813', 'Sint non occaecat sa', 10, 57, 0, NULL, 52, 2, NULL, '0', NULL, '2025-01-12 16:44:10', '2025-01-12 16:44:10'),
(49, 16, 'Lucius Bernard', '+61', '765587587578', 'pyvafo@mailinator.com', 'Sequi qui sed nulla', 'Oppo', '813', 'Sint non occaecat sa', 10, 57, 0, NULL, 52, 2, NULL, '0', NULL, '2025-01-12 16:44:46', '2025-01-12 16:44:46'),
(50, 16, 'Lucius Bernard', '+1', '765587587578', 'pyvafo@mailinator.com', 'Sequi qui sed nulla', 'Oppo', '813', 'Sint non occaecat sa', 10, 0, 10, NULL, 52, 2, NULL, '0', NULL, '2025-01-12 16:46:04', '2025-01-12 16:46:04'),
(51, 17, 'Jillian Lindsay', '+1', '67567567576', 'lihemo@mailinator.com', 'Omnis delectus haru', 'Oppo', '383', 'Repellendus Ad exer', 14, 72, 0, NULL, 71, 2, NULL, '0', NULL, '2025-01-12 16:46:28', '2025-01-12 16:46:28'),
(52, 17, 'Jillian Lindsay', '+1', '67567567576', 'lihemo@mailinator.com', 'Omnis delectus haru', 'Oppo', '383', 'Repellendus Ad exer', 14, 72, 0, NULL, 71, 2, NULL, '0', NULL, '2025-01-12 16:46:46', '2025-01-12 16:46:46'),
(53, 17, 'Jillian Lindsay', '+1', '67567567576', 'lihemo@mailinator.com', 'Omnis delectus haru', 'Oppo', '383', 'Repellendus Ad exer', 14, 72, 0, NULL, 71, 2, NULL, '0', NULL, '2025-01-12 16:47:07', '2025-01-12 16:47:07'),
(54, 17, 'Jillian Lindsay', '+1', '67567567576', 'lihemo@mailinator.com', 'Omnis delectus haru', 'Oppo', '383', 'Repellendus Ad exer', 14, 0, 14, NULL, 71, 2, NULL, '0', NULL, '2025-01-12 16:49:55', '2025-01-12 16:49:55'),
(55, 18, 'MacKensie Castaneda', '+1', '9123813012', 'pymibazin@mailinator.com', 'Quaerat optio nostr', 'iPhone', '704', 'Mollit ullam ea cons', 62, 83, 0, 25, 85, 3, 3, '1', '2025-03-03', '2025-03-03 04:19:05', '2025-03-03 12:14:57');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('1','2') NOT NULL DEFAULT '1' COMMENT '1 for users and 2 for staff',
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `images` varchar(255) DEFAULT NULL,
  `verification_code` int(11) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `billing_address` bigint(20) DEFAULT NULL,
  `shipping_address` bigint(20) DEFAULT NULL,
  `is_guest` enum('0','1') NOT NULL DEFAULT '0',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `documents` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `type`, `name`, `email`, `phone`, `email_verified_at`, `password`, `role_id`, `images`, `verification_code`, `is_verified`, `billing_address`, `shipping_address`, `is_guest`, `status`, `remember_token`, `created_at`, `updated_at`, `department`, `designation`, `joining_date`, `salary`, `documents`) VALUES
(1, '1', 'Super Admin', 'info@quickphonefixandmore.com', NULL, NULL, '$2y$10$PgIfJHFTRyLeeRl/Sa32ruQqXj4qeL5NcybMPjrh8apDXF2SKk3im', 1, NULL, NULL, 0, NULL, NULL, '0', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, '1', 'Hridoy', 'hridoy@gmail.com', '01788888888', NULL, '$2y$12$XADjk1sBXWArrbLkhlul1..QHB2DGnDX4nGabLJ07LLYGMRfXLaYa', 2, '', NULL, 0, NULL, NULL, '0', '1', NULL, '2025-01-04 21:50:31', '2025-01-04 21:51:23', NULL, NULL, NULL, NULL, NULL),
(3, '1', 'aaaaaaaaaa', 'aa@g.com', '34545435345', NULL, '$2y$10$753h4FPJOtDGIT9RRsY0HuMMpj3S4R/WQqHLbTvhv206DC87Pe06e', 3, NULL, NULL, 0, NULL, NULL, '0', '1', NULL, NULL, '2025-07-14 14:08:26', NULL, NULL, NULL, NULL, NULL),
(4, '2', 'Isabella Larson', 'xuvi@mailinator.com', '+1 (583) 148-1609', NULL, NULL, NULL, '20250216091201_ARZTAspzBd.png', NULL, 0, NULL, NULL, '0', '0', NULL, '2025-02-16 03:12:01', '2025-02-16 03:23:31', 'Suscipit quaerat aut', 'Nihil veniam quidem', '1998-12-26', 56.00, '[\"20250216091201_zKdMURlxYb.pdf\",\"20250216091201_Zr6FokSEIw.pdf\"]');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `name`, `phone`, `email`, `address`, `status`, `updated_at`, `created_at`) VALUES
(2, 'Hayley Foley', '01783748739', 'hybom@mailinator.com', 'Eveniet laudantium', '1', '2025-06-01 03:44:04', '2025-06-01 03:44:04'),
(3, 'Global Brand', '01531375977', 'global@gmail.com', 'Dhanmondi,Dhaka', '1', '2025-06-30 04:00:15', '2025-06-30 04:00:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendances_date_index` (`date`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_email_unique` (`email`);

--
-- Indexes for table `daily_expenses`
--
ALTER TABLE `daily_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `daily_sales`
--
ALTER TABLE `daily_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extras`
--
ALTER TABLE `extras`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchases_product_id_foreign` (`product_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `salaries`
--
ALTER TABLE `salaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salaries_date_index` (`date`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales_items`
--
ALTER TABLE `sales_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales_target`
--
ALTER TABLE `sales_target`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `daily_expenses`
--
ALTER TABLE `daily_expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `daily_sales`
--
ALTER TABLE `daily_sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `districts`
--
ALTER TABLE `districts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `extras`
--
ALTER TABLE `extras`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `salaries`
--
ALTER TABLE `salaries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `sales_items`
--
ALTER TABLE `sales_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `sales_target`
--
ALTER TABLE `sales_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
