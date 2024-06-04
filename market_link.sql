-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jun 03, 2024 at 06:58 PM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `market_link`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_menu`
--

CREATE TABLE `admin_menu` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_menu`
--

INSERT INTO `admin_menu` (`id`, `parent_id`, `order`, `title`, `icon`, `uri`, `permission`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 'Dashboard', 'fa-bar-chart', '/', NULL, NULL, '2024-06-03 15:53:28'),
(2, 0, 12, 'Admin', 'fa-tasks', NULL, NULL, NULL, '2024-06-03 15:53:28'),
(3, 2, 13, 'Users', 'fa-users', 'auth/users', NULL, NULL, '2024-06-03 15:53:28'),
(4, 2, 14, 'Roles', 'fa-user', 'auth/roles', NULL, NULL, '2024-06-03 15:53:28'),
(5, 2, 15, 'Permission', 'fa-ban', 'auth/permissions', NULL, NULL, '2024-06-03 15:53:28'),
(6, 2, 16, 'Menu', 'fa-bars', 'auth/menu', NULL, NULL, '2024-06-03 15:53:28'),
(7, 2, 17, 'Operation log', 'fa-history', 'auth/logs', NULL, NULL, '2024-06-03 15:53:28'),
(8, 0, 11, 'Companies', 'fa-building', 'companies', NULL, '2023-12-28 14:17:40', '2024-06-03 15:53:28'),
(9, 11, 8, 'Stock Categories', 'fa-codepen', 'stock-categories', NULL, '2023-12-28 15:57:30', '2024-06-03 15:53:28'),
(10, 11, 7, 'Stock Sub Categories', 'fa-columns', 'stock-sub-categories', NULL, '2023-12-28 16:22:14', '2024-06-03 15:53:28'),
(11, 0, 5, 'System Configuration', 'fa-cogs', 'financial-periods', NULL, '2023-12-29 16:01:21', '2024-06-03 15:53:28'),
(12, 11, 10, 'Financial Periods', 'fa-calendar', 'financial-periods', NULL, '2023-12-29 16:02:13', '2024-06-03 15:53:28'),
(13, 11, 9, 'Employees', 'fa-users', 'employees', NULL, '2023-12-29 16:19:19', '2024-06-03 15:53:28'),
(14, 0, 4, 'Stock items', 'fa-archive', 'stock-items', NULL, '2023-12-30 14:22:38', '2024-06-03 15:53:28'),
(15, 0, 3, 'Stock records', 'fa-adjust', 'stock-records', NULL, '2024-01-01 15:36:12', '2024-06-03 15:53:28'),
(16, 11, 6, 'Company Profile', 'fa-cogs', 'companies-edit', NULL, '2024-01-06 15:09:51', '2024-06-03 15:53:28'),
(17, 0, 2, 'Code gens', 'fa-cogs', 'gens', NULL, '2024-02-09 14:58:25', '2024-06-03 15:53:28');

-- --------------------------------------------------------

--
-- Table structure for table `admin_operation_log`
--

CREATE TABLE `admin_operation_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `input` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_permissions`
--

CREATE TABLE `admin_permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `http_path` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_permissions`
--

INSERT INTO `admin_permissions` (`id`, `name`, `slug`, `http_method`, `http_path`, `created_at`, `updated_at`) VALUES
(1, 'All permission', '*', '', '*', NULL, NULL),
(2, 'Dashboard', 'dashboard', 'GET', '/', NULL, NULL),
(3, 'Login', 'auth.login', '', '/auth/login\r\n/auth/logout', NULL, NULL),
(4, 'User setting', 'auth.setting', 'GET,PUT', '/auth/setting', NULL, NULL),
(5, 'Auth management', 'auth.management', '', '/auth/roles\r\n/auth/permissions\r\n/auth/menu\r\n/auth/logs', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_roles`
--

CREATE TABLE `admin_roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_roles`
--

INSERT INTO `admin_roles` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'admin', '2023-12-27 15:57:01', '2023-12-27 16:08:46'),
(2, 'Company Owner', 'company', '2023-12-27 16:09:55', '2023-12-27 16:09:55'),
(3, 'Company Worker', 'worker', '2023-12-27 16:10:35', '2023-12-27 16:10:35'),
(4, 'super-treasurer', 'super-treasurer', '2024-04-30 13:48:20', '2024-04-30 13:48:20'),
(5, 'treasurer', 'treasurer', '2024-04-30 13:48:29', '2024-04-30 13:48:29');

-- --------------------------------------------------------

--
-- Table structure for table `admin_role_menu`
--

CREATE TABLE `admin_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_role_menu`
--

INSERT INTO `admin_role_menu` (`role_id`, `menu_id`, `created_at`, `updated_at`) VALUES
(1, 8, NULL, NULL),
(2, 9, NULL, NULL),
(3, 9, NULL, NULL),
(2, 10, NULL, NULL),
(3, 10, NULL, NULL),
(2, 11, NULL, NULL),
(2, 12, NULL, NULL),
(2, 13, NULL, NULL),
(2, 14, NULL, NULL),
(3, 14, NULL, NULL),
(2, 15, NULL, NULL),
(3, 15, NULL, NULL),
(2, 16, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_role_permissions`
--

CREATE TABLE `admin_role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_role_permissions`
--

INSERT INTO `admin_role_permissions` (`role_id`, `permission_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL),
(2, 1, NULL, NULL),
(3, 1, NULL, NULL),
(4, 1, NULL, NULL),
(5, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_role_users`
--

CREATE TABLE `admin_role_users` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_role_users`
--

INSERT INTO `admin_role_users` (`role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL),
(2, 2, NULL, NULL),
(2, 3, NULL, NULL),
(1, 7, NULL, NULL),
(2, 8, NULL, NULL),
(2, 9, NULL, NULL),
(2, 10, NULL, NULL),
(2, 15, NULL, NULL),
(2, 16, NULL, NULL),
(2, 17, NULL, NULL),
(4, 5, NULL, NULL),
(5, 16, NULL, NULL),
(2, 17, NULL, NULL),
(2, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `first_name` text COLLATE utf8mb4_unicode_ci,
  `last_name` text COLLATE utf8mb4_unicode_ci,
  `phone_number` text COLLATE utf8mb4_unicode_ci,
  `phone_number_2` text COLLATE utf8mb4_unicode_ci,
  `address` text COLLATE utf8mb4_unicode_ci,
  `sex` text COLLATE utf8mb4_unicode_ci,
  `dob` date DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `username`, `password`, `name`, `avatar`, `remember_token`, `created_at`, `updated_at`, `company_id`, `first_name`, `last_name`, `phone_number`, `phone_number_2`, `address`, `sex`, `dob`, `status`, `email`) VALUES
(1, '+256783204665', '$2y$12$COQ4QAw3/hoTfQnm2TOtgej/KnSaWUXZKbrCPUiuF.RLDVgu4QZmK', 'Muhindo Mubaraka', 'images/8Tech 27-02-2023-1.jpg', '3W2mBx3xMi2bYbObLHFjXeApkcGfU8gVst8VosdeReSZhd5OpNXPoeIMijcO', '2023-12-27 15:57:01', '2024-06-03 15:21:01', 1, 'Muhindo', 'Mubaraka', '+256783204665', '+256783204665', 'Kampala, Uganda', 'Male', '2024-01-06', 'Active', '+256783204665'),
(2, '+256782349228', '$2y$12$ub7nGRquDzOeWG6GvQrHGOWBU5klEOCHb9DNF5t361VGhS9aps0ji', 'Siyama Kaswera', NULL, 'tzYJSR8g0TulnPoHMNv4q35B4Dtliudca0lTPZd9zlR4mbXxhDSeyHEPxVr0', '2023-12-28 14:31:42', '2024-04-28 20:56:22', 1, 'Siyama', 'Kaswera', '+256782349228', '+256782349228', 'Bwera asese', 'Female', NULL, 'Active', '+256782349228'),
(3, 'mubahood1', '$2y$12$suUCDM8EhPLsalQA9h9VSOeMO73MKrXwNaLdAPWM0CBuJl8m5vs9u', 'Mubaraka Muhindo', 'images/pic-to-take.jpeg', 'XQfFEnpc0a0bd7ZM2lr0re6hDiBdO0rHG2T3yCZrhrsXcNek4Q5v9wjD8HBe', '2023-12-28 14:32:27', '2024-05-02 04:02:27', 1, 'Mubaraka', 'Muhindo', '+256783204665', NULL, 'Optio eos id eaque', 'Male', NULL, 'Active', 'mubahood1'),
(4, 'mubahood', '$2y$12$ub7nGRquDzOeWG6GvQrHGOWBU5klEOCHb9DNF5t361VGhS9aps0ji', 'Britanney Strickland', NULL, NULL, '2023-12-29 16:32:38', '2024-01-08 15:33:17', 7, 'Britanney', 'Strickland', '+1 (113) 639-6595', '+1 (162) 618-9013', 'Reprehenderit cupidi', 'Male', NULL, 'Active', 'mubahood'),
(5, 'bmuhidin40@gmail.com', '$2y$12$.aReHLmXai10w.o5XERVY.Rzn3r2B2W0ImuWLpStf5G3C9jEaKUh.', 'Bwambale Muhidin', NULL, 'ZFcIko4cc798Ko07tXsHxy3m3bWYCmSMtUpGZWJyGfbezIxI6obkGaQpXUgk', '2024-01-07 15:02:54', '2024-05-06 00:50:10', 1, 'Bwambale', 'Muhidin', '0708343674', '0708343674', NULL, 'Male', NULL, 'Active', 'bmuhidin40@gmail.com'),
(6, 'mubahood1@gmail.com', '$2y$12$PYQWoGMocuDPXih6cOfvpud4JVTj17brPA6kDSlrlhVI43u8Tzjd6', 'Muhindo Mubaraka', NULL, NULL, '2024-01-07 15:09:09', '2024-01-07 15:09:09', 3, 'Muhindo', 'Mubaraka', '+256783204665', NULL, NULL, NULL, NULL, 'Active', 'mubahood1@gmail.com'),
(7, 'mubahood2@gmail.com', '$2y$10$Gr1A40jk.UKMltB5OEvVqO8S.tGiKigwH3u/UlrRVda4MmD5AXwgq', 'Muhindo Mubaraka', NULL, NULL, '2024-01-07 15:13:30', '2024-01-07 15:13:30', 4, 'Muhindo', 'Mubaraka', '+256783204665', NULL, NULL, NULL, NULL, 'Active', 'mubahood2@gmail.com'),
(8, 'mubahood5@gmail.com', '$2y$12$bsEuNorMNJytTl/n6B.P0.hQIEaanvX4PlXt2ADUyVTDfI1pCKJLm', 'Muhindo Mubaraka', NULL, NULL, '2024-01-07 15:27:56', '2024-01-07 15:27:56', 5, 'Muhindo', 'Mubaraka', '+256783204665', NULL, NULL, NULL, NULL, 'Active', 'mubahood5@gmail.com'),
(9, 'mubahood6@gmail.com', '$2y$10$tv/FErAD6MPB0fXaDP//i.DEwmKfm9NBDQk.NSpOTftbemHmp0bXC', 'Muhindo Mubaraka', NULL, NULL, '2024-01-07 15:29:39', '2024-01-07 15:29:39', 6, 'Muhindo', 'Mubaraka', '+256783204665', NULL, NULL, NULL, NULL, 'Active', 'mubahood6@gmail.com'),
(10, 'mubahood360@gmail.com', '$2y$10$uDLNkP3Vzf6GgdVVypyWI.mIGPyKotchnKaZfitqcgjIs0rwiKGwi', 'Muhindo Mubaraka', NULL, '0rkCxCPU2qpeODzdI22Oyu29pRJV38rUkwiNZEOy4C4VutXegoA6cL3wxUwb', '2024-01-08 14:09:31', '2024-01-08 14:09:31', 7, 'Muhindo', 'Mubaraka', '+256783204665', NULL, NULL, NULL, NULL, 'Active', 'mubahood360@gmail.com'),
(11, 'employee1@gmail.com', '$2y$12$OVU2uliA1JgOvnN3dg2LR.MWo2OXIi4y1/NQwvP0BxM5GEJ9N.Puu', 'Employee One', NULL, 'tsHpofqRWB3ajLoCNA35UeFsi8VrY10DQXCcTeL2w1DwvE1CTJDcr2f4CCAU', '2024-01-08 15:20:37', '2024-01-08 15:20:37', 6, 'Employee', 'One', '+256783204665', NULL, 'Kasese, Uganda', 'Male', '1995-08-18', 'Active', 'employee1@gmail.com'),
(13, 'employee2@gmail.com', '$2y$12$48VMHHFgbOKnkkTgFx4M6ebv5unz9evNq0vh/rtXLoInOzKg1k/W.', 'Employee One', NULL, NULL, '2024-01-08 15:25:47', '2024-01-08 15:25:47', 7, 'Employee', 'One', '+256783204665', NULL, 'Kasese, Uganda', 'Male', '1995-08-18', 'Active', 'employee2@gmail.com'),
(14, 'employee3@gmail.com', '$2y$12$QnuqwtMXVoImWI07y9UgM.1iFgTqtIgcSD4ufa30q/9DjCP1Euk/.', 'Employee Four', NULL, NULL, '2024-01-08 15:26:11', '2024-01-08 15:27:52', 7, 'Employee', 'Four', '+256783204665', NULL, 'Kasese, Uganda', 'Male', '1995-08-18', 'Active', 'employee3@gmail.com'),
(15, '+256789804064', '$2y$12$a8P7f9rIOwOUgdSwNnGhc.1oOyBbJhxeTYBalUxnILniZefODKNPS', 'Farida Dada', NULL, NULL, '2024-04-28 21:07:49', '2024-04-28 21:07:49', 1, 'Farida', 'Dada', '+256789804064', '+256789804064', NULL, 'Female', '2024-04-29', 'Active', '+256789804064'),
(16, 'safari', '$2y$12$PbrIIfVzbXuU1I39FsFk1eAykgybvpOIZGX8QzQ67r8jJBt.7XEQq', 'Safari Miraji', NULL, NULL, '2024-05-02 23:43:45', '2024-05-02 23:45:22', 1, 'Safari', 'Miraji', 'safari', NULL, NULL, 'Male', '2024-05-03', 'Active', 'safari'),
(17, 'sumayahswaib@gmail.com', '$2y$10$dAXmCv8F0pwIv78JL18pC.QaTVCTK1BD6a0fp8JnmlTxIhkfb0lkW', 'sumayah swaib', NULL, NULL, '2024-05-07 00:12:57', '2024-05-07 00:12:57', 11, 'sumayah', 'swaib', '0755906818', NULL, NULL, NULL, NULL, 'Active', 'sumayahswaib@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `admin_user_permissions`
--

CREATE TABLE `admin_user_permissions` (
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `budget_items`
--

CREATE TABLE `budget_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `budget_program_id` bigint(20) UNSIGNED NOT NULL,
  `budget_item_category_id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `changed_by_id` bigint(20) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `target_amount` bigint(20) DEFAULT NULL,
  `invested_amount` bigint(20) DEFAULT NULL,
  `balance` bigint(20) DEFAULT NULL,
  `percentage_done` bigint(20) DEFAULT NULL,
  `is_complete` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `unit_price` bigint(20) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `approved` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `details` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `budget_items`
--

INSERT INTO `budget_items` (`id`, `created_at`, `updated_at`, `budget_program_id`, `budget_item_category_id`, `company_id`, `created_by_id`, `changed_by_id`, `name`, `target_amount`, `invested_amount`, `balance`, `percentage_done`, `is_complete`, `unit_price`, `quantity`, `approved`, `details`) VALUES
(1, '2024-04-30 06:18:31', '2024-04-30 19:04:01', 1, 1, 1, 2, 5, 'Cow', 3000000, 1500000, 1500000, 50, 'No', 2, 1500000, '1', NULL),
(2, '2024-04-30 06:26:48', '2024-04-30 07:06:34', 1, 1, 1, 2, 2, 'Sofaset', 700000, 700000, 0, 100, 'Yes', 1, 700000, '1', NULL),
(3, '2024-04-30 06:26:48', '2024-05-06 02:03:09', 1, 1, 1, 3, 3, 'Water tank', 550000, 550000, 0, 100, 'Yes', 1, 550000, '1', 'Purchased tank cas 550000'),
(4, '2024-04-30 06:26:48', '2024-04-30 07:07:00', 1, 1, 1, 2, 2, 'Refrigerator', 1000000, 1000000, 0, 100, 'Yes', 1, 1000000, '1', NULL),
(5, '2024-04-30 06:26:48', '2024-05-06 02:15:36', 1, 1, 1, 3, 3, 'Muggo gwa tata', 80000, 0, 80000, 0, 'No', 1, 80000, '1', NULL),
(6, '2024-04-30 06:26:48', '2024-05-03 09:51:07', 1, 1, 1, 16, 16, 'Senga\'s Goats', 400000, 0, 400000, 0, 'No', 2, 200000, '1', NULL),
(7, '2024-04-30 06:26:48', '2024-04-30 07:08:46', 1, 1, 1, 2, 2, 'Mother\'s Goats', 600000, 600000, 0, 100, 'Yes', 3, 200000, '1', NULL),
(8, '2024-04-30 06:26:48', '2024-05-04 22:25:43', 1, 1, 1, 3, 3, 'Mother\'s Gomesi', 130000, 130000, 0, 100, 'Yes', 1, 130000, '1', 'Cleared'),
(9, '2024-04-30 06:26:48', '2024-05-04 22:26:35', 1, 1, 1, 3, 3, 'Senga\'s Gomesi', 130000, 130000, 0, 100, 'Yes', 1, 130000, '1', 'Cleared'),
(10, '2024-04-30 06:26:48', '2024-05-04 12:01:06', 1, 1, 1, 3, 3, 'Mukodomi Kanzu', 240000, 240000, 0, 100, 'Yes', 3, 80000, '1', 'Paid mama hilala'),
(12, '2024-04-30 06:26:48', '2024-05-05 12:32:13', 1, 1, 1, 3, 3, 'Soap', 152000, 152000, 0, 100, 'Yes', 4, 38000, '1', 'Gave money to dada Farida'),
(13, '2024-04-30 06:26:48', '2024-04-30 07:09:27', 1, 1, 1, 2, 2, 'Wedding support', 500000, 500000, 0, 100, 'Yes', 1, 500000, '1', NULL),
(14, '2024-04-30 06:26:48', '2024-05-05 12:33:26', 1, 1, 1, 3, 3, 'Sugar', 190000, 190000, 0, 100, 'Yes', 2, 95000, '1', 'Gave money to dada Farida'),
(15, '2024-04-30 06:26:48', '2024-05-05 12:33:07', 1, 1, 1, 3, 3, 'Soda (Crates)', 100000, 100000, 0, 100, 'Yes', 5, 20000, '1', 'Gave money to dada Farida'),
(16, '2024-04-30 06:29:40', '2024-05-01 03:08:19', 1, 2, 1, 2, 5, 'Changing Dresses', 320000, 250000, 70000, 78, 'No', 1, 320000, '1', 'Gave vari 200k for man\'s changing dress & woman\'s, tailored'),
(18, '2024-04-30 06:29:40', '2024-04-30 08:52:59', 1, 2, 1, 2, 2, 'Gomesi', 400000, 400000, 0, 100, 'Yes', 1, 400000, '1', 'Sent 400k to romina'),
(19, '2024-04-30 06:29:40', '2024-05-07 02:53:47', 1, 2, 1, 3, 3, 'Wedding gown & Maids', 1300000, 1050000, 250000, 81, 'No', 1, 1300000, '1', 'Gave mama nafsat 450k\nAdded mama nafsat 600k'),
(22, '2024-04-30 06:29:40', '2024-05-04 11:38:31', 1, 2, 1, 3, 3, 'Makeup & Saloon', 650000, 550000, 100000, 85, 'No', 1, 650000, '1', 'Gave zamda 200k\nAdded zamzuchu 350k through mobile money'),
(24, '2024-04-30 06:32:33', '2024-05-01 15:19:36', 1, 3, 1, 1, 1, 'Suits', 300000, 200000, 100000, 67, 'No', 6, 50000, '1', 'Gave mama nafsat 200k for suits'),
(26, '2024-04-30 06:34:18', '2024-05-05 12:41:38', 1, 4, 1, 3, 3, 'Rice', 920000, 920000, 0, 100, 'Yes', 200, 4600, '1', 'Gave dada farida 390k\nGave balance to farida'),
(27, '2024-04-30 06:34:18', '2024-05-03 13:27:25', 1, 4, 1, 3, 3, 'Goat', 200000, 200000, 0, 100, 'Yes', 1, 200000, '1', 'Cleared by Kaka kawaya'),
(28, '2024-04-30 06:34:18', '2024-05-03 01:14:50', 1, 4, 1, 3, 3, 'Meat', 1200000, 600000, 600000, 50, 'No', 100, 12000, '1', 'Paid 50% cash on meat.'),
(29, '2024-04-30 06:34:18', '2024-04-30 09:00:49', 1, 4, 1, 2, 2, 'Matooke', 150000, 0, 150000, 0, 'No', 10, 15000, '1', NULL),
(31, '2024-04-30 06:34:18', '2024-05-07 03:44:54', 1, 4, 1, 3, 3, 'Ngano', 75000, 75000, 0, 100, 'Yes', 1, 75000, '1', 'Gave money to dada Farida'),
(32, '2024-04-30 06:34:18', '2024-05-05 12:42:40', 1, 4, 1, 3, 3, 'Irish', 160000, 160000, 0, 100, 'Yes', 4, 40000, '1', 'Gave money to dada Farida'),
(33, '2024-04-30 06:34:18', '2024-04-30 09:06:12', 1, 4, 1, 2, 2, 'Cabbages', 40000, 0, 40000, 0, 'No', 20, 2000, '1', NULL),
(34, '2024-04-30 06:34:18', '2024-04-30 09:06:13', 1, 4, 1, 2, 2, 'Beans (basins)', 70000, 0, 70000, 0, 'No', 2, 35000, '1', NULL),
(35, '2024-04-30 06:34:18', '2024-04-30 09:06:14', 1, 4, 1, 2, 2, 'Carrots & Green papers', 40000, 0, 40000, 0, 'No', 1, 40000, '1', NULL),
(37, '2024-04-30 06:34:18', '2024-04-30 09:06:16', 1, 4, 1, 2, 2, 'Cassava flour (KG)', 100000, 0, 100000, 0, 'No', 50, 2000, '1', NULL),
(38, '2024-04-30 06:34:18', '2024-05-06 00:51:10', 1, 4, 1, 3, 3, 'Chicken', 400000, 400000, 0, 100, 'Yes', 20, 20000, '1', 'Gave papa tamim 150k..\nGave papa tamim balance'),
(39, '2024-04-30 06:34:18', '2024-05-05 14:42:43', 1, 4, 1, 3, 3, 'Cooking oil (40 litres)', 260000, 260000, 0, 100, 'Yes', 2, 130000, '1', 'Gave money to dada Farida'),
(40, '2024-04-30 06:34:18', '2024-05-05 12:41:54', 1, 4, 1, 3, 3, 'Salt (20 kg)', 22000, 22000, 0, 100, 'Yes', 1, 22000, '1', 'Gave money to dada Farida'),
(41, '2024-04-30 06:34:18', '2024-05-03 13:31:19', 1, 4, 1, 5, 5, 'Fire wood', 200000, 200000, 0, 100, 'Yes', 1, 200000, '1', 'Gave dada farida 200kDelivered all the wedding venue.'),
(42, '2024-04-30 06:34:18', '2024-05-05 10:53:39', 1, 4, 1, 3, 3, 'Tomatoes & Onions', 260000, 0, 260000, 0, 'No', 2, 130000, '1', NULL),
(43, '2024-04-30 06:34:18', '2024-05-07 03:48:57', 1, 4, 1, 3, 3, 'Mineral water (cartons)', 45000, 45000, 0, 100, 'Yes', 1, 45000, '1', 'Gave Farida full amount'),
(44, '2024-04-30 06:34:18', '2024-04-30 09:07:46', 1, 4, 1, 2, 2, 'Soda (Crates)', 100000, 0, 100000, 0, 'No', 5, 20000, '1', NULL),
(46, '2024-04-30 06:34:18', '2024-05-01 23:17:48', 1, 4, 1, 1, 1, 'Catering Services', 1000000, 500000, 500000, 50, 'No', 1, 1000000, '1', 'Paid mama zayi deposit 500k on mtn mobile money.'),
(48, '2024-04-30 06:35:12', '2024-05-02 08:45:40', 1, 5, 1, 3, 3, 'Tents', 800000, 800000, 0, 100, 'Yes', 8, 100000, '1', NULL),
(49, '2024-04-30 06:35:12', '2024-05-02 08:46:02', 1, 5, 1, 3, 3, 'Plastics chairs', 200000, 200000, 0, 100, 'Yes', 400, 500, '1', NULL),
(50, '2024-04-30 06:35:12', '2024-05-02 08:48:05', 1, 5, 1, 3, 3, 'Decoration', 700000, 0, 700000, 0, 'No', 1, 700000, '1', NULL),
(51, '2024-04-30 06:35:12', '2024-05-02 01:33:27', 1, 5, 1, 3, 3, 'Cake', 600000, 300000, 300000, 50, 'No', 1, 600000, '1', 'Paid hamdan 300k mobile money'),
(52, '2024-04-30 06:35:53', '2024-05-02 10:05:16', 1, 6, 1, 3, 3, 'Radio', 400000, 200000, 200000, 50, 'No', 1, 400000, '1', 'Paid radio 50%'),
(53, '2024-04-30 06:35:53', '2024-04-30 09:09:13', 1, 6, 1, 2, 2, 'MC', 200000, 0, 200000, 0, 'No', 1, 200000, '1', NULL),
(54, '2024-04-30 06:35:53', '2024-05-05 01:37:04', 1, 6, 1, 3, 3, 'Video coverage & Photos', 700000, 400000, 300000, 57, 'No', 1, 700000, '1', 'Paid talik media 400k as part of full coverage of whole ceremony.'),
(55, '2024-04-30 06:35:53', '2024-05-04 06:54:27', 1, 6, 1, 3, 3, 'Invitation cards', 250000, 250000, 0, 100, 'Yes', 500, 500, '1', NULL),
(56, '2024-04-30 06:35:53', '2024-04-30 09:09:18', 1, 6, 1, 2, 2, 'Miscellaneous', 1000000, 0, 1000000, 0, 'No', 1, 1000000, '1', NULL),
(57, '2024-04-30 06:36:34', '2024-04-30 19:03:10', 1, 7, 1, 2, 5, 'Sand', 80000, 80000, 0, 100, 'Yes', 1, 80000, '1', NULL),
(58, '2024-04-30 06:36:34', '2024-04-30 19:33:06', 1, 7, 1, 2, 5, 'Breaks', 140000, 140000, 0, 100, 'Yes', 1, 140000, '1', NULL),
(59, '2024-04-30 06:36:34', '2024-04-30 09:09:56', 1, 7, 1, 2, 2, 'Cement', 204000, 204000, 0, 100, 'Yes', 6, 34000, '1', NULL),
(60, '2024-04-30 06:36:34', '2024-04-30 09:09:56', 1, 7, 1, 2, 2, 'Builders', 120000, 120000, 0, 100, 'Yes', 1, 120000, '1', NULL),
(61, '2024-05-01 15:23:42', '2024-05-07 02:42:09', 1, 1, 1, 3, 3, 'Transport (Canter)', 1000000, 600000, 400000, 60, 'No', 1, 1000000, '1', 'Paid mwesige of canter 600k'),
(62, '2024-05-01 15:25:07', '2024-05-05 12:23:12', 1, 1, 1, 3, 3, 'Ebibbo', 300000, 300000, 0, 100, 'Yes', 30, 10000, '1', 'Gave money to dada Farida'),
(63, '2024-05-04 00:28:41', '2024-05-04 00:28:41', 1, 7, 1, 3, 3, 'Painting', 250000, 250000, 0, 100, 'Yes', 1, 250000, 'No', NULL),
(64, '2024-05-05 01:54:23', '2024-05-05 13:48:58', 1, 1, 1, 5, 5, 'Gifts for ababuuza', 500000, 500000, 0, 100, 'Yes', 1, 500000, 'No', 'Bought gifts 🎁 for sengas, brothers, sisters, kids (5 groups)'),
(65, '2024-05-05 10:35:51', '2024-05-05 12:33:42', 1, 1, 1, 3, 3, 'Tea Leaves', 25000, 25000, 0, 100, 'Yes', 1, 25000, 'No', 'Gave money to dada Farida'),
(66, '2024-05-05 10:36:09', '2024-05-05 12:24:23', 1, 1, 1, 3, 3, 'Matchbox', 65000, 65000, 0, 100, 'Yes', 1, 65000, 'No', 'Gave money to dada Farida'),
(67, '2024-05-05 10:37:50', '2024-05-05 21:36:08', 1, 1, 1, 3, 3, 'Mineral water', 45000, 45000, 0, 100, 'Yes', 10, 4500, 'No', 'Gave money to Farida'),
(68, '2024-05-05 10:41:07', '2024-05-05 12:25:15', 1, 1, 1, 3, 3, 'Salt', 43000, 43000, 0, 100, 'Yes', 2, 21500, 'No', 'Gave money to dada Farida'),
(69, '2024-05-06 04:00:39', '2024-05-06 04:00:39', 1, 6, 1, 3, 3, 'Cultural dancers', 150000, 50000, 100000, 33, 'No', 1, 150000, 'No', 'Paid 50k to kikiibi people'),
(70, '2024-05-06 08:08:15', '2024-05-06 08:08:15', 1, 1, 1, 3, 3, 'Nikkah & Marriage certificate', 200000, 200000, 0, 100, 'Yes', 1, 200000, 'No', 'Paid Sheik Ismail 200k'),
(71, '2024-05-08 11:00:36', '2024-05-08 11:00:36', 1, 8, 1, 2, 2, 'Bikwara', 10000, 50000, -40000, 500, 'Yes', 1, 10000, NULL, 'Purchased'),
(72, '2024-05-08 11:01:30', '2024-05-08 11:01:30', 1, 8, 1, 2, 2, 'Rice', 80000, 80000, 0, 100, 'Yes', 1, 80000, NULL, 'Purchased 25KG rice bag');

-- --------------------------------------------------------

--
-- Table structure for table `budget_item_categories`
--

CREATE TABLE `budget_item_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `budget_program_id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `target_amount` bigint(20) DEFAULT NULL,
  `invested_amount` bigint(20) DEFAULT NULL,
  `balance` bigint(20) DEFAULT NULL,
  `percentage_done` bigint(20) DEFAULT NULL,
  `is_complete` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `budget_item_categories`
--

INSERT INTO `budget_item_categories` (`id`, `created_at`, `updated_at`, `budget_program_id`, `company_id`, `name`, `target_amount`, `invested_amount`, `balance`, `percentage_done`, `is_complete`) VALUES
(1, '2024-04-29 04:45:28', '2024-05-05 23:26:20', 1, 1, 'Dowery', 9950000, 7570000, 2380000, 76, 'Yes'),
(2, '2024-04-29 04:45:44', '2024-05-05 23:26:20', 1, 1, 'Bride', 2670000, 2250000, 420000, 84, 'No'),
(3, '2024-04-29 04:46:00', '2024-05-05 23:26:20', 1, 1, 'Bridegroom', 300000, 200000, 100000, 67, 'No'),
(4, '2024-04-29 04:46:14', '2024-05-05 23:26:20', 1, 1, 'Reception', 5242000, 3382000, 1860000, 65, 'No'),
(5, '2024-04-29 04:46:50', '2024-05-05 23:26:20', 1, 1, 'Pavilion', 2300000, 1300000, 1000000, 57, 'No'),
(6, '2024-04-29 04:46:59', '2024-05-05 23:26:20', 1, 1, 'Entertainment', 2700000, 900000, 1800000, 33, 'No'),
(7, '2024-04-29 04:47:07', '2024-05-05 23:26:20', 1, 1, 'Hom Renovation', 794000, 794000, 0, 100, 'No'),
(8, '2024-05-08 10:59:24', '2024-05-08 11:00:03', 1, 1, 'Home Expenses', 90000, 130000, -40000, 144, 'No');

-- --------------------------------------------------------

--
-- Table structure for table `budget_programs`
--

CREATE TABLE `budget_programs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `total_collected` bigint(20) DEFAULT '0',
  `total_expected` bigint(20) DEFAULT '0',
  `total_in_pledge` bigint(20) DEFAULT '0',
  `budget_total` bigint(20) DEFAULT '0',
  `budget_spent` bigint(20) DEFAULT '0',
  `budget_balance` bigint(20) DEFAULT '0',
  `string` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `budget_programs`
--

INSERT INTO `budget_programs` (`id`, `created_at`, `updated_at`, `company_id`, `name`, `total_collected`, `total_expected`, `total_in_pledge`, `budget_total`, `budget_spent`, `budget_balance`, `string`, `status`) VALUES
(1, '2024-04-28 18:42:05', '2024-04-28 18:42:05', 1, 'Muhindo Mubaraka wedding', 0, 0, 0, 0, 0, 0, 'Active', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `code_gens`
--

CREATE TABLE `code_gens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `table_name` text COLLATE utf8mb4_unicode_ci,
  `end_point` text COLLATE utf8mb4_unicode_ci,
  `other_1` text COLLATE utf8mb4_unicode_ci,
  `other_2` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `code_gens`
--

INSERT INTO `code_gens` (`id`, `created_at`, `updated_at`, `table_name`, `end_point`, `other_1`, `other_2`) VALUES
(1, '2024-02-09 15:13:22', '2024-02-09 15:13:22', 'financial_periods', 'api/FinancialYear', 'FinancialYear', NULL),
(2, '2024-04-04 19:30:05', '2024-04-04 19:30:05', 'financial_reports', 'api/FinancialReport', 'FinancialReport', NULL),
(3, '2024-04-30 14:23:14', '2024-04-30 14:23:14', 'contribution_records', 'api/ContributionRecord', 'ContributionRecordModel', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `owner_id` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` text COLLATE utf8mb4_unicode_ci,
  `logo` text COLLATE utf8mb4_unicode_ci,
  `website` text COLLATE utf8mb4_unicode_ci,
  `about` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license_expire` date DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `phone_number` text COLLATE utf8mb4_unicode_ci,
  `phone_number_2` text COLLATE utf8mb4_unicode_ci,
  `pobox` text COLLATE utf8mb4_unicode_ci,
  `color` text COLLATE utf8mb4_unicode_ci,
  `slogan` text COLLATE utf8mb4_unicode_ci,
  `facebook` text COLLATE utf8mb4_unicode_ci,
  `twitter` text COLLATE utf8mb4_unicode_ci,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'USD',
  `settings_worker_can_create_stock_item` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Yes',
  `settings_worker_can_create_stock_record` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Yes',
  `settings_worker_can_create_stock_category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Yes',
  `settings_worker_can_view_balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Yes',
  `settings_worker_can_view_stats` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `created_at`, `updated_at`, `owner_id`, `name`, `email`, `logo`, `website`, `about`, `status`, `license_expire`, `address`, `phone_number`, `phone_number_2`, `pobox`, `color`, `slogan`, `facebook`, `twitter`, `currency`, `settings_worker_can_create_stock_item`, `settings_worker_can_create_stock_record`, `settings_worker_can_create_stock_category`, `settings_worker_can_view_balance`, `settings_worker_can_view_stats`) VALUES
(1, '2023-12-28 14:49:38', '2024-01-06 15:20:58', 2, 'Company One', 'folohofaf@mailinator.com', 'images/LOGO.jpeg', 'https://www.nene.in', 'Ea iure repellendus', 'Voluptatum veritatis', '2023-12-28', 'Ut rem vitae ipsum', '+1 (186) 934-7611', '+1 (347) 995-1221', 'P.O. Box 17', '#000000', 'Cumque ab vero tempo', 'https://www.fujif.tv', 'https://www.fymeboc.org', 'UGX', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(2, '2023-12-28 15:29:14', '2024-04-03 08:10:09', 3, 'Company Two', 'tenifeqipy@mailinator.com', 'images/91be1d1a-163f-4b1d-8409-0203d6b7e129.jpeg', 'https://www.rodatysagit.ws', 'Modi et odio qui qui', 'Nostrud voluptatem', '2023-12-28', 'Pariatur Necessitat', '+1 (966) 873-8174', '+1 (672) 165-9854', 'PO Box 774', '#000000', 'Et esse quidem quib', 'https://www.cuqyrevasomiq.com', 'https://www.zose.ca', 'USD', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(3, '2024-01-07 15:09:09', '2024-01-07 15:09:09', 6, 'Muhindo and Sons', 'mubahood1@gmail.com', NULL, NULL, NULL, 'Active', '2025-01-07', NULL, '+256783204665', NULL, NULL, NULL, NULL, NULL, NULL, 'UGX', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(4, '2024-01-07 15:13:30', '2024-01-07 15:13:30', 7, 'Muhindo and Sons', 'mubahood2@gmail.com', NULL, NULL, NULL, 'Active', '2025-01-07', NULL, '+256783204665', NULL, NULL, NULL, NULL, NULL, NULL, 'UGX', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(5, '2024-01-07 15:27:56', '2024-01-07 15:27:56', 8, 'Muhindo and Sons', 'mubahood5@gmail.com', NULL, NULL, NULL, 'Active', '2025-01-07', NULL, '+256783204665', NULL, NULL, NULL, NULL, NULL, NULL, 'UGX', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(6, '2024-01-07 15:29:39', '2024-01-07 15:29:39', 9, 'Muhindo and Sons', 'mubahood6@gmail.com', NULL, NULL, NULL, 'Active', '2025-01-07', NULL, '+256783204665', NULL, NULL, NULL, NULL, NULL, NULL, 'UGX', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(7, '2024-01-08 14:09:31', '2024-01-08 14:09:31', 10, 'Muhindo and Sons', 'mubahood360@gmail.com', NULL, NULL, NULL, 'Active', '2025-01-08', NULL, '+256783204665', NULL, NULL, NULL, NULL, NULL, NULL, 'UGX', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(8, '2024-04-06 05:35:15', '2024-04-06 05:35:15', 15, 'Lucias Concepts', 'ndemarupatricia@gmail.com', NULL, NULL, NULL, 'Active', '2025-04-06', NULL, '0779889965', NULL, NULL, NULL, NULL, NULL, NULL, 'UGX', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(9, '2024-04-08 05:49:29', '2024-04-08 05:49:29', 16, 'Dinesh', 'adeb502070@gmail.com', NULL, NULL, NULL, 'Active', '2025-04-08', NULL, '30020060', NULL, NULL, NULL, NULL, NULL, NULL, 'Qtr', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(10, '2024-04-14 05:30:33', '2024-04-14 05:30:33', 17, 'Test company', 'johnson@gmail.com', NULL, NULL, NULL, 'Active', '2025-04-14', NULL, '0706638499', NULL, NULL, NULL, NULL, NULL, NULL, 'UGX', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes'),
(11, '2024-05-07 00:12:57', '2024-05-07 00:12:57', 17, 'justtesting', 'sumayahswaib@gmail.com', NULL, NULL, NULL, 'Active', '2025-05-07', NULL, '0755906818', NULL, NULL, NULL, NULL, NULL, NULL, 'ugx', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `contribution_records`
--

CREATE TABLE `contribution_records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `budget_program_id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `treasurer_id` bigint(20) DEFAULT NULL,
  `chaned_by_id` bigint(20) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `amount` bigint(20) DEFAULT '0',
  `paid_amount` bigint(20) DEFAULT '0',
  `not_paid_amount` bigint(20) DEFAULT '0',
  `fully_paid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'No',
  `custom_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_paid_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Family'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contribution_records`
--

INSERT INTO `contribution_records` (`id`, `created_at`, `updated_at`, `budget_program_id`, `company_id`, `treasurer_id`, `chaned_by_id`, `name`, `amount`, `paid_amount`, `not_paid_amount`, `fully_paid`, `custom_amount`, `custom_paid_amount`, `category_id`) VALUES
(3, '2024-04-28 20:24:14', '2024-05-06 09:32:47', 1, 1, 5, 5, 'Halsalim', 30000, 30000, 0, 'Yes', NULL, NULL, 'Family'),
(4, '2024-04-28 20:25:25', '2024-05-01 09:27:42', 1, 1, 1, 2, 'Mwajuma Jim', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(5, '2024-04-28 20:25:59', '2024-05-06 12:59:02', 1, 1, 2, 5, 'Shafi Magalo', 30000, 30000, 0, 'Yes', NULL, NULL, 'Family'),
(6, '2024-04-28 20:26:49', '2024-04-28 20:26:49', 1, 1, 15, 2, 'Mama Yazid', 50000, 0, 50000, 'No', NULL, NULL, 'Family'),
(7, '2024-04-28 20:27:34', '2024-04-28 20:27:34', 1, 1, 15, 2, 'Kaka Malik', 50000, 0, 50000, 'No', NULL, NULL, 'Family'),
(8, '2024-04-28 20:28:04', '2024-04-30 05:32:00', 1, 1, 1, 2, 'Dada Anjane', 100000, 100000, 0, 'Yes', NULL, NULL, 'Family'),
(9, '2024-04-30 05:31:20', '2024-04-30 05:34:12', 1, 1, 1, 2, 'Muhidin Mutheke', 100000, 100000, 0, 'Yes', NULL, NULL, 'Family'),
(10, '2024-04-28 20:28:55', '2024-05-05 09:31:42', 1, 1, 15, 5, 'Ramzo Mutheke', 100000, 100000, 0, 'Yes', NULL, NULL, 'Family'),
(11, '2024-04-28 20:29:13', '2024-05-02 12:53:34', 1, 1, 3, 3, 'Razaka Mutheke', 15000, 15000, 0, 'Yes', NULL, NULL, 'Family'),
(12, '2024-04-28 20:29:31', '2024-04-28 20:30:02', 1, 1, 15, 2, 'Swaleh Mutheke', 50000, 0, 50000, 'No', NULL, NULL, 'Family'),
(13, '2024-04-28 20:30:30', '2024-04-28 21:13:34', 1, 1, 15, 2, 'Mama Mary', 50000, 10000, 40000, 'No', NULL, NULL, 'Family'),
(14, '2024-04-28 20:30:54', '2024-05-05 09:31:08', 1, 1, 2, 3, 'Babu Ssali', 200000, 50000, 150000, 'No', NULL, NULL, 'Family'),
(15, '2024-04-28 20:31:15', '2024-04-28 20:31:15', 1, 1, 15, 2, 'Bast Muhidin', 50000, 0, 50000, 'No', NULL, NULL, 'Family'),
(17, '2024-04-28 21:05:30', '2024-04-28 21:22:19', 1, 1, 2, 2, 'Babu Kasim', 100000, 100000, 0, 'Yes', NULL, NULL, 'Family'),
(18, '2024-04-28 21:06:07', '2024-04-28 21:09:05', 1, 1, 15, 2, 'Mama Takiyu', 10000, 10000, 0, 'Yes', NULL, NULL, 'Family'),
(19, '2024-04-28 21:09:51', '2024-05-03 11:33:55', 1, 1, 3, 3, 'Mama Malik Kasim', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(20, '2024-04-28 21:10:34', '2024-05-05 09:44:55', 1, 1, 15, 3, 'Mama Hilal', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(21, '2024-04-28 21:11:01', '2024-04-28 21:11:01', 1, 1, 15, 2, 'Mama Nasuru', 15000, 15000, 0, 'Yes', NULL, NULL, 'Family'),
(22, '2024-04-28 21:11:36', '2024-04-28 21:11:36', 1, 1, 15, 2, 'Mama Ashiraf Chabo', 40000, 40000, 0, 'Yes', NULL, NULL, 'Family'),
(23, '2024-04-28 21:11:54', '2024-04-28 21:11:54', 1, 1, 15, 2, 'MRS KABALO', 5000, 5000, 0, 'Yes', NULL, NULL, 'Family'),
(24, '2024-04-28 21:12:20', '2024-05-03 11:13:28', 1, 1, 3, 3, 'Shamim Raja', 30000, 30000, 0, 'Yes', NULL, NULL, 'Family'),
(25, '2024-04-28 21:12:40', '2024-04-28 21:20:12', 1, 1, 15, 2, 'Papa Kericho', 30000, 0, 30000, 'No', NULL, NULL, 'Family'),
(26, '2024-04-28 21:14:31', '2024-04-28 21:15:29', 1, 1, 15, 2, 'Aunt Batuli', 50000, 10000, 40000, 'No', NULL, NULL, 'Family'),
(27, '2024-04-28 21:16:13', '2024-04-28 21:16:13', 1, 1, 15, 2, 'Mama Farahati', 50000, 10000, 40000, 'No', NULL, NULL, 'Family'),
(28, '2024-04-28 21:16:38', '2024-05-05 15:06:53', 1, 1, 15, 5, 'Nyabahasa Kaserengethe', 20000, 10000, 10000, 'No', NULL, NULL, 'Friend'),
(29, '2024-04-28 21:16:54', '2024-04-28 21:16:54', 1, 1, 15, 2, 'Siyama Kericho', 5000, 5000, 0, 'Yes', NULL, NULL, 'Family'),
(30, '2024-04-28 21:17:23', '2024-04-28 21:17:23', 1, 1, 15, 2, 'Mrs. Moris Mutheke', 30000, 30000, 0, 'Yes', NULL, NULL, 'Family'),
(31, '2024-04-28 21:17:41', '2024-04-28 21:17:41', 1, 1, 15, 2, 'Muajabu Kamama', 30000, 30000, 0, 'Yes', NULL, NULL, 'Family'),
(32, '2024-04-28 21:18:11', '2024-05-06 00:26:38', 1, 1, 3, 3, 'Papa Tamimu', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(33, '2024-04-28 21:18:45', '2024-05-05 09:50:53', 1, 1, 15, 3, 'Dada Farida', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(34, '2024-04-28 21:34:37', '2024-04-28 21:34:42', 1, 1, 1, 2, 'Arafat Kalera', 30000, 0, 30000, 'No', NULL, NULL, 'Friend'),
(35, '2024-04-28 21:35:38', '2024-04-28 21:35:44', 1, 1, 2, 2, 'Abdul Kisugu', 10000, 0, 10000, 'No', NULL, NULL, 'Friend'),
(36, '2024-04-28 21:36:22', '2024-04-28 21:36:37', 1, 1, 5, 2, 'Rashida Head girl', 120000, 120000, 0, 'Yes', NULL, NULL, 'Friend'),
(37, '2024-04-28 21:37:58', '2024-04-28 21:38:04', 1, 1, 1, 2, 'Joslyn K', 50000, 50000, 0, 'Yes', NULL, NULL, 'Friend'),
(38, '2024-04-28 21:38:57', '2024-04-28 21:38:57', 1, 1, 2, 2, 'Mr & Mr Isingoma Landus', 40000, 0, 40000, 'No', NULL, NULL, 'Friend'),
(39, '2024-04-28 21:39:29', '2024-04-28 21:39:29', 1, 1, 5, 2, 'Ambrose', 55000, 55000, 0, 'Yes', NULL, NULL, 'Friend'),
(40, '2024-04-28 21:39:56', '2024-05-03 10:42:49', 1, 1, 3, 3, 'Mwajuma Uncle', 30000, 30000, 0, 'Yes', NULL, NULL, 'MTK'),
(41, '2024-04-28 21:40:31', '2024-04-28 21:40:31', 1, 1, 1, 2, 'Sumaya Swaib', 100000, 100000, 0, 'Yes', NULL, NULL, 'Friend'),
(42, '2024-04-28 21:40:48', '2024-04-28 21:40:48', 1, 1, 2, 2, 'Ajiba', 10000, 0, 10000, 'No', NULL, NULL, 'Friend'),
(43, '2024-04-28 21:41:35', '2024-04-28 21:41:35', 1, 1, 2, 2, 'Kafufu Salma', 100000, 0, 100000, 'No', NULL, NULL, 'Friend'),
(44, '2024-04-28 21:41:59', '2024-05-02 01:48:03', 1, 1, 3, 3, 'Shantale & Family', 300000, 300000, 0, 'Yes', NULL, NULL, 'MTK'),
(45, '2024-04-28 21:43:08', '2024-04-30 13:40:10', 1, 1, 2, 1, 'Musa', 200000, 200000, 0, 'Yes', NULL, NULL, 'Friend'),
(46, '2024-04-28 21:43:24', '2024-04-28 21:43:24', 1, 1, 2, 2, 'Adra Rafik', 50000, 0, 50000, 'No', NULL, NULL, 'Friend'),
(47, '2024-04-28 21:43:43', '2024-04-29 09:12:37', 1, 1, 5, 2, 'Naggayi Claire', 20000, 20000, 0, 'Yes', NULL, NULL, 'Friend'),
(48, '2024-04-28 21:44:46', '2024-04-28 21:44:46', 1, 1, 5, 2, 'Fauzia', 20000, 20000, 0, 'Yes', NULL, NULL, 'Friend'),
(49, '2024-04-28 21:45:40', '2024-04-30 13:39:33', 1, 1, 5, 1, 'Humiliheri', 35000, 35000, 0, 'Yes', NULL, NULL, 'Friend'),
(50, '2024-04-28 21:45:57', '2024-04-28 21:45:57', 1, 1, 2, 2, 'Sharp', 30000, 0, 30000, 'No', NULL, NULL, 'Friend'),
(51, '2024-04-28 21:46:44', '2024-04-28 21:46:44', 1, 1, 2, 2, 'Mr. & Mrs. Everest Designs', 50000, 0, 50000, 'No', NULL, NULL, 'Friend'),
(52, '2024-04-28 21:47:32', '2024-04-28 21:47:32', 1, 1, 5, 2, 'Friends Group collection', 35000, 0, 35000, 'No', NULL, NULL, 'Friend'),
(53, '2024-04-28 21:48:01', '2024-04-28 21:48:01', 1, 1, 5, 2, 'Contractor', 46000, 46000, 0, 'Yes', NULL, NULL, 'Friend'),
(54, '2024-04-28 21:48:48', '2024-05-01 01:00:26', 1, 1, 5, 2, 'Muhindo Sam', 60000, 60000, 0, 'Yes', NULL, NULL, 'Friend'),
(55, '2024-04-28 21:49:10', '2024-04-28 21:49:10', 1, 1, 5, 2, 'Mukhiwa Khamis', 15000, 15000, 0, 'Yes', NULL, NULL, 'Friend'),
(56, '2024-04-28 21:49:26', '2024-04-28 21:49:26', 1, 1, 5, 2, 'Sera', 50000, 50000, 0, 'Yes', NULL, NULL, 'Friend'),
(57, '2024-04-28 21:50:31', '2024-05-06 08:56:01', 1, 1, 5, 5, 'Bagheni Herizon', 50000, 50000, 0, 'Yes', NULL, NULL, 'Friend'),
(58, '2024-04-28 21:50:57', '2024-04-28 21:50:57', 1, 1, 2, 2, 'Kalule and Family', 200000, 0, 200000, 'No', NULL, NULL, 'Friend'),
(59, '2024-04-28 21:51:30', '2024-05-03 10:39:35', 1, 1, 5, 2, 'Mko Yasin', 20000, 20000, 0, 'Yes', NULL, NULL, 'Friend'),
(60, '2024-04-28 21:51:54', '2024-04-29 06:21:31', 1, 1, 5, 2, 'Nya Fahad', 50000, 50000, 0, 'Yes', NULL, NULL, 'MTK'),
(61, '2024-04-28 21:52:50', '2024-04-29 07:28:33', 1, 1, 5, 2, 'Nuswaiba', 50000, 50000, 0, 'Yes', NULL, NULL, 'Friend'),
(62, '2024-04-28 21:53:27', '2024-05-01 03:03:38', 1, 1, 1, 2, 'Biira Harriet Mutheke', 50000, 50000, 0, 'Yes', NULL, NULL, 'MTK'),
(63, '2024-04-28 21:54:30', '2024-04-29 06:21:16', 1, 1, 2, 2, 'Bwambale Jockim MTK', 50000, 0, 50000, 'No', NULL, NULL, 'MTK'),
(64, '2024-04-28 21:54:50', '2024-04-30 13:56:04', 1, 1, 1, 5, 'Muadhi Kisando', 200000, 200000, 0, 'Yes', NULL, NULL, 'Friend'),
(65, '2024-04-28 23:41:54', '2024-05-02 22:40:33', 1, 1, 2, 3, 'Dada Zubeda', 15000, 15000, 0, 'Yes', NULL, NULL, 'Family'),
(66, '2024-04-29 05:55:19', '2024-04-29 05:55:19', 1, 1, 2, 2, 'Twalib Jim', 50000, 0, 50000, 'No', NULL, NULL, 'Family'),
(67, '2024-04-29 05:57:31', '2024-05-03 00:42:26', 1, 1, 1, 3, 'Mubaraka Bannada', 100000, 100000, 0, 'Yes', NULL, NULL, 'Friend'),
(68, '2024-04-29 06:02:15', '2024-04-29 06:02:15', 1, 1, 1, 2, 'Prof. Ssendawula', 70000, 70000, 0, 'Yes', NULL, NULL, 'Friend'),
(69, '2024-04-29 06:22:33', '2024-04-29 06:22:33', 1, 1, 1, 2, 'Chris', 20000, 20000, 0, 'Yes', NULL, NULL, 'MTK'),
(70, '2024-04-29 06:22:46', '2024-04-29 06:23:37', 1, 1, 1, 2, 'Amon', 10000, 10000, 0, 'Yes', NULL, NULL, 'MTK'),
(71, '2024-04-29 06:53:23', '2024-04-29 06:54:45', 1, 1, 1, 2, 'Farahat Kericho', 50000, 0, 50000, 'No', NULL, NULL, 'Family'),
(72, '2024-04-29 14:37:51', '2024-04-29 14:40:26', 1, 1, 1, 2, 'Faishal Kasim', 100000, 100000, 0, 'Yes', NULL, NULL, 'Family'),
(73, '2024-04-29 14:57:44', '2024-04-29 14:57:44', 1, 1, 2, 2, 'Sharhabil Amo', 100000, 100000, 0, 'Yes', NULL, NULL, 'Family'),
(74, '2024-04-29 15:06:32', '2024-04-29 15:15:24', 1, 1, 2, 2, 'Sidrat Kericho', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(75, '2024-04-30 03:29:07', '2024-04-30 03:29:32', 1, 1, 2, 2, 'Mama Halid', 20000, 20000, 0, 'Yes', NULL, NULL, 'Family'),
(77, '2024-04-30 12:41:30', '2024-04-30 12:41:30', 1, 1, 1, 2, 'Faika Kericho', 70000, 70000, 0, 'Yes', NULL, NULL, 'Family'),
(78, '2024-04-30 14:06:08', '2024-05-02 22:40:03', 1, 1, 3, 3, 'Biira Christine', 50000, 50000, 0, 'Yes', NULL, NULL, 'Friend'),
(79, '2024-04-30 14:07:28', '2024-04-30 14:07:28', 1, 1, 5, 2, 'Mama Albert (Viola)', 50000, 50000, 0, 'Yes', NULL, NULL, 'Friend'),
(80, '2024-04-30 15:58:02', '2024-04-30 15:58:02', 1, 1, 1, 5, 'Timothy Surveyor', 50000, 50000, 0, 'Yes', NULL, NULL, 'Friend'),
(81, '2024-05-01 04:34:51', '2024-05-01 04:34:51', 1, 1, 5, 5, 'Rachel Kisaakye', 100000, 100000, 0, 'Yes', NULL, NULL, 'Friend'),
(82, '2024-05-01 04:56:17', '2024-05-02 22:39:30', 1, 1, 1, 3, 'Ahebwa Ibrahim Gomba', 50000, 50000, 0, 'Yes', NULL, NULL, 'Friend'),
(83, '2024-05-01 07:41:16', '2024-05-01 07:44:07', 1, 1, 1, 1, 'Peter Kwesiga', 65000, 65000, 0, 'Yes', NULL, NULL, 'Friend'),
(84, '2024-05-01 09:30:42', '2024-05-01 09:30:43', 1, 1, 1, 1, 'Mumbejja Jim', 30000, 30000, 0, 'Yes', NULL, NULL, 'Family'),
(85, '2024-05-01 11:54:30', '2024-05-01 11:54:35', 1, 1, 1, 1, 'Kusain Kalule', 100000, 100000, 0, 'Yes', NULL, NULL, 'Friend'),
(86, '2024-05-01 13:04:47', '2024-05-01 13:04:48', 1, 1, 1, 1, 'Mr. Ivan - UK', 460000, 460000, 0, 'Yes', NULL, NULL, 'Friend'),
(87, '2024-05-01 22:54:37', '2024-05-01 22:54:37', 1, 1, 1, 1, 'Samuel Ocen', 100000, 100000, 0, 'Yes', NULL, NULL, 'Friend'),
(88, '2024-05-02 00:47:06', '2024-05-02 00:47:06', 1, 1, 3, 3, 'Mama Sofi Kabangire', 20000, 20000, 0, 'Yes', NULL, NULL, 'Family'),
(89, '2024-05-02 01:44:56', '2024-05-02 22:39:07', 1, 1, 2, 3, 'Kaka Hasan Rauben', 20000, 20000, 0, 'Yes', NULL, NULL, 'Family'),
(90, '2024-05-02 01:45:44', '2024-05-02 22:38:59', 1, 1, 2, 3, 'Kaka Walji', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(91, '2024-05-02 03:58:52', '2024-05-02 03:58:52', 1, 1, 3, 3, 'Brother Wilfred', 80000, 80000, 0, 'Yes', NULL, NULL, 'MTK'),
(92, '2024-05-02 08:06:30', '2024-05-02 22:38:47', 1, 1, 3, 3, 'Hon. Fatuma Kasim', 100000, 100000, 0, 'Yes', NULL, NULL, 'Family'),
(93, '2024-05-02 08:08:29', '2024-05-02 22:38:39', 1, 1, 2, 3, 'Aunt Asha', 30000, 30000, 0, 'Yes', NULL, NULL, 'Family'),
(94, '2024-05-02 10:28:54', '2024-05-02 22:38:27', 1, 1, 3, 3, 'Aisha Ali', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(95, '2024-05-02 11:15:50', '2024-05-02 11:16:11', 1, 1, 3, 3, 'Taufik Naser', 50000, 0, 50000, 'No', NULL, NULL, 'Friend'),
(96, '2024-05-02 20:51:09', '2024-05-02 21:57:54', 1, 1, 2, 3, 'Sulaiman Kabalo', 20000, 20000, 0, 'Yes', NULL, NULL, 'Family'),
(97, '2024-05-02 20:51:59', '2024-05-02 21:59:42', 1, 1, 2, 3, 'Mariam Kasim', 40000, 40000, 0, 'Yes', NULL, NULL, 'Family'),
(98, '2024-05-03 03:58:34', '2024-05-03 03:58:34', 1, 1, 3, 3, 'Mama Nya Jafali', 50000, 50000, 0, 'Yes', NULL, NULL, 'MTK'),
(99, '2024-05-03 07:06:28', '2024-05-03 07:06:28', 1, 1, 3, 3, 'Mama Nya Kyamuhangawa', 20000, 20000, 0, 'Yes', NULL, NULL, 'MTK'),
(100, '2024-05-03 08:25:51', '2024-05-04 15:01:34', 1, 1, 3, 5, 'Masika Roset', 20000, 20000, 0, 'Yes', NULL, NULL, 'MTK'),
(101, '2024-05-03 11:14:48', '2024-05-03 11:14:48', 1, 1, 2, 3, 'Sarah Mwanvua', 20000, 20000, 0, 'Yes', NULL, NULL, 'Family'),
(102, '2024-05-03 11:19:22', '2024-05-03 11:19:22', 1, 1, 5, 5, 'Twalha imran', 15000, 0, 15000, 'No', NULL, NULL, 'Friend'),
(103, '2024-05-03 11:44:44', '2024-05-03 11:44:44', 1, 1, 3, 3, 'Sungali Helena', 10000, 10000, 0, 'Yes', NULL, NULL, 'MTK'),
(104, '2024-05-04 05:23:28', '2024-05-04 05:23:28', 1, 1, 5, 5, 'Kabogoza Dalusy', 500000, 500000, 0, 'Yes', NULL, NULL, 'Family'),
(105, '2024-05-04 11:16:34', '2024-05-04 11:20:13', 1, 1, 3, 3, 'Mama Rayan', 20000, 20000, 0, 'Yes', NULL, NULL, 'MTK'),
(106, '2024-05-04 11:39:24', '2024-05-04 11:39:24', 1, 1, 3, 3, 'Zamzuchu', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(107, '2024-05-04 21:47:48', '2024-05-04 21:47:48', 1, 1, 3, 3, 'Tofail Masoud', 100000, 100000, 0, 'Yes', NULL, NULL, 'Family'),
(108, '2024-05-04 23:02:38', '2024-05-04 23:02:38', 1, 1, 1, 5, 'kaka kawaya, A physical goat worth', 500000, 500000, 0, 'Yes', NULL, NULL, 'Family'),
(109, '2024-05-05 07:17:30', '2024-05-05 07:20:15', 1, 1, 5, 5, 'Sk Jossy', 20000, 20000, 0, 'Yes', NULL, NULL, 'Friend'),
(110, '2024-05-05 07:45:45', '2024-05-05 09:50:17', 1, 1, 2, 5, 'Mama Asha Kachachu', 10000, 10000, 0, 'Yes', NULL, NULL, 'Family'),
(111, '2024-05-05 08:46:25', '2024-05-05 08:46:25', 1, 1, 3, 3, 'Mubaraka Salim', 30000, 30000, 0, 'Yes', NULL, NULL, 'Family'),
(112, '2024-05-05 08:48:48', '2024-05-05 08:48:48', 1, 1, 1, 3, 'Sister Sadress', 20000, 20000, 0, 'Yes', NULL, NULL, 'MTK'),
(113, '2024-05-05 09:11:43', '2024-05-05 09:11:43', 1, 1, 3, 3, 'Papa Kababa', 50000, 30000, 20000, 'No', NULL, NULL, 'Family'),
(114, '2024-05-05 09:29:01', '2024-05-05 09:29:01', 1, 1, 3, 5, 'Mama Faikah Mrs.Muhidin', 40000, 40000, 0, 'Yes', NULL, NULL, 'Family'),
(115, '2024-05-05 09:40:07', '2024-05-05 09:40:07', 1, 1, 1, 3, 'Nya Hunaiza', 20000, 20000, 0, 'Yes', NULL, NULL, 'MTK'),
(116, '2024-05-05 09:42:13', '2024-05-05 09:42:13', 1, 1, 3, 3, 'Mama Nya Meresi', 40000, 40000, 0, 'Yes', NULL, NULL, 'MTK'),
(117, '2024-05-05 09:49:10', '2024-05-05 09:49:10', 1, 1, 2, 5, 'Mama Mubarak Koliko', 10000, 10000, 0, 'Yes', NULL, NULL, 'Family'),
(118, '2024-05-05 09:57:07', '2024-05-05 09:58:12', 1, 1, 3, 3, 'Joshua Salyababuya', 50000, 50000, 0, 'Yes', NULL, NULL, 'MTK'),
(119, '2024-05-05 12:00:06', '2024-05-05 15:11:23', 1, 1, 3, 5, 'Shiek Ismail - Mufti', 20000, 20000, 0, 'Yes', NULL, NULL, 'Friend'),
(120, '2024-05-05 12:19:13', '2024-05-05 12:19:13', 1, 1, 3, 3, 'Ozil', 30000, 0, 30000, 'No', NULL, NULL, 'Family'),
(121, '2024-05-05 15:02:05', '2024-05-05 15:02:17', 1, 1, 3, 5, 'Haulat Salim', 5000, 5000, 0, 'Yes', NULL, NULL, 'Family'),
(122, '2024-05-05 15:02:39', '2024-05-05 15:02:39', 1, 1, 3, 5, 'Halima Salim', 5000, 5000, 0, 'Yes', NULL, NULL, 'Family'),
(123, '2024-05-05 15:03:54', '2024-05-05 15:03:54', 1, 1, 1, 5, 'Nya Badru', 20000, 0, 20000, 'No', NULL, NULL, 'Family'),
(124, '2024-05-05 15:04:54', '2024-05-05 15:04:54', 1, 1, 1, 5, 'Nya Hansa', 20000, 5000, 15000, 'No', NULL, NULL, 'Family'),
(125, '2024-05-05 15:05:48', '2024-05-05 15:05:48', 1, 1, 1, 5, 'Baba Ashraf', 15000, 15000, 0, 'Yes', NULL, NULL, 'Family'),
(126, '2024-05-05 15:06:09', '2024-05-05 15:06:09', 1, 1, 1, 5, 'Aladin', 10000, 10000, 0, 'Yes', NULL, NULL, 'Family'),
(127, '2024-05-05 15:07:10', '2024-05-05 22:01:40', 1, 1, 1, 16, 'Kabunere', 5000, 5000, 0, 'Yes', NULL, NULL, 'Friend'),
(128, '2024-05-05 15:08:18', '2024-05-05 15:08:18', 1, 1, 1, 5, 'Baba Maggie', 10000, 10000, 0, 'Yes', NULL, NULL, 'Friend'),
(129, '2024-05-05 15:09:33', '2024-05-05 15:09:33', 1, 1, 1, 5, 'Nya Fahd', 10000, 10000, 0, 'Yes', NULL, NULL, 'Friend'),
(130, '2024-05-05 17:13:28', '2024-05-05 17:13:28', 1, 1, 3, 3, 'Dada Nuru', 100000, 100000, 0, 'Yes', NULL, NULL, 'Family'),
(131, '2024-05-05 22:02:15', '2024-05-05 22:02:15', 1, 1, 3, 3, 'Mustafa Salya', 10000, 0, 10000, 'No', NULL, NULL, 'MTK'),
(132, '2024-05-06 02:24:11', '2024-05-06 02:24:11', 1, 1, 3, 3, 'Hajjati Addy Rwanda', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(133, '2024-05-06 08:54:23', '2024-05-06 08:54:23', 1, 1, 5, 5, 'Ajiba Atwiya', 10000, 10000, 0, 'Yes', NULL, NULL, 'Friend'),
(134, '2024-05-06 08:56:35', '2024-05-06 09:25:10', 1, 1, 5, 5, 'Cherotich Veni', 10000, 10000, 0, 'Yes', NULL, NULL, 'Friend'),
(135, '2024-05-06 09:02:20', '2024-05-06 09:02:20', 1, 1, 5, 5, 'Muhindo Abdunoor', 20000, 20000, 0, 'Yes', NULL, NULL, 'Friend'),
(136, '2024-05-06 10:16:22', '2024-05-06 10:16:22', 1, 1, 3, 3, 'Papa Ali', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(137, '2024-05-06 10:20:31', '2024-05-06 10:20:31', 1, 1, 3, 3, 'Chongomweru Haleem (Car+Fuel+400k)', 400000, 400000, 0, 'Yes', NULL, NULL, 'Family'),
(138, '2024-05-06 10:35:06', '2024-05-06 10:35:06', 1, 1, 3, 3, 'Jafanga', 10000, 10000, 0, 'Yes', NULL, NULL, 'MTK'),
(139, '2024-05-06 10:53:47', '2024-05-06 10:53:56', 1, 1, 3, 3, 'Mwajuma Tamim', 20000, 20000, 0, 'Yes', NULL, NULL, 'Family'),
(140, '2024-05-06 11:12:25', '2024-05-06 11:12:25', 1, 1, 3, 3, 'Ntumba Charlote', 20000, 20000, 0, 'Yes', NULL, NULL, 'Friend'),
(141, '2024-05-06 23:00:31', '2024-05-06 23:00:31', 1, 1, 3, 3, 'Galiwo Shafik', 42000, 42000, 0, 'Yes', NULL, NULL, 'Family'),
(142, '2024-05-07 01:59:38', '2024-05-07 01:59:38', 1, 1, 3, 3, 'Morgan Bitaka', 40000, 40000, 0, 'Yes', NULL, NULL, 'MTK'),
(143, '2024-05-07 03:34:07', '2024-05-07 03:34:07', 1, 1, 3, 3, 'Shafi Hakim S.A', 50000, 50000, 0, 'Yes', NULL, NULL, 'Family'),
(144, '2024-05-07 03:46:02', '2024-05-31 06:27:32', 1, 1, 2, 5, 'Masika Hindu', 40000, 40000, 0, 'Yes', NULL, NULL, 'Family');

-- --------------------------------------------------------

--
-- Table structure for table `data_exports`
--

CREATE TABLE `data_exports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `created_by_id` bigint(20) DEFAULT NULL,
  `treasurer_id` bigint(20) DEFAULT NULL,
  `category_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameter_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameter_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameter_3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameter_4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_exports`
--

INSERT INTO `data_exports` (`id`, `created_at`, `updated_at`, `company_id`, `created_by_id`, `treasurer_id`, `category_id`, `parameter_1`, `parameter_2`, `parameter_3`, `parameter_4`) VALUES
(1, '2024-04-28 22:05:20', '2024-04-28 22:05:37', 1, 2, NULL, 'Friend', NULL, NULL, NULL, NULL),
(2, '2024-04-28 22:05:25', '2024-04-28 23:00:43', 1, 2, NULL, 'Family', NULL, NULL, NULL, NULL),
(3, '2024-04-29 06:23:01', '2024-04-29 06:23:01', 1, 2, NULL, 'MTK', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `financial_categories`
--

CREATE TABLE `financial_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `total_income` bigint(20) DEFAULT NULL,
  `total_expense` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financial_categories`
--

INSERT INTO `financial_categories` (`id`, `created_at`, `updated_at`, `company_id`, `total_income`, `total_expense`, `name`, `description`) VALUES
(1, '2024-04-01 11:06:57', '2024-04-01 11:06:57', 1, NULL, NULL, 'Category 1', 'some data'),
(2, '2024-04-01 11:09:38', '2024-04-01 11:09:38', 1, NULL, NULL, 'Category 3', 'some data'),
(3, '2024-04-01 11:09:43', '2024-04-01 11:09:43', 1, NULL, NULL, 'Category 3', 'some data'),
(4, '2024-04-01 11:10:17', '2024-04-01 11:10:17', 1, NULL, NULL, 'Category 3', 'some dataAS'),
(5, '2024-04-01 11:11:15', '2024-04-01 11:11:15', 1, NULL, NULL, 'Category 3', 'some dataAS'),
(6, '2024-04-01 11:11:44', '2024-04-01 11:11:44', 1, NULL, NULL, 'Category 4', 'some dataAS'),
(7, '2024-04-01 17:49:21', '2024-04-01 17:49:21', 1, NULL, NULL, 'Sales', NULL),
(8, '2024-04-01 17:49:21', '2024-04-01 17:49:21', 1, NULL, NULL, 'Purchase', NULL),
(9, '2024-04-01 17:49:21', '2024-04-01 17:49:21', 1, NULL, NULL, 'Expense', NULL),
(10, '2024-04-02 18:41:24', '2024-04-02 18:41:24', 2, NULL, NULL, 'Sales', NULL),
(11, '2024-04-02 18:41:24', '2024-04-02 18:41:24', 2, NULL, NULL, 'Purchase', NULL),
(12, '2024-04-02 18:41:24', '2024-04-02 18:41:24', 2, NULL, NULL, 'Expense', NULL),
(13, '2024-04-06 05:35:15', '2024-04-06 05:35:15', 8, NULL, NULL, 'Sales', NULL),
(14, '2024-04-06 05:35:15', '2024-04-06 05:35:15', 8, NULL, NULL, 'Purchase', NULL),
(15, '2024-04-06 05:35:15', '2024-04-06 05:35:15', 8, NULL, NULL, 'Expense', NULL),
(16, '2024-04-08 05:49:29', '2024-04-08 05:49:29', 9, NULL, NULL, 'Sales', NULL),
(17, '2024-04-08 05:49:29', '2024-04-08 05:49:29', 9, NULL, NULL, 'Purchase', NULL),
(18, '2024-04-08 05:49:29', '2024-04-08 05:49:29', 9, NULL, NULL, 'Expense', NULL),
(19, '2024-04-14 05:30:33', '2024-04-14 05:30:33', 10, NULL, NULL, 'Sales', NULL),
(20, '2024-04-14 05:30:33', '2024-04-14 05:30:33', 10, NULL, NULL, 'Purchase', NULL),
(21, '2024-04-14 05:30:33', '2024-04-14 05:30:33', 10, NULL, NULL, 'Expense', NULL),
(22, '2024-05-07 00:12:57', '2024-05-07 00:12:57', 11, NULL, NULL, 'Sales', NULL),
(23, '2024-05-07 00:12:57', '2024-05-07 00:12:57', 11, NULL, NULL, 'Purchase', NULL),
(24, '2024-05-07 00:12:57', '2024-05-07 00:12:57', 11, NULL, NULL, 'Expense', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `financial_periods`
--

CREATE TABLE `financial_periods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  `description` text COLLATE utf8mb4_unicode_ci,
  `total_investment` bigint(20) NOT NULL DEFAULT '0',
  `total_sales` bigint(20) NOT NULL DEFAULT '0',
  `total_profit` bigint(20) NOT NULL DEFAULT '0',
  `total_expenses` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financial_periods`
--

INSERT INTO `financial_periods` (`id`, `created_at`, `updated_at`, `company_id`, `name`, `start_date`, `end_date`, `status`, `description`, `total_investment`, `total_sales`, `total_profit`, `total_expenses`) VALUES
(1, '2023-12-29 16:11:01', '2023-12-29 16:15:54', 1, '2023', '2023-01-01', '2023-12-31', 'Inactive', 'Some details about this 2023', 0, 0, 0, 0),
(2, '2023-12-29 16:12:29', '2023-12-29 16:16:00', 1, '2024', '2024-01-01', '2024-12-31', 'Active', 'Some info about 2024', 0, 0, 0, 0),
(3, '2024-01-08 14:51:04', '2024-01-08 15:14:57', 6, '2024-2026', '2024-01-01', '2024-12-31', 'Inactive', '2024 YEAR', 0, 0, 0, 0),
(4, '2024-01-08 14:58:29', '2024-01-08 15:12:01', 7, '2024-2026', '2024-01-01', '2024-12-31', 'Inactive', '2024 YEAR', 0, 0, 0, 0),
(5, '2024-01-08 15:12:29', '2024-01-08 15:12:29', 7, '2023-2024', '2023-01-01', '2023-12-31', 'Active', '2024 YEAR', 0, 0, 0, 0),
(6, '2024-01-08 15:15:02', '2024-01-08 15:15:02', 6, '2023-2024', '2023-01-01', '2023-12-31', 'Active', '2024 YEAR', 0, 0, 0, 0),
(7, '2024-04-02 18:15:00', '2024-04-02 18:15:00', 2, '2024', '2024-04-02', '2024-04-02', 'Active', '2024 Financial period', 0, 0, 0, 0),
(8, '2024-04-14 05:32:58', '2024-04-14 05:32:58', 10, '2024', '2024-01-01', '2024-12-31', 'Active', 'tesrt', 0, 0, 0, 0),
(9, '2024-05-07 00:51:59', '2024-05-07 00:51:59', 11, '2024', '2024-05-08', '2025-05-08', 'Active', 'some details', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `financial_records`
--

CREATE TABLE `financial_records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `financial_category_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `amount` bigint(20) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` text COLLATE utf8mb4_unicode_ci,
  `recipient` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `receipt` text COLLATE utf8mb4_unicode_ci,
  `date` date DEFAULT NULL,
  `financial_period_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financial_records`
--

INSERT INTO `financial_records` (`id`, `created_at`, `updated_at`, `financial_category_id`, `company_id`, `user_id`, `amount`, `quantity`, `type`, `payment_method`, `recipient`, `description`, `receipt`, `date`, `financial_period_id`, `created_by_id`) VALUES
(2, '2024-04-01 17:58:53', '2024-04-01 17:58:53', 7, 1, 1, 150, 1, 'Income', 'Cash', '', 'Sales of #9', '', NULL, 2, 1),
(3, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 10, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 1', 'Description 1', 'Receipt 1', NULL, 7, 3),
(4, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 10, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 2', 'Description 2', 'Receipt 2', NULL, 7, 3),
(5, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 10, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 3', 'Description 3', 'Receipt 3', NULL, 7, 3),
(6, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 10, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 4', 'Description 4', 'Receipt 4', NULL, 7, 3),
(7, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 10, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 5', 'Description 5', 'Receipt 5', NULL, 7, 3),
(8, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 11, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 1', 'Description 1', 'Receipt 1', NULL, 7, 3),
(9, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 11, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 2', 'Description 2', 'Receipt 2', NULL, 7, 3),
(10, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 11, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 3', 'Description 3', 'Receipt 3', NULL, 7, 3),
(11, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 11, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 4', 'Description 4', 'Receipt 4', NULL, 7, 3),
(12, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 11, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 5', 'Description 5', 'Receipt 5', NULL, 7, 3),
(13, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 12, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 1', 'Description 1', 'Receipt 1', NULL, 7, 3),
(14, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 12, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 2', 'Description 2', 'Receipt 2', NULL, 7, 3),
(15, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 12, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 3', 'Description 3', 'Receipt 3', NULL, 7, 3),
(16, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 12, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 4', 'Description 4', 'Receipt 4', NULL, 7, 3),
(17, '2024-04-02 18:50:08', '2024-04-02 18:50:08', 12, 2, 3, 100, 10, 'Income', 'Cash', 'Recipient 5', 'Description 5', 'Receipt 5', NULL, 7, 3),
(18, '2024-04-04 17:59:53', '2024-04-04 17:59:53', 10, 2, 3, 50000, 5, 'Income', 'Cash', '', 'Sales of #635', '', NULL, 7, 3),
(19, '2024-04-05 21:36:44', '2024-04-05 21:36:44', 10, 2, 3, 3000, 20, 'Income', 'Cash', '', 'Sales of #636', '', NULL, 7, 3),
(20, '2024-04-05 21:37:23', '2024-04-05 21:37:23', 10, 2, 3, 2250, 15, 'Income', 'Cash', '', 'Sales of #637', '', NULL, 7, 3),
(21, '2024-04-06 05:29:17', '2024-04-06 05:29:17', 10, 2, 3, 20000, 2, 'Income', 'Cash', '', 'Sales of #638', '', NULL, 7, 3),
(22, '2024-04-14 05:39:20', '2024-04-14 05:39:20', 19, 10, 17, 25000, 10, 'Income', 'Cash', '', 'Sales of #639', '', NULL, 8, 17),
(23, '2024-04-14 05:41:31', '2024-04-14 05:41:31', 19, 10, 17, 450000, 180, 'Income', 'Cash', '', 'Sales of #641', '', NULL, 8, 17);

-- --------------------------------------------------------

--
-- Table structure for table `financial_reports`
--

CREATE TABLE `financial_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `period_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_generated` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'no',
  `file` text COLLATE utf8mb4_unicode_ci,
  `total_income` decimal(15,2) DEFAULT NULL,
  `total_expense` decimal(15,2) DEFAULT NULL,
  `profit` decimal(15,2) DEFAULT NULL,
  `include_finance_accounts` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `include_finance_records` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inventory_total_buying_price` decimal(15,2) DEFAULT NULL,
  `inventory_total_selling_price` decimal(15,2) DEFAULT NULL,
  `inventory_total_expected_profit` decimal(15,2) DEFAULT NULL,
  `inventory_total_earned_profit` decimal(15,2) DEFAULT NULL,
  `inventory_include_categories` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inventory_include_sub_categories` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inventory_include_products` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `do_generate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `financial_reports`
--

INSERT INTO `financial_reports` (`id`, `created_at`, `updated_at`, `company_id`, `user_id`, `type`, `period_type`, `start_date`, `end_date`, `currency`, `file_generated`, `file`, `total_income`, `total_expense`, `profit`, `include_finance_accounts`, `include_finance_records`, `inventory_total_buying_price`, `inventory_total_selling_price`, `inventory_total_expected_profit`, `inventory_total_earned_profit`, `inventory_include_categories`, `inventory_include_sub_categories`, `inventory_include_products`, `do_generate`) VALUES
(1, '2024-04-02 19:00:10', '2024-04-04 19:05:51', 2, 3, 'Financial', 'Custom', '2024-01-02', '2024-12-30', 'USD', 'Yes', 'files/report-1.pdf', '51500.00', '0.00', '51500.00', 'Yes', 'Yes', NULL, NULL, NULL, NULL, 'Yes', 'Yes', 'Yes', 'No'),
(2, '2024-04-06 03:33:17', '2024-04-06 04:05:51', 2, 3, 'Financial', 'Year', '2024-01-01', '2024-12-31', 'USD', 'Yes', 'files/report-2.pdf', '56750.00', '0.00', '56750.00', 'Yes', 'Yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No');

-- --------------------------------------------------------

--
-- Table structure for table `gens`
--

CREATE TABLE `gens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `class_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `endpoint` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gens`
--

INSERT INTO `gens` (`id`, `created_at`, `updated_at`, `class_name`, `table_name`, `endpoint`) VALUES
(1, '2024-03-21 18:17:49', '2024-03-21 18:17:49', 'FinancialPeriodModel', 'financial_periods', 'FinancialPeriod'),
(2, '2024-03-25 16:24:29', '2024-03-25 16:36:32', 'EmployeeModel', 'admin_users', 'User'),
(3, '2024-03-26 16:17:12', '2024-03-26 16:17:12', 'StockCategoryModel', 'stock_categories', 'StockCategory'),
(4, '2024-03-28 00:40:20', '2024-03-28 00:40:20', 'StockSubCategoryModel', 'stock_sub_categories', 'StockSubCategory'),
(5, '2024-03-28 01:38:05', '2024-03-28 01:38:05', 'StockItemModel', 'stock_items', 'StockItem'),
(6, '2024-03-28 03:24:30', '2024-03-28 03:24:30', 'StockRecordModel', 'stock_records', 'StockRecord'),
(7, '2024-04-01 10:09:02', '2024-04-01 10:09:02', 'FinancialCategory', 'financial_categories', 'FinancialCategory'),
(8, '2024-04-01 10:22:09', '2024-04-01 10:22:09', 'FinancialRecordModel', 'financial_records', 'FinancialRecord'),
(9, '2024-04-04 19:30:46', '2024-04-04 19:30:46', 'FinancialReportModel', 'financial_reports', 'FinancialReport'),
(10, '2024-04-30 19:14:36', '2024-04-30 19:14:59', 'BudgetItemModel', 'budget_items', 'BudgetItem');

-- --------------------------------------------------------

--
-- Table structure for table `handover_records`
--

CREATE TABLE `handover_records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `budget_program_id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `from_id` bigint(20) DEFAULT NULL,
  `to_id` bigint(20) DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `transfer_date` datetime DEFAULT NULL,
  `to_approved` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `amount` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2016_01_04_173148_create_admin_tables', 2),
(6, '2023_12_27_191449_create_companies_table', 3),
(7, '2023_12_28_175439_add_more_data_to_users_table', 4),
(8, '2023_12_28_184634_create_stock_categories_table', 5),
(9, '2023_12_28_191608_create_stock_sub_categories_table', 6),
(10, '2023_12_29_185415_create_financial_periods_table', 7),
(11, '2023_12_29_193135_add_email_to_users_table', 8),
(12, '2023_12_30_170905_create_stock_items_table', 9),
(13, '2024_01_01_181454_add_in_stock_stock_sub_categories', 10),
(14, '2024_01_01_182639_create_stock_records_table', 11),
(15, '2024_01_03_174223_add_profit_col_stock_records', 12),
(16, '2024_01_03_175748_add_financial_period_id_to', 13),
(17, '2024_01_06_180349_add_currency_to_companies', 14),
(18, '2024_02_09_175542_create_code_gens_table', 15),
(19, '2024_03_21_210236_create_gens_table', 16),
(20, '2024_04_01_123859_create_financial_records_table', 17),
(21, '2024_04_01_125240_create_financial_categories_table', 18),
(22, '2024_04_01_190510_add_financial_period_ido_financial_records', 19),
(23, '2024_04_01_190855_add_created_by_id_to_financial_records', 20),
(24, '2024_04_02_201819_create_financial_reports_table', 21),
(25, '2024_04_02_211110_add_do_generate_financial_reports', 22),
(26, '2024_04_28_152333_create_budget_programs_table', 23),
(27, '2024_04_28_204616_create_contribution_records_table', 23),
(28, '2024_04_28_205622_create_handover_records_table', 23),
(29, '2024_04_28_210435_create_budget_item_categories_table', 23),
(30, '2024_04_28_211253_create_budget_items_table', 23),
(31, '2024_04_28_220225_add_auto_data_contribution_records', 23),
(32, '2024_04_28_231823_add_amount_handover_records', 23),
(33, '2024_04_29_003019_add_cat_contribution_records', 23),
(34, '2024_04_29_005531_create_data_exports_table', 23),
(35, '2024_04_30_090241_add_unit_budget_items', 23),
(36, '2024_04_30_091231_add_approved_budget_items', 23),
(37, '2024_04_30_100151_add_details_budget_items', 23),
(38, '2024_05_31_093512_add_status_to_budget_programs', 23),
(39, '2024_05_31_111210_make_change_user_id_on_organisations', 23),
(40, '2024_05_31_112507_add_new_status_to_budget_programs', 24);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_categories`
--

CREATE TABLE `stock_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `image` text COLLATE utf8mb4_unicode_ci,
  `buying_price` bigint(20) DEFAULT '0',
  `selling_price` bigint(20) DEFAULT '0',
  `expected_profit` bigint(20) DEFAULT '0',
  `earned_profit` bigint(20) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_categories`
--

INSERT INTO `stock_categories` (`id`, `created_at`, `updated_at`, `company_id`, `name`, `description`, `status`, `image`, `buying_price`, `selling_price`, `expected_profit`, `earned_profit`) VALUES
(1, '2023-12-28 16:05:13', '2024-01-03 14:30:04', 1, 'Fresh Produce', 'SOme details..', 'Active', 'images/Is_Fresh_Produce_Safe_to_Eat_Small-compressor.jpeg', 0, 0, 0, 0),
(2, '2023-12-28 16:06:14', '2023-12-28 16:06:14', 1, 'Grocery', 'Some details abaout Grocery', 'Active', NULL, 0, 0, 0, 0),
(3, '2023-12-29 15:10:56', '2024-04-01 17:58:53', 1, 'Frozen Foods:', NULL, 'Active', NULL, 50000, 75000, 25000, 2650),
(4, '2024-01-08 15:32:16', '2024-01-22 15:23:14', 7, 'Test Name 1.', 'Some Description', 'Active', NULL, 1000000, 800000, -200000, -4000),
(5, '2024-01-08 15:34:28', '2024-01-08 15:34:28', 7, 'Test Name 2', 'Some Description', 'Active', NULL, 0, 0, 0, 0),
(6, '2024-01-08 15:34:28', '2024-01-08 15:34:28', 7, 'Test Name 2', 'Some Description', 'Active', NULL, 0, 0, 0, 0),
(7, '2024-04-02 18:24:31', '2024-04-02 18:32:11', 2, 'Electronics', 'Electronics', 'active', 'images/placeholder.jpg', 250000, 375000, 125000, 0),
(8, '2024-04-02 18:24:31', '2024-04-06 05:29:17', 2, 'Furniture', 'Furniture', 'active', 'images/placeholder.jpg', 750000, 1375000, 625000, 35000),
(9, '2024-04-02 18:24:31', '2024-04-02 18:32:12', 2, 'Clothing', 'Clothing', 'active', 'images/placeholder.jpg', 250000, 375000, 125000, 0),
(10, '2024-04-02 18:24:31', '2024-04-05 21:36:44', 2, 'Food', 'Food', 'active', 'images/placeholder.jpg', 250000, 375000, 125000, 1000),
(11, '2024-04-02 18:24:31', '2024-04-05 21:37:23', 2, 'Stationery', 'Stationery', 'active', 'images/placeholder.jpg', 250000, 375000, 125000, 750),
(12, '2024-04-14 05:34:02', '2024-04-14 05:41:31', 10, 'Food staffs', 'some details', 'Active', 'images/1713094442_32943.jpg', 2600000, 3250000, 650000, 95000),
(13, '2024-04-14 05:34:43', '2024-04-14 05:34:43', 10, 'Detargents', 'sone detaila', 'Active', 'images/1713094483_38581.jpg', 0, 0, 0, 0),
(14, '2024-05-07 00:49:16', '2024-05-07 00:49:16', 11, 'foods', 'some description', 'Active', 'images/1715064556_86595.jpg', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `stock_items`
--

CREATE TABLE `stock_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `created_by_id` bigint(20) UNSIGNED NOT NULL,
  `stock_category_id` bigint(20) UNSIGNED NOT NULL,
  `stock_sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `financial_period_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` text COLLATE utf8mb4_unicode_ci,
  `barcode` text COLLATE utf8mb4_unicode_ci,
  `sku` text COLLATE utf8mb4_unicode_ci,
  `generate_sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gallery` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buying_price` bigint(20) NOT NULL DEFAULT '0',
  `selling_price` bigint(20) NOT NULL DEFAULT '0',
  `original_quantity` bigint(20) NOT NULL DEFAULT '0',
  `current_quantity` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_items`
--

INSERT INTO `stock_items` (`id`, `created_at`, `updated_at`, `company_id`, `created_by_id`, `stock_category_id`, `stock_sub_category_id`, `financial_period_id`, `name`, `description`, `image`, `barcode`, `sku`, `generate_sku`, `update_sku`, `gallery`, `buying_price`, `selling_price`, `original_quantity`, `current_quantity`) VALUES
(2, '2024-01-03 14:31:54', '2024-06-03 15:22:24', 1, 2, 3, 3, 2, 'Test ice cream', 'Some details', 'images/93874ff81a771b5f30b5ece14abf8ed3.jpg', NULL, '2024-1-1', 'Auto', 'No', '[\"images\\/698b3c7da41dfa85b978403fc45a9f00.jpg\",\"images\\/6f1cf831bd665dc74551b4543c9860b9.jpg\"]', 100, 150, 500, 247),
(3, '2024-01-22 15:18:18', '2024-01-22 15:18:18', 7, 10, 4, 5, 5, 'Test stock item', 'some details', 'images/1705947498_43127.png', NULL, '28628', 'Auto', '8263627', NULL, 10000, 8000, 50, 50),
(4, '2024-01-22 15:18:54', '2024-01-22 15:23:14', 7, 10, 4, 5, 5, 'Test stock item', 'some details', NULL, NULL, '28628', 'Auto', '8263627', NULL, 10000, 8000, 50, 48),
(5, '2024-04-02 18:32:11', '2024-04-02 18:34:29', 2, 3, 7, 6, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-6-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(6, '2024-04-02 18:32:11', '2024-04-02 18:34:29', 2, 3, 7, 6, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-6-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(7, '2024-04-02 18:32:11', '2024-04-02 18:34:29', 2, 3, 7, 6, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-6-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(8, '2024-04-02 18:32:11', '2024-04-02 18:34:29', 2, 3, 7, 6, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-6-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(9, '2024-04-02 18:32:11', '2024-04-02 18:34:29', 2, 3, 7, 6, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-6-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(10, '2024-04-02 18:32:11', '2024-04-02 18:34:29', 2, 3, 7, 7, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-7-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(11, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 7, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-7-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(12, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 7, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-7-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(13, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 7, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-7-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(14, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 7, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-7-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(15, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 8, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-8-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(16, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 8, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-8-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(17, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 8, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-8-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(18, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 8, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-8-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(19, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 8, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-8-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(20, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 9, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-9-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(21, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 9, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-9-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(22, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 9, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-9-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(23, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 9, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-9-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(24, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 9, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-9-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(25, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 10, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-10-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(26, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 10, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-10-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(27, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 10, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-10-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(28, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 10, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-10-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(29, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 7, 10, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-10-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(30, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 8, 11, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-11-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(31, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 8, 11, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-11-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(32, '2024-04-02 18:32:11', '2024-04-02 18:34:30', 2, 3, 8, 11, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-11-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(33, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 11, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-11-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(34, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 11, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-11-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(35, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 12, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-12-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(36, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 12, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-12-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(37, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 12, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-12-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(38, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 12, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-12-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(39, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 12, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-12-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(40, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 13, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-13-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(41, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 13, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-13-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(42, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 13, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-13-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(43, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 13, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-13-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(44, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 13, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-13-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(45, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 14, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-14-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(46, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 14, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-14-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(47, '2024-04-02 18:32:11', '2024-04-02 18:34:31', 2, 3, 8, 14, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-14-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(48, '2024-04-02 18:32:12', '2024-04-02 18:34:31', 2, 3, 8, 14, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-14-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(49, '2024-04-02 18:32:12', '2024-04-02 18:34:31', 2, 3, 8, 14, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-14-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(50, '2024-04-02 18:32:12', '2024-04-02 18:34:31', 2, 3, 8, 15, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-15-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(51, '2024-04-02 18:32:12', '2024-04-02 18:34:31', 2, 3, 8, 15, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-15-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(52, '2024-04-02 18:32:12', '2024-04-02 18:34:31', 2, 3, 8, 15, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-15-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(53, '2024-04-02 18:32:12', '2024-04-02 18:34:31', 2, 3, 8, 15, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-15-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(54, '2024-04-02 18:32:12', '2024-04-02 18:34:31', 2, 3, 8, 15, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-15-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(55, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 16, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-16-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(56, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 16, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-16-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(57, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 16, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-16-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(58, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 16, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-16-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(59, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 16, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-16-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(60, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 17, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-17-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(61, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 17, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-17-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(62, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 17, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-17-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(63, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 17, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-17-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(64, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 17, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-17-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(65, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 18, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-18-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(66, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 18, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-18-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(67, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 18, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-18-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(68, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 18, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-18-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(69, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 18, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-18-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(70, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 19, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-19-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(71, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 19, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-19-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(72, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 19, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-19-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(73, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 19, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-19-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(74, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 19, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-19-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(75, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 20, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-20-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(76, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 20, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-20-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(77, '2024-04-02 18:32:12', '2024-04-02 18:34:32', 2, 3, 9, 20, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-20-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(78, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 9, 20, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-20-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(79, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 9, 20, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-20-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(80, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 21, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-21-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(81, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 21, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-21-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(82, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 21, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-21-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(83, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 21, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-21-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(84, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 21, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-21-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(85, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 22, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-22-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(86, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 22, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-22-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(87, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 22, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-22-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(88, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 22, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-22-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(89, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 22, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-22-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(90, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 23, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-23-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(91, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 23, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-23-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(92, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 23, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-23-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(93, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 23, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-23-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(94, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 23, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-23-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(95, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 24, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-24-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(96, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 24, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-24-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(97, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 24, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-24-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(98, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 24, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-24-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(99, '2024-04-02 18:32:12', '2024-04-02 18:34:33', 2, 3, 10, 24, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-24-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(100, '2024-04-02 18:32:12', '2024-04-05 21:36:44', 2, 3, 10, 25, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-25-1', 'No', 'No', '\"[]\"', 100, 150, 100, 30),
(101, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 10, 25, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-25-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(102, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 10, 25, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-25-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(103, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 10, 25, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-25-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(104, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 10, 25, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-25-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(105, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 26, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-26-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(106, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 26, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-26-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(107, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 26, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-26-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(108, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 26, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-26-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(109, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 26, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-26-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(110, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 27, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-27-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(111, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 27, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-27-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(112, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 27, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-27-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(113, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 27, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-27-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(114, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 27, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-27-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(115, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 28, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-28-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(116, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 28, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-28-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(117, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 28, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-28-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(118, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 28, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-28-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(119, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 28, 7, 'Stock Item 5', 'Stock Item 5', 'images/placeholder.jpg', 'barcode', '2024-28-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(120, '2024-04-02 18:32:12', '2024-04-02 18:34:34', 2, 3, 11, 29, 7, 'Stock Item 1', 'Stock Item 1', 'images/placeholder.jpg', 'barcode', '2024-29-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(121, '2024-04-02 18:32:12', '2024-04-02 18:34:35', 2, 3, 11, 29, 7, 'Stock Item 2', 'Stock Item 2', 'images/placeholder.jpg', 'barcode', '2024-29-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(122, '2024-04-02 18:32:12', '2024-04-02 18:34:35', 2, 3, 11, 29, 7, 'Stock Item 3', 'Stock Item 3', 'images/placeholder.jpg', 'barcode', '2024-29-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(123, '2024-04-02 18:32:12', '2024-04-02 18:34:35', 2, 3, 11, 29, 7, 'Stock Item 4', 'Stock Item 4', 'images/placeholder.jpg', 'barcode', '2024-29-4', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(124, '2024-04-02 18:32:12', '2024-04-06 04:35:10', 2, 3, 11, 29, 7, 'Stock Item 5', 'Stock Item 5', 'images/1712399710_89699.jpg', 'barcode', '2024-29-5', 'Auto', 'No', '\"[]\"', 100, 150, 100, 50),
(125, '2024-04-02 18:32:12', '2024-04-05 21:35:05', 2, 3, 11, 30, 7, 'Stock Item 1', 'Stock Item 1', 'images/f4516cd55120f34060d39f3e1f55d7e8.jpeg', 'barcode', '2024-30-1', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(126, '2024-04-02 18:32:12', '2024-04-05 21:34:40', 2, 3, 11, 30, 7, 'Stock Item 2', 'Stock Item 2', 'images/87506a87fb93d325883989bad42dbfa8.jpg', 'barcode', '2024-30-2', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(127, '2024-04-02 18:32:12', '2024-04-05 21:32:33', 2, 3, 11, 30, 7, 'Stock Item 3', 'Stock Item 3', 'images/bb0de3d96e42a8532a5b0e4083e8345b.jpg', 'barcode', '2024-30-3', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(128, '2024-04-02 18:32:12', '2024-04-05 21:37:23', 2, 3, 11, 30, 7, 'Stock Item 4', 'Stock Item 4', 'images/92f4de0c644b42bb4b62dd222fbe88d2.jpg', 'barcode', '2024-30-4', 'No', 'No', '\"[]\"', 100, 150, 100, 35),
(129, '2024-04-02 18:32:12', '2024-04-05 21:29:07', 2, 3, 11, 30, 7, 'Stock Item 5', 'Stock Item 5', 'images/f82baa39780e21b2b2281f755deb9cf3.webp', 'barcode', '2024-30-5', 'No', 'No', '\"[]\"', 100, 150, 100, 50),
(130, '2024-04-04 17:55:06', '2024-04-06 05:29:17', 2, 3, 8, 11, 7, 'Mangoe', NULL, 'images/65d2f9673e433c3299b56d99736f8701.jpeg', NULL, '2024-11-6', 'Auto', 'No', NULL, 5000, 10000, 100, 93),
(131, '2024-04-14 05:37:41', '2024-04-14 05:37:41', 10, 17, 12, 31, 8, 'test', 'test', 'images/1713094661_89305.jpg', NULL, '2024-31-1', 'Auto', NULL, NULL, 1200, 1500, 500, 500),
(132, '2024-04-14 05:38:31', '2024-04-14 05:41:31', 10, 17, 12, 31, 8, 'test 4', 'sone detailz', 'images/1713094711_45344.jpg', NULL, '2024-31-2', 'Auto', NULL, NULL, 2000, 2500, 1000, 800);

-- --------------------------------------------------------

--
-- Table structure for table `stock_records`
--

CREATE TABLE `stock_records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `stock_item_id` bigint(20) UNSIGNED NOT NULL,
  `stock_category_id` bigint(20) UNSIGNED NOT NULL,
  `stock_sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `created_by_id` bigint(20) UNSIGNED NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `measurement_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `selling_price` double(8,2) NOT NULL,
  `total_sales` double(8,2) NOT NULL,
  `profit` bigint(20) NOT NULL DEFAULT '0',
  `financial_period_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_sub_categories`
--

CREATE TABLE `stock_sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `stock_category_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `image` text COLLATE utf8mb4_unicode_ci,
  `buying_price` bigint(20) DEFAULT '0',
  `selling_price` bigint(20) DEFAULT '0',
  `expected_profit` bigint(20) DEFAULT '0',
  `earned_profit` bigint(20) DEFAULT '0',
  `measurement_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_quantity` bigint(20) DEFAULT '0',
  `reorder_level` bigint(20) DEFAULT '0',
  `in_stock` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stock_sub_categories`
--

INSERT INTO `stock_sub_categories` (`id`, `created_at`, `updated_at`, `company_id`, `stock_category_id`, `name`, `description`, `status`, `image`, `buying_price`, `selling_price`, `expected_profit`, `earned_profit`, `measurement_unit`, `current_quantity`, `reorder_level`, `in_stock`) VALUES
(1, '2023-12-29 15:18:46', '2023-12-29 15:40:30', 1, 1, 'Fruits', 'Some details about fruits', 'Active', 'images/4f342ca403fc142e2d05cfaa26016da9.jpeg', 0, 0, 0, 0, 'KG', 0, 70, 'No'),
(2, '2023-12-29 15:28:56', '2024-01-03 14:30:04', 1, 1, 'Vegetables', NULL, 'Active', 'images/7402f3ceae2373ea0847cd523f63719b.jpeg', 0, 0, 0, 0, 'KG', 0, 5, 'No'),
(3, '2023-12-29 15:30:35', '2024-04-01 17:58:53', 1, 3, 'Ice Cream and Frozen Desserts', 'Some details of Ice Cream and Frozen Desserts', 'Active', 'images/657113a08cb4eaf49f57022c737a3d85.webp', 50000, 75000, 25000, 2650, 'Pieces', 247, 20, 'Yes'),
(4, '2024-01-22 14:31:12', '2024-01-22 14:31:12', 7, 4, 'Test sub cat', 'Some details about this sub cat', 'Active', NULL, 0, 0, 0, 0, 'KG', 0, 10, 'No'),
(5, '2024-01-22 15:00:31', '2024-01-22 15:23:14', 7, 4, 'Test sub cat', 'Some details about this sub cat', 'Active', 'images/1705946715_70667.png', 1000000, 800000, -200000, -4000, 'KG', 98, 12, 'Yes'),
(6, '2024-04-02 18:25:47', '2024-04-02 18:34:29', 2, 7, 'Sub Category 1', 'Sub Category 1', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(7, '2024-04-02 18:25:47', '2024-04-02 18:34:30', 2, 7, 'Sub Category 2', 'Sub Category 2', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(8, '2024-04-02 18:25:47', '2024-04-02 18:34:30', 2, 7, 'Sub Category 3', 'Sub Category 3', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(9, '2024-04-02 18:25:47', '2024-04-02 18:34:30', 2, 7, 'Sub Category 4', 'Sub Category 4', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(10, '2024-04-02 18:25:47', '2024-04-02 18:34:30', 2, 7, 'Sub Category 5', 'Sub Category 5', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(11, '2024-04-02 18:25:47', '2024-04-06 05:29:17', 2, 8, 'Sub Category 1', 'Sub Category 1', 'active', 'images/placeholder.jpg', 550000, 1075000, 525000, 35000, 'Kg', 343, 10, 'Yes'),
(12, '2024-04-02 18:25:47', '2024-04-02 18:34:31', 2, 8, 'Sub Category 2', 'Sub Category 2', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(13, '2024-04-02 18:25:47', '2024-04-02 18:34:31', 2, 8, 'Sub Category 3', 'Sub Category 3', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(14, '2024-04-02 18:25:47', '2024-04-02 18:34:31', 2, 8, 'Sub Category 4', 'Sub Category 4', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(15, '2024-04-02 18:25:47', '2024-04-02 18:34:31', 2, 8, 'Sub Category 5', 'Sub Category 5', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(16, '2024-04-02 18:25:47', '2024-04-02 18:34:32', 2, 9, 'Sub Category 1', 'Sub Category 1', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(17, '2024-04-02 18:25:47', '2024-04-02 18:34:32', 2, 9, 'Sub Category 2', 'Sub Category 2', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(18, '2024-04-02 18:25:47', '2024-04-02 18:34:32', 2, 9, 'Sub Category 3', 'Sub Category 3', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(19, '2024-04-02 18:25:47', '2024-04-02 18:34:32', 2, 9, 'Sub Category 4', 'Sub Category 4', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(20, '2024-04-02 18:25:47', '2024-04-02 18:34:33', 2, 9, 'Sub Category 5', 'Sub Category 5', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(21, '2024-04-02 18:25:47', '2024-04-02 18:34:33', 2, 10, 'Sub Category 1', 'Sub Category 1', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(22, '2024-04-02 18:25:47', '2024-04-02 18:34:33', 2, 10, 'Sub Category 2', 'Sub Category 2', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(23, '2024-04-02 18:25:47', '2024-04-02 18:34:33', 2, 10, 'Sub Category 3', 'Sub Category 3', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(24, '2024-04-02 18:25:47', '2024-04-02 18:34:33', 2, 10, 'Sub Category 4', 'Sub Category 4', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(25, '2024-04-02 18:25:47', '2024-04-05 21:36:44', 2, 10, 'Sub Category 5', 'Sub Category 5', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 1000, 'Kg', 230, 10, 'Yes'),
(26, '2024-04-02 18:25:47', '2024-04-02 18:34:34', 2, 11, 'Sub Category 1', 'Sub Category 1', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(27, '2024-04-02 18:25:47', '2024-04-02 18:34:34', 2, 11, 'Sub Category 2', 'Sub Category 2', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(28, '2024-04-02 18:25:47', '2024-04-02 18:34:34', 2, 11, 'Sub Category 3', 'Sub Category 3', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(29, '2024-04-02 18:25:47', '2024-04-02 18:34:35', 2, 11, 'Sub Category 4', 'Sub Category 4', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 0, 'Kg', 250, 10, 'Yes'),
(30, '2024-04-02 18:25:47', '2024-04-05 21:37:23', 2, 11, 'Sub Category 5', 'Sub Category 5', 'active', 'images/placeholder.jpg', 50000, 75000, 25000, 750, 'Kg', 235, 10, 'Yes'),
(31, '2024-04-14 05:35:31', '2024-04-14 05:41:31', 10, 12, 'Vegetables', 'some details', 'Active', 'images/1713094531_39050.jpg', 2600000, 3250000, 650000, 95000, 'kg', 1300, 5, 'Yes'),
(32, '2024-04-14 05:36:15', '2024-04-14 05:36:15', 10, 12, 'Serials', 'vgg', 'Active', 'images/1713094575_47041.jpg', 0, 0, 0, 0, 'KG', 0, 12, 'No'),
(33, '2024-05-07 00:50:54', '2024-05-07 00:50:54', 11, 14, 'fish', 'some description', 'Active', 'images/1715064654_18182.png', 0, 0, 0, 0, 'kgs', 0, 500, 'No');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_menu`
--
ALTER TABLE `admin_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_operation_log`
--
ALTER TABLE `admin_operation_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_operation_log_user_id_index` (`user_id`);

--
-- Indexes for table `admin_permissions`
--
ALTER TABLE `admin_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_permissions_name_unique` (`name`),
  ADD UNIQUE KEY `admin_permissions_slug_unique` (`slug`);

--
-- Indexes for table `admin_roles`
--
ALTER TABLE `admin_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_roles_name_unique` (`name`),
  ADD UNIQUE KEY `admin_roles_slug_unique` (`slug`);

--
-- Indexes for table `admin_role_menu`
--
ALTER TABLE `admin_role_menu`
  ADD KEY `admin_role_menu_role_id_menu_id_index` (`role_id`,`menu_id`);

--
-- Indexes for table `admin_role_permissions`
--
ALTER TABLE `admin_role_permissions`
  ADD KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`);

--
-- Indexes for table `admin_role_users`
--
ALTER TABLE `admin_role_users`
  ADD KEY `admin_role_users_role_id_user_id_index` (`role_id`,`user_id`);

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_users_username_unique` (`username`);

--
-- Indexes for table `admin_user_permissions`
--
ALTER TABLE `admin_user_permissions`
  ADD KEY `admin_user_permissions_user_id_permission_id_index` (`user_id`,`permission_id`);

--
-- Indexes for table `budget_items`
--
ALTER TABLE `budget_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `budget_item_categories`
--
ALTER TABLE `budget_item_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `budget_programs`
--
ALTER TABLE `budget_programs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `code_gens`
--
ALTER TABLE `code_gens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contribution_records`
--
ALTER TABLE `contribution_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_exports`
--
ALTER TABLE `data_exports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `financial_categories`
--
ALTER TABLE `financial_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `financial_periods`
--
ALTER TABLE `financial_periods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `financial_records`
--
ALTER TABLE `financial_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `financial_reports`
--
ALTER TABLE `financial_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gens`
--
ALTER TABLE `gens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `handover_records`
--
ALTER TABLE `handover_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `stock_categories`
--
ALTER TABLE `stock_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_items`
--
ALTER TABLE `stock_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_records`
--
ALTER TABLE `stock_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_sub_categories`
--
ALTER TABLE `stock_sub_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_menu`
--
ALTER TABLE `admin_menu`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `admin_operation_log`
--
ALTER TABLE `admin_operation_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_permissions`
--
ALTER TABLE `admin_permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `admin_roles`
--
ALTER TABLE `admin_roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `budget_items`
--
ALTER TABLE `budget_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `budget_item_categories`
--
ALTER TABLE `budget_item_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `budget_programs`
--
ALTER TABLE `budget_programs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `code_gens`
--
ALTER TABLE `code_gens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `contribution_records`
--
ALTER TABLE `contribution_records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT for table `data_exports`
--
ALTER TABLE `data_exports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `financial_categories`
--
ALTER TABLE `financial_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `financial_periods`
--
ALTER TABLE `financial_periods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `financial_records`
--
ALTER TABLE `financial_records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `financial_reports`
--
ALTER TABLE `financial_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `gens`
--
ALTER TABLE `gens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `handover_records`
--
ALTER TABLE `handover_records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_categories`
--
ALTER TABLE `stock_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `stock_items`
--
ALTER TABLE `stock_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `stock_records`
--
ALTER TABLE `stock_records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_sub_categories`
--
ALTER TABLE `stock_sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
