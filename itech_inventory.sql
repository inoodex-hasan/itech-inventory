-- Adminer 5.4.2 MySQL 8.4.3 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alternative_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` bigint NOT NULL,
  `area` bigint NOT NULL,
  `address_details` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `address_type` enum('1','2') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `advance_salaries`;
CREATE TABLE `advance_salaries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `request_date` date NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `advance_salaries_employee_id_foreign` (`employee_id`),
  CONSTRAINT `advance_salaries_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `areas`;
CREATE TABLE `areas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `district_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `attendances`;
CREATE TABLE `attendances` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `date` date NOT NULL,
  `check_in` time DEFAULT NULL,
  `check_out` time DEFAULT NULL,
  `attendance_status` int NOT NULL DEFAULT '1',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendances_date_index` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `bank_details`;
CREATE TABLE `bank_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `routing_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `bank_details` (`id`, `account_name`, `bank_name`, `branch`, `account_number`, `account_type`, `routing_number`, `is_default`, `is_active`, `created_at`, `updated_at`) VALUES
(1,	'Intelligent Technology',	'Bank Asia Ltd.',	'Satmosjid Road',	'06933000526',	'Current',	'070264034',	1,	1,	'2025-11-29 10:21:26',	'2025-11-30 10:56:54');

DROP TABLE IF EXISTS `bill_items`;
CREATE TABLE `bill_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bill_id` bigint unsigned NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bill_items_bill_id_foreign` (`bill_id`),
  CONSTRAINT `bill_items_bill_id_foreign` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `bills`;
CREATE TABLE `bills` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bill_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sale_id` bigint unsigned DEFAULT NULL,
  `project_id` bigint unsigned DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `type` enum('sale','project') COLLATE utf8mb4_unicode_ci NOT NULL,
  `work_order_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bill_date` date NOT NULL,
  `subtotal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bank_detail_id` bigint unsigned DEFAULT NULL,
  `company_detail_id` bigint unsigned DEFAULT NULL,
  `terms_conditions` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attention_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bills_bill_number_unique` (`bill_number`),
  KEY `bills_sale_id_foreign` (`sale_id`),
  KEY `bills_project_id_foreign` (`project_id`),
  KEY `bills_customer_id_foreign` (`customer_id`),
  KEY `bills_client_id_foreign` (`client_id`),
  KEY `bills_bank_detail_id_foreign` (`bank_detail_id`),
  KEY `bills_company_detail_id_foreign` (`company_detail_id`),
  CONSTRAINT `bills_bank_detail_id_foreign` FOREIGN KEY (`bank_detail_id`) REFERENCES `bank_details` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bills_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bills_company_detail_id_foreign` FOREIGN KEY (`company_detail_id`) REFERENCES `company_details` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bills_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bills_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bills_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `bookings`;
CREATE TABLE `bookings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `brands` (`id`, `name`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2,	'HP',	1,	'2025-11-02 12:37:35',	'2025-11-02 12:37:35',	NULL),
(3,	'Canon',	1,	'2025-11-02 12:38:06',	'2025-11-02 12:38:06',	NULL),
(4,	'Epson',	1,	'2025-11-02 12:38:12',	'2025-11-02 12:38:12',	NULL),
(8,	'HiTi',	1,	'2026-03-14 04:16:23',	'2026-03-14 04:49:07',	NULL),
(9,	'Zebra',	1,	'2026-03-14 04:16:55',	'2026-03-14 04:16:55',	NULL),
(10,	'Evolish',	1,	'2026-03-14 04:17:09',	'2026-03-14 04:17:09',	NULL),
(11,	'RFID 125k Mango brand',	1,	'2026-03-14 04:17:42',	'2026-03-14 04:17:42',	NULL),
(12,	'Crystal',	1,	'2026-03-14 04:18:14',	'2026-03-14 04:18:14',	NULL),
(13,	'Luminus',	1,	'2026-03-14 04:18:29',	'2026-03-14 04:18:29',	NULL),
(14,	'ZKTeco',	1,	'2026-03-14 04:18:59',	'2026-03-14 04:18:59',	NULL),
(15,	'HIKVISION',	1,	'2026-03-14 04:19:25',	'2026-03-14 04:19:25',	NULL),
(16,	'3D Glass',	1,	'2026-03-28 08:50:32',	'2026-03-28 08:50:32',	NULL),
(17,	'DT Lebel',	1,	'2026-03-29 05:57:19',	'2026-03-29 05:57:19',	NULL),
(18,	'TT Lebel',	1,	'2026-03-29 05:58:57',	'2026-03-29 05:58:57',	NULL),
(19,	'Jing tai',	1,	'2026-04-04 10:00:52',	'2026-04-04 10:00:52',	NULL),
(20,	'Keja',	1,	'2026-04-04 10:01:02',	'2026-04-04 10:01:02',	NULL),
(21,	'ZKTeco',	1,	'2026-04-04 10:04:13',	'2026-04-04 10:04:13',	NULL),
(22,	'Printer Usable Software',	1,	'2026-04-04 10:07:18',	'2026-04-04 10:07:18',	NULL),
(23,	'UTP and shielded',	1,	'2026-04-04 10:09:52',	'2026-04-04 10:09:52',	NULL),
(24,	'BREB',	1,	'2026-04-04 10:13:47',	'2026-04-04 10:13:47',	NULL),
(25,	'Crystal',	1,	'2026-04-04 10:26:53',	'2026-04-04 10:26:53',	NULL),
(26,	'Lanyard Hook',	1,	'2026-04-04 10:42:16',	'2026-04-04 10:42:16',	NULL),
(27,	'FingerTec',	1,	'2026-04-20 11:37:02',	'2026-04-20 11:37:02',	NULL),
(28,	'Genuine Secure',	1,	'2026-04-20 12:03:22',	'2026-04-20 12:03:22',	NULL),
(29,	'BREB',	1,	'2026-04-20 12:31:09',	'2026-04-20 12:31:09',	NULL),
(30,	'ALL PVC CARD',	1,	'2026-04-20 12:38:23',	'2026-04-20 12:38:23',	NULL),
(31,	'Sense',	1,	'2026-04-20 13:27:50',	'2026-04-20 13:27:50',	NULL),
(32,	'Thermal POS Paper',	1,	'2026-04-20 13:33:21',	'2026-04-20 13:33:21',	NULL),
(33,	'TSC',	1,	'2026-04-20 13:35:12',	'2026-04-20 13:35:12',	NULL),
(34,	'Good Quality Yoyo',	1,	'2026-04-20 13:37:39',	'2026-04-20 13:37:39',	NULL);

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `order_by` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `image`, `status`, `order_by`, `created_at`, `updated_at`) VALUES
(4,	'Tablets',	'tablets',	NULL,	NULL,	1,	3,	'2026-03-08 03:28:49',	'2026-03-08 03:28:49'),
(5,	'Accessories',	'accessories',	NULL,	NULL,	1,	4,	'2026-03-08 03:28:49',	'2026-03-08 03:28:49'),
(19,	'Pvc card',	'pvc-card',	NULL,	NULL,	1,	0,	'2026-03-14 04:28:23',	'2026-03-14 04:28:23'),
(20,	'Printers Ribbons',	'printers-ribbons',	NULL,	NULL,	1,	0,	'2026-03-14 04:28:51',	'2026-03-14 04:29:01'),
(21,	'Printers',	'printers',	NULL,	NULL,	1,	0,	'2026-03-14 04:29:18',	'2026-03-14 04:29:18'),
(22,	'Service Charges',	'service-charges',	NULL,	NULL,	1,	0,	'2026-03-14 04:29:58',	'2026-03-14 04:29:58'),
(23,	'DT Lebel',	'dt-lebel',	NULL,	NULL,	1,	0,	'2026-03-29 05:56:53',	'2026-03-29 05:56:53'),
(24,	'Plastic Cover',	'plastic-cover',	NULL,	NULL,	1,	0,	'2026-04-04 09:59:54',	'2026-04-04 10:00:37'),
(25,	'Metal Cover',	'metal-cover',	NULL,	NULL,	1,	0,	'2026-04-04 10:00:20',	'2026-04-04 10:00:20'),
(26,	'Security Lock',	'security-lock',	NULL,	NULL,	1,	0,	'2026-04-04 10:03:55',	'2026-04-04 10:03:55'),
(27,	'Software',	'software',	NULL,	NULL,	1,	0,	'2026-04-04 10:05:24',	'2026-04-04 10:05:24'),
(28,	'Internet Cable',	'internet-cable',	NULL,	NULL,	1,	0,	'2026-04-04 10:08:54',	'2026-04-04 10:08:54'),
(29,	'Electrical Accessories',	'electrical-accessories',	NULL,	NULL,	1,	0,	'2026-04-04 10:13:18',	'2026-04-04 10:13:18'),
(30,	'Lanyard Hook',	'lanyard-hook',	NULL,	NULL,	1,	0,	'2026-04-04 10:41:38',	'2026-04-04 10:41:38'),
(31,	'Biometric Device',	'biometric-device',	NULL,	NULL,	1,	0,	'2026-04-20 11:38:06',	'2026-04-20 11:38:06'),
(32,	'Hologram Sticker',	'hologram-sticker',	NULL,	NULL,	1,	0,	'2026-04-20 12:03:04',	'2026-04-20 12:03:04'),
(33,	'Power Cable',	'power-cable',	NULL,	NULL,	1,	0,	'2026-04-20 12:30:58',	'2026-04-20 12:30:58'),
(34,	'Thermal POS Paper',	'thermal-pos-paper',	NULL,	NULL,	1,	0,	'2026-04-20 13:33:14',	'2026-04-20 13:33:14');

DROP TABLE IF EXISTS `challan_items`;
CREATE TABLE `challan_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `challan_id` bigint unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Piece',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `challan_items_challan_id_foreign` (`challan_id`),
  CONSTRAINT `challan_items_challan_id_foreign` FOREIGN KEY (`challan_id`) REFERENCES `challans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `challans`;
CREATE TABLE `challans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `challan_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `challan_date` date NOT NULL,
  `type` enum('sale','project') COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_id` bigint unsigned DEFAULT NULL,
  `project_id` bigint unsigned DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `recipient_organization` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recipient_designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recipient_address` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attention_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signatory_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signatory_designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `challans_challan_number_unique` (`challan_number`),
  KEY `challans_sale_id_foreign` (`sale_id`),
  KEY `challans_project_id_foreign` (`project_id`),
  CONSTRAINT `challans_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `challans_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `clients` (`id`, `name`, `phone`, `email`, `address`, `created_at`, `updated_at`) VALUES
(2,	'Md Hasan',	'01234567890',	'hasan@inoodex.com',	'Dhaka',	'2025-11-14 20:08:22',	'2025-11-14 20:08:22'),
(9,	'Mr Rahim',	'01000000000',	'rahim@example.com',	'Mirpur',	'2025-11-26 05:52:50',	'2025-11-26 05:52:50');

DROP TABLE IF EXISTS `company_details`;
CREATE TABLE `company_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `signatory_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `signatory_designation` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `company_details` (`id`, `name`, `signatory_name`, `signatory_designation`, `phone`, `email`, `website`, `address`, `is_default`, `is_active`, `created_at`, `updated_at`) VALUES
(1,	'Intelligent Technology',	'Engr. Shamsul Alam',	'Director (Technical)',	'+88 01904400202',	'info.itechbd@yahoo.com',	'www.itechbd.net',	'187(3rd Floor), Green Road, Dhanmondi Dhaka-1205, Bangladesh',	1,	1,	'2025-11-29 09:54:32',	'2025-11-30 10:58:20');

DROP TABLE IF EXISTS `cost_categories`;
CREATE TABLE `cost_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `cost_categories` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1,	'Transport Cost',	NULL,	1,	'2025-11-18 00:24:51',	'2025-11-18 00:24:51'),
(2,	'Installation Charge',	NULL,	1,	'2025-11-18 00:28:24',	'2025-11-18 17:02:00');

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `images` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification_code` int DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `billing_address` bigint DEFAULT NULL,
  `shipping_address` bigint DEFAULT NULL,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `customers` (`id`, `name`, `country_code`, `phone`, `email`, `email_verified_at`, `address`, `images`, `verification_code`, `is_verified`, `billing_address`, `shipping_address`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(19,	'Averroes International  School',	NULL,	'01302223312',	NULL,	NULL,	'Lalmatia,7/16 B-block',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-03-14 04:22:03',	'2026-03-14 04:22:03'),
(20,	'Unique Trade Co',	NULL,	'01718943547',	NULL,	NULL,	'Shamim sarani,Sewrapara,Mirpur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-03-14 04:24:04',	'2026-03-14 04:24:04'),
(21,	'Techno Solution',	NULL,	'01894892867',	NULL,	NULL,	'Elephant Road,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-03-14 04:25:46',	'2026-03-14 04:25:46'),
(22,	'Nonghor Photo Graphics',	NULL,	'01723407102',	NULL,	NULL,	'Gloria Tower (Gnd Floor), Paltan',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-03-14 04:26:52',	'2026-03-14 04:26:52'),
(23,	'Access Printing and service',	NULL,	'01922838955',	NULL,	NULL,	'House 285,Mollapara, Monirpur, Mirpur 2',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:40:44',	'2026-04-19 11:40:44'),
(24,	'Active Computer Technology',	NULL,	'01716020383',	NULL,	NULL,	'Green Road, Panthapath',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:42:28',	'2026-04-19 11:42:28'),
(25,	'Adhoc Station Headquter',	NULL,	'01605686380',	NULL,	NULL,	'Mirpur, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:43:41',	'2026-04-19 11:43:41'),
(26,	'Aegis Service Limited',	NULL,	'01332508443',	NULL,	NULL,	'House-41.Road-27,Banani, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:45:23',	'2026-04-19 11:45:23'),
(27,	'Affix Amity Trade International',	NULL,	'01763152733',	NULL,	NULL,	'Badda, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:50:33',	'2026-04-19 11:50:33'),
(28,	'Ahsania Mission Cancer & General Hospital',	NULL,	'01919922304',	NULL,	NULL,	'P # 3, Embankment Driveway, S # 10, Uttara, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:51:48',	'2026-04-19 11:51:48'),
(29,	'AI Technology',	NULL,	'01628201270',	NULL,	NULL,	'Shop # 15, Block # D, Baitul Mukarram Super Market, Dhaka-1000',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:54:04',	'2026-04-19 11:54:04'),
(30,	'Al Amin Enterprise',	NULL,	'01716501730',	NULL,	NULL,	'Gulshan -2',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:55:21',	'2026-04-19 11:55:21'),
(31,	'All in One',	NULL,	'01614939907',	NULL,	NULL,	'Farmgate ,Tejgaon,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:56:51',	'2026-04-19 11:56:51'),
(32,	'Alpha Clothing Ltd',	NULL,	'01611450012',	NULL,	NULL,	'Baridhara,DOHS',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:57:54',	'2026-04-19 11:57:54'),
(33,	'Amran Shah Bulbul',	NULL,	'01644103474',	NULL,	NULL,	'Kaliganj Bazar ,Shylet',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:58:31',	'2026-04-19 11:58:31'),
(34,	'Annex IT',	NULL,	'01612345686',	NULL,	NULL,	'Faridpur Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:59:10',	'2026-04-19 11:59:10'),
(35,	'ANR Fashion Wear Limited',	NULL,	'01752873016',	NULL,	NULL,	'Deger Chala Road,National University, Gazipur -1704',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 11:59:55',	'2026-04-19 11:59:55'),
(36,	'ANR Technology',	NULL,	'01915471747',	NULL,	NULL,	'Shop No.-21, Rahmania International Complex',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:00:53',	'2026-04-19 12:00:53'),
(37,	'Ansar Headquarter',	NULL,	'01740620005',	NULL,	NULL,	'Malibagh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:01:31',	'2026-04-19 12:01:31'),
(38,	'Anwara Trading',	NULL,	'01815717737',	NULL,	NULL,	'Chattagram',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:03:38',	'2026-04-19 12:03:38'),
(39,	'AR Trade International',	NULL,	'01719116301',	NULL,	NULL,	'BS Bhaban,(Lift-4) New Elephant Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:04:24',	'2026-04-19 12:04:24'),
(40,	'Araf Computer & Communication',	NULL,	'01711636208',	NULL,	NULL,	'02, Ranbabu Road (1st Floor), Opposite Mohakali School, Mymensingh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:04:56',	'2026-04-19 12:04:56'),
(41,	'Argoan Technology',	NULL,	'01815312122',	NULL,	NULL,	'Shop: 701-702, Suvastu Arcade ICT Bhaban, Lift Floor- 07, 46 নিউ এলিফ্যান্ট রোড, ঢাকা 1205',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:05:31',	'2026-04-19 12:05:31'),
(42,	'Arham Traders',	NULL,	'01783000106',	NULL,	NULL,	'Tejgaon, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:06:52',	'2026-04-19 12:06:52'),
(43,	'Aristo IT and Services',	NULL,	'01884552666',	NULL,	NULL,	'New Elephant Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:07:48',	'2026-04-19 12:07:48'),
(44,	'ARMY SPORT CONTROL BOARD(ASCB)',	NULL,	'01769012195',	NULL,	NULL,	'Dhaka Cantonment, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:08:23',	'2026-04-19 12:08:23'),
(45,	'Arparnet Computer',	NULL,	'01819698263',	NULL,	NULL,	'Gari Khana Road,Jessore',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:08:58',	'2026-04-19 12:08:58'),
(46,	'Asia Pacific University',	NULL,	'01671156901',	NULL,	NULL,	'Farmgate',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:09:31',	'2026-04-19 12:09:31'),
(47,	'Asia Trade Chittagong',	NULL,	'01819904484',	NULL,	NULL,	'Anderkilla, Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:10:04',	'2026-04-19 12:10:04'),
(48,	'Asian Computer',	NULL,	'01712923361',	NULL,	NULL,	'Panthapath',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:11:05',	'2026-04-19 12:11:05'),
(49,	'Averroes International School, Lalmatia',	NULL,	'01724497043',	NULL,	NULL,	'Lalmatia,7/16 B-block',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:11:37',	'2026-04-19 12:11:37'),
(50,	'Axiom International',	NULL,	'01719328628',	NULL,	NULL,	'Satmatha, Koigari, Bogra',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:12:39',	'2026-04-19 12:12:39'),
(51,	'AZ TechBD',	NULL,	'01811789710',	NULL,	NULL,	'Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:13:35',	'2026-04-19 12:13:35'),
(52,	'Azad Printing',	NULL,	'01718579921',	NULL,	NULL,	'Modhumita Road, Tongi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:14:08',	'2026-04-19 12:14:08'),
(53,	'Aziz Trade',	NULL,	'01712012590',	NULL,	NULL,	'Caab Headquarter',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:14:38',	'2026-04-19 12:14:38'),
(54,	'B-Fresh Limited',	NULL,	'01820868718',	NULL,	NULL,	'Banani',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:15:14',	'2026-04-19 12:15:14'),
(55,	'BAF Shaheen College',	NULL,	'01685139673',	NULL,	NULL,	'3rd Gate, Near Shaheed Jahangir Gate,Dhaka-1206',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:15:54',	'2026-04-19 12:15:54'),
(56,	'Bangladesh Agriculture University',	NULL,	'01711452496',	NULL,	NULL,	'Mymensingh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:16:34',	'2026-04-19 12:16:34'),
(57,	'Bappy Business Media',	NULL,	'01673577544',	NULL,	NULL,	'Motijheel',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:17:10',	'2026-04-19 12:17:10'),
(58,	'Bari Technology',	NULL,	'01716119110',	NULL,	NULL,	'Banasree, Road -05, Block-z',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:17:43',	'2026-04-19 12:17:43'),
(59,	'Barind Medical College',	NULL,	'01716902001',	NULL,	NULL,	'Padma Abasic, Chandrima, Rajshahi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:21:32',	'2026-04-19 12:21:32'),
(60,	'Barishal Palli Bidut Somiti-2',	NULL,	'01922201688',	NULL,	NULL,	'Barishal Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:22:09',	'2026-04-19 12:22:09'),
(61,	'Bashundhara Jewellers',	NULL,	'01921076464',	NULL,	NULL,	'Santinagar Twin Tower',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:30:05',	'2026-04-19 12:30:05'),
(62,	'BAUET',	NULL,	'01727564207',	NULL,	NULL,	'Qadirabad,Natore',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:30:46',	'2026-04-19 12:30:46'),
(63,	'Belle Vue Hospital',	NULL,	'01907809205',	NULL,	NULL,	'Panchlaish, Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:31:24',	'2026-04-19 12:31:24'),
(64,	'BGB Record Wing',	NULL,	'01707409467',	NULL,	NULL,	'Philkhana,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:36:01',	'2026-04-19 12:36:01'),
(65,	'Bhai Bhai Accessories',	NULL,	'01624647999',	NULL,	NULL,	'Mirpur -11',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:36:32',	'2026-04-19 12:36:32'),
(66,	'Bio-Xin',	NULL,	'01325097253',	NULL,	NULL,	'Mirpur DOHS Cultural Center, Level-4',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:37:12',	'2026-04-19 12:37:12'),
(67,	'Blue Star Enterprise',	NULL,	'01711639181',	NULL,	NULL,	'Motijheel',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:37:41',	'2026-04-19 12:37:41'),
(68,	'Bogura Cantonment',	NULL,	'01798730504',	NULL,	NULL,	'Station Headquarter,Bogura Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:38:15',	'2026-04-19 12:38:15'),
(69,	'Bogura Millennium Scholastic English Medium School',	NULL,	'01751853786',	NULL,	NULL,	'Bagura Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:38:48',	'2026-04-19 12:38:48'),
(70,	'Bornil Printing Press',	NULL,	'01925511226',	NULL,	NULL,	'Shariatpur Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:39:43',	'2026-04-19 12:39:43'),
(71,	'Brothers Enterprise',	NULL,	'01775903987',	NULL,	NULL,	'Shop No.-14(1st Floor),Unicorn Plaza,Gulshan -2',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:40:13',	'2026-04-19 12:40:13'),
(72,	'Brothers Tech',	NULL,	'01711024146',	NULL,	NULL,	'Rampura, Bono-sree',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:40:47',	'2026-04-19 12:40:47'),
(73,	'Building for Future Ltd',	NULL,	'01705390540',	NULL,	NULL,	'GQ Shefali Tower, Uttara Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:41:22',	'2026-04-19 12:41:22'),
(74,	'Byatikram Digital Sign',	NULL,	'01828612081',	NULL,	NULL,	'এইচ আর সিটি কমপ্লেক্স, বসুরহাট, কোম্পানীগন্জ, নোয়াখালী',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:42:17',	'2026-04-19 12:42:17'),
(75,	'Cantonment Public School and College Momenshahi',	NULL,	'01646488608',	NULL,	NULL,	'Momenshahi Cantonment, Mymensingh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:42:51',	'2026-04-19 12:42:51'),
(76,	'Care Point, Chattogram',	NULL,	'01750545491',	NULL,	NULL,	'Chawkbazar, Chattogram',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:43:21',	'2026-04-19 12:43:21'),
(77,	'Carren International',	NULL,	'01726496745',	NULL,	NULL,	'Bogura Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:43:57',	'2026-04-19 12:43:57'),
(78,	'Central Hospital Ltd',	NULL,	'01733167890',	NULL,	NULL,	'House # 2 সড়ক নং ৫, Green Rd, Dhaka 1205',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:44:52',	'2026-04-19 12:44:52'),
(79,	'Chader Hasi Hospital',	NULL,	'01717932061',	NULL,	NULL,	'Habiganj Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:45:29',	'2026-04-19 12:45:29'),
(80,	'Chandrima Real Estate (PVT) LTD',	NULL,	'01973001971',	NULL,	NULL,	'House # 18, Avenue # 1 Block # A, Chandrima Model Town, Mohammadpur, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:46:03',	'2026-04-19 12:46:03'),
(81,	'Chasma Ghar',	NULL,	'01626737563',	NULL,	NULL,	'170,K,c Dey road, beside dexi bari resutaurant , Lal dighi Chattogram',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:46:31',	'2026-04-19 12:46:31'),
(82,	'Chevron Hospital',	NULL,	'01866980878',	NULL,	NULL,	'JBK Tower,Grand Trunk Road, Feni',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:47:09',	'2026-04-19 12:47:09'),
(83,	'Chevron tulip Turjo',	NULL,	'01743555858',	NULL,	NULL,	'Gulshan 2 , Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:52:25',	'2026-04-19 12:52:25'),
(84,	'City Hospital',	NULL,	'01726703250',	NULL,	NULL,	'Shath Mashjid Road,Shankar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:52:57',	'2026-04-19 12:52:57'),
(85,	'City Solution',	NULL,	'01727307354',	NULL,	NULL,	'H-35, Ground Floor, Nee Elrphant Road, Dhaka-1205',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:53:29',	'2026-04-19 12:53:29'),
(86,	'Civil Aviation School and College',	NULL,	'01990360211',	NULL,	NULL,	'Kurmitola , Dhaka -1229',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:54:02',	'2026-04-19 12:54:02'),
(87,	'Civil Aviation Authority of Bangladesh CAAB',	NULL,	'01552554741',	NULL,	NULL,	'Uttara, Airport',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:54:43',	'2026-04-19 12:54:43'),
(88,	'Civil Defence Office',	NULL,	'01740008376',	NULL,	NULL,	'Pallabi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:55:10',	'2026-04-19 12:55:10'),
(89,	'Comfit Composite Knit Ltd',	NULL,	'01714507066',	NULL,	NULL,	'Youth Tower,B22/2, Rokeya Sarani,(8th Floor),Dhaka-1216',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:58:47',	'2026-04-19 12:58:47'),
(90,	'Computer Care',	NULL,	'01713060922',	NULL,	NULL,	'Shelthech sierra, Elephant roaad, Shop No: 410',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 12:59:34',	'2026-04-19 12:59:34'),
(91,	'Computer Village',	NULL,	'01680875747',	NULL,	NULL,	'Shop#226, 2nd Floor, BCS Computer City, Agargaon, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:00:03',	'2026-04-19 13:00:03'),
(92,	'Creative Computer',	NULL,	'01580806206',	NULL,	NULL,	'Laksam,Cumilla',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:00:39',	'2026-04-19 13:00:39'),
(93,	'Crescent Hospital',	NULL,	'01920540150',	NULL,	NULL,	'Uttara, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:01:27',	'2026-04-19 13:01:27'),
(94,	'CSL Service',	NULL,	'01893115555',	NULL,	NULL,	'3rd Floor, Hannan Plaza, House-02, Road-01/A, Sector-09, Uttara, Dhaka-1230',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:01:55',	'2026-04-19 13:01:55'),
(95,	'Defence Services Command & Staff College',	NULL,	'01769008721',	NULL,	NULL,	'Mirpur Cantonment, Mirpur,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:02:58',	'2026-04-19 13:02:58'),
(96,	'Delta Life Insurance Limited',	NULL,	'01912325976',	NULL,	NULL,	'Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:04:08',	'2026-04-19 13:04:08'),
(97,	'Design Point',	NULL,	'01730932553',	NULL,	NULL,	'Fakirapool',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:23:15',	'2026-04-19 13:23:15'),
(98,	'Dhaka Club',	NULL,	'01724849252',	NULL,	NULL,	'Sahbag,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:24:25',	'2026-04-19 13:24:25'),
(99,	'Dhaka Community Hospital and College',	NULL,	'01572014813',	NULL,	NULL,	'Wireless Moor,Moghbazar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:25:11',	'2026-04-19 13:25:11'),
(100,	'Dhaka International University',	NULL,	'01684717384',	NULL,	NULL,	'Satarkul,Badda,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:25:47',	'2026-04-19 13:25:47'),
(101,	'Dhaka Logistics Service and Solution',	NULL,	'01737698244',	NULL,	NULL,	'Houses B101,Road-07,Mohakhali DOHS',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:26:15',	'2026-04-19 13:26:15'),
(102,	'Dhaka Stock Exchange PLC',	NULL,	'01713425848',	NULL,	NULL,	'DSE Tower, House#46, Road#21, Nikunja-2, Dhaka -1229, Bangladesh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:26:47',	'2026-04-19 13:26:47'),
(103,	'Dhaka Tax Bar Association',	NULL,	'01834663298',	NULL,	NULL,	'Segunbagicha',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:27:27',	'2026-04-19 13:27:27'),
(104,	'Diamond House',	NULL,	'01958067616',	NULL,	NULL,	'Metro Shoppingmall,Shop No-124-125. Dhanmondi -32,01677036264',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:28:03',	'2026-04-19 13:28:03'),
(105,	'DIGI SOLUTION',	NULL,	'01552374042',	NULL,	NULL,	'Road-7, 13th floor, Rupayan Prime , Green Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:31:22',	'2026-04-19 13:31:22'),
(106,	'Digital Computer Center',	NULL,	'01717317454',	NULL,	NULL,	'Ka-34/2, Kalachandpur School Road, Gulshan-2',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:33:08',	'2026-04-19 13:33:08'),
(107,	'Digital Croprotioan',	NULL,	'01761097747',	NULL,	NULL,	'Farmgate, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:33:41',	'2026-04-19 13:33:41'),
(108,	'Dipok Enterprise',	NULL,	'01816902612',	NULL,	NULL,	'Sitakunda',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:34:08',	'2026-04-19 13:34:08'),
(109,	'Drug International Limited',	NULL,	'01301749151',	NULL,	NULL,	'Green Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:34:44',	'2026-04-19 13:34:44'),
(110,	'Durgapur Degree College Durgapur',	NULL,	'01722868577',	NULL,	NULL,	'Rajshahi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:35:21',	'2026-04-19 13:35:21'),
(111,	'E-Online Point Home Tex',	NULL,	'01897713273',	NULL,	NULL,	'Sector-11, House-42, Road-11, Uttara',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:35:50',	'2026-04-19 13:35:50'),
(112,	'Easy Tech',	NULL,	'01870517959',	NULL,	NULL,	'Palton,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:36:23',	'2026-04-19 13:36:23'),
(113,	'Easy Tech Trading Solution',	NULL,	'01511119878',	NULL,	NULL,	'583, Anamika Concord (1st floor), Shamim sharoni, Dhaka-1216',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:36:52',	'2026-04-19 13:36:52'),
(114,	'English Therapy',	NULL,	'01329636829',	NULL,	NULL,	'Road No. 6, Dhaka 1216',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:37:31',	'2026-04-19 13:37:31'),
(115,	'Essential Drugs Company Limited',	NULL,	'01842912928',	NULL,	NULL,	'395-397,Tejgaon Industrial Area',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:37:53',	'2026-04-19 13:37:53'),
(116,	'Essential Latex Processing Plant',	NULL,	'01792656793',	NULL,	NULL,	'Pirgacga, Rabar Bagan, Madhupur , Tangail.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:38:28',	'2026-04-19 13:38:28'),
(117,	'Euro Trade',	NULL,	'01301809766',	NULL,	NULL,	'Sankar, Dhanmondi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:38:53',	'2026-04-19 13:38:53'),
(118,	'European Standard School',	NULL,	'01321201963',	NULL,	NULL,	'Dhanmondi 7/A',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:39:28',	'2026-04-19 13:39:28'),
(119,	'Everest Pharmaceutical',	NULL,	'01909106711',	NULL,	NULL,	'Tejgaon link Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:39:59',	'2026-04-19 13:39:59'),
(120,	'Exclusive communication',	NULL,	'01934373839',	NULL,	NULL,	'Road-23,Mohakhali DOHS',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:40:26',	'2026-04-19 13:40:26'),
(121,	'Fakhruddin Enterprise',	NULL,	'01816760655',	NULL,	NULL,	'Motijheel',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:40:55',	'2026-04-19 13:40:55'),
(122,	'Fast Service',	NULL,	'01717590882',	NULL,	NULL,	'Uttara',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:41:30',	'2026-04-19 13:41:30'),
(123,	'Finesse Lifestyle Ltd',	NULL,	'01998685230',	NULL,	NULL,	'5th floor , sylhet city center, zindabazar, sylhet',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:42:03',	'2026-04-19 13:42:03'),
(124,	'FIU',	NULL,	'01769013712',	NULL,	NULL,	'Dhaka Cantonment',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:42:27',	'2026-04-19 13:42:27'),
(125,	'FM Technology Solution',	NULL,	'01716551859',	NULL,	NULL,	'Shahera Tropical Center, Shop-18, Level-3, Bata Signal Mor, New Elephent Road ElephantRoad, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:42:59',	'2026-04-19 13:42:59'),
(126,	'Fortune Biz Solution',	NULL,	'01323368114',	NULL,	NULL,	'193/2 Siddique Mansion (3rd Floor),Flat No # 403, Fakirapool, Motijheel, Dhaka-1000',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:44:06',	'2026-04-19 13:44:06'),
(127,	'Friends Computer',	NULL,	'01728580495',	NULL,	NULL,	'Akram Tower Purana Paltan, lift#5',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 13:44:44',	'2026-04-19 13:44:44'),
(128,	'General Automation LTD Mirpur',	NULL,	'01733611646',	NULL,	NULL,	'Sukrabad,Dhanmondi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:42:49',	'2026-04-19 14:42:49'),
(129,	'General Telecom',	NULL,	'01717120114',	NULL,	NULL,	'Nobabpur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:43:15',	'2026-04-19 14:43:15'),
(130,	'Germania Corporation limited',	NULL,	'01911569085',	NULL,	NULL,	'Police Plaza Concord, Unit #M,Level # 11,Tower#1,Plot#2,Road#144, Gulshan-1, Dhaka-1212',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:43:45',	'2026-04-19 14:43:45'),
(131,	'Gias Uddin Islamic Model College',	NULL,	'01911590713',	NULL,	NULL,	'Hirajheel,Siddirganj,Narayanganj',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:44:18',	'2026-04-19 14:44:18'),
(132,	'Globe Office Equipment',	NULL,	'01711563660',	NULL,	NULL,	'House -23,Road-8,Sector -3',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:44:48',	'2026-04-19 14:44:48'),
(133,	'Glory computers',	NULL,	'01911734170',	NULL,	NULL,	'236 new elephant road, sheltech sierra computer city, 2nd floor, room no- 234, dhaka-1205',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:45:19',	'2026-04-19 14:45:19'),
(134,	'Goodman Pharma',	NULL,	'01797014054',	NULL,	NULL,	'Dhanmondhi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:45:43',	'2026-04-19 14:45:43'),
(135,	'GS Trading',	NULL,	'01915893905',	NULL,	NULL,	'PaltanHaji Jamiruddin Shafina Mohila Degree College\r\nRajshahi Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:46:19',	'2026-04-19 14:46:19'),
(136,	'Haji Jamiruddin Shafina Mohila Degree College',	NULL,	'01738663423',	NULL,	NULL,	'Rajshahi Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:46:51',	'2026-04-19 14:46:51'),
(137,	'Halima Studio',	NULL,	'01956006598',	NULL,	NULL,	'Mirpur -1',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:47:27',	'2026-04-19 14:47:27'),
(138,	'Happy Mars',	NULL,	'01717668993',	NULL,	NULL,	'Mirpur -1',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:53:32',	'2026-04-19 14:53:32'),
(139,	'Hasan Graphics',	NULL,	'01727409969',	NULL,	NULL,	'Fakirapool',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:54:05',	'2026-04-19 14:54:05'),
(140,	'Hasan ID card',	NULL,	'01756010706',	NULL,	NULL,	'Road-4, Block a, Banasree,Rampura',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:55:39',	'2026-04-19 14:55:39'),
(141,	'Hasan Trade',	NULL,	'01885511306',	NULL,	NULL,	'Nabinagar Pollybiddut, Savar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:56:27',	'2026-04-19 14:56:27'),
(142,	'Hatikhala High School',	NULL,	'01728982636',	NULL,	NULL,	'Gafargaon,Mymensingh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:56:56',	'2026-04-19 14:56:56'),
(143,	'Hazi Tech',	NULL,	'01777661999',	NULL,	NULL,	'Level #7, Shop #720,738 69, Multiplan Center, 71 New Elephant Rd, Dhaka 1205',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:57:29',	'2026-04-19 14:57:29'),
(144,	'Hossain Brothers 1 Sikder Market, Main Road, Tek Para, Cox\'s Bazar',	NULL,	'01840507003',	NULL,	NULL,	'1 Sikder Market, Main Road, Tek Para, Cox\'s Bazar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 14:58:03',	'2026-04-19 14:58:03'),
(145,	'Hypertension and Research Centre',	NULL,	'01723612188',	NULL,	NULL,	'Holding No 13/2, Hypertension Centre Lane, Dhap, Jail Road, Rangpur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:01:28',	'2026-04-19 15:01:28'),
(146,	'IBN Global System',	NULL,	'01717548038',	NULL,	NULL,	'221, South pirerbag Amtala Bazar 60 Feet,Dhaka-1216',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:02:30',	'2026-04-19 15:02:30'),
(147,	'Ibn Sina',	NULL,	'01687468382',	NULL,	NULL,	'D-Lab Bhaban -02, Lift-08,Housebuilding, Uttara',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:03:14',	'2026-04-19 15:03:14'),
(148,	'ICS System Solution',	NULL,	'01784446633',	NULL,	NULL,	'Middile Badda',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:04:01',	'2026-04-19 15:04:01'),
(149,	'Ideal Enterprise',	NULL,	'01712923930',	NULL,	NULL,	'Mirpur-1',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:04:43',	'2026-04-19 15:04:43'),
(150,	'Indosore Sweater Limited',	NULL,	'01970045275',	NULL,	NULL,	'Saydana,Gazipur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:05:24',	'2026-04-19 15:05:24'),
(151,	'Infynix Solutions',	NULL,	'01911172084',	NULL,	NULL,	'Mirpur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:06:09',	'2026-04-19 15:06:09'),
(152,	'Insaf Barakah Kidney & General Hospital',	NULL,	'01978098081',	NULL,	NULL,	'Mogbazar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:06:58',	'2026-04-19 15:06:58'),
(153,	'Intelligent Solution Limited',	NULL,	'01842948036',	NULL,	NULL,	'Mirpur -6',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:07:42',	'2026-04-19 15:07:42'),
(154,	'International Hope School',	NULL,	'01911227363',	NULL,	NULL,	'Gulshan -1',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:08:24',	'2026-04-19 15:08:24'),
(155,	'International Trimmings & Lebels Bangladesh',	NULL,	'01713426040',	NULL,	NULL,	'Private Ltd Road-2, Uttara,Dhaka-1230',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:09:19',	'2026-04-19 15:09:19'),
(156,	'Intra Food & Beverage',	NULL,	'01744959697',	NULL,	NULL,	'Khawaja Nagar, Dipchar Road Bolarampur, Pabna.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:10:27',	'2026-04-19 15:10:27'),
(157,	'Ishrat Enterprise',	NULL,	'01719722892',	NULL,	NULL,	'Motijheel',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:11:05',	'2026-04-19 15:11:05'),
(158,	'Iskcon Kheturi Dham',	NULL,	'01776644257',	NULL,	NULL,	'Godagari, Rajshahi Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:11:47',	'2026-04-19 15:11:47'),
(159,	'Ispahani Cantonment Public School and College',	NULL,	'01789543183',	NULL,	NULL,	'Cumilla',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:12:21',	'2026-04-19 15:12:21'),
(160,	'IT Bazar',	NULL,	'01788111131',	NULL,	NULL,	'Savar, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:13:02',	'2026-04-19 15:13:02'),
(161,	'IT Bazar',	NULL,	'01339581986',	NULL,	NULL,	'35,36 Savar New Market',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:14:05',	'2026-04-19 15:14:05'),
(162,	'IT Factory Bangladesh',	NULL,	'01712409343',	NULL,	NULL,	'535-536, Froth Floor, Ponchokhana Supper Market, Sylhet',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:14:45',	'2026-04-19 15:14:45'),
(163,	'IT Square BD Hamza',	NULL,	'01817737741',	NULL,	NULL,	'Tower, hamzerbag, panchlaish, CTG',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:15:27',	'2026-04-19 15:15:27'),
(164,	'Jafor ID Solution',	NULL,	'01829864311',	NULL,	NULL,	'Nilkhet',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:16:15',	'2026-04-19 15:16:15'),
(165,	'Jahanara Israil School & College',	NULL,	'01575082901',	NULL,	NULL,	'999 College Row, Barishal',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:16:50',	'2026-04-19 15:16:50'),
(166,	'Jewel Vai',	NULL,	'01711784861',	NULL,	NULL,	'Dhanmondhi, Dhaka.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:17:29',	'2026-04-19 15:17:29'),
(167,	'JM Cargo and Courier Service',	NULL,	'01718115182',	NULL,	NULL,	'Rampura Staff Quarter Link Road,Demra',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:18:25',	'2026-04-19 15:18:25'),
(168,	'Jony Vai',	NULL,	'01676413962',	NULL,	NULL,	'Motijheel',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:19:10',	'2026-04-19 15:19:10'),
(169,	'Junan Computer',	NULL,	'01568734866',	NULL,	NULL,	'Babuchara Bazar, Diginala,Khagrachhari',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:20:21',	'2026-04-19 15:20:21'),
(170,	'Junior Laboratory High School',	NULL,	'01764538009',	NULL,	NULL,	'House 38, Road 10/A,Dhanmondi, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:20:57',	'2026-04-19 15:20:57'),
(171,	'K local Digital Sign',	NULL,	'01929383795',	NULL,	NULL,	'Kushtia Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:21:46',	'2026-04-19 15:21:46'),
(172,	'Kamal Enterprise',	NULL,	'01912239886',	NULL,	NULL,	'Mirpur -1',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:22:23',	'2026-04-19 15:22:23'),
(173,	'Kazi Digital Automation',	NULL,	'01818026775',	NULL,	NULL,	'53, B R T C Market, Station road,Chattogram',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:22:59',	'2026-04-19 15:22:59'),
(174,	'KEPZ Computer',	NULL,	'01624435760',	NULL,	NULL,	'CEPZ, Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:23:33',	'2026-04-19 15:23:33'),
(175,	'Khagrachari Cantonment Public School and College',	NULL,	'01552717577',	NULL,	NULL,	'Khagrachari Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:33:58',	'2026-04-19 15:33:58'),
(176,	'Khan Computer',	NULL,	'01770647287',	NULL,	NULL,	'Kushtia Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:34:44',	'2026-04-19 15:34:44'),
(177,	'Khan Enterprise',	NULL,	'01781142590',	NULL,	NULL,	'CAAB Headquarter Airport',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:38:31',	'2026-04-19 15:38:31'),
(178,	'Khan Zahan Ali Press',	NULL,	'01706090919',	NULL,	NULL,	'64 KCC Super market ,Khulna',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:39:05',	'2026-04-19 15:39:05'),
(179,	'Labaid Diagnostic (Dinajpur)',	NULL,	'01766662199',	NULL,	NULL,	'Sadar Hospital Road, Dinajpur.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:39:48',	'2026-04-19 15:39:48'),
(180,	'Labaid Diagnostic (Rangpur)',	NULL,	'01766660145',	NULL,	NULL,	'Jail Road, Ranhpur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:40:25',	'2026-04-19 15:40:25'),
(181,	'Labaid Diagnostic (Tangail)',	NULL,	'01766662220',	NULL,	NULL,	'Holding: 247, Maymensingh Road, Sabalia, Tangail Sador',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:41:03',	'2026-04-19 15:41:03'),
(182,	'Labaid Diagonistic',	NULL,	'01766662530',	NULL,	NULL,	'Gulshan',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:41:42',	'2026-04-19 15:41:42'),
(183,	'Labaid Diognostic (Mymensingh)',	NULL,	'01911059516',	NULL,	NULL,	'Mymensingh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:42:28',	'2026-04-19 15:42:28'),
(184,	'Labaid Ltd. Diagnostic',	NULL,	'01766661212',	NULL,	NULL,	'Malibag Rahaman Arcadia, House-B65, DIT Avenue, Malibag Chowdhury Para Rd. Dhaka 1217',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:43:25',	'2026-04-19 15:43:25'),
(185,	'Labaid Ltd. Diagnostic Norsingdi',	NULL,	'01766661830',	NULL,	NULL,	'House No. 89/4, DC Mor Jailkhana Road, Torowa, Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:44:10',	'2026-04-19 15:44:10'),
(186,	'Labaid Specialized Hospital (Chittagong)',	NULL,	'01623700051',	NULL,	NULL,	'Nizam Road, Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:45:03',	'2026-04-19 15:45:03'),
(187,	'Lotus Computer Multiplan Center',	NULL,	'01761499315',	NULL,	NULL,	'Level -7,Shop-750 A, 69-71,New Elephant Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:46:19',	'2026-04-19 15:46:19'),
(188,	'LUCIDTech Rahman',	NULL,	'01894839307',	NULL,	NULL,	'Lucid Tower, Kakrail, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:47:07',	'2026-04-19 15:47:07'),
(189,	'M Technology',	NULL,	'01739680379',	NULL,	NULL,	'Shop-217,Sheltch Sierra Computer City 236,New Elephant Road,Dhka-1205',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:47:54',	'2026-04-19 15:47:54'),
(190,	'M/s Power Enterprise',	NULL,	'01816905442',	NULL,	NULL,	'169,Bashar,Supper Market,Baizid Bostami,Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:48:38',	'2026-04-19 15:48:38'),
(191,	'Mahdir Metallic & Graphic House',	NULL,	'01746004541',	NULL,	NULL,	'Dingaboda more,Rajpara, Rajshahi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:49:16',	'2026-04-19 15:49:16'),
(192,	'Mahmud',	NULL,	'01626764512',	NULL,	NULL,	'Master hafiz uddin Goli, Chlabon Chaity,Azompur, Uttara, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:50:14',	'2026-04-19 15:50:14'),
(193,	'Mainamati English School and College',	NULL,	'01769331361',	NULL,	NULL,	'Cumilla Cantonment, Cumilla',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:50:56',	'2026-04-19 15:50:56'),
(194,	'Mamun Computer',	NULL,	'01834953496',	NULL,	NULL,	'Dhanbari,Tangail',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:51:44',	'2026-04-19 15:51:44'),
(195,	'Manarat International School and College',	NULL,	'01822222353',	NULL,	NULL,	'Polt(CEN) Road # 104,Gulshan-2,Dhaka-1212',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:52:29',	'2026-04-19 15:52:29'),
(196,	'Maple Leaf International School',	NULL,	'01915525848',	NULL,	NULL,	'11/a, House-95/1, Dhanmondi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:53:06',	'2026-04-19 15:53:06'),
(197,	'Master Link It',	NULL,	'01621771640',	NULL,	NULL,	'Multiplan',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:53:38',	'2026-04-19 15:53:38'),
(198,	'Matrichiya Printers',	NULL,	'01716778696',	NULL,	NULL,	'Mirpur-10',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:54:19',	'2026-04-19 15:54:19'),
(199,	'Micare Health Limited Shaymoli',	NULL,	'01898803000',	NULL,	NULL,	'Cinema Hall Building Complex, 3rd Floor(lift-3),Ring Road,Shaymoli, Dhaka-1207',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:55:07',	'2026-04-19 15:55:07'),
(200,	'Micro Automation',	NULL,	'01716242550',	NULL,	NULL,	'68,Khilgaon Chowdhury Para,1st Flr.D.I.T Road,Dhaka-1219',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:55:56',	'2026-04-19 15:55:56'),
(201,	'Mirpur Staff College',	NULL,	'01867681382',	NULL,	NULL,	'Mirpur-12',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:56:29',	'2026-04-19 15:56:29'),
(202,	'Mirpur Station Headquarters',	NULL,	'01401811242',	NULL,	NULL,	'Mirpur 12',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 15:57:11',	'2026-04-19 15:57:11'),
(203,	'Modern Herbal Group',	NULL,	'01678075340',	NULL,	NULL,	'Mogbazar, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:03:41',	'2026-04-19 16:03:41'),
(204,	'Modern Stationary',	NULL,	'01616547977',	NULL,	NULL,	'25, Kakrail.Paltan',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:04:17',	'2026-04-19 16:04:17'),
(205,	'Cancer Hospital',	NULL,	'01817380571',	NULL,	NULL,	'Mohakhali',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:05:01',	'2026-04-19 16:05:01'),
(206,	'Mohammadpur Fertility Services and Training Centre',	NULL,	'01761646148',	NULL,	NULL,	'(MFSTC) plot # 14, Aurangzeb road (New - 49, 35 Shahjahan Rd, Dhaka 1207',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:05:55',	'2026-04-19 16:05:55'),
(207,	'Mohammadpur Preparatory School and College',	NULL,	'01681536232',	NULL,	NULL,	'Mohammadpur, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:06:32',	'2026-04-19 16:06:32'),
(208,	'Mohon Digital',	NULL,	'01537048955',	NULL,	NULL,	'Anderkilla, Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:07:04',	'2026-04-19 16:07:04'),
(209,	'Moon Moon Studio',	NULL,	'01744135500',	NULL,	NULL,	'Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:07:46',	'2026-04-19 16:07:46'),
(210,	'Munshi Digital Sign',	NULL,	'01765873457',	NULL,	NULL,	'Moksudpur,Gopalganj',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:08:46',	'2026-04-19 16:08:46'),
(211,	'My TV',	NULL,	'01325066693',	NULL,	NULL,	'Rampura',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:09:19',	'2026-04-19 16:09:19'),
(212,	'Mymensingh International School (MIS)',	NULL,	'01748388705',	NULL,	NULL,	'Mymenshing cantonment ,Mymenshing',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:13:57',	'2026-04-19 16:13:57'),
(213,	'Narsingdi Chamber of commerce & Industry',	NULL,	'01715026476',	NULL,	NULL,	'796, Bilashdi, DC Road, Narsingdi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:15:30',	'2026-04-19 16:15:30'),
(214,	'National Computer',	NULL,	'01960531827',	NULL,	NULL,	'Agrabad,Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:16:05',	'2026-04-19 16:16:05'),
(215,	'National Garment Workers Federation',	NULL,	'01731201302',	NULL,	NULL,	'31/F,Topkhana Road,Dhaka-1000',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:16:47',	'2026-04-19 16:16:47'),
(216,	'Net Finders',	NULL,	'01741772656',	NULL,	NULL,	'Bata signal, level -5',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:17:23',	'2026-04-19 16:17:23'),
(217,	'Netpro School',	NULL,	'01329648874',	NULL,	NULL,	'Bogura',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:18:00',	'2026-04-19 16:18:00'),
(218,	'New Amena Corporation',	NULL,	'01721296049',	NULL,	NULL,	'14, Shop No.24, Ground Floor, Dar-us-Salaam Arcade, Purana Paltan, Dhaka 1000',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:19:19',	'2026-04-19 16:19:19'),
(219,	'Nexus Computer',	NULL,	'01970009913',	NULL,	NULL,	'IDB , Agargaon',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:20:08',	'2026-04-19 16:20:08'),
(220,	'Nilphamari Govt College',	NULL,	'01818804084',	NULL,	NULL,	'Nilphamari Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:20:47',	'2026-04-19 16:20:47'),
(221,	'Noman Fashion Fabrics Limited Adamjee',	NULL,	'01900000222',	NULL,	NULL,	'Court Annex-2 Building (09th Floor) 115-120,Motijheel C/A, Dhaka-100',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:21:55',	'2026-04-19 16:21:55'),
(222,	'North South University',	NULL,	'01682198557',	NULL,	NULL,	'Bosundhara , Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:24:26',	'2026-04-19 16:24:26'),
(223,	'Novotheater',	NULL,	'01751929750',	NULL,	NULL,	'Rajshahi Zoo Rad, Rajshahi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:25:20',	'2026-04-19 16:25:20'),
(224,	'Ntier Space International',	NULL,	'01819198898',	NULL,	NULL,	'28/1/C ,Towenbe Circuler road ,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:25:57',	'2026-04-19 16:25:57'),
(225,	'Nuran Biznet Solution',	NULL,	'01777769554',	NULL,	NULL,	'4 no,Darus Salam road,Mirpur tower ,room# 09 mirpur-1',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:26:42',	'2026-04-19 16:26:42'),
(226,	'Ocean Sweat Ind(Pvt) Ltd',	NULL,	'01907100712',	NULL,	NULL,	'House 25,Road-12,Sector 04,Uttara,Dhaka-1230,Bangladesh.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:27:37',	'2026-04-19 16:27:37'),
(227,	'Ocean Sweater Ind (Pvt) ltd',	NULL,	'01716948707',	NULL,	NULL,	'Islampur, Joydevpur, Gazipur-1700',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:28:24',	'2026-04-19 16:28:24'),
(228,	'Officers Club',	NULL,	'01769047530',	NULL,	NULL,	'Dhaka Cantonment, Vashanteck',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:29:56',	'2026-04-19 16:29:56'),
(229,	'Onix Computers System IDB Bhaban',	NULL,	'01713452531',	NULL,	NULL,	'BCS Computer City, Shop-306 & 307,(3rd Floor) Ser-e- Bangla nagar, Agargaon, Dhaka-1207',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:31:21',	'2026-04-19 16:31:21'),
(230,	'Online Point',	NULL,	'01915460476',	NULL,	NULL,	'Amjhupi, Meherpur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:32:02',	'2026-04-19 16:32:02'),
(231,	'Onnorokom Group',	NULL,	'01708166005',	NULL,	NULL,	'Karwan Bazar, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:32:34',	'2026-04-19 16:32:34'),
(232,	'Orion Technology',	NULL,	'01990685520',	NULL,	NULL,	'Road-4, Bonosree A Block',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:33:11',	'2026-04-19 16:33:11'),
(233,	'Osman Interlinings Ltd Jahangir',	NULL,	'01819143962',	NULL,	NULL,	'Tower, (4th floor), 10 Kawran Bazar, Dhaka -1215',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:33:56',	'2026-04-19 16:33:56'),
(234,	'Oxford International School',	NULL,	'01926000711',	NULL,	NULL,	'Dhanmondi 27,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:34:41',	'2026-04-19 16:34:41'),
(235,	'Paramount School',	NULL,	'01303644986',	NULL,	NULL,	'Rajshahi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:35:31',	'2026-04-19 16:35:31'),
(236,	'Pathao Limited CWN (A)',	NULL,	'01904488397',	NULL,	NULL,	'3A Road 49, Gulshan Model Town, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:36:06',	'2026-04-19 16:36:06'),
(237,	'Photolab Trading',	NULL,	'01958455222',	NULL,	NULL,	'34, Purano Paltan(2nd floor)',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:36:42',	'2026-04-19 16:36:42'),
(238,	'Photoshop',	NULL,	'01674283664',	NULL,	NULL,	'Uttara',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:37:18',	'2026-04-19 16:37:18'),
(239,	'Power Line Computer Central Shopping Complex',	NULL,	'01819536363',	NULL,	NULL,	'(2nd Floor), 562, O.R. Nizam Road, Chittagong.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:38:05',	'2026-04-19 16:38:05'),
(240,	'Prime Point Solution',	NULL,	'01609640051',	NULL,	NULL,	'138, Arambagh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:38:37',	'2026-04-19 16:38:37'),
(241,	'Qadirabad Cantonment (Record Office)',	NULL,	'01922521509',	NULL,	NULL,	'Qadirabad cantonment, Natore',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:39:21',	'2026-04-19 16:39:21'),
(242,	'Qadirabad Cantonment A ( Station Headquter)',	NULL,	'01886804886',	NULL,	NULL,	'Dayrampur,Natore',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:39:55',	'2026-04-19 16:39:55'),
(243,	'Qflix Limited',	NULL,	'01715238312',	NULL,	NULL,	'Shewrapara',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:40:31',	'2026-04-19 16:40:31'),
(244,	'Qnix computer system',	NULL,	'01885938368',	NULL,	NULL,	'#4th floor,shop-306/307, Agargaon, IDB',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:41:07',	'2026-04-19 16:41:07'),
(245,	'Radisson Blu Water Garden Hotel',	NULL,	'01636503583',	NULL,	NULL,	'Airport Rd, Dhaka 1206',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:41:50',	'2026-04-19 16:41:50'),
(246,	'Radisson Digital Technologies Ltd',	NULL,	'01518749595',	NULL,	NULL,	'Shah Ali Tower(6th Floor), 33 Kawran Bazar, Dhaka-1215',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:42:41',	'2026-04-19 16:42:41'),
(247,	'Raisha Computer',	NULL,	'01309915639',	NULL,	NULL,	'Elephant Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:44:22',	'2026-04-19 16:44:22'),
(248,	'Rajshahi Online Ltd',	NULL,	'01837314802',	NULL,	NULL,	'Taltola,Agargaon',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:44:55',	'2026-04-19 16:44:55'),
(249,	'Rana,s Corporation',	NULL,	'01922588955',	NULL,	NULL,	'Shewrapara',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:45:34',	'2026-04-19 16:45:34'),
(250,	'Rangpur Cantonment Public School and College',	NULL,	'01746696653',	NULL,	NULL,	'Rangpur Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:46:13',	'2026-04-19 16:46:13'),
(251,	'Rangs motor',	NULL,	'01998708581',	NULL,	NULL,	'Gazipur ,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:46:47',	'2026-04-19 16:46:47'),
(252,	'Ratul Hassan',	NULL,	'01829795990',	NULL,	NULL,	'5/2 Lalmatia , Block E',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:58:05',	'2026-04-19 16:58:05'),
(253,	'Retail Technologies Limited',	NULL,	'01841600878',	NULL,	NULL,	'Navana Tower,Gulshan-1',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:58:56',	'2026-04-19 16:58:56'),
(254,	'RFS Technology',	NULL,	'01958105600',	NULL,	NULL,	'Shop-127,Multiplan, Elephant Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 16:59:40',	'2026-04-19 16:59:40'),
(255,	'Right Technology',	NULL,	'01919128489',	NULL,	NULL,	'Paltan',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:00:22',	'2026-04-19 17:00:22'),
(256,	'Riyad vai',	NULL,	'01710109805',	NULL,	NULL,	'Sylhet airport, sylhet',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:00:58',	'2026-04-19 17:00:58'),
(257,	'RM Technology',	NULL,	'01815333956',	NULL,	NULL,	'Laldighirpar, CoxsBazar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:01:33',	'2026-04-19 17:01:33'),
(258,	'Roktim Kurarghat Medical',	NULL,	'01684180545',	NULL,	NULL,	'Kamrangir Char,Dhaka- 1211',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:02:14',	'2026-04-19 17:02:14'),
(259,	'Ronghodhonu Computer',	NULL,	'01858344496',	NULL,	NULL,	'Andarkilla, Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:02:55',	'2026-04-19 17:02:55'),
(260,	'Ryans computer',	NULL,	'01313467590',	NULL,	NULL,	'IDB Branch, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:03:41',	'2026-04-19 17:03:41'),
(261,	'S M Sagor',	NULL,	'01711395684',	NULL,	NULL,	'Barisal , Barisal',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:04:41',	'2026-04-19 17:04:41'),
(262,	'Safco International',	NULL,	'01718041060',	NULL,	NULL,	'Paltan',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:05:05',	'2026-04-19 17:05:05'),
(263,	'Safeway Hospital',	NULL,	'01767677575',	NULL,	NULL,	'Mugda Biswa Road, Mugda',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:05:40',	'2026-04-19 17:05:40'),
(264,	'Saidpur Cantonment Public School and College',	NULL,	'01717527155',	NULL,	NULL,	'Saidpur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:06:20',	'2026-04-19 17:06:20'),
(265,	'Saiham Tower',	NULL,	'01928405061',	NULL,	NULL,	'unkwon',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:07:34',	'2026-04-19 17:07:34'),
(266,	'Samuda Chemical',	NULL,	'01799990804',	NULL,	NULL,	'TK Bhaban ,Kaoran Bazar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:08:15',	'2026-04-19 17:08:15'),
(267,	'Selise',	NULL,	'01715494703',	NULL,	NULL,	'Dhanmondi 27',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:08:32',	'2026-04-19 17:08:32'),
(268,	'Service One',	NULL,	'01675708791',	NULL,	NULL,	'25/3 Tarokalok Bhaban, Green Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:08:59',	'2026-04-19 17:08:59'),
(269,	'Shaheed Bir Uttam Lt Anower Girls College',	NULL,	'01715078334',	NULL,	NULL,	'Dhaka Cantonment',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:10:16',	'2026-04-19 17:10:16'),
(270,	'SHAHEED LIEUTENANT TANZIM CANTONMENT PUBLIC SCHOOL & COLLEGE',	NULL,	'01830561085',	NULL,	NULL,	'Alijahan,Cox’s Bazar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:12:09',	'2026-04-19 17:12:09'),
(271,	'Shaikh Zakaria Islamic Research center',	NULL,	'01623222241',	NULL,	NULL,	'Unk',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:12:42',	'2026-04-19 17:12:42'),
(272,	'Sheba IT Solution',	NULL,	'01626133222',	NULL,	NULL,	'Mugbazar Grand Plaza.Mugbazar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:13:13',	'2026-04-19 17:13:13'),
(273,	'Sheltech Holding limited',	NULL,	'01712163043',	NULL,	NULL,	'House# 52, Road# 11, Block- F, Banani, Dhaka- 1213',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:13:51',	'2026-04-19 17:13:51'),
(274,	'Shimul Memorial North South School and College',	NULL,	'01748117184',	NULL,	NULL,	'Rajshahi',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:14:16',	'2026-04-19 17:14:16'),
(275,	'Shornadip Foundation Hospital',	NULL,	'01745009877',	NULL,	NULL,	'Malek Munshir Bazar, Haramia, Sandwip, Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:14:58',	'2026-04-19 17:14:58'),
(276,	'Si-tech Computer',	NULL,	'01841734106',	NULL,	NULL,	'28/G/1, Toynbee circular Road, Shop no: 184,185,186,187, 2nd floor, Gause pak bhaban, Motijheel Dhaka-1000.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:15:37',	'2026-04-19 17:15:37'),
(277,	'Siam Enterprise',	NULL,	'01724027633',	NULL,	NULL,	'Tongi College Gate,Gazipur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:16:15',	'2026-04-19 17:16:15'),
(278,	'Sigma Card and Printers',	NULL,	'01735444406',	NULL,	NULL,	'Paltan',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:16:52',	'2026-04-19 17:16:52'),
(279,	'Six Seasons Hotel Six Seasons Hotel',	NULL,	'01987009827',	NULL,	NULL,	'House# 19, Road# 96 Gulshan-2, Dhaka-1212.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:17:45',	'2026-04-19 17:17:45'),
(280,	'SM computer',	NULL,	'01720478950',	NULL,	NULL,	'Uttara Azompur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:18:24',	'2026-04-19 17:18:24'),
(281,	'Sohag Enterprise',	NULL,	'01723793123',	NULL,	NULL,	'Nilkhet',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:19:01',	'2026-04-19 17:19:01'),
(282,	'Solutions one Nahar',	NULL,	'01318304905',	NULL,	NULL,	'Plaza,Hatirpool,Dhaka-100',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:19:39',	'2026-04-19 17:19:39'),
(283,	'Sotota Digital Printers',	NULL,	'01917354065',	NULL,	NULL,	'Muktagachha, Mymensingh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:20:03',	'2026-04-19 17:20:03'),
(284,	'Southeast Sweater Limited',	NULL,	'01717740898',	NULL,	NULL,	'Uttar Khan,Uttara',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:20:34',	'2026-04-19 17:20:34'),
(285,	'Southern General Hospital',	NULL,	'01919211560',	NULL,	NULL,	'143/2, Arambagh(1st Floor)',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:20:58',	'2026-04-19 17:20:58'),
(286,	'Special Branch of Police',	NULL,	'01921928099',	NULL,	NULL,	'SB office, Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:21:28',	'2026-04-19 17:21:28'),
(287,	'SR Automation',	NULL,	'01827805010',	NULL,	NULL,	'10/A High Villa Main Road, Mohammadpur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:21:52',	'2026-04-19 17:21:52'),
(288,	'Star Sign',	NULL,	'01612028405',	NULL,	NULL,	'Banani',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:22:14',	'2026-04-19 17:22:14'),
(289,	'Step Media Ltd',	NULL,	'01713366031',	NULL,	NULL,	'House 7, Road 23/B, Gulshan 1',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:22:40',	'2026-04-19 17:22:40'),
(290,	'Subrato Arambarai',	NULL,	'01707010640',	NULL,	NULL,	'bazar,ishurdi,Pabna',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:23:13',	'2026-04-19 17:23:13'),
(291,	'Sylhet Binary Logic',	NULL,	'01971044803',	NULL,	NULL,	'Sylhet Sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:23:47',	'2026-04-19 17:23:47'),
(292,	'Sylhet District CNG-Powered Auto Rickshaw Workers Union',	NULL,	'01893354064',	NULL,	NULL,	'Bharatkhola Jame Mosque, Dakshin Surma, Sylhet',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:24:19',	'2026-04-19 17:24:19'),
(293,	'Sylhet Womens Medical College Hospital',	NULL,	'01716748880',	NULL,	NULL,	'Mirboxtula, Sylhet',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:24:51',	'2026-04-19 17:24:51'),
(294,	'Tasfia Digital Sign',	NULL,	'01719656888',	NULL,	NULL,	'Bonpara,Natore',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-19 17:26:35',	'2026-04-19 17:26:35'),
(295,	'Tech Deal',	NULL,	'01844944094',	NULL,	NULL,	'28/C,Toyenbee Circular Road,Motijheel, Dhaka-1000',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:39:17',	'2026-04-20 09:39:17'),
(296,	'Tech Solution',	NULL,	'01740412542',	NULL,	NULL,	'Mogbazar , Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:39:46',	'2026-04-20 09:39:46'),
(297,	'Tech Vision Cyber Cafe',	NULL,	'01977240958',	NULL,	NULL,	'Konabari,Gazipur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:40:18',	'2026-04-20 09:40:18'),
(298,	'TEKJET',	NULL,	'01738566371',	NULL,	NULL,	'Paltan',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:41:10',	'2026-04-20 09:41:10'),
(299,	'The Millennium Stars School And College',	NULL,	'01904400205',	NULL,	NULL,	'Rangpur',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:42:20',	'2026-04-20 09:42:20'),
(300,	'The ordinance Center & School (OC&S) Bangladesh Army',	NULL,	'01796446052',	NULL,	NULL,	'Rajendrapur Cantonment Rajendropur, Gazipur.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:42:58',	'2026-04-20 09:42:58'),
(301,	'The White Clean Ltd Amaze Corporation',	NULL,	'01810001911',	NULL,	NULL,	'House#4(Lift#2) Road#23/A, Block#B,Banani (Near Banani Bidda Niketon School)',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:47:35',	'2026-04-20 09:47:35'),
(302,	'TK Group',	NULL,	'01612558944',	NULL,	NULL,	'Karwanbazar, Dhaka.',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:48:02',	'2026-04-20 09:48:02'),
(303,	'Torulota Enterprise',	NULL,	'01915412172',	NULL,	NULL,	'Tejgaon',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:48:27',	'2026-04-20 09:48:27'),
(304,	'Tripti Computer',	NULL,	'01912562279',	NULL,	NULL,	'Choumohoni, Noakhali',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:48:52',	'2026-04-20 09:48:52'),
(305,	'TS Computer',	NULL,	'01718881333',	NULL,	NULL,	'Mymensingh sadar',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:49:15',	'2026-04-20 09:49:15'),
(306,	'Umma Hatul Muminin Girls Madrasah',	NULL,	'01911324141',	NULL,	NULL,	'Gulshan, Bhatara ,Dhaka',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:49:42',	'2026-04-20 09:49:42'),
(307,	'Universal Computer Technology',	NULL,	'01714069083',	NULL,	NULL,	'141/48 Bitul Aman Tower, Ring Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:50:05',	'2026-04-20 09:50:05'),
(308,	'University of Chittagong',	NULL,	'01819852475',	NULL,	NULL,	'Chittagong',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:50:30',	'2026-04-20 09:50:30'),
(309,	'Vertex Computer Multiplan computer',	NULL,	'01914504403',	NULL,	NULL,	'city center, New Elephant Road Shop# 451, level# 4',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:51:11',	'2026-04-20 09:51:11'),
(310,	'Vesta BD & Company',	NULL,	'01741544451',	NULL,	NULL,	'Green Road Staff Quarter',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:53:06',	'2026-04-20 09:53:06'),
(311,	'XENUS Tech',	NULL,	'01785264124',	NULL,	NULL,	'F#C-6, H#55/1, North Pirerbag, 60 Feet Road, Mirpur, Dhaka-1216',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:53:29',	'2026-04-20 09:53:29'),
(312,	'Zaber and Zubair Fabrics Limited Adamjee',	NULL,	'01787668372',	NULL,	NULL,	'Court Annex-2 Building (09th Floor) 115-120,Motijheel C/A, Dhaka-100,Bangladesh',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:54:05',	'2026-04-20 09:54:05'),
(313,	'Zettabyte Gadgets',	NULL,	'01977784777',	NULL,	NULL,	'Shop: 434, Suvastu Arcade ICT Bhabon, Elephand Road',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:54:30',	'2026-04-20 09:54:30'),
(314,	'Zoha Enterprise',	NULL,	'01718263961',	NULL,	NULL,	'190/A, Fakirapool, Motijheel, Dhaka-1000, Dhaka, Bangladesh - 1000',	NULL,	NULL,	0,	NULL,	NULL,	'1',	NULL,	'2026-04-20 09:54:55',	'2026-04-20 09:54:55');

DROP TABLE IF EXISTS `daily_expenses`;
CREATE TABLE `daily_expenses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `employee_id` bigint unsigned NOT NULL,
  `date` date NOT NULL,
  `expense_category_id` bigint unsigned NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `spend_method` enum('cash','card','bank_transfer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `daily_expenses_user_id_foreign` (`user_id`),
  KEY `daily_expenses_employee_id_foreign` (`employee_id`),
  KEY `daily_expenses_expense_category_id_foreign` (`expense_category_id`),
  CONSTRAINT `daily_expenses_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  CONSTRAINT `daily_expenses_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `daily_expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `daily_expenses` (`id`, `user_id`, `employee_id`, `date`, `expense_category_id`, `amount`, `spend_method`, `remarks`, `created_at`, `updated_at`) VALUES
(2,	2,	5,	'2025-11-12',	2,	5000.00,	'cash',	'advance salary',	'2025-11-11 18:10:46',	'2025-11-13 00:59:25');

DROP TABLE IF EXISTS `daily_sales`;
CREATE TABLE `daily_sales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `card_amount` decimal(8,2) DEFAULT NULL,
  `cash_amount` decimal(8,2) DEFAULT NULL,
  `others_amount` decimal(8,2) DEFAULT NULL,
  `total_amount` decimal(8,2) DEFAULT NULL,
  `assigned_person_id` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `districts`;
CREATE TABLE `districts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `employee_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `salary` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employees_employee_id_unique` (`employee_id`),
  UNIQUE KEY `employees_email_unique` (`email`),
  KEY `employees_user_id_foreign` (`user_id`),
  CONSTRAINT `employees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `employees` (`id`, `user_id`, `employee_id`, `name`, `email`, `phone`, `image`, `designation`, `join_date`, `salary`, `status`, `created_at`, `updated_at`) VALUES
(4,	5,	'EMP0005',	'Md Hasan',	'test2@example.com',	'012398763542',	NULL,	'Jr. Employee',	'2025-11-05',	20000.00,	'active',	'2025-11-09 18:30:52',	'2025-11-09 19:45:21'),
(5,	6,	'EMP0006',	'Md Karim',	'karim@example.com',	'012306050408',	NULL,	'Sr. Employee',	NULL,	25000.00,	'active',	'2025-11-11 18:05:35',	'2025-11-11 18:08:24');

DROP TABLE IF EXISTS `expense_categories`;
CREATE TABLE `expense_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expense_categories_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `expense_categories` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1,	'Other',	1,	'2025-11-03 00:27:27',	'2025-11-03 00:27:27'),
(2,	'Advance Salary',	1,	'2025-11-09 19:01:53',	'2025-11-09 19:01:53');

DROP TABLE IF EXISTS `extras`;
CREATE TABLE `extras` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(8,2) DEFAULT NULL,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `inventories`;
CREATE TABLE `inventories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `opening_stock` int NOT NULL DEFAULT '0',
  `current_stock` int NOT NULL DEFAULT '0',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `inventories` (`id`, `product_id`, `opening_stock`, `current_stock`, `notes`, `created_at`, `updated_at`) VALUES
(1,	4,	10,	5,	'Opening stock entry',	'2025-11-02 19:31:35',	'2026-03-31 10:19:07'),
(3,	5,	20,	2,	'Opening stock entry',	'2025-11-03 02:05:12',	'2026-04-01 09:29:05'),
(4,	3,	12,	1,	'Opening stock entry',	'2025-11-03 02:11:45',	'2026-01-12 06:51:32'),
(5,	82,	635,	632,	'Opening stock entry',	'2026-04-20 14:51:03',	'2026-05-02 10:11:27'),
(6,	93,	17,	17,	'Opening stock entry',	'2026-04-20 15:40:21',	'2026-04-20 15:40:21'),
(7,	83,	340,	340,	'Opening stock entry',	'2026-04-20 15:41:27',	'2026-04-20 15:41:27');

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1,	'2014_10_12_000000_create_users_table',	1),
(2,	'2014_10_12_100000_create_password_reset_tokens_table',	1),
(3,	'2014_10_12_100000_create_password_resets_table',	1),
(4,	'2019_08_19_000000_create_failed_jobs_table',	1),
(5,	'2019_12_14_000001_create_personal_access_tokens_table',	1),
(6,	'2024_02_29_144312_addresses',	1),
(7,	'2024_03_13_022048_norifications',	1),
(8,	'2024_11_10_034909_ditsricts',	1),
(9,	'2024_11_10_034941_areas',	1),
(10,	'2024_11_25_144630_customers',	1),
(11,	'2024_11_25_164637_services',	1),
(12,	'2024_12_01_091025_create_bookings_table',	1),
(13,	'2024_12_02_015620_create_brands_table',	1),
(14,	'2024_12_03_143540_products',	1),
(15,	'2024_12_05_152050_sales',	1),
(16,	'2024_12_16_102327_payments',	1),
(17,	'2024_12_31_090914_daily_sales',	1),
(18,	'2025_02_16_091918_attendances',	1),
(19,	'2025_03_08_103257_salaries',	1),
(20,	'2025_03_26_120716_extras',	1),
(21,	'2025_04_14_015443_create_vendors_table',	1),
(22,	'2025_05_27_095543_create_purchases_table',	1),
(23,	'2025_05_29_103934_create_inventories_table',	1),
(24,	'2025_10_14_001916_create_expense_categories_table',	1),
(25,	'2025_10_14_002056_create_daily_expenses_table',	1),
(26,	'2025_10_14_015809_create_sale_items_table',	1),
(27,	'add_teams_fields',	1),
(28,	'create_permission_tables',	1),
(29,	'2025_11_03_045711_create_revenues_table',	2),
(30,	'2025_11_03_045713_create_revenues_table',	3),
(31,	'2025_11_05_004928_create_employees_table',	4),
(32,	'2025_11_05_051145_create_ta_das_table',	5),
(33,	'2025_11_06_063400_create_salaries_table',	6),
(34,	'2025_11_06_063401_create_salaries_table',	7),
(35,	'2025_11_06_063402_create_salaries_table',	8),
(36,	'2025_11_05_051146_create_ta_das_table',	9),
(37,	'2025_11_09_000043_create_salary_advances_table',	10),
(38,	'2025_11_09_065739_create_advance_salaries_table',	11),
(39,	'2025_11_09_074807_add_user_id_to_employees_table',	12),
(40,	'2025_11_09_074807_add_role_id_to_employees_table',	13),
(41,	'2025_11_09_066928_create_employees_table',	14),
(42,	'2025_11_10_051146_create_ta_das_table',	15),
(43,	'2025_11_10_051147_create_ta_das_table',	16),
(44,	'2025_11_10_052056_create_daily_expenses_table',	17),
(45,	'2025_11_10_052057_create_daily_expenses_table',	18),
(46,	'2025_11_10_052067_create_daily_expenses_table',	19),
(47,	'2025_11_11_051147_create_ta_das_table',	20),
(48,	'2025_11_11_051148_create_ta_das_table',	21),
(49,	'2025_11_11_051149_create_ta_das_table',	22),
(50,	'2025_11_12_010102_create_projects_table',	23),
(51,	'2025_11_12_010132_create_projects_table',	24),
(52,	'2025_11_11_051150_create_ta_das_table',	25),
(53,	'2025_11_11_051152_create_ta_das_table',	26),
(54,	'2025_11_12_010133_create_projects_table',	27),
(55,	'2025_11_12_010134_create_projects_table',	28),
(56,	'2025_11_15_013858_create_clients_table',	29),
(57,	'2025_11_12_010135_create_projects_table',	30),
(58,	'2025_11_18_014629_create_project_items_table',	31),
(59,	'2025_11_18_013135_create_projects_table',	32),
(60,	'2025_11_18_060953_create_cost_categories_table',	33),
(61,	'2025_11_18_065841_create_project_costs_table',	34),
(62,	'2025_11_18_065842_create_project_costs_table',	35),
(63,	'2025_11_20_143924_create_project_bills_table',	36),
(64,	'2025_11_20_144053_create_bill_items_table',	37),
(65,	'2025_11_20_143925_create_project_bills_table',	38),
(66,	'2025_11_20_144055_create_bill_items_table',	39),
(67,	'2025_11_20_175440_create_bills_table',	40),
(68,	'2025_11_20_175446_create_bills_table',	41),
(69,	'2025_11_20_175447_create_bills_table',	42),
(70,	'2025_11_21_144055_create_bill_items_table',	43),
(71,	'2025_11_21_144056_create_bill_items_table',	44),
(72,	'2025_11_23_183130_create_challans_table',	45),
(73,	'2025_11_23_183135_create_challans_table',	46),
(74,	'2025_11_24_110556_create_challan_items_table',	46),
(75,	'2025_11_24_125447_create_bills_table',	47),
(76,	'2025_11_24_144056_create_bill_items_table',	48),
(77,	'2025_11_24_125448_create_bills_table',	49),
(78,	'2025_11_24_144057_create_bill_items_table',	49),
(79,	'2025_11_24_152350_add_project_fields_to_sales_table',	50),
(80,	'2025_11_24_152355_add_project_fields_to_sales_table',	51),
(81,	'2025_11_24_163950_make_customer_id_nullable_in_sales_table',	52),
(82,	'2025_11_25_102923_add_photo_to_products_table',	53),
(83,	'2025_11_25_131014_create_quotations_table',	54),
(84,	'2025_11_25_135221_create_quotation_items_table',	54),
(85,	'2025_11_26_123944_add_project_id_to_payments_table',	55),
(86,	'2025_11_29_153131_create_bank_details_table',	56),
(87,	'2025_11_29_153146_create_company_details_table',	56),
(88,	'2025_11_29_153309_add_fields_to_bills_table',	56),
(89,	'2025_11_29_163131_create_bank_details_table',	57),
(90,	'2025_11_29_173929_add_fields_to_challans_table',	58),
(91,	'2025_11_30_113802_add_designation_to_bills_table',	59),
(92,	'2025_11_30_132753_add_designation_to_challans_table',	60),
(93,	'2026_01_12_121918_add_fields_to_sales_table',	61),
(94,	'2026_03_08_152251_create_categories_table',	62),
(95,	'2026_03_08_152751_add_category_id_to_products_table',	63),
(96,	'2026_03_08_153755_remove_parent_id_from_categories_table',	64),
(97,	'2026_03_08_160500_add_product_id_to_services_table',	65),
(98,	'2026_03_08_161500_add_paid_amount_to_services_table',	66),
(99,	'2026_03_08_162500_make_country_code_and_warranty_nullable_on_services_table',	67),
(100,	'2026_03_08_170000_sync_service_schema_updates',	68),
(101,	'2026_04_01_154652_add_recipient_and_company_fields_to_challans_table',	69),
(102,	'2026_04_01_155356_add_client_and_company_fields_to_quotations_table',	70),
(103,	'2026_05_02_123308_create_returns_table',	71),
(104,	'2026_05_02_123312_create_return_items_table',	72);

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1,	'App\\Models\\User',	1),
(1,	'App\\Models\\User',	2),
(2,	'App\\Models\\User',	5),
(2,	'App\\Models\\User',	6);

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL DEFAULT '1',
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `isSeen` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_for` int NOT NULL,
  `customer_id` bigint NOT NULL,
  `sale_id` bigint NOT NULL,
  `project_id` bigint unsigned DEFAULT NULL,
  `payment_method` enum('cash','card','bank_transfer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `amount` double NOT NULL,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `payments` (`id`, `payment_for`, `customer_id`, `sale_id`, `project_id`, `payment_method`, `amount`, `status`, `created_at`, `updated_at`) VALUES
(1,	2,	9,	9,	NULL,	'cash',	10000,	'1',	'2025-11-03 01:06:11',	'2025-11-03 01:06:11'),
(2,	2,	10,	10,	NULL,	'cash',	21500,	'1',	'2025-11-03 01:27:52',	'2025-11-03 01:27:52'),
(3,	2,	16,	26,	NULL,	'cash',	7500,	'1',	'2025-11-26 11:02:09',	'2025-11-26 11:02:09'),
(4,	1,	15,	1,	NULL,	'cash',	200,	'1',	'2026-04-01 07:08:00',	'2026-04-01 07:08:00'),
(5,	1,	15,	1,	NULL,	'cash',	200,	'1',	'2026-04-01 08:01:55',	'2026-04-01 08:01:55'),
(6,	1,	15,	1,	NULL,	'cash',	100,	'1',	'2026-04-01 08:10:18',	'2026-04-01 08:10:18'),
(7,	1,	15,	4,	NULL,	'cash',	300,	'1',	'2026-04-01 08:18:42',	'2026-04-01 08:18:42'),
(8,	1,	20,	5,	NULL,	'cash',	12,	'1',	'2026-04-01 10:30:52',	'2026-04-01 10:30:52'),
(9,	1,	21,	6,	NULL,	'card',	288,	'1',	'2026-04-01 10:34:35',	'2026-04-01 10:34:35'),
(10,	1,	21,	6,	NULL,	'cash',	199,	'1',	'2026-04-01 10:39:14',	'2026-04-01 10:39:14'),
(11,	1,	21,	6,	NULL,	'bank_transfer',	100,	'1',	'2026-04-01 10:39:30',	'2026-04-01 10:39:30'),
(12,	1,	22,	7,	NULL,	'cash',	200,	'1',	'2026-04-01 10:53:44',	'2026-04-01 10:53:44'),
(13,	1,	22,	8,	NULL,	'cash',	200,	'1',	'2026-04-01 10:57:29',	'2026-04-01 10:57:29'),
(14,	1,	16,	9,	NULL,	'cash',	500,	'1',	'2026-04-01 11:01:01',	'2026-04-01 11:01:01'),
(15,	1,	22,	10,	NULL,	'cash',	150,	'1',	'2026-04-01 18:32:35',	'2026-04-01 18:32:35');

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1,	'Administration',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(2,	'Booking',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(3,	'Service Management',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(4,	'Sales Management',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(5,	'Settings',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(6,	'Product Management',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(7,	'Customer Management',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(8,	'Vendor Management',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(9,	'Purchase Management',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(10,	'Inventory Management',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(11,	'Accounts Management',	'web',	'2025-10-14 23:04:22',	'2025-11-04 18:46:45'),
(12,	'Report Management',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(13,	'Payment Management',	'web',	'2025-11-03 00:47:54',	'2025-11-03 00:47:54'),
(16,	'Employee Management',	'web',	'2025-11-09 01:21:40',	'2025-11-09 01:21:40'),
(17,	'Project Management',	'web',	'2025-11-11 19:05:43',	'2025-11-11 19:05:43'),
(18,	'Client Management',	'web',	'2025-11-17 23:16:07',	'2025-11-17 23:16:07'),
(19,	'Cost Management',	'web',	'2025-11-18 00:22:52',	'2025-11-18 00:22:52'),
(20,	'Company Management',	'web',	'2025-11-29 09:49:27',	'2025-11-29 09:49:27'),
(21,	'Category Management',	'web',	'2026-03-08 09:30:25',	'2026-03-08 09:30:25');

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_id` bigint unsigned NOT NULL,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `warranty` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_brand_id_foreign` (`brand_id`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `products` (`id`, `category_id`, `name`, `brand_id`, `model`, `photos`, `status`, `warranty`, `created_at`, `updated_at`) VALUES
(11,	NULL,	'HP Smart Tank 670 Wi-Fi Duplexer All-in-One Color Printer',	2,	'Smart Tank 670',	'[\"products\\/VfLtkp76kbG5hgYlEYaLXeDO5GRFykxoFmcfe5gV.jpg\"]',	'1',	365,	'2025-11-30 04:54:46',	'2026-03-08 10:33:16'),
(12,	NULL,	'HiTi Colour Ribbon(YMCKO)',	8,	'CS200e',	'[\"products\\/Mck1r35Y9I2MbS9RTG5q6F8DZM9wI3lUimNG25LV.png\"]',	'1',	365,	'2026-03-14 04:55:50',	'2026-03-14 05:06:09'),
(13,	NULL,	'HiTi ID Card Printer',	8,	'CS200e',	'[\"products\\/lyy3onKh4BrerKYkbg0vu9ZcusbaCpBENzo4Yg3J.png\"]',	'1',	365,	'2026-03-14 05:32:36',	'2026-03-14 05:32:36'),
(14,	NULL,	'ZC300 Series Dual-Sided Card Printer',	9,	'ZC300',	'[\"products\\/dqDJN1b2rDhJ86enmNgZoyjTwwPbZKLXOSOSCOS3.png\"]',	'1',	365,	'2026-03-14 05:36:45',	'2026-03-14 05:36:45'),
(15,	NULL,	'Evolis ID card printer.',	10,	'Primacy 2',	'[\"products\\/8SWx2jtWYGd7a970ymnbQwILTfSWi2smcJ7emh8n.png\"]',	'1',	365,	'2026-03-14 05:41:20',	'2026-03-14 05:41:20'),
(16,	NULL,	'Evolis Colour Ribbon (YMCKO)',	10,	'Primacy 2',	'[\"products\\/tYGmMKoQJEEWWXYW3ntoWvUq3gqrzDbcShcUaNur.png\"]',	'1',	365,	'2026-03-14 05:47:14',	'2026-03-14 05:47:14'),
(17,	NULL,	'ZC300 Colour Ribbon (YMCKO) 300IMG',	9,	'ZC300',	'[\"products\\/rEeoo6nUjz6nlgpBMZ1FWhBgjx2Qpvg0XolCLYZr.png\"]',	'1',	365,	'2026-03-14 05:50:02',	'2026-03-14 05:50:02'),
(18,	NULL,	'Glass',	16,	'3D',	NULL,	'1',	365,	'2026-03-28 08:51:15',	'2026-03-28 08:51:15'),
(19,	NULL,	'AC Adapter',	8,	'(HiTi CS 200e)',	NULL,	'1',	365,	'2026-03-29 05:54:34',	'2026-03-29 05:54:34'),
(20,	NULL,	'AC Adapter',	9,	'( Zebra ZXP-3)',	NULL,	'1',	365,	'2026-03-29 05:56:08',	'2026-03-29 05:56:08'),
(21,	NULL,	'Barcode Label DT (50mm.38mm)',	17,	'(50mm.38mm)',	NULL,	'1',	365,	'2026-03-29 05:57:57',	'2026-03-29 05:57:57'),
(22,	NULL,	'Barcode label DT',	17,	'(100mm.57mm)',	NULL,	'1',	365,	'2026-03-29 05:58:21',	'2026-03-29 05:58:21'),
(23,	NULL,	'Barcode Label TT',	18,	'(38mm.25mm)',	NULL,	'1',	365,	'2026-03-29 05:59:17',	'2026-03-29 05:59:17'),
(24,	NULL,	'Barcode Label-DT',	17,	'(50mm.25mm)',	NULL,	'1',	365,	'2026-03-29 06:00:12',	'2026-03-29 06:00:12'),
(25,	NULL,	'Barcode Label',	17,	'(DT 38mm.25mm)',	NULL,	'1',	365,	'2026-03-29 06:00:35',	'2026-03-29 06:00:35'),
(26,	NULL,	'Barcode Printer',	4,	'(TSC TE244)',	NULL,	'1',	0,	'2026-04-04 09:53:04',	'2026-04-04 09:53:04'),
(27,	NULL,	'Barcode Printer',	9,	'(Zebra GT820)',	NULL,	'1',	0,	'2026-04-04 09:54:02',	'2026-04-04 09:54:02'),
(28,	NULL,	'Barcode Printer',	9,	'(Zebra ZD230 TA)',	NULL,	'1',	0,	'2026-04-04 09:54:23',	'2026-04-04 09:54:23'),
(29,	NULL,	'Barcode Ribbon',	17,	'(Premium Wax-55mm.300mm)',	NULL,	'1',	0,	'2026-04-04 09:55:21',	'2026-04-04 09:55:21'),
(30,	NULL,	'Barcode Ribbon',	17,	'(Premium Wax-85mm.300mm)',	NULL,	'1',	0,	'2026-04-04 09:55:41',	'2026-04-04 09:55:41'),
(31,	NULL,	'Barcode Scanner',	9,	'(Zebra DS2208)',	NULL,	'1',	0,	'2026-04-04 09:56:14',	'2026-04-04 09:56:14'),
(32,	NULL,	'Barcode Scanner',	9,	'(Zebra DS2278)',	NULL,	'1',	0,	'2026-04-04 09:56:36',	'2026-04-04 09:56:36'),
(33,	NULL,	'Barcode Scanner',	9,	'(Zebra DS9308)',	NULL,	'1',	0,	'2026-04-04 09:56:59',	'2026-04-04 09:56:59'),
(34,	NULL,	'Barcode Scanner',	9,	'(LS2208)',	NULL,	'1',	0,	'2026-04-04 09:57:28',	'2026-04-04 09:57:28'),
(35,	NULL,	'Bercode Black Ribbon',	17,	'Black Ribbon',	NULL,	'1',	0,	'2026-04-04 09:57:54',	'2026-04-04 09:57:54'),
(36,	NULL,	'Bercode Lebel',	17,	'(1.3)\"',	NULL,	'1',	0,	'2026-04-04 09:58:15',	'2026-04-04 09:58:15'),
(37,	NULL,	'Bercode Lebel',	17,	'\'\'(1.5.1.5)\"',	NULL,	'1',	0,	'2026-04-04 09:58:50',	'2026-04-04 09:58:50'),
(38,	NULL,	'Black',	20,	'Metal Cover',	NULL,	'1',	0,	'2026-04-04 10:01:59',	'2026-04-04 10:01:59'),
(39,	NULL,	'Blue Landscape',	20,	'Metal Cover',	NULL,	'1',	0,	'2026-04-04 10:02:34',	'2026-04-04 10:02:34'),
(40,	NULL,	'Blue',	20,	'Metal Cover',	NULL,	'1',	0,	'2026-04-04 10:03:02',	'2026-04-04 10:03:02'),
(41,	NULL,	'Bolt Lock',	21,	'Bolt type',	NULL,	'1',	0,	'2026-04-04 10:04:52',	'2026-04-04 10:04:52'),
(42,	NULL,	'Card Five Software, Made In USA.',	22,	'Version:6.3 Professional',	NULL,	'1',	0,	'2026-04-04 10:08:17',	'2026-04-04 10:08:17'),
(43,	NULL,	'Cat-6',	23,	'conductor material',	NULL,	'1',	0,	'2026-04-04 10:11:54',	'2026-04-04 10:11:54'),
(44,	NULL,	'Channel',	24,	'\'\'3*4\'\'- \'\'2*1\'\'',	NULL,	'1',	0,	'2026-04-04 10:14:50',	'2026-04-04 10:14:50'),
(45,	NULL,	'Cleaning Swab',	10,	'Evolish',	NULL,	'1',	0,	'2026-04-04 10:17:49',	'2026-04-04 10:17:49'),
(46,	NULL,	'RFID Card',	11,	'Compatible',	NULL,	'1',	0,	'2026-04-04 10:18:17',	'2026-04-04 10:18:17'),
(47,	NULL,	'Crystal',	25,	'Mifare Card',	NULL,	'1',	0,	'2026-04-04 10:29:48',	'2026-04-04 10:29:48'),
(48,	NULL,	'Crystal',	25,	'PVC White Card',	NULL,	'1',	0,	'2026-04-04 10:30:23',	'2026-04-04 10:30:23'),
(49,	NULL,	'Crystal RFID',	25,	'Premium Card',	NULL,	'1',	0,	'2026-04-04 10:30:56',	'2026-04-04 10:30:56'),
(50,	NULL,	'crystal RFID',	25,	'Regular Card',	NULL,	'1',	0,	'2026-04-04 10:31:23',	'2026-04-04 10:31:23'),
(51,	NULL,	'Data cable',	8,	'CS200E',	NULL,	'1',	0,	'2026-04-04 10:32:05',	'2026-04-04 10:32:05'),
(52,	NULL,	'Dog Hook',	26,	'Big size',	NULL,	'1',	0,	'2026-04-04 10:42:35',	'2026-04-04 10:42:35'),
(53,	NULL,	'Dog Hook',	26,	'Medium size',	NULL,	'1',	0,	'2026-04-04 10:42:56',	'2026-04-04 10:42:56'),
(54,	NULL,	'Evolis Cleaning Set',	10,	'Long & Short',	NULL,	'1',	0,	'2026-04-04 10:43:39',	'2026-04-04 10:43:39'),
(55,	NULL,	'Cleanning Pen',	10,	'ACL001',	NULL,	'1',	0,	'2026-04-04 10:45:01',	'2026-04-04 10:45:01'),
(56,	NULL,	'Evolis Hightrust',	10,	'PVC Card',	NULL,	'1',	0,	'2026-04-04 10:45:44',	'2026-04-04 10:45:44'),
(57,	NULL,	'Evolis pebble -4 monochrome black ribbon',	10,	'pebble -4',	NULL,	'1',	0,	'2026-04-04 10:46:16',	'2026-04-04 10:46:16'),
(58,	NULL,	'Evolis Primacy long Cleaning Card',	10,	'Long Size',	NULL,	'1',	0,	'2026-04-04 10:46:46',	'2026-04-04 10:46:46'),
(59,	NULL,	'Evolis Primacy Short Cleaning Card',	10,	'Short',	NULL,	'1',	0,	'2026-04-04 10:47:09',	'2026-04-04 10:47:09'),
(60,	NULL,	'Evolis  Black Ribbon Pack',	10,	'Primacy -1',	NULL,	'1',	0,	'2026-04-04 10:48:18',	'2026-04-04 10:48:18'),
(61,	NULL,	'Evolis Colour Ribbon Pack',	10,	'Primacy -1',	NULL,	'1',	0,	'2026-04-04 10:48:44',	'2026-04-04 10:48:44'),
(62,	NULL,	'Primacy -1 Printer',	10,	'Primacy -1',	NULL,	'1',	0,	'2026-04-04 10:54:14',	'2026-04-04 10:54:14'),
(63,	NULL,	'Evolis Primacy -2 Colour Ribbon Pack',	10,	'Primacy -2',	NULL,	'1',	0,	'2026-04-04 10:55:54',	'2026-04-04 10:55:54'),
(64,	NULL,	'Primacy-1 Long Compatible Cleaning Card',	10,	'Primacy-1',	NULL,	'1',	0,	'2026-04-20 11:35:32',	'2026-04-20 11:35:32'),
(65,	NULL,	'Primacy-1 Short Compatible Cleaning Card',	10,	'Primacy-1',	NULL,	'1',	0,	'2026-04-20 11:36:06',	'2026-04-20 11:36:06'),
(66,	NULL,	'Evolis Primacy-2 Black Ribbon',	10,	'Evolis Primacy-2',	NULL,	'1',	0,	'2026-04-20 11:36:29',	'2026-04-20 11:36:29'),
(67,	NULL,	'FingerTec :Face ID 4D',	27,	'Face ID 4D',	NULL,	'1',	0,	'2026-04-20 11:38:41',	'2026-04-20 11:38:41'),
(68,	NULL,	'FingerTec: Face ID 5',	27,	'Face ID 5',	NULL,	'1',	0,	'2026-04-20 11:39:42',	'2026-04-20 11:39:42'),
(69,	NULL,	'FingerTec: Kadex Plus',	27,	'Kadex Plus',	NULL,	'1',	0,	'2026-04-20 11:40:08',	'2026-04-20 11:40:08'),
(70,	NULL,	'FingerTec: R3',	27,	'R3',	NULL,	'1',	0,	'2026-04-20 11:59:24',	'2026-04-20 11:59:24'),
(71,	NULL,	'FingerTec: R3C',	27,	'R3C',	NULL,	'1',	0,	'2026-04-20 12:01:33',	'2026-04-20 12:01:33'),
(72,	NULL,	'FingerTec: TA100CR',	27,	'TA100CR',	NULL,	'1',	0,	'2026-04-20 12:01:56',	'2026-04-20 12:01:56'),
(73,	NULL,	'Genuine Secure Hologram Sticker',	28,	'Sticker',	NULL,	'1',	0,	'2026-04-20 12:03:41',	'2026-04-20 12:03:41'),
(74,	NULL,	'HIKVISION  DS-2CD2T43G2-4I  4 MP WDR Fixed Bullet Network Camera',	15,	'DS-2CD2T43G2-4I',	NULL,	'1',	0,	'2026-04-20 12:07:18',	'2026-04-20 12:07:18'),
(75,	NULL,	'HIKVISION DS-7716NXI-K4 16-ch 4 SATA AcuSense 4k NVR',	15,	'DS-7716NXI-K4 16-ch 4 SATA AcuSense',	NULL,	'1',	0,	'2026-04-20 12:07:42',	'2026-04-20 12:07:42'),
(76,	NULL,	'HIKVISION DS-K1T320EFWX-B2',	15,	'DS-K1T320',	NULL,	'1',	0,	'2026-04-20 12:08:06',	'2026-04-20 12:08:06'),
(77,	NULL,	'HIKVISION DS-N6U-ZCO(ORANGE)CAT6 305 Meter UTP Cable 99% Copper Cable',	15,	'-N6U-ZCO(ORANGE)CAT6',	NULL,	'1',	0,	'2026-04-20 12:08:31',	'2026-04-20 12:08:31'),
(78,	NULL,	'HiTi Black Chips',	8,	'Chips',	NULL,	'1',	0,	'2026-04-20 12:09:02',	'2026-04-20 12:09:02'),
(79,	NULL,	'Hiti Black Ribbon(1000 print)',	8,	'Hiti Cs200e',	NULL,	'1',	0,	'2026-04-20 12:09:51',	'2026-04-20 13:59:25'),
(80,	NULL,	'HiTi Cleaning Card',	8,	'Hiti Cs200e',	NULL,	'1',	0,	'2026-04-20 12:10:14',	'2026-04-20 12:10:14'),
(81,	NULL,	'HiTi Cleaning Roller',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:10:35',	'2026-04-20 12:10:35'),
(82,	NULL,	'HiTi Colour Ribbon Pack',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:10:52',	'2026-04-20 12:10:52'),
(83,	NULL,	'HiTi Compatible Black Ribbon Pack',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:11:11',	'2026-04-20 12:11:11'),
(84,	NULL,	'HiTi Compatible Colour Ribbon Pack',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:11:31',	'2026-04-20 12:11:31'),
(85,	NULL,	'HiTi Compatible Gold Ribbon Pack',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:11:49',	'2026-04-20 12:11:49'),
(86,	NULL,	'HiTi Compatible O-Ring Belt',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:12:23',	'2026-04-20 12:12:23'),
(87,	NULL,	'HiTi Compatible Silver Ribbon Pack',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:12:42',	'2026-04-20 12:12:42'),
(88,	NULL,	'HiTi Compatible UV Ribbon Pack',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:13:01',	'2026-04-20 12:13:01'),
(89,	NULL,	'Hiti Compatible White Ribbon',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:13:17',	'2026-04-20 12:13:17'),
(90,	NULL,	'HiTi Dual side Flipper Module',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:13:34',	'2026-04-20 12:13:34'),
(91,	NULL,	'HiTi ID Card Printer Dual Side Printer',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:13:53',	'2026-04-20 12:13:53'),
(92,	NULL,	'HiTi O-Ring Belt',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:14:12',	'2026-04-20 12:14:12'),
(93,	NULL,	'HiTi Plastic ID Card Printer',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:14:26',	'2026-04-20 12:14:26'),
(94,	NULL,	'HiTi Printer Head(Cs200e)',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:14:43',	'2026-04-20 12:14:43'),
(95,	NULL,	'Hiti Printer Motherboard',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:14:59',	'2026-04-20 12:14:59'),
(96,	NULL,	'HiTi YMCKO Chip',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:15:21',	'2026-04-20 12:15:21'),
(97,	NULL,	'Jewelry Tag(81mm.12mm)',	17,	'(81mm.12mm)',	NULL,	'1',	0,	'2026-04-20 12:17:32',	'2026-04-20 12:17:32'),
(98,	NULL,	'Kit O Ring Belt Primacy',	10,	'Primacy -1',	NULL,	'1',	0,	'2026-04-20 12:18:12',	'2026-04-20 12:18:12'),
(99,	NULL,	'Lanyard 1.5 Cm',	26,	'1.5 Cm',	NULL,	'1',	0,	'2026-04-20 12:18:35',	'2026-04-20 12:18:35'),
(100,	NULL,	'Luminus PVC Blank Card',	13,	'PVC White Card',	NULL,	'1',	0,	'2026-04-20 12:19:14',	'2026-04-20 12:19:14'),
(101,	NULL,	'Matador ID Card Holder',	20,	'Card Holder',	NULL,	'1',	0,	'2026-04-20 12:19:50',	'2026-04-20 12:19:50'),
(102,	NULL,	'Medium Mobile Hook',	26,	'Hook',	NULL,	'1',	0,	'2026-04-20 12:20:12',	'2026-04-20 12:20:12'),
(103,	NULL,	'Metal Cover (H)',	20,	'Cover',	NULL,	'1',	0,	'2026-04-20 12:22:37',	'2026-04-20 12:22:37'),
(104,	NULL,	'Metal Cover Golden V',	20,	'Golden V',	NULL,	'1',	0,	'2026-04-20 12:23:01',	'2026-04-20 12:23:01'),
(105,	NULL,	'Mifare Classic 1k NFC Card',	11,	'1k NFC Card',	NULL,	'1',	0,	'2026-04-20 12:28:17',	'2026-04-20 12:28:17'),
(106,	NULL,	'Plastic Cover T 994',	19,	'T 994',	NULL,	'1',	0,	'2026-04-20 12:28:44',	'2026-04-20 12:28:44'),
(107,	NULL,	'Poket Clip',	19,	'Clip',	NULL,	'1',	0,	'2026-04-20 12:29:06',	'2026-04-20 12:29:06'),
(108,	NULL,	'Poly Cover ( Landscape)',	20,	'( Landscape)',	NULL,	'1',	0,	'2026-04-20 12:29:31',	'2026-04-20 12:29:31'),
(109,	NULL,	'Power Cable',	24,	'Cable',	NULL,	'1',	0,	'2026-04-20 12:32:14',	'2026-04-20 12:32:14'),
(110,	NULL,	'Premium Crystal card',	25,	'Premium Card',	NULL,	'1',	0,	'2026-04-20 12:32:42',	'2026-04-20 12:32:42'),
(111,	NULL,	'Premium WAX Ribbon ( 110 x 300 M)',	17,	'( 110 x 300 M)',	NULL,	'1',	0,	'2026-04-20 12:33:05',	'2026-04-20 12:33:05'),
(112,	NULL,	'Premium Wax(110mm.300mm)',	17,	'(110mm.300mm)',	NULL,	'1',	0,	'2026-04-20 12:33:23',	'2026-04-20 12:33:23'),
(113,	NULL,	'Primacy Orginal Cleaning Card Set',	10,	'Cleaning Card Set',	NULL,	'1',	0,	'2026-04-20 12:34:38',	'2026-04-20 12:34:38'),
(114,	NULL,	'Primacy-1 Printer Head',	10,	'Primacy -1',	NULL,	'1',	0,	'2026-04-20 12:34:58',	'2026-04-20 12:34:58'),
(115,	NULL,	'Printed ID Card',	13,	'ID Card',	NULL,	'1',	0,	'2026-04-20 12:35:24',	'2026-04-20 12:35:24'),
(116,	NULL,	'Printed Lanyard(1.5 cm)',	26,	'(1.5 cm)',	NULL,	'1',	0,	'2026-04-20 12:35:47',	'2026-04-20 12:35:47'),
(117,	NULL,	'Printed Lanyard(2 .5 CM)',	26,	'(2 .5 CM)',	NULL,	'1',	0,	'2026-04-20 12:36:07',	'2026-04-20 12:36:07'),
(118,	NULL,	'Printed Lanyard(2 CM)',	26,	'(2 CM)',	NULL,	'1',	0,	'2026-04-20 12:36:26',	'2026-04-20 12:36:26'),
(119,	NULL,	'Printer Roller',	8,	'CS200e',	NULL,	'1',	0,	'2026-04-20 12:37:44',	'2026-04-20 12:37:44'),
(120,	NULL,	'PVC Golden Card',	30,	'Golden Card',	NULL,	'1',	0,	'2026-04-20 12:39:03',	'2026-04-20 12:39:03'),
(121,	NULL,	'PVC Silver Card',	30,	'Silver Card',	NULL,	'1',	0,	'2026-04-20 12:39:24',	'2026-04-20 12:39:24'),
(122,	NULL,	'PVC White Card Best Quality',	30,	'Card Best Quality',	NULL,	'1',	0,	'2026-04-20 12:39:58',	'2026-04-20 12:39:58'),
(123,	NULL,	'Resin Ribbon ( 55mm X 300M)',	20,	'( 55mm X 300M)',	NULL,	'1',	0,	'2026-04-20 13:23:05',	'2026-04-20 13:23:05'),
(124,	NULL,	'Resin Ribbon (110mm X 300M)',	20,	'(110mm X 300M)',	NULL,	'1',	0,	'2026-04-20 13:23:38',	'2026-04-20 13:23:38'),
(125,	NULL,	'RFID Card',	20,	'RFID',	NULL,	'1',	0,	'2026-04-20 13:24:16',	'2026-04-20 13:24:16'),
(126,	NULL,	'RFID China Card',	19,	'China Card',	NULL,	'1',	0,	'2026-04-20 13:24:43',	'2026-04-20 13:24:43'),
(127,	NULL,	'Sense Face 2A Biometric Device',	31,	'2A',	NULL,	'1',	0,	'2026-04-20 13:28:22',	'2026-04-20 13:28:22'),
(128,	NULL,	'Soft Cover T-014v Jing Tai',	20,	'014v',	NULL,	'1',	0,	'2026-04-20 13:31:15',	'2026-04-20 13:31:15'),
(130,	NULL,	'Soft Cover T-065V Kejea',	19,	'065V',	NULL,	'1',	0,	'2026-04-20 13:32:03',	'2026-04-20 13:32:03'),
(131,	NULL,	'T-738 Plastic Cover',	19,	'738',	NULL,	'1',	0,	'2026-04-20 13:32:34',	'2026-04-20 13:32:34'),
(132,	NULL,	'Thermal POS Paper Roll ( 78 x 51) mm',	32,	'( 78 x 51) mm',	NULL,	'1',	0,	'2026-04-20 13:33:47',	'2026-04-20 13:33:47'),
(133,	NULL,	'Thermal POS Paper Roll (56 x 38) mm',	32,	'(56 x 38) mm',	NULL,	'1',	0,	'2026-04-20 13:34:03',	'2026-04-20 13:34:03'),
(134,	NULL,	'Thermal POS Paper Roll (56 x 50) mm',	32,	'(56 x 50) mm',	NULL,	'1',	0,	'2026-04-20 13:34:20',	'2026-04-20 13:34:20'),
(135,	NULL,	'TSC 344 Barcode printer',	33,	'344',	NULL,	'1',	0,	'2026-04-20 13:35:28',	'2026-04-20 13:35:28'),
(136,	NULL,	'White Fita',	26,	'2cm and 1.5 cm',	NULL,	'1',	0,	'2026-04-20 13:36:03',	'2026-04-20 13:36:03'),
(137,	NULL,	'Yo yo Small Size',	34,	'Small Size',	NULL,	'1',	0,	'2026-04-20 13:38:05',	'2026-04-20 13:38:05'),
(138,	NULL,	'YowYow',	34,	'Big size',	NULL,	'1',	0,	'2026-04-20 13:38:25',	'2026-04-20 13:38:25'),
(139,	NULL,	'Yoyo printed',	34,	'printed',	NULL,	'1',	0,	'2026-04-20 13:38:56',	'2026-04-20 13:38:56'),
(140,	NULL,	'ZC-300 ID Card Printer',	9,	'ZC-300',	NULL,	'1',	0,	'2026-04-20 13:39:24',	'2026-04-20 13:39:24'),
(141,	NULL,	'ZC-300 Printer Head',	9,	'ZC300',	NULL,	'1',	0,	'2026-04-20 13:39:44',	'2026-04-20 13:39:44'),
(142,	NULL,	'Zebra O-Ring Belt(Green)',	9,	'O-Ring',	NULL,	'1',	0,	'2026-04-20 13:40:05',	'2026-04-20 13:40:05'),
(143,	NULL,	'Zebra P330i Long Cleaning Card',	9,	'P330i',	NULL,	'1',	0,	'2026-04-20 13:40:23',	'2026-04-20 13:40:23'),
(144,	NULL,	'Zebra P330in Compatible Black Ribbon Pack',	9,	'P330in',	NULL,	'1',	0,	'2026-04-20 13:40:42',	'2026-04-20 13:40:42'),
(145,	NULL,	'Zebra Premium PVC Card',	9,	'Premium PVC',	NULL,	'1',	0,	'2026-04-20 13:41:04',	'2026-04-20 13:41:04'),
(146,	NULL,	'Zebra ZC-300 Black Ribbon Pack',	9,	'ZC300',	NULL,	'1',	0,	'2026-04-20 13:41:29',	'2026-04-20 13:41:29'),
(147,	NULL,	'Zebra ZC-300 Cleaning Card',	9,	'ZC-300',	NULL,	'1',	0,	'2026-04-20 13:41:48',	'2026-04-20 13:41:48'),
(148,	NULL,	'Zebra ZC-300 Cleaning Compatible Card',	9,	'ZC300',	NULL,	'1',	0,	'2026-04-20 13:42:05',	'2026-04-20 13:42:05'),
(149,	NULL,	'Zebra ZC-300 Color Ribbon Pack',	9,	'ZC300',	NULL,	'1',	0,	'2026-04-20 13:42:24',	'2026-04-20 13:42:24'),
(150,	NULL,	'Zebra ZC-300 Color Ribbon(300 Image)',	9,	'ZC300',	NULL,	'1',	0,	'2026-04-20 13:43:08',	'2026-04-20 13:43:08'),
(151,	NULL,	'Zebra ZD 421 Barcode Printer',	9,	'ZD 421',	NULL,	'1',	0,	'2026-04-20 13:43:33',	'2026-04-20 13:43:33'),
(152,	NULL,	'Zebra ZXP-3 Black Ribbon Pack',	9,	'ZXP-3',	NULL,	'1',	0,	'2026-04-20 13:43:53',	'2026-04-20 13:43:53'),
(153,	NULL,	'Zebra ZXP-3 Color Ribbon Pack',	9,	'ZXP-3',	NULL,	'1',	0,	'2026-04-20 13:44:14',	'2026-04-20 13:44:14'),
(154,	NULL,	'Zebra ZXP-3 Compatible Cleaning Card Set',	9,	'ZXP-3',	NULL,	'1',	0,	'2026-04-20 13:44:33',	'2026-04-20 13:44:33'),
(155,	NULL,	'Zebra ZXP-3 Compatible Color Ribbon Pack',	9,	'ZXP-3',	NULL,	'1',	0,	'2026-04-20 13:44:51',	'2026-04-20 13:44:51'),
(156,	NULL,	'Zebra ZXP-3 O-Ring Belt(Black)',	9,	'ZXP-3',	NULL,	'1',	0,	'2026-04-20 13:45:14',	'2026-04-20 13:45:14'),
(157,	NULL,	'Zebra ZXP-3 Plastic ID Card Printer',	9,	'ZXP-3',	NULL,	'1',	0,	'2026-04-20 13:45:36',	'2026-04-20 13:45:36'),
(158,	NULL,	'Zebra Printer Head',	9,	'ZXP-3',	NULL,	'1',	0,	'2026-04-20 13:45:53',	'2026-04-20 13:59:54'),
(159,	NULL,	'Zipper ID Card Cover',	30,	'Zipper',	NULL,	'1',	0,	'2026-04-20 13:46:16',	'2026-04-20 13:46:16'),
(160,	NULL,	'ZKTECO SENSEFACE 3A',	21,	'3A',	NULL,	'1',	0,	'2026-04-20 13:46:43',	'2026-04-20 13:46:43'),
(161,	NULL,	'Zkteco Speed Face V5L',	21,	'V5L',	NULL,	'1',	0,	'2026-04-20 13:47:50',	'2026-04-20 13:47:50'),
(162,	NULL,	'Zkteco UZ bracket',	21,	'UZ',	NULL,	'1',	0,	'2026-04-20 13:48:14',	'2026-04-20 13:48:14'),
(163,	NULL,	'ZKTeco: F18 Time Attendance & Access Control',	21,	'F18',	NULL,	'1',	0,	'2026-04-20 13:48:34',	'2026-04-20 13:48:34'),
(164,	NULL,	'ZXP-3 Feeder Belt',	9,	'ZXP-3',	NULL,	'1',	0,	'2026-04-20 13:48:54',	'2026-04-20 13:49:41'),
(165,	NULL,	'Zxp3 Upper Cover',	9,	'ZXP-3',	NULL,	'1',	0,	'2026-04-20 13:49:18',	'2026-04-20 13:49:18');

DROP TABLE IF EXISTS `project_costs`;
CREATE TABLE `project_costs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint unsigned NOT NULL,
  `cost_category_id` bigint unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `amount` decimal(12,2) NOT NULL,
  `cost_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_costs_project_id_foreign` (`project_id`),
  KEY `project_costs_cost_category_id_foreign` (`cost_category_id`),
  CONSTRAINT `project_costs_cost_category_id_foreign` FOREIGN KEY (`cost_category_id`) REFERENCES `cost_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_costs_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `project_costs` (`id`, `project_id`, `cost_category_id`, `description`, `amount`, `cost_date`, `created_at`, `updated_at`) VALUES
(6,	10,	2,	NULL,	5000.00,	'2025-11-26',	'2025-11-26 06:06:09',	'2025-11-26 13:25:43');

DROP TABLE IF EXISTS `project_items`;
CREATE TABLE `project_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_items_project_id_foreign` (`project_id`),
  KEY `project_items_product_id_foreign` (`product_id`),
  CONSTRAINT `project_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_items_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `project_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` bigint unsigned NOT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  `sub_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `grand_total` decimal(12,2) NOT NULL,
  `advanced_payment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `due_payment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','in_progress','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_client_id_foreign` (`client_id`),
  CONSTRAINT `projects_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `projects` (`id`, `project_name`, `client_id`, `budget`, `sub_total`, `discount`, `grand_total`, `advanced_payment`, `due_payment`, `description`, `status`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(10,	'Project 1',	9,	250000.00,	116000.00,	0.00,	116000.00,	0.00,	116000.00,	NULL,	'pending',	NULL,	NULL,	'2025-11-26 05:52:50',	'2025-11-26 05:54:14');

DROP TABLE IF EXISTS `purchases`;
CREATE TABLE `purchases` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `vendor_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `sub_price` decimal(10,2) DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `payment` decimal(10,2) DEFAULT NULL,
  `due` decimal(10,2) DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchases_product_id_foreign` (`product_id`),
  KEY `purchases_vendor_id_foreign` (`vendor_id`),
  KEY `purchases_created_by_foreign` (`created_by`),
  KEY `purchases_updated_by_foreign` (`updated_by`),
  CONSTRAINT `purchases_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `purchases_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchases_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `purchases_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `purchases` (`id`, `product_id`, `vendor_id`, `quantity`, `unit_price`, `sub_price`, `total_price`, `payment`, `due`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(6,	82,	35,	635,	3600.00,	2286000.00,	2286000.00,	2286000.00,	0.00,	2,	NULL,	'2026-04-20 14:51:03',	'2026-04-20 14:51:03'),
(7,	93,	35,	17,	63000.00,	1071000.00,	1071000.00,	1071000.00,	0.00,	2,	NULL,	'2026-04-20 15:40:21',	'2026-04-20 15:40:21'),
(8,	83,	35,	340,	1200.00,	408000.00,	408000.00,	408000.00,	0.00,	2,	NULL,	'2026-04-20 15:41:27',	'2026-04-20 15:41:27');

DROP TABLE IF EXISTS `quotation_items`;
CREATE TABLE `quotation_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quotation_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quotation_items_quotation_id_foreign` (`quotation_id`),
  KEY `quotation_items_product_id_foreign` (`product_id`),
  CONSTRAINT `quotation_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quotation_items_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `quotations`;
CREATE TABLE `quotations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `quotation_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `client_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_address` text COLLATE utf8mb4_unicode_ci,
  `client_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attention_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body_content` text COLLATE utf8mb4_unicode_ci,
  `terms_conditions` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signatory_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signatory_designation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `additional_enclosed` text COLLATE utf8mb4_unicode_ci,
  `quotation_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `sub_total` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('draft','sent','accepted','rejected','expired') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quotations_quotation_number_unique` (`quotation_number`),
  KEY `quotations_customer_id_foreign` (`customer_id`),
  KEY `quotations_client_id_foreign` (`client_id`),
  CONSTRAINT `quotations_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quotations_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `quotations` (`id`, `quotation_number`, `customer_id`, `client_id`, `client_name`, `client_designation`, `client_address`, `client_phone`, `client_email`, `attention_to`, `body_content`, `terms_conditions`, `subject`, `company_name`, `signatory_name`, `signatory_designation`, `company_phone`, `company_email`, `company_website`, `additional_enclosed`, `quotation_date`, `expiry_date`, `notes`, `sub_total`, `discount_amount`, `total_amount`, `status`, `created_at`, `updated_at`) VALUES
(23,	'QT-20260401-0001',	NULL,	9,	'Mr Rahim',	'Manager',	'Mirpur',	NULL,	NULL,	'Mr. Kamal',	'Dear Sir,\r\n\r\nConcerning the above-mentioned subject, we are pleased to propose a technical solution and financial appraisal for the supply & installation of the ID Card Printing System for your organization.\r\n\r\nWe appreciate your interest in Cost-saving & new state-of-the-art technology ID Card Printers. We guarantee customer satisfaction by providing both excellent services and products of the highest quality. We maintain spares as recommended by our principal. \r\n\r\nIntelligent Technology is a leading card printer, office automation, and security solution provider. The company has an expert team of technical persons consisting of graduates and diploma engineers. For our valued customers we have a service desk available on an 8 / 6 basis which ensures instant support. Please note that Intelligent Technology is the original Distributor of all kinds of the best products, ensuring quality products with quality services. Especially authorized distributor for HiTi Digital Inc, Taiwan, and reseller for Zebra Technologies, USA & Evolis Card Printer, France in Bangladesh. Also Provide a Biometric Attendance and Access Control System, CCTV Surveillance System, Fire Safety & Security Solutions and Interactive Whiteboard System for the Classroom.\r\n\r\nPlease do not hesitate to contact me for further inquiries. We will be happy to provide our best to you all the time. We are ready to conduct the demonstration at any time as per your kind schedule. A detail of the offer is enclosed herewith. If you have any further assistance, please do not hesitate to contact us. We assure you of our best co-operation.\r\n\r\nThanks, with assuring you our best services.\r\nYours Sincerely,',	'1. Intelligent Technology will promptly deliver the product from available stock or within 7 to 15 days upon order placement.\r\n2. Intelligent Technology will provide (01) one-year service warranty for printer; however, no warranty is provided for printer heads & any others spare parts. \r\n    • Warranty doesn\'t acceptable against natural disaster, burn case for AC INPUT power fluctuation or any mechanical/Physical damage.\r\n    • Warranty doesn\'t acceptable of the product if \"warranty void seal\" removed or tempered.\r\n3. Accessories are not covered by any warranty.\r\n4. The printer and its accessories cannot be exchanged or replaced once used.\r\n5. The design of the card and lanyard must design must be approved by the relevant authority. Once printed, no modifications to the design will be allowed. \r\n6. The payment for the services will be made through an account payee cheque/DD/pay order, payable to Intelligent Technology, along with a corresponding work order.\r\n7. This offer is made in Bangladesh Taka Only.\r\n8. Government VAT and TAX are not included in the prices. If necessary, please incorporate the applicable amount of TAX and VAT in accordance with government or organizational regulations.\r\n9. As you are experiencing, the cost of inconsistence supplies and raw materials is highly fluctuating and reflecting an increasing cost trend all along the supply chain. Price is increasing both freight and US$ to Taka conversion rate too. Validity of all quotation will be 15 days only.',	'Test',	'Intelligent Technology',	'Engr. Shamsul Alam',	'Director (Technical)',	'+880 1904400202',	'info@intelligenttech.com',	'www.intelligenttech.com',	'Enclosed:\r\n                                                1)	Price Quotation.\r\n                                                2)	Summary.\r\n                                                3)	Terms & Conditions.',	'2026-04-01',	'2026-04-16',	'Test',	3000.00,	200.00,	2800.00,	'draft',	'2026-04-01 09:59:37',	'2026-04-01 09:59:37');

DROP TABLE IF EXISTS `return_items`;
CREATE TABLE `return_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `return_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `sales_item_id` bigint unsigned DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(12,2) NOT NULL,
  `return_reason` enum('damaged','wrong_item','customer_changed_mind','defective','expired','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  `condition` enum('good','damaged','defective') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'good',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `return_items_return_id_foreign` (`return_id`),
  KEY `return_items_product_id_foreign` (`product_id`),
  KEY `return_items_sales_item_id_foreign` (`sales_item_id`),
  CONSTRAINT `return_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `return_items_return_id_foreign` FOREIGN KEY (`return_id`) REFERENCES `returns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `return_items_sales_item_id_foreign` FOREIGN KEY (`sales_item_id`) REFERENCES `sales_items` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `return_items` (`id`, `return_id`, `product_id`, `sales_item_id`, `quantity`, `unit_price`, `total_price`, `return_reason`, `condition`, `notes`, `created_at`, `updated_at`) VALUES
(1,	1,	82,	25,	2,	3600.00,	7200.00,	'customer_changed_mind',	'good',	'product is ok',	'2026-05-02 10:00:55',	'2026-05-02 10:00:55');

DROP TABLE IF EXISTS `returns`;
CREATE TABLE `returns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sale_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `return_date` date NOT NULL,
  `total_refund_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status` enum('pending','approved','completed','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `reason` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `processed_by` bigint unsigned DEFAULT NULL,
  `processed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `returns_sale_id_foreign` (`sale_id`),
  KEY `returns_customer_id_foreign` (`customer_id`),
  CONSTRAINT `returns_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `returns_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `returns` (`id`, `sale_id`, `customer_id`, `return_date`, `total_refund_amount`, `status`, `reason`, `notes`, `processed_by`, `processed_at`, `created_at`, `updated_at`) VALUES
(1,	43,	31,	'2026-05-02',	7200.00,	'completed',	'test',	NULL,	2,	'2026-05-02 10:11:27',	'2026-05-02 10:00:55',	'2026-05-02 10:11:27');

DROP TABLE IF EXISTS `revenues`;
CREATE TABLE `revenues` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `total_sales` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_purchases` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_expenses` decimal(15,2) NOT NULL DEFAULT '0.00',
  `net_profit` decimal(15,2) GENERATED ALWAYS AS (((`total_sales` - `total_purchases`) - `total_expenses`)) VIRTUAL,
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revenues_year_month_unique` (`year`,`month`),
  KEY `revenues_year_index` (`year`),
  KEY `revenues_month_index` (`month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `revenues` (`id`, `year`, `month`, `total_sales`, `total_purchases`, `total_expenses`, `remarks`, `created_at`, `updated_at`) VALUES
(1,	2025,	11,	149000.00,	884000.00,	5000.00,	NULL,	'2025-11-03 00:06:23',	'2025-11-26 12:10:01');

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1,	1),
(2,	1),
(3,	1),
(4,	1),
(5,	1),
(6,	1),
(7,	1),
(8,	1),
(9,	1),
(10,	1),
(11,	1),
(12,	1),
(13,	1),
(17,	1),
(18,	1),
(19,	1),
(20,	1),
(21,	1),
(16,	2);

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1,	'Super Admin',	'web',	'2025-10-14 23:04:22',	'2025-10-14 23:04:22'),
(2,	'Employee',	'web',	'2025-11-05 19:06:09',	'2025-11-09 01:20:37');

DROP TABLE IF EXISTS `salaries`;
CREATE TABLE `salaries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` bigint unsigned NOT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `basic_salary` decimal(10,2) NOT NULL,
  `advance` decimal(10,2) DEFAULT NULL,
  `allowance` decimal(10,2) DEFAULT NULL,
  `deduction` decimal(10,2) DEFAULT NULL,
  `net_salary` decimal(10,2) NOT NULL,
  `payment_status` enum('paid','unpaid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `payment_date` date DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `salaries_employee_id_foreign` (`employee_id`),
  CONSTRAINT `salaries_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `salaries` (`id`, `employee_id`, `month`, `basic_salary`, `advance`, `allowance`, `deduction`, `net_salary`, `payment_status`, `payment_date`, `note`, `created_at`, `updated_at`) VALUES
(6,	5,	'2025-11',	25000.00,	5000.00,	700.00,	0.00,	20700.00,	'paid',	'2025-11-26',	NULL,	'2025-11-26 07:11:58',	'2025-11-26 07:11:58');

DROP TABLE IF EXISTS `salary_advances`;
CREATE TABLE `salary_advances` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` bigint unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `request_date` date NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `salary_advances_employee_id_foreign` (`employee_id`),
  CONSTRAINT `salary_advances_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned DEFAULT NULL,
  `product_id` bigint unsigned NOT NULL,
  `sale_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'retail',
  `project_id` bigint unsigned DEFAULT NULL,
  `qty` double NOT NULL,
  `total` double NOT NULL,
  `vat` decimal(10,2) NOT NULL DEFAULT '0.00',
  `tax` decimal(10,2) NOT NULL DEFAULT '0.00',
  `delivery_charge` decimal(10,2) NOT NULL DEFAULT '0.00',
  `payble` double NOT NULL,
  `bill` double NOT NULL,
  `advanced_payment` decimal(15,2) DEFAULT NULL,
  `due_payment` decimal(15,2) DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `sales_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('paid','partial','credit') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'credit',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sales_order_no_unique` (`order_no`),
  KEY `sales_customer_id_foreign` (`customer_id`),
  KEY `sales_product_id_foreign` (`product_id`),
  KEY `sales_project_id_foreign` (`project_id`),
  KEY `sales_client_id_foreign` (`client_id`),
  CONSTRAINT `sales_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL,
  CONSTRAINT `sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sales_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sales_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sales` (`id`, `order_no`, `customer_id`, `client_id`, `product_id`, `sale_type`, `project_id`, `qty`, `total`, `vat`, `tax`, `delivery_charge`, `payble`, `bill`, `advanced_payment`, `due_payment`, `discount`, `sales_by`, `status`, `created_at`, `updated_at`) VALUES
(43,	'INV-69F5C5E2E6284',	31,	NULL,	82,	'retail',	NULL,	4,	14400,	0.00,	0.00,	0.00,	14400,	14400,	5000.00,	9400.00,	0,	'2',	'partial',	'2026-05-02 09:37:38',	'2026-05-02 09:37:38');

DROP TABLE IF EXISTS `sales_items`;
CREATE TABLE `sales_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `unit_price` double NOT NULL,
  `warranty` int NOT NULL DEFAULT '0' COMMENT 'in days',
  `qty` int NOT NULL,
  `total_price` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sales_items` (`id`, `order_id`, `product_id`, `unit_price`, `warranty`, `qty`, `total_price`, `created_at`, `updated_at`) VALUES
(1,	1,	1,	2500,	365,	2,	5000,	'2025-10-14 23:06:04',	'2025-10-14 23:06:04'),
(2,	2,	2,	1200,	365,	5,	6000,	'2025-11-02 19:18:55',	'2025-11-02 19:18:55'),
(3,	3,	2,	10000,	365,	12,	120000,	'2025-11-02 20:01:39',	'2025-11-02 20:01:39'),
(4,	4,	3,	100,	365,	10,	1000,	'2025-11-02 20:03:14',	'2025-11-02 20:03:14'),
(5,	5,	2,	100,	365,	10,	1000,	'2025-11-02 20:13:01',	'2025-11-02 20:13:01'),
(6,	6,	2,	1000,	365,	5,	5000,	'2025-11-02 20:57:52',	'2025-11-02 20:57:52'),
(7,	6,	3,	1500,	365,	3,	4500,	'2025-11-02 20:57:52',	'2025-11-02 20:57:52'),
(8,	7,	2,	100,	365,	5,	500,	'2025-11-02 21:22:29',	'2025-11-02 21:22:29'),
(9,	7,	4,	16000,	365,	2,	32000,	'2025-11-02 21:22:29',	'2025-11-02 21:22:29'),
(10,	8,	4,	16000,	365,	5,	80000,	'2025-11-02 22:12:36',	'2025-11-02 22:12:36'),
(11,	9,	4,	18000,	365,	2,	36000,	'2025-11-03 00:22:32',	'2025-11-03 00:22:32'),
(12,	10,	2,	16000,	365,	3,	48000,	'2025-11-03 01:26:05',	'2025-11-03 01:26:05'),
(13,	11,	5,	28000,	365,	8,	224000,	'2025-11-03 02:06:48',	'2025-11-03 02:06:48'),
(14,	11,	2,	16000,	365,	2,	32000,	'2025-11-03 02:06:48',	'2025-11-03 02:06:48'),
(15,	12,	3,	14500,	365,	2,	29000,	'2025-11-23 06:05:15',	'2025-11-23 06:05:15'),
(17,	26,	4,	16500,	365,	2,	33000,	'2025-11-26 05:29:49',	'2025-11-26 05:29:49'),
(18,	37,	3,	100,	365,	2,	200,	'2026-01-12 06:51:32',	'2026-01-12 06:51:32'),
(19,	37,	5,	100,	365,	3,	300,	'2026-01-12 06:51:32',	'2026-01-12 06:51:32'),
(20,	38,	5,	100,	365,	1,	100,	'2026-01-12 06:54:44',	'2026-01-12 06:54:44'),
(21,	39,	4,	16000,	365,	2,	32000,	'2026-03-31 07:56:51',	'2026-03-31 07:56:51'),
(22,	40,	4,	15000,	365,	2,	30000,	'2026-03-31 10:19:07',	'2026-03-31 10:19:07'),
(23,	41,	5,	1500,	365,	1,	1500,	'2026-04-01 09:29:05',	'2026-04-01 09:29:05'),
(24,	42,	82,	4200,	0,	1,	4200,	'2026-04-21 10:23:10',	'2026-04-21 10:23:10'),
(25,	43,	82,	3600,	0,	4,	14400,	'2026-05-02 09:37:38',	'2026-05-02 09:37:38');

DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `product_id` bigint unsigned DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `total` double NOT NULL,
  `bill` double NOT NULL,
  `paid_amount` double NOT NULL DEFAULT '0',
  `discount` double DEFAULT NULL,
  `due_amount` double NOT NULL,
  `warranty_duration` int DEFAULT NULL,
  `repaired_by` bigint DEFAULT NULL,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `complated_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `services_product_id_foreign` (`product_id`),
  CONSTRAINT `services_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `services` (`id`, `customer_id`, `name`, `country_code`, `phone`, `email`, `address`, `product_id`, `product_name`, `product_number`, `details`, `total`, `bill`, `paid_amount`, `discount`, `due_amount`, `warranty_duration`, `repaired_by`, `status`, `complated_date`, `created_at`, `updated_at`) VALUES
(4,	15,	'Md Rahim',	NULL,	'01195674368',	'rahim@example.com',	'Dhaka',	NULL,	'Canon Pixma G3010 Refillable Ink Tank Wireless All-In-One Printer',	'12345',	'test',	800,	750,	300,	50,	450,	NULL,	NULL,	'0',	NULL,	'2026-04-01 08:18:42',	'2026-04-01 08:18:42'),
(9,	16,	'Md Hasan',	NULL,	'01200000000',	'hasan@example.com',	'Dhaka',	NULL,	'Epson EcoTank L3250 A4 Wi-Fi Multifunction InkTank Printer (Official)',	'123456',	'Test',	800,	750,	500,	50,	250,	NULL,	NULL,	'0',	NULL,	'2026-04-01 11:01:01',	'2026-04-01 11:01:01');

DROP TABLE IF EXISTS `ta_das`;
CREATE TABLE `ta_das` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `employee_id` bigint unsigned NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `used_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `remaining_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `purpose` text COLLATE utf8mb4_unicode_ci,
  `type` enum('TA','DA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'TA',
  `payment_type` enum('Advance','Claim') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Advance',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ta_das_employee_id_foreign` (`employee_id`),
  KEY `ta_das_user_id_foreign` (`user_id`),
  CONSTRAINT `ta_das_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ta_das_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ta_das` (`id`, `user_id`, `employee_id`, `date`, `amount`, `used_amount`, `remaining_amount`, `purpose`, `type`, `payment_type`, `created_at`, `updated_at`) VALUES
(1,	NULL,	5,	'2025-11-12',	200.00,	150.00,	50.00,	NULL,	'TA',	'Advance',	'2025-11-12 00:04:30',	'2025-11-13 00:18:33'),
(2,	6,	5,	'2025-11-12',	150.00,	0.00,	0.00,	NULL,	'TA',	'Claim',	'2025-11-12 00:10:08',	'2025-11-12 00:10:08'),
(3,	6,	5,	'2025-11-13',	100.00,	0.00,	0.00,	NULL,	'DA',	'Claim',	'2025-11-13 00:18:56',	'2025-11-13 00:18:56'),
(4,	6,	5,	'2025-11-26',	500.00,	0.00,	0.00,	'lunch',	'DA',	'Claim',	'2025-11-26 07:11:04',	'2025-11-26 07:11:04');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` int NOT NULL DEFAULT '1',
  `images` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification_code` int DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `billing_address` bigint DEFAULT NULL,
  `shipping_address` bigint DEFAULT NULL,
  `is_guest` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `type` enum('1','2','3','4') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `email_verified_at`, `password`, `role_id`, `images`, `verification_code`, `is_verified`, `billing_address`, `shipping_address`, `is_guest`, `status`, `type`, `remember_token`, `created_at`, `updated_at`) VALUES
(1,	'Super Admin',	'info@quickphonefixandmore.com',	'01000000000',	NULL,	'$2y$12$KWIVx/4asS.TLUkXRveAwu6BmURg1M4CtaaPhCtvRQvLmJEgxM1EW',	1,	NULL,	NULL,	0,	NULL,	NULL,	'0',	'0',	'1',	NULL,	NULL,	'2025-11-09 01:26:04'),
(2,	'Inoodex',	'hello@inoodex.com',	'013268546970',	NULL,	'$2y$12$XX/aD1Jy7JoYjb64CfBEuOBTTyCk.X60uazJ/mjue4zvbrFbYHBau',	1,	'',	NULL,	0,	NULL,	NULL,	'0',	'1',	'1',	NULL,	'2025-11-04 18:43:21',	'2025-11-04 18:43:21'),
(5,	'Md Hasan',	'test2@example.com',	'012398763542',	NULL,	'$2y$12$L6PfuXrm52J5sLsRKMBtv.ZmBX07JumeLi.TanaM3yBLR4U.u5rhq',	2,	'',	NULL,	0,	NULL,	NULL,	'0',	'1',	'1',	NULL,	'2025-11-09 18:30:52',	'2025-11-09 18:35:52'),
(6,	'Md Karim',	'karim@example.com',	'012306050408',	NULL,	'$2y$12$dcIPKb6RYCzeQbH6.k.QKOiEvS4bR6LVBM8evcnSOtN7F1C6x68h.',	2,	'',	NULL,	0,	NULL,	NULL,	'0',	'1',	'1',	NULL,	'2025-11-11 18:05:35',	'2025-11-11 18:05:35');

DROP TABLE IF EXISTS `vendors`;
CREATE TABLE `vendors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `vendors` (`id`, `name`, `phone`, `email`, `address`, `status`, `created_at`, `updated_at`) VALUES
(1,	'Tech Land',	'01364829570',	'techland@example.com',	'Banani',	'1',	'2025-11-02 18:44:31',	'2025-11-09 18:52:33'),
(2,	'Ryans',	'01195674368',	'ryans@example.com',	'Gulshan',	'1',	'2025-11-02 18:45:07',	'2025-11-09 18:48:08'),
(3,	'Star Tech',	'01295876340',	'startech@example.com',	'Multiplan',	'1',	'2025-11-03 02:11:13',	'2025-11-09 18:52:45'),
(4,	'Global Brand',	'01129367145',	'globalbrand@example.com',	'Uttara',	'1',	'2025-11-09 18:51:46',	'2025-11-09 18:52:18'),
(5,	'Yasin Enterprise',	'01829392026',	NULL,	'Bakusha market,Neelkhet',	'1',	'2026-04-04 11:01:23',	'2026-04-04 11:01:23'),
(6,	'Alif Digital',	'01900410582',	NULL,	'Dhaka',	'1',	'2026-04-20 10:01:29',	'2026-04-20 10:01:29'),
(7,	'Almas Electric',	'01727711000',	NULL,	'Green Road',	'1',	'2026-04-20 10:02:19',	'2026-04-20 10:02:19'),
(8,	'Anik Enterprise',	'01888888858',	NULL,	'Dhaka',	'1',	'2026-04-20 10:03:21',	'2026-04-20 10:03:21'),
(9,	'Aun Nafi Stationery',	'01914872788',	NULL,	'Aligarh House,Shop-11(GF)',	'1',	'2026-04-20 10:06:06',	'2026-04-20 10:06:06'),
(10,	'BD Technology',	'01714340790',	NULL,	'Nilkhet',	'1',	'2026-04-20 10:06:40',	'2026-04-20 10:06:40'),
(11,	'Bismillah Traders',	'01602291781',	NULL,	'Panthapath',	'1',	'2026-04-20 10:07:32',	'2026-04-20 10:07:32'),
(12,	'Bismillah Trades',	'01739032938',	NULL,	'Nilkhet',	'1',	'2026-04-20 10:08:07',	'2026-04-20 10:08:07'),
(13,	'Computer City Technology Ltd',	'01938858817',	NULL,	'B.S Bhaban (3rd Floor)75-76 Laboratory Road',	'1',	'2026-04-20 10:08:49',	'2026-04-20 10:08:49'),
(14,	'Digi Mark Solution',	'01819234343',	NULL,	'Fakirapool',	'1',	'2026-04-20 10:09:23',	'2026-04-20 10:09:23'),
(15,	'Digitech Solution Limited',	'01725897654',	NULL,	'Mirpur-1',	'1',	'2026-04-20 10:09:52',	'2026-04-20 10:09:52'),
(16,	'Dipok Studio',	'01937269545',	NULL,	'Paltan',	'1',	'2026-04-20 10:10:24',	'2026-04-20 10:10:24'),
(17,	'Electrosonic',	'01711522742',	NULL,	'SR-305(3rd Floor),BCS Computer City,IDB Bhaban,',	'1',	'2026-04-20 10:11:31',	'2026-04-20 10:11:31'),
(18,	'Fast Signs',	'01979128622',	NULL,	'272/ka,1/3 West Agarhaon,Sher-E-Bangla Nagar,Dhaka-1207',	'1',	'2026-04-20 10:12:12',	'2026-04-20 10:12:12'),
(19,	'Flyerex',	'01987988501',	NULL,	'Newmarket,Azimpur',	'1',	'2026-04-20 10:12:58',	'2026-04-20 10:12:58'),
(20,	'Global Brand',	'01977476430',	NULL,	'19/2, West Panthapath Dhanmondi, Dhaka-1205, Bangladesh',	'1',	'2026-04-20 10:14:32',	'2026-04-20 10:14:32'),
(21,	'Green Enterprise',	'01719704897',	NULL,	'Motijheel',	'1',	'2026-04-20 10:19:23',	'2026-04-20 10:19:23'),
(22,	'Jagannath University',	'01913054120',	NULL,	'9-10 Chittaranjan Ave, Dhaka 1100',	'1',	'2026-04-20 10:20:39',	'2026-04-20 10:20:39'),
(23,	'Jahan Trading',	'01715751842',	NULL,	'Kataban',	'1',	'2026-04-20 10:21:10',	'2026-04-20 10:21:10'),
(24,	'Metro Coverage',	'01755639001',	NULL,	'Gloria Tower, Paltan',	'1',	'2026-04-20 10:21:43',	'2026-04-20 10:21:43'),
(25,	'Nur Computer',	'01908353942',	NULL,	'Corporate Market, 2nd Floor',	'1',	'2026-04-20 10:22:15',	'2026-04-20 10:22:15'),
(26,	'Prime Stationary',	'01719281314',	NULL,	'Motijheel',	'1',	'2026-04-20 10:23:41',	'2026-04-20 10:23:41'),
(27,	'Rangpur Community Medical College and Hospital',	'01303690695',	NULL,	'Rangpur',	'1',	'2026-04-20 10:25:36',	'2026-04-20 10:25:36'),
(28,	'Rich Market',	'01724625402',	NULL,	'Ashuganj,Bramnobaria',	'1',	'2026-04-20 10:26:11',	'2026-04-20 10:26:11'),
(29,	'RS International',	'01878256805',	NULL,	'Ukhiya, Rajshahi',	'1',	'2026-04-20 10:26:42',	'2026-04-20 10:26:42'),
(30,	'Sena Kalyan Sangstha Tower',	'01769056382',	NULL,	'SKS TOWER (10th Floor), 07 VIP Road , Mohakhali',	'1',	'2026-04-20 10:27:34',	'2026-04-20 10:27:34'),
(31,	'Sheikh Brothers',	'01819847464',	NULL,	'Green Road',	'1',	'2026-04-20 10:28:06',	'2026-04-20 10:28:06'),
(32,	'Sun Shine',	'01673677515',	NULL,	'Shop#861,Leve#8,Multiplane, New Elephant Road',	'1',	'2026-04-20 10:29:17',	'2026-04-20 10:29:17'),
(33,	'Trimatrik Multimedia',	'01853330345',	'info@trimatrikbd.com',	'Uttara, Dhaka-1230',	'1',	'2026-04-20 10:29:54',	'2026-04-20 10:29:54'),
(34,	'Univers IT and Automation Limited',	'01823021975',	NULL,	'Mirpur, Pallabi',	'1',	'2026-04-20 10:31:25',	'2026-04-20 10:31:25'),
(35,	'HiTi',	'01904400202',	NULL,	'Taiwan',	'1',	'2026-04-20 14:48:59',	'2026-04-20 14:48:59');

-- 2026-05-02 10:40:12 UTC
