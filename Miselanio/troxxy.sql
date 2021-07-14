-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-07-2021 a las 09:53:18
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 8.0.2

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `troxxy`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuota`
--

CREATE TABLE `cuota` (
  `idCuota` int(3) NOT NULL,
  `DetalleCuota` varchar(40) NOT NULL,
  `FechaVenc` date NOT NULL,
  `ImporteCuo` decimal(9,2) DEFAULT NULL,
  `ImporteCom` decimal(9,2) NOT NULL,
  `CodigoBus` varchar(14) NOT NULL,
  `CodServicio` int(3) UNSIGNED ZEROFILL NOT NULL,
  `Status` enum('Pendiente','Validando','Pagado','') DEFAULT NULL,
  `DocCondominio` int(8) UNSIGNED ZEROFILL NOT NULL,
  `NumCuota` int(2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELACIONES PARA LA TABLA `cuota`:
--   `CodigoBus`
--       `ordenpago` -> `CodigoBusqueda`
--

--
-- Volcado de datos para la tabla `cuota`
--

INSERT INTO `cuota` VALUES(1, 'Cuota del mes de agosto', '2021-08-13', '750.00', '0.00', 'CL20:59:30.381', 002, 'Pendiente', 12345678, 0);
INSERT INTO `cuota` VALUES(2, 'Cuota del mes de septiembre', '2021-09-13', '750.00', '0.00', 'CL20:59:30.381', 002, 'Pendiente', 12345678, 1);
INSERT INTO `cuota` VALUES(3, 'Cuota del mes de octubre', '2021-10-13', '750.00', '0.00', 'CL20:59:30.381', 002, 'Pendiente', 12345678, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallepago`
--

CREATE TABLE `detallepago` (
  `Id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `NumCuota` int(3) UNSIGNED ZEROFILL NOT NULL,
  `ImporteCuota` float(9,2) NOT NULL,
  `DetalleCuota` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELACIONES PARA LA TABLA `detallepago`:
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `deuda`
--

CREATE TABLE `deuda` (
  `Id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `CodigoBus` varchar(14) NOT NULL,
  `CodServicio` int(3) UNSIGNED ZEROFILL NOT NULL,
  `ImporteAde` decimal(9,2) NOT NULL,
  `ImporteMin` decimal(9,2) NOT NULL,
  `ImporteCom` decimal(9,2) NOT NULL,
  `DocCondominio` varchar(8) NOT NULL,
  `Status` enum('Pendiente','Validando','Pagado','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELACIONES PARA LA TABLA `deuda`:
--   `CodigoBus`
--       `ordenpago` -> `CodigoBusqueda`
--

--
-- Volcado de datos para la tabla `deuda`
--

INSERT INTO `deuda` VALUES(002, 'CL21:11:23.207', 001, '300.00', '0.00', '0.00', '12345678', 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenpago`
--

CREATE TABLE `ordenpago` (
  `Id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `CodigoBusqueda` varchar(14) NOT NULL,
  `NomCliente` varchar(40) NOT NULL,
  `Documento` varchar(8) NOT NULL,
  `Numcasa` varchar(10) NOT NULL,
  `Valor` float(9,2) NOT NULL,
  `Servicio` varchar(32) DEFAULT NULL,
  `CodServicio` int(3) UNSIGNED ZEROFILL NOT NULL,
  `Formapago` varchar(25) DEFAULT NULL,
  `NumCuotas` int(2) DEFAULT NULL,
  `Status` enum('Pendiente','Validando','Pagado','') NOT NULL,
  `ImpAde` float(9,2) NOT NULL,
  `ImpMin` float(9,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELACIONES PARA LA TABLA `ordenpago`:
--

--
-- Volcado de datos para la tabla `ordenpago`
--

INSERT INTO `ordenpago` VALUES(001, 'CL20:59:30.381', 'PABLO PEREZ GUERRA', '12345678', '123-45', 2250.00, '2. Reservas Arias sociales', 002, 'Pago a Cuotas', 3, 'Pendiente', 0.00, 0.00);
INSERT INTO `ordenpago` VALUES(002, 'CL21:11:23.207', 'PABLO PEREZ GUERRA', '12345678', '123-45', 300.00, '1. Gastos comunes', 001, 'Pago Unico', 1, 'Pendiente', 300.00, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `CodServicio` int(3) UNSIGNED ZEROFILL NOT NULL,
  `Descripcion` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELACIONES PARA LA TABLA `servicio`:
--

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` VALUES(001, '1. Gastos comunes');
INSERT INTO `servicio` VALUES(002, '2. Reservas Arias sociales');
INSERT INTO `servicio` VALUES(003, '3. Consumos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipopago`
--

CREATE TABLE `tipopago` (
  `id` int(3) UNSIGNED ZEROFILL NOT NULL,
  `Descripcion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELACIONES PARA LA TABLA `tipopago`:
--

--
-- Volcado de datos para la tabla `tipopago`
--

INSERT INTO `tipopago` VALUES(001, 'Pago Unico');
INSERT INTO `tipopago` VALUES(002, 'Pago a Cuotas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transaccion`
--

CREATE TABLE `transaccion` (
  `Id` int(8) UNSIGNED ZEROFILL NOT NULL,
  `fechaPago` date NOT NULL,
  `MontoTotal` float(9,2) NOT NULL,
  `NombreFactura` varchar(40) DEFAULT NULL,
  `NIT` int(8) DEFAULT NULL,
  `LugarPago` varchar(14) DEFAULT NULL,
  `CodigoBus` varchar(14) NOT NULL,
  `Status` enum('Validando','Pagado','Devuelto','','') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELACIONES PARA LA TABLA `transaccion`:
--   `CodigoBus`
--       `ordenpago` -> `CodigoBusqueda`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `Id` int(2) UNSIGNED NOT NULL,
  `Usuario` varchar(8) NOT NULL,
  `Contraseña` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- RELACIONES PARA LA TABLA `users`:
--

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` VALUES(1, 'admin', 'admin');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cuota`
--
ALTER TABLE `cuota`
  ADD PRIMARY KEY (`idCuota`),
  ADD KEY `DocCondominio` (`DocCondominio`),
  ADD KEY `CodigoBus` (`CodigoBus`);

--
-- Indices de la tabla `detallepago`
--
ALTER TABLE `detallepago`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `deuda`
--
ALTER TABLE `deuda`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `CodigoBus` (`CodigoBus`),
  ADD KEY `CodServicio` (`CodServicio`),
  ADD KEY `idCondominio` (`DocCondominio`);

--
-- Indices de la tabla `ordenpago`
--
ALTER TABLE `ordenpago`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `CodigoBusqueda` (`CodigoBusqueda`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`CodServicio`);

--
-- Indices de la tabla `tipopago`
--
ALTER TABLE `tipopago`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `transaccion`
--
ALTER TABLE `transaccion`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `id_cond` (`CodigoBus`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Usuario` (`Usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cuota`
--
ALTER TABLE `cuota`
  MODIFY `idCuota` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detallepago`
--
ALTER TABLE `detallepago`
  MODIFY `Id` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `deuda`
--
ALTER TABLE `deuda`
  MODIFY `Id` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ordenpago`
--
ALTER TABLE `ordenpago`
  MODIFY `Id` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `transaccion`
--
ALTER TABLE `transaccion`
  MODIFY `Id` int(8) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `Id` int(2) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cuota`
--
ALTER TABLE `cuota`
  ADD CONSTRAINT `cuota_ibfk_1` FOREIGN KEY (`CodigoBus`) REFERENCES `ordenpago` (`CodigoBusqueda`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `deuda`
--
ALTER TABLE `deuda`
  ADD CONSTRAINT `deuda_ibfk_1` FOREIGN KEY (`CodigoBus`) REFERENCES `ordenpago` (`CodigoBusqueda`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `transaccion`
--
ALTER TABLE `transaccion`
  ADD CONSTRAINT `transaccion_ibfk_1` FOREIGN KEY (`CodigoBus`) REFERENCES `ordenpago` (`CodigoBusqueda`) ON DELETE CASCADE ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
