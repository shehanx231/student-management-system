-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:4306
-- Generation Time: Mar 30, 2026 at 08:05 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `abc_institute`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_user`
--

CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_user`
--

INSERT INTO `admin_user` (`id`, `email`, `password`) VALUES
(1, 'admin@abc.com', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `course_id` varchar(20) NOT NULL,
  `course_name` varchar(200) NOT NULL,
  `stream` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `course_id`, `course_name`, `stream`, `description`) VALUES
(1, 'CS102.3', 'Computer Science', 'Computing', 'The Computer Science course provides students with a comprehensive understanding of the theory, principles, and practical applications of computing. It is designed to develop problem-solving skills, logical thinking, and the ability to design and implement software solutions for a wide range of real-world challenges.\n\nStudents will explore core topics including programming, algorithms, data structures, databases, computer networks, operating systems, and software development.'),
(2, 'BS101.2', 'Accounting', 'Business', 'The Accounting course provides students with a solid foundation in the principles and practices of financial and managerial accounting. It is designed to equip learners with the skills necessary to record, analyze, and interpret financial information, enabling informed decision-making in both personal and organizational contexts.\n\nThroughout the course, students will explore fundamental accounting concepts such as double-entry bookkeeping, the accounting cycle, preparation of financial statements, and the recognition of assets, liabilities, and equity.');

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

CREATE TABLE `registration` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `batch_no` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `stream` varchar(100) NOT NULL,
  `course_id` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `registration`
--

INSERT INTO `registration` (`id`, `student_id`, `batch_no`, `email`, `stream`, `course_id`, `created_at`) VALUES
(2, 30502, '23.1', 'sepala@gmail.com', 'Computing', 'CS102.3', '2025-08-24 16:44:18'),
(3, 30503, '23.2', 'nadun@gmail.com', 'Business', 'BS101.2', '2025-08-24 17:12:18'),
(4, 30502, '23.2', 'sepala@gmail.com', 'Computing', 'CS102.3', '2025-08-24 17:20:50');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `index_no` int(11) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`id`, `index_no`, `first_name`, `last_name`, `dob`, `address`, `phone`, `email`, `password`) VALUES
(30502, 30500, 'Sepala', 'Siriwardhana', '2003-02-26', 'Colombo, Homagama', '0775673421', 'sepala@gmail.com', '123'),
(30503, 30501, 'Nadun', 'Perera', '2002-07-17', 'Kurunegala', '0775673452', 'nadun@gmail.com', '123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_user`
--
ALTER TABLE `admin_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_id` (`course_id`);

--
-- Indexes for table `registration`
--
ALTER TABLE `registration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reg_student` (`student_id`),
  ADD KEY `fk_reg_courseid` (`course_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_no` (`index_no`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_user`
--
ALTER TABLE `admin_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `registration`
--
ALTER TABLE `registration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30504;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `registration`
--
ALTER TABLE `registration`
  ADD CONSTRAINT `fk_reg_courseid` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `fk_reg_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
