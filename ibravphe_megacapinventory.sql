-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 29, 2025 at 01:50 PM
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
-- Table structure for table `advance_salaries`
--

CREATE TABLE `advance_salaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `request_date` date NOT NULL,
  `notes` text DEFAULT NULL,
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
-- Table structure for table `bank_details`
--

CREATE TABLE `bank_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `branch` varchar(255) NOT NULL,
  `account_number` varchar(255) NOT NULL,
  `account_type` varchar(255) NOT NULL,
  `routing_number` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bank_details`
--

INSERT INTO `bank_details` (`id`, `account_name`, `bank_name`, `branch`, `account_number`, `account_type`, `routing_number`, `is_default`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'ghjrtuj', 'rhyj', 'rthdrher', '321654', 'Current', '65584', 1, 1, '2025-11-29 10:21:26', '2025-11-29 10:24:34');

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bill_number` varchar(255) NOT NULL,
  `reference_number` varchar(255) DEFAULT NULL,
  `sale_id` bigint(20) UNSIGNED DEFAULT NULL,
  `project_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('sale','project') NOT NULL,
  `work_order_number` varchar(255) DEFAULT NULL,
  `bill_date` date NOT NULL,
  `subtotal` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bank_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `company_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `terms_conditions` text DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `attention_to` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`id`, `bill_number`, `reference_number`, `sale_id`, `project_id`, `customer_id`, `client_id`, `type`, `work_order_number`, `bill_date`, `subtotal`, `total_amount`, `notes`, `created_at`, `updated_at`, `bank_detail_id`, `company_detail_id`, `terms_conditions`, `subject`, `attention_to`) VALUES
(12, 'BILL-20251129-0001', 'BIL-20251129-172600', NULL, 10, NULL, 9, 'sale', 'rytkytuk', '2025-11-29', 116000.00, 116000.00, NULL, '2025-11-29 11:26:11', '2025-11-29 11:26:11', 1, 1, 'The products come with a 1-year limited warranty. Please note that the warranty does not cover physical damage or burn cases.\r\nThe delivered products & accessories will not be changeable after use.\r\n The party will pay by Cash/ an account Payee Cheque/DD/Pay Order in favor of our company with a work order.\r\nGovt. VAT & TAX: Prices are including of all kinds of TAX & VAT as per government rule.', 'Bill for Supplying of Products/Services', 'kytuytuk');

-- --------------------------------------------------------

--
-- Table structure for table `bill_items`
--

CREATE TABLE `bill_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bill_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bill_items`
--

INSERT INTO `bill_items` (`id`, `bill_id`, `description`, `quantity`, `unit_price`, `total`, `created_at`, `updated_at`) VALUES
(15, 12, 'Epson EcoTank L3250 A4 Wi-Fi Multifunction InkTank Printer (Official)', 2, 16000.00, 32000.00, '2025-11-29 11:26:11', '2025-11-29 11:26:11'),
(16, 12, 'Canon Pixma G3010 Refillable Ink Tank Wireless All-In-One Printer', 3, 28000.00, 84000.00, '2025-11-29 11:26:11', '2025-11-29 11:26:11');

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

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'HP', 1, '2025-11-02 18:37:35', '2025-11-02 18:37:35', NULL),
(3, 'Canon', 1, '2025-11-02 18:38:06', '2025-11-02 18:38:06', NULL),
(4, 'Epson', 1, '2025-11-02 18:38:12', '2025-11-02 18:38:12', NULL),
(5, 'Brother', 1, '2025-11-02 18:38:25', '2025-11-02 18:38:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `challans`
--

CREATE TABLE `challans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `challan_number` varchar(255) NOT NULL,
  `reference_number` varchar(255) NOT NULL,
  `challan_date` date NOT NULL,
  `type` enum('sale','project') NOT NULL,
  `sale_id` bigint(20) UNSIGNED DEFAULT NULL,
  `project_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attention_to` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `challans`
--

INSERT INTO `challans` (`id`, `challan_number`, `reference_number`, `challan_date`, `type`, `sale_id`, `project_id`, `customer_id`, `client_id`, `created_at`, `updated_at`, `attention_to`) VALUES
(31, 'CHALLAN-20251129-0001', 'CHL-20251129-182634', '2025-11-29', 'sale', 26, NULL, 16, NULL, '2025-11-29 12:26:56', '2025-11-29 12:26:56', NULL),
(32, 'CHALLAN-20251129-0002', 'CHL-20251129-183106', '2025-11-29', 'project', NULL, 10, NULL, 9, '2025-11-29 12:31:15', '2025-11-29 12:31:15', NULL),
(33, 'CHALLAN-20251129-0003', 'CHL-20251129-183228', '2025-11-29', 'sale', 26, NULL, 16, NULL, '2025-11-29 12:32:34', '2025-11-29 12:32:34', NULL),
(34, 'CHALLAN-20251129-0004', 'CHL-20251129-183800', '2025-11-29', 'sale', 26, NULL, 16, NULL, '2025-11-29 12:38:09', '2025-11-29 12:38:09', NULL),
(35, 'CHALLAN-20251129-0005', 'CHL-20251129-183918', '2025-11-29', 'sale', 26, NULL, 16, NULL, '2025-11-29 12:39:24', '2025-11-29 12:39:24', NULL),
(36, 'CHALLAN-20251129-0006', 'CHL-20251129-184053', '2025-11-29', 'project', NULL, 10, NULL, 9, '2025-11-29 12:41:02', '2025-11-29 12:41:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `challan_items`
--

CREATE TABLE `challan_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `challan_id` bigint(20) UNSIGNED NOT NULL,
  `description` text NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `unit` varchar(255) NOT NULL DEFAULT 'Piece',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `challan_items`
--

INSERT INTO `challan_items` (`id`, `challan_id`, `description`, `quantity`, `unit`, `created_at`, `updated_at`) VALUES
(32, 31, 'Epson EcoTank L3250 A4 Wi-Fi Multifunction InkTank Printer (Official)', 2, 'Piece', '2025-11-29 12:26:56', '2025-11-29 12:26:56'),
(33, 32, 'Epson EcoTank L3250 A4 Wi-Fi Multifunction InkTank Printer (Official)', 2, 'Unit', '2025-11-29 12:31:15', '2025-11-29 12:31:15'),
(34, 32, 'Canon Pixma G3010 Refillable Ink Tank Wireless All-In-One Printer', 3, 'Unit', '2025-11-29 12:31:15', '2025-11-29 12:31:15'),
(35, 33, 'Epson EcoTank L3250 A4 Wi-Fi Multifunction InkTank Printer (Official)', 2, 'Piece', '2025-11-29 12:32:34', '2025-11-29 12:32:34'),
(36, 34, 'Epson EcoTank L3250 A4 Wi-Fi Multifunction InkTank Printer (Official)', 2, 'Piece', '2025-11-29 12:38:09', '2025-11-29 12:38:09'),
(37, 35, 'Epson EcoTank L3250 A4 Wi-Fi Multifunction InkTank Printer (Official)', 2, 'Piece', '2025-11-29 12:39:24', '2025-11-29 12:39:24'),
(38, 36, 'Epson EcoTank L3250 A4 Wi-Fi Multifunction InkTank Printer (Official)', 2, 'Unit', '2025-11-29 12:41:02', '2025-11-29 12:41:02'),
(39, 36, 'Canon Pixma G3010 Refillable Ink Tank Wireless All-In-One Printer', 3, 'Unit', '2025-11-29 12:41:02', '2025-11-29 12:41:02');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `name`, `phone`, `email`, `address`, `created_at`, `updated_at`) VALUES
(2, 'Md Hasan', '01234567890', 'hasan@inoodex.com', 'Dhaka', '2025-11-14 20:08:22', '2025-11-14 20:08:22'),
(9, 'Mr Rahim', '01000000000', 'rahim@example.com', 'Mirpur', '2025-11-26 05:52:50', '2025-11-26 05:52:50');

-- --------------------------------------------------------

--
-- Table structure for table `company_details`
--

CREATE TABLE `company_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `signatory_name` varchar(255) NOT NULL,
  `signatory_designation` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `company_details`
--

INSERT INTO `company_details` (`id`, `name`, `signatory_name`, `signatory_designation`, `phone`, `email`, `website`, `address`, `is_default`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'ABC', 'abc', 'abcd', '216421644', 'hasan@example.com', 'www.abc.com', 'dlkgnoisdgjldkgn', 1, 1, '2025-11-29 09:54:32', '2025-11-29 10:00:54');

-- --------------------------------------------------------

--
-- Table structure for table `cost_categories`
--

CREATE TABLE `cost_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cost_categories`
--

INSERT INTO `cost_categories` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Transport Cost', NULL, 1, '2025-11-18 00:24:51', '2025-11-18 00:24:51'),
(2, 'Installation Charge', NULL, 1, '2025-11-18 00:28:24', '2025-11-18 17:02:00');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
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
(11, 'Md Juel', NULL, '01213986745', 'juel@example.com', NULL, 'Gulshan', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-11-03 02:06:48', '2025-11-26 11:00:21'),
(15, 'Md Rahim', NULL, '01195674368', 'rahim@example.com', NULL, 'Dhaka', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-11-23 06:05:15', '2025-11-26 10:59:08'),
(16, 'Md Hasan', NULL, '01200000000', 'hasan@example.com', NULL, 'Dhaka', NULL, NULL, 0, NULL, NULL, '1', NULL, '2025-11-26 05:26:27', '2025-11-26 10:56:57');

-- --------------------------------------------------------

--
-- Table structure for table `daily_expenses`
--

CREATE TABLE `daily_expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
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

INSERT INTO `daily_expenses` (`id`, `user_id`, `employee_id`, `date`, `expense_category_id`, `amount`, `spend_method`, `remarks`, `created_at`, `updated_at`) VALUES
(2, 2, 5, '2025-11-12', 2, 5000.00, 'cash', 'advance salary', '2025-11-11 18:10:46', '2025-11-13 00:59:25');

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
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `salary` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `user_id`, `employee_id`, `name`, `email`, `phone`, `image`, `designation`, `join_date`, `salary`, `status`, `created_at`, `updated_at`) VALUES
(4, 5, 'EMP0005', 'Md Hasan', 'test2@example.com', '012398763542', NULL, 'Jr. Employee', '2025-11-05', 20000.00, 'active', '2025-11-09 18:30:52', '2025-11-09 19:45:21'),
(5, 6, 'EMP0006', 'Md Karim', 'karim@example.com', '012306050408', NULL, 'Sr. Employee', NULL, 25000.00, 'active', '2025-11-11 18:05:35', '2025-11-11 18:08:24');

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
(1, 'Other', 1, '2025-11-03 00:27:27', '2025-11-03 00:27:27'),
(2, 'Advance Salary', 1, '2025-11-09 19:01:53', '2025-11-09 19:01:53');

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
(1, 4, 10, 9, 'Opening stock entry', '2025-11-02 19:31:35', '2025-11-26 05:54:14'),
(3, 5, 20, 7, 'Opening stock entry', '2025-11-03 02:05:12', '2025-11-26 05:54:14'),
(4, 3, 12, 3, 'Opening stock entry', '2025-11-03 02:11:45', '2025-11-24 10:56:34');

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
(12, '2024_12_01_091025_create_bookings_table', 1),
(13, '2024_12_02_015620_create_brands_table', 1),
(14, '2024_12_03_143540_products', 1),
(15, '2024_12_05_152050_sales', 1),
(16, '2024_12_16_102327_payments', 1),
(17, '2024_12_31_090914_daily_sales', 1),
(18, '2025_02_16_091918_attendances', 1),
(19, '2025_03_08_103257_salaries', 1),
(20, '2025_03_26_120716_extras', 1),
(21, '2025_04_14_015443_create_vendors_table', 1),
(22, '2025_05_27_095543_create_purchases_table', 1),
(23, '2025_05_29_103934_create_inventories_table', 1),
(24, '2025_10_14_001916_create_expense_categories_table', 1),
(25, '2025_10_14_002056_create_daily_expenses_table', 1),
(26, '2025_10_14_015809_create_sale_items_table', 1),
(27, 'add_teams_fields', 1),
(28, 'create_permission_tables', 1),
(29, '2025_11_03_045711_create_revenues_table', 2),
(30, '2025_11_03_045713_create_revenues_table', 3),
(31, '2025_11_05_004928_create_employees_table', 4),
(32, '2025_11_05_051145_create_ta_das_table', 5),
(33, '2025_11_06_063400_create_salaries_table', 6),
(34, '2025_11_06_063401_create_salaries_table', 7),
(35, '2025_11_06_063402_create_salaries_table', 8),
(36, '2025_11_05_051146_create_ta_das_table', 9),
(37, '2025_11_09_000043_create_salary_advances_table', 10),
(38, '2025_11_09_065739_create_advance_salaries_table', 11),
(39, '2025_11_09_074807_add_user_id_to_employees_table', 12),
(40, '2025_11_09_074807_add_role_id_to_employees_table', 13),
(41, '2025_11_09_066928_create_employees_table', 14),
(42, '2025_11_10_051146_create_ta_das_table', 15),
(43, '2025_11_10_051147_create_ta_das_table', 16),
(44, '2025_11_10_052056_create_daily_expenses_table', 17),
(45, '2025_11_10_052057_create_daily_expenses_table', 18),
(46, '2025_11_10_052067_create_daily_expenses_table', 19),
(47, '2025_11_11_051147_create_ta_das_table', 20),
(48, '2025_11_11_051148_create_ta_das_table', 21),
(49, '2025_11_11_051149_create_ta_das_table', 22),
(50, '2025_11_12_010102_create_projects_table', 23),
(51, '2025_11_12_010132_create_projects_table', 24),
(52, '2025_11_11_051150_create_ta_das_table', 25),
(53, '2025_11_11_051152_create_ta_das_table', 26),
(54, '2025_11_12_010133_create_projects_table', 27),
(55, '2025_11_12_010134_create_projects_table', 28),
(56, '2025_11_15_013858_create_clients_table', 29),
(57, '2025_11_12_010135_create_projects_table', 30),
(58, '2025_11_18_014629_create_project_items_table', 31),
(59, '2025_11_18_013135_create_projects_table', 32),
(60, '2025_11_18_060953_create_cost_categories_table', 33),
(61, '2025_11_18_065841_create_project_costs_table', 34),
(62, '2025_11_18_065842_create_project_costs_table', 35),
(63, '2025_11_20_143924_create_project_bills_table', 36),
(64, '2025_11_20_144053_create_bill_items_table', 37),
(65, '2025_11_20_143925_create_project_bills_table', 38),
(66, '2025_11_20_144055_create_bill_items_table', 39),
(67, '2025_11_20_175440_create_bills_table', 40),
(68, '2025_11_20_175446_create_bills_table', 41),
(69, '2025_11_20_175447_create_bills_table', 42),
(70, '2025_11_21_144055_create_bill_items_table', 43),
(71, '2025_11_21_144056_create_bill_items_table', 44),
(72, '2025_11_23_183130_create_challans_table', 45),
(73, '2025_11_23_183135_create_challans_table', 46),
(74, '2025_11_24_110556_create_challan_items_table', 46),
(75, '2025_11_24_125447_create_bills_table', 47),
(76, '2025_11_24_144056_create_bill_items_table', 48),
(77, '2025_11_24_125448_create_bills_table', 49),
(78, '2025_11_24_144057_create_bill_items_table', 49),
(79, '2025_11_24_152350_add_project_fields_to_sales_table', 50),
(80, '2025_11_24_152355_add_project_fields_to_sales_table', 51),
(81, '2025_11_24_163950_make_customer_id_nullable_in_sales_table', 52),
(82, '2025_11_25_102923_add_photo_to_products_table', 53),
(83, '2025_11_25_131014_create_quotations_table', 54),
(84, '2025_11_25_135221_create_quotation_items_table', 54),
(85, '2025_11_26_123944_add_project_id_to_payments_table', 55),
(86, '2025_11_29_153131_create_bank_details_table', 56),
(87, '2025_11_29_153146_create_company_details_table', 56),
(88, '2025_11_29_153309_add_fields_to_bills_table', 56),
(89, '2025_11_29_163131_create_bank_details_table', 57),
(90, '2025_11_29_173929_add_fields_to_challans_table', 58);

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
(1, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 5),
(2, 'App\\Models\\User', 6);

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
  `project_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_method` enum('cash','card','bank_transfer') NOT NULL DEFAULT 'cash',
  `amount` double NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `payment_for`, `customer_id`, `sale_id`, `project_id`, `payment_method`, `amount`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 9, 9, NULL, 'cash', 10000, '1', '2025-11-03 01:06:11', '2025-11-03 01:06:11'),
(2, 2, 10, 10, NULL, 'cash', 21500, '1', '2025-11-03 01:27:52', '2025-11-03 01:27:52'),
(3, 2, 16, 26, NULL, 'cash', 7500, '1', '2025-11-26 11:02:09', '2025-11-26 11:02:09');

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
(1, 'Administration', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(2, 'Booking', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(3, 'Service Management', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(4, 'Sales Management', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(5, 'Settings', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(6, 'Product Management', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(7, 'Customer Management', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(8, 'Vendor Management', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(9, 'Purchase Management', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(10, 'Inventory Management', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(11, 'Accounts Management', 'web', '2025-10-14 23:04:22', '2025-11-04 18:46:45'),
(12, 'Report Management', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(13, 'Payment Management', 'web', '2025-11-03 00:47:54', '2025-11-03 00:47:54'),
(16, 'Employee Management', 'web', '2025-11-09 01:21:40', '2025-11-09 01:21:40'),
(17, 'Project Management', 'web', '2025-11-11 19:05:43', '2025-11-11 19:05:43'),
(18, 'Client Management', 'web', '2025-11-17 23:16:07', '2025-11-17 23:16:07'),
(19, 'Cost Management', 'web', '2025-11-18 00:22:52', '2025-11-18 00:22:52'),
(20, 'Company Management', 'web', '2025-11-29 09:49:27', '2025-11-29 09:49:27');

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
  `name` varchar(255) NOT NULL,
  `brand_id` bigint(20) UNSIGNED NOT NULL,
  `model` varchar(255) NOT NULL,
  `photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`photos`)),
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `warranty` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `brand_id`, `model`, `photos`, `status`, `warranty`, `created_at`, `updated_at`) VALUES
(3, 'Brother HL-L2320D Auto Duplex Laser Printer (30 PPM)', 5, 'Brother HL-L2320D', '[\"products\\/MvogjUxGJxkpdJ81qlvcw0xvNkNP359uJMsQmYeJ.jpg\"]', '1', 365, '2025-11-02 18:39:59', '2025-11-25 12:56:30'),
(4, 'Epson EcoTank L3250 A4 Wi-Fi Multifunction InkTank Printer (Official)', 4, 'EcoTank L3250', '[\"products\\/tASNTtO44wLOcacQJD3c4OY1RlN6BeKvD0syvHAu.jpg\"]', '1', 365, '2025-11-02 18:40:49', '2025-11-25 11:48:20'),
(5, 'Canon Pixma G3010 Refillable Ink Tank Wireless All-In-One Printer', 3, 'Canon Pixma G3010', '[\"products\\/hRkUJ44b4qhFOjjeeyCMtSqfHQQWxBekLq60T9eE.jpg\"]', '1', 365, '2025-11-02 18:41:22', '2025-11-25 11:48:08');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  `sub_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `grand_total` decimal(12,2) NOT NULL,
  `advanced_payment` decimal(12,2) NOT NULL DEFAULT 0.00,
  `due_payment` decimal(12,2) NOT NULL DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `status` enum('pending','in_progress','completed','cancelled') NOT NULL DEFAULT 'pending',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `project_name`, `client_id`, `budget`, `sub_total`, `discount`, `grand_total`, `advanced_payment`, `due_payment`, `description`, `status`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(10, 'Project 1', 9, 250000.00, 116000.00, 0.00, 116000.00, 0.00, 116000.00, NULL, 'pending', NULL, NULL, '2025-11-26 05:52:50', '2025-11-26 05:54:14');

-- --------------------------------------------------------

--
-- Table structure for table `project_costs`
--

CREATE TABLE `project_costs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `cost_category_id` bigint(20) UNSIGNED NOT NULL,
  `description` text DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `cost_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_costs`
--

INSERT INTO `project_costs` (`id`, `project_id`, `cost_category_id`, `description`, `amount`, `cost_date`, `created_at`, `updated_at`) VALUES
(6, 10, 2, NULL, 5000.00, '2025-11-26', '2025-11-26 06:06:09', '2025-11-26 13:25:43');

-- --------------------------------------------------------

--
-- Table structure for table `project_items`
--

CREATE TABLE `project_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_items`
--

INSERT INTO `project_items` (`id`, `project_id`, `product_id`, `unit_price`, `quantity`, `total`, `created_at`, `updated_at`) VALUES
(65, 10, 4, 16000.00, 2, 32000.00, '2025-11-26 05:54:14', '2025-11-26 05:54:14'),
(66, 10, 5, 28000.00, 3, 84000.00, '2025-11-26 05:54:14', '2025-11-26 05:54:14');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `sub_price` decimal(10,2) DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `payment` decimal(10,2) DEFAULT NULL,
  `due` decimal(10,2) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `product_id`, `vendor_id`, `quantity`, `unit_price`, `sub_price`, `total_price`, `payment`, `due`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 4, 2, 10, 15500.00, 155000.00, 14000.00, 10000.00, 4000.00, 1, NULL, '2025-11-02 19:31:34', '2025-11-02 19:31:34'),
(3, 5, 1, 20, 25000.00, 500000.00, 480000.00, 400000.00, 80000.00, 1, NULL, '2025-11-03 02:05:12', '2025-11-03 02:05:12'),
(4, 3, 3, 12, 13500.00, 162000.00, 160000.00, 80000.00, 80000.00, 1, NULL, '2025-11-03 02:11:45', '2025-11-03 02:11:45'),
(5, 4, 4, 15, 15500.00, 232500.00, 230000.00, 150000.00, 80000.00, 2, NULL, '2025-11-20 05:14:42', '2025-11-20 05:14:42');

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_number` varchar(255) NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quotation_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('draft','sent','accepted','rejected','expired') NOT NULL DEFAULT 'draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotations`
--

INSERT INTO `quotations` (`id`, `quotation_number`, `customer_id`, `client_id`, `quotation_date`, `expiry_date`, `notes`, `sub_total`, `discount_amount`, `total_amount`, `status`, `created_at`, `updated_at`) VALUES
(20, 'QT-20251129-0001', NULL, NULL, '2025-11-29', '2025-12-14', 'thrtj', 65800.00, 0.00, 65800.00, 'draft', '2025-11-29 12:46:27', '2025-11-29 12:46:27');

-- --------------------------------------------------------

--
-- Table structure for table `quotation_items`
--

CREATE TABLE `quotation_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quotation_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_items`
--

INSERT INTO `quotation_items` (`id`, `quotation_id`, `product_id`, `description`, `quantity`, `unit_price`, `total`, `created_at`, `updated_at`) VALUES
(21, 20, 4, NULL, 2, 12500.00, 25000.00, '2025-11-29 12:46:27', '2025-11-29 12:46:27'),
(22, 20, 5, NULL, 3, 13600.00, 40800.00, '2025-11-29 12:46:27', '2025-11-29 12:46:27');

-- --------------------------------------------------------

--
-- Table structure for table `revenues`
--

CREATE TABLE `revenues` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `total_sales` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total_purchases` decimal(15,2) NOT NULL DEFAULT 0.00,
  `total_expenses` decimal(15,2) NOT NULL DEFAULT 0.00,
  `net_profit` decimal(15,2) GENERATED ALWAYS AS (`total_sales` - `total_purchases` - `total_expenses`) VIRTUAL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `revenues`
--

INSERT INTO `revenues` (`id`, `year`, `month`, `total_sales`, `total_purchases`, `total_expenses`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 2025, 11, 149000.00, 884000.00, 5000.00, NULL, '2025-11-03 00:06:23', '2025-11-26 12:10:01');

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
(1, 'Super Admin', 'web', '2025-10-14 23:04:22', '2025-10-14 23:04:22'),
(2, 'Employee', 'web', '2025-11-05 19:06:09', '2025-11-09 01:20:37');

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
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(16, 2),
(17, 1),
(18, 1),
(19, 1),
(20, 1);

-- --------------------------------------------------------

--
-- Table structure for table `salaries`
--

CREATE TABLE `salaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `month` varchar(255) NOT NULL,
  `basic_salary` decimal(10,2) NOT NULL,
  `advance` decimal(10,2) DEFAULT NULL,
  `allowance` decimal(10,2) DEFAULT NULL,
  `deduction` decimal(10,2) DEFAULT NULL,
  `net_salary` decimal(10,2) NOT NULL,
  `payment_status` enum('paid','unpaid') NOT NULL DEFAULT 'unpaid',
  `payment_date` date DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `salaries`
--

INSERT INTO `salaries` (`id`, `employee_id`, `month`, `basic_salary`, `advance`, `allowance`, `deduction`, `net_salary`, `payment_status`, `payment_date`, `note`, `created_at`, `updated_at`) VALUES
(6, 5, '2025-11', 25000.00, 5000.00, 700.00, 0.00, 20700.00, 'paid', '2025-11-26', NULL, '2025-11-26 07:11:58', '2025-11-26 07:11:58');

-- --------------------------------------------------------

--
-- Table structure for table `salary_advances`
--

CREATE TABLE `salary_advances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `request_date` date NOT NULL,
  `notes` text DEFAULT NULL,
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
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `sale_type` varchar(255) NOT NULL DEFAULT 'retail',
  `project_id` bigint(20) UNSIGNED DEFAULT NULL,
  `qty` double NOT NULL,
  `total` double NOT NULL,
  `payble` double NOT NULL,
  `bill` double NOT NULL,
  `advanced_payment` decimal(15,2) DEFAULT NULL,
  `due_payment` decimal(15,2) DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `sales_by` varchar(255) DEFAULT NULL,
  `status` enum('paid','partial','credit') NOT NULL DEFAULT 'credit',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `order_no`, `customer_id`, `client_id`, `product_id`, `sale_type`, `project_id`, `qty`, `total`, `payble`, `bill`, `advanced_payment`, `due_payment`, `discount`, `sales_by`, `status`, `created_at`, `updated_at`) VALUES
(26, 'INV-69268F83DF752', 16, NULL, 4, 'retail', NULL, 2, 32400, 33000, 33000, 23000.00, 10000.00, 0, '2', 'partial', '2025-11-26 05:26:27', '2025-11-26 11:02:09'),
(35, 'PRJ-10-0B4C22CF0487', NULL, 9, 4, 'project', 10, 2, 32000, 32000, 250000, NULL, NULL, NULL, NULL, 'credit', '2025-11-26 05:54:14', '2025-11-26 05:54:14'),
(36, 'PRJ-10-E7F592F03244', NULL, 9, 5, 'project', 10, 3, 84000, 84000, 250000, NULL, NULL, NULL, NULL, 'credit', '2025-11-26 05:54:14', '2025-11-26 05:54:14');

-- --------------------------------------------------------

--
-- Table structure for table `sales_items`
--

CREATE TABLE `sales_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `unit_price` double NOT NULL,
  `warranty` int(11) NOT NULL DEFAULT 0 COMMENT 'in days',
  `qty` int(11) NOT NULL,
  `total_price` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales_items`
--

INSERT INTO `sales_items` (`id`, `order_id`, `product_id`, `unit_price`, `warranty`, `qty`, `total_price`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2500, 365, 2, 5000, '2025-10-14 23:06:04', '2025-10-14 23:06:04'),
(2, 2, 2, 1200, 365, 5, 6000, '2025-11-02 19:18:55', '2025-11-02 19:18:55'),
(3, 3, 2, 10000, 365, 12, 120000, '2025-11-02 20:01:39', '2025-11-02 20:01:39'),
(4, 4, 3, 100, 365, 10, 1000, '2025-11-02 20:03:14', '2025-11-02 20:03:14'),
(5, 5, 2, 100, 365, 10, 1000, '2025-11-02 20:13:01', '2025-11-02 20:13:01'),
(6, 6, 2, 1000, 365, 5, 5000, '2025-11-02 20:57:52', '2025-11-02 20:57:52'),
(7, 6, 3, 1500, 365, 3, 4500, '2025-11-02 20:57:52', '2025-11-02 20:57:52'),
(8, 7, 2, 100, 365, 5, 500, '2025-11-02 21:22:29', '2025-11-02 21:22:29'),
(9, 7, 4, 16000, 365, 2, 32000, '2025-11-02 21:22:29', '2025-11-02 21:22:29'),
(10, 8, 4, 16000, 365, 5, 80000, '2025-11-02 22:12:36', '2025-11-02 22:12:36'),
(11, 9, 4, 18000, 365, 2, 36000, '2025-11-03 00:22:32', '2025-11-03 00:22:32'),
(12, 10, 2, 16000, 365, 3, 48000, '2025-11-03 01:26:05', '2025-11-03 01:26:05'),
(13, 11, 5, 28000, 365, 8, 224000, '2025-11-03 02:06:48', '2025-11-03 02:06:48'),
(14, 11, 2, 16000, 365, 2, 32000, '2025-11-03 02:06:48', '2025-11-03 02:06:48'),
(15, 12, 3, 14500, 365, 2, 29000, '2025-11-23 06:05:15', '2025-11-23 06:05:15'),
(17, 26, 4, 16500, 365, 2, 33000, '2025-11-26 05:29:49', '2025-11-26 05:29:49');

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
  `total` double NOT NULL,
  `bill` double NOT NULL,
  `discount` double DEFAULT NULL,
  `due_amount` double NOT NULL,
  `warranty_duration` int(11) NOT NULL,
  `repaired_by` bigint(20) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `complated_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ta_das`
--

CREATE TABLE `ta_das` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `used_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `remaining_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `purpose` text DEFAULT NULL,
  `type` enum('TA','DA') NOT NULL DEFAULT 'TA',
  `payment_type` enum('Advance','Claim') NOT NULL DEFAULT 'Advance',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ta_das`
--

INSERT INTO `ta_das` (`id`, `user_id`, `employee_id`, `date`, `amount`, `used_amount`, `remaining_amount`, `purpose`, `type`, `payment_type`, `created_at`, `updated_at`) VALUES
(1, NULL, 5, '2025-11-12', 200.00, 150.00, 50.00, NULL, 'TA', 'Advance', '2025-11-12 00:04:30', '2025-11-13 00:18:33'),
(2, 6, 5, '2025-11-12', 150.00, 0.00, 0.00, NULL, 'TA', 'Claim', '2025-11-12 00:10:08', '2025-11-12 00:10:08'),
(3, 6, 5, '2025-11-13', 100.00, 0.00, 0.00, NULL, 'DA', 'Claim', '2025-11-13 00:18:56', '2025-11-13 00:18:56'),
(4, 6, 5, '2025-11-26', 500.00, 0.00, 0.00, 'lunch', 'DA', 'Claim', '2025-11-26 07:11:04', '2025-11-26 07:11:04');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL DEFAULT 1,
  `images` varchar(255) DEFAULT NULL,
  `verification_code` int(11) DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `billing_address` bigint(20) DEFAULT NULL,
  `shipping_address` bigint(20) DEFAULT NULL,
  `is_guest` enum('0','1') NOT NULL DEFAULT '0',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `type` enum('1','2','3','4') NOT NULL DEFAULT '1',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `email_verified_at`, `password`, `role_id`, `images`, `verification_code`, `is_verified`, `billing_address`, `shipping_address`, `is_guest`, `status`, `type`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'info@quickphonefixandmore.com', '01000000000', NULL, '$2y$12$KWIVx/4asS.TLUkXRveAwu6BmURg1M4CtaaPhCtvRQvLmJEgxM1EW', 1, NULL, NULL, 0, NULL, NULL, '0', '0', '1', NULL, NULL, '2025-11-09 01:26:04'),
(2, 'Inoodex', 'hello@inoodex.com', '013268546970', NULL, '$2y$12$XX/aD1Jy7JoYjb64CfBEuOBTTyCk.X60uazJ/mjue4zvbrFbYHBau', 1, '', NULL, 0, NULL, NULL, '0', '1', '1', NULL, '2025-11-04 18:43:21', '2025-11-04 18:43:21'),
(5, 'Md Hasan', 'test2@example.com', '012398763542', NULL, '$2y$12$L6PfuXrm52J5sLsRKMBtv.ZmBX07JumeLi.TanaM3yBLR4U.u5rhq', 2, '', NULL, 0, NULL, NULL, '0', '1', '1', NULL, '2025-11-09 18:30:52', '2025-11-09 18:35:52'),
(6, 'Md Karim', 'karim@example.com', '012306050408', NULL, '$2y$12$dcIPKb6RYCzeQbH6.k.QKOiEvS4bR6LVBM8evcnSOtN7F1C6x68h.', 2, '', NULL, 0, NULL, NULL, '0', '1', '1', NULL, '2025-11-11 18:05:35', '2025-11-11 18:05:35');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `name`, `phone`, `email`, `address`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Tech Land', '01364829570', 'techland@example.com', 'Banani', '1', '2025-11-02 18:44:31', '2025-11-09 18:52:33'),
(2, 'Ryans', '01195674368', 'ryans@example.com', 'Gulshan', '1', '2025-11-02 18:45:07', '2025-11-09 18:48:08'),
(3, 'Star Tech', '01295876340', 'startech@example.com', 'Multiplan', '1', '2025-11-03 02:11:13', '2025-11-09 18:52:45'),
(4, 'Global Brand', '01129367145', 'globalbrand@example.com', 'Uttara', '1', '2025-11-09 18:51:46', '2025-11-09 18:52:18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `advance_salaries`
--
ALTER TABLE `advance_salaries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `advance_salaries_employee_id_foreign` (`employee_id`);

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
-- Indexes for table `bank_details`
--
ALTER TABLE `bank_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bills_bill_number_unique` (`bill_number`),
  ADD KEY `bills_sale_id_foreign` (`sale_id`),
  ADD KEY `bills_project_id_foreign` (`project_id`),
  ADD KEY `bills_customer_id_foreign` (`customer_id`),
  ADD KEY `bills_client_id_foreign` (`client_id`),
  ADD KEY `bills_bank_detail_id_foreign` (`bank_detail_id`),
  ADD KEY `bills_company_detail_id_foreign` (`company_detail_id`);

--
-- Indexes for table `bill_items`
--
ALTER TABLE `bill_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bill_items_bill_id_foreign` (`bill_id`);

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
-- Indexes for table `challans`
--
ALTER TABLE `challans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `challans_challan_number_unique` (`challan_number`),
  ADD KEY `challans_sale_id_foreign` (`sale_id`),
  ADD KEY `challans_project_id_foreign` (`project_id`);

--
-- Indexes for table `challan_items`
--
ALTER TABLE `challan_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `challan_items_challan_id_foreign` (`challan_id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company_details`
--
ALTER TABLE `company_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cost_categories`
--
ALTER TABLE `cost_categories`
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
  ADD PRIMARY KEY (`id`),
  ADD KEY `daily_expenses_user_id_foreign` (`user_id`),
  ADD KEY `daily_expenses_employee_id_foreign` (`employee_id`),
  ADD KEY `daily_expenses_expense_category_id_foreign` (`expense_category_id`);

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
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_employee_id_unique` (`employee_id`),
  ADD UNIQUE KEY `employees_email_unique` (`email`),
  ADD KEY `employees_user_id_foreign` (`user_id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `expense_categories_name_unique` (`name`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projects_client_id_foreign` (`client_id`);

--
-- Indexes for table `project_costs`
--
ALTER TABLE `project_costs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_costs_project_id_foreign` (`project_id`),
  ADD KEY `project_costs_cost_category_id_foreign` (`cost_category_id`);

--
-- Indexes for table `project_items`
--
ALTER TABLE `project_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_items_project_id_foreign` (`project_id`),
  ADD KEY `project_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchases_product_id_foreign` (`product_id`),
  ADD KEY `purchases_vendor_id_foreign` (`vendor_id`),
  ADD KEY `purchases_created_by_foreign` (`created_by`),
  ADD KEY `purchases_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quotations_quotation_number_unique` (`quotation_number`),
  ADD KEY `quotations_customer_id_foreign` (`customer_id`),
  ADD KEY `quotations_client_id_foreign` (`client_id`);

--
-- Indexes for table `quotation_items`
--
ALTER TABLE `quotation_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quotation_items_quotation_id_foreign` (`quotation_id`),
  ADD KEY `quotation_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `revenues`
--
ALTER TABLE `revenues`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `revenues_year_month_unique` (`year`,`month`),
  ADD KEY `revenues_year_index` (`year`),
  ADD KEY `revenues_month_index` (`month`);

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
  ADD KEY `salaries_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `salary_advances`
--
ALTER TABLE `salary_advances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salary_advances_employee_id_foreign` (`employee_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sales_order_no_unique` (`order_no`),
  ADD KEY `sales_customer_id_foreign` (`customer_id`),
  ADD KEY `sales_product_id_foreign` (`product_id`),
  ADD KEY `sales_project_id_foreign` (`project_id`),
  ADD KEY `sales_client_id_foreign` (`client_id`);

--
-- Indexes for table `sales_items`
--
ALTER TABLE `sales_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ta_das`
--
ALTER TABLE `ta_das`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ta_das_employee_id_foreign` (`employee_id`),
  ADD KEY `ta_das_user_id_foreign` (`user_id`);

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
-- AUTO_INCREMENT for table `advance_salaries`
--
ALTER TABLE `advance_salaries`
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
-- AUTO_INCREMENT for table `bank_details`
--
ALTER TABLE `bank_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `bill_items`
--
ALTER TABLE `bill_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `challans`
--
ALTER TABLE `challans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `challan_items`
--
ALTER TABLE `challan_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `company_details`
--
ALTER TABLE `company_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cost_categories`
--
ALTER TABLE `cost_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `daily_expenses`
--
ALTER TABLE `daily_expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `daily_sales`
--
ALTER TABLE `daily_sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `districts`
--
ALTER TABLE `districts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `project_costs`
--
ALTER TABLE `project_costs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `project_items`
--
ALTER TABLE `project_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `quotation_items`
--
ALTER TABLE `quotation_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `revenues`
--
ALTER TABLE `revenues`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `salaries`
--
ALTER TABLE `salaries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `salary_advances`
--
ALTER TABLE `salary_advances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `sales_items`
--
ALTER TABLE `sales_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ta_das`
--
ALTER TABLE `ta_das`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `advance_salaries`
--
ALTER TABLE `advance_salaries`
  ADD CONSTRAINT `advance_salaries_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_bank_detail_id_foreign` FOREIGN KEY (`bank_detail_id`) REFERENCES `bank_details` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bills_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bills_company_detail_id_foreign` FOREIGN KEY (`company_detail_id`) REFERENCES `company_details` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `bills_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bills_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bills_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bill_items`
--
ALTER TABLE `bill_items`
  ADD CONSTRAINT `bill_items_bill_id_foreign` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `challans`
--
ALTER TABLE `challans`
  ADD CONSTRAINT `challans_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `challans_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `challan_items`
--
ALTER TABLE `challan_items`
  ADD CONSTRAINT `challan_items_challan_id_foreign` FOREIGN KEY (`challan_id`) REFERENCES `challans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `daily_expenses`
--
ALTER TABLE `daily_expenses`
  ADD CONSTRAINT `daily_expenses_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `daily_expenses_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `daily_expenses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

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
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `project_costs`
--
ALTER TABLE `project_costs`
  ADD CONSTRAINT `project_costs_cost_category_id_foreign` FOREIGN KEY (`cost_category_id`) REFERENCES `cost_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_costs_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `project_items`
--
ALTER TABLE `project_items`
  ADD CONSTRAINT `project_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_items_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `purchases_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchases_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `purchases_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quotations`
--
ALTER TABLE `quotations`
  ADD CONSTRAINT `quotations_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quotations_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quotation_items`
--
ALTER TABLE `quotation_items`
  ADD CONSTRAINT `quotation_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quotation_items_quotation_id_foreign` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `salaries`
--
ALTER TABLE `salaries`
  ADD CONSTRAINT `salaries_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `salary_advances`
--
ALTER TABLE `salary_advances`
  ADD CONSTRAINT `salary_advances_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ta_das`
--
ALTER TABLE `ta_das`
  ADD CONSTRAINT `ta_das_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ta_das_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
