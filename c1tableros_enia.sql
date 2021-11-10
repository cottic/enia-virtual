-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 10-11-2021 a las 10:41:35
-- Versión del servidor: 10.1.48-MariaDB-0+deb9u2
-- Versión de PHP: 7.3.31-1+0~20210923.88+debian9~1.gbpac4058

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `c1tableros_enia`
--
CREATE DATABASE IF NOT EXISTS `c1tableros_enia` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `c1tableros_enia`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `01_agentes-contratades`
--

CREATE TABLE `01_agentes-contratades` (
  `apellido` varchar(22) DEFAULT NULL,
  `nombre` varchar(31) DEFAULT NULL,
  `dni` int(9) DEFAULT NULL,
  `nacimiento` varchar(10) DEFAULT NULL,
  `formacion_profesional` varchar(68) DEFAULT NULL,
  ` num_contrato` int(9) DEFAULT NULL,
  `fecha_de_alta` varchar(6) DEFAULT NULL,
  `estado_contractual` varchar(15) DEFAULT NULL,
  `fecha_de_baja` varchar(6) DEFAULT NULL,
  `programa` varchar(14) DEFAULT NULL,
  `rol_en_territorio` varchar(46) DEFAULT NULL,
  `provincia` varchar(12) DEFAULT NULL,
  `departamento` varchar(21) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `01_agentes-contratades_r20210628`
--

CREATE TABLE `01_agentes-contratades_r20210628` (
  `apellido` varchar(22) DEFAULT NULL,
  `nombre` varchar(31) DEFAULT NULL,
  `dni` int(9) DEFAULT NULL,
  `nacimiento` varchar(10) DEFAULT NULL,
  `formacion_profesional` varchar(68) DEFAULT NULL,
  ` num_contrato` int(9) DEFAULT NULL,
  `fecha_de_alta` varchar(6) DEFAULT NULL,
  `estado_contractual` varchar(15) DEFAULT NULL,
  `fecha_de_baja` varchar(6) DEFAULT NULL,
  `programa` varchar(14) DEFAULT NULL,
  `rol_en_territorio` varchar(46) DEFAULT NULL,
  `provincia` varchar(12) DEFAULT NULL,
  `departamento` varchar(21) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `02_padron-escuelas-provincias`
--

CREATE TABLE `02_padron-escuelas-provincias` (
  `cue` int(9) NOT NULL,
  `jurisdiccion` varchar(19) DEFAULT NULL,
  `nombre` varchar(111) DEFAULT NULL,
  `sector` varchar(18) DEFAULT NULL,
  `ambito` varchar(15) DEFAULT NULL,
  `domicilio` varchar(148) DEFAULT NULL,
  `cp` varchar(9) DEFAULT NULL,
  `codigo_de_area` varchar(14) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `codigo_localidad` int(8) DEFAULT NULL,
  `localidad` varchar(50) DEFAULT NULL,
  `departamento` varchar(29) DEFAULT NULL,
  `email` varchar(189) DEFAULT NULL,
  `longitud` varchar(29) DEFAULT NULL,
  `latitud` varchar(29) DEFAULT NULL,
  `ubicación` varchar(10) DEFAULT NULL,
  `ed_comun` varchar(1) DEFAULT NULL,
  `ed_especial` varchar(1) DEFAULT NULL,
  `ed_adultos` varchar(1) DEFAULT NULL,
  `ed_artistica` varchar(1) DEFAULT NULL,
  `ed_hospitalaria_domiciliaria` varchar(1) DEFAULT NULL,
  `ed_intercultural_bilingue` varchar(1) DEFAULT NULL,
  `ed_contexto_de_encierro` varchar(1) DEFAULT NULL,
  `jardin_maternal` varchar(1) DEFAULT NULL,
  `inicial` varchar(1) DEFAULT NULL,
  `primaria` varchar(1) DEFAULT NULL,
  `secundaria` varchar(1) DEFAULT NULL,
  `secundaria_tecnica_INET` varchar(1) DEFAULT NULL,
  `superior_no_universitario` varchar(1) DEFAULT NULL,
  `superior_no_universitario_INET` varchar(1) DEFAULT NULL,
  `cursos_y_talleres` varchar(1) DEFAULT NULL,
  `educacion_temprana` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `04_metas_dispensa`
--

CREATE TABLE `04_metas_dispensa` (
  `departamento` varchar(21) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `meta` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `11_SSyR-agentes-territoriales`
--

CREATE TABLE `11_SSyR-agentes-territoriales` (
  `efector_sissa` varchar(15) NOT NULL,
  `efector_nombre` varchar(90) DEFAULT NULL,
  `efector_nombre_popular` varchar(53) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `departamento` varchar(22) DEFAULT NULL,
  `localidad` varchar(40) DEFAULT NULL,
  `localidad_bahra` varchar(12) DEFAULT NULL,
  `medico_cuit` varchar(11) DEFAULT NULL,
  `medico_apellido` varchar(14) DEFAULT NULL,
  `medico_nombre` varchar(20) DEFAULT NULL,
  `medico_email` varchar(30) DEFAULT NULL,
  `obstetrico_cuit` varchar(11) DEFAULT NULL,
  `obstetrico_apellido` varchar(14) DEFAULT NULL,
  `obstetrico_nombre` varchar(22) DEFAULT NULL,
  `obstetrico_email` varchar(29) DEFAULT NULL,
  `psicosocial_cuit` varchar(11) DEFAULT NULL,
  `psicosocial_apellido` varchar(17) DEFAULT NULL,
  `psicosocial_nombre` varchar(18) DEFAULT NULL,
  `psicosocial_email` varchar(33) DEFAULT NULL,
  `psicosocial2_cuit` varchar(11) DEFAULT NULL,
  `psicosocial2_apellido` varchar(9) DEFAULT NULL,
  `psicosocial2_nombre` varchar(14) DEFAULT NULL,
  `psicosocial2_email` varchar(29) DEFAULT NULL,
  `observaciones` varchar(51) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `12_SSyR-capacitaciones-personal-salud`
--

CREATE TABLE `12_SSyR-capacitaciones-personal-salud` (
  `fecha` varchar(10) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `lugar` varchar(90) DEFAULT NULL,
  `departamento` varchar(22) DEFAULT NULL,
  `nombre` varchar(143) DEFAULT NULL,
  `tematica` varchar(27) DEFAULT NULL,
  `tematica_agrupada` varchar(14) DEFAULT NULL,
  `asistente_nombre` varchar(37) DEFAULT NULL,
  `asisente_edad` int(4) DEFAULT NULL,
  `asistente_dni` varchar(11) DEFAULT NULL,
  `asisente_genero` varchar(27) DEFAULT NULL,
  `asistente_ocupacion` varchar(19) DEFAULT NULL,
  `especialidad_de_lxs_medicxs` varchar(29) DEFAULT NULL,
  `especificacion_de_otra_ocupacion` varchar(53) DEFAULT NULL,
  `cargo` varchar(56) DEFAULT NULL,
  `area_y_tarea_q_desempenia` varchar(227) DEFAULT NULL,
  `institucion` varchar(8) DEFAULT NULL,
  `sisa` varchar(15) DEFAULT NULL,
  `asistente_servicio_salud_nombre` varchar(90) DEFAULT NULL,
  `asistente_servicio_salud_provincia` varchar(19) DEFAULT NULL,
  `asistente_servicio_salud_departamento` varchar(29) DEFAULT NULL,
  `asistente_servicio_salud_localidad` varchar(40) DEFAULT NULL,
  `asistente_telefono` varchar(21) DEFAULT NULL,
  `asistente_fax` varchar(12) DEFAULT NULL,
  `asistente_mail` varchar(41) DEFAULT NULL,
  `asistente_web` varchar(8) DEFAULT NULL,
  `observaciones` varchar(24) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `13_SSyR-efectores-salud`
--

CREATE TABLE `13_SSyR-efectores-salud` (
  `refes_sissa` varchar(27) DEFAULT NULL,
  `nombre` varchar(102) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `departamento` varchar(29) DEFAULT NULL,
  `localidad` varchar(46) DEFAULT NULL,
  `tipo_servcio` varchar(8) DEFAULT NULL,
  `ss_enia` varchar(31) DEFAULT NULL,
  `caps_bajo_plan` varchar(14) DEFAULT NULL,
  `geolocalizacion` varchar(14) DEFAULT NULL,
  `cobertura_distribucion` varchar(14) DEFAULT NULL,
  `domicilio_efector` varchar(98) DEFAULT NULL,
  `depto_enia` varchar(20) DEFAULT NULL,
  `movimiento_en_base_efectores` varchar(21) DEFAULT NULL,
  `detalle_movimiento` varchar(139) DEFAULT NULL,
  `fecha_movimiento` varchar(10) DEFAULT NULL,
  `nombre_popular` varchar(40) DEFAULT NULL,
  `origen_del_financiamiento` varchar(7) DEFAULT NULL,
  `cod_remediar_1` varchar(6) DEFAULT NULL,
  `cod_remediar_2` varchar(6) DEFAULT NULL,
  `cod_remediar_3` varchar(6) DEFAULT NULL,
  `cod_remediar_4` varchar(6) DEFAULT NULL,
  `cod_remediar_5` varchar(6) DEFAULT NULL,
  `cod_remediar_6` varchar(6) DEFAULT NULL,
  `localidad_bahra` varchar(12) DEFAULT NULL,
  `latitud` varchar(20) DEFAULT NULL,
  `longitud` varchar(20) DEFAULT NULL,
  `vinculacion_con_refes` varchar(41) DEFAULT NULL,
  `dependencia` varchar(33) DEFAULT NULL,
  `observaciones` varchar(58) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `14_SSyR-larcs`
--

CREATE TABLE `14_SSyR-larcs` (
  `id` varchar(256) DEFAULT NULL,
  `efector_redes_siisa` varchar(256) DEFAULT NULL,
  `fecha_carga` varchar(256) DEFAULT NULL,
  `colocacion_fecha` varchar(256) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `anio_mes` varchar(256) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `departamento_enia` int(4) DEFAULT NULL,
  `metodo_aplicado` varchar(256) DEFAULT NULL,
  `metodo_agru` int(1) DEFAULT NULL,
  `grupo_etario` int(1) DEFAULT NULL,
  `aipe` varchar(256) DEFAULT NULL,
  `tipo_e_s` int(4) DEFAULT NULL,
  `mes_str` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `14_SSyR-larcs_v2021_03`
--

CREATE TABLE `14_SSyR-larcs_v2021_03` (
  `efector_redes_siisa` varchar(256) DEFAULT NULL,
  `fecha_carga` varchar(256) DEFAULT NULL,
  `practica_tipo` varchar(256) DEFAULT NULL,
  `metodo_aplicado` varchar(256) DEFAULT NULL,
  `metodo_agru` int(1) DEFAULT NULL,
  `colocacion_fecha` varchar(256) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `aipe` varchar(256) DEFAULT NULL,
  `usuar_nombre` varchar(256) DEFAULT NULL,
  `usuar_apellido` varchar(256) DEFAULT NULL,
  `usuar_edad` varchar(256) DEFAULT NULL,
  `grupo_etario` int(1) DEFAULT NULL,
  `usuar_nacimiento` varchar(256) DEFAULT NULL,
  `usuar_dni` varchar(256) DEFAULT NULL,
  `usuar_localidad` varchar(256) DEFAULT NULL,
  `usuar_departamento` varchar(256) DEFAULT NULL,
  `usuar_dpto_codigo` varchar(256) DEFAULT NULL,
  `usuar_provincia` varchar(256) DEFAULT NULL,
  `usuar_pcia_codigo` varchar(256) DEFAULT NULL,
  `usuar_codigo_area` varchar(256) DEFAULT NULL,
  `usuar_numero` varchar(256) DEFAULT NULL,
  `usuar_discapacidad` varchar(256) DEFAULT NULL,
  `usar_tipo_discap_1` varchar(256) DEFAULT NULL,
  `usar_tipo_discap_2` varchar(256) DEFAULT NULL,
  `usuar_n_parto` varchar(256) DEFAULT NULL,
  `usuar_n_cesareas` varchar(256) DEFAULT NULL,
  `usuar_n_abortos` varchar(256) DEFAULT NULL,
  `usuar_eo` varchar(256) DEFAULT NULL,
  `usuar_aco` varchar(256) DEFAULT NULL,
  `usuar_acolac` varchar(256) DEFAULT NULL,
  `usuar_aci_mensual` varchar(256) DEFAULT NULL,
  `usuar_aci_trim` varchar(256) DEFAULT NULL,
  `usuar_diu` varchar(256) DEFAULT NULL,
  `usuar_lng` varchar(256) DEFAULT NULL,
  `usuar_implante` varchar(256) DEFAULT NULL,
  `usuar_preserva` varchar(256) DEFAULT NULL,
  `usuar_otro_mac` varchar(256) DEFAULT NULL,
  `usuar_sin_mac` varchar(256) DEFAULT NULL,
  `tipo_e_s` int(4) DEFAULT NULL,
  `e_nombre` varchar(256) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `efector_pcia_codigo` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `efector_dpto_codigo` varchar(256) DEFAULT NULL,
  `remediar` varchar(256) DEFAULT NULL,
  `localidad` varchar(256) DEFAULT NULL,
  `profesional` varchar(256) DEFAULT NULL,
  `observaciones` varchar(256) DEFAULT NULL,
  `departamento_enia` int(4) DEFAULT NULL,
  `grupos` varchar(256) DEFAULT NULL,
  `grupos_num` varchar(256) DEFAULT NULL,
  `et_ssyr` varchar(256) DEFAULT NULL,
  `seleccion` varchar(256) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `14_SSyR-larcs_v2021_06`
--

CREATE TABLE `14_SSyR-larcs_v2021_06` (
  `id` varchar(256) DEFAULT NULL,
  `efector_redes_siisa` varchar(256) DEFAULT NULL,
  `fecha_carga` varchar(256) DEFAULT NULL,
  `colocacion_fecha` varchar(256) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `mes_str` varchar(2) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `departamento_enia` int(4) DEFAULT NULL,
  `metodo_aplicado` varchar(256) DEFAULT NULL,
  `metodo_agru` int(1) DEFAULT NULL,
  `grupo_etario` int(1) DEFAULT NULL,
  `aipe` varchar(256) DEFAULT NULL,
  `tipo_e_s` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `15_SSyR-distribucion-MAC-a-depositos-provinciales`
--

CREATE TABLE `15_SSyR-distribucion-MAC-a-depositos-provinciales` (
  `anio` int(4) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `implantes_subdermicos` int(5) DEFAULT NULL,
  `suma_de_diu_t` varchar(4) DEFAULT NULL,
  `preservativos_144u` varchar(3) DEFAULT NULL,
  `inyectable_trimestral` varchar(4) DEFAULT NULL,
  `anticoncepcion_hormonal_de_emergencia` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `16_SSyR-distribucion-MAC-a-centro-de-salud`
--

CREATE TABLE `16_SSyR-distribucion-MAC-a-centro-de-salud` (
  `fecha_carga` varchar(10) DEFAULT NULL,
  `fecha_entrega_efector` varchar(5) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `mes_anio` varchar(15) DEFAULT NULL,
  `metodo` int(1) DEFAULT NULL,
  `metodo_agru` int(1) DEFAULT NULL,
  `cantidad_entregada` int(3) DEFAULT NULL,
  `refes_o_sissa` varchar(15) DEFAULT NULL,
  `nombre` varchar(84) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `provincia_codigo` varchar(4) NOT NULL,
  `departamento` varchar(22) DEFAULT NULL,
  `departamento_codigo` varchar(10) NOT NULL,
  `localidad` varchar(40) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `21_DIAJU-agentes-territoriales`
--

CREATE TABLE `21_DIAJU-agentes-territoriales` (
  `id` varchar(256) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `pcia_codigo` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `dpto_codigo` varchar(256) DEFAULT NULL,
  `localizacion_tipo` varchar(256) DEFAULT NULL,
  `estado` varchar(256) DEFAULT NULL,
  `anio_mes_entrega` varchar(256) DEFAULT NULL,
  `anio` varchar(4) NOT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `21_DIAJU-agentes-territoriales_v20210705`
--

CREATE TABLE `21_DIAJU-agentes-territoriales_v20210705` (
  `id` varchar(15) DEFAULT NULL,
  `provincia` varchar(12) DEFAULT NULL,
  `efector_pcia_codigo` int(2) DEFAULT NULL,
  `departamento` varchar(18) DEFAULT NULL,
  `efector_dpto_codigo` int(5) DEFAULT NULL,
  `efector_localidad_bahra` varchar(14) DEFAULT NULL,
  `efector_numero_asociacion` int(1) DEFAULT NULL,
  `efector_cue_sissa` varchar(14) DEFAULT NULL,
  `localizacion_tipo` int(2) DEFAULT NULL,
  `escuela_cue` varchar(1) DEFAULT NULL,
  `escuela_nombre` varchar(1) DEFAULT NULL,
  `efector_siisa` varchar(1) DEFAULT NULL,
  `efector_nombre` varchar(1) DEFAULT NULL,
  `localizacion_nombre` varchar(17) DEFAULT NULL,
  `espacio_comunitario_nombre` varchar(1) DEFAULT NULL,
  `plataforma_nombre` varchar(17) DEFAULT NULL,
  `localizacion_telefono` varchar(14) DEFAULT NULL,
  `escuela_telefono` varchar(1) DEFAULT NULL,
  `efector_telefono` varchar(1) DEFAULT NULL,
  `espacio_comunitario_telefono` varchar(1) DEFAULT NULL,
  `localizacion_direccion` int(4) DEFAULT NULL,
  `escuela_direccion` varchar(1) DEFAULT NULL,
  `efector_direccion` varchar(1) DEFAULT NULL,
  `espacio_comunitario_direccion` varchar(1) DEFAULT NULL,
  `plataforma_direccion` int(4) DEFAULT NULL,
  `uso_plataforma` decimal(4,3) DEFAULT NULL,
  `efector_siisa_asociado` bigint(14) DEFAULT NULL,
  `estado` int(1) DEFAULT NULL,
  `agente_nombre` varchar(9) DEFAULT NULL,
  `agente_apellido` varchar(5) DEFAULT NULL,
  `agente_cuit` varchar(14) DEFAULT NULL,
  `agente_email` varchar(25) DEFAULT NULL,
  `agente_telefono` int(10) DEFAULT NULL,
  `turno_protegido_modalidad_1` int(1) DEFAULT NULL,
  `turno_protegido_modalidad_2` int(1) DEFAULT NULL,
  `turno_protegido_gestion_1` int(2) DEFAULT NULL,
  `turno_protegido_gestion_2` int(2) DEFAULT NULL,
  `asesoria_espacio_tipo` int(1) DEFAULT NULL,
  `mapa_recursos` int(1) DEFAULT NULL,
  `momento_implementacion` int(1) DEFAULT NULL,
  `acta_acuerdo` int(1) DEFAULT NULL,
  `asesoria_modalidad` int(1) DEFAULT NULL,
  `asesoria_perioricidad` int(1) DEFAULT NULL,
  `asesoria_horario_lunes` varchar(1) DEFAULT NULL,
  `asesoria_horario_martes` varchar(1) DEFAULT NULL,
  `asesoria_horario_miercoles` varchar(1) DEFAULT NULL,
  `asesoria_horario_jueves` varchar(1) DEFAULT NULL,
  `asesoria_horario_viernes` varchar(1) DEFAULT NULL,
  `asesoria_horario_sabado` varchar(1) DEFAULT NULL,
  `comentarios` varchar(1) DEFAULT NULL,
  `entrega_fecha_anio_mes` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `21_DIAJU-agentes-territoriales_v20210811`
--

CREATE TABLE `21_DIAJU-agentes-territoriales_v20210811` (
  `id` varchar(256) DEFAULT NULL,
  `provincia` varchar(12) DEFAULT NULL,
  `efector_pcia_cod` varchar(256) DEFAULT NULL,
  `departamento` varchar(18) DEFAULT NULL,
  `efector_dpto_cod` varchar(256) DEFAULT NULL,
  `agente_localidad_bahra` varchar(256) DEFAULT NULL,
  `efector_numero_asociacion` varchar(256) DEFAULT NULL,
  `localizacion_tipo` int(2) DEFAULT NULL,
  `localiza_cue_sissa` varchar(256) DEFAULT NULL,
  `localizacion_nombre` varchar(256) DEFAULT NULL,
  `espacio_comunitario_nombre` varchar(256) DEFAULT NULL,
  `localizacion_telefono` varchar(256) DEFAULT NULL,
  `localizacion_direccion` varchar(256) DEFAULT NULL,
  `escuela_cue` varchar(256) DEFAULT NULL,
  `escuela_nombre` varchar(256) DEFAULT NULL,
  `escuela_telefono` varchar(256) DEFAULT NULL,
  `escuela_direccion` varchar(256) DEFAULT NULL,
  `efector_siisa` varchar(256) DEFAULT NULL,
  `efector_nombre` varchar(256) DEFAULT NULL,
  `efector_telefono` varchar(256) DEFAULT NULL,
  `efector_direccion` varchar(256) DEFAULT NULL,
  `espacio_comunitario_direccion` varchar(256) DEFAULT NULL,
  `espacio_comunitario_telefono` varchar(256) DEFAULT NULL,
  `plataforma_nombre` varchar(256) DEFAULT NULL,
  `plataforma_direccion` varchar(256) DEFAULT NULL,
  `uso_plataforma` varchar(256) DEFAULT NULL,
  `efector_siisa_asociado` varchar(256) DEFAULT NULL,
  `estado` varchar(256) DEFAULT NULL,
  `agente_nombre` varchar(256) DEFAULT NULL,
  `agente_apellido` varchar(256) DEFAULT NULL,
  `agente_cuit` varchar(256) DEFAULT NULL,
  `agente_email` varchar(256) DEFAULT NULL,
  `agente_telefono` varchar(256) DEFAULT NULL,
  `turno_protegido_modalidad_1` varchar(256) DEFAULT NULL,
  `turno_protegido_modalidad_2` varchar(256) DEFAULT NULL,
  `turno_protegido_gestion_1` varchar(256) DEFAULT NULL,
  `turno_protegido_gestion_2` varchar(256) DEFAULT NULL,
  `asesoria_espacio_tipo` varchar(256) DEFAULT NULL,
  `mapa_recursos` varchar(256) DEFAULT NULL,
  `momento_implementacion` varchar(256) DEFAULT NULL,
  `acta_acuerdo` varchar(256) DEFAULT NULL,
  `asesoria_modalidad` varchar(256) DEFAULT NULL,
  `asesoria_perioricidad` varchar(256) DEFAULT NULL,
  `asesoria_horario_lunes` varchar(256) DEFAULT NULL,
  `asesoria_horario_lunes_inic_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_lunes_fin_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_lunes_inic_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_lunes_fin_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_martes` varchar(256) DEFAULT NULL,
  `asesoria_horario_martes_inic_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_martes_fin_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_martes_inic_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_martes_fin_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_miercoles` varchar(256) DEFAULT NULL,
  `asesoria_horario_miercoles_inic_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_miercoles_fin_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_miercoles_inic_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_miercoles_fin_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_jueves` varchar(256) DEFAULT NULL,
  `asesoria_horario_jueves_inic_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_jueves_fin_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_jueves_inic_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_jueves_fin_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_viernes` varchar(256) DEFAULT NULL,
  `asesoria_horario_viernes_inic_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_viernes_fin_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_viernes_inic_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_viernes_fin_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_sabado` varchar(256) DEFAULT NULL,
  `asesoria_horario_sabado_inic_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_sabado_fin_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_sabado_inic_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_sabado_fin_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_domingo_inic_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_domingo_fin_1` varchar(256) DEFAULT NULL,
  `asesoria_horario_domingo_inic_2` varchar(256) DEFAULT NULL,
  `asesoria_horario_domingo_fin_2` varchar(256) DEFAULT NULL,
  `comentarios` varchar(256) DEFAULT NULL,
  `entrega_fecha_anio_mes` varchar(256) DEFAULT NULL,
  `localizacion_tipo_2` varchar(256) DEFAULT NULL,
  `a_omes` varchar(256) DEFAULT NULL,
  `filter_dispositivo` varchar(256) DEFAULT NULL,
  `apellynom_asesor_a` varchar(256) DEFAULT NULL,
  `localizacion_tipo_agrupada` varchar(256) DEFAULT NULL,
  `filter_dispositivo_mensajeria` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `22_DIAJU-planilla-B`
--

CREATE TABLE `22_DIAJU-planilla-B` (
  `id` varchar(256) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `agente_nombre` varchar(256) DEFAULT NULL,
  `agente_apellido` varchar(256) DEFAULT NULL,
  `agente_cuit` varchar(256) DEFAULT NULL,
  `agente_email` varchar(256) DEFAULT NULL,
  `tipo_localiza` int(1) DEFAULT NULL,
  `escuela_cue` varchar(256) DEFAULT NULL,
  `escuela_nombre` varchar(256) DEFAULT NULL,
  `efector_cus` varchar(256) DEFAULT NULL,
  `efector_siisa` varchar(256) DEFAULT NULL,
  `efector_nombre` varchar(256) DEFAULT NULL,
  `espacio_comunitario_clase` varchar(256) DEFAULT NULL,
  `espacio_comunitario_nombre` varchar(256) DEFAULT NULL,
  `espacio_comunitario_localidad` varchar(256) DEFAULT NULL,
  `virtual_nombre` varchar(256) DEFAULT NULL,
  `vitual_otro_nombre` varchar(256) DEFAULT NULL,
  `adolesc_nombre` varchar(256) DEFAULT NULL,
  `adolesc_apellildo` varchar(256) DEFAULT NULL,
  `adolesc_dni` varchar(256) DEFAULT NULL,
  `adolesc_edad_agrup` varchar(256) DEFAULT NULL,
  `adolesc_edad` varchar(256) DEFAULT NULL,
  `adolesc_fecha_nac` varchar(256) DEFAULT NULL,
  `genero_autopercibido` int(1) DEFAULT NULL,
  `adolesc_otros_genero` varchar(256) DEFAULT NULL,
  `adolesc_genero_coincide` varchar(256) DEFAULT NULL,
  `adolesc_genero_cambio_registral` varchar(256) DEFAULT NULL,
  `adolesc_capacidad_gestar` varchar(256) DEFAULT NULL,
  `adolesc_genero` varchar(256) DEFAULT NULL,
  `escolariza` int(1) DEFAULT NULL,
  `tipo_asesora` int(1) DEFAULT NULL,
  `asesora_anio_mes` varchar(256) DEFAULT NULL,
  `asesora_fecha` varchar(256) DEFAULT NULL,
  `asesora_uso_kit` varchar(256) DEFAULT NULL,
  `motivo_princip` int(1) DEFAULT NULL,
  `consulta_motivo_princip_otro` varchar(256) DEFAULT NULL,
  `situacion1_singular` varchar(256) DEFAULT NULL,
  `situacion1_convive` varchar(256) DEFAULT NULL,
  `referencia1` int(1) DEFAULT NULL,
  `situacion1_referencia_especialidad` varchar(256) DEFAULT NULL,
  `situacion1_otra_referencia` varchar(256) DEFAULT NULL,
  `situacion1_efector_referencia` varchar(256) DEFAULT NULL,
  `situacion1_cod_cus_otro` varchar(256) DEFAULT NULL,
  `situacion1_cod_siisa` varchar(256) DEFAULT NULL,
  `situacion1_otro_efector` varchar(256) DEFAULT NULL,
  `situacion2_singular_presencia` varchar(256) DEFAULT NULL,
  `consulta_motivo_secund` varchar(256) DEFAULT NULL,
  `consulta_motivo_secund_otro` varchar(256) DEFAULT NULL,
  `situacion2_singular` varchar(256) DEFAULT NULL,
  `situacion2_convive` varchar(256) DEFAULT NULL,
  `referencia2` int(1) DEFAULT NULL,
  `situacion2_referencia_especialidad` varchar(256) DEFAULT NULL,
  `situacion2_otra_referencia` varchar(256) DEFAULT NULL,
  `situacion2_efector_referencia` varchar(256) DEFAULT NULL,
  `situacion2_cod_cus_otro` varchar(256) DEFAULT NULL,
  `situacion2_cod_siisa` varchar(256) DEFAULT NULL,
  `situacion2_otro_efector` varchar(256) DEFAULT NULL,
  `observaciones` varchar(256) DEFAULT NULL,
  `fecha_entrega` varchar(256) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `adolescentes_1` varchar(256) DEFAULT NULL,
  `adolescentes_2` varchar(256) DEFAULT NULL,
  `adolescentes` varchar(256) DEFAULT NULL,
  `depto` varchar(256) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `mesa_o` varchar(256) DEFAULT NULL,
  `trimestre` varchar(256) DEFAULT NULL,
  `tramoedad` varchar(256) DEFAULT NULL,
  `edadsimple` varchar(256) DEFAULT NULL,
  `generoagrup` varchar(256) DEFAULT NULL,
  `tipo_local_2` varchar(256) DEFAULT NULL,
  `motivo_princip_agrupado` varchar(256) DEFAULT NULL,
  `motivo_segund_agrupado` varchar(256) DEFAULT NULL,
  `modalidad` varchar(256) DEFAULT NULL,
  `ref1` varchar(256) DEFAULT NULL,
  `ref2` varchar(256) DEFAULT NULL,
  `referencias` varchar(256) DEFAULT NULL,
  `filter_referencias` varchar(256) DEFAULT NULL,
  `filter_adolescentes` int(1) DEFAULT NULL,
  `nombreyapellido` varchar(256) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL,
  `agente_pcia_codigo` varchar(256) DEFAULT NULL,
  `agente_dpto_codigo` varchar(256) DEFAULT NULL,
  `tipo_localizacion_agrupado` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `22_DIAJU-planilla-B_v20210705`
--

CREATE TABLE `22_DIAJU-planilla-B_v20210705` (
  `ID_2` int(8) DEFAULT NULL,
  `PROVINCIA` varchar(200) DEFAULT NULL,
  `departamento` varchar(140) DEFAULT NULL,
  `NOM_ASESOR` varchar(16) DEFAULT NULL,
  `APELL_ASESOR` varchar(7) DEFAULT NULL,
  `CUIT_ASESOR` bigint(11) DEFAULT NULL,
  `CORREOELECTRONICO` varchar(31) DEFAULT NULL,
  `TIPO_LOCALIZA` int(1) DEFAULT NULL,
  `COD_CUE` varchar(10) DEFAULT NULL,
  `NOM_ESCUELA` varchar(60) DEFAULT NULL,
  `COD_CUS` varchar(10) DEFAULT NULL,
  `COD_SIISA` varchar(10) DEFAULT NULL,
  `NOM_SERVICIODESALUD` varchar(10) DEFAULT NULL,
  `CLASE_EC` varchar(1) DEFAULT NULL,
  `COD_EC` varchar(10) DEFAULT NULL,
  `LOCALIDAD_EC` varchar(10) DEFAULT NULL,
  `NOMBRE_PLATAFORMA` varchar(1) DEFAULT NULL,
  `OTROS_NOMBRE_PLATAFORMA` varchar(10) DEFAULT NULL,
  `NOM_ADOLESC` varchar(2) DEFAULT NULL,
  `APELL_ADOLESC` varchar(2) DEFAULT NULL,
  `DNI_ADOLESC` varchar(4) DEFAULT NULL,
  `EDAD_ADOLESC_RECOD` int(2) DEFAULT NULL,
  `EDAD_ADOLESC` int(2) DEFAULT NULL,
  `FECHA_NAC` varchar(10) DEFAULT NULL,
  `GENERO_AUTOPERCIBIDO` int(1) DEFAULT NULL,
  `OTROS_GENERO_ADOLESC` varchar(10) DEFAULT NULL,
  `GENERO_COINCIDE` int(4) DEFAULT NULL,
  `CAMBIO_REG_SEXO` int(4) DEFAULT NULL,
  `CAPACIDAD_GESTAR` int(1) DEFAULT NULL,
  `GENERO` int(1) DEFAULT NULL,
  `ESCOLARIZA` int(1) DEFAULT NULL,
  `TIPO_ASESORA` int(1) DEFAULT NULL,
  `aniomes` decimal(5,1) DEFAULT NULL,
  `FECHA_ASESORA` varchar(10) DEFAULT NULL,
  `USO_KIT` int(1) DEFAULT NULL,
  `MOTIVO_PRINCIP` int(1) DEFAULT NULL,
  `MOTIVO_PRINCIP_OTRO` varchar(10) DEFAULT NULL,
  `SIT_SINGULAR_1` varchar(1) DEFAULT NULL,
  `CONVIVE_1` varchar(1) DEFAULT NULL,
  `REFERENCIA_1` int(1) DEFAULT NULL,
  `REFERENCIA_ESPECIALIDAD_1` int(2) DEFAULT NULL,
  `OTRA_REFERENCIA_1` varchar(10) DEFAULT NULL,
  `EFECTOR_REFERENCIA_1` int(1) DEFAULT NULL,
  `COD_CUS_OTRO_1` varchar(10) DEFAULT NULL,
  `COD_SIISA_REFER_1` varchar(10) DEFAULT NULL,
  `OTRO_EFECTOR_REFERENCIA_1` varchar(10) DEFAULT NULL,
  `SI_SECUNDARIO` int(1) DEFAULT NULL,
  `MOTIVO_SEGUND` varchar(2) DEFAULT NULL,
  `MOTIVO_SEGUND_OTRO` varchar(17) DEFAULT NULL,
  `SIT_SINGULAR_2` varchar(1) DEFAULT NULL,
  `CONVIVE_2` varchar(1) DEFAULT NULL,
  `REFERENCIA_2` varchar(1) DEFAULT NULL,
  `REFERENCIA_ESPECIALIDAD_2` varchar(2) DEFAULT NULL,
  `OTRA_REFERENCIA_2` varchar(10) DEFAULT NULL,
  `EFECTOR_REFERENCIA_2` varchar(1) DEFAULT NULL,
  `COD_CUS_OTRO_2` varchar(10) DEFAULT NULL,
  `COD_SIISA_REFER_2` varchar(10) DEFAULT NULL,
  `OTRO_EFECTOR_REFERENCIA_2` varchar(10) DEFAULT NULL,
  `OBSERVACIONES` varchar(31) DEFAULT NULL,
  `FECHA_ENTREGA` varchar(10) DEFAULT NULL,
  `ID` varchar(8) DEFAULT NULL,
  `adolescentes_1` int(1) DEFAULT NULL,
  `adolescentes_2` int(1) DEFAULT NULL,
  `adolescentes` int(1) DEFAULT NULL,
  `depto` int(2) DEFAULT NULL,
  `mes` int(1) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `mesaño` int(1) DEFAULT NULL,
  `trimestre` int(1) DEFAULT NULL,
  `tramoedad` int(1) DEFAULT NULL,
  `edadsimple` int(2) DEFAULT NULL,
  `generoagrup` int(1) DEFAULT NULL,
  `TIPO_LOCAL_2` int(1) DEFAULT NULL,
  `MOTIVO_PRINCIP_agrupado` int(1) DEFAULT NULL,
  `MOTIVO_SEGUND_agrupado` varchar(1) DEFAULT NULL,
  `modalidad` int(1) DEFAULT NULL,
  `filter_referencias` int(1) DEFAULT NULL,
  `filter_adolescentes` int(1) DEFAULT NULL,
  `NombreyApellido` varchar(24) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `23_DIAJU-planilla-D`
--

CREATE TABLE `23_DIAJU-planilla-D` (
  `ID` varchar(13) DEFAULT NULL,
  `PROV` int(2) DEFAULT NULL,
  `DPTO` decimal(5,3) DEFAULT NULL,
  `NOM_ASESOR` varchar(25) DEFAULT NULL,
  `APELL_ASESOR` varchar(22) DEFAULT NULL,
  `CUIT_ASESOR` varchar(15) DEFAULT NULL,
  `EMAIL_ASESOR` varchar(38) DEFAULT NULL,
  `TIPO_LOCALIZA` int(2) DEFAULT NULL,
  `COD_CUE` varchar(10) DEFAULT NULL,
  `NOMBRE_ESCUELA` varchar(95) DEFAULT NULL,
  `LOCALIDAD_ESCUELA` varchar(45) DEFAULT NULL,
  `COD_CUS` varchar(6) DEFAULT NULL,
  `COD_SIISA` varchar(15) DEFAULT NULL,
  `NOMBRE_EFECTOR` varchar(75) DEFAULT NULL,
  `LOCALIDAD_EFECTOR` varchar(35) DEFAULT NULL,
  `CLASE_EC` varchar(7) DEFAULT NULL,
  `NOMBRE_EC` varchar(125) DEFAULT NULL,
  `LOCALIDAD_EC` varchar(40) DEFAULT NULL,
  `NOMBRE_PLATAFORMA` varchar(7) DEFAULT NULL,
  `OTROS_NOMBRE_PLATAFORMA` varchar(22) DEFAULT NULL,
  `TIPO_ACTIVIDAD` int(1) DEFAULT NULL,
  `AÑO_MES` decimal(6,2) DEFAULT NULL,
  `FECHA_ACTIVIDAD` varchar(11) DEFAULT NULL,
  `MOTIVO_PRINCIP` int(2) DEFAULT NULL,
  `MOTIVO_PRINCIP_OTRO` varchar(31) DEFAULT NULL,
  `MOTIVO_SEGUND` varchar(7) DEFAULT NULL,
  `MOTIVO_SEGUND_OTRO` varchar(399) DEFAULT NULL,
  `UTILIZO_KIT` decimal(4,3) DEFAULT NULL,
  `CANT_NIÑXS_10_14` varchar(7) DEFAULT NULL,
  `CANT_ADOLESC_15_19` varchar(7) DEFAULT NULL,
  `CANT_JOVEN_20_24` varchar(7) DEFAULT NULL,
  `CANT_ASISTENT` int(3) DEFAULT NULL,
  `CANT_DOCENT` int(2) DEFAULT NULL,
  `OBSERVACIONES` varchar(668) DEFAULT NULL,
  `FECHA_ENTREGA` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `31_DBC-agentes-territoriales`
--

CREATE TABLE `31_DBC-agentes-territoriales` (
  `id` varchar(256) DEFAULT NULL,
  `pcia_codigo` varchar(256) DEFAULT NULL,
  `dpto_codigo` varchar(256) DEFAULT NULL,
  `localizacion_tipo` varchar(256) DEFAULT NULL,
  `estado` varchar(256) DEFAULT NULL,
  `ames_entrega` varchar(256) DEFAULT NULL,
  `anio` varchar(256) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `31_DBC-agentes-territoriales_v20210705`
--

CREATE TABLE `31_DBC-agentes-territoriales_v20210705` (
  `ID` varchar(14) DEFAULT NULL,
  `PROVINCIA` varchar(120) DEFAULT NULL,
  `DEPARTAMENTO` varchar(120) DEFAULT NULL,
  `LOCALIDAD_ENIA_NOMBRE_BAHRA` varchar(35) DEFAULT NULL,
  `N_ASOC` int(2) DEFAULT NULL,
  `localizacion_tipo` int(2) DEFAULT NULL,
  `CLASE_EC` varchar(68) DEFAULT NULL,
  `COD_CUE_SIISA` varchar(10) DEFAULT NULL,
  `NOM_ESCUELA_EFECTOR_EC` varchar(88) DEFAULT NULL,
  `TEL_ESCUELA_EFECTOR_EC` varchar(5) DEFAULT NULL,
  `DIREC_ESPACIO_COMUNITARIO` varchar(116) DEFAULT NULL,
  `LOCALIDAD_EC` varchar(34) DEFAULT NULL,
  `SIISA_EFECTOR_ASOC` varchar(15) DEFAULT NULL,
  `NOMBRE_EFECTOR_ASOC` varchar(62) DEFAULT NULL,
  `ASESOR_PRESENCIA` int(1) DEFAULT NULL,
  `NOM_ASESOR_A` varchar(30) DEFAULT NULL,
  `APELL_ASESOR_A` varchar(19) DEFAULT NULL,
  `DNI_ASESOR_A` int(8) DEFAULT NULL,
  `CUIT_ASESOR_A` bigint(11) DEFAULT NULL,
  `MAIL_ASESOR_A` varchar(33) DEFAULT NULL,
  `PROGRAMA_ASESOR_A` int(1) DEFAULT NULL,
  `INICIO_ASESORIA` int(1) DEFAULT NULL,
  `MODALIDAD_ASESORIA` int(1) DEFAULT NULL,
  `PERIODICIDAD` int(4) DEFAULT NULL,
  `LUNES` varchar(17) DEFAULT NULL,
  `MARTES` varchar(17) DEFAULT NULL,
  `MIERCOLES` varchar(16) DEFAULT NULL,
  `JUEVES` varchar(25) DEFAULT NULL,
  `VIERNES` varchar(16) DEFAULT NULL,
  `SABADO` varchar(17) DEFAULT NULL,
  `RESPONSABLE_NOM_APELL` varchar(28) DEFAULT NULL,
  `PRESERVATIVOS_CANT_RECIBID` varchar(7) DEFAULT NULL,
  `AÑO.MES_FECHA.ENTREGA` decimal(6,2) DEFAULT NULL,
  `SecuenciaCoincidencia` int(3) DEFAULT NULL,
  `PrimarioÚltimo` int(1) DEFAULT NULL,
  `filter_$` int(1) DEFAULT NULL,
  `EC_Unico` int(1) DEFAULT NULL,
  `Asesor_Unico` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `31_DBC-agentes-territoriales_v20210811`
--

CREATE TABLE `31_DBC-agentes-territoriales_v20210811` (
  `id` varchar(256) DEFAULT NULL,
  `registro_estado` varchar(256) DEFAULT NULL,
  `registro_comentarios` varchar(256) DEFAULT NULL,
  `provincia` varchar(120) DEFAULT NULL,
  `departamento` varchar(120) DEFAULT NULL,
  `efector_localidad_bahra` varchar(256) DEFAULT NULL,
  `efector_siisa_asociado` varchar(256) DEFAULT NULL,
  `efector_nombre_asociado` varchar(256) DEFAULT NULL,
  `turno_protegido_modalidad_1` varchar(256) DEFAULT NULL,
  `localizacion_tipo` int(2) DEFAULT NULL,
  `espacio_comunitario_nombre` varchar(256) DEFAULT NULL,
  `espacio_comunitario_codigo` varchar(256) DEFAULT NULL,
  `espacio_comunitario_direccion` varchar(256) DEFAULT NULL,
  `espacio_comunitario_localidad` varchar(256) DEFAULT NULL,
  `plataforma_nombre` varchar(256) DEFAULT NULL,
  `plataforma_nombre_otro` varchar(256) DEFAULT NULL,
  `asesoria_estado` varchar(256) DEFAULT NULL,
  `asesoria_modalidad` varchar(256) DEFAULT NULL,
  `asesoria_tipo` varchar(256) DEFAULT NULL,
  `asesoria_perioricidad` varchar(256) DEFAULT NULL,
  `asesoria_horario_lunes` varchar(256) DEFAULT NULL,
  `asesoria_horario_martes` varchar(256) DEFAULT NULL,
  `asesoria_horario_miercoles` varchar(256) DEFAULT NULL,
  `asesoria_horario_jueves` varchar(256) DEFAULT NULL,
  `asesoria_horario_viernes` varchar(256) DEFAULT NULL,
  `asesoria_horario_sabado` varchar(256) DEFAULT NULL,
  `agente_nombre` varchar(256) DEFAULT NULL,
  `agente_apellido` varchar(256) DEFAULT NULL,
  `agente_cuit` varchar(256) DEFAULT NULL,
  `agente_email` varchar(256) DEFAULT NULL,
  `agente_programa_codigo` varchar(256) DEFAULT NULL,
  `agente_dni` varchar(256) DEFAULT NULL,
  `agente_programa` varchar(256) DEFAULT NULL,
  `responsable_nombre_apellido` varchar(256) DEFAULT NULL,
  `preservativos_cantidad` varchar(256) DEFAULT NULL,
  `comentarios` varchar(256) DEFAULT NULL,
  `entrega_fecha` varchar(256) DEFAULT NULL,
  `observaciones` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `32_DBC-planilla-B`
--

CREATE TABLE `32_DBC-planilla-B` (
  `ID` varchar(12) DEFAULT NULL,
  `ID_EXTRAE` decimal(5,3) DEFAULT NULL,
  `provincia` varchar(120) DEFAULT NULL,
  `departamento` varchar(140) DEFAULT NULL,
  `NOM_ASESOR` varchar(13) DEFAULT NULL,
  `APELL_ASESOR` varchar(9) DEFAULT NULL,
  `CUIT_ASESOR` int(4) DEFAULT NULL,
  `CORREOELECTRONICO` varchar(5) DEFAULT NULL,
  `TIPO_LOCALIZA` int(2) DEFAULT NULL,
  `COD_PLAT` varchar(1) DEFAULT NULL,
  `COD_PLAT_OTROS` varchar(10) DEFAULT NULL,
  `TIPO_ASESORA` int(1) DEFAULT NULL,
  `FECHA_ASESORA` varchar(10) DEFAULT NULL,
  `NOM_ADOLESC` varchar(2) DEFAULT NULL,
  `APELL_ADOLESC` varchar(2) DEFAULT NULL,
  `DNI_ADOLESC` varchar(3) DEFAULT NULL,
  `EDAD_ADOLESC` int(2) DEFAULT NULL,
  `EDAD_ADOLESC_RECOD` int(2) DEFAULT NULL,
  `genero_autopercibido` int(1) DEFAULT NULL,
  `OTROS_GENERO_ADOLESC` varchar(10) DEFAULT NULL,
  `CAMBIO_REG_SEXO` int(4) DEFAULT NULL,
  `ESCOLARIZA` int(1) DEFAULT NULL,
  `MOTIVO_PRINCIP` int(2) DEFAULT NULL,
  `MOTIVO_PRINCIP_OTRO` varchar(10) DEFAULT NULL,
  `SIT_SINGULAR_1` varchar(4) DEFAULT NULL,
  `CONVIVE_1` varchar(4) DEFAULT NULL,
  `REFERENCIA_1` int(1) DEFAULT NULL,
  `REFERENCIA_ESPECIALIDAD_1` int(2) DEFAULT NULL,
  `OTRA_REFERENCIA_1` varchar(19) DEFAULT NULL,
  `EFECTOR_REFERENCIA_1` int(1) DEFAULT NULL,
  `COD_CUS_OTRO_1` varchar(6) DEFAULT NULL,
  `COD_SIISA_REFER_1` varchar(5) DEFAULT NULL,
  `OTRO_EFECTOR_REFERENCIA_1` varchar(14) DEFAULT NULL,
  `SI_SECUNDARIO` int(1) DEFAULT NULL,
  `MOTIVO_SEGUND` varchar(2) DEFAULT NULL,
  `MOTIVO_SEGUND_OTRO` varchar(10) DEFAULT NULL,
  `SIT_SINGULAR_2` varchar(4) DEFAULT NULL,
  `CONVIVE_2` varchar(4) DEFAULT NULL,
  `REFERENCIA_2` varchar(1) DEFAULT NULL,
  `REFERENCIA_ESPECIALIDAD_2` varchar(1) DEFAULT NULL,
  `OTRA_REFERENCIA_2` varchar(1) DEFAULT NULL,
  `EFECTOR_REFERENCIA_2` varchar(1) DEFAULT NULL,
  `COD_CUS_OTRO_2` varchar(10) DEFAULT NULL,
  `COD_SIISA_REFER_2` varchar(10) DEFAULT NULL,
  `OTRO_EFECTOR_REFERENCIA_2` varchar(10) DEFAULT NULL,
  `FECHA_NAC` varchar(8) DEFAULT NULL,
  `TIPO_EC` varchar(1) DEFAULT NULL,
  `COD_EC` varchar(24) DEFAULT NULL,
  `NEW_CODIGO_EC` varchar(1) DEFAULT NULL,
  `LOCALIDAD_EC` varchar(10) DEFAULT NULL,
  `COD_CUE` varchar(1) DEFAULT NULL,
  `NOM_ESCUELA` varchar(10) DEFAULT NULL,
  `COD_CUS` varchar(5) DEFAULT NULL,
  `COD_SIISA` varchar(5) DEFAULT NULL,
  `NOM_SERVICIODESALUD` varchar(7) DEFAULT NULL,
  `CLASE_EC` varchar(4) DEFAULT NULL,
  `AÑO_MES` decimal(6,2) DEFAULT NULL,
  `USO_KIT` int(1) DEFAULT NULL,
  `FECHA_ENTREGA` varchar(1) DEFAULT NULL,
  `OBSERVACIONES` varchar(10) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `mesaño` int(2) DEFAULT NULL,
  `trimestre` int(1) DEFAULT NULL,
  `tramoedad` int(1) DEFAULT NULL,
  `mes_cadena` int(2) DEFAULT NULL,
  `año_cadena` int(4) DEFAULT NULL,
  `ID_2` decimal(11,3) DEFAULT NULL,
  `filter_adolescentes` int(1) DEFAULT NULL,
  `filter_$` int(1) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `32_DBC_planilla_b_acum_2021_03`
--

CREATE TABLE `32_DBC_planilla_b_acum_2021_03` (
  `id` varchar(256) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `provincia_codigo` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `departamento_codigo` varchar(256) DEFAULT NULL,
  `agente_nombre` varchar(256) DEFAULT NULL,
  `agente_apellido` varchar(256) DEFAULT NULL,
  `agente_cuit` varchar(256) DEFAULT NULL,
  `agente_email` varchar(256) DEFAULT NULL,
  `efector_tipo` varchar(256) DEFAULT NULL,
  `virtual_tipo` varchar(256) DEFAULT NULL,
  `vitual_otro_nombre` varchar(256) DEFAULT NULL,
  `asesoria_tipo` varchar(256) DEFAULT NULL,
  `asesoria_fecha` varchar(256) DEFAULT NULL,
  `adolesc_nombre` varchar(256) DEFAULT NULL,
  `adolesc_apellildo` varchar(256) DEFAULT NULL,
  `adolesc_dni` varchar(256) DEFAULT NULL,
  `adolesc_edad` varchar(256) DEFAULT NULL,
  `adolesc_edad_agrup` varchar(256) DEFAULT NULL,
  `genero_autopercibido` int(1) DEFAULT NULL,
  `otros_generos_autopercibidos` varchar(256) DEFAULT NULL,
  `cambio_registral_sexo` varchar(256) DEFAULT NULL,
  `adolesc_escolarizado` varchar(256) DEFAULT NULL,
  `consulta_motivo_princ` varchar(256) DEFAULT NULL,
  `consulta_motivo_otro` varchar(256) DEFAULT NULL,
  `situacion1_singular` varchar(256) DEFAULT NULL,
  `situacion1_convive` varchar(256) DEFAULT NULL,
  `situacion1_referencia` varchar(256) DEFAULT NULL,
  `situacion1_referencia_especialidad` varchar(256) DEFAULT NULL,
  `situacion1_otra_referencia` varchar(256) DEFAULT NULL,
  `situacion1_efector_referencia` varchar(256) DEFAULT NULL,
  `situacion1_cod_cus_otro` varchar(256) DEFAULT NULL,
  `situacion1_cod_siisa` varchar(256) DEFAULT NULL,
  `situacion1_otro_efector` varchar(256) DEFAULT NULL,
  `situacion2` varchar(256) DEFAULT NULL,
  `situacion2_motivo` varchar(256) DEFAULT NULL,
  `situacion2_motivo_otro` varchar(256) DEFAULT NULL,
  `situacion2_singular` varchar(256) DEFAULT NULL,
  `situacion2_convive` varchar(256) DEFAULT NULL,
  `situacion2_referencia` varchar(256) DEFAULT NULL,
  `situacion2_referencia_especialidad` varchar(256) DEFAULT NULL,
  `situacion2_otra_referencia` varchar(256) DEFAULT NULL,
  `situacion2_efector_referencia` varchar(256) DEFAULT NULL,
  `situacion2_cod_cus_otro` varchar(256) DEFAULT NULL,
  `situacion2_cod_siisa` varchar(256) DEFAULT NULL,
  `situacion2_otro_efector` varchar(256) DEFAULT NULL,
  `adolesc_fecha_nac` varchar(256) DEFAULT NULL,
  `espacio_comunitario_tipo` varchar(256) DEFAULT NULL,
  `espacio_comunitario_codigo` varchar(256) DEFAULT NULL,
  `espacio_comunitario_codigo_nuevo` varchar(256) DEFAULT NULL,
  `espacio_comunitario_localidad` varchar(256) DEFAULT NULL,
  `escuela_cue` varchar(256) DEFAULT NULL,
  `escuela_nombre` varchar(256) DEFAULT NULL,
  `efector_cus` varchar(256) DEFAULT NULL,
  `efector_siisa` varchar(256) DEFAULT NULL,
  `efector_nombre` varchar(256) DEFAULT NULL,
  `comunitario_nombre` varchar(256) DEFAULT NULL,
  `asesora_anio_mes` varchar(256) DEFAULT NULL,
  `uso_kit` varchar(256) DEFAULT NULL,
  `fecha_entrega` varchar(256) DEFAULT NULL,
  `observaciones` varchar(256) DEFAULT NULL,
  `filter_adolescentes` int(1) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `mes_anio` varchar(256) DEFAULT NULL,
  `trimestre` varchar(256) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `33_DBC-actividades-de-convocatoria`
--

CREATE TABLE `33_DBC-actividades-de-convocatoria` (
  `id` varchar(15) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `nombre_actividad` varchar(210) DEFAULT NULL,
  `tipo` int(4) DEFAULT NULL,
  `fecha` varchar(10) DEFAULT NULL,
  `provincia` int(2) DEFAULT NULL,
  `departamento` int(5) DEFAULT NULL,
  `localidad` varchar(35) DEFAULT NULL,
  `barrio` varchar(86) DEFAULT NULL,
  `tipo_localizacion` int(2) DEFAULT NULL,
  `institucion1_tipo` varchar(4) DEFAULT NULL,
  `institucion1_nombre` varchar(158) DEFAULT NULL,
  `institucion2_tipo` varchar(4) DEFAULT NULL,
  `institucion2_nombre` varchar(121) DEFAULT NULL,
  `particpantes_10a12` varchar(3) DEFAULT NULL,
  `participantes_13a24` varchar(4) DEFAULT NULL,
  `estimacion_adolescentes` varchar(4) DEFAULT NULL,
  `turnos_protegidos_gestionados` int(2) DEFAULT NULL,
  `turnos_asesoramientos_gestionados` int(2) DEFAULT NULL,
  `participantes_25mas` varchar(3) DEFAULT NULL,
  `nomina` int(4) DEFAULT NULL,
  `source01` int(1) DEFAULT NULL,
  `actividad_ninios` varchar(1) DEFAULT NULL,
  `actividad_adolescentes` varchar(1) DEFAULT NULL,
  `actividad_adultos` varchar(1) DEFAULT NULL,
  `actividad_adole_esti` varchar(1) DEFAULT NULL,
  `destinatarios` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `41_ESI-agentes-territoriales`
--

CREATE TABLE `41_ESI-agentes-territoriales` (
  `cuela_cue` varchar(10) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `departamento` varchar(22) DEFAULT NULL,
  `escuela_localidad` varchar(45) DEFAULT NULL,
  `escuela_numero_asociacion_esi` varchar(8) DEFAULT NULL,
  `escuela_nombre` varchar(97) DEFAULT NULL,
  `nombre` varchar(25) DEFAULT NULL,
  `apellido` varchar(20) DEFAULT NULL,
  `dni` varchar(17) DEFAULT NULL,
  `observaciones_escuela` varchar(313) DEFAULT NULL,
  `V11` varchar(1) DEFAULT NULL,
  `V12` varchar(1) DEFAULT NULL,
  `V13` varchar(1) DEFAULT NULL,
  `V14` varchar(1) DEFAULT NULL,
  `V15` varchar(1) DEFAULT NULL,
  `V16` varchar(1) DEFAULT NULL,
  `V17` varchar(1) DEFAULT NULL,
  `V18` varchar(1) DEFAULT NULL,
  `V19` varchar(1) DEFAULT NULL,
  `V20` varchar(1) DEFAULT NULL,
  `V21` varchar(1) DEFAULT NULL,
  `V22` varchar(1) DEFAULT NULL,
  `V23` varchar(1) DEFAULT NULL,
  `V24` varchar(1) DEFAULT NULL,
  `V25` varchar(1) DEFAULT NULL,
  `V26` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `41_ESI_agentes_territoriales_2020_03`
--

CREATE TABLE `41_ESI_agentes_territoriales_2020_03` (
  `escuela_cue` varchar(256) DEFAULT NULL,
  `escuela_provincia` varchar(256) DEFAULT NULL,
  `escuela_pcia_codigo` varchar(256) DEFAULT NULL,
  `escuela_departamento` varchar(256) DEFAULT NULL,
  `escuela_dpto_codigo` varchar(256) DEFAULT NULL,
  `escuela_localidad` varchar(256) DEFAULT NULL,
  `escuela_numero_asociacion_esi` varchar(256) DEFAULT NULL,
  `escuela_nombre` varchar(256) DEFAULT NULL,
  `agente_nombre` varchar(256) DEFAULT NULL,
  `agente_apellido` varchar(256) DEFAULT NULL,
  `agente_dni` varchar(256) DEFAULT NULL,
  `observaciones_escuela` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `42_ESI-escuelas-caracterizacion`
--

CREATE TABLE `42_ESI-escuelas-caracterizacion` (
  `fecha` varchar(19) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `departamento` varchar(22) DEFAULT NULL,
  `localidad` varchar(44) DEFAULT NULL,
  `a_p_apellido` varchar(20) DEFAULT NULL,
  `a_p_nombre` varchar(25) DEFAULT NULL,
  `a_p_dni` varchar(9) DEFAULT NULL,
  `cue` varchar(10) DEFAULT NULL,
  `nombre` varchar(90) DEFAULT NULL,
  `turno_maniana` int(1) DEFAULT NULL,
  `turno_tarde` int(1) DEFAULT NULL,
  `turno_noche` int(1) DEFAULT NULL,
  `e_equip_orient_esc` int(1) DEFAULT NULL,
  `e_asesoria` int(1) DEFAULT NULL,
  `e_pci` int(1) DEFAULT NULL,
  `area_esi_form` int(1) DEFAULT NULL,
  `area_esi_ed_fis` int(1) DEFAULT NULL,
  `area_esi_ed_art` int(1) DEFAULT NULL,
  `area_esi_leng` int(1) DEFAULT NULL,
  `area_esi_soc` int(1) DEFAULT NULL,
  `area_esi_nat` int(1) DEFAULT NULL,
  `area_esi_psi_fil` int(1) DEFAULT NULL,
  `area_esi_exac` int(1) DEFAULT NULL,
  `area_esi_tec` int(1) DEFAULT NULL,
  `area_esi_ext` int(1) DEFAULT NULL,
  `area_esi_otras` int(1) DEFAULT NULL,
  `e_mat_1ro` int(3) DEFAULT NULL,
  `e_mat_2do` int(3) DEFAULT NULL,
  `e_mat_3ro` int(3) DEFAULT NULL,
  `e_mat_4to` int(3) DEFAULT NULL,
  `e_mat_5to` int(3) DEFAULT NULL,
  `e_mat_6to` int(3) DEFAULT NULL,
  `e_cursos_1ro` int(2) DEFAULT NULL,
  `e_cursos_2do` int(2) DEFAULT NULL,
  `e_cursos_3ro` int(2) DEFAULT NULL,
  `e_cursos_4to` int(2) DEFAULT NULL,
  `e_cursos_5to` int(2) DEFAULT NULL,
  `e_cursos_6fo` int(2) DEFAULT NULL,
  `d_capact_esi` int(3) DEFAULT NULL,
  `e_estud_integr` int(1) DEFAULT NULL,
  `p_equip_cb` varchar(7) DEFAULT NULL,
  `d_cb_equip_enia` int(2) DEFAULT NULL,
  `d_activos_cb` int(3) DEFAULT NULL,
  `p_equip_co` varchar(7) DEFAULT NULL,
  `d_co_equip_enia` int(2) DEFAULT NULL,
  `d_activos_co` int(3) DEFAULT NULL,
  `p_equip_tot` varchar(7) DEFAULT NULL,
  `d_2_ciclos_equip_enia` int(2) DEFAULT NULL,
  `d_activos_2_ciclos` int(3) DEFAULT NULL,
  `d_sin_curso_equip_enia` int(2) DEFAULT NULL,
  `d_area_form` int(1) DEFAULT NULL,
  `d_area_ed_fid` int(1) DEFAULT NULL,
  `d_area_ed_art` int(1) DEFAULT NULL,
  `d_area_leng` int(1) DEFAULT NULL,
  `d_area_soc` int(1) DEFAULT NULL,
  `d_area_nat` int(1) DEFAULT NULL,
  `d_area_psi_fil` int(1) DEFAULT NULL,
  `d_area_exac` int(1) DEFAULT NULL,
  `d_area_tec` int(1) DEFAULT NULL,
  `d_area_ext` int(1) DEFAULT NULL,
  `d_area_otra` int(1) DEFAULT NULL,
  `d_esi_sin_cap` int(1) DEFAULT NULL,
  `d_horas_sin_estud` int(1) DEFAULT NULL,
  `d_cap_enia_siguen` int(1) DEFAULT NULL,
  `d_cuantos_no_siguen` int(4) DEFAULT NULL,
  `comentarios` varchar(2554) DEFAULT NULL,
  `respondente_nombre` varchar(110) DEFAULT NULL,
  `respondente_cargo` varchar(27) DEFAULT NULL,
  `tot` varchar(5) DEFAULT NULL,
  `n_docent_sum` varchar(7) DEFAULT NULL,
  `p_equip_capacit` varchar(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `43_ESI-capacitaciones-docentes`
--

CREATE TABLE `43_ESI-capacitaciones-docentes` (
  `escuela_nombre` varchar(256) DEFAULT NULL,
  `cue` varchar(256) DEFAULT NULL,
  `docente_nombre` varchar(256) DEFAULT NULL,
  `docente_apellido` varchar(256) DEFAULT NULL,
  `docente_dni` varchar(256) DEFAULT NULL,
  `docente_cargo` varchar(256) DEFAULT NULL,
  `docente_area` varchar(256) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `docente_departamento` varchar(256) DEFAULT NULL,
  `escuela_localidad` varchar(256) DEFAULT NULL,
  `capacit_fecha` varchar(256) DEFAULT NULL,
  `mes` int(4) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL,
  `anio` int(4) DEFAULT NULL,
  `docente_cuil` varchar(256) DEFAULT NULL,
  `source01` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `43_ESI-capacitaciones-docentes_back`
--

CREATE TABLE `43_ESI-capacitaciones-docentes_back` (
  `escuela_nombre` varchar(95) DEFAULT NULL,
  `cue` varchar(10) DEFAULT NULL,
  `nombre` varchar(31) DEFAULT NULL,
  `apellido` varchar(26) DEFAULT NULL,
  `dni` varchar(11) DEFAULT NULL,
  `cargo` varchar(68) DEFAULT NULL,
  `si_docente_area` varchar(48) DEFAULT NULL,
  `escula_departamento` varchar(22) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `departamento` varchar(22) DEFAULT NULL,
  `localidad` varchar(30) DEFAULT NULL,
  `fecha_capacitacion_docente` varchar(10) DEFAULT NULL,
  `mes` int(4) DEFAULT NULL,
  `anio` varchar(5) DEFAULT NULL,
  `mesanio` varchar(5) DEFAULT NULL,
  `provincia_codigo` int(5) DEFAULT NULL,
  `departamento_codigo` varchar(5) DEFAULT NULL,
  `cargo_docente` varchar(4) DEFAULT NULL,
  `primario_ultimo` varchar(4) DEFAULT NULL,
  `no_escuela` varchar(4) DEFAULT NULL,
  `filter_$` varchar(4) DEFAULT NULL,
  `escuela_con_docente_capacitado` varchar(4) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `43_ESI-capacitaciones-docentes_v20210714`
--

CREATE TABLE `43_ESI-capacitaciones-docentes_v20210714` (
  `escuela_nombre` varchar(95) DEFAULT NULL,
  `cue` varchar(10) DEFAULT NULL,
  `nombre` varchar(31) DEFAULT NULL,
  `apellido` varchar(26) DEFAULT NULL,
  `dni` varchar(11) DEFAULT NULL,
  `cargo` varchar(68) DEFAULT NULL,
  `si_docente_area` varchar(48) DEFAULT NULL,
  `escula_departamento` varchar(22) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `departamento` varchar(22) DEFAULT NULL,
  `localidad` varchar(30) DEFAULT NULL,
  `fecha_capacitacion_docente` varchar(10) DEFAULT NULL,
  `mes` int(4) DEFAULT NULL,
  `anio` varchar(5) DEFAULT NULL,
  `mesanio` varchar(5) DEFAULT NULL,
  `provincia_codigo` int(5) DEFAULT NULL,
  `departamento_codigo` varchar(5) DEFAULT NULL,
  `cargo_docente` varchar(4) DEFAULT NULL,
  `primario_ultimo` varchar(4) DEFAULT NULL,
  `no_escuela` varchar(4) DEFAULT NULL,
  `filter_$` varchar(4) DEFAULT NULL,
  `escuela_con_docente_capacitado` varchar(4) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `44_ESI-capacitaciones-directivos`
--

CREATE TABLE `44_ESI-capacitaciones-directivos` (
  `anio` int(4) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `FECHA` varchar(10) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `departamento` varchar(80) DEFAULT NULL,
  `LOCALIDAD` varchar(21) DEFAULT NULL,
  `NOMBRE_de_la_ESCUELA` varchar(71) DEFAULT NULL,
  `CUE_de_la_ESCUELA` varchar(10) DEFAULT NULL,
  `NOMBRE` varchar(20) DEFAULT NULL,
  `APELLIDO` varchar(24) DEFAULT NULL,
  `DNI` varchar(9) DEFAULT NULL,
  `Cargo` varchar(68) DEFAULT NULL,
  `codpcia` varchar(2) DEFAULT NULL,
  `codpto` varchar(3) DEFAULT NULL,
  `concatpd` varchar(5) DEFAULT NULL,
  `mesaño` varchar(2) DEFAULT NULL,
  `noescuela` varchar(1) DEFAULT NULL,
  `cueduplicado` varchar(1) DEFAULT NULL,
  `PrimarioÚltimo` varchar(1) DEFAULT NULL,
  `filter_$` varchar(1) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `45_ESI-visitas`
--

CREATE TABLE `45_ESI-visitas` (
  `F_CARGA` varchar(20) DEFAULT NULL,
  `A_P_NOMBRE` varchar(26) DEFAULT NULL,
  `A_P_APELLIDO` varchar(20) DEFAULT NULL,
  `A_P_DNI` varchar(9) DEFAULT NULL,
  `PROVINCIA` varchar(19) DEFAULT NULL,
  `DEPARTAMENTO` varchar(22) DEFAULT NULL,
  `LOC` varchar(45) DEFAULT NULL,
  `F_MES` varchar(10) DEFAULT NULL,
  `CANT_VIS` int(2) DEFAULT NULL,
  `E_NOMBRE` varchar(95) DEFAULT NULL,
  `E_ANEXO` int(1) DEFAULT NULL,
  `E_TURNO` int(1) DEFAULT NULL,
  `E_TURNO_M` int(1) DEFAULT NULL,
  `E_TURNO_T` int(1) DEFAULT NULL,
  `E_TURNO_N` int(1) DEFAULT NULL,
  `E_ESI_PCI` int(1) DEFAULT NULL,
  `E_CUE` varchar(10) DEFAULT NULL,
  `E_MAT_1ro` decimal(6,3) DEFAULT NULL,
  `E_MAT_2ro` decimal(6,3) DEFAULT NULL,
  `E_MAT_3ro` decimal(6,3) DEFAULT NULL,
  `E_MAT_4ro` decimal(6,3) DEFAULT NULL,
  `E_MAT_5ro` decimal(6,3) DEFAULT NULL,
  `E_MAT_6ro` decimal(6,3) DEFAULT NULL,
  `D_ACTIVOS` decimal(6,3) DEFAULT NULL,
  `D_CAP_P_ENIA` varchar(7) DEFAULT NULL,
  `D_CAP_V_ESI` varchar(7) DEFAULT NULL,
  `D_CAP_V_EMPA` varchar(2) DEFAULT NULL,
  `TT_SOCIALIZADO_ENIA` int(3) DEFAULT NULL,
  `CARTILLA_SOCIALIZADA` int(1) DEFAULT NULL,
  `E_T_CANTIDAD` decimal(5,3) DEFAULT NULL,
  `E_T_DERECHO` int(1) DEFAULT NULL,
  `E_T_EFISICA` int(1) DEFAULT NULL,
  `E_T_EARTISTICA` int(1) DEFAULT NULL,
  `E_T_LENGUA` int(1) DEFAULT NULL,
  `E_T_CSOC` int(1) DEFAULT NULL,
  `E_T_CNAT` int(1) DEFAULT NULL,
  `E_T_PSI` int(1) DEFAULT NULL,
  `E_T_CEXACTAS` int(1) DEFAULT NULL,
  `E_T_ATECNICAS` int(1) DEFAULT NULL,
  `E_T_LEXTRANJERAS` int(1) DEFAULT NULL,
  `E_T_OTRA` int(1) DEFAULT NULL,
  `D_CRONO_ANUAL` int(1) DEFAULT NULL,
  `ACTIV_PLANIF` int(1) DEFAULT NULL,
  `CANT_ACT_CON_AP` varchar(7) DEFAULT NULL,
  `ACT_MOD1_SE_DICE_DE_MI` int(1) DEFAULT NULL,
  `ACT_MOD1_BAJO_PRESION` int(1) DEFAULT NULL,
  `ACT_MOD1_BARRERAS` int(1) DEFAULT NULL,
  `ACT_MOD1_OJOS_ABIERTOS` int(1) DEFAULT NULL,
  `ACT_MOD1_1ro` int(1) DEFAULT NULL,
  `ACT_MOD1_2ro` int(1) DEFAULT NULL,
  `ACT_MOD1_3ro` int(1) DEFAULT NULL,
  `ACT_MOD1_4ro` int(1) DEFAULT NULL,
  `ACT_MOD1_5ro` int(1) DEFAULT NULL,
  `ACT_MOD1_6ro` int(1) DEFAULT NULL,
  `EDAD_EST_ACT_MOD1` varchar(53) DEFAULT NULL,
  `ACT_MOD1_MODAL_CLASES` int(1) DEFAULT NULL,
  `ACT_MOD1_MODAL_JORNAD` int(1) DEFAULT NULL,
  `R_U_CUADERNOS_MOD1` int(1) DEFAULT NULL,
  `R_U_LAMINAS_MOD1` int(1) DEFAULT NULL,
  `ACT_MOD2_DER1` int(1) DEFAULT NULL,
  `ACT_MOD2_DER2` int(1) DEFAULT NULL,
  `ACT_MOD2_DER3` int(1) DEFAULT NULL,
  `ACT_MOD2_ABUSO1` int(1) DEFAULT NULL,
  `ACT_MOD2_ABUSO2` int(1) DEFAULT NULL,
  `ACT_MOD2_DECISIONES` int(1) DEFAULT NULL,
  `ACT_MOD2_1ro` int(1) DEFAULT NULL,
  `ACT_MOD2_2ro` int(1) DEFAULT NULL,
  `ACT_MOD2_3ro` int(1) DEFAULT NULL,
  `ACT_MOD2_4ro` int(1) DEFAULT NULL,
  `ACT_MOD2_5ro` int(1) DEFAULT NULL,
  `ACT_MOD2_6ro` int(1) DEFAULT NULL,
  `EDAD_EST_ACT_MOD2` varchar(53) DEFAULT NULL,
  `ACT_MOD2_MODAL_CLASES` int(1) DEFAULT NULL,
  `ACT_MOD2_MODAL_JORNAD` int(1) DEFAULT NULL,
  `R_U_CUADERNOS_MOD2` int(1) DEFAULT NULL,
  `R_U_LAMINAS_MOD2` int(1) DEFAULT NULL,
  `ACT_MOD3_MAC` int(1) DEFAULT NULL,
  `ACT_MOD3_PRESERVAT` int(1) DEFAULT NULL,
  `ACT_MOD3_MAC_DESICION` int(1) DEFAULT NULL,
  `ACT_MOD3_1ro` int(1) DEFAULT NULL,
  `ACT_MOD3_2ro` int(1) DEFAULT NULL,
  `ACT_MOD3_3ro` int(1) DEFAULT NULL,
  `ACT_MOD3_4ro` int(1) DEFAULT NULL,
  `ACT_MOD3_5ro` int(1) DEFAULT NULL,
  `ACT_MOD3_6ro` int(1) DEFAULT NULL,
  `EDAD_EST_ACT_MOD3` varchar(57) DEFAULT NULL,
  `ACT_MOD3_MODAL_CLASES` varchar(2) DEFAULT NULL,
  `ACT_MOD3_MODAL_JORNAD` int(1) DEFAULT NULL,
  `R_U_CUADERNOS_MOD3` int(1) DEFAULT NULL,
  `R_U_LAMINAS_MOD3` int(1) DEFAULT NULL,
  `ACTIV_ADOLES_CB` int(3) DEFAULT NULL,
  `ACTIV_ADOLES_CO` varchar(7) DEFAULT NULL,
  `ESTUD_TIPO_PROD_VIDEOS` decimal(4,3) DEFAULT NULL,
  `ESTUD_TIPO_PROD_FOLLET` int(1) DEFAULT NULL,
  `ESTUD_TIPO_PROD_RADIO` int(1) DEFAULT NULL,
  `ESTUD_TIPO_PROD_LAMINAS` int(1) DEFAULT NULL,
  `ESTUD_TIPO_PROD_BLOG` int(1) DEFAULT NULL,
  `ESTUD_TIPO_PROD_TEATRO` int(1) DEFAULT NULL,
  `ESTUD_TIPO_PROD_CONC_LIT` int(1) DEFAULT NULL,
  `ESTUD_TIPO_PROD_FERIAS` int(1) DEFAULT NULL,
  `ESTUD_TIPO_PROD_OTRAS` int(1) DEFAULT NULL,
  `ESTUD_TIPO_PROD_NINGUNA` int(1) DEFAULT NULL,
  `ESTUD_TIPO_PROD_OTRAS_CUAL` varchar(354) DEFAULT NULL,
  `PNSIA_ASESOR` int(1) DEFAULT NULL,
  `PNSIA_TEMA_COMPARTIDOS` int(1) DEFAULT NULL,
  `PNSIA_DIFUSION` int(1) DEFAULT NULL,
  `PNSIA_REUNION` int(1) DEFAULT NULL,
  `PNSIA_PARTICIPA_AP` int(1) DEFAULT NULL,
  `PNSIA_PARTICIPA_DOC` int(1) DEFAULT NULL,
  `ACTIV_CENTRO_ESTUD` int(1) DEFAULT NULL,
  `ACTIV_CENTRO_ESTUD_CANT` varchar(4) DEFAULT NULL,
  `ACTIV_CENTRO_ESTUD_CUALES` varchar(563) DEFAULT NULL,
  `FLIA_PARTIC` int(1) DEFAULT NULL,
  `FLIA_PARTIC_CUALES` varchar(326) DEFAULT NULL,
  `ARTIC_PRIMEROS_AÑOS` int(1) DEFAULT NULL,
  `EV_REUNION` int(1) DEFAULT NULL,
  `COMENTARIOS` varchar(2616) DEFAULT NULL,
  `RESPONDENTE_NOMBRE` varchar(128) DEFAULT NULL,
  `RESPONDENTE_TEL` varchar(13) DEFAULT NULL,
  `mes` int(2) DEFAULT NULL,
  `año` decimal(4,3) DEFAULT NULL,
  `mesaño` varchar(5) DEFAULT NULL,
  `codpcia` int(2) DEFAULT NULL,
  `concatpd` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `46_ESI-actividades`
--

CREATE TABLE `46_ESI-actividades` (
  `F_CARGA` varchar(9) DEFAULT NULL,
  `E_CUE` int(9) DEFAULT NULL,
  `uniques` int(1) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `ANIO_MES` decimal(6,2) DEFAULT NULL,
  `anio` int(4) NOT NULL,
  `mes` int(2) NOT NULL,
  `departamento` varchar(22) DEFAULT NULL,
  `LOC` varchar(36) DEFAULT NULL,
  `A_P_APELLIDO` varchar(14) DEFAULT NULL,
  `A_P_NOMBRE` varchar(25) DEFAULT NULL,
  `A_P_DNI` varchar(9) DEFAULT NULL,
  `E_NOMBRE` varchar(90) DEFAULT NULL,
  `MES_INFOR` varchar(15) DEFAULT NULL,
  `visitas_cantidad` varchar(4) DEFAULT NULL,
  `cronograma_anual` varchar(6) DEFAULT NULL,
  `planifica_docente_cap` varchar(6) DEFAULT NULL,
  `actividad_mod_1_anio_1` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_1_anio_1` varchar(4) DEFAULT NULL,
  `A1M1_temas_represent` varchar(3) DEFAULT NULL,
  `A1M1_temas_presion` varchar(3) DEFAULT NULL,
  `A1M1_temas_dificult` varchar(3) DEFAULT NULL,
  `A1M1_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A1M1_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A1M1_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A1M1_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A1M1_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD1_1°_CUALES` varchar(305) DEFAULT NULL,
  `actividad_mod_2_anio_1` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_2_anio_1` varchar(4) DEFAULT NULL,
  `A1M2_temas_derechos` varchar(3) DEFAULT NULL,
  `A1M2_temas_abuso` varchar(3) DEFAULT NULL,
  `A1M2_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A1M2_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A1M2_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A1M2_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A1M2_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD2_1°_CUALES` varchar(668) DEFAULT NULL,
  `actividad_mod_3_anio_1` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_3_anio_1` varchar(4) DEFAULT NULL,
  `A1M3_temas_perspectiva` varchar(3) DEFAULT NULL,
  `A1M3_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A1M3_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A1M3_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A1M3_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A1M3_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD3_1°_CUALES` varchar(275) DEFAULT NULL,
  `actividad_mod_1_anio_2` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_1_anio_2` varchar(4) DEFAULT NULL,
  `A2M1_temas_represent` varchar(3) DEFAULT NULL,
  `A2M1_temas_presion` varchar(3) DEFAULT NULL,
  `A2M1_temas_dificult` varchar(3) DEFAULT NULL,
  `A2M1_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A2M1_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A2M1_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A2M1_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A2M1_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD1_2°_CUALES` varchar(191) DEFAULT NULL,
  `actividad_mod_2_anio_2` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_2_anio_2` varchar(4) DEFAULT NULL,
  `A2M2_temas_derechos` varchar(3) DEFAULT NULL,
  `A2M2_temas_abuso` varchar(3) DEFAULT NULL,
  `A2M2_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A2M2_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A2M2_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A2M2_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A2M2_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD2_2°_CUALES` varchar(668) DEFAULT NULL,
  `actividad_mod_3_anio_2` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_3_anio_2` varchar(4) DEFAULT NULL,
  `A2M3_temas_perspectiva` varchar(3) DEFAULT NULL,
  `A2M3_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A2M3_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A2M3_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A2M3_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A2M3_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD3_2°_CUALES` varchar(274) DEFAULT NULL,
  `actividad_mod_1_anio_3` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_1_anio_3` varchar(4) DEFAULT NULL,
  `A3M1_temas_represent` varchar(3) DEFAULT NULL,
  `A3M1_temas_presion` varchar(3) DEFAULT NULL,
  `A3M1_temas_dificult` varchar(3) DEFAULT NULL,
  `A3M1_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A3M1_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A3M1_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A3M1_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A3M1_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD1_3°_CUALES` varchar(191) DEFAULT NULL,
  `actividad_mod_2_anio_3` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_2_anio_3` varchar(4) DEFAULT NULL,
  `A3M2_temas_derechos` varchar(3) DEFAULT NULL,
  `A3M2_temas_abuso` varchar(3) DEFAULT NULL,
  `A3M2_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A3M2_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A3M2_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A3M2_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A3M2_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD2_3°_CUALES` varchar(668) DEFAULT NULL,
  `actividad_mod_3_anio_3` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_3_anio_3` varchar(3) DEFAULT NULL,
  `A3M3_temas_perspectiva` varchar(3) DEFAULT NULL,
  `A3M3_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A3M3_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A3M3_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A3M3_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A3M3_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD3_3°_CUALES` varchar(274) DEFAULT NULL,
  `actividad_mod_1_anio_4` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_1_anio_4` varchar(4) DEFAULT NULL,
  `A4M1_temas_represent` varchar(3) DEFAULT NULL,
  `A4M1_temas_presion` varchar(3) DEFAULT NULL,
  `A4M1_temas_dificult` varchar(3) DEFAULT NULL,
  `A4M1_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A4M1_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A4M1_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A4M1_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A4M1_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD1_4°_CUALES` varchar(191) DEFAULT NULL,
  `actividad_mod_2_anio_4` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_2_anio_4` varchar(4) DEFAULT NULL,
  `A4M2_temas_derechos` varchar(3) DEFAULT NULL,
  `A4M2_temas_abuso` varchar(3) DEFAULT NULL,
  `A4M2_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A4M2_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A4M2_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A4M2_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A4M2_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD2_4°_CUALES` varchar(668) DEFAULT NULL,
  `actividad_mod_3_anio_4` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_3_anio_4` varchar(4) DEFAULT NULL,
  `A4M3_temas_perspectiva` varchar(3) DEFAULT NULL,
  `A4M3_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A4M3_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A4M3_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A4M3_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A4M3_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD3_4°_CUALES` varchar(274) DEFAULT NULL,
  `actividad_mod_1_anio_5` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_1_anio_5` varchar(3) DEFAULT NULL,
  `A5M1_temas_represent` varchar(3) DEFAULT NULL,
  `A5M1_temas_presion` varchar(3) DEFAULT NULL,
  `A5M1_temas_dificult` varchar(3) DEFAULT NULL,
  `A5M1_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A5M1_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A5M1_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A5M1_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A5M1_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD1_5°_CUALES` varchar(191) DEFAULT NULL,
  `actividad_mod_2_anio_5` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_2_anio_5` varchar(3) DEFAULT NULL,
  `A5M2_temas_derechos` varchar(3) DEFAULT NULL,
  `A5M2_temas_abuso` varchar(3) DEFAULT NULL,
  `A5M2_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A5M2_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A5M2_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A5M2_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A5M2_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD2_5°_CUALES` varchar(668) DEFAULT NULL,
  `actividad_mod_3_anio_5` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_3_anio_5` varchar(3) DEFAULT NULL,
  `A5M3_temas_perspectiva` varchar(3) DEFAULT NULL,
  `A5M3_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A5M3_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A5M3_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A5M3_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A5M3_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD3_5°_CUALES` varchar(274) DEFAULT NULL,
  `actividad_mod_1_anio_6` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_1_anio_6` varchar(3) DEFAULT NULL,
  `A6M1_temas_represent` varchar(3) DEFAULT NULL,
  `A6M1_temas_presion` varchar(3) DEFAULT NULL,
  `A6M1_temas_dificult` varchar(3) DEFAULT NULL,
  `A6M1_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A6M1_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A6M1_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A6M1_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A6M1_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD1_6°_CUALES` varchar(90) DEFAULT NULL,
  `actividad_mod_2_anio_6` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_2_anio_6` varchar(3) DEFAULT NULL,
  `A6M2_temas_derechos` varchar(3) DEFAULT NULL,
  `A6M2_temas_abuso` varchar(3) DEFAULT NULL,
  `A6M2_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A6M2_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A6M2_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A6M2_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A6M2_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD2_6°_CUALES` varchar(668) DEFAULT NULL,
  `actividad_mod_3_anio_6` varchar(6) DEFAULT NULL,
  `cant_cursos_mod_3_anio_6` varchar(3) DEFAULT NULL,
  `A6M3_temas_perspectiva` varchar(3) DEFAULT NULL,
  `A6M3_materiales_cartilla` varchar(3) DEFAULT NULL,
  `A6M3_materiales_cuaderno` varchar(3) DEFAULT NULL,
  `A6M3_materiales_otros_mat` varchar(3) DEFAULT NULL,
  `A6M3_materiales_mat_prov` varchar(3) DEFAULT NULL,
  `A6M3_materiales_otros` varchar(3) DEFAULT NULL,
  `OTROSMAT_MOD3_6°_CUALES` varchar(274) DEFAULT NULL,
  `ESTUD_CB` varchar(6) DEFAULT NULL,
  `ESTUD_CO` varchar(6) DEFAULT NULL,
  `ESTUD_TOT` varchar(8) DEFAULT NULL,
  `REUNIONES_AP_AS` varchar(6) DEFAULT NULL,
  `PLANIF_AP_AS` varchar(6) DEFAULT NULL,
  `ACTIV_VIRT_ESTUD` varchar(6) DEFAULT NULL,
  `TIPO_ACTIV_VIRT` varchar(6) DEFAULT NULL,
  `COMENTARIOS` varchar(1390) DEFAULT NULL,
  `RESPONDENTE_NOMBRE` varchar(96) DEFAULT NULL,
  `RESPONDENTE_CARGO` varchar(27) DEFAULT NULL,
  `A4M3_temas_perspectiva_sum` varchar(6) DEFAULT NULL,
  `A4M3_materiales_cartilla_sum` varchar(6) DEFAULT NULL,
  `A4M3_materiales_cuaderno_sum` varchar(6) DEFAULT NULL,
  `A4M3_materiales_otros_mat_sum` varchar(6) DEFAULT NULL,
  `A4M3_materiales_mat_prov_sum` varchar(6) DEFAULT NULL,
  `A4M3_materiales_otros_sum` varchar(6) DEFAULT NULL,
  `A5M3_temas_perspectiva_sum` varchar(6) DEFAULT NULL,
  `A5M3_materiales_cartilla_sum` varchar(6) DEFAULT NULL,
  `A5M3_materiales_cuaderno_sum` varchar(6) DEFAULT NULL,
  `A5M3_materiales_otros_mat_sum` varchar(6) DEFAULT NULL,
  `A5M3_materiales_mat_prov_sum` varchar(6) DEFAULT NULL,
  `A5M3_materiales_otros_sum` varchar(6) DEFAULT NULL,
  `A6M3_temas_perspectiva_sum` varchar(6) DEFAULT NULL,
  `A6M3_materiales_cartilla_sum` varchar(6) DEFAULT NULL,
  `A6M3_materiales_cuaderno_sum` varchar(6) DEFAULT NULL,
  `A6M3_materiales_otros_mat_sum` varchar(6) DEFAULT NULL,
  `A6M3_materiales_mat_prov_sum` varchar(6) DEFAULT NULL,
  `A6M3_materiales_otros_sum` varchar(6) DEFAULT NULL,
  `TOT` varchar(4) DEFAULT NULL,
  `n_cour_mod_1_anio_1` varchar(7) DEFAULT NULL,
  `n_cour_mod_1_anio_2` varchar(7) DEFAULT NULL,
  `n_cour_mod_1_anio_3` varchar(7) DEFAULT NULL,
  `n_cour_mod_1_anio_4` varchar(7) DEFAULT NULL,
  `n_cour_mod_1_anio_5` varchar(7) DEFAULT NULL,
  `n_cour_mod_1_anio_6` varchar(7) DEFAULT NULL,
  `n_cour_mod_2_anio_1` varchar(7) DEFAULT NULL,
  `n_cour_mod_2_anio_2` varchar(7) DEFAULT NULL,
  `n_cour_mod_2_anio_3` varchar(7) DEFAULT NULL,
  `n_cour_mod_2_anio_4` varchar(7) DEFAULT NULL,
  `n_cour_mod_2_anio_5` varchar(7) DEFAULT NULL,
  `n_cour_mod_2_anio_6` varchar(7) DEFAULT NULL,
  `n_cour_mod_3_anio_1` varchar(7) DEFAULT NULL,
  `n_cour_mod_3_anio_2` varchar(7) DEFAULT NULL,
  `n_cour_mod_3_anio_3` varchar(7) DEFAULT NULL,
  `n_cour_mod_3_anio_4` varchar(7) DEFAULT NULL,
  `n_cour_mod_3_anio_5` varchar(7) DEFAULT NULL,
  `n_cour_mod_3_anio_6` varchar(7) DEFAULT NULL,
  `activ_mod_1_anio_1` varchar(6) DEFAULT NULL,
  `activ_mod_1_anio_2` varchar(6) DEFAULT NULL,
  `activ_mod_1_anio_3` varchar(6) DEFAULT NULL,
  `activ_mod_1_anio_4` varchar(6) DEFAULT NULL,
  `activ_mod_1_anio_5` varchar(6) DEFAULT NULL,
  `activ_mod_1_anio_6` varchar(6) DEFAULT NULL,
  `activ_mod_2_anio_1` varchar(6) DEFAULT NULL,
  `activ_mod_2_anio_2` varchar(6) DEFAULT NULL,
  `activ_mod_2_anio_3` varchar(6) DEFAULT NULL,
  `activ_mod_2_anio_4` varchar(6) DEFAULT NULL,
  `activ_mod_2_anio_5` varchar(6) DEFAULT NULL,
  `activ_mod_2_anio_6` varchar(6) DEFAULT NULL,
  `activ_mod_3_anio_1` varchar(6) DEFAULT NULL,
  `activ_mod_3_anio_2` varchar(6) DEFAULT NULL,
  `activ_mod_3_anio_3` varchar(6) DEFAULT NULL,
  `activ_mod_3_anio_4` varchar(6) DEFAULT NULL,
  `activ_mod_3_anio_5` varchar(6) DEFAULT NULL,
  `activ_mod_3_anio_6` varchar(6) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `47_ESI-escuelas-matriculas`
--

CREATE TABLE `47_ESI-escuelas-matriculas` (
  `CUE` int(9) DEFAULT NULL,
  `provincia` varchar(19) DEFAULT NULL,
  `pcia_codigo` varchar(2) DEFAULT NULL,
  `departamento` varchar(22) DEFAULT NULL,
  `dpto_codigo` varchar(5) DEFAULT NULL,
  `matricula_docente` varchar(3) DEFAULT NULL,
  `matricula_estud_cb` varchar(3) DEFAULT NULL,
  `matricula_estud_co` varchar(4) DEFAULT NULL,
  `matricula_estud_total` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `48_ESI-actividades-acum`
--

CREATE TABLE `48_ESI-actividades-acum` (
  `e_cue` varchar(256) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `anio` varchar(256) DEFAULT NULL,
  `actividad_mes` int(3) DEFAULT NULL,
  `act_mes` varchar(256) DEFAULT NULL,
  `estud_cb` int(7) DEFAULT NULL,
  `estud_co` int(7) DEFAULT NULL,
  `estud_tot` int(7) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `48_ESI_actividades_resumen_acum_2021_03`
--

CREATE TABLE `48_ESI_actividades_resumen_acum_2021_03` (
  `e_cue` varchar(256) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `anio` int(4) DEFAULT NULL,
  `actividad_mes` int(3) DEFAULT NULL,
  `act_mes` varchar(256) DEFAULT NULL,
  `estud_cb` int(7) DEFAULT NULL,
  `estud_co` int(7) DEFAULT NULL,
  `estud_tot` int(7) DEFAULT NULL,
  `mes_str` varchar(2) NOT NULL,
  `source01` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `48_ESI_actividades_resumen_acum_agost2021`
--

CREATE TABLE `48_ESI_actividades_resumen_acum_agost2021` (
  `e_cue` varchar(256) DEFAULT NULL,
  `provincia` varchar(256) DEFAULT NULL,
  `departamento` varchar(256) DEFAULT NULL,
  `anio` varchar(256) DEFAULT NULL,
  `actividad_mes` varchar(256) DEFAULT NULL,
  `act_mes` varchar(256) DEFAULT NULL,
  `estud_cb` varchar(256) DEFAULT NULL,
  `estud_co` varchar(256) DEFAULT NULL,
  `estud_tot` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` varchar(200) CHARACTER SET utf8 NOT NULL,
  `content` varchar(2000) CHARACTER SET utf8 NOT NULL,
  `departament` varchar(256) NOT NULL,
  `school` varchar(256) NOT NULL,
  `workcalendars` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `02_padron-escuelas-provincias`
--
ALTER TABLE `02_padron-escuelas-provincias`
  ADD PRIMARY KEY (`cue`);

--
-- Indices de la tabla `11_SSyR-agentes-territoriales`
--
ALTER TABLE `11_SSyR-agentes-territoriales`
  ADD PRIMARY KEY (`efector_sissa`);

--
-- Indices de la tabla `14_SSyR-larcs_v2021_03`
--
ALTER TABLE `14_SSyR-larcs_v2021_03`
  ADD KEY `mes` (`mes`,`anio`,`aipe`,`grupo_etario`,`provincia`,`localidad`,`departamento_enia`);

--
-- Indices de la tabla `21_DIAJU-agentes-territoriales`
--
ALTER TABLE `21_DIAJU-agentes-territoriales`
  ADD KEY `provincia` (`provincia`,`departamento`,`localizacion_tipo`,`anio`,`mes_str`);

--
-- Indices de la tabla `21_DIAJU-agentes-territoriales_v20210705`
--
ALTER TABLE `21_DIAJU-agentes-territoriales_v20210705`
  ADD KEY `provincia` (`provincia`,`departamento`,`localizacion_tipo`),
  ADD KEY `provincia_2` (`provincia`,`departamento`,`localizacion_tipo`);

--
-- Indices de la tabla `21_DIAJU-agentes-territoriales_v20210811`
--
ALTER TABLE `21_DIAJU-agentes-territoriales_v20210811`
  ADD KEY `provincia` (`provincia`,`departamento`,`localizacion_tipo`);

--
-- Indices de la tabla `22_DIAJU-planilla-B`
--
ALTER TABLE `22_DIAJU-planilla-B`
  ADD KEY `provincia` (`provincia`,`departamento`,`tipo_localiza`,`genero_autopercibido`,`escolariza`,`tipo_asesora`,`motivo_princip`,`referencia1`,`referencia2`,`anio`,`mes`,`filter_referencias`,`mes_str`);

--
-- Indices de la tabla `22_DIAJU-planilla-B_v20210705`
--
ALTER TABLE `22_DIAJU-planilla-B_v20210705`
  ADD KEY `anio` (`anio`),
  ADD KEY `TIPO_LOCALIZA` (`TIPO_LOCALIZA`),
  ADD KEY `mes` (`mes`),
  ADD KEY `PROVINCIA` (`PROVINCIA`),
  ADD KEY `MOTIVO_PRINCIP` (`MOTIVO_PRINCIP`),
  ADD KEY `filter_adolescentes` (`filter_adolescentes`);

--
-- Indices de la tabla `32_DBC-planilla-B`
--
ALTER TABLE `32_DBC-planilla-B`
  ADD KEY `filter_adolescentes` (`filter_adolescentes`),
  ADD KEY `provincia` (`provincia`),
  ADD KEY `mes` (`mes`),
  ADD KEY `anio` (`anio`);

--
-- Indices de la tabla `43_ESI-capacitaciones-docentes`
--
ALTER TABLE `43_ESI-capacitaciones-docentes`
  ADD KEY `escuela_nombre` (`escuela_nombre`,`cue`,`provincia`,`departamento`,`mes_str`,`anio`);

--
-- Indices de la tabla `43_ESI-capacitaciones-docentes_back`
--
ALTER TABLE `43_ESI-capacitaciones-docentes_back`
  ADD KEY `escuela_nombre` (`escuela_nombre`);

--
-- Indices de la tabla `43_ESI-capacitaciones-docentes_v20210714`
--
ALTER TABLE `43_ESI-capacitaciones-docentes_v20210714`
  ADD KEY `escuela_nombre` (`escuela_nombre`);

--
-- Indices de la tabla `48_ESI-actividades-acum`
--
ALTER TABLE `48_ESI-actividades-acum`
  ADD KEY `e_cue` (`e_cue`,`provincia`,`departamento`,`anio`,`estud_cb`,`estud_co`,`estud_tot`,`mes_str`);

--
-- Indices de la tabla `48_ESI_actividades_resumen_acum_2021_03`
--
ALTER TABLE `48_ESI_actividades_resumen_acum_2021_03`
  ADD KEY `e_cue` (`e_cue`,`provincia`,`departamento`,`anio`,`estud_cb`,`estud_co`,`estud_tot`,`mes_str`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
