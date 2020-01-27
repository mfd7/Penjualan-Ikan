-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 05, 2019 at 03:16 AM
-- Server version: 5.7.23
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjualan_ikan`
--

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
CREATE TABLE IF NOT EXISTS `history` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `nama` char(30) NOT NULL,
  `uang` int(15) NOT NULL,
  `tanggal` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ikan`
--

DROP TABLE IF EXISTS `ikan`;
CREATE TABLE IF NOT EXISTS `ikan` (
  `id_jenis` int(2) NOT NULL AUTO_INCREMENT,
  `jenis_ikan` char(20) NOT NULL,
  `harga` int(12) NOT NULL,
  `stok` double NOT NULL,
  PRIMARY KEY (`id_jenis`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ikan`
--

INSERT INTO `ikan` (`id_jenis`, `jenis_ikan`, `harga`, `stok`) VALUES
(1, 'Mas', 8000, 74.5),
(2, 'Nila', 7500, 0),
(3, 'Lele', 3000, 0),
(5, 'BS', 4000, 35);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

DROP TABLE IF EXISTS `transaksi`;
CREATE TABLE IF NOT EXISTS `transaksi` (
  `id_trans` int(50) NOT NULL AUTO_INCREMENT,
  `nama` char(20) NOT NULL,
  `id_jenis` int(3) NOT NULL,
  `banyak` double NOT NULL,
  `total` int(12) NOT NULL,
  `sdh_dibayar` int(12) NOT NULL,
  `tanggal` date DEFAULT NULL,
  PRIMARY KEY (`id_trans`),
  KEY `id_jenis` (`id_jenis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `transaksi`
--
DROP TRIGGER IF EXISTS `kurangi_stok1`;
DELIMITER $$
CREATE TRIGGER `kurangi_stok1` AFTER INSERT ON `transaksi` FOR EACH ROW UPDATE ikan SET stok = ikan.stok-NEW.banyak WHERE ikan.id_jenis = NEW.id_jenis
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `pindah`;
DELIMITER $$
CREATE TRIGGER `pindah` AFTER DELETE ON `transaksi` FOR EACH ROW insert into trans_lunas (id_transLunas, nama, id_jenis, banyak, total, tanggal) VALUES(NULL, OLD.nama, OLD.id_jenis, OLD.banyak, OLD.total, OLD.tanggal)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trans_lunas`
--

DROP TABLE IF EXISTS `trans_lunas`;
CREATE TABLE IF NOT EXISTS `trans_lunas` (
  `id_transLunas` int(50) NOT NULL AUTO_INCREMENT,
  `nama` char(20) NOT NULL,
  `id_jenis` int(2) NOT NULL,
  `banyak` double NOT NULL,
  `total` int(12) NOT NULL,
  `tanggal` date DEFAULT NULL,
  PRIMARY KEY (`id_transLunas`),
  KEY `id_jenis` (`id_jenis`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(1) NOT NULL AUTO_INCREMENT,
  `username` char(30) NOT NULL,
  `password` char(30) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`) VALUES
(1, 'username', 'password');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_jenis`) REFERENCES `ikan` (`id_jenis`);

--
-- Constraints for table `trans_lunas`
--
ALTER TABLE `trans_lunas`
  ADD CONSTRAINT `trans_lunas_ibfk_1` FOREIGN KEY (`id_jenis`) REFERENCES `ikan` (`id_jenis`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
