-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 09, 2018 at 05:21 PM
-- Server version: 5.7.21-0ubuntu0.16.04.1
-- PHP Version: 7.0.28-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projet_python_web`
--

-- --------------------------------------------------------

--
-- Table structure for table `etats_site`
--

CREATE TABLE `etats_site` (
  `id` int(11) NOT NULL,
  `etats` int(3) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `website_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `etats_site`
--

INSERT INTO `etats_site` (`id`, `etats`, `date`, `website_id`) VALUES
(1, 200, '2018-04-02 02:12:25', 1),
(2, 200, '2018-04-02 02:14:25', 1),
(3, 200, '2018-04-02 08:20:00', 2),
(4, 404, '2018-04-02 08:22:00', 2);

-- --------------------------------------------------------

--
-- Table structure for table `liste_site`
--

CREATE TABLE `liste_site` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `lien` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `liste_site`
--

INSERT INTO `liste_site` (`id`, `nom`, `lien`) VALUES
(1, 'SiteGuigui', 'https://guillaumehanotel.com/'),
(2, 'JeuGuigui', 'https://thelittleminer.000webhostapp.com/'),
(3, 'Azerty', 'azerty');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `nom`, `password`, `is_admin`) VALUES
(1, 'user', '$argon2i$v=19$m=512,t=2,p=2$07qXMsb4P4fQ+p9T6l3rvQ$hWU817VMNDP/E9l21rYOKQ', 0),
(2, 'admin', '$argon2i$v=19$m=512,t=2,p=2$07qXMsb4P4fQ+p9T6l3rvQ$hWU817VMNDP/E9l21rYOKQ', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `etats_site`
--
ALTER TABLE `etats_site`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FOREIGN_KEY_historique_website` (`website_id`);

--
-- Indexes for table `liste_site`
--
ALTER TABLE `liste_site`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `etats_site`
--
ALTER TABLE `etats_site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `liste_site`
--
ALTER TABLE `liste_site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `etats_site`
--
ALTER TABLE `etats_site`
  ADD CONSTRAINT `FOREIGN_KEY_historique_website` FOREIGN KEY (`website_id`) REFERENCES `liste_site` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
