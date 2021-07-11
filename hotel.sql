-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Apr 29, 2021 alle 14:14
-- Versione del server: 10.4.18-MariaDB
-- Versione PHP: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `clients`
--

CREATE TABLE `clients` (
  `email` varchar(60) NOT NULL,
  `name` varchar(30) NOT NULL,
  `phone` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `clients`
--

INSERT INTO `clients` (`email`, `name`, `phone`) VALUES
('client1@mail.com', 'client1', '3332'),
('rgjopalaj@gmail.com', 'roland', '21124124'),
('rolandgjopalaj@gmail.com', 'roland', '12124912');

-- --------------------------------------------------------

--
-- Struttura della tabella `reservations`
--

CREATE TABLE `reservations` (
  `codice` int(11) NOT NULL,
  `date` date NOT NULL,
  `nrdays` int(11) NOT NULL,
  `nradult` int(11) NOT NULL,
  `cost` int(11) NOT NULL,
  `room` int(11) NOT NULL,
  `client` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `reservations`
--

INSERT INTO `reservations` (`codice`, `date`, `nrdays`, `nradult`, `cost`, `room`, `client`) VALUES
(4, '2023-02-03', 4, 4, 30, 3, 'client1@mail.com'),
(5, '2021-09-12', 2, 1, 30, 2, 'rolandgjopalaj@gmail.com'),
(6, '2022-04-05', 2, 1, 30, 10, 'rgjopalaj@gmail.com');

-- --------------------------------------------------------

--
-- Struttura della tabella `rooms`
--

CREATE TABLE `rooms` (
  `codice` int(11) NOT NULL,
  `letti` int(11) NOT NULL,
  `descrizione` varchar(200) NOT NULL,
  `rservated` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `rooms`
--

INSERT INTO `rooms` (`codice`, `letti`, `descrizione`, `rservated`) VALUES
(1, 4, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 0),
(2, 4, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 0),
(3, 4, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 0),
(4, 4, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 0),
(5, 4, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 0),
(6, 4, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 0),
(7, 5, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 0),
(8, 4, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 0),
(9, 5, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 0),
(10, 4, 'The room is a one-room suite with 4 beds and confortable seating area.The large bathroom has a 60-inch shower.The entire suite is designed in a fashion to allow mobility impaired accessibility.', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`email`);

--
-- Indici per le tabelle `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`codice`),
  ADD KEY `resClient` (`client`),
  ADD KEY `resRoom` (`room`);

--
-- Indici per le tabelle `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`codice`);

--
-- Indici per le tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `reservations`
--
ALTER TABLE `reservations`
  MODIFY `codice` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT per la tabella `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `resClient` FOREIGN KEY (`client`) REFERENCES `clients` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `resRoom` FOREIGN KEY (`room`) REFERENCES `rooms` (`codice`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
