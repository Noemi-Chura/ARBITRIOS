--
-- PostgreSQL database dump
--

\restrict EFoMuVkzvLUS3uLHvQqjzYs4WiK80J6Z2ygMPZa2ZV1zI6BLN9VUzx4pxa3Cnak

-- Dumped from database version 16.11 (Ubuntu 16.11-1.pgdg24.04+1)
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-30 02:43:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 15 (class 2615 OID 42015)
-- Name: alc; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA alc;


ALTER SCHEMA alc OWNER TO admin;

--
-- TOC entry 14 (class 2615 OID 41567)
-- Name: arb; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA arb;


ALTER SCHEMA arb OWNER TO admin;

--
-- TOC entry 11 (class 2615 OID 36619)
-- Name: caj; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA caj;


ALTER SCHEMA caj OWNER TO pg_database_owner;

--
-- TOC entry 5619 (class 0 OID 0)
-- Dependencies: 11
-- Name: SCHEMA caj; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA caj IS 'standard public schema';


--
-- TOC entry 7 (class 2615 OID 34572)
-- Name: fis; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA fis;


ALTER SCHEMA fis OWNER TO admin;

--
-- TOC entry 13 (class 2615 OID 40373)
-- Name: gen; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA gen;


ALTER SCHEMA gen OWNER TO admin;

--
-- TOC entry 10 (class 2615 OID 34716)
-- Name: hcl; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA hcl;


ALTER SCHEMA hcl OWNER TO admin;

--
-- TOC entry 8 (class 2615 OID 34644)
-- Name: imp; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA imp;


ALTER SCHEMA imp OWNER TO admin;

--
-- TOC entry 12 (class 2615 OID 40371)
-- Name: lic; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA lic;


ALTER SCHEMA lic OWNER TO admin;

--
-- TOC entry 9 (class 2615 OID 34715)
-- Name: saa; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA saa;


ALTER SCHEMA saa OWNER TO admin;

--
-- TOC entry 2 (class 3079 OID 36221)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA hcl;


--
-- TOC entry 5620 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 1213 (class 1247 OID 41703)
-- Name: tp_estado; Type: TYPE; Schema: arb; Owner: admin
--

CREATE TYPE arb.tp_estado AS ENUM (
    'activo',
    'anulado'
);


ALTER TYPE arb.tp_estado OWNER TO admin;

--
-- TOC entry 1246 (class 1247 OID 34632)
-- Name: estado_cc; Type: TYPE; Schema: fis; Owner: admin
--

CREATE TYPE fis.estado_cc AS ENUM (
    'pendiente',
    'parcialmente_pagada',
    'pagada',
    'anulada',
    'castigada'
);


ALTER TYPE fis.estado_cc OWNER TO admin;

--
-- TOC entry 1222 (class 1247 OID 34574)
-- Name: estado_fiscalizacion; Type: TYPE; Schema: fis; Owner: admin
--

CREATE TYPE fis.estado_fiscalizacion AS ENUM (
    'en_tramite',
    'resuelto',
    'archivado'
);


ALTER TYPE fis.estado_fiscalizacion OWNER TO admin;

--
-- TOC entry 1231 (class 1247 OID 34598)
-- Name: estado_generico; Type: TYPE; Schema: fis; Owner: admin
--

CREATE TYPE fis.estado_generico AS ENUM (
    'activo',
    'inactivo'
);


ALTER TYPE fis.estado_generico OWNER TO admin;

--
-- TOC entry 1228 (class 1247 OID 34590)
-- Name: estado_liquidacion; Type: TYPE; Schema: fis; Owner: admin
--

CREATE TYPE fis.estado_liquidacion AS ENUM (
    'emitida',
    'notificada',
    'pagada'
);


ALTER TYPE fis.estado_liquidacion OWNER TO admin;

--
-- TOC entry 1225 (class 1247 OID 34582)
-- Name: estado_requerimiento; Type: TYPE; Schema: fis; Owner: admin
--

CREATE TYPE fis.estado_requerimiento AS ENUM (
    'pendiente',
    'atendido',
    'vencido'
);


ALTER TYPE fis.estado_requerimiento OWNER TO admin;

--
-- TOC entry 1234 (class 1247 OID 34604)
-- Name: tipo_documento_enum; Type: TYPE; Schema: fis; Owner: admin
--

CREATE TYPE fis.tipo_documento_enum AS ENUM (
    'dni',
    'ruc',
    'ce'
);


ALTER TYPE fis.tipo_documento_enum OWNER TO admin;

--
-- TOC entry 1240 (class 1247 OID 34618)
-- Name: tipo_multa_enum; Type: TYPE; Schema: fis; Owner: admin
--

CREATE TYPE fis.tipo_multa_enum AS ENUM (
    'omiso',
    'subvaluante'
);


ALTER TYPE fis.tipo_multa_enum OWNER TO admin;

--
-- TOC entry 1237 (class 1247 OID 34612)
-- Name: tipo_predio_enum; Type: TYPE; Schema: fis; Owner: admin
--

CREATE TYPE fis.tipo_predio_enum AS ENUM (
    'urbano',
    'rustico'
);


ALTER TYPE fis.tipo_predio_enum OWNER TO admin;

--
-- TOC entry 1243 (class 1247 OID 34624)
-- Name: tipo_procedimiento_enum; Type: TYPE; Schema: fis; Owner: admin
--

CREATE TYPE fis.tipo_procedimiento_enum AS ENUM (
    'oficio',
    'denuncia',
    'programa'
);


ALTER TYPE fis.tipo_procedimiento_enum OWNER TO admin;

--
-- TOC entry 505 (class 1255 OID 42083)
-- Name: fn_calcular_impuesto_alcabala(); Type: FUNCTION; Schema: alc; Owner: admin
--

CREATE FUNCTION alc.fn_calcular_impuesto_alcabala() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_ipm NUMERIC(10, 6);
    v_uit NUMERIC(10, 2);
    v_porcentaje NUMERIC(5, 2);
    v_deduccion NUMERIC(12, 2);
BEGIN
    IF NEW.id_factor_calculo IS NULL THEN
        SELECT id, valor_ipm, uit_valor, porcentaje_impuesto
        INTO NEW.id_factor_calculo, v_ipm, v_uit, v_porcentaje
        FROM alc.alc_factor_calculo
        WHERE anio = EXTRACT(YEAR FROM NEW.fecha_contrato)::INTEGER
          AND mes = EXTRACT(MONTH FROM NEW.fecha_contrato)::INTEGER
        LIMIT 1;
    ELSE
        SELECT valor_ipm, uit_valor, porcentaje_impuesto 
        INTO v_ipm, v_uit, v_porcentaje
        FROM alc.alc_factor_calculo
        WHERE id = NEW.id_factor_calculo;
    END IF;

    IF v_ipm IS NULL OR v_uit IS NULL THEN
        RAISE EXCEPTION 'No existe configuración de Factor de Cálculo (UIT/IPM) para la fecha indicada.';
    END IF;

    NEW.valor_base_imponible_actualizado := ROUND(NEW.base_imponible * v_ipm, 2);
    NEW.valor_mayor := GREATEST(NEW.valor_venta, NEW.valor_base_imponible_actualizado);
    
    v_deduccion := 10 * v_uit;
    NEW.tramo_afecto := NEW.valor_mayor - v_deduccion;
    
    IF NEW.tramo_afecto < 0 THEN
        NEW.tramo_afecto := 0.00;
    END IF;

    NEW.impuesto_calculado := ROUND(NEW.tramo_afecto * (v_porcentaje / 100.00), 2);
    NEW.total_a_pagar := NEW.impuesto_calculado + COALESCE(NEW.intereses, 0.00);

    RETURN NEW;
END;
$$;


ALTER FUNCTION alc.fn_calcular_impuesto_alcabala() OWNER TO admin;

--
-- TOC entry 596 (class 1255 OID 42091)
-- Name: fn_actualizar_mora_interes(integer); Type: FUNCTION; Schema: arb; Owner: admin
--

CREATE FUNCTION arb.fn_actualizar_mora_interes(p_id_arbitrio_detalle integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_dias INT;
    v_monto_base DECIMAL(15,2);
BEGIN
    SELECT monto_base,
           EXTRACT(DAY FROM (CURRENT_DATE - fecha_actualizado))
    INTO v_monto_base, v_dias
    FROM arb.arbitrio_detalle
    WHERE id_arbitrio_detalle = p_id_arbitrio_detalle;

    UPDATE arb.arbitrio_detalle
    SET interes = v_monto_base * 0.0005 * v_dias,
        mora = v_monto_base * 0.0003 * v_dias,
        monto_final = monto_base + interes + mora
    WHERE id_arbitrio_detalle = p_id_arbitrio_detalle;
END;
$$;


ALTER FUNCTION arb.fn_actualizar_mora_interes(p_id_arbitrio_detalle integer) OWNER TO admin;

--
-- TOC entry 545 (class 1255 OID 42100)
-- Name: fn_arbitrio_actualizar(integer, character varying, arb.tp_estado, character varying); Type: FUNCTION; Schema: arb; Owner: admin
--

CREATE FUNCTION arb.fn_arbitrio_actualizar(p_id_arbitrio integer, p_observacion character varying, p_estado arb.tp_estado, p_usuario_actualizado character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE arb.arbitrio
    SET observacion = p_observacion,
        estado = p_estado,
        usuario_actualizado = p_usuario_actualizado,
        fecha_actualizado = CURRENT_TIMESTAMP
    WHERE id_arbitrio = p_id_arbitrio;

    IF NOT FOUND THEN
        RETURN format('No se encontró el arbitrio con ID: %s', p_id_arbitrio);
    END IF;

    RETURN format('Arbitrio (ID: %s) actualizado correctamente', p_id_arbitrio);
END;
$$;


ALTER FUNCTION arb.fn_arbitrio_actualizar(p_id_arbitrio integer, p_observacion character varying, p_estado arb.tp_estado, p_usuario_actualizado character varying) OWNER TO admin;

--
-- TOC entry 544 (class 1255 OID 42101)
-- Name: fn_arbitrio_eliminar(integer); Type: FUNCTION; Schema: arb; Owner: admin
--

CREATE FUNCTION arb.fn_arbitrio_eliminar(p_id_arbitrio integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM arb.arbitrio
    WHERE id_arbitrio = p_id_arbitrio;

    IF NOT FOUND THEN
        RETURN format('No se encontró el arbitrio con ID: %s', p_id_arbitrio);
    END IF;

    RETURN format('Arbitrio (ID: %s) eliminado correctamente', p_id_arbitrio);
END;
$$;


ALTER FUNCTION arb.fn_arbitrio_eliminar(p_id_arbitrio integer) OWNER TO admin;

--
-- TOC entry 513 (class 1255 OID 42098)
-- Name: fn_arbitrio_insertar(integer, integer, integer, integer, character varying, character varying); Type: FUNCTION; Schema: arb; Owner: admin
--

CREATE FUNCTION arb.fn_arbitrio_insertar(p_id_contribuyente integer, p_id_predio integer, p_id_tipo_registro_origen integer, p_anio integer, p_observacion character varying, p_usuario_actualizado character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id_arbitrio INT;
BEGIN
    -- Validación: contribuyente existe
    IF NOT EXISTS (SELECT 1 FROM gen.gen_contribuyente WHERE id = p_id_contribuyente) THEN
        RETURN 'Error: El contribuyente no existe';
    END IF;

    -- Validación: predio existe
    IF NOT EXISTS (SELECT 1 FROM gen.gen_predio WHERE id_predio = p_id_predio) THEN
        RETURN 'Error: El predio no existe';
    END IF;

    INSERT INTO arb.arbitrio (
        id_contribuyente, id_predio, id_tipo_registro_origen,
        anio, observacion, usuario_actualizado, fecha_actualizado
    )
    VALUES (
        p_id_contribuyente, p_id_predio, p_id_tipo_registro_origen,
        p_anio, p_observacion, p_usuario_actualizado, CURRENT_TIMESTAMP
    )
    RETURNING id_arbitrio INTO v_id_arbitrio;

    RETURN format('Arbitrio creado correctamente (ID: %s)', v_id_arbitrio);
END;
$$;


ALTER FUNCTION arb.fn_arbitrio_insertar(p_id_contribuyente integer, p_id_predio integer, p_id_tipo_registro_origen integer, p_anio integer, p_observacion character varying, p_usuario_actualizado character varying) OWNER TO admin;

--
-- TOC entry 583 (class 1255 OID 42099)
-- Name: fn_arbitrio_leer(integer); Type: FUNCTION; Schema: arb; Owner: admin
--

CREATE FUNCTION arb.fn_arbitrio_leer(p_id_arbitrio integer) RETURNS TABLE(id_arbitrio integer, id_contribuyente integer, nombre_contribuyente character varying, id_predio integer, direccion_predio character varying, anio integer, estado arb.tp_estado, observacion character varying, fecha_actualizado timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        a.id_arbitrio,
        a.id_contribuyente,
        c.nombre_razonsocial AS nombre_contribuyente,
        a.id_predio,
        p.direccion,
        a.anio,
        a.estado,
        a.observacion,
        a.fecha_actualizado
    FROM arb.arbitrio a
    JOIN gen.gen_contribuyente c ON a.id_contribuyente = c.id
    JOIN gen.gen_predio p ON a.id_predio = p.id_predio
    WHERE a.id_arbitrio = p_id_arbitrio;
END;
$$;


ALTER FUNCTION arb.fn_arbitrio_leer(p_id_arbitrio integer) OWNER TO admin;

--
-- TOC entry 597 (class 1255 OID 42089)
-- Name: fn_calcular_arbitrio_detalle(); Type: FUNCTION; Schema: arb; Owner: admin
--

CREATE FUNCTION arb.fn_calcular_arbitrio_detalle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_barrido DECIMAL(15,2);
    v_relleno DECIMAL(15,2);
    v_parques DECIMAL(15,2);
    v_serenazgo DECIMAL(15,2);
    v_interes DECIMAL(15,2);
    v_mora DECIMAL(15,2);
BEGIN
    v_barrido := NEW.frentera_metros * NEW.frecuencia_barrido * 0.8;
    v_relleno := NEW.area_construida * 0.5;

    IF NEW.distancia_a_parque <= 50 THEN
        v_parques := 20;
    ELSIF NEW.distancia_a_parque <= 100 THEN
        v_parques := 15;
    ELSE
        v_parques := 10;
    END IF;

    v_serenazgo := (NEW.porcentaje_inseguridad / 100) * NEW.area_terreno;

    NEW.monto_base := v_barrido + v_relleno + v_parques + v_serenazgo;

    v_interes := NEW.monto_base * 0.02;
    v_mora := NEW.monto_base * 0.01;

    NEW.interes := v_interes;
    NEW.mora := v_mora;
    NEW.monto_final := NEW.monto_base + v_interes + v_mora;

    RETURN NEW;
END;
$$;


ALTER FUNCTION arb.fn_calcular_arbitrio_detalle() OWNER TO admin;

--
-- TOC entry 561 (class 1255 OID 42092)
-- Name: fn_notificar_arbitrio(integer); Type: FUNCTION; Schema: arb; Owner: admin
--

CREATE FUNCTION arb.fn_notificar_arbitrio(p_id_contribuyente integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_correo VARCHAR(200);
    v_total DECIMAL(15,2);
BEGIN
    SELECT email INTO v_correo
    FROM gen.gen_contribuyente
    WHERE id = p_id_contribuyente;

    SELECT SUM(ad.monto_final)
    INTO v_total
    FROM arb.arbitrio_detalle ad
    JOIN arb.arbitrio a ON ad.id_arbitrio = a.id_arbitrio
    WHERE a.id_contribuyente = p_id_contribuyente;

    RETURN format(
        'Correo enviado a %s con deuda total S/. %s',
        v_correo, COALESCE(v_total,0)
    );
END;
$$;


ALTER FUNCTION arb.fn_notificar_arbitrio(p_id_contribuyente integer) OWNER TO admin;

--
-- TOC entry 509 (class 1255 OID 36620)
-- Name: fn_auditoria(); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_auditoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_desc TEXT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        v_desc := 'Nuevo registro insertado: ' || row_to_json(NEW);
        INSERT INTO auditoria(tabla, operacion, registro_id, descripcion)
        VALUES (TG_TABLE_NAME, TG_OP, NEW.id, v_desc);

    ELSIF TG_OP = 'UPDATE' THEN
        v_desc := 'Registro actualizado. Antes: ' || row_to_json(OLD) ||
                   ' | Después: ' || row_to_json(NEW);
        INSERT INTO auditoria(tabla, operacion, registro_id, descripcion)
        VALUES (TG_TABLE_NAME, TG_OP, NEW.id, v_desc);

    ELSIF TG_OP = 'DELETE' THEN
        v_desc := 'Registro eliminado: ' || row_to_json(OLD);
        INSERT INTO auditoria(tabla, operacion, registro_id, descripcion)
        VALUES (TG_TABLE_NAME, TG_OP, OLD.id, v_desc);
    END IF;

    RETURN NULL;
END;
$$;


ALTER FUNCTION caj.fn_auditoria() OWNER TO postgres;

--
-- TOC entry 557 (class 1255 OID 36621)
-- Name: fn_i_apertura_cobranza(integer, text); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_i_apertura_cobranza(p_id_cajero integer, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_id INT;
BEGIN
    INSERT INTO apertura_cobranza(id_cajero, fecha_apertura, observaciones, estado)
    VALUES (p_id_cajero, CURRENT_DATE, p_observaciones, 'ABIERTO')
    RETURNING id INTO v_id;
    RETURN v_id;
END;
$$;


ALTER FUNCTION caj.fn_i_apertura_cobranza(p_id_cajero integer, p_observaciones text) OWNER TO postgres;

--
-- TOC entry 562 (class 1255 OID 36622)
-- Name: fn_i_cajero(character varying, character varying, character varying, text, integer); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_i_cajero(p_nombres character varying, p_apellidos character varying, p_dni character varying, p_cod_acceso text, p_numeracion_inicial integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_id INT;
BEGIN
    INSERT INTO cajero(nombres, apellidos, dni, cod_acceso, numeracion_inicial_recibo, numeracion_actual_recibo, estado)
    VALUES (p_nombres, p_apellidos, p_dni, p_cod_acceso, p_numeracion_inicial, p_numeracion_inicial, 'ACTIVO')
    RETURNING id INTO v_id;
    RETURN v_id;
END;
$$;


ALTER FUNCTION caj.fn_i_cajero(p_nombres character varying, p_apellidos character varying, p_dni character varying, p_cod_acceso text, p_numeracion_inicial integer) OWNER TO postgres;

--
-- TOC entry 582 (class 1255 OID 36623)
-- Name: fn_i_cierre_caja(integer, numeric, numeric, numeric, text); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_i_cierre_caja(p_id_cajero integer, p_total_efectivo numeric, p_total_comisiones numeric, p_total_general numeric, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_id INT;
BEGIN
    INSERT INTO cierre_caja(id_cajero, fecha_cierre, total_efectivo, total_comisiones, total_general, observaciones)
    VALUES (p_id_cajero, CURRENT_DATE, p_total_efectivo, p_total_comisiones, p_total_general, p_observaciones)
    RETURNING id INTO v_id;
    RETURN v_id;
END;
$$;


ALTER FUNCTION caj.fn_i_cierre_caja(p_id_cajero integer, p_total_efectivo numeric, p_total_comisiones numeric, p_total_general numeric, p_observaciones text) OWNER TO postgres;

--
-- TOC entry 594 (class 1255 OID 36624)
-- Name: fn_i_concepto_pago(character varying, numeric); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_i_concepto_pago(p_descripcion character varying, p_monto numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_id INT;
BEGIN
    INSERT INTO concepto_pago(descripcion, monto) VALUES (p_descripcion, p_monto) RETURNING id INTO v_id;
    RETURN v_id;
END;
$$;


ALTER FUNCTION caj.fn_i_concepto_pago(p_descripcion character varying, p_monto numeric) OWNER TO postgres;

--
-- TOC entry 586 (class 1255 OID 36625)
-- Name: fn_i_pago(integer, integer, integer, numeric, text); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_i_pago(p_id_usuario integer, p_id_cajero integer, p_id_tipo_pago integer, p_total numeric, p_observaciones text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_id INT;
BEGIN
    INSERT INTO pago(id_usuario, id_cajero, id_tipo_pago, total, observaciones)
    VALUES (p_id_usuario, p_id_cajero, p_id_tipo_pago, p_total, p_observaciones)
    RETURNING id INTO v_id;
    RETURN v_id;
END;
$$;


ALTER FUNCTION caj.fn_i_pago(p_id_usuario integer, p_id_cajero integer, p_id_tipo_pago integer, p_total numeric, p_observaciones text) OWNER TO postgres;

--
-- TOC entry 527 (class 1255 OID 36626)
-- Name: fn_i_pago_detalle(integer, integer, integer, numeric); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_i_pago_detalle(p_id_pago integer, p_id_concepto_pago integer, p_cantidad integer, p_subtotal numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_id INT;
BEGIN
    INSERT INTO pago_detalle(id_pago, id_concepto_pago, cantidad, subtotal)
    VALUES (p_id_pago, p_id_concepto_pago, p_cantidad, p_subtotal)
    RETURNING id INTO v_id;
    RETURN v_id;
END;
$$;


ALTER FUNCTION caj.fn_i_pago_detalle(p_id_pago integer, p_id_concepto_pago integer, p_cantidad integer, p_subtotal numeric) OWNER TO postgres;

--
-- TOC entry 570 (class 1255 OID 36627)
-- Name: fn_i_recibo(integer, integer, numeric); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_i_recibo(p_id_pago integer, p_id_cajero integer, p_total numeric) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id INT;
    v_numero INT;
BEGIN
    SELECT numeracion_actual_recibo INTO v_numero FROM cajero WHERE id = p_id_cajero;

    INSERT INTO recibo(id_pago, id_cajero, numero_recibo, total)
    VALUES (p_id_pago, p_id_cajero, v_numero, p_total)
    RETURNING id INTO v_id;

    CALL sp_u_cajero_numeracion(p_id_cajero);  -- actualiza numeración

    RETURN v_id;
END;
$$;


ALTER FUNCTION caj.fn_i_recibo(p_id_pago integer, p_id_cajero integer, p_total numeric) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 36628)
-- Name: fn_i_tipo_pago(character varying); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_i_tipo_pago(p_descripcion character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_id INT;
BEGIN
    INSERT INTO tipo_pago(descripcion) VALUES (p_descripcion) RETURNING id INTO v_id;
    RETURN v_id;
END;
$$;


ALTER FUNCTION caj.fn_i_tipo_pago(p_descripcion character varying) OWNER TO postgres;

--
-- TOC entry 587 (class 1255 OID 36629)
-- Name: fn_i_usuario(character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: caj; Owner: postgres
--

CREATE FUNCTION caj.fn_i_usuario(p_nombres character varying, p_apellidos character varying, p_dni character varying, p_direccion character varying, p_telefono character varying, p_correo character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_id INT;
BEGIN
    INSERT INTO usuario(nombres, apellidos, dni, direccion, telefono, correo)
    VALUES (p_nombres, p_apellidos, p_dni, p_direccion, p_telefono, p_correo)
    RETURNING id INTO v_id;
    RETURN v_id;
END;
$$;


ALTER FUNCTION caj.fn_i_usuario(p_nombres character varying, p_apellidos character varying, p_dni character varying, p_direccion character varying, p_telefono character varying, p_correo character varying) OWNER TO postgres;

--
-- TOC entry 569 (class 1255 OID 36630)
-- Name: sp_extornar_pago(integer, integer, integer, text); Type: PROCEDURE; Schema: caj; Owner: postgres
--

CREATE PROCEDURE caj.sp_extornar_pago(IN p_id_pago integer, IN p_id_recibo integer, IN p_id_cajero integer, IN p_motivo text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Registrar el extorno
    INSERT INTO extorno(id_pago, id_recibo, id_cajero, motivo)
    VALUES (p_id_pago, p_id_recibo, p_id_cajero, p_motivo);

    -- Actualizar estado del recibo
    UPDATE recibo
    SET estado = 'EXTORNADO'
    WHERE id = p_id_recibo;
END;
$$;


ALTER PROCEDURE caj.sp_extornar_pago(IN p_id_pago integer, IN p_id_recibo integer, IN p_id_cajero integer, IN p_motivo text) OWNER TO postgres;

--
-- TOC entry 558 (class 1255 OID 36631)
-- Name: sp_u_cajero_numeracion(integer); Type: PROCEDURE; Schema: caj; Owner: postgres
--

CREATE PROCEDURE caj.sp_u_cajero_numeracion(IN p_id_cajero integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE cajero
    SET numeracion_actual_recibo = numeracion_actual_recibo + 1
    WHERE id = p_id_cajero;
END;
$$;


ALTER PROCEDURE caj.sp_u_cajero_numeracion(IN p_id_cajero integer) OWNER TO postgres;

--
-- TOC entry 543 (class 1255 OID 40681)
-- Name: u_actualizar_vistas_materializadas(); Type: PROCEDURE; Schema: gen; Owner: admin
--

CREATE PROCEDURE gen.u_actualizar_vistas_materializadas()
    LANGUAGE plpgsql
    AS $$
BEGIN
    RAISE NOTICE 'Actualizando vistas materializadas del schema gen...';
    
    REFRESH MATERIALIZED VIEW gen.vw_gen_departamento;
    REFRESH MATERIALIZED VIEW gen.vw_gen_provincia;
    REFRESH MATERIALIZED VIEW gen.vw_gen_distrito;
    REFRESH MATERIALIZED VIEW gen.vw_gen_sector;
    REFRESH MATERIALIZED VIEW gen.vw_gen_tipo_via;
    REFRESH MATERIALIZED VIEW gen.vw_gen_tipo_interior;
    REFRESH MATERIALIZED VIEW gen.vw_gen_tipo_habilitacion_urbana;
    REFRESH MATERIALIZED VIEW gen.vw_gen_habilitacion_urbana;
    REFRESH MATERIALIZED VIEW gen.vw_gen_via;
    REFRESH MATERIALIZED VIEW gen.vw_gen_contribuyente;
    REFRESH MATERIALIZED VIEW gen.vw_gen_predio;
    
    RAISE NOTICE 'Vistas materializadas actualizadas exitosamente.';
END;
$$;


ALTER PROCEDURE gen.u_actualizar_vistas_materializadas() OWNER TO admin;

--
-- TOC entry 564 (class 1255 OID 41350)
-- Name: fn_asignar_paciente_a_historia(uuid, uuid); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_asignar_paciente_a_historia(p_id_historia uuid, p_id_paciente uuid) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_estado_actual VARCHAR(50);
    v_paciente_existe BOOLEAN;
    v_paciente_tiene_historia BOOLEAN;
BEGIN
    -- Verificar que la historia clínica existe y obtener su estado
    SELECT estado INTO v_estado_actual
    FROM historia_clinica
    WHERE id_historia = p_id_historia;
    
    IF v_estado_actual IS NULL THEN
        RAISE EXCEPTION 'Historia clínica no encontrada con ID: %', p_id_historia;
    END IF;
    
    -- Verificar que la historia está en estado borrador
    IF v_estado_actual != 'borrador' THEN
        RAISE EXCEPTION 'La historia clínica no está en estado borrador. Estado actual: %', v_estado_actual;
    END IF;
    
    -- Verificar que el paciente existe
    SELECT EXISTS(
        SELECT 1 FROM paciente WHERE id_paciente = p_id_paciente
    ) INTO v_paciente_existe;
    
    IF NOT v_paciente_existe THEN
        RAISE EXCEPTION 'Paciente no encontrado con ID: %', p_id_paciente;
    END IF;
    
    -- Verificar que el paciente no tiene otra historia asignada
    SELECT EXISTS(
        SELECT 1 
        FROM historia_clinica 
        WHERE id_paciente = p_id_paciente 
          AND id_historia != p_id_historia
    ) INTO v_paciente_tiene_historia;
    
    IF v_paciente_tiene_historia THEN
        RAISE EXCEPTION 'El paciente ya tiene una historia clínica asignada';
    END IF;
    
    -- Asignar el paciente y cambiar el estado
    UPDATE historia_clinica
    SET 
        id_paciente = p_id_paciente,
        estado = 'en_proceso',
        ultima_modificacion = CURRENT_TIMESTAMP
    WHERE id_historia = p_id_historia;
    
    RAISE NOTICE 'Paciente % asignado a historia % exitosamente', p_id_paciente, p_id_historia;
    
    RETURN TRUE;
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al asignar paciente: %', SQLERRM;
END;
$$;


ALTER FUNCTION hcl.fn_asignar_paciente_a_historia(p_id_historia uuid, p_id_paciente uuid) OWNER TO admin;

--
-- TOC entry 5621 (class 0 OID 0)
-- Dependencies: 564
-- Name: FUNCTION fn_asignar_paciente_a_historia(p_id_historia uuid, p_id_paciente uuid); Type: COMMENT; Schema: hcl; Owner: admin
--

COMMENT ON FUNCTION hcl.fn_asignar_paciente_a_historia(p_id_historia uuid, p_id_paciente uuid) IS 'Asigna un paciente a una historia clínica en estado borrador y la cambia a estado en_proceso. Valida que la historia esté en borrador y que el paciente no tenga otra historia asignada.';


--
-- TOC entry 574 (class 1255 OID 41362)
-- Name: fn_buscar_paciente_por_dni(character); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_buscar_paciente_por_dni(p_dni character) RETURNS TABLE(id_paciente uuid, nombre character varying, apellido character varying, nombre_completo character varying, dni character, fecha_nacimiento date, edad integer, id_sexo uuid, sexo_descripcion character varying, telefono character varying, email character varying, fecha_registro timestamp without time zone, activo boolean, tiene_historia_clinica boolean)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    -- Validar formato de DNI
    IF NOT (p_dni ~ '^\d{8}$') THEN
        RAISE EXCEPTION 'El DNI debe tener exactamente 8 dígitos numéricos';
    END IF;

    RETURN QUERY
    SELECT 
        p.id_paciente,
        p.nombre,
        p.apellido,
        (p.nombre || ' ' || p.apellido)::VARCHAR(400) AS nombre_completo,
        p.dni,
        p.fecha_nacimiento,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INT AS edad,
        p.id_sexo,
        cs.descripcion AS sexo_descripcion,
        p.telefono,
        p.email,
        p.fecha_registro,
        p.activo,
        EXISTS(SELECT 1 FROM historia_clinica hc WHERE hc.id_paciente = p.id_paciente) AS tiene_historia_clinica
    FROM paciente p
    INNER JOIN catalogo_sexo cs ON p.id_sexo = cs.id_sexo
    WHERE p.dni = p_dni;
END;
$_$;


ALTER FUNCTION hcl.fn_buscar_paciente_por_dni(p_dni character) OWNER TO admin;

--
-- TOC entry 5622 (class 0 OID 0)
-- Dependencies: 574
-- Name: FUNCTION fn_buscar_paciente_por_dni(p_dni character); Type: COMMENT; Schema: hcl; Owner: admin
--

COMMENT ON FUNCTION hcl.fn_buscar_paciente_por_dni(p_dni character) IS 'Busca un paciente por su DNI con validación de formato';


--
-- TOC entry 571 (class 1255 OID 41351)
-- Name: fn_crear_historia_clinica(uuid); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_crear_historia_clinica(p_id_estudiante uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id_historia_clinica uuid;
BEGIN
    INSERT INTO historia_clinica (id_estudiante)
        VALUES (p_id_estudiante)
    RETURNING
        id_historia INTO v_id_historia_clinica;
    RETURN v_id_historia_clinica;
END;
$$;


ALTER FUNCTION hcl.fn_crear_historia_clinica(p_id_estudiante uuid) OWNER TO admin;

--
-- TOC entry 552 (class 1255 OID 41363)
-- Name: fn_crear_paciente(character varying, character varying, character, date, character varying, character varying, character varying); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_crear_paciente(p_nombre character varying, p_apellido character varying, p_dni character, p_fecha_nacimiento date, p_sexo character varying, p_telefono character varying DEFAULT NULL::character varying, p_email character varying DEFAULT NULL::character varying) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id_sexo UUID;
    v_id_paciente UUID;
BEGIN
    -- Obtener el UUID del sexo desde el catálogo
    SELECT id_sexo INTO v_id_sexo
    FROM catalogo_sexo
    WHERE UPPER(descripcion) = UPPER(p_sexo);
    
    IF v_id_sexo IS NULL THEN
        RAISE EXCEPTION 'El sexo proporcionado no existe en el catálogo. Use: Masculino o Femenino';
    END IF;

    -- Insertar el paciente
    INSERT INTO paciente (
        nombre,
        apellido,
        dni,
        fecha_nacimiento,
        id_sexo,
        telefono,
        email,
        fecha_registro,
        activo
    ) VALUES (
        p_nombre,
        p_apellido,
        p_dni,
        p_fecha_nacimiento,
        v_id_sexo,
        p_telefono,
        p_email,
        CURRENT_TIMESTAMP,
        TRUE
    )
    RETURNING id_paciente INTO v_id_paciente;

    RAISE NOTICE 'Paciente creado: % % (DNI: %) con ID: %', p_nombre, p_apellido, p_dni, v_id_paciente;

    RETURN v_id_paciente;

EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Ya existe un paciente registrado con el DNI: %', p_dni;
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'Error de integridad referencial: %', SQLERRM;
    WHEN check_violation THEN
        RAISE EXCEPTION 'Error de validación de datos: %', SQLERRM;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al crear paciente: %', SQLERRM;
END;
$$;


ALTER FUNCTION hcl.fn_crear_paciente(p_nombre character varying, p_apellido character varying, p_dni character, p_fecha_nacimiento date, p_sexo character varying, p_telefono character varying, p_email character varying) OWNER TO admin;

--
-- TOC entry 5623 (class 0 OID 0)
-- Dependencies: 552
-- Name: FUNCTION fn_crear_paciente(p_nombre character varying, p_apellido character varying, p_dni character, p_fecha_nacimiento date, p_sexo character varying, p_telefono character varying, p_email character varying); Type: COMMENT; Schema: hcl; Owner: admin
--

COMMENT ON FUNCTION hcl.fn_crear_paciente(p_nombre character varying, p_apellido character varying, p_dni character, p_fecha_nacimiento date, p_sexo character varying, p_telefono character varying, p_email character varying) IS 'Crea un nuevo paciente y retorna su UUID';


--
-- TOC entry 580 (class 1255 OID 41364)
-- Name: fn_listar_pacientes(boolean, character varying, integer, integer); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_listar_pacientes(p_activo boolean DEFAULT NULL::boolean, p_busqueda character varying DEFAULT NULL::character varying, p_limite integer DEFAULT 50, p_offset integer DEFAULT 0) RETURNS TABLE(id_paciente uuid, nombre character varying, apellido character varying, nombre_completo character varying, dni character, fecha_nacimiento date, edad integer, sexo_descripcion character varying, telefono character varying, email character varying, fecha_registro timestamp without time zone, activo boolean, tiene_historia_clinica boolean)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_paciente,
        p.nombre,
        p.apellido,
        (p.nombre || ' ' || p.apellido)::VARCHAR(400) AS nombre_completo,
        p.dni,
        p.fecha_nacimiento,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INT AS edad,
        cs.descripcion AS sexo_descripcion,
        p.telefono,
        p.email,
        p.fecha_registro,
        p.activo,
        EXISTS(SELECT 1 FROM historia_clinica hc WHERE hc.id_paciente = p.id_paciente) AS tiene_historia_clinica
    FROM paciente p
    INNER JOIN catalogo_sexo cs ON p.id_sexo = cs.id_sexo
    WHERE 
        -- Filtro por estado activo
        (p_activo IS NULL OR p.activo = p_activo)
        AND
        -- Filtro por búsqueda en nombre, apellido o DNI
        (
            p_busqueda IS NULL 
            OR p.nombre ILIKE '%' || p_busqueda || '%'
            OR p.apellido ILIKE '%' || p_busqueda || '%'
            OR (p.nombre || ' ' || p.apellido) ILIKE '%' || p_busqueda || '%'
            OR p.dni LIKE '%' || p_busqueda || '%'
        )
    ORDER BY p.fecha_registro DESC
    LIMIT p_limite
    OFFSET p_offset;
END;
$$;


ALTER FUNCTION hcl.fn_listar_pacientes(p_activo boolean, p_busqueda character varying, p_limite integer, p_offset integer) OWNER TO admin;

--
-- TOC entry 5624 (class 0 OID 0)
-- Dependencies: 580
-- Name: FUNCTION fn_listar_pacientes(p_activo boolean, p_busqueda character varying, p_limite integer, p_offset integer); Type: COMMENT; Schema: hcl; Owner: admin
--

COMMENT ON FUNCTION hcl.fn_listar_pacientes(p_activo boolean, p_busqueda character varying, p_limite integer, p_offset integer) IS 'Lista todos los pacientes con filtros opcionales por estado activo y búsqueda por nombre, apellido o DNI. Incluye paginación.';


--
-- TOC entry 555 (class 1255 OID 41352)
-- Name: fn_obtener_filiacion(uuid); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_obtener_filiacion(p_id_historia uuid) RETURNS TABLE(id_filiacion uuid, id_historia uuid, raza character varying, fecha_nacimiento date, lugar character varying, estado_civil character varying, nombre_conyuge character varying, ocupacion character varying, lugar_procedencia character varying, tiempo_residencia_tacna character varying, direccion character varying, grado_instruccion character varying, ultima_visita_dentista date, motivo_visita_dentista character varying, ultima_visita_medico date, motivo_visita_medico character varying, contacto_emergencia character varying, telefono_emergencia character varying, acompaniante character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        f.id_filiacion,
        f.id_historia,
        f.raza,
        f.fecha_nacimiento,
        f.lugar,
        ec.descripcion AS estado_civil,
        f.nombre_conyuge,
        oc.descripcion AS ocupacion,
        f.lugar_procedencia,
        f.tiempo_residencia_tacna,
        f.direccion,
        gi.descripcion AS grado_instruccion,
        f.ultima_visita_dentista,
        f.motivo_visita_dentista,
        f.ultima_visita_medico,
        f.motivo_visita_medico,
        f.contacto_emergencia,
        f.telefono_emergencia,
        f.acompaniante
    FROM
        filiacion f
        INNER JOIN catalogo_estado_civil ec ON f.id_estado_civil = ec.id_estado_civil
        INNER JOIN catalogo_ocupacion oc ON f.id_ocupacion = oc.id_ocupacion
        INNER JOIN catalogo_grado_instruccion gi ON f.id_grado_instruccion = gi.id_grado_instruccion
    WHERE
        f.id_historia = p_id_historia;
END;
$$;


ALTER FUNCTION hcl.fn_obtener_filiacion(p_id_historia uuid) OWNER TO admin;

--
-- TOC entry 548 (class 1255 OID 41353)
-- Name: fn_obtener_o_crear_borrador(uuid); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_obtener_o_crear_borrador(p_id_estudiante uuid) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id_historia UUID;
BEGIN
    -- Buscar si ya existe un borrador para este estudiante
    SELECT id_historia INTO v_id_historia
    FROM historia_clinica
    WHERE id_estudiante = p_id_estudiante
      AND estado = 'borrador'
    LIMIT 1;
    
    -- Si existe, devolverlo
    IF v_id_historia IS NOT NULL THEN
        RAISE NOTICE 'Borrador existente encontrado para estudiante %: %', p_id_estudiante, v_id_historia;
        RETURN v_id_historia;
    END IF;
    
    -- Si no existe, crear uno nuevo
    INSERT INTO historia_clinica (
        id_estudiante,
        fecha_elaboracion,
        ultima_modificacion,
        estado
    ) VALUES (
        p_id_estudiante,
        CURRENT_DATE,
        CURRENT_TIMESTAMP,
        'borrador'
    )
    RETURNING id_historia INTO v_id_historia;
    
    RAISE NOTICE 'Nuevo borrador creado para estudiante %: %', p_id_estudiante, v_id_historia;
    RETURN v_id_historia;
END;
$$;


ALTER FUNCTION hcl.fn_obtener_o_crear_borrador(p_id_estudiante uuid) OWNER TO admin;

--
-- TOC entry 5625 (class 0 OID 0)
-- Dependencies: 548
-- Name: FUNCTION fn_obtener_o_crear_borrador(p_id_estudiante uuid); Type: COMMENT; Schema: hcl; Owner: admin
--

COMMENT ON FUNCTION hcl.fn_obtener_o_crear_borrador(p_id_estudiante uuid) IS 'Retorna el ID del borrador existente del estudiante o crea uno nuevo si no existe. Garantiza que cada estudiante tenga máximo un borrador a la vez.';


--
-- TOC entry 504 (class 1255 OID 41358)
-- Name: fn_obtener_paciente_por_historia(uuid); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_obtener_paciente_por_historia(p_id_historia uuid) RETURNS TABLE(id_paciente uuid, dni character, nombre character varying, apellido character varying, fecha_nacimiento date, edad integer, sexo character varying, telefono character varying, email character varying, fecha_registro timestamp without time zone, activo boolean)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_paciente,
        p.dni,
        p.nombre,
        p.apellido,
        p.fecha_nacimiento,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INTEGER AS edad,
        cs.descripcion AS sexo,
        p.telefono,
        p.email,
        p.fecha_registro,
        p.activo
    FROM historia_clinica hc
    INNER JOIN paciente p ON hc.id_paciente = p.id_paciente
    LEFT JOIN catalogo_sexo cs ON p.id_sexo = cs.id_sexo
    WHERE hc.id_historia = p_id_historia;
    
    -- Si no se encuentra, devolver vacío (no error)
    IF NOT FOUND THEN
        RAISE NOTICE 'No se encontró paciente para la historia %', p_id_historia;
    END IF;
END;
$$;


ALTER FUNCTION hcl.fn_obtener_paciente_por_historia(p_id_historia uuid) OWNER TO admin;

--
-- TOC entry 5626 (class 0 OID 0)
-- Dependencies: 504
-- Name: FUNCTION fn_obtener_paciente_por_historia(p_id_historia uuid); Type: COMMENT; Schema: hcl; Owner: admin
--

COMMENT ON FUNCTION hcl.fn_obtener_paciente_por_historia(p_id_historia uuid) IS 'Retorna los datos completos del paciente asociado a una historia clínica. Devuelve NULL si la historia no tiene paciente asignado.';


--
-- TOC entry 515 (class 1255 OID 41374)
-- Name: fn_obtener_paciente_por_id(uuid); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_obtener_paciente_por_id(p_id_paciente uuid) RETURNS TABLE(id_paciente uuid, nombre character varying, apellido character varying, nombre_completo character varying, dni character, fecha_nacimiento date, edad integer, id_sexo uuid, sexo_descripcion character varying, telefono character varying, email character varying, fecha_registro timestamp without time zone, activo boolean, tiene_historia_clinica boolean)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_paciente,
        p.nombre,
        p.apellido,
        (p.nombre || ' ' || p.apellido)::VARCHAR(400) AS nombre_completo,
        p.dni,
        p.fecha_nacimiento,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INT AS edad,
        p.id_sexo,
        cs.descripcion AS sexo_descripcion,
        p.telefono,
        p.email,
        p.fecha_registro,
        p.activo,
        EXISTS(SELECT 1 FROM historia_clinica hc WHERE hc.id_paciente = p.id_paciente) AS tiene_historia_clinica
    FROM paciente p
    INNER JOIN catalogo_sexo cs ON p.id_sexo = cs.id_sexo
    WHERE p.id_paciente = p_id_paciente;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró un paciente con el ID proporcionado';
    END IF;
END;
$$;


ALTER FUNCTION hcl.fn_obtener_paciente_por_id(p_id_paciente uuid) OWNER TO admin;

--
-- TOC entry 5627 (class 0 OID 0)
-- Dependencies: 515
-- Name: FUNCTION fn_obtener_paciente_por_id(p_id_paciente uuid); Type: COMMENT; Schema: hcl; Owner: admin
--

COMMENT ON FUNCTION hcl.fn_obtener_paciente_por_id(p_id_paciente uuid) IS 'Obtiene los datos completos de un paciente por su ID, incluyendo edad calculada y descripción del sexo';


--
-- TOC entry 577 (class 1255 OID 36533)
-- Name: fn_obtener_pacientes_adultos(uuid); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_obtener_pacientes_adultos(p_id_estudiante uuid) RETURNS TABLE(id_paciente uuid, id_historia uuid, nombre character varying, apellido character varying, nombre_completo character varying, edad integer, telefono character varying, email character varying, sexo character varying, ultima_modificacion timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.id_paciente,
        h.id_historia,
        p.nombre,
        p.apellido,
        (p.nombre || ' ' || p.apellido)::VARCHAR AS nombre_completo,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INT AS edad,
        p.telefono,
        p.email,
        s.descripcion AS sexo,
        h.ultima_modificacion
    FROM
        historia_clinica h
        INNER JOIN paciente p ON h.id_paciente = p.id_paciente
        LEFT JOIN catalogo_sexo s ON p.id_sexo = s.id_sexo
    WHERE
        h.id_estudiante = p_id_estudiante
        AND EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento))::INT >= 18;
END;
$$;


ALTER FUNCTION hcl.fn_obtener_pacientes_adultos(p_id_estudiante uuid) OWNER TO admin;

--
-- TOC entry 579 (class 1255 OID 41404)
-- Name: fn_obtener_usuario(uuid); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_obtener_usuario(p_id_usuario uuid) RETURNS TABLE(id_usuario uuid, codigo_usuario character varying, nombre character varying, apellido character varying, dni character, email character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_usuario,
           u.codigo_usuario,
           u.nombre,
           u.apellido,
           u.dni,
           u.email
    FROM usuario u
    WHERE u.id_usuario = p_id_usuario;
END;
$$;


ALTER FUNCTION hcl.fn_obtener_usuario(p_id_usuario uuid) OWNER TO admin;

--
-- TOC entry 590 (class 1255 OID 41394)
-- Name: fn_obtener_usuario_login(character varying); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_obtener_usuario_login(p_codigo_usuario character varying) RETURNS TABLE(id_usuario uuid, codigo_usuario character varying, nombre character varying, apellido character varying, dni character, email character varying, rol character varying, contrasena_hash character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_usuario, u.codigo_usuario, u.nombre, u.apellido, 
           u.dni, u.email, u.rol, u.contrasena_hash
    FROM usuario u
    WHERE u.codigo_usuario = p_codigo_usuario 
      AND u.activo = TRUE;
END;
$$;


ALTER FUNCTION hcl.fn_obtener_usuario_login(p_codigo_usuario character varying) OWNER TO admin;

--
-- TOC entry 576 (class 1255 OID 41375)
-- Name: fn_verificar_paciente_existe(character); Type: FUNCTION; Schema: hcl; Owner: admin
--

CREATE FUNCTION hcl.fn_verificar_paciente_existe(p_dni character) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
    v_existe BOOLEAN;
BEGIN
    -- Validar formato de DNI
    IF NOT (p_dni ~ '^\d{8}$') THEN
        RAISE EXCEPTION 'El DNI debe tener exactamente 8 dígitos numéricos';
    END IF;

    SELECT EXISTS(
        SELECT 1 
        FROM paciente 
        WHERE dni = p_dni
    ) INTO v_existe;
    
    RETURN v_existe;
END;
$_$;


ALTER FUNCTION hcl.fn_verificar_paciente_existe(p_dni character) OWNER TO admin;

--
-- TOC entry 5628 (class 0 OID 0)
-- Dependencies: 576
-- Name: FUNCTION fn_verificar_paciente_existe(p_dni character); Type: COMMENT; Schema: hcl; Owner: admin
--

COMMENT ON FUNCTION hcl.fn_verificar_paciente_existe(p_dni character) IS 'Verifica si existe un paciente con el DNI proporcionado. Útil para validaciones previas al registro.';


--
-- TOC entry 554 (class 1255 OID 40992)
-- Name: fn_actualizar_modificado(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_actualizar_modificado() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.f_modificado := CURRENT_DATE;
    NEW.h_modificado := CURRENT_TIME;
    RETURN NEW;
END;
$$;


ALTER FUNCTION lic.fn_actualizar_modificado() OWNER TO admin;

--
-- TOC entry 595 (class 1255 OID 40996)
-- Name: fn_actualizar_vista_actividad_comercial(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_actualizar_vista_actividad_comercial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lic.vw_lic_actividad_comercial;
    RETURN NULL;
END;
$$;


ALTER FUNCTION lic.fn_actualizar_vista_actividad_comercial() OWNER TO admin;

--
-- TOC entry 507 (class 1255 OID 40995)
-- Name: fn_actualizar_vista_condicion_local(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_actualizar_vista_condicion_local() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lic.vw_lic_condicion_local;
    RETURN NULL;
END;
$$;


ALTER FUNCTION lic.fn_actualizar_vista_condicion_local() OWNER TO admin;

--
-- TOC entry 537 (class 1255 OID 40998)
-- Name: fn_actualizar_vista_giro_negocio(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_actualizar_vista_giro_negocio() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lic.vw_lic_giro_negocio;
    RETURN NULL;
END;
$$;


ALTER FUNCTION lic.fn_actualizar_vista_giro_negocio() OWNER TO admin;

--
-- TOC entry 584 (class 1255 OID 41000)
-- Name: fn_actualizar_vista_licencia(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_actualizar_vista_licencia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lic.vw_lic_licencia;
    RETURN NULL;
END;
$$;


ALTER FUNCTION lic.fn_actualizar_vista_licencia() OWNER TO admin;

--
-- TOC entry 532 (class 1255 OID 40993)
-- Name: fn_actualizar_vista_motivo_registro(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_actualizar_vista_motivo_registro() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lic.vw_lic_motivo_registro;
    REFRESH MATERIALIZED VIEW lic.vw_lic_motivo_anulacion;
    RETURN NULL;
END;
$$;


ALTER FUNCTION lic.fn_actualizar_vista_motivo_registro() OWNER TO admin;

--
-- TOC entry 514 (class 1255 OID 40999)
-- Name: fn_actualizar_vista_requisito(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_actualizar_vista_requisito() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lic.vw_lic_requisito;
    RETURN NULL;
END;
$$;


ALTER FUNCTION lic.fn_actualizar_vista_requisito() OWNER TO admin;

--
-- TOC entry 599 (class 1255 OID 40997)
-- Name: fn_actualizar_vista_tipo_establecimiento(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_actualizar_vista_tipo_establecimiento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lic.vw_lic_tipo_establecimiento;
    RETURN NULL;
END;
$$;


ALTER FUNCTION lic.fn_actualizar_vista_tipo_establecimiento() OWNER TO admin;

--
-- TOC entry 534 (class 1255 OID 40994)
-- Name: fn_actualizar_vista_tipo_licencia(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_actualizar_vista_tipo_licencia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    REFRESH MATERIALIZED VIEW lic.vw_lic_tipo_licencia;
    RETURN NULL;
END;
$$;


ALTER FUNCTION lic.fn_actualizar_vista_tipo_licencia() OWNER TO admin;

--
-- TOC entry 516 (class 1255 OID 40987)
-- Name: fn_contar_licencias(integer); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_contar_licencias(p_id_contribuyente integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_total INT;
BEGIN
    SELECT COUNT(*) INTO v_total
    FROM lic.lic_licencia
    WHERE id_contribuyente = p_id_contribuyente;
    RETURN COALESCE(v_total, 0);
END;
$$;


ALTER FUNCTION lic.fn_contar_licencias(p_id_contribuyente integer) OWNER TO admin;

--
-- TOC entry 581 (class 1255 OID 40988)
-- Name: fn_detalle_licencia(integer); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_detalle_licencia(p_id_licencia integer) RETURNS TABLE(contribuyente text, nombre_licencia text, tipo_licencia text, actividad text, giro text, desde date, hasta date, estado character varying, numero_expediente text, numero_resolucion text, numero_certificado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.nombre AS contribuyente,
        l.nombre AS nombre_licencia,
        tl.nombre AS tipo_licencia,
        ac.nombre AS actividad,
        gn.nombre AS giro,
        gl.desde,
        gl.hasta,
        l.estado,
        l.num_expediente AS numero_expediente,
        l.num_resolucion AS numero_resolucion,
        l.num_certificado AS numero_certificado
    FROM lic.lic_licencia AS l
        JOIN gen.gen_contribuyente AS c ON l.id_contribuyente = c.id
        JOIN lic.lic_tipo_licencia AS tl ON l.id_tipo_licencia = tl.id
        JOIN lic.lic_actividad_comercial AS ac ON l.id_actividad_comercial = ac.id
        JOIN lic.lic_giro_licencia AS gl ON l.id_giro_licencia = gl.id
        JOIN lic.lic_giro_negocio AS gn ON gl.id_giro_negocio = gn.id
    WHERE l.id = p_id_licencia;
END;
$$;


ALTER FUNCTION lic.fn_detalle_licencia(p_id_licencia integer) OWNER TO admin;

--
-- TOC entry 573 (class 1255 OID 40990)
-- Name: fn_evitar_duplicados_catalogo(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_evitar_duplicados_catalogo() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    v_count INTEGER;
    v_table_full_name TEXT;
BEGIN
    v_table_full_name := TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME;
    
    EXECUTE format(
        'SELECT COUNT(*) FROM %I.%I WHERE UPPER(nombre) = UPPER($1) AND id != $2', 
        TG_TABLE_SCHEMA,
        TG_TABLE_NAME
    )
    INTO v_count
    USING NEW.nombre, COALESCE(NEW.id, -1);
    
    IF v_count > 0 THEN
        RAISE EXCEPTION 'El registro "%" ya existe en % (búsqueda insensible a mayúsculas)', 
            NEW.nombre, v_table_full_name;
    END IF;
    
    RETURN NEW;
END;
$_$;


ALTER FUNCTION lic.fn_evitar_duplicados_catalogo() OWNER TO admin;

--
-- TOC entry 538 (class 1255 OID 40991)
-- Name: fn_evitar_eliminar_ultimo(); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_evitar_eliminar_ultimo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_total_registros INTEGER;
    v_table_full_name TEXT;
BEGIN
    v_table_full_name := TG_TABLE_SCHEMA || '.' || TG_TABLE_NAME;
    
    EXECUTE format('SELECT COUNT(*) FROM %I.%I', TG_TABLE_SCHEMA, TG_TABLE_NAME) 
        INTO v_total_registros;
    
    IF v_total_registros <= 1 THEN
        RAISE EXCEPTION 'No se puede eliminar el último registro de la tabla %', 
            v_table_full_name;
    END IF;
    
    RETURN OLD;
END;
$$;


ALTER FUNCTION lic.fn_evitar_eliminar_ultimo() OWNER TO admin;

--
-- TOC entry 551 (class 1255 OID 40984)
-- Name: fn_reporte_contribuyente(date, date); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_reporte_contribuyente(p_fecha_desde date, p_fecha_hasta date) RETURNS TABLE(descid text, ncertif text, acertif text, fcertif text, nexped text, fexped text, nresoluc text, fresoluc text, nombrecom text, contrib text, nomb_rz text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        l.estado::TEXT AS Descid,
        l.num_certificado::TEXT AS Ncertif,
        l.anio_certificado::TEXT AS Acertif,
        l.certificado_fecha::TEXT AS Fcertif,
        l.num_expediente::TEXT AS Nexped,
        l.expediente_fecha::TEXT AS Fexped,
        l.num_resolucion::TEXT AS Nresoluc,
        l.resolucion_fecha::TEXT AS Fresoluc,
        l.nombre::TEXT AS Nombrecom,
        c.dni::TEXT AS Contrib,
        c.nombre::TEXT AS Nomb_rz
    FROM lic.lic_licencia AS l
        JOIN gen.gen_contribuyente AS c ON c.id = l.id_contribuyente
    WHERE l.f_creado BETWEEN p_fecha_desde AND p_fecha_hasta
    ORDER BY c.nombre;
END;
$$;


ALTER FUNCTION lic.fn_reporte_contribuyente(p_fecha_desde date, p_fecha_hasta date) OWNER TO admin;

--
-- TOC entry 506 (class 1255 OID 40985)
-- Name: fn_reporte_predio(date, date); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_reporte_predio(p_fecha_desde date, p_fecha_hasta date) RETURNS TABLE(descid text, ncertif text, acertif text, fcertif text, nexped text, fexped text, nresoluc text, fresoluc text, nombrecom text, contrib text, nomb_rz text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        l.estado::TEXT AS Descid,
        l.num_certificado::TEXT AS Ncertif,
        l.anio_certificado::TEXT AS Acertif,
        l.certificado_fecha::TEXT AS Fcertif,
        l.num_expediente::TEXT AS Nexped,
        l.expediente_fecha::TEXT AS Fexped,
        l.num_resolucion::TEXT AS Nresoluc,
        l.resolucion_fecha::TEXT AS Fresoluc,
        l.nombre::TEXT AS Nombrecom,
        c.dni::TEXT AS Contrib,
        c.nombre::TEXT AS Nomb_rz
    FROM lic.lic_licencia AS l 
        JOIN gen.gen_contribuyente AS c ON c.id = l.id_contribuyente
        JOIN gen.gen_predio AS p ON p.id = l.id_predio
        LEFT JOIN gen.gen_via AS v ON p.id_via = v.id
    WHERE l.f_creado BETWEEN p_fecha_desde AND p_fecha_hasta
    ORDER BY CONCAT_WS(' ', v.nombre, p.numero, p.manzana, p.letra);
END;
$$;


ALTER FUNCTION lic.fn_reporte_predio(p_fecha_desde date, p_fecha_hasta date) OWNER TO admin;

--
-- TOC entry 525 (class 1255 OID 40986)
-- Name: fn_reporte_tipo_requisito(text, text); Type: FUNCTION; Schema: lic; Owner: admin
--

CREATE FUNCTION lic.fn_reporte_tipo_requisito(p_tipo_doc text, p_orden_por text DEFAULT 'contribuyente'::text) RETURNS TABLE(descid text, ncertif text, acertif text, fcertif text, nexped text, fexped text, nresoluc text, fresoluc text, nombrecom text, contrib text, nomb_rz text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        l.estado::TEXT AS Descid,
        l.num_certificado::TEXT AS Ncertif,
        l.anio_certificado::TEXT AS Acertif,
        l.certificado_fecha::TEXT AS Fcertif,
        l.num_expediente::TEXT AS Nexped,
        l.expediente_fecha::TEXT AS Fexped,
        l.num_resolucion::TEXT AS Nresoluc,
        l.resolucion_fecha::TEXT AS Fresoluc,
        l.nombre::TEXT AS Nombrecom,
        c.dni::TEXT AS Contrib,
        c.nombre::TEXT AS Nomb_rz
    FROM lic.lic_licencia AS l 
        JOIN lic.lic_motivo_registro AS mr ON mr.id = l.id_motivo_registro
        JOIN gen.gen_contribuyente AS c ON c.id = l.id_contribuyente
        JOIN gen.gen_predio AS p ON p.id = l.id_predio
        LEFT JOIN gen.gen_via AS v ON p.id_via = v.id
    WHERE mr.nombre = p_tipo_doc
    ORDER BY 
        CASE 
            WHEN LOWER(p_orden_por) = 'contribuyente' THEN c.nombre
            ELSE CONCAT_WS(' ', v.nombre, p.numero, p.manzana, p.letra)
        END;
END;
$$;


ALTER FUNCTION lic.fn_reporte_tipo_requisito(p_tipo_doc text, p_orden_por text) OWNER TO admin;

--
-- TOC entry 528 (class 1255 OID 40989)
-- Name: u_actualizar_vistas_materializadas(); Type: PROCEDURE; Schema: lic; Owner: admin
--

CREATE PROCEDURE lic.u_actualizar_vistas_materializadas()
    LANGUAGE plpgsql
    AS $$
BEGIN
    RAISE NOTICE 'Actualizando vistas materializadas...';
    
    REFRESH MATERIALIZED VIEW lic.vw_lic_motivo_registro;
    REFRESH MATERIALIZED VIEW lic.vw_lic_motivo_anulacion;
    REFRESH MATERIALIZED VIEW lic.vw_lic_tipo_licencia;
    REFRESH MATERIALIZED VIEW lic.vw_lic_condicion_local;
    REFRESH MATERIALIZED VIEW lic.vw_lic_actividad_comercial;
    REFRESH MATERIALIZED VIEW lic.vw_lic_tipo_establecimiento;
    REFRESH MATERIALIZED VIEW lic.vw_lic_giro_negocio;
    REFRESH MATERIALIZED VIEW lic.vw_lic_requisito;
    REFRESH MATERIALIZED VIEW lic.vw_lic_licencia;
    
    RAISE NOTICE 'Todas las vistas materializadas han sido actualizadas.';
END;
$$;


ALTER PROCEDURE lic.u_actualizar_vistas_materializadas() OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 498 (class 1259 OID 42034)
-- Name: alc_contrato_alcabala; Type: TABLE; Schema: alc; Owner: admin
--

CREATE TABLE alc.alc_contrato_alcabala (
    id integer NOT NULL,
    codigo_contrato character varying(20),
    n_contrato character varying(20),
    fecha_contrato date NOT NULL,
    fecha_proceso date DEFAULT CURRENT_DATE,
    tipo_transferencia character varying(50),
    notaria character varying(100),
    nombre_notaria character varying(100),
    n_minuta character varying(50),
    n_preminuta character varying(50),
    id_predio integer NOT NULL,
    id_entidad_inafecta integer,
    id_factor_calculo integer,
    id_contribuyente_transferente integer,
    id_contribuyente_adquiriente integer,
    valor_venta numeric(12,2) NOT NULL,
    base_imponible numeric(12,2) NOT NULL,
    valor_base_imponible_actualizado numeric(12,2),
    valor_mayor numeric(12,2),
    tramo_afecto numeric(12,2),
    impuesto_calculado numeric(12,2),
    intereses numeric(12,2) DEFAULT 0.00,
    total_a_pagar numeric(12,2),
    usuario_creador character varying(50) NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usuario_modificador character varying(50),
    fecha_modificacion timestamp without time zone
);


ALTER TABLE alc.alc_contrato_alcabala OWNER TO admin;

--
-- TOC entry 497 (class 1259 OID 42033)
-- Name: alc_contrato_alcabala_id_seq; Type: SEQUENCE; Schema: alc; Owner: admin
--

CREATE SEQUENCE alc.alc_contrato_alcabala_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE alc.alc_contrato_alcabala_id_seq OWNER TO admin;

--
-- TOC entry 5629 (class 0 OID 0)
-- Dependencies: 497
-- Name: alc_contrato_alcabala_id_seq; Type: SEQUENCE OWNED BY; Schema: alc; Owner: admin
--

ALTER SEQUENCE alc.alc_contrato_alcabala_id_seq OWNED BY alc.alc_contrato_alcabala.id;


--
-- TOC entry 494 (class 1259 OID 42017)
-- Name: alc_entidad_inafecta; Type: TABLE; Schema: alc; Owner: admin
--

CREATE TABLE alc.alc_entidad_inafecta (
    id integer NOT NULL,
    codigo character varying(20),
    nombre character varying(200) NOT NULL,
    abreviatura character varying(50),
    usuario_creador character varying(50) NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usuario_modificador character varying(50),
    fecha_modificacion timestamp without time zone
);


ALTER TABLE alc.alc_entidad_inafecta OWNER TO admin;

--
-- TOC entry 493 (class 1259 OID 42016)
-- Name: alc_entidad_inafecta_id_seq; Type: SEQUENCE; Schema: alc; Owner: admin
--

CREATE SEQUENCE alc.alc_entidad_inafecta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE alc.alc_entidad_inafecta_id_seq OWNER TO admin;

--
-- TOC entry 5630 (class 0 OID 0)
-- Dependencies: 493
-- Name: alc_entidad_inafecta_id_seq; Type: SEQUENCE OWNED BY; Schema: alc; Owner: admin
--

ALTER SEQUENCE alc.alc_entidad_inafecta_id_seq OWNED BY alc.alc_entidad_inafecta.id;


--
-- TOC entry 500 (class 1259 OID 42071)
-- Name: alc_estado_contrato; Type: TABLE; Schema: alc; Owner: admin
--

CREATE TABLE alc.alc_estado_contrato (
    id integer NOT NULL,
    id_contrato_alcabala integer NOT NULL,
    estado_contrato character varying(20) NOT NULL,
    fecha_pago date,
    n_recibo character varying(50),
    codigo_caja character varying(20),
    usuario_creador character varying(50) NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usuario_modificador character varying(50),
    fecha_modificacion timestamp without time zone
);


ALTER TABLE alc.alc_estado_contrato OWNER TO admin;

--
-- TOC entry 499 (class 1259 OID 42070)
-- Name: alc_estado_contrato_id_seq; Type: SEQUENCE; Schema: alc; Owner: admin
--

CREATE SEQUENCE alc.alc_estado_contrato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE alc.alc_estado_contrato_id_seq OWNER TO admin;

--
-- TOC entry 5631 (class 0 OID 0)
-- Dependencies: 499
-- Name: alc_estado_contrato_id_seq; Type: SEQUENCE OWNED BY; Schema: alc; Owner: admin
--

ALTER SEQUENCE alc.alc_estado_contrato_id_seq OWNED BY alc.alc_estado_contrato.id;


--
-- TOC entry 496 (class 1259 OID 42025)
-- Name: alc_factor_calculo; Type: TABLE; Schema: alc; Owner: admin
--

CREATE TABLE alc.alc_factor_calculo (
    id integer NOT NULL,
    anio integer NOT NULL,
    mes integer NOT NULL,
    valor_ipm numeric(10,6) NOT NULL,
    uit_valor numeric(10,2) NOT NULL,
    porcentaje_impuesto numeric(5,2) DEFAULT 3.00,
    fecha_vencimiento date,
    usuario_creador character varying(50) NOT NULL,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usuario_modificador character varying(50),
    fecha_modificacion timestamp without time zone
);


ALTER TABLE alc.alc_factor_calculo OWNER TO admin;

--
-- TOC entry 495 (class 1259 OID 42024)
-- Name: alc_factor_calculo_id_seq; Type: SEQUENCE; Schema: alc; Owner: admin
--

CREATE SEQUENCE alc.alc_factor_calculo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE alc.alc_factor_calculo_id_seq OWNER TO admin;

--
-- TOC entry 5632 (class 0 OID 0)
-- Dependencies: 495
-- Name: alc_factor_calculo_id_seq; Type: SEQUENCE OWNED BY; Schema: alc; Owner: admin
--

ALTER SEQUENCE alc.alc_factor_calculo_id_seq OWNED BY alc.alc_factor_calculo.id;


--
-- TOC entry 478 (class 1259 OID 41824)
-- Name: arbitrio; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.arbitrio (
    id_arbitrio integer NOT NULL,
    id_contribuyente integer,
    id_predio integer,
    id_tipo_registro_origen integer,
    anio integer NOT NULL,
    estado arb.tp_estado DEFAULT 'activo'::arb.tp_estado,
    observacion character varying(300),
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.arbitrio OWNER TO admin;

--
-- TOC entry 480 (class 1259 OID 41850)
-- Name: arbitrio_detalle; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.arbitrio_detalle (
    id_arbitrio_detalle integer NOT NULL,
    id_arbitrio integer,
    id_tipo_beneficio_limpieza_publica integer,
    id_tipo_beneficio_parques_jardines integer,
    id_tipo_beneficio_relleno_sanitario integer,
    id_tipo_beneficio_serenazgo integer,
    frentera_metros numeric(15,2),
    frecuencia_barrido integer,
    nro_habitantes integer,
    area_construida numeric(15,2),
    area_terreno numeric(15,2),
    tiene_licencia boolean,
    porcentaje_inseguridad numeric(5,2),
    monto_base numeric(15,2),
    monto_final numeric(15,2),
    distancia_a_parque numeric(10,2),
    enero boolean,
    febrero boolean,
    marzo boolean,
    abril boolean,
    mayo boolean,
    junio boolean,
    julio boolean,
    agosto boolean,
    septiembre boolean,
    octubre boolean,
    noviembre boolean,
    diciembre boolean,
    anio integer,
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100),
    interes numeric(10,2),
    mora numeric(10,2)
);


ALTER TABLE arb.arbitrio_detalle OWNER TO admin;

--
-- TOC entry 479 (class 1259 OID 41849)
-- Name: arbitrio_detalle_id_arbitrio_detalle_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.arbitrio_detalle_id_arbitrio_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.arbitrio_detalle_id_arbitrio_detalle_seq OWNER TO admin;

--
-- TOC entry 5633 (class 0 OID 0)
-- Dependencies: 479
-- Name: arbitrio_detalle_id_arbitrio_detalle_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.arbitrio_detalle_id_arbitrio_detalle_seq OWNED BY arb.arbitrio_detalle.id_arbitrio_detalle;


--
-- TOC entry 477 (class 1259 OID 41823)
-- Name: arbitrio_id_arbitrio_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.arbitrio_id_arbitrio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.arbitrio_id_arbitrio_seq OWNER TO admin;

--
-- TOC entry 5634 (class 0 OID 0)
-- Dependencies: 477
-- Name: arbitrio_id_arbitrio_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.arbitrio_id_arbitrio_seq OWNED BY arb.arbitrio.id_arbitrio;


--
-- TOC entry 474 (class 1259 OID 41803)
-- Name: categoria; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.categoria (
    id_categoria integer NOT NULL,
    codigo character varying(20),
    denominacion character varying(150),
    abreviatura character varying(20),
    id_grupo_categoria integer,
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.categoria OWNER TO admin;

--
-- TOC entry 473 (class 1259 OID 41802)
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.categoria_id_categoria_seq OWNER TO admin;

--
-- TOC entry 5635 (class 0 OID 0)
-- Dependencies: 473
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.categoria_id_categoria_seq OWNED BY arb.categoria.id_categoria;


--
-- TOC entry 492 (class 1259 OID 41996)
-- Name: categoria_tributo; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.categoria_tributo (
    id_categoria_tributo integer NOT NULL,
    id_categoria integer,
    id_tributo integer,
    anio integer,
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.categoria_tributo OWNER TO admin;

--
-- TOC entry 491 (class 1259 OID 41995)
-- Name: categoria_tributo_id_categoria_tributo_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.categoria_tributo_id_categoria_tributo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.categoria_tributo_id_categoria_tributo_seq OWNER TO admin;

--
-- TOC entry 5636 (class 0 OID 0)
-- Dependencies: 491
-- Name: categoria_tributo_id_categoria_tributo_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.categoria_tributo_id_categoria_tributo_seq OWNED BY arb.categoria_tributo.id_categoria_tributo;


--
-- TOC entry 484 (class 1259 OID 41911)
-- Name: determina_calculo; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.determina_calculo (
    id_determina_calculo integer NOT NULL,
    codigo character varying(20),
    denominacion character varying(100),
    anio integer,
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.determina_calculo OWNER TO admin;

--
-- TOC entry 483 (class 1259 OID 41910)
-- Name: determina_calculo_id_determina_calculo_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.determina_calculo_id_determina_calculo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.determina_calculo_id_determina_calculo_seq OWNER TO admin;

--
-- TOC entry 5637 (class 0 OID 0)
-- Dependencies: 483
-- Name: determina_calculo_id_determina_calculo_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.determina_calculo_id_determina_calculo_seq OWNED BY arb.determina_calculo.id_determina_calculo;


--
-- TOC entry 472 (class 1259 OID 41795)
-- Name: grupo_categoria; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.grupo_categoria (
    id_grupo_categoria integer NOT NULL,
    denominacion character varying(150),
    abreviatura character varying(20),
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.grupo_categoria OWNER TO admin;

--
-- TOC entry 471 (class 1259 OID 41794)
-- Name: grupo_categoria_id_grupo_categoria_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.grupo_categoria_id_grupo_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.grupo_categoria_id_grupo_categoria_seq OWNER TO admin;

--
-- TOC entry 5638 (class 0 OID 0)
-- Dependencies: 471
-- Name: grupo_categoria_id_grupo_categoria_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.grupo_categoria_id_grupo_categoria_seq OWNED BY arb.grupo_categoria.id_grupo_categoria;


--
-- TOC entry 482 (class 1259 OID 41883)
-- Name: licencia_funcionamiento; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.licencia_funcionamiento (
    id_licencia integer NOT NULL,
    id_contribuyente integer,
    id_predio integer,
    id_categoria integer,
    nro_licencia character varying(50),
    categoria_licencia character varying(120),
    fecha_emision date,
    fecha_vencimiento date,
    estado arb.tp_estado DEFAULT 'activo'::arb.tp_estado,
    actividad_comercial character varying(200),
    aforo integer,
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.licencia_funcionamiento OWNER TO admin;

--
-- TOC entry 481 (class 1259 OID 41882)
-- Name: licencia_funcionamiento_id_licencia_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.licencia_funcionamiento_id_licencia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.licencia_funcionamiento_id_licencia_seq OWNER TO admin;

--
-- TOC entry 5639 (class 0 OID 0)
-- Dependencies: 481
-- Name: licencia_funcionamiento_id_licencia_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.licencia_funcionamiento_id_licencia_seq OWNED BY arb.licencia_funcionamiento.id_licencia;


--
-- TOC entry 488 (class 1259 OID 41954)
-- Name: tarifa_area_construida; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.tarifa_area_construida (
    id_tarifa_area_construida integer NOT NULL,
    id_tributo integer,
    id_categoria integer,
    desde_area_construida numeric(15,2) DEFAULT 0.00,
    hasta_area_construida numeric(15,2) DEFAULT 0.00,
    tasa_mensual numeric(15,7) DEFAULT 0.00,
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.tarifa_area_construida OWNER TO admin;

--
-- TOC entry 487 (class 1259 OID 41953)
-- Name: tarifa_area_construida_id_tarifa_area_construida_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.tarifa_area_construida_id_tarifa_area_construida_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.tarifa_area_construida_id_tarifa_area_construida_seq OWNER TO admin;

--
-- TOC entry 5640 (class 0 OID 0)
-- Dependencies: 487
-- Name: tarifa_area_construida_id_tarifa_area_construida_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.tarifa_area_construida_id_tarifa_area_construida_seq OWNED BY arb.tarifa_area_construida.id_tarifa_area_construida;


--
-- TOC entry 490 (class 1259 OID 41975)
-- Name: tarifa_area_terreno; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.tarifa_area_terreno (
    id_tarifa_area_terreno integer NOT NULL,
    id_categoria integer,
    id_tributo integer,
    id_sector character varying(200),
    desde_area_terreno numeric(15,2) DEFAULT 0.00,
    hasta_area_terreno numeric(15,2) DEFAULT 9999999.99,
    tasa_mensual numeric(15,2) DEFAULT 0.00,
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.tarifa_area_terreno OWNER TO admin;

--
-- TOC entry 489 (class 1259 OID 41974)
-- Name: tarifa_area_terreno_id_tarifa_area_terreno_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.tarifa_area_terreno_id_tarifa_area_terreno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.tarifa_area_terreno_id_tarifa_area_terreno_seq OWNER TO admin;

--
-- TOC entry 5641 (class 0 OID 0)
-- Dependencies: 489
-- Name: tarifa_area_terreno_id_tarifa_area_terreno_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.tarifa_area_terreno_id_tarifa_area_terreno_seq OWNED BY arb.tarifa_area_terreno.id_tarifa_area_terreno;


--
-- TOC entry 486 (class 1259 OID 41919)
-- Name: tarifa_categoria; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.tarifa_categoria (
    id_tarifa_categoria integer NOT NULL,
    id_tributo integer NOT NULL,
    id_determina_calculo integer,
    id_categoria integer NOT NULL,
    estado arb.tp_estado DEFAULT 'activo'::arb.tp_estado NOT NULL,
    anio integer NOT NULL,
    codigo character(1),
    denominacion_categoria character varying(150),
    abreviado character varying(20),
    tipo_determinacion_calculo character varying(50),
    desde_mes integer,
    hasta_mes integer,
    monto_fijo_mensual numeric(15,2) DEFAULT 0.00,
    valor_tasa_mensual numeric(15,4) DEFAULT 0.00,
    valor_tasa_metro_lineal numeric(15,7) DEFAULT 0.00,
    nro_habitantes_promedio_predio integer DEFAULT 0,
    factor_variacion_habitante numeric(10,7),
    porcentaje_descuento_subsidio numeric(10,2) DEFAULT 0.00,
    porcentaje_tope_incremento numeric(10,2) DEFAULT 0.00,
    calcular_incremento_sobre_anio numeric(10,2),
    glosa_base_legal character varying(300),
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100),
    CONSTRAINT ch_tarifa_categoria_desde_mes CHECK (((desde_mes >= 1) AND (desde_mes <= 12))),
    CONSTRAINT ch_tarifa_categoria_hasta_mes CHECK (((hasta_mes >= 1) AND (hasta_mes <= 12))),
    CONSTRAINT ch_tarifa_categoria_rango_meses CHECK ((desde_mes <= hasta_mes))
);


ALTER TABLE arb.tarifa_categoria OWNER TO admin;

--
-- TOC entry 485 (class 1259 OID 41918)
-- Name: tarifa_categoria_id_tarifa_categoria_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.tarifa_categoria_id_tarifa_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.tarifa_categoria_id_tarifa_categoria_seq OWNER TO admin;

--
-- TOC entry 5642 (class 0 OID 0)
-- Dependencies: 485
-- Name: tarifa_categoria_id_tarifa_categoria_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.tarifa_categoria_id_tarifa_categoria_seq OWNED BY arb.tarifa_categoria.id_tarifa_categoria;


--
-- TOC entry 470 (class 1259 OID 41782)
-- Name: tipo_beneficio; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.tipo_beneficio (
    id_tipo_beneficio integer NOT NULL,
    codigo character varying(20),
    denominacion character varying(100),
    abreviatura character varying(20),
    id_tributo integer,
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.tipo_beneficio OWNER TO admin;

--
-- TOC entry 469 (class 1259 OID 41781)
-- Name: tipo_beneficio_id_tipo_beneficio_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.tipo_beneficio_id_tipo_beneficio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.tipo_beneficio_id_tipo_beneficio_seq OWNER TO admin;

--
-- TOC entry 5643 (class 0 OID 0)
-- Dependencies: 469
-- Name: tipo_beneficio_id_tipo_beneficio_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.tipo_beneficio_id_tipo_beneficio_seq OWNED BY arb.tipo_beneficio.id_tipo_beneficio;


--
-- TOC entry 476 (class 1259 OID 41816)
-- Name: tipo_registro_origen; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.tipo_registro_origen (
    id_tipo_registro_origen integer NOT NULL,
    denominacion character varying(100),
    abreviatura character varying(20),
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.tipo_registro_origen OWNER TO admin;

--
-- TOC entry 475 (class 1259 OID 41815)
-- Name: tipo_registro_origen_id_tipo_registro_origen_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.tipo_registro_origen_id_tipo_registro_origen_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.tipo_registro_origen_id_tipo_registro_origen_seq OWNER TO admin;

--
-- TOC entry 5644 (class 0 OID 0)
-- Dependencies: 475
-- Name: tipo_registro_origen_id_tipo_registro_origen_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.tipo_registro_origen_id_tipo_registro_origen_seq OWNED BY arb.tipo_registro_origen.id_tipo_registro_origen;


--
-- TOC entry 468 (class 1259 OID 41774)
-- Name: tributo; Type: TABLE; Schema: arb; Owner: admin
--

CREATE TABLE arb.tributo (
    id_tributo integer NOT NULL,
    codigo character varying(20) NOT NULL,
    denominacion character varying(150),
    abreviatura character varying(20),
    reajuste numeric(10,2),
    interes numeric(10,2),
    id_tipo_tributo integer,
    id_dependencia integer,
    usuario_actualizado character varying(100),
    fecha_actualizado timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    atributo_actualizado character varying(100)
);


ALTER TABLE arb.tributo OWNER TO admin;

--
-- TOC entry 467 (class 1259 OID 41773)
-- Name: tributo_id_tributo_seq; Type: SEQUENCE; Schema: arb; Owner: admin
--

CREATE SEQUENCE arb.tributo_id_tributo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE arb.tributo_id_tributo_seq OWNER TO admin;

--
-- TOC entry 5645 (class 0 OID 0)
-- Dependencies: 467
-- Name: tributo_id_tributo_seq; Type: SEQUENCE OWNED BY; Schema: arb; Owner: admin
--

ALTER SEQUENCE arb.tributo_id_tributo_seq OWNED BY arb.tributo.id_tributo;


--
-- TOC entry 501 (class 1259 OID 42093)
-- Name: vw_recaudacion_arbitrios; Type: VIEW; Schema: arb; Owner: admin
--

CREATE VIEW arb.vw_recaudacion_arbitrios AS
 SELECT a.anio,
    EXTRACT(month FROM ad.fecha_actualizado) AS mes,
    sum(ad.monto_final) AS total_recaudado
   FROM (arb.arbitrio_detalle ad
     JOIN arb.arbitrio a ON ((ad.id_arbitrio = a.id_arbitrio)))
  GROUP BY a.anio, (EXTRACT(month FROM ad.fecha_actualizado))
  ORDER BY a.anio, (EXTRACT(month FROM ad.fecha_actualizado));


ALTER VIEW arb.vw_recaudacion_arbitrios OWNER TO admin;

--
-- TOC entry 254 (class 1259 OID 36632)
-- Name: apertura_cobranza; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.apertura_cobranza (
    id integer NOT NULL,
    id_cajero integer,
    fecha_apertura date NOT NULL,
    hora_apertura time without time zone DEFAULT CURRENT_TIME,
    observaciones text,
    estado character varying(15) DEFAULT 'ABIERTO'::character varying
);


ALTER TABLE caj.apertura_cobranza OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 36639)
-- Name: apertura_cobranza_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.apertura_cobranza_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.apertura_cobranza_id_seq OWNER TO postgres;

--
-- TOC entry 5646 (class 0 OID 0)
-- Dependencies: 255
-- Name: apertura_cobranza_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.apertura_cobranza_id_seq OWNED BY caj.apertura_cobranza.id;


--
-- TOC entry 256 (class 1259 OID 36640)
-- Name: auditoria; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.auditoria (
    id integer NOT NULL,
    tabla character varying(50) NOT NULL,
    operacion character varying(10) NOT NULL,
    registro_id integer,
    usuario_bd text DEFAULT CURRENT_USER,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    descripcion text
);


ALTER TABLE caj.auditoria OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 36647)
-- Name: auditoria_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.auditoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.auditoria_id_seq OWNER TO postgres;

--
-- TOC entry 5647 (class 0 OID 0)
-- Dependencies: 257
-- Name: auditoria_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.auditoria_id_seq OWNED BY caj.auditoria.id;


--
-- TOC entry 258 (class 1259 OID 36648)
-- Name: cajero; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.cajero (
    id integer NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    dni character varying(15) NOT NULL,
    cod_acceso text NOT NULL,
    numeracion_inicial_recibo integer NOT NULL,
    numeracion_actual_recibo integer NOT NULL,
    estado character varying(15) DEFAULT 'ACTIVO'::character varying
);


ALTER TABLE caj.cajero OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 36654)
-- Name: cajero_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.cajero_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.cajero_id_seq OWNER TO postgres;

--
-- TOC entry 5648 (class 0 OID 0)
-- Dependencies: 259
-- Name: cajero_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.cajero_id_seq OWNED BY caj.cajero.id;


--
-- TOC entry 260 (class 1259 OID 36655)
-- Name: cierre_caja; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.cierre_caja (
    id integer NOT NULL,
    id_cajero integer,
    fecha_cierre date NOT NULL,
    hora_cierre time without time zone DEFAULT CURRENT_TIME,
    total_efectivo numeric(10,2) DEFAULT 0,
    total_comisiones numeric(10,2) DEFAULT 0,
    total_general numeric(10,2) DEFAULT 0,
    observaciones text
);


ALTER TABLE caj.cierre_caja OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 36664)
-- Name: cierre_caja_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.cierre_caja_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.cierre_caja_id_seq OWNER TO postgres;

--
-- TOC entry 5649 (class 0 OID 0)
-- Dependencies: 261
-- Name: cierre_caja_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.cierre_caja_id_seq OWNED BY caj.cierre_caja.id;


--
-- TOC entry 262 (class 1259 OID 36665)
-- Name: concepto_pago; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.concepto_pago (
    id integer NOT NULL,
    descripcion character varying(100) NOT NULL,
    monto numeric(10,2) NOT NULL
);


ALTER TABLE caj.concepto_pago OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 36668)
-- Name: concepto_pago_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.concepto_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.concepto_pago_id_seq OWNER TO postgres;

--
-- TOC entry 5650 (class 0 OID 0)
-- Dependencies: 263
-- Name: concepto_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.concepto_pago_id_seq OWNED BY caj.concepto_pago.id;


--
-- TOC entry 264 (class 1259 OID 36669)
-- Name: extorno; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.extorno (
    id integer NOT NULL,
    id_pago integer,
    id_recibo integer,
    id_cajero integer,
    motivo text NOT NULL,
    fecha_extorno date DEFAULT CURRENT_DATE,
    hora_extorno time without time zone DEFAULT CURRENT_TIME
);


ALTER TABLE caj.extorno OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 36676)
-- Name: extorno_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.extorno_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.extorno_id_seq OWNER TO postgres;

--
-- TOC entry 5651 (class 0 OID 0)
-- Dependencies: 265
-- Name: extorno_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.extorno_id_seq OWNED BY caj.extorno.id;


--
-- TOC entry 266 (class 1259 OID 36677)
-- Name: pago; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.pago (
    id integer NOT NULL,
    id_usuario integer,
    id_cajero integer,
    id_tipo_pago integer,
    fecha_pago date DEFAULT CURRENT_DATE,
    total numeric(10,2) NOT NULL,
    observaciones text
);


ALTER TABLE caj.pago OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 36683)
-- Name: pago_detalle; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.pago_detalle (
    id integer NOT NULL,
    id_pago integer,
    id_concepto_pago integer,
    cantidad integer DEFAULT 1,
    subtotal numeric(10,2) NOT NULL
);


ALTER TABLE caj.pago_detalle OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 36687)
-- Name: pago_detalle_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.pago_detalle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.pago_detalle_id_seq OWNER TO postgres;

--
-- TOC entry 5652 (class 0 OID 0)
-- Dependencies: 268
-- Name: pago_detalle_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.pago_detalle_id_seq OWNED BY caj.pago_detalle.id;


--
-- TOC entry 269 (class 1259 OID 36688)
-- Name: pago_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.pago_id_seq OWNER TO postgres;

--
-- TOC entry 5653 (class 0 OID 0)
-- Dependencies: 269
-- Name: pago_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.pago_id_seq OWNED BY caj.pago.id;


--
-- TOC entry 270 (class 1259 OID 36689)
-- Name: recibo; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.recibo (
    id integer NOT NULL,
    id_pago integer,
    id_cajero integer,
    numero_recibo integer NOT NULL,
    fecha_emision date DEFAULT CURRENT_DATE,
    total numeric(10,2) NOT NULL,
    estado character varying(15) DEFAULT 'EMITIDO'::character varying
);


ALTER TABLE caj.recibo OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 36694)
-- Name: recibo_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.recibo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.recibo_id_seq OWNER TO postgres;

--
-- TOC entry 5654 (class 0 OID 0)
-- Dependencies: 271
-- Name: recibo_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.recibo_id_seq OWNED BY caj.recibo.id;


--
-- TOC entry 272 (class 1259 OID 36695)
-- Name: tipo_pago; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.tipo_pago (
    id integer NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE caj.tipo_pago OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 36698)
-- Name: tipo_pago_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.tipo_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.tipo_pago_id_seq OWNER TO postgres;

--
-- TOC entry 5655 (class 0 OID 0)
-- Dependencies: 273
-- Name: tipo_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.tipo_pago_id_seq OWNED BY caj.tipo_pago.id;


--
-- TOC entry 274 (class 1259 OID 36699)
-- Name: usuario; Type: TABLE; Schema: caj; Owner: postgres
--

CREATE TABLE caj.usuario (
    id integer NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    dni character varying(15) NOT NULL,
    direccion character varying(150),
    telefono character varying(20),
    correo character varying(100)
);


ALTER TABLE caj.usuario OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 36702)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: caj; Owner: postgres
--

CREATE SEQUENCE caj.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE caj.usuario_id_seq OWNER TO postgres;

--
-- TOC entry 5656 (class 0 OID 0)
-- Dependencies: 275
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: caj; Owner: postgres
--

ALTER SEQUENCE caj.usuario_id_seq OWNED BY caj.usuario.id;


--
-- TOC entry 460 (class 1259 OID 41509)
-- Name: fis_acta_inspección; Type: TABLE; Schema: fis; Owner: admin
--

CREATE TABLE fis."fis_acta_inspección" (
    id_acta integer NOT NULL,
    id_fiscalizacion integer,
    numero_acta text,
    fecha_inspeccion date,
    hora_inicio time without time zone,
    hora_fin time without time zone,
    participantes text,
    observaciones text,
    evidencias_fotograficas text,
    estado fis.estado_generico
);


ALTER TABLE fis."fis_acta_inspección" OWNER TO admin;

--
-- TOC entry 459 (class 1259 OID 41508)
-- Name: fis_acta_inspección_id_acta_seq; Type: SEQUENCE; Schema: fis; Owner: admin
--

CREATE SEQUENCE fis."fis_acta_inspección_id_acta_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fis."fis_acta_inspección_id_acta_seq" OWNER TO admin;

--
-- TOC entry 5657 (class 0 OID 0)
-- Dependencies: 459
-- Name: fis_acta_inspección_id_acta_seq; Type: SEQUENCE OWNED BY; Schema: fis; Owner: admin
--

ALTER SEQUENCE fis."fis_acta_inspección_id_acta_seq" OWNED BY fis."fis_acta_inspección".id_acta;


--
-- TOC entry 456 (class 1259 OID 41406)
-- Name: fis_fiscalizacion; Type: TABLE; Schema: fis; Owner: admin
--

CREATE TABLE fis.fis_fiscalizacion (
    id_fiscalizacion integer NOT NULL,
    numero_expediente text,
    tipo_procedimiento fis.tipo_procedimiento_enum,
    fecha_inicio date,
    fecha_termino date,
    estado fis.estado_fiscalizacion,
    id_predio integer,
    id_contribuyente integer,
    id_funcionario integer
);


ALTER TABLE fis.fis_fiscalizacion OWNER TO admin;

--
-- TOC entry 455 (class 1259 OID 41405)
-- Name: fis_fiscalizacion_id_fiscalizacion_seq; Type: SEQUENCE; Schema: fis; Owner: admin
--

CREATE SEQUENCE fis.fis_fiscalizacion_id_fiscalizacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fis.fis_fiscalizacion_id_fiscalizacion_seq OWNER TO admin;

--
-- TOC entry 5658 (class 0 OID 0)
-- Dependencies: 455
-- Name: fis_fiscalizacion_id_fiscalizacion_seq; Type: SEQUENCE OWNED BY; Schema: fis; Owner: admin
--

ALTER SEQUENCE fis.fis_fiscalizacion_id_fiscalizacion_seq OWNED BY fis.fis_fiscalizacion.id_fiscalizacion;


--
-- TOC entry 462 (class 1259 OID 41523)
-- Name: fis_liquidacion; Type: TABLE; Schema: fis; Owner: admin
--

CREATE TABLE fis.fis_liquidacion (
    id_liquidacion integer NOT NULL,
    id_fiscalizacion integer,
    numero_liquidacion text,
    fecha_emision date,
    base_imponible numeric(10,2),
    impuesto_omiso numeric(10,2),
    multa numeric(10,2),
    intereses numeric(10,2),
    total_a_pagar numeric(10,2),
    estado fis.estado_liquidacion
);


ALTER TABLE fis.fis_liquidacion OWNER TO admin;

--
-- TOC entry 461 (class 1259 OID 41522)
-- Name: fis_liquidacion_id_liquidacion_seq; Type: SEQUENCE; Schema: fis; Owner: admin
--

CREATE SEQUENCE fis.fis_liquidacion_id_liquidacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fis.fis_liquidacion_id_liquidacion_seq OWNER TO admin;

--
-- TOC entry 5659 (class 0 OID 0)
-- Dependencies: 461
-- Name: fis_liquidacion_id_liquidacion_seq; Type: SEQUENCE OWNED BY; Schema: fis; Owner: admin
--

ALTER SEQUENCE fis.fis_liquidacion_id_liquidacion_seq OWNED BY fis.fis_liquidacion.id_liquidacion;


--
-- TOC entry 466 (class 1259 OID 41551)
-- Name: fis_multa; Type: TABLE; Schema: fis; Owner: admin
--

CREATE TABLE fis.fis_multa (
    id_multa integer NOT NULL,
    id_resolucion integer,
    codigo_multa text,
    descripcion text,
    porcentaje_aplicado numeric(10,2),
    monto numeric(10,2),
    tipo fis.tipo_multa_enum
);


ALTER TABLE fis.fis_multa OWNER TO admin;

--
-- TOC entry 465 (class 1259 OID 41550)
-- Name: fis_multa_id_multa_seq; Type: SEQUENCE; Schema: fis; Owner: admin
--

CREATE SEQUENCE fis.fis_multa_id_multa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fis.fis_multa_id_multa_seq OWNER TO admin;

--
-- TOC entry 5660 (class 0 OID 0)
-- Dependencies: 465
-- Name: fis_multa_id_multa_seq; Type: SEQUENCE OWNED BY; Schema: fis; Owner: admin
--

ALTER SEQUENCE fis.fis_multa_id_multa_seq OWNED BY fis.fis_multa.id_multa;


--
-- TOC entry 458 (class 1259 OID 41495)
-- Name: fis_requerimiento; Type: TABLE; Schema: fis; Owner: admin
--

CREATE TABLE fis.fis_requerimiento (
    id_requerimiento integer NOT NULL,
    id_fiscalizacion integer,
    numero_requerimiento text,
    fecha_emision date,
    fecha_vencimiento date,
    tipo_requerimiento text,
    descripcion text,
    estado fis.estado_requerimiento,
    evidencia_fotografica text
);


ALTER TABLE fis.fis_requerimiento OWNER TO admin;

--
-- TOC entry 457 (class 1259 OID 41494)
-- Name: fis_requerimiento_id_requerimiento_seq; Type: SEQUENCE; Schema: fis; Owner: admin
--

CREATE SEQUENCE fis.fis_requerimiento_id_requerimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fis.fis_requerimiento_id_requerimiento_seq OWNER TO admin;

--
-- TOC entry 5661 (class 0 OID 0)
-- Dependencies: 457
-- Name: fis_requerimiento_id_requerimiento_seq; Type: SEQUENCE OWNED BY; Schema: fis; Owner: admin
--

ALTER SEQUENCE fis.fis_requerimiento_id_requerimiento_seq OWNED BY fis.fis_requerimiento.id_requerimiento;


--
-- TOC entry 464 (class 1259 OID 41537)
-- Name: fis_resolucion; Type: TABLE; Schema: fis; Owner: admin
--

CREATE TABLE fis.fis_resolucion (
    id_resolucion integer NOT NULL,
    id_fiscalizacion integer,
    numero_resolucion text,
    tipo text,
    fecha_emision date,
    fundamento_legal text,
    disposiciones text,
    estado fis.estado_generico
);


ALTER TABLE fis.fis_resolucion OWNER TO admin;

--
-- TOC entry 463 (class 1259 OID 41536)
-- Name: fis_resolucion_id_resolucion_seq; Type: SEQUENCE; Schema: fis; Owner: admin
--

CREATE SEQUENCE fis.fis_resolucion_id_resolucion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fis.fis_resolucion_id_resolucion_seq OWNER TO admin;

--
-- TOC entry 5662 (class 0 OID 0)
-- Dependencies: 463
-- Name: fis_resolucion_id_resolucion_seq; Type: SEQUENCE OWNED BY; Schema: fis; Owner: admin
--

ALTER SEQUENCE fis.fis_resolucion_id_resolucion_seq OWNED BY fis.fis_resolucion.id_resolucion;


--
-- TOC entry 380 (class 1259 OID 40526)
-- Name: gen_contribuyente; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_contribuyente (
    id integer NOT NULL,
    estado character varying(8) NOT NULL,
    fecha_creacion date DEFAULT CURRENT_DATE,
    dni character varying(8),
    ruc character varying(11),
    otro_documento_identidad character varying(30),
    nro_documento_identidad character varying(20),
    nombre character varying(100) NOT NULL,
    tipo_persona character varying(10) NOT NULL,
    genero character varying(6),
    fecha_nacimiento date,
    domicilio_fiscal text,
    referencia_domicilio_fiscal text,
    telefono_fijo character varying(9),
    telefono_celular character varying(9),
    celular_whatsapp character varying(9),
    email character varying(100),
    observaciones text,
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_contribuyente_documento CHECK (((dni IS NOT NULL) OR (ruc IS NOT NULL) OR ((otro_documento_identidad IS NOT NULL) AND (nro_documento_identidad IS NOT NULL)))),
    CONSTRAINT gen_contribuyente_celular_whatsapp_check CHECK (((celular_whatsapp)::text ~ '^[0-9]{9}$'::text)),
    CONSTRAINT gen_contribuyente_dni_check CHECK (((dni)::text ~ '^[0-9]{8}$'::text)),
    CONSTRAINT gen_contribuyente_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activo'::character varying, 'Anulado'::character varying])::text[]))),
    CONSTRAINT gen_contribuyente_genero_check CHECK (((genero)::text = ANY ((ARRAY['Hombre'::character varying, 'Mujer'::character varying])::text[]))),
    CONSTRAINT gen_contribuyente_otro_documento_identidad_check CHECK (((otro_documento_identidad)::text = ANY ((ARRAY['Libreta Militar'::character varying, 'Pasaporte'::character varying, 'Carnet de Extranjeria'::character varying, 'Partida de Nacimiento'::character varying])::text[]))),
    CONSTRAINT gen_contribuyente_ruc_check CHECK (((ruc)::text ~ '^[0-9]{11}$'::text)),
    CONSTRAINT gen_contribuyente_telefono_celular_check CHECK (((telefono_celular)::text ~ '^[0-9]{9}$'::text)),
    CONSTRAINT gen_contribuyente_telefono_fijo_check CHECK (((telefono_fijo)::text ~ '^[0-9]{7,9}$'::text)),
    CONSTRAINT gen_contribuyente_tipo_persona_check CHECK (((tipo_persona)::text = ANY ((ARRAY['Natural'::character varying, 'Juridica'::character varying])::text[])))
);


ALTER TABLE gen.gen_contribuyente OWNER TO admin;

--
-- TOC entry 379 (class 1259 OID 40525)
-- Name: gen_contribuyente_id_seq; Type: SEQUENCE; Schema: gen; Owner: admin
--

CREATE SEQUENCE gen.gen_contribuyente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE gen.gen_contribuyente_id_seq OWNER TO admin;

--
-- TOC entry 5663 (class 0 OID 0)
-- Dependencies: 379
-- Name: gen_contribuyente_id_seq; Type: SEQUENCE OWNED BY; Schema: gen; Owner: admin
--

ALTER SEQUENCE gen.gen_contribuyente_id_seq OWNED BY gen.gen_contribuyente.id;


--
-- TOC entry 365 (class 1259 OID 40377)
-- Name: gen_departamento; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_departamento (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE gen.gen_departamento OWNER TO admin;

--
-- TOC entry 364 (class 1259 OID 40376)
-- Name: gen_departamento_id_seq; Type: SEQUENCE; Schema: gen; Owner: admin
--

CREATE SEQUENCE gen.gen_departamento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE gen.gen_departamento_id_seq OWNER TO admin;

--
-- TOC entry 5664 (class 0 OID 0)
-- Dependencies: 364
-- Name: gen_departamento_id_seq; Type: SEQUENCE OWNED BY; Schema: gen; Owner: admin
--

ALTER SEQUENCE gen.gen_departamento_id_seq OWNED BY gen.gen_departamento.id;


--
-- TOC entry 369 (class 1259 OID 40406)
-- Name: gen_distrito; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_distrito (
    id integer NOT NULL,
    id_departamento integer NOT NULL,
    id_provincia integer NOT NULL,
    nombre character varying(50) NOT NULL,
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE gen.gen_distrito OWNER TO admin;

--
-- TOC entry 368 (class 1259 OID 40405)
-- Name: gen_distrito_id_seq; Type: SEQUENCE; Schema: gen; Owner: admin
--

CREATE SEQUENCE gen.gen_distrito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE gen.gen_distrito_id_seq OWNER TO admin;

--
-- TOC entry 5665 (class 0 OID 0)
-- Dependencies: 368
-- Name: gen_distrito_id_seq; Type: SEQUENCE OWNED BY; Schema: gen; Owner: admin
--

ALTER SEQUENCE gen.gen_distrito_id_seq OWNED BY gen.gen_distrito.id;


--
-- TOC entry 454 (class 1259 OID 41321)
-- Name: gen_funcionario; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_funcionario (
    id integer NOT NULL,
    dni text,
    nombres text,
    apellidos text,
    cargo text,
    area text,
    credencial_fiscalizador text,
    estado fis.estado_generico
);


ALTER TABLE gen.gen_funcionario OWNER TO admin;

--
-- TOC entry 453 (class 1259 OID 41320)
-- Name: gen_funcionario_id_seq; Type: SEQUENCE; Schema: gen; Owner: admin
--

CREATE SEQUENCE gen.gen_funcionario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE gen.gen_funcionario_id_seq OWNER TO admin;

--
-- TOC entry 5666 (class 0 OID 0)
-- Dependencies: 453
-- Name: gen_funcionario_id_seq; Type: SEQUENCE OWNED BY; Schema: gen; Owner: admin
--

ALTER SEQUENCE gen.gen_funcionario_id_seq OWNED BY gen.gen_funcionario.id;


--
-- TOC entry 377 (class 1259 OID 40478)
-- Name: gen_habilitacion_urbana; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_habilitacion_urbana (
    id integer NOT NULL,
    estado character varying(8) NOT NULL,
    id_distrito integer NOT NULL,
    id_tipo_habilitacion_urbana integer,
    nombre character varying(100) NOT NULL,
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT gen_habilitacion_urbana_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activo'::character varying, 'Anulado'::character varying])::text[])))
);


ALTER TABLE gen.gen_habilitacion_urbana OWNER TO admin;

--
-- TOC entry 382 (class 1259 OID 40553)
-- Name: gen_predio; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_predio (
    id integer NOT NULL,
    estado character varying(11) NOT NULL,
    id_via integer,
    id_sector integer,
    id_habilitacion_urbana integer NOT NULL,
    ubigeo character varying(6) GENERATED ALWAYS AS (((lpad((id_departamento)::text, 2, '0'::text) || lpad((id_provincia)::text, 2, '0'::text)) || lpad((id_distrito)::text, 2, '0'::text))) STORED,
    numero character varying(10),
    letra character(1),
    nombre_predio character varying(100),
    id_tipo_interior integer,
    nro_interior character varying(10),
    manzana character varying(5),
    lote character varying(10),
    sublote character varying(10),
    bloque character varying(10),
    edificio character varying(5),
    piso character varying(5),
    otra_numeracion text,
    nro_partida character varying(20),
    codigo_catastral character varying(20) GENERATED ALWAYS AS (((((((lpad((id_departamento)::text, 2, '0'::text) || '-'::text) || lpad((id_provincia)::text, 2, '0'::text)) || '-'::text) || lpad((id_distrito)::text, 2, '0'::text)) || '-'::text) || lpad((id)::text, 6, '0'::text))) STORED,
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_departamento integer NOT NULL,
    id_provincia integer NOT NULL,
    id_distrito integer NOT NULL,
    CONSTRAINT gen_predio_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activo'::character varying, 'Anulado'::character varying, 'Subdividido'::character varying])::text[])))
);


ALTER TABLE gen.gen_predio OWNER TO admin;

--
-- TOC entry 381 (class 1259 OID 40552)
-- Name: gen_predio_id_seq; Type: SEQUENCE; Schema: gen; Owner: admin
--

CREATE SEQUENCE gen.gen_predio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE gen.gen_predio_id_seq OWNER TO admin;

--
-- TOC entry 5667 (class 0 OID 0)
-- Dependencies: 381
-- Name: gen_predio_id_seq; Type: SEQUENCE OWNED BY; Schema: gen; Owner: admin
--

ALTER SEQUENCE gen.gen_predio_id_seq OWNED BY gen.gen_predio.id;


--
-- TOC entry 367 (class 1259 OID 40389)
-- Name: gen_provincia; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_provincia (
    id integer NOT NULL,
    id_departamento integer NOT NULL,
    nombre character varying(50) NOT NULL,
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE gen.gen_provincia OWNER TO admin;

--
-- TOC entry 366 (class 1259 OID 40388)
-- Name: gen_provincia_id_seq; Type: SEQUENCE; Schema: gen; Owner: admin
--

CREATE SEQUENCE gen.gen_provincia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE gen.gen_provincia_id_seq OWNER TO admin;

--
-- TOC entry 5668 (class 0 OID 0)
-- Dependencies: 366
-- Name: gen_provincia_id_seq; Type: SEQUENCE OWNED BY; Schema: gen; Owner: admin
--

ALTER SEQUENCE gen.gen_provincia_id_seq OWNED BY gen.gen_provincia.id;


--
-- TOC entry 370 (class 1259 OID 40425)
-- Name: gen_sector; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_sector (
    id integer NOT NULL,
    estado character varying(8) NOT NULL,
    id_distrito integer NOT NULL,
    nombre character varying(50) NOT NULL,
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT gen_sector_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activo'::character varying, 'Anulado'::character varying])::text[])))
);


ALTER TABLE gen.gen_sector OWNER TO admin;

--
-- TOC entry 376 (class 1259 OID 40467)
-- Name: gen_tipo_habilitacion_urbana; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_tipo_habilitacion_urbana (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    abreviacion character varying(10),
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE gen.gen_tipo_habilitacion_urbana OWNER TO admin;

--
-- TOC entry 375 (class 1259 OID 40466)
-- Name: gen_tipo_habilitacion_urbana_id_seq; Type: SEQUENCE; Schema: gen; Owner: admin
--

CREATE SEQUENCE gen.gen_tipo_habilitacion_urbana_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE gen.gen_tipo_habilitacion_urbana_id_seq OWNER TO admin;

--
-- TOC entry 5669 (class 0 OID 0)
-- Dependencies: 375
-- Name: gen_tipo_habilitacion_urbana_id_seq; Type: SEQUENCE OWNED BY; Schema: gen; Owner: admin
--

ALTER SEQUENCE gen.gen_tipo_habilitacion_urbana_id_seq OWNED BY gen.gen_tipo_habilitacion_urbana.id;


--
-- TOC entry 374 (class 1259 OID 40454)
-- Name: gen_tipo_interior; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_tipo_interior (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    especificar_otros boolean DEFAULT false,
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE gen.gen_tipo_interior OWNER TO admin;

--
-- TOC entry 373 (class 1259 OID 40453)
-- Name: gen_tipo_interior_id_seq; Type: SEQUENCE; Schema: gen; Owner: admin
--

CREATE SEQUENCE gen.gen_tipo_interior_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE gen.gen_tipo_interior_id_seq OWNER TO admin;

--
-- TOC entry 5670 (class 0 OID 0)
-- Dependencies: 373
-- Name: gen_tipo_interior_id_seq; Type: SEQUENCE OWNED BY; Schema: gen; Owner: admin
--

ALTER SEQUENCE gen.gen_tipo_interior_id_seq OWNED BY gen.gen_tipo_interior.id;


--
-- TOC entry 372 (class 1259 OID 40442)
-- Name: gen_tipo_via; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_tipo_via (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    abreviacion character varying(10),
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE gen.gen_tipo_via OWNER TO admin;

--
-- TOC entry 371 (class 1259 OID 40441)
-- Name: gen_tipo_via_id_seq; Type: SEQUENCE; Schema: gen; Owner: admin
--

CREATE SEQUENCE gen.gen_tipo_via_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE gen.gen_tipo_via_id_seq OWNER TO admin;

--
-- TOC entry 5671 (class 0 OID 0)
-- Dependencies: 371
-- Name: gen_tipo_via_id_seq; Type: SEQUENCE OWNED BY; Schema: gen; Owner: admin
--

ALTER SEQUENCE gen.gen_tipo_via_id_seq OWNED BY gen.gen_tipo_via.id;


--
-- TOC entry 378 (class 1259 OID 40499)
-- Name: gen_via; Type: TABLE; Schema: gen; Owner: admin
--

CREATE TABLE gen.gen_via (
    id integer NOT NULL,
    estado character varying(8) NOT NULL,
    id_habilitacion_urbana integer NOT NULL,
    id_sector integer,
    id_tipo_via integer,
    nombre character varying(100) NOT NULL,
    f_control date DEFAULT CURRENT_DATE,
    h_control time without time zone DEFAULT CURRENT_TIME,
    fecha_servidor timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT gen_via_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activo'::character varying, 'Anulado'::character varying])::text[])))
);


ALTER TABLE gen.gen_via OWNER TO admin;

--
-- TOC entry 392 (class 1259 OID 40658)
-- Name: vw_gen_contribuyente; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_contribuyente AS
 SELECT id,
    estado,
    fecha_creacion,
    dni,
    ruc,
    otro_documento_identidad,
    nro_documento_identidad,
    nombre,
    tipo_persona,
    genero,
    fecha_nacimiento,
    domicilio_fiscal,
    referencia_domicilio_fiscal,
    telefono_fijo,
    telefono_celular,
    celular_whatsapp,
    email,
    observaciones,
    f_control,
    h_control,
    fecha_servidor
   FROM gen.gen_contribuyente
  WHERE ((estado)::text = 'Activo'::text)
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_contribuyente OWNER TO admin;

--
-- TOC entry 383 (class 1259 OID 40618)
-- Name: vw_gen_departamento; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_departamento AS
 SELECT id,
    nombre,
    f_control,
    h_control,
    fecha_servidor
   FROM gen.gen_departamento
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_departamento OWNER TO admin;

--
-- TOC entry 385 (class 1259 OID 40626)
-- Name: vw_gen_distrito; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_distrito AS
 SELECT dt.id,
    dt.id_provincia,
    p.id_departamento,
    dep.nombre AS departamento,
    p.nombre AS provincia,
    dt.nombre,
    dt.f_control,
    dt.h_control,
    dt.fecha_servidor
   FROM ((gen.gen_distrito dt
     JOIN gen.gen_provincia p ON ((dt.id_provincia = p.id)))
     JOIN gen.gen_departamento dep ON ((p.id_departamento = dep.id)))
  ORDER BY dt.id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_distrito OWNER TO admin;

--
-- TOC entry 390 (class 1259 OID 40648)
-- Name: vw_gen_habilitacion_urbana; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_habilitacion_urbana AS
 SELECT hu.id,
    hu.estado,
    hu.id_distrito,
    dt.nombre AS distrito,
    p.nombre AS provincia,
    dep.nombre AS departamento,
    hu.id_tipo_habilitacion_urbana,
    thu.nombre AS tipo_habilitacion,
    thu.abreviacion AS tipo_abreviacion,
    hu.nombre,
    hu.f_control,
    hu.h_control,
    hu.fecha_servidor
   FROM ((((gen.gen_habilitacion_urbana hu
     JOIN gen.gen_distrito dt ON ((hu.id_distrito = dt.id)))
     JOIN gen.gen_provincia p ON ((dt.id_provincia = p.id)))
     JOIN gen.gen_departamento dep ON ((p.id_departamento = dep.id)))
     LEFT JOIN gen.gen_tipo_habilitacion_urbana thu ON ((hu.id_tipo_habilitacion_urbana = thu.id)))
  WHERE ((hu.estado)::text = 'Activo'::text)
  ORDER BY hu.id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_habilitacion_urbana OWNER TO admin;

--
-- TOC entry 393 (class 1259 OID 40665)
-- Name: vw_gen_predio; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_predio AS
 SELECT pr.id,
    pr.estado,
    pr.id_departamento,
    dep.nombre AS departamento,
    pr.id_provincia,
    prov.nombre AS provincia,
    pr.id_distrito,
    dist.nombre AS distrito,
    pr.ubigeo,
    pr.id_sector,
    s.nombre AS sector,
    pr.id_habilitacion_urbana,
    hu.nombre AS habilitacion_urbana,
    pr.id_via,
    v.nombre AS via,
        CASE
            WHEN ((v.nombre IS NOT NULL) AND (tv.abreviacion IS NOT NULL)) THEN (((tv.abreviacion)::text || ' '::text) || (v.nombre)::text)
            WHEN (v.nombre IS NOT NULL) THEN (v.nombre)::text
            ELSE NULL::text
        END AS via_completa,
    pr.numero,
    pr.letra,
    pr.nombre_predio,
    pr.id_tipo_interior,
    ti.nombre AS tipo_interior,
    pr.nro_interior,
    pr.manzana,
    pr.lote,
    pr.sublote,
    pr.bloque,
    pr.edificio,
    pr.piso,
    pr.otra_numeracion,
    pr.nro_partida,
    pr.codigo_catastral,
    NULLIF(TRIM(BOTH FROM concat_ws(' '::text,
        CASE
            WHEN ((tv.abreviacion IS NOT NULL) AND (v.nombre IS NOT NULL)) THEN (((tv.abreviacion)::text || ' '::text) || (v.nombre)::text)
            WHEN (v.nombre IS NOT NULL) THEN (v.nombre)::text
            ELSE NULL::text
        END,
        CASE
            WHEN (pr.numero IS NOT NULL) THEN ('N° '::text || (pr.numero)::text)
            ELSE NULL::text
        END,
        CASE
            WHEN (pr.manzana IS NOT NULL) THEN ('MZ '::text || (pr.manzana)::text)
            ELSE NULL::text
        END,
        CASE
            WHEN (pr.lote IS NOT NULL) THEN ('LT '::text || (pr.lote)::text)
            ELSE NULL::text
        END,
        CASE
            WHEN ((ti.nombre IS NOT NULL) AND (pr.nro_interior IS NOT NULL)) THEN (((ti.nombre)::text || ' '::text) || (pr.nro_interior)::text)
            ELSE NULL::text
        END, hu.nombre)), ''::text) AS direccion_completa,
    pr.f_control,
    pr.h_control,
    pr.fecha_servidor
   FROM ((((((((gen.gen_predio pr
     JOIN gen.gen_departamento dep ON ((pr.id_departamento = dep.id)))
     JOIN gen.gen_provincia prov ON ((pr.id_provincia = prov.id)))
     JOIN gen.gen_distrito dist ON ((pr.id_distrito = dist.id)))
     LEFT JOIN gen.gen_sector s ON ((pr.id_sector = s.id)))
     JOIN gen.gen_habilitacion_urbana hu ON ((pr.id_habilitacion_urbana = hu.id)))
     LEFT JOIN gen.gen_via v ON ((pr.id_via = v.id)))
     LEFT JOIN gen.gen_tipo_via tv ON ((v.id_tipo_via = tv.id)))
     LEFT JOIN gen.gen_tipo_interior ti ON ((pr.id_tipo_interior = ti.id)))
  WHERE ((pr.estado)::text = 'Activo'::text)
  ORDER BY pr.id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_predio OWNER TO admin;

--
-- TOC entry 384 (class 1259 OID 40622)
-- Name: vw_gen_provincia; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_provincia AS
 SELECT p.id,
    p.id_departamento,
    d.nombre AS departamento,
    p.nombre,
    p.f_control,
    p.h_control,
    p.fecha_servidor
   FROM (gen.gen_provincia p
     JOIN gen.gen_departamento d ON ((p.id_departamento = d.id)))
  ORDER BY p.id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_provincia OWNER TO admin;

--
-- TOC entry 386 (class 1259 OID 40631)
-- Name: vw_gen_sector; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_sector AS
 SELECT s.id,
    s.estado,
    s.id_distrito,
    dt.nombre AS distrito,
    p.nombre AS provincia,
    dep.nombre AS departamento,
    s.nombre,
    s.f_control,
    s.h_control,
    s.fecha_servidor
   FROM (((gen.gen_sector s
     JOIN gen.gen_distrito dt ON ((s.id_distrito = dt.id)))
     JOIN gen.gen_provincia p ON ((dt.id_provincia = p.id)))
     JOIN gen.gen_departamento dep ON ((p.id_departamento = dep.id)))
  WHERE ((s.estado)::text = 'Activo'::text)
  ORDER BY s.id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_sector OWNER TO admin;

--
-- TOC entry 389 (class 1259 OID 40644)
-- Name: vw_gen_tipo_habilitacion_urbana; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_tipo_habilitacion_urbana AS
 SELECT id,
    nombre,
    abreviacion,
    f_control,
    h_control,
    fecha_servidor
   FROM gen.gen_tipo_habilitacion_urbana
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_tipo_habilitacion_urbana OWNER TO admin;

--
-- TOC entry 388 (class 1259 OID 40640)
-- Name: vw_gen_tipo_interior; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_tipo_interior AS
 SELECT id,
    nombre,
    especificar_otros,
    f_control,
    h_control,
    fecha_servidor
   FROM gen.gen_tipo_interior
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_tipo_interior OWNER TO admin;

--
-- TOC entry 387 (class 1259 OID 40636)
-- Name: vw_gen_tipo_via; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_tipo_via AS
 SELECT id,
    nombre,
    abreviacion,
    f_control,
    h_control,
    fecha_servidor
   FROM gen.gen_tipo_via
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_tipo_via OWNER TO admin;

--
-- TOC entry 391 (class 1259 OID 40653)
-- Name: vw_gen_via; Type: MATERIALIZED VIEW; Schema: gen; Owner: admin
--

CREATE MATERIALIZED VIEW gen.vw_gen_via AS
 SELECT v.id,
    v.estado,
    v.id_habilitacion_urbana,
    hu.nombre AS habilitacion_urbana,
    v.id_sector,
    s.nombre AS sector,
    v.id_tipo_via,
    tv.nombre AS tipo_via,
    tv.abreviacion AS tipo_via_abrev,
    v.nombre,
    v.f_control,
    v.h_control,
    v.fecha_servidor
   FROM (((gen.gen_via v
     JOIN gen.gen_habilitacion_urbana hu ON ((v.id_habilitacion_urbana = hu.id)))
     LEFT JOIN gen.gen_sector s ON ((v.id_sector = s.id)))
     LEFT JOIN gen.gen_tipo_via tv ON ((v.id_tipo_via = tv.id)))
  WHERE ((v.estado)::text = 'Activo'::text)
  ORDER BY v.id
  WITH NO DATA;


ALTER MATERIALIZED VIEW gen.vw_gen_via OWNER TO admin;

--
-- TOC entry 245 (class 1259 OID 36432)
-- Name: antecedente_cumplimiento; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.antecedente_cumplimiento (
    id_ant_cumplimiento uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    dentista_dolor boolean,
    frecuenca_dentista character varying(100),
    higiene_oral character varying(100),
    tranquilo boolean,
    nervioso boolean,
    panico boolean,
    desagrado_atencion text
);


ALTER TABLE hcl.antecedente_cumplimiento OWNER TO admin;

--
-- TOC entry 244 (class 1259 OID 36422)
-- Name: antecedente_familiar; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.antecedente_familiar (
    id_ant_fam uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    descripcion text
);


ALTER TABLE hcl.antecedente_familiar OWNER TO admin;

--
-- TOC entry 243 (class 1259 OID 36412)
-- Name: antecedente_medico; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.antecedente_medico (
    id_ant_patologico uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    salud_general character varying(50),
    bajo_tratamiento boolean,
    tipo_tratamiento character varying(200),
    hospitalizaciones text,
    traumatismos text,
    alergias text,
    medicamentos_contraindicados text,
    odontologicos text
);


ALTER TABLE hcl.antecedente_medico OWNER TO admin;

--
-- TOC entry 242 (class 1259 OID 36402)
-- Name: antecedente_personal; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.antecedente_personal (
    id_antecedente uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    esta_embarazada boolean,
    mac character varying(200),
    otros text,
    psicosocial text,
    vacunas text,
    hepatitis_b boolean,
    id_grupo_sanguineo uuid,
    fuma boolean,
    cigarrillos_dia integer,
    toma_te boolean,
    tazas_te_dia integer,
    toma_alcohol boolean,
    frecuencia_alcohol character varying(100),
    aprieta_dientes boolean,
    momento_aprieta character varying(100),
    rechina boolean,
    dolor_muscular boolean,
    chupa_dedo boolean,
    muerde_objetos boolean,
    muerde_labios boolean,
    otros_habitos text,
    frecuencia_cepillado integer
);


ALTER TABLE hcl.antecedente_personal OWNER TO admin;

--
-- TOC entry 253 (class 1259 OID 36524)
-- Name: auditoria; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.auditoria (
    id_auditoria uuid DEFAULT gen_random_uuid() NOT NULL,
    id_usuario uuid NOT NULL,
    fecha_cambio timestamp without time zone DEFAULT now() NOT NULL,
    nombre_tabla character varying(50) NOT NULL,
    id_registro_afectado uuid NOT NULL,
    accion character varying(10) NOT NULL,
    datos_anteriores jsonb,
    datos_nuevos jsonb,
    ip_address character varying(45),
    user_agent text
);


ALTER TABLE hcl.auditoria OWNER TO admin;

--
-- TOC entry 232 (class 1259 OID 36308)
-- Name: catalogo_clinica; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_clinica (
    id_clinica uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE hcl.catalogo_clinica OWNER TO admin;

--
-- TOC entry 229 (class 1259 OID 36290)
-- Name: catalogo_enfermedad; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_enfermedad (
    id_enfermedad uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE hcl.catalogo_enfermedad OWNER TO admin;

--
-- TOC entry 226 (class 1259 OID 36266)
-- Name: catalogo_estado_civil; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_estado_civil (
    id_estado_civil uuid DEFAULT gen_random_uuid() NOT NULL,
    descripcion character varying(50) NOT NULL
);


ALTER TABLE hcl.catalogo_estado_civil OWNER TO admin;

--
-- TOC entry 234 (class 1259 OID 36320)
-- Name: catalogo_estado_revision; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_estado_revision (
    id_estado_revision uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE hcl.catalogo_estado_revision OWNER TO admin;

--
-- TOC entry 231 (class 1259 OID 36302)
-- Name: catalogo_examen_auxiliar; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_examen_auxiliar (
    id_examen uuid DEFAULT gen_random_uuid() NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE hcl.catalogo_examen_auxiliar OWNER TO admin;

--
-- TOC entry 227 (class 1259 OID 36274)
-- Name: catalogo_grado_instruccion; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_grado_instruccion (
    id_grado_instruccion uuid DEFAULT gen_random_uuid() NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE hcl.catalogo_grado_instruccion OWNER TO admin;

--
-- TOC entry 233 (class 1259 OID 36314)
-- Name: catalogo_grupo_sanguineo; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_grupo_sanguineo (
    id_grupo_sanguineo uuid DEFAULT gen_random_uuid() NOT NULL,
    descripcion character varying(10) NOT NULL
);


ALTER TABLE hcl.catalogo_grupo_sanguineo OWNER TO admin;

--
-- TOC entry 230 (class 1259 OID 36296)
-- Name: catalogo_habito; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_habito (
    id_habito uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE hcl.catalogo_habito OWNER TO admin;

--
-- TOC entry 228 (class 1259 OID 36282)
-- Name: catalogo_ocupacion; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_ocupacion (
    id_ocupacion uuid DEFAULT gen_random_uuid() NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE hcl.catalogo_ocupacion OWNER TO admin;

--
-- TOC entry 225 (class 1259 OID 36258)
-- Name: catalogo_sexo; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.catalogo_sexo (
    id_sexo uuid DEFAULT gen_random_uuid() NOT NULL,
    descripcion character varying(20) NOT NULL
);


ALTER TABLE hcl.catalogo_sexo OWNER TO admin;

--
-- TOC entry 250 (class 1259 OID 36495)
-- Name: diagnostico; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.diagnostico (
    id_diagnostico uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid NOT NULL,
    descripcion text NOT NULL,
    definitivo boolean DEFAULT false,
    fecha date DEFAULT CURRENT_DATE
);


ALTER TABLE hcl.diagnostico OWNER TO admin;

--
-- TOC entry 241 (class 1259 OID 36392)
-- Name: enfermedad_actual; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.enfermedad_actual (
    id_enfermedad_actual uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    sintoma_principal character varying(300),
    tiempo_enfermedad character varying(100),
    forma_inicio character varying(200),
    curso character varying(200),
    relato text,
    tratamiento_prev text
);


ALTER TABLE hcl.enfermedad_actual OWNER TO admin;

--
-- TOC entry 252 (class 1259 OID 36515)
-- Name: evolucion; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.evolucion (
    id_evolucion uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid NOT NULL,
    fecha date DEFAULT CURRENT_DATE,
    actividad text NOT NULL,
    alumno character varying(200),
    observaciones text
);


ALTER TABLE hcl.evolucion OWNER TO admin;

--
-- TOC entry 249 (class 1259 OID 36487)
-- Name: examen_auxiliar; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.examen_auxiliar (
    id_examen_auxiliar uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid NOT NULL,
    id_examen uuid NOT NULL,
    detalle character varying(200),
    fecha_solicitud timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE hcl.examen_auxiliar OWNER TO admin;

--
-- TOC entry 248 (class 1259 OID 36472)
-- Name: examen_clinico_boca; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.examen_clinico_boca (
    id_boca uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    labios_sin_lesiones text,
    labios_con_lesiones text,
    vestibulo_sin_lesiones text,
    vestibulo_con_lesiones text,
    carrillos_retromolar_sin_lesiones text,
    carrillos_retromolar_con_lesiones text,
    paladar_sin_lesiones text,
    paladar_con_lesiones text,
    orofaringe_sin_lesiones text,
    orofaringe_con_lesiones text,
    piso_boca_sin_lesiones text,
    piso_boca_con_lesiones text,
    lengua_sin_lesiones text,
    lengua_con_lesiones text,
    encia_sin_lesiones text,
    encia_con_lesiones text,
    oclusion_molar_der character varying(50),
    oclusion_molar_izq character varying(50),
    oclusion_canina_der character varying(50),
    oclusion_canina_izq character varying(50),
    oclusion_mordida_cruzada character varying(50),
    oclusion_vestibuloclusion boolean,
    oclusion_overbite numeric(4,1),
    oclusion_mordida_abierta character varying(50),
    oclusion_sobremordida boolean,
    oclusion_relacion_vertical_otros text,
    oclusion_overjet numeric(4,1),
    oclusion_protrusion boolean,
    oclusion_guia_incisiva text,
    oclusion_contacto_posterior text,
    lat_der_guia_canina boolean,
    lat_der_funcion_grupo boolean,
    lat_der_contacto_balance boolean,
    lat_der_describa text,
    lat_izq_guia_canina boolean,
    lat_izq_funcion_grupo boolean,
    lat_izq_contacto_balance boolean,
    lat_izq_describa text
);


ALTER TABLE hcl.examen_clinico_boca OWNER TO admin;

--
-- TOC entry 246 (class 1259 OID 36442)
-- Name: examen_general; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.examen_general (
    id_examen uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    posicion character varying(50),
    actitud character varying(50),
    deambulacion character varying(50),
    facies character varying(50),
    facies_obs text,
    conciencia text,
    constitucion character varying(50),
    estado_nutritivo character varying(50),
    temperatura character varying(50),
    presion_arterial character varying(50),
    frecuencia_respiratoria character varying(50),
    pulso character varying(50),
    peso numeric(5,2),
    talla numeric(5,2),
    piel_color character varying(100),
    piel_humedad character varying(50),
    piel_lesiones character varying(50),
    piel_lesiones_obs text,
    piel_anexos character varying(50),
    piel_anexos_obs text,
    tcs_distribucion character varying(50),
    tcs_distribucion_obs text,
    tcs_cantidad character varying(50),
    ganglios character varying(50),
    ganglios_obs text
);


ALTER TABLE hcl.examen_general OWNER TO admin;

--
-- TOC entry 247 (class 1259 OID 36457)
-- Name: examen_regional; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.examen_regional (
    id_regional uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    cabeza_posicion character varying(50),
    cabeza_movimientos character varying(50),
    cabeza_movimientos_obs text,
    craneo_tamano character varying(50),
    craneo_forma character varying(50),
    cara_forma_frente character varying(50),
    cara_forma_perfil character varying(50),
    ojos_cejas_adecuada boolean,
    ojos_implantacion_obs text,
    ojos_escleroticas character varying(50),
    ojos_agudeza_visual boolean,
    ojos_iris_color character varying(50),
    ojos_arco_senil boolean,
    nariz_forma character varying(100),
    nariz_permeables boolean,
    nariz_secreciones boolean,
    nariz_senos_dolorosos boolean,
    oidos_anomalias_morfologicas boolean,
    oidos_anomalias_obs text,
    oidos_secreciones boolean,
    oidos_audicion_conservada boolean,
    atm_trayectoria character varying(50),
    atm_lat_izq_dolor boolean,
    atm_lat_izq_ruido boolean,
    atm_lat_izq_salto boolean,
    atm_lat_der_dolor boolean,
    atm_lat_der_ruido boolean,
    atm_lat_der_salto boolean,
    atm_prot_dolor boolean,
    atm_prot_ruido boolean,
    atm_prot_salto boolean,
    atm_aper_dolor boolean,
    atm_aper_ruido boolean,
    atm_aper_salto boolean,
    atm_cierre_dolor boolean,
    atm_cierre_ruido boolean,
    atm_cierre_salto boolean,
    atm_coordinacion_condilar boolean,
    atm_apertura_maxima_mm numeric(5,2),
    atm_observaciones text,
    atm_musculos_dolor boolean,
    atm_musculos_dolor_grado character varying(50),
    atm_musculos_dolor_zona text,
    cuello_simetrico boolean,
    cuello_simetrico_obs text,
    cuello_movilidad_conservada boolean,
    cuello_movilidad_obs text,
    laringe_alineada boolean,
    laringe_alineada_obs text,
    cuello_otros text
);


ALTER TABLE hcl.examen_regional OWNER TO admin;

--
-- TOC entry 239 (class 1259 OID 36373)
-- Name: filiacion; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.filiacion (
    id_filiacion uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    raza character varying(100),
    fecha_nacimiento date,
    lugar character varying(150),
    id_estado_civil uuid,
    nombre_conyuge character varying(200),
    id_ocupacion uuid,
    lugar_procedencia character varying(150),
    tiempo_residencia_tacna character varying(50),
    direccion character varying(200),
    id_grado_instruccion uuid,
    ultima_visita_dentista date,
    motivo_visita_dentista character varying(300),
    ultima_visita_medico date,
    motivo_visita_medico character varying(300),
    contacto_emergencia character varying(200),
    telefono_emergencia character varying(20),
    acompaniante character varying(200)
);


ALTER TABLE hcl.filiacion OWNER TO admin;

--
-- TOC entry 237 (class 1259 OID 36353)
-- Name: historia_clinica; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.historia_clinica (
    id_historia uuid DEFAULT gen_random_uuid() NOT NULL,
    id_paciente uuid,
    id_estudiante uuid NOT NULL,
    fecha_elaboracion date DEFAULT CURRENT_DATE NOT NULL,
    ultima_modificacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) DEFAULT 'en_proceso'::character varying
);


ALTER TABLE hcl.historia_clinica OWNER TO admin;

--
-- TOC entry 240 (class 1259 OID 36383)
-- Name: motivo_consulta; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.motivo_consulta (
    id_motivo uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid,
    motivo text NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE hcl.motivo_consulta OWNER TO admin;

--
-- TOC entry 236 (class 1259 OID 36341)
-- Name: paciente; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.paciente (
    id_paciente uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre character varying(200) NOT NULL,
    apellido character varying(200) NOT NULL,
    dni character(8) NOT NULL,
    fecha_nacimiento date NOT NULL,
    id_sexo uuid NOT NULL,
    telefono character varying(20),
    email character varying(200),
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    activo boolean DEFAULT true
);


ALTER TABLE hcl.paciente OWNER TO admin;

--
-- TOC entry 251 (class 1259 OID 36505)
-- Name: referencia_clinica; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.referencia_clinica (
    id_ref uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid NOT NULL,
    id_clinica uuid NOT NULL,
    observaciones text,
    fecha date DEFAULT CURRENT_DATE,
    estado character varying(20) DEFAULT 'pendiente'::character varying
);


ALTER TABLE hcl.referencia_clinica OWNER TO admin;

--
-- TOC entry 238 (class 1259 OID 36364)
-- Name: revision_historia; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.revision_historia (
    id_revision uuid DEFAULT gen_random_uuid() NOT NULL,
    id_historia uuid NOT NULL,
    id_docente uuid NOT NULL,
    fecha date DEFAULT CURRENT_DATE,
    id_estado_revision uuid NOT NULL,
    observaciones text
);


ALTER TABLE hcl.revision_historia OWNER TO admin;

--
-- TOC entry 235 (class 1259 OID 36326)
-- Name: usuario; Type: TABLE; Schema: hcl; Owner: admin
--

CREATE TABLE hcl.usuario (
    id_usuario uuid DEFAULT gen_random_uuid() NOT NULL,
    codigo_usuario character varying(100) NOT NULL,
    nombre character varying(200) NOT NULL,
    apellido character varying(200) NOT NULL,
    dni character(8) NOT NULL,
    email character varying(200) NOT NULL,
    rol character varying(50) NOT NULL,
    contrasena_hash character varying(255) NOT NULL,
    activo boolean DEFAULT true
);


ALTER TABLE hcl.usuario OWNER TO admin;

--
-- TOC entry 317 (class 1259 OID 38971)
-- Name: imp_arancel_urbano; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_arancel_urbano (
    id_arancel_urbano integer NOT NULL,
    anio smallint NOT NULL,
    valor_arancel_m2 numeric(14,2) NOT NULL,
    direccion_predio character varying(255)
);


ALTER TABLE imp.imp_arancel_urbano OWNER TO admin;

--
-- TOC entry 316 (class 1259 OID 38970)
-- Name: imp_arancel_urbano_id_arancel_urbano_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_arancel_urbano_id_arancel_urbano_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_arancel_urbano_id_arancel_urbano_seq OWNER TO admin;

--
-- TOC entry 5672 (class 0 OID 0)
-- Dependencies: 316
-- Name: imp_arancel_urbano_id_arancel_urbano_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_arancel_urbano_id_arancel_urbano_seq OWNED BY imp.imp_arancel_urbano.id_arancel_urbano;


--
-- TOC entry 357 (class 1259 OID 39317)
-- Name: imp_area_rustica; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_area_rustica (
    id_area_rustica integer NOT NULL,
    id_grupo_tierra_detalle integer NOT NULL,
    id_categoria_terreno integer NOT NULL,
    valor numeric(18,2)
);


ALTER TABLE imp.imp_area_rustica OWNER TO admin;

--
-- TOC entry 356 (class 1259 OID 39316)
-- Name: imp_area_rustica_id_area_rustica_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_area_rustica_id_area_rustica_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_area_rustica_id_area_rustica_seq OWNER TO admin;

--
-- TOC entry 5673 (class 0 OID 0)
-- Dependencies: 356
-- Name: imp_area_rustica_id_area_rustica_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_area_rustica_id_area_rustica_seq OWNED BY imp.imp_area_rustica.id_area_rustica;


--
-- TOC entry 289 (class 1259 OID 38797)
-- Name: imp_asociacion; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_asociacion (
    id_asociacion integer NOT NULL,
    estado character varying(20),
    nombre_asociacion character varying(150) NOT NULL,
    id_distrito integer NOT NULL
);


ALTER TABLE imp.imp_asociacion OWNER TO admin;

--
-- TOC entry 288 (class 1259 OID 38796)
-- Name: imp_asociacion_id_asociacion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_asociacion_id_asociacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_asociacion_id_asociacion_seq OWNER TO admin;

--
-- TOC entry 5674 (class 0 OID 0)
-- Dependencies: 288
-- Name: imp_asociacion_id_asociacion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_asociacion_id_asociacion_seq OWNED BY imp.imp_asociacion.id_asociacion;


--
-- TOC entry 324 (class 1259 OID 39006)
-- Name: imp_categoria_edificacion; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_categoria_edificacion (
    id_categoria character(1) NOT NULL,
    descripcion character varying(200),
    muros_y_columnas character varying(200),
    techos character varying(200),
    pisos character varying(200),
    puertas_ventanas character varying(200),
    revestimiento character varying(200),
    banos character varying(200),
    instalaciones_electricas_sanitarias character varying(200)
);


ALTER TABLE imp.imp_categoria_edificacion OWNER TO admin;

--
-- TOC entry 313 (class 1259 OID 38955)
-- Name: imp_categoria_terreno; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_categoria_terreno (
    id_categoria_terreno integer NOT NULL,
    denominacion character varying(100) NOT NULL
);


ALTER TABLE imp.imp_categoria_terreno OWNER TO admin;

--
-- TOC entry 309 (class 1259 OID 38941)
-- Name: imp_categoria_terreno_ext; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_categoria_terreno_ext (
    id_categoria_terreno_ext integer NOT NULL,
    categoria character varying(50) NOT NULL,
    abreviacion character varying(10)
);


ALTER TABLE imp.imp_categoria_terreno_ext OWNER TO admin;

--
-- TOC entry 308 (class 1259 OID 38940)
-- Name: imp_categoria_terreno_ext_id_categoria_terreno_ext_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_categoria_terreno_ext_id_categoria_terreno_ext_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_categoria_terreno_ext_id_categoria_terreno_ext_seq OWNER TO admin;

--
-- TOC entry 5675 (class 0 OID 0)
-- Dependencies: 308
-- Name: imp_categoria_terreno_ext_id_categoria_terreno_ext_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_categoria_terreno_ext_id_categoria_terreno_ext_seq OWNED BY imp.imp_categoria_terreno_ext.id_categoria_terreno_ext;


--
-- TOC entry 312 (class 1259 OID 38954)
-- Name: imp_categoria_terreno_id_categoria_terreno_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_categoria_terreno_id_categoria_terreno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_categoria_terreno_id_categoria_terreno_seq OWNER TO admin;

--
-- TOC entry 5676 (class 0 OID 0)
-- Dependencies: 312
-- Name: imp_categoria_terreno_id_categoria_terreno_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_categoria_terreno_id_categoria_terreno_seq OWNED BY imp.imp_categoria_terreno.id_categoria_terreno;


--
-- TOC entry 307 (class 1259 OID 38934)
-- Name: imp_clasificacion_terreno; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_clasificacion_terreno (
    id_clasificacion_terreno integer NOT NULL,
    denominacion character varying(150) NOT NULL
);


ALTER TABLE imp.imp_clasificacion_terreno OWNER TO admin;

--
-- TOC entry 306 (class 1259 OID 38933)
-- Name: imp_clasificacion_terreno_id_clasificacion_terreno_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_clasificacion_terreno_id_clasificacion_terreno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_clasificacion_terreno_id_clasificacion_terreno_seq OWNER TO admin;

--
-- TOC entry 5677 (class 0 OID 0)
-- Dependencies: 306
-- Name: imp_clasificacion_terreno_id_clasificacion_terreno_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_clasificacion_terreno_id_clasificacion_terreno_seq OWNED BY imp.imp_clasificacion_terreno.id_clasificacion_terreno;


--
-- TOC entry 294 (class 1259 OID 38836)
-- Name: imp_contribuyente; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_contribuyente (
    codigo character varying(15) NOT NULL,
    estado character varying(20) NOT NULL,
    tipo_persona character varying(20) NOT NULL,
    genero character varying(10),
    fecha_nacimiento date,
    dni character varying(10),
    ruc character varying(15),
    otros_doc_ident character varying(50),
    nro_doc_ident character varying(50),
    nombres_razon_social character varying(255) NOT NULL,
    observaciones text,
    telefono_fijo character varying(20),
    celular character varying(20),
    celular_whatsapp character varying(20),
    correo_electronico character varying(100),
    fecha_creacion date DEFAULT CURRENT_DATE,
    codigo_anterior character varying(15),
    doc_ident_rep_legal character varying(50),
    nro_doc_rep_legal character varying(50)
);


ALTER TABLE imp.imp_contribuyente OWNER TO admin;

--
-- TOC entry 363 (class 1259 OID 39363)
-- Name: imp_cuenta_corriente; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_cuenta_corriente (
    id_movimiento integer NOT NULL,
    codigo_contribuyente character varying(15) NOT NULL,
    anio smallint NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    tipo_movimiento character varying(20) NOT NULL,
    concepto character varying(50) NOT NULL,
    monto numeric(14,2) NOT NULL,
    saldo numeric(14,2) NOT NULL,
    id_origen_dj integer,
    id_origen_pago integer,
    CONSTRAINT imp_cuenta_corriente_concepto_check CHECK (((concepto)::text = ANY ((ARRAY['IMPUESTO'::character varying, 'DE_EMISION'::character varying, 'MULTA'::character varying, 'INTERES'::character varying, 'PAGO'::character varying, 'EXTORNO'::character varying])::text[]))),
    CONSTRAINT imp_cuenta_corriente_tipo_movimiento_check CHECK (((tipo_movimiento)::text = ANY ((ARRAY['CARGO'::character varying, 'ABONO'::character varying, 'AJUSTE'::character varying])::text[])))
);


ALTER TABLE imp.imp_cuenta_corriente OWNER TO admin;

--
-- TOC entry 362 (class 1259 OID 39362)
-- Name: imp_cuenta_corriente_id_movimiento_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_cuenta_corriente_id_movimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_cuenta_corriente_id_movimiento_seq OWNER TO admin;

--
-- TOC entry 5678 (class 0 OID 0)
-- Dependencies: 362
-- Name: imp_cuenta_corriente_id_movimiento_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_cuenta_corriente_id_movimiento_seq OWNED BY imp.imp_cuenta_corriente.id_movimiento;


--
-- TOC entry 343 (class 1259 OID 39146)
-- Name: imp_declaracion_jurada; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_declaracion_jurada (
    id_declaracion_jurada integer NOT NULL,
    codigo_contribuyente character varying(15) NOT NULL,
    id_motivo_dj integer NOT NULL,
    estado character varying(20),
    anio smallint NOT NULL,
    fecha_recepcion date,
    otros_motivos_declaracion text,
    total_predios_declarados smallint,
    anio_desde smallint,
    trimestre_desde smallint,
    fecha_declaracion date,
    total_base_imponible numeric(18,2),
    impuesto_anual numeric(18,2),
    impuesto_trimestral numeric(18,2),
    observaciones text,
    total_multa numeric(18,2),
    total_multa_descuento numeric(18,2)
);


ALTER TABLE imp.imp_declaracion_jurada OWNER TO admin;

--
-- TOC entry 342 (class 1259 OID 39145)
-- Name: imp_declaracion_jurada_id_declaracion_jurada_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_declaracion_jurada_id_declaracion_jurada_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_declaracion_jurada_id_declaracion_jurada_seq OWNER TO admin;

--
-- TOC entry 5679 (class 0 OID 0)
-- Dependencies: 342
-- Name: imp_declaracion_jurada_id_declaracion_jurada_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_declaracion_jurada_id_declaracion_jurada_seq OWNED BY imp.imp_declaracion_jurada.id_declaracion_jurada;


--
-- TOC entry 277 (class 1259 OID 38726)
-- Name: imp_departamento; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_departamento (
    id_departamento integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE imp.imp_departamento OWNER TO admin;

--
-- TOC entry 276 (class 1259 OID 38725)
-- Name: imp_departamento_id_departamento_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_departamento_id_departamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_departamento_id_departamento_seq OWNER TO admin;

--
-- TOC entry 5680 (class 0 OID 0)
-- Dependencies: 276
-- Name: imp_departamento_id_departamento_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_departamento_id_departamento_seq OWNED BY imp.imp_departamento.id_departamento;


--
-- TOC entry 331 (class 1259 OID 39050)
-- Name: imp_depreciacion; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_depreciacion (
    id_depreciacion integer NOT NULL,
    anio smallint NOT NULL,
    clasificacion character varying(150) NOT NULL,
    material_predominante character varying(100),
    antiguedad_anios integer,
    muy_bueno numeric(4,2),
    bueno numeric(4,2),
    regular numeric(4,2),
    malo numeric(4,2),
    muy_malo numeric(4,2)
);


ALTER TABLE imp.imp_depreciacion OWNER TO admin;

--
-- TOC entry 330 (class 1259 OID 39049)
-- Name: imp_depreciacion_id_depreciacion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_depreciacion_id_depreciacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_depreciacion_id_depreciacion_seq OWNER TO admin;

--
-- TOC entry 5681 (class 0 OID 0)
-- Dependencies: 330
-- Name: imp_depreciacion_id_depreciacion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_depreciacion_id_depreciacion_seq OWNED BY imp.imp_depreciacion.id_depreciacion;


--
-- TOC entry 281 (class 1259 OID 38745)
-- Name: imp_distrito; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_distrito (
    id_distrito integer NOT NULL,
    id_provincia integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE imp.imp_distrito OWNER TO admin;

--
-- TOC entry 280 (class 1259 OID 38744)
-- Name: imp_distrito_id_distrito_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_distrito_id_distrito_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_distrito_id_distrito_seq OWNER TO admin;

--
-- TOC entry 5682 (class 0 OID 0)
-- Dependencies: 280
-- Name: imp_distrito_id_distrito_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_distrito_id_distrito_seq OWNED BY imp.imp_distrito.id_distrito;


--
-- TOC entry 345 (class 1259 OID 39165)
-- Name: imp_dj_predio; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_dj_predio (
    id_dj_predio integer NOT NULL,
    id_declaracion_jurada integer NOT NULL,
    id_predio integer,
    id_tipo_registro_predio integer,
    direccion_predio character varying(255),
    condicion_propiedad character varying(50),
    id_uso_predio integer,
    porcentaje_co_propiedad numeric(5,2) DEFAULT 100.00,
    luz character varying(50),
    agua character varying(50),
    licencia_construccion character varying(50),
    conformidad_obra character varying(50),
    declaracion_fabrica character varying(50),
    sustento text,
    fecha_adquisicion date,
    area_terreno numeric(10,2),
    area_comun numeric(8,2),
    id_arancel_urbano integer,
    partida_registral character varying(50),
    total_area_construida numeric(8,2),
    total_area_instalacion numeric(8,2),
    autoavaluo_copropietario numeric(8,2),
    valor_tconstruccion numeric(8,2),
    valor_tinstalacion numeric(8,2),
    valor_terreno numeric(8,2),
    total_autoavaluo numeric(8,2),
    base_imponible numeric(14,2) NOT NULL,
    url_foto_dj character varying(255),
    id_valor_exoneracion integer
);


ALTER TABLE imp.imp_dj_predio OWNER TO admin;

--
-- TOC entry 344 (class 1259 OID 39164)
-- Name: imp_dj_predio_id_dj_predio_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_dj_predio_id_dj_predio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_dj_predio_id_dj_predio_seq OWNER TO admin;

--
-- TOC entry 5683 (class 0 OID 0)
-- Dependencies: 344
-- Name: imp_dj_predio_id_dj_predio_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_dj_predio_id_dj_predio_seq OWNED BY imp.imp_dj_predio.id_dj_predio;


--
-- TOC entry 298 (class 1259 OID 38854)
-- Name: imp_domicilio_fiscal_contribuyente; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_domicilio_fiscal_contribuyente (
    id_domicilio integer NOT NULL,
    codigo_contribuyente character varying(15) NOT NULL,
    id_distrito integer NOT NULL,
    id_via integer,
    id_sector integer,
    id_habilitacion integer,
    id_asociacion integer,
    numero character varying(20),
    letra character varying(5),
    id_tipo_interior integer,
    numero_interior character varying(20),
    manzana character varying(10),
    lote character varying(10),
    sublote character varying(10),
    bloque character varying(10),
    edificio character varying(50),
    piso character varying(10),
    numeracion_ampliada character varying(100),
    direccion_fiscal character varying(255),
    referencia_direccion character varying(255)
);


ALTER TABLE imp.imp_domicilio_fiscal_contribuyente OWNER TO admin;

--
-- TOC entry 297 (class 1259 OID 38853)
-- Name: imp_domicilio_fiscal_contribuyente_id_domicilio_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_domicilio_fiscal_contribuyente_id_domicilio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_domicilio_fiscal_contribuyente_id_domicilio_seq OWNER TO admin;

--
-- TOC entry 5684 (class 0 OID 0)
-- Dependencies: 297
-- Name: imp_domicilio_fiscal_contribuyente_id_domicilio_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_domicilio_fiscal_contribuyente_id_domicilio_seq OWNED BY imp.imp_domicilio_fiscal_contribuyente.id_domicilio;


--
-- TOC entry 323 (class 1259 OID 38998)
-- Name: imp_escala_impuesto; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_escala_impuesto (
    id_escala_impuesto integer NOT NULL,
    anio smallint NOT NULL,
    desde_autovaluo numeric(18,2) NOT NULL,
    hasta_autovaluo numeric(18,2) NOT NULL,
    tasa_impuesto numeric(6,4),
    impuesto_acumulado numeric(18,2)
);


ALTER TABLE imp.imp_escala_impuesto OWNER TO admin;

--
-- TOC entry 322 (class 1259 OID 38997)
-- Name: imp_escala_impuesto_id_escala_impuesto_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_escala_impuesto_id_escala_impuesto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_escala_impuesto_id_escala_impuesto_seq OWNER TO admin;

--
-- TOC entry 5685 (class 0 OID 0)
-- Dependencies: 322
-- Name: imp_escala_impuesto_id_escala_impuesto_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_escala_impuesto_id_escala_impuesto_seq OWNED BY imp.imp_escala_impuesto.id_escala_impuesto;


--
-- TOC entry 315 (class 1259 OID 38962)
-- Name: imp_estado_conservacion; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_estado_conservacion (
    id_estado_conservacion integer NOT NULL,
    codigo character varying(10),
    denominacion character varying(100) NOT NULL,
    factor_depreciacion numeric(5,2)
);


ALTER TABLE imp.imp_estado_conservacion OWNER TO admin;

--
-- TOC entry 314 (class 1259 OID 38961)
-- Name: imp_estado_conservacion_id_estado_conservacion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_estado_conservacion_id_estado_conservacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_estado_conservacion_id_estado_conservacion_seq OWNER TO admin;

--
-- TOC entry 5686 (class 0 OID 0)
-- Dependencies: 314
-- Name: imp_estado_conservacion_id_estado_conservacion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_estado_conservacion_id_estado_conservacion_seq OWNED BY imp.imp_estado_conservacion.id_estado_conservacion;


--
-- TOC entry 333 (class 1259 OID 39059)
-- Name: imp_exoneracion; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_exoneracion (
    id_exoneracion integer NOT NULL,
    estado character varying(20),
    tributo character varying(100) NOT NULL,
    descripcion text,
    abreviacion character varying(20),
    requiere_sustento boolean DEFAULT false
);


ALTER TABLE imp.imp_exoneracion OWNER TO admin;

--
-- TOC entry 332 (class 1259 OID 39058)
-- Name: imp_exoneracion_id_exoneracion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_exoneracion_id_exoneracion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_exoneracion_id_exoneracion_seq OWNER TO admin;

--
-- TOC entry 5687 (class 0 OID 0)
-- Dependencies: 332
-- Name: imp_exoneracion_id_exoneracion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_exoneracion_id_exoneracion_seq OWNED BY imp.imp_exoneracion.id_exoneracion;


--
-- TOC entry 311 (class 1259 OID 38948)
-- Name: imp_grupo_tierra; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_grupo_tierra (
    id_grupo_tierra integer NOT NULL,
    denominacion character varying(100) NOT NULL
);


ALTER TABLE imp.imp_grupo_tierra OWNER TO admin;

--
-- TOC entry 355 (class 1259 OID 39305)
-- Name: imp_grupo_tierra_detalle; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_grupo_tierra_detalle (
    id_grupo_tierra_detalle integer NOT NULL,
    id_grupo_tierra integer NOT NULL,
    denominacion character varying(100),
    activo boolean,
    eliminado boolean,
    usuario_ingreso character varying(50),
    fecha_ingreso timestamp without time zone
);


ALTER TABLE imp.imp_grupo_tierra_detalle OWNER TO admin;

--
-- TOC entry 354 (class 1259 OID 39304)
-- Name: imp_grupo_tierra_detalle_id_grupo_tierra_detalle_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_grupo_tierra_detalle_id_grupo_tierra_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_grupo_tierra_detalle_id_grupo_tierra_detalle_seq OWNER TO admin;

--
-- TOC entry 5688 (class 0 OID 0)
-- Dependencies: 354
-- Name: imp_grupo_tierra_detalle_id_grupo_tierra_detalle_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_grupo_tierra_detalle_id_grupo_tierra_detalle_seq OWNED BY imp.imp_grupo_tierra_detalle.id_grupo_tierra_detalle;


--
-- TOC entry 310 (class 1259 OID 38947)
-- Name: imp_grupo_tierra_id_grupo_tierra_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_grupo_tierra_id_grupo_tierra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_grupo_tierra_id_grupo_tierra_seq OWNER TO admin;

--
-- TOC entry 5689 (class 0 OID 0)
-- Dependencies: 310
-- Name: imp_grupo_tierra_id_grupo_tierra_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_grupo_tierra_id_grupo_tierra_seq OWNED BY imp.imp_grupo_tierra.id_grupo_tierra;


--
-- TOC entry 287 (class 1259 OID 38778)
-- Name: imp_habilitacion_urbana; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_habilitacion_urbana (
    id_habilitacion integer NOT NULL,
    estado character varying(20),
    nombre_habilitacion character varying(150) NOT NULL,
    numero_partida character varying(100),
    id_tipo_habilitacion integer,
    id_distrito integer NOT NULL
);


ALTER TABLE imp.imp_habilitacion_urbana OWNER TO admin;

--
-- TOC entry 286 (class 1259 OID 38777)
-- Name: imp_habilitacion_urbana_id_habilitacion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_habilitacion_urbana_id_habilitacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_habilitacion_urbana_id_habilitacion_seq OWNER TO admin;

--
-- TOC entry 5690 (class 0 OID 0)
-- Dependencies: 286
-- Name: imp_habilitacion_urbana_id_habilitacion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_habilitacion_urbana_id_habilitacion_seq OWNED BY imp.imp_habilitacion_urbana.id_habilitacion;


--
-- TOC entry 339 (class 1259 OID 39094)
-- Name: imp_junta_vecinal; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_junta_vecinal (
    id_junta_vecinal integer NOT NULL,
    descripcion character varying(200)
);


ALTER TABLE imp.imp_junta_vecinal OWNER TO admin;

--
-- TOC entry 338 (class 1259 OID 39093)
-- Name: imp_junta_vecinal_id_junta_vecinal_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_junta_vecinal_id_junta_vecinal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_junta_vecinal_id_junta_vecinal_seq OWNER TO admin;

--
-- TOC entry 5691 (class 0 OID 0)
-- Dependencies: 338
-- Name: imp_junta_vecinal_id_junta_vecinal_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_junta_vecinal_id_junta_vecinal_seq OWNED BY imp.imp_junta_vecinal.id_junta_vecinal;


--
-- TOC entry 303 (class 1259 OID 38915)
-- Name: imp_material_estructural_predio; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_material_estructural_predio (
    id_material_estructural_predio integer NOT NULL,
    codigo character varying(10),
    denominacion character varying(100) NOT NULL,
    valor_referencia numeric(10,2)
);


ALTER TABLE imp.imp_material_estructural_predio OWNER TO admin;

--
-- TOC entry 302 (class 1259 OID 38914)
-- Name: imp_material_estructural_pred_id_material_estructural_predi_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_material_estructural_pred_id_material_estructural_predi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_material_estructural_pred_id_material_estructural_predi_seq OWNER TO admin;

--
-- TOC entry 5692 (class 0 OID 0)
-- Dependencies: 302
-- Name: imp_material_estructural_pred_id_material_estructural_predi_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_material_estructural_pred_id_material_estructural_predi_seq OWNED BY imp.imp_material_estructural_predio.id_material_estructural_predio;


--
-- TOC entry 305 (class 1259 OID 38924)
-- Name: imp_motivo_dj; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_motivo_dj (
    id_motivo_dj integer NOT NULL,
    codigo character varying(10),
    denominacion character varying(100) NOT NULL,
    abreviatura character varying(10),
    transferencia boolean DEFAULT false
);


ALTER TABLE imp.imp_motivo_dj OWNER TO admin;

--
-- TOC entry 304 (class 1259 OID 38923)
-- Name: imp_motivo_dj_id_motivo_dj_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_motivo_dj_id_motivo_dj_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_motivo_dj_id_motivo_dj_seq OWNER TO admin;

--
-- TOC entry 5693 (class 0 OID 0)
-- Dependencies: 304
-- Name: imp_motivo_dj_id_motivo_dj_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_motivo_dj_id_motivo_dj_seq OWNED BY imp.imp_motivo_dj.id_motivo_dj;


--
-- TOC entry 299 (class 1259 OID 38897)
-- Name: imp_nivel; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_nivel (
    id_nivel character varying(10) NOT NULL,
    codigo character varying(10),
    denominacion character varying(100) NOT NULL,
    incremento_sp numeric(5,2) DEFAULT 0.00,
    aplicar_5_por_ciento boolean DEFAULT false
);


ALTER TABLE imp.imp_nivel OWNER TO admin;

--
-- TOC entry 327 (class 1259 OID 39029)
-- Name: imp_obra_complementaria; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_obra_complementaria (
    id_obra character(3) NOT NULL,
    descripcion character varying(255) NOT NULL,
    componente character varying(100),
    unidad character varying(50),
    CONSTRAINT ck_imp_obra_id_formato CHECK ((id_obra ~ '^[0-9]{3}$'::text))
);


ALTER TABLE imp.imp_obra_complementaria OWNER TO admin;

--
-- TOC entry 359 (class 1259 OID 39334)
-- Name: imp_pago; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_pago (
    id_pago integer NOT NULL,
    declaracion_predio_id integer NOT NULL,
    cuota integer NOT NULL,
    fecha_vencimiento date,
    monto numeric(14,2) NOT NULL,
    monto_pagado numeric(14,2) DEFAULT 0,
    fecha_pago date,
    estado character varying(15) DEFAULT 'pendiente'::character varying,
    id_vencimiento_emision integer,
    CONSTRAINT imp_pago_estado_check CHECK (((estado)::text = ANY ((ARRAY['pendiente'::character varying, 'pagado'::character varying, 'vencido'::character varying])::text[])))
);


ALTER TABLE imp.imp_pago OWNER TO admin;

--
-- TOC entry 358 (class 1259 OID 39333)
-- Name: imp_pago_id_pago_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_pago_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_pago_id_pago_seq OWNER TO admin;

--
-- TOC entry 5694 (class 0 OID 0)
-- Dependencies: 358
-- Name: imp_pago_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_pago_id_pago_seq OWNED BY imp.imp_pago.id_pago;


--
-- TOC entry 361 (class 1259 OID 39354)
-- Name: imp_param_moratorio; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_param_moratorio (
    id_param_moratorio integer NOT NULL,
    anio smallint NOT NULL,
    factor_ipm numeric(5,4) NOT NULL,
    tasa_tim numeric(5,4) NOT NULL
);


ALTER TABLE imp.imp_param_moratorio OWNER TO admin;

--
-- TOC entry 360 (class 1259 OID 39353)
-- Name: imp_param_moratorio_id_param_moratorio_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_param_moratorio_id_param_moratorio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_param_moratorio_id_param_moratorio_seq OWNER TO admin;

--
-- TOC entry 5695 (class 0 OID 0)
-- Dependencies: 360
-- Name: imp_param_moratorio_id_param_moratorio_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_param_moratorio_id_param_moratorio_seq OWNED BY imp.imp_param_moratorio.id_param_moratorio;


--
-- TOC entry 321 (class 1259 OID 38987)
-- Name: imp_param_principales; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_param_principales (
    id_param_principal integer NOT NULL,
    anio smallint NOT NULL,
    numero_cuponeras integer,
    porcentaje_quinta numeric(6,4),
    valor_uit numeric(18,2),
    moneda character varying(20),
    cuotas integer,
    impuesto_minimo numeric(14,2),
    tope_emision numeric(14,2),
    porcentaje_incremento numeric(6,4),
    factor_oficializacion_otras_instalaciones numeric(8,4),
    glosa_base_legal text
);


ALTER TABLE imp.imp_param_principales OWNER TO admin;

--
-- TOC entry 320 (class 1259 OID 38986)
-- Name: imp_param_principales_id_param_principal_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_param_principales_id_param_principal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_param_principales_id_param_principal_seq OWNER TO admin;

--
-- TOC entry 5696 (class 0 OID 0)
-- Dependencies: 320
-- Name: imp_param_principales_id_param_principal_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_param_principales_id_param_principal_seq OWNED BY imp.imp_param_principales.id_param_principal;


--
-- TOC entry 341 (class 1259 OID 39101)
-- Name: imp_predio; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_predio (
    id_predio integer NOT NULL,
    estado character varying(20) NOT NULL,
    id_distrito integer NOT NULL,
    id_via integer,
    id_sector integer,
    id_habilitacion integer,
    id_asociacion integer,
    numero character varying(20),
    letra character varying(10),
    nombre_predio character varying(255),
    id_tipo_interior integer,
    numero_interior character varying(20),
    manzana character varying(10),
    lote character varying(10),
    sublote character varying(10),
    bloque character varying(10),
    edificio character varying(50),
    piso character varying(10),
    numeracion_ampliada character varying(100),
    id_junta_vecinal integer,
    observaciones text,
    CONSTRAINT imp_predio_estado_check CHECK (((estado)::text = ANY ((ARRAY['activo'::character varying, 'anulado'::character varying, 'subdividido'::character varying])::text[])))
);


ALTER TABLE imp.imp_predio OWNER TO admin;

--
-- TOC entry 347 (class 1259 OID 39205)
-- Name: imp_predio_colindante; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_predio_colindante (
    id_predio_colindante integer NOT NULL,
    id_dj_predio integer NOT NULL,
    predio_norte character varying(100),
    propietario_norte character varying(200),
    medida_norte numeric(10,2),
    predio_sur character varying(100),
    propietario_sur character varying(200),
    medida_sur numeric(10,2),
    predio_este character varying(100),
    propietario_este character varying(200),
    medida_este numeric(10,2),
    predio_oeste character varying(100),
    propietario_oeste character varying(200),
    medida_oeste numeric(10,2)
);


ALTER TABLE imp.imp_predio_colindante OWNER TO admin;

--
-- TOC entry 346 (class 1259 OID 39204)
-- Name: imp_predio_colindante_id_predio_colindante_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_predio_colindante_id_predio_colindante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_predio_colindante_id_predio_colindante_seq OWNER TO admin;

--
-- TOC entry 5697 (class 0 OID 0)
-- Dependencies: 346
-- Name: imp_predio_colindante_id_predio_colindante_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_predio_colindante_id_predio_colindante_seq OWNED BY imp.imp_predio_colindante.id_predio_colindante;


--
-- TOC entry 349 (class 1259 OID 39219)
-- Name: imp_predio_construccion; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_predio_construccion (
    id_predio_construccion integer NOT NULL,
    id_dj_predio integer NOT NULL,
    id_nivel character varying(10),
    id_material_estructural_predio integer,
    id_depreciacion integer,
    id_categoria_edificacion character(1),
    antiguedad integer,
    area_construida numeric(10,2) NOT NULL,
    valor_unitario numeric(10,2),
    valor_depreciado numeric(10,2),
    valor_total_construccion numeric(14,2)
);


ALTER TABLE imp.imp_predio_construccion OWNER TO admin;

--
-- TOC entry 348 (class 1259 OID 39218)
-- Name: imp_predio_construccion_id_predio_construccion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_predio_construccion_id_predio_construccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_predio_construccion_id_predio_construccion_seq OWNER TO admin;

--
-- TOC entry 5698 (class 0 OID 0)
-- Dependencies: 348
-- Name: imp_predio_construccion_id_predio_construccion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_predio_construccion_id_predio_construccion_seq OWNED BY imp.imp_predio_construccion.id_predio_construccion;


--
-- TOC entry 340 (class 1259 OID 39100)
-- Name: imp_predio_id_predio_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_predio_id_predio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_predio_id_predio_seq OWNER TO admin;

--
-- TOC entry 5699 (class 0 OID 0)
-- Dependencies: 340
-- Name: imp_predio_id_predio_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_predio_id_predio_seq OWNED BY imp.imp_predio.id_predio;


--
-- TOC entry 353 (class 1259 OID 39273)
-- Name: imp_predio_otra_instalacion; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_predio_otra_instalacion (
    id_predio_otra_instalacion integer NOT NULL,
    id_dj_predio integer NOT NULL,
    id_nivel character varying(10),
    id_material_estructural_predio integer,
    id_obra_complementaria character(3),
    id_depreciacion integer,
    antiguedad integer,
    area numeric(10,2) NOT NULL,
    valor_instalacion numeric(14,2)
);


ALTER TABLE imp.imp_predio_otra_instalacion OWNER TO admin;

--
-- TOC entry 352 (class 1259 OID 39272)
-- Name: imp_predio_otra_instalacion_id_predio_otra_instalacion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_predio_otra_instalacion_id_predio_otra_instalacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_predio_otra_instalacion_id_predio_otra_instalacion_seq OWNER TO admin;

--
-- TOC entry 5700 (class 0 OID 0)
-- Dependencies: 352
-- Name: imp_predio_otra_instalacion_id_predio_otra_instalacion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_predio_otra_instalacion_id_predio_otra_instalacion_seq OWNED BY imp.imp_predio_otra_instalacion.id_predio_otra_instalacion;


--
-- TOC entry 351 (class 1259 OID 39251)
-- Name: imp_predio_terreno; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_predio_terreno (
    id_predio_terreno integer NOT NULL,
    id_dj_predio integer NOT NULL,
    id_clasificacion_terreno integer NOT NULL,
    id_categoria_terreno_ext integer NOT NULL,
    arancel numeric(14,2),
    cantidad numeric(10,2),
    valor numeric(14,2)
);


ALTER TABLE imp.imp_predio_terreno OWNER TO admin;

--
-- TOC entry 350 (class 1259 OID 39250)
-- Name: imp_predio_terreno_id_predio_terreno_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_predio_terreno_id_predio_terreno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_predio_terreno_id_predio_terreno_seq OWNER TO admin;

--
-- TOC entry 5701 (class 0 OID 0)
-- Dependencies: 350
-- Name: imp_predio_terreno_id_predio_terreno_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_predio_terreno_id_predio_terreno_seq OWNED BY imp.imp_predio_terreno.id_predio_terreno;


--
-- TOC entry 279 (class 1259 OID 38733)
-- Name: imp_provincia; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_provincia (
    id_provincia integer NOT NULL,
    id_departamento integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE imp.imp_provincia OWNER TO admin;

--
-- TOC entry 278 (class 1259 OID 38732)
-- Name: imp_provincia_id_provincia_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_provincia_id_provincia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_provincia_id_provincia_seq OWNER TO admin;

--
-- TOC entry 5702 (class 0 OID 0)
-- Dependencies: 278
-- Name: imp_provincia_id_provincia_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_provincia_id_provincia_seq OWNED BY imp.imp_provincia.id_provincia;


--
-- TOC entry 283 (class 1259 OID 38757)
-- Name: imp_sector; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_sector (
    id_sector integer NOT NULL,
    estado character varying(20),
    nombre_sector character varying(150) NOT NULL,
    id_distrito integer NOT NULL
);


ALTER TABLE imp.imp_sector OWNER TO admin;

--
-- TOC entry 282 (class 1259 OID 38756)
-- Name: imp_sector_id_sector_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_sector_id_sector_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_sector_id_sector_seq OWNER TO admin;

--
-- TOC entry 5703 (class 0 OID 0)
-- Dependencies: 282
-- Name: imp_sector_id_sector_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_sector_id_sector_seq OWNED BY imp.imp_sector.id_sector;


--
-- TOC entry 285 (class 1259 OID 38771)
-- Name: imp_tipo_habilitacion_urbana; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_tipo_habilitacion_urbana (
    id_tipo_habilitacion integer NOT NULL,
    descripcion character varying(200),
    abreviacion character varying(20)
);


ALTER TABLE imp.imp_tipo_habilitacion_urbana OWNER TO admin;

--
-- TOC entry 284 (class 1259 OID 38770)
-- Name: imp_tipo_habilitacion_urbana_id_tipo_habilitacion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_tipo_habilitacion_urbana_id_tipo_habilitacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_tipo_habilitacion_urbana_id_tipo_habilitacion_seq OWNER TO admin;

--
-- TOC entry 5704 (class 0 OID 0)
-- Dependencies: 284
-- Name: imp_tipo_habilitacion_urbana_id_tipo_habilitacion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_tipo_habilitacion_urbana_id_tipo_habilitacion_seq OWNED BY imp.imp_tipo_habilitacion_urbana.id_tipo_habilitacion;


--
-- TOC entry 296 (class 1259 OID 38845)
-- Name: imp_tipo_interior; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_tipo_interior (
    id_tipo_interior integer NOT NULL,
    descripcion character varying(200),
    otros text
);


ALTER TABLE imp.imp_tipo_interior OWNER TO admin;

--
-- TOC entry 295 (class 1259 OID 38844)
-- Name: imp_tipo_interior_id_tipo_interior_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_tipo_interior_id_tipo_interior_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_tipo_interior_id_tipo_interior_seq OWNER TO admin;

--
-- TOC entry 5705 (class 0 OID 0)
-- Dependencies: 295
-- Name: imp_tipo_interior_id_tipo_interior_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_tipo_interior_id_tipo_interior_seq OWNED BY imp.imp_tipo_interior.id_tipo_interior;


--
-- TOC entry 301 (class 1259 OID 38907)
-- Name: imp_tipo_registro_predio; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_tipo_registro_predio (
    id_tipo_registro_predio integer NOT NULL,
    denominacion character varying(100) NOT NULL,
    activo boolean DEFAULT true
);


ALTER TABLE imp.imp_tipo_registro_predio OWNER TO admin;

--
-- TOC entry 300 (class 1259 OID 38906)
-- Name: imp_tipo_registro_predio_id_tipo_registro_predio_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_tipo_registro_predio_id_tipo_registro_predio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_tipo_registro_predio_id_tipo_registro_predio_seq OWNER TO admin;

--
-- TOC entry 5706 (class 0 OID 0)
-- Dependencies: 300
-- Name: imp_tipo_registro_predio_id_tipo_registro_predio_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_tipo_registro_predio_id_tipo_registro_predio_seq OWNED BY imp.imp_tipo_registro_predio.id_tipo_registro_predio;


--
-- TOC entry 291 (class 1259 OID 38811)
-- Name: imp_tipo_via; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_tipo_via (
    id_tipo_via integer NOT NULL,
    tipo_via character varying(100),
    abreviacion character varying(20)
);


ALTER TABLE imp.imp_tipo_via OWNER TO admin;

--
-- TOC entry 290 (class 1259 OID 38810)
-- Name: imp_tipo_via_id_tipo_via_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_tipo_via_id_tipo_via_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_tipo_via_id_tipo_via_seq OWNER TO admin;

--
-- TOC entry 5707 (class 0 OID 0)
-- Dependencies: 290
-- Name: imp_tipo_via_id_tipo_via_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_tipo_via_id_tipo_via_seq OWNED BY imp.imp_tipo_via.id_tipo_via;


--
-- TOC entry 319 (class 1259 OID 38980)
-- Name: imp_uso_predio; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_uso_predio (
    id_uso integer NOT NULL,
    estado character varying(20),
    descripcion_uso character varying(200) NOT NULL
);


ALTER TABLE imp.imp_uso_predio OWNER TO admin;

--
-- TOC entry 318 (class 1259 OID 38979)
-- Name: imp_uso_predio_id_uso_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_uso_predio_id_uso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_uso_predio_id_uso_seq OWNER TO admin;

--
-- TOC entry 5708 (class 0 OID 0)
-- Dependencies: 318
-- Name: imp_uso_predio_id_uso_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_uso_predio_id_uso_seq OWNED BY imp.imp_uso_predio.id_uso;


--
-- TOC entry 335 (class 1259 OID 39069)
-- Name: imp_valor_exoneracion; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_valor_exoneracion (
    id_valor_exoneracion integer NOT NULL,
    anio smallint NOT NULL,
    id_exoneracion integer NOT NULL,
    monto_exonerado numeric(14,2),
    porcentaje_exonerado numeric(6,4)
);


ALTER TABLE imp.imp_valor_exoneracion OWNER TO admin;

--
-- TOC entry 334 (class 1259 OID 39068)
-- Name: imp_valor_exoneracion_id_valor_exoneracion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_valor_exoneracion_id_valor_exoneracion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_valor_exoneracion_id_valor_exoneracion_seq OWNER TO admin;

--
-- TOC entry 5709 (class 0 OID 0)
-- Dependencies: 334
-- Name: imp_valor_exoneracion_id_valor_exoneracion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_valor_exoneracion_id_valor_exoneracion_seq OWNED BY imp.imp_valor_exoneracion.id_valor_exoneracion;


--
-- TOC entry 326 (class 1259 OID 39014)
-- Name: imp_valor_unitario_edificacion; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_valor_unitario_edificacion (
    id_valor_unitario_edificacion integer NOT NULL,
    anio smallint NOT NULL,
    id_categoria character(1) NOT NULL,
    muros_y_columnas numeric(14,2),
    techos numeric(14,2),
    pisos numeric(14,2),
    puertas_ventanas numeric(14,2),
    revestimientos numeric(14,2),
    banos numeric(14,2),
    instalaciones_electricas_sanitarias numeric(14,2),
    base_legal text
);


ALTER TABLE imp.imp_valor_unitario_edificacion OWNER TO admin;

--
-- TOC entry 325 (class 1259 OID 39013)
-- Name: imp_valor_unitario_edificacio_id_valor_unitario_edificacion_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_valor_unitario_edificacio_id_valor_unitario_edificacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_valor_unitario_edificacio_id_valor_unitario_edificacion_seq OWNER TO admin;

--
-- TOC entry 5710 (class 0 OID 0)
-- Dependencies: 325
-- Name: imp_valor_unitario_edificacio_id_valor_unitario_edificacion_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_valor_unitario_edificacio_id_valor_unitario_edificacion_seq OWNED BY imp.imp_valor_unitario_edificacion.id_valor_unitario_edificacion;


--
-- TOC entry 329 (class 1259 OID 39036)
-- Name: imp_valor_unitario_obra; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_valor_unitario_obra (
    id_valor_unitario_obra integer NOT NULL,
    anio smallint NOT NULL,
    id_obra character(3) NOT NULL,
    valor_unitario numeric(14,2)
);


ALTER TABLE imp.imp_valor_unitario_obra OWNER TO admin;

--
-- TOC entry 328 (class 1259 OID 39035)
-- Name: imp_valor_unitario_obra_id_valor_unitario_obra_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_valor_unitario_obra_id_valor_unitario_obra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_valor_unitario_obra_id_valor_unitario_obra_seq OWNER TO admin;

--
-- TOC entry 5711 (class 0 OID 0)
-- Dependencies: 328
-- Name: imp_valor_unitario_obra_id_valor_unitario_obra_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_valor_unitario_obra_id_valor_unitario_obra_seq OWNED BY imp.imp_valor_unitario_obra.id_valor_unitario_obra;


--
-- TOC entry 337 (class 1259 OID 39083)
-- Name: imp_vencimiento_emision; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_vencimiento_emision (
    id_vencimiento_emision integer NOT NULL,
    tributo character varying(100) NOT NULL,
    anio smallint NOT NULL,
    periodo smallint,
    fecha_vencimiento date,
    fecha_prorroga date,
    base_legal text,
    derecho_emision numeric(14,2),
    costo_por_predio numeric(14,2),
    cantidad_predios_exceso integer
);


ALTER TABLE imp.imp_vencimiento_emision OWNER TO admin;

--
-- TOC entry 336 (class 1259 OID 39082)
-- Name: imp_vencimiento_emision_id_vencimiento_emision_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_vencimiento_emision_id_vencimiento_emision_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_vencimiento_emision_id_vencimiento_emision_seq OWNER TO admin;

--
-- TOC entry 5712 (class 0 OID 0)
-- Dependencies: 336
-- Name: imp_vencimiento_emision_id_vencimiento_emision_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_vencimiento_emision_id_vencimiento_emision_seq OWNED BY imp.imp_vencimiento_emision.id_vencimiento_emision;


--
-- TOC entry 293 (class 1259 OID 38818)
-- Name: imp_via; Type: TABLE; Schema: imp; Owner: admin
--

CREATE TABLE imp.imp_via (
    id_via integer NOT NULL,
    estado character varying(20),
    nombre_via character varying(150) NOT NULL,
    id_tipo_via integer,
    id_distrito integer NOT NULL
);


ALTER TABLE imp.imp_via OWNER TO admin;

--
-- TOC entry 292 (class 1259 OID 38817)
-- Name: imp_via_id_via_seq; Type: SEQUENCE; Schema: imp; Owner: admin
--

CREATE SEQUENCE imp.imp_via_id_via_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE imp.imp_via_id_via_seq OWNER TO admin;

--
-- TOC entry 5713 (class 0 OID 0)
-- Dependencies: 292
-- Name: imp_via_id_via_seq; Type: SEQUENCE OWNED BY; Schema: imp; Owner: admin
--

ALTER SEQUENCE imp.imp_via_id_via_seq OWNED BY imp.imp_via.id_via;


--
-- TOC entry 401 (class 1259 OID 40732)
-- Name: lic_actividad_comercial; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_actividad_comercial (
    id integer NOT NULL,
    nombre text NOT NULL,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME
);


ALTER TABLE lic.lic_actividad_comercial OWNER TO admin;

--
-- TOC entry 400 (class 1259 OID 40731)
-- Name: lic_actividad_comercial_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_actividad_comercial_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_actividad_comercial_id_seq OWNER TO admin;

--
-- TOC entry 5714 (class 0 OID 0)
-- Dependencies: 400
-- Name: lic_actividad_comercial_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_actividad_comercial_id_seq OWNED BY lic.lic_actividad_comercial.id;


--
-- TOC entry 399 (class 1259 OID 40717)
-- Name: lic_condicion_local; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_condicion_local (
    id integer NOT NULL,
    nombre text NOT NULL,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME
);


ALTER TABLE lic.lic_condicion_local OWNER TO admin;

--
-- TOC entry 398 (class 1259 OID 40716)
-- Name: lic_condicion_local_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_condicion_local_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_condicion_local_id_seq OWNER TO admin;

--
-- TOC entry 5715 (class 0 OID 0)
-- Dependencies: 398
-- Name: lic_condicion_local_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_condicion_local_id_seq OWNED BY lic.lic_condicion_local.id;


--
-- TOC entry 411 (class 1259 OID 40812)
-- Name: lic_documento; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_documento (
    id integer NOT NULL,
    id_requisito integer NOT NULL,
    descripcion text,
    num_documento text NOT NULL,
    fecha date NOT NULL,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME
);


ALTER TABLE lic.lic_documento OWNER TO admin;

--
-- TOC entry 410 (class 1259 OID 40811)
-- Name: lic_documento_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_documento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_documento_id_seq OWNER TO admin;

--
-- TOC entry 5716 (class 0 OID 0)
-- Dependencies: 410
-- Name: lic_documento_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_documento_id_seq OWNED BY lic.lic_documento.id;


--
-- TOC entry 409 (class 1259 OID 40793)
-- Name: lic_giro_licencia; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_giro_licencia (
    id integer NOT NULL,
    id_giro_negocio integer NOT NULL,
    desde date NOT NULL,
    hasta date NOT NULL,
    detalles text,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME,
    CONSTRAINT chk_giro_licencia_fechas CHECK ((desde <= hasta))
);


ALTER TABLE lic.lic_giro_licencia OWNER TO admin;

--
-- TOC entry 408 (class 1259 OID 40792)
-- Name: lic_giro_licencia_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_giro_licencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_giro_licencia_id_seq OWNER TO admin;

--
-- TOC entry 5717 (class 0 OID 0)
-- Dependencies: 408
-- Name: lic_giro_licencia_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_giro_licencia_id_seq OWNED BY lic.lic_giro_licencia.id;


--
-- TOC entry 405 (class 1259 OID 40762)
-- Name: lic_giro_negocio; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_giro_negocio (
    id integer NOT NULL,
    nombre text NOT NULL,
    monto numeric(10,2) NOT NULL,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME,
    CONSTRAINT chk_giro_negocio_monto CHECK ((monto >= (0)::numeric))
);


ALTER TABLE lic.lic_giro_negocio OWNER TO admin;

--
-- TOC entry 404 (class 1259 OID 40761)
-- Name: lic_giro_negocio_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_giro_negocio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_giro_negocio_id_seq OWNER TO admin;

--
-- TOC entry 5718 (class 0 OID 0)
-- Dependencies: 404
-- Name: lic_giro_negocio_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_giro_negocio_id_seq OWNED BY lic.lic_giro_negocio.id;


--
-- TOC entry 413 (class 1259 OID 40830)
-- Name: lic_licencia; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_licencia (
    id integer NOT NULL,
    estado character varying(30) DEFAULT 'Pendiente'::character varying NOT NULL,
    num_certificado integer,
    anio_certificado integer,
    certificado_fecha date,
    num_expediente text,
    expediente_fecha date,
    num_resolucion text,
    resolucion_fecha date,
    id_contribuyente integer NOT NULL,
    id_predio integer NOT NULL,
    id_motivo_registro integer NOT NULL,
    id_tipo_licencia integer NOT NULL,
    id_condicion_local integer NOT NULL,
    id_actividad_comercial integer NOT NULL,
    id_tipo_establecimiento integer NOT NULL,
    nombre text NOT NULL,
    area_publica numeric(10,2),
    area_total numeric(10,2) NOT NULL,
    desde time without time zone NOT NULL,
    hasta time without time zone NOT NULL,
    horario_extraordinario text,
    exoneracion_sustento text,
    id_giro_licencia integer NOT NULL,
    id_documento integer,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME,
    CONSTRAINT chk_licencia_area_total CHECK ((area_total > (0)::numeric)),
    CONSTRAINT chk_licencia_areas CHECK (((area_publica IS NULL) OR (area_publica >= (0)::numeric))),
    CONSTRAINT chk_licencia_horario CHECK (((desde < hasta) OR (horario_extraordinario IS NOT NULL))),
    CONSTRAINT lic_licencia_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activa'::character varying, 'Inactiva'::character varying, 'Pendiente'::character varying])::text[])))
);


ALTER TABLE lic.lic_licencia OWNER TO admin;

--
-- TOC entry 412 (class 1259 OID 40829)
-- Name: lic_licencia_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_licencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_licencia_id_seq OWNER TO admin;

--
-- TOC entry 5719 (class 0 OID 0)
-- Dependencies: 412
-- Name: lic_licencia_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_licencia_id_seq OWNED BY lic.lic_licencia.id;


--
-- TOC entry 395 (class 1259 OID 40687)
-- Name: lic_motivo_registro; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_motivo_registro (
    id integer NOT NULL,
    nombre text NOT NULL,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME
);


ALTER TABLE lic.lic_motivo_registro OWNER TO admin;

--
-- TOC entry 394 (class 1259 OID 40686)
-- Name: lic_motivo_registro_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_motivo_registro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_motivo_registro_id_seq OWNER TO admin;

--
-- TOC entry 5720 (class 0 OID 0)
-- Dependencies: 394
-- Name: lic_motivo_registro_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_motivo_registro_id_seq OWNED BY lic.lic_motivo_registro.id;


--
-- TOC entry 407 (class 1259 OID 40778)
-- Name: lic_requisito; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_requisito (
    id integer NOT NULL,
    nombre text NOT NULL,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME
);


ALTER TABLE lic.lic_requisito OWNER TO admin;

--
-- TOC entry 406 (class 1259 OID 40777)
-- Name: lic_requisito_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_requisito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_requisito_id_seq OWNER TO admin;

--
-- TOC entry 5721 (class 0 OID 0)
-- Dependencies: 406
-- Name: lic_requisito_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_requisito_id_seq OWNED BY lic.lic_requisito.id;


--
-- TOC entry 415 (class 1259 OID 40899)
-- Name: lic_sust_anulacion; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_sust_anulacion (
    id integer NOT NULL,
    id_licencia integer NOT NULL,
    id_motivo_registro integer NOT NULL,
    documento_sustento text NOT NULL,
    fecha date NOT NULL,
    observaciones text,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME
);


ALTER TABLE lic.lic_sust_anulacion OWNER TO admin;

--
-- TOC entry 414 (class 1259 OID 40898)
-- Name: lic_sust_anulacion_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_sust_anulacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_sust_anulacion_id_seq OWNER TO admin;

--
-- TOC entry 5722 (class 0 OID 0)
-- Dependencies: 414
-- Name: lic_sust_anulacion_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_sust_anulacion_id_seq OWNED BY lic.lic_sust_anulacion.id;


--
-- TOC entry 403 (class 1259 OID 40747)
-- Name: lic_tipo_establecimiento; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_tipo_establecimiento (
    id integer NOT NULL,
    nombre text NOT NULL,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME
);


ALTER TABLE lic.lic_tipo_establecimiento OWNER TO admin;

--
-- TOC entry 402 (class 1259 OID 40746)
-- Name: lic_tipo_establecimiento_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_tipo_establecimiento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_tipo_establecimiento_id_seq OWNER TO admin;

--
-- TOC entry 5723 (class 0 OID 0)
-- Dependencies: 402
-- Name: lic_tipo_establecimiento_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_tipo_establecimiento_id_seq OWNED BY lic.lic_tipo_establecimiento.id;


--
-- TOC entry 397 (class 1259 OID 40702)
-- Name: lic_tipo_licencia; Type: TABLE; Schema: lic; Owner: admin
--

CREATE TABLE lic.lic_tipo_licencia (
    id integer NOT NULL,
    nombre text NOT NULL,
    f_creado date DEFAULT CURRENT_DATE,
    h_creado time without time zone DEFAULT CURRENT_TIME,
    f_modificado date DEFAULT CURRENT_DATE,
    h_modificado time without time zone DEFAULT CURRENT_TIME
);


ALTER TABLE lic.lic_tipo_licencia OWNER TO admin;

--
-- TOC entry 396 (class 1259 OID 40701)
-- Name: lic_tipo_licencia_id_seq; Type: SEQUENCE; Schema: lic; Owner: admin
--

CREATE SEQUENCE lic.lic_tipo_licencia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE lic.lic_tipo_licencia_id_seq OWNER TO admin;

--
-- TOC entry 5724 (class 0 OID 0)
-- Dependencies: 396
-- Name: lic_tipo_licencia_id_seq; Type: SEQUENCE OWNED BY; Schema: lic; Owner: admin
--

ALTER SEQUENCE lic.lic_tipo_licencia_id_seq OWNED BY lic.lic_tipo_licencia.id;


--
-- TOC entry 420 (class 1259 OID 40953)
-- Name: vw_lic_actividad_comercial; Type: MATERIALIZED VIEW; Schema: lic; Owner: admin
--

CREATE MATERIALIZED VIEW lic.vw_lic_actividad_comercial AS
 SELECT id,
    nombre,
    f_creado,
    h_creado,
    f_modificado,
    h_modificado
   FROM lic.lic_actividad_comercial
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW lic.vw_lic_actividad_comercial OWNER TO admin;

--
-- TOC entry 419 (class 1259 OID 40947)
-- Name: vw_lic_condicion_local; Type: MATERIALIZED VIEW; Schema: lic; Owner: admin
--

CREATE MATERIALIZED VIEW lic.vw_lic_condicion_local AS
 SELECT id,
    nombre,
    f_creado,
    h_creado,
    f_modificado,
    h_modificado
   FROM lic.lic_condicion_local
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW lic.vw_lic_condicion_local OWNER TO admin;

--
-- TOC entry 422 (class 1259 OID 40965)
-- Name: vw_lic_giro_negocio; Type: MATERIALIZED VIEW; Schema: lic; Owner: admin
--

CREATE MATERIALIZED VIEW lic.vw_lic_giro_negocio AS
 SELECT id,
    nombre,
    to_char(monto, 'FM999999999.00'::text) AS monto,
    f_creado,
    h_creado,
    f_modificado,
    h_modificado
   FROM lic.lic_giro_negocio
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW lic.vw_lic_giro_negocio OWNER TO admin;

--
-- TOC entry 424 (class 1259 OID 40977)
-- Name: vw_lic_licencia; Type: MATERIALIZED VIEW; Schema: lic; Owner: admin
--

CREATE MATERIALIZED VIEW lic.vw_lic_licencia AS
 SELECT l.id,
    l.estado AS "Estado",
    l.num_certificado AS "N° de Certificado",
    c.dni AS "DNI",
    c.nombre AS "Razon Social",
    concat_ws(' '::text, COALESCE(v.nombre, ''::character varying), COALESCE(p.numero, ''::character varying), COALESCE(p.manzana, ''::character varying), COALESCE(p.letra, ''::bpchar)) AS "Direccion de Licencia",
    l.nombre AS "Nombre del Negocio"
   FROM (((lic.lic_licencia l
     LEFT JOIN gen.gen_contribuyente c ON ((l.id_contribuyente = c.id)))
     LEFT JOIN gen.gen_predio p ON ((l.id_predio = p.id)))
     LEFT JOIN gen.gen_via v ON ((p.id_via = v.id)))
  ORDER BY l.id
  WITH NO DATA;


ALTER MATERIALIZED VIEW lic.vw_lic_licencia OWNER TO admin;

--
-- TOC entry 417 (class 1259 OID 40935)
-- Name: vw_lic_motivo_anulacion; Type: MATERIALIZED VIEW; Schema: lic; Owner: admin
--

CREATE MATERIALIZED VIEW lic.vw_lic_motivo_anulacion AS
 SELECT id,
    nombre,
    f_creado,
    h_creado,
    f_modificado,
    h_modificado
   FROM lic.lic_motivo_registro
  WHERE (nombre <> 'INICIO DE ACTIVIDAD'::text)
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW lic.vw_lic_motivo_anulacion OWNER TO admin;

--
-- TOC entry 416 (class 1259 OID 40929)
-- Name: vw_lic_motivo_registro; Type: MATERIALIZED VIEW; Schema: lic; Owner: admin
--

CREATE MATERIALIZED VIEW lic.vw_lic_motivo_registro AS
 SELECT id,
    nombre,
    f_creado,
    h_creado,
    f_modificado,
    h_modificado
   FROM lic.lic_motivo_registro
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW lic.vw_lic_motivo_registro OWNER TO admin;

--
-- TOC entry 423 (class 1259 OID 40971)
-- Name: vw_lic_requisito; Type: MATERIALIZED VIEW; Schema: lic; Owner: admin
--

CREATE MATERIALIZED VIEW lic.vw_lic_requisito AS
 SELECT id,
    nombre,
    f_creado,
    h_creado,
    f_modificado,
    h_modificado
   FROM lic.lic_requisito
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW lic.vw_lic_requisito OWNER TO admin;

--
-- TOC entry 421 (class 1259 OID 40959)
-- Name: vw_lic_tipo_establecimiento; Type: MATERIALIZED VIEW; Schema: lic; Owner: admin
--

CREATE MATERIALIZED VIEW lic.vw_lic_tipo_establecimiento AS
 SELECT id,
    nombre,
    f_creado,
    h_creado,
    f_modificado,
    h_modificado
   FROM lic.lic_tipo_establecimiento
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW lic.vw_lic_tipo_establecimiento OWNER TO admin;

--
-- TOC entry 418 (class 1259 OID 40941)
-- Name: vw_lic_tipo_licencia; Type: MATERIALIZED VIEW; Schema: lic; Owner: admin
--

CREATE MATERIALIZED VIEW lic.vw_lic_tipo_licencia AS
 SELECT id,
    nombre,
    f_creado,
    h_creado,
    f_modificado,
    h_modificado
   FROM lic.lic_tipo_licencia
  ORDER BY id
  WITH NO DATA;


ALTER MATERIALIZED VIEW lic.vw_lic_tipo_licencia OWNER TO admin;

--
-- TOC entry 432 (class 1259 OID 41070)
-- Name: categoria_servicio; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.categoria_servicio (
    id_categoria_servicio integer NOT NULL,
    nombre_categoria character varying(100) NOT NULL,
    descripcion text,
    anio_vigencia integer NOT NULL,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone
);


ALTER TABLE saa.categoria_servicio OWNER TO admin;

--
-- TOC entry 431 (class 1259 OID 41069)
-- Name: categoria_servicio_id_categoria_servicio_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.categoria_servicio_id_categoria_servicio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.categoria_servicio_id_categoria_servicio_seq OWNER TO admin;

--
-- TOC entry 5725 (class 0 OID 0)
-- Dependencies: 431
-- Name: categoria_servicio_id_categoria_servicio_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.categoria_servicio_id_categoria_servicio_seq OWNED BY saa.categoria_servicio.id_categoria_servicio;


--
-- TOC entry 435 (class 1259 OID 41098)
-- Name: configuracion; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.configuracion (
    parametro character varying(50) NOT NULL,
    valor text NOT NULL,
    descripcion text,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone
);


ALTER TABLE saa.configuracion OWNER TO admin;

--
-- TOC entry 439 (class 1259 OID 41129)
-- Name: contrato; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.contrato (
    id_contrato integer NOT NULL,
    numero_contrato character varying(50) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    tipo_cobranza character varying(50),
    observaciones text,
    id_contribuyente integer NOT NULL,
    id_predio integer NOT NULL,
    id_categoria_servicio integer NOT NULL,
    id_estado_servicio integer NOT NULL,
    id_red_agua integer NOT NULL,
    id_zona_afectacion integer NOT NULL,
    diametro_conexion_mm numeric(6,2),
    numero_medidor character varying(50),
    fondo_garantia numeric(10,2),
    penalidad_temporal numeric(10,2),
    esta_exonerado boolean DEFAULT false,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone
);


ALTER TABLE saa.contrato OWNER TO admin;

--
-- TOC entry 5726 (class 0 OID 0)
-- Dependencies: 439
-- Name: COLUMN contrato.id_predio; Type: COMMENT; Schema: saa; Owner: admin
--

COMMENT ON COLUMN saa.contrato.id_predio IS 'Referencia a la PK de la tabla gen.gen_predio ';


--
-- TOC entry 438 (class 1259 OID 41128)
-- Name: contrato_id_contrato_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.contrato_id_contrato_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.contrato_id_contrato_seq OWNER TO admin;

--
-- TOC entry 5727 (class 0 OID 0)
-- Dependencies: 438
-- Name: contrato_id_contrato_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.contrato_id_contrato_seq OWNED BY saa.contrato.id_contrato;


--
-- TOC entry 440 (class 1259 OID 41171)
-- Name: contrato_instalacion_pago; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.contrato_instalacion_pago (
    id_contrato integer NOT NULL,
    forma_pago character varying(20) NOT NULL,
    monto_instalacion numeric(10,2) NOT NULL,
    plazo_meses integer,
    cuota_mensual numeric(10,2),
    numero_cuotas integer,
    interes_porcentaje numeric(5,2),
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone,
    CONSTRAINT contrato_instalacion_pago_cuota_mensual_check CHECK ((cuota_mensual >= (0)::numeric)),
    CONSTRAINT contrato_instalacion_pago_forma_pago_check CHECK (((forma_pago)::text = ANY ((ARRAY['Contado'::character varying, 'Cuotas'::character varying])::text[]))),
    CONSTRAINT contrato_instalacion_pago_interes_porcentaje_check CHECK ((interes_porcentaje >= (0)::numeric)),
    CONSTRAINT contrato_instalacion_pago_monto_instalacion_check CHECK ((monto_instalacion >= (0)::numeric)),
    CONSTRAINT contrato_instalacion_pago_numero_cuotas_check CHECK ((numero_cuotas > 0)),
    CONSTRAINT contrato_instalacion_pago_plazo_meses_check CHECK ((plazo_meses > 0))
);


ALTER TABLE saa.contrato_instalacion_pago OWNER TO admin;

--
-- TOC entry 448 (class 1259 OID 41250)
-- Name: corte_suspension; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.corte_suspension (
    id_corte_suspension integer NOT NULL,
    id_contrato integer NOT NULL,
    tipo character varying(20) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_reposicion date,
    motivo text NOT NULL,
    periodo_deuda_inicio character varying(7),
    periodo_deuda_fin character varying(7),
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone,
    CONSTRAINT corte_suspension_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['Corte'::character varying, 'Suspensión'::character varying])::text[])))
);


ALTER TABLE saa.corte_suspension OWNER TO admin;

--
-- TOC entry 5728 (class 0 OID 0)
-- Dependencies: 448
-- Name: COLUMN corte_suspension.periodo_deuda_inicio; Type: COMMENT; Schema: saa; Owner: admin
--

COMMENT ON COLUMN saa.corte_suspension.periodo_deuda_inicio IS 'Primer mes de deuda que originó el corte (formato YYYY-MM)';


--
-- TOC entry 5729 (class 0 OID 0)
-- Dependencies: 448
-- Name: COLUMN corte_suspension.periodo_deuda_fin; Type: COMMENT; Schema: saa; Owner: admin
--

COMMENT ON COLUMN saa.corte_suspension.periodo_deuda_fin IS 'Último mes de deuda que originó el corte (formato YYYY-MM)';


--
-- TOC entry 447 (class 1259 OID 41249)
-- Name: corte_suspension_id_corte_suspension_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.corte_suspension_id_corte_suspension_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.corte_suspension_id_corte_suspension_seq OWNER TO admin;

--
-- TOC entry 5730 (class 0 OID 0)
-- Dependencies: 447
-- Name: corte_suspension_id_corte_suspension_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.corte_suspension_id_corte_suspension_seq OWNED BY saa.corte_suspension.id_corte_suspension;


--
-- TOC entry 426 (class 1259 OID 41036)
-- Name: estado_servicio; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.estado_servicio (
    id_estado_servicio integer NOT NULL,
    nombre_estado character varying(50) NOT NULL,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone
);


ALTER TABLE saa.estado_servicio OWNER TO admin;

--
-- TOC entry 425 (class 1259 OID 41035)
-- Name: estado_servicio_id_estado_servicio_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.estado_servicio_id_estado_servicio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.estado_servicio_id_estado_servicio_seq OWNER TO admin;

--
-- TOC entry 5731 (class 0 OID 0)
-- Dependencies: 425
-- Name: estado_servicio_id_estado_servicio_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.estado_servicio_id_estado_servicio_seq OWNED BY saa.estado_servicio.id_estado_servicio;


--
-- TOC entry 452 (class 1259 OID 41281)
-- Name: informe_mantenimiento; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.informe_mantenimiento (
    id_informe integer NOT NULL,
    id_contrato integer NOT NULL,
    fecha_informe date DEFAULT CURRENT_DATE NOT NULL,
    descripcion text NOT NULL,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone
);


ALTER TABLE saa.informe_mantenimiento OWNER TO admin;

--
-- TOC entry 451 (class 1259 OID 41280)
-- Name: informe_mantenimiento_id_informe_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.informe_mantenimiento_id_informe_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.informe_mantenimiento_id_informe_seq OWNER TO admin;

--
-- TOC entry 5732 (class 0 OID 0)
-- Dependencies: 451
-- Name: informe_mantenimiento_id_informe_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.informe_mantenimiento_id_informe_seq OWNED BY saa.informe_mantenimiento.id_informe;


--
-- TOC entry 450 (class 1259 OID 41266)
-- Name: omision_servicio; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.omision_servicio (
    id_omision integer NOT NULL,
    id_contrato integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    mes_anio_inicio character varying(7) NOT NULL,
    mes_anio_fin character varying(7),
    numero_documento_sustento character varying(50) NOT NULL,
    fecha_sustento date NOT NULL,
    detalle_sustento text NOT NULL,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone
);


ALTER TABLE saa.omision_servicio OWNER TO admin;

--
-- TOC entry 5733 (class 0 OID 0)
-- Dependencies: 450
-- Name: COLUMN omision_servicio.mes_anio_inicio; Type: COMMENT; Schema: saa; Owner: admin
--

COMMENT ON COLUMN saa.omision_servicio.mes_anio_inicio IS 'Primer periodo (YYYY-MM) afectado por la omisión';


--
-- TOC entry 5734 (class 0 OID 0)
-- Dependencies: 450
-- Name: COLUMN omision_servicio.mes_anio_fin; Type: COMMENT; Schema: saa; Owner: admin
--

COMMENT ON COLUMN saa.omision_servicio.mes_anio_fin IS 'Último periodo (YYYY-MM) afectado por la omisión (si aplica)';


--
-- TOC entry 449 (class 1259 OID 41265)
-- Name: omision_servicio_id_omision_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.omision_servicio_id_omision_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.omision_servicio_id_omision_seq OWNER TO admin;

--
-- TOC entry 5735 (class 0 OID 0)
-- Dependencies: 449
-- Name: omision_servicio_id_omision_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.omision_servicio_id_omision_seq OWNED BY saa.omision_servicio.id_omision;


--
-- TOC entry 446 (class 1259 OID 41231)
-- Name: pago; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.pago (
    id_pago integer NOT NULL,
    id_recibo integer NOT NULL,
    id_pago_caja integer NOT NULL,
    fecha_pago timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    monto_pagado numeric(10,2) NOT NULL,
    usuario_creacion character varying(50) NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone,
    CONSTRAINT pago_monto_pagado_check CHECK ((monto_pagado > (0)::numeric))
);


ALTER TABLE saa.pago OWNER TO admin;

--
-- TOC entry 5736 (class 0 OID 0)
-- Dependencies: 446
-- Name: COLUMN pago.id_pago_caja; Type: COMMENT; Schema: saa; Owner: admin
--

COMMENT ON COLUMN saa.pago.id_pago_caja IS 'Referencia a la PK de la tabla caj.pago (Módulo Caja)';


--
-- TOC entry 445 (class 1259 OID 41230)
-- Name: pago_id_pago_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.pago_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.pago_id_pago_seq OWNER TO admin;

--
-- TOC entry 5737 (class 0 OID 0)
-- Dependencies: 445
-- Name: pago_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.pago_id_pago_seq OWNED BY saa.pago.id_pago;


--
-- TOC entry 444 (class 1259 OID 41203)
-- Name: recibo; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.recibo (
    id_recibo integer NOT NULL,
    id_contrato integer NOT NULL,
    anio integer NOT NULL,
    mes integer NOT NULL,
    monto_consumo numeric(10,2) NOT NULL,
    id_sustento_descuento integer,
    lectura_anterior numeric(10,2) DEFAULT 0,
    lectura_actual numeric(10,2) DEFAULT 0,
    consumo_m3 numeric(10,2) GENERATED ALWAYS AS ((lectura_actual - lectura_anterior)) STORED,
    monto_total numeric(10,2) NOT NULL,
    estado_pago character varying(20) DEFAULT 'Pendiente'::character varying NOT NULL,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone,
    CONSTRAINT recibo_estado_pago_check CHECK (((estado_pago)::text = ANY ((ARRAY['Pendiente'::character varying, 'Pagado'::character varying, 'Vencido'::character varying, 'Anulado'::character varying])::text[]))),
    CONSTRAINT recibo_mes_check CHECK (((mes >= 1) AND (mes <= 12))),
    CONSTRAINT recibo_monto_consumo_check CHECK ((monto_consumo >= (0)::numeric)),
    CONSTRAINT recibo_monto_total_check CHECK ((monto_total >= (0)::numeric))
);


ALTER TABLE saa.recibo OWNER TO admin;

--
-- TOC entry 5738 (class 0 OID 0)
-- Dependencies: 444
-- Name: COLUMN recibo.monto_total; Type: COMMENT; Schema: saa; Owner: admin
--

COMMENT ON COLUMN saa.recibo.monto_total IS 'Monto final a pagar, considerando descuentos si id_sustento_descuento no es nulo.';


--
-- TOC entry 443 (class 1259 OID 41202)
-- Name: recibo_id_recibo_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.recibo_id_recibo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.recibo_id_recibo_seq OWNER TO admin;

--
-- TOC entry 5739 (class 0 OID 0)
-- Dependencies: 443
-- Name: recibo_id_recibo_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.recibo_id_recibo_seq OWNED BY saa.recibo.id_recibo;


--
-- TOC entry 428 (class 1259 OID 41046)
-- Name: red_agua; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.red_agua (
    id_red_agua integer NOT NULL,
    nombre_red character varying(100) NOT NULL,
    descripcion text,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone
);


ALTER TABLE saa.red_agua OWNER TO admin;

--
-- TOC entry 427 (class 1259 OID 41045)
-- Name: red_agua_id_red_agua_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.red_agua_id_red_agua_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.red_agua_id_red_agua_seq OWNER TO admin;

--
-- TOC entry 5740 (class 0 OID 0)
-- Dependencies: 427
-- Name: red_agua_id_red_agua_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.red_agua_id_red_agua_seq OWNED BY saa.red_agua.id_red_agua;


--
-- TOC entry 442 (class 1259 OID 41189)
-- Name: sustento_descuento; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.sustento_descuento (
    id_sustento_descuento integer NOT NULL,
    numero_documento character varying(50) NOT NULL,
    fecha_documento date NOT NULL,
    detalle_sustento text NOT NULL,
    porcentaje_descuento numeric(5,2) NOT NULL,
    monto_fijo_descuento numeric(10,2),
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone,
    CONSTRAINT sustento_descuento_monto_fijo_descuento_check CHECK ((monto_fijo_descuento >= (0)::numeric)),
    CONSTRAINT sustento_descuento_porcentaje_descuento_check CHECK (((porcentaje_descuento >= (0)::numeric) AND (porcentaje_descuento <= (100)::numeric)))
);


ALTER TABLE saa.sustento_descuento OWNER TO admin;

--
-- TOC entry 441 (class 1259 OID 41188)
-- Name: sustento_descuento_id_sustento_descuento_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.sustento_descuento_id_sustento_descuento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.sustento_descuento_id_sustento_descuento_seq OWNER TO admin;

--
-- TOC entry 5741 (class 0 OID 0)
-- Dependencies: 441
-- Name: sustento_descuento_id_sustento_descuento_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.sustento_descuento_id_sustento_descuento_seq OWNED BY saa.sustento_descuento.id_sustento_descuento;


--
-- TOC entry 434 (class 1259 OID 41082)
-- Name: tarifa; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.tarifa (
    id_tarifa integer NOT NULL,
    id_categoria_servicio integer NOT NULL,
    anio integer NOT NULL,
    mes integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone,
    CONSTRAINT tarifa_mes_check CHECK (((mes >= 1) AND (mes <= 12))),
    CONSTRAINT tarifa_monto_check CHECK ((monto >= (0)::numeric))
);


ALTER TABLE saa.tarifa OWNER TO admin;

--
-- TOC entry 433 (class 1259 OID 41081)
-- Name: tarifa_id_tarifa_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.tarifa_id_tarifa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.tarifa_id_tarifa_seq OWNER TO admin;

--
-- TOC entry 5742 (class 0 OID 0)
-- Dependencies: 433
-- Name: tarifa_id_tarifa_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.tarifa_id_tarifa_seq OWNED BY saa.tarifa.id_tarifa;


--
-- TOC entry 437 (class 1259 OID 41113)
-- Name: usuario; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.usuario (
    id_contribuyente integer NOT NULL,
    codigo_usuario_saa character varying(20) NOT NULL,
    estado_usuario character varying(20) DEFAULT 'Activo'::character varying NOT NULL,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone,
    CONSTRAINT usuario_estado_usuario_check CHECK (((estado_usuario)::text = ANY ((ARRAY['Activo'::character varying, 'Inactivo'::character varying])::text[])))
);


ALTER TABLE saa.usuario OWNER TO admin;

--
-- TOC entry 5743 (class 0 OID 0)
-- Dependencies: 437
-- Name: COLUMN usuario.id_contribuyente; Type: COMMENT; Schema: saa; Owner: admin
--

COMMENT ON COLUMN saa.usuario.id_contribuyente IS 'Referencia a la PK de la tabla general gen.gen_contribuyente ';


--
-- TOC entry 436 (class 1259 OID 41106)
-- Name: vencimiento_parametro_anual; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.vencimiento_parametro_anual (
    anio integer NOT NULL,
    mes integer NOT NULL,
    fecha_vencimiento date NOT NULL,
    factor_ipm numeric(8,6),
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone,
    CONSTRAINT vencimiento_parametro_anual_mes_check CHECK (((mes >= 1) AND (mes <= 12)))
);


ALTER TABLE saa.vencimiento_parametro_anual OWNER TO admin;

--
-- TOC entry 430 (class 1259 OID 41058)
-- Name: zona_afectacion; Type: TABLE; Schema: saa; Owner: admin
--

CREATE TABLE saa.zona_afectacion (
    id_zona_afectacion integer NOT NULL,
    nombre_zona character varying(100) NOT NULL,
    descripcion text,
    usuario_creacion character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    usuario_modificacion character varying(50),
    fecha_modificacion timestamp with time zone
);


ALTER TABLE saa.zona_afectacion OWNER TO admin;

--
-- TOC entry 429 (class 1259 OID 41057)
-- Name: zona_afectacion_id_zona_afectacion_seq; Type: SEQUENCE; Schema: saa; Owner: admin
--

CREATE SEQUENCE saa.zona_afectacion_id_zona_afectacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE saa.zona_afectacion_id_zona_afectacion_seq OWNER TO admin;

--
-- TOC entry 5744 (class 0 OID 0)
-- Dependencies: 429
-- Name: zona_afectacion_id_zona_afectacion_seq; Type: SEQUENCE OWNED BY; Schema: saa; Owner: admin
--

ALTER SEQUENCE saa.zona_afectacion_id_zona_afectacion_seq OWNED BY saa.zona_afectacion.id_zona_afectacion;


--
-- TOC entry 4466 (class 2604 OID 42037)
-- Name: alc_contrato_alcabala id; Type: DEFAULT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_contrato_alcabala ALTER COLUMN id SET DEFAULT nextval('alc.alc_contrato_alcabala_id_seq'::regclass);


--
-- TOC entry 4461 (class 2604 OID 42020)
-- Name: alc_entidad_inafecta id; Type: DEFAULT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_entidad_inafecta ALTER COLUMN id SET DEFAULT nextval('alc.alc_entidad_inafecta_id_seq'::regclass);


--
-- TOC entry 4470 (class 2604 OID 42074)
-- Name: alc_estado_contrato id; Type: DEFAULT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_estado_contrato ALTER COLUMN id SET DEFAULT nextval('alc.alc_estado_contrato_id_seq'::regclass);


--
-- TOC entry 4463 (class 2604 OID 42028)
-- Name: alc_factor_calculo id; Type: DEFAULT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_factor_calculo ALTER COLUMN id SET DEFAULT nextval('alc.alc_factor_calculo_id_seq'::regclass);


--
-- TOC entry 4430 (class 2604 OID 41827)
-- Name: arbitrio id_arbitrio; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio ALTER COLUMN id_arbitrio SET DEFAULT nextval('arb.arbitrio_id_arbitrio_seq'::regclass);


--
-- TOC entry 4433 (class 2604 OID 41853)
-- Name: arbitrio_detalle id_arbitrio_detalle; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio_detalle ALTER COLUMN id_arbitrio_detalle SET DEFAULT nextval('arb.arbitrio_detalle_id_arbitrio_detalle_seq'::regclass);


--
-- TOC entry 4426 (class 2604 OID 41806)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('arb.categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4459 (class 2604 OID 41999)
-- Name: categoria_tributo id_categoria_tributo; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.categoria_tributo ALTER COLUMN id_categoria_tributo SET DEFAULT nextval('arb.categoria_tributo_id_categoria_tributo_seq'::regclass);


--
-- TOC entry 4438 (class 2604 OID 41914)
-- Name: determina_calculo id_determina_calculo; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.determina_calculo ALTER COLUMN id_determina_calculo SET DEFAULT nextval('arb.determina_calculo_id_determina_calculo_seq'::regclass);


--
-- TOC entry 4424 (class 2604 OID 41798)
-- Name: grupo_categoria id_grupo_categoria; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.grupo_categoria ALTER COLUMN id_grupo_categoria SET DEFAULT nextval('arb.grupo_categoria_id_grupo_categoria_seq'::regclass);


--
-- TOC entry 4435 (class 2604 OID 41886)
-- Name: licencia_funcionamiento id_licencia; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.licencia_funcionamiento ALTER COLUMN id_licencia SET DEFAULT nextval('arb.licencia_funcionamiento_id_licencia_seq'::regclass);


--
-- TOC entry 4449 (class 2604 OID 41957)
-- Name: tarifa_area_construida id_tarifa_area_construida; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_area_construida ALTER COLUMN id_tarifa_area_construida SET DEFAULT nextval('arb.tarifa_area_construida_id_tarifa_area_construida_seq'::regclass);


--
-- TOC entry 4454 (class 2604 OID 41978)
-- Name: tarifa_area_terreno id_tarifa_area_terreno; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_area_terreno ALTER COLUMN id_tarifa_area_terreno SET DEFAULT nextval('arb.tarifa_area_terreno_id_tarifa_area_terreno_seq'::regclass);


--
-- TOC entry 4440 (class 2604 OID 41922)
-- Name: tarifa_categoria id_tarifa_categoria; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_categoria ALTER COLUMN id_tarifa_categoria SET DEFAULT nextval('arb.tarifa_categoria_id_tarifa_categoria_seq'::regclass);


--
-- TOC entry 4422 (class 2604 OID 41785)
-- Name: tipo_beneficio id_tipo_beneficio; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tipo_beneficio ALTER COLUMN id_tipo_beneficio SET DEFAULT nextval('arb.tipo_beneficio_id_tipo_beneficio_seq'::regclass);


--
-- TOC entry 4428 (class 2604 OID 41819)
-- Name: tipo_registro_origen id_tipo_registro_origen; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tipo_registro_origen ALTER COLUMN id_tipo_registro_origen SET DEFAULT nextval('arb.tipo_registro_origen_id_tipo_registro_origen_seq'::regclass);


--
-- TOC entry 4420 (class 2604 OID 41777)
-- Name: tributo id_tributo; Type: DEFAULT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tributo ALTER COLUMN id_tributo SET DEFAULT nextval('arb.tributo_id_tributo_seq'::regclass);


--
-- TOC entry 4199 (class 2604 OID 36703)
-- Name: apertura_cobranza id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.apertura_cobranza ALTER COLUMN id SET DEFAULT nextval('caj.apertura_cobranza_id_seq'::regclass);


--
-- TOC entry 4202 (class 2604 OID 36704)
-- Name: auditoria id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.auditoria ALTER COLUMN id SET DEFAULT nextval('caj.auditoria_id_seq'::regclass);


--
-- TOC entry 4205 (class 2604 OID 36705)
-- Name: cajero id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.cajero ALTER COLUMN id SET DEFAULT nextval('caj.cajero_id_seq'::regclass);


--
-- TOC entry 4207 (class 2604 OID 36706)
-- Name: cierre_caja id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.cierre_caja ALTER COLUMN id SET DEFAULT nextval('caj.cierre_caja_id_seq'::regclass);


--
-- TOC entry 4212 (class 2604 OID 36707)
-- Name: concepto_pago id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.concepto_pago ALTER COLUMN id SET DEFAULT nextval('caj.concepto_pago_id_seq'::regclass);


--
-- TOC entry 4213 (class 2604 OID 36708)
-- Name: extorno id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.extorno ALTER COLUMN id SET DEFAULT nextval('caj.extorno_id_seq'::regclass);


--
-- TOC entry 4216 (class 2604 OID 36709)
-- Name: pago id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.pago ALTER COLUMN id SET DEFAULT nextval('caj.pago_id_seq'::regclass);


--
-- TOC entry 4218 (class 2604 OID 36710)
-- Name: pago_detalle id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.pago_detalle ALTER COLUMN id SET DEFAULT nextval('caj.pago_detalle_id_seq'::regclass);


--
-- TOC entry 4220 (class 2604 OID 36711)
-- Name: recibo id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.recibo ALTER COLUMN id SET DEFAULT nextval('caj.recibo_id_seq'::regclass);


--
-- TOC entry 4223 (class 2604 OID 36712)
-- Name: tipo_pago id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.tipo_pago ALTER COLUMN id SET DEFAULT nextval('caj.tipo_pago_id_seq'::regclass);


--
-- TOC entry 4224 (class 2604 OID 36713)
-- Name: usuario id; Type: DEFAULT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.usuario ALTER COLUMN id SET DEFAULT nextval('caj.usuario_id_seq'::regclass);


--
-- TOC entry 4416 (class 2604 OID 41512)
-- Name: fis_acta_inspección id_acta; Type: DEFAULT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis."fis_acta_inspección" ALTER COLUMN id_acta SET DEFAULT nextval('fis."fis_acta_inspección_id_acta_seq"'::regclass);


--
-- TOC entry 4414 (class 2604 OID 41409)
-- Name: fis_fiscalizacion id_fiscalizacion; Type: DEFAULT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_fiscalizacion ALTER COLUMN id_fiscalizacion SET DEFAULT nextval('fis.fis_fiscalizacion_id_fiscalizacion_seq'::regclass);


--
-- TOC entry 4417 (class 2604 OID 41526)
-- Name: fis_liquidacion id_liquidacion; Type: DEFAULT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_liquidacion ALTER COLUMN id_liquidacion SET DEFAULT nextval('fis.fis_liquidacion_id_liquidacion_seq'::regclass);


--
-- TOC entry 4419 (class 2604 OID 41554)
-- Name: fis_multa id_multa; Type: DEFAULT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_multa ALTER COLUMN id_multa SET DEFAULT nextval('fis.fis_multa_id_multa_seq'::regclass);


--
-- TOC entry 4415 (class 2604 OID 41498)
-- Name: fis_requerimiento id_requerimiento; Type: DEFAULT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_requerimiento ALTER COLUMN id_requerimiento SET DEFAULT nextval('fis.fis_requerimiento_id_requerimiento_seq'::regclass);


--
-- TOC entry 4418 (class 2604 OID 41540)
-- Name: fis_resolucion id_resolucion; Type: DEFAULT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_resolucion ALTER COLUMN id_resolucion SET DEFAULT nextval('fis.fis_resolucion_id_resolucion_seq'::regclass);


--
-- TOC entry 4311 (class 2604 OID 40529)
-- Name: gen_contribuyente id; Type: DEFAULT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_contribuyente ALTER COLUMN id SET DEFAULT nextval('gen.gen_contribuyente_id_seq'::regclass);


--
-- TOC entry 4277 (class 2604 OID 40380)
-- Name: gen_departamento id; Type: DEFAULT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_departamento ALTER COLUMN id SET DEFAULT nextval('gen.gen_departamento_id_seq'::regclass);


--
-- TOC entry 4285 (class 2604 OID 40409)
-- Name: gen_distrito id; Type: DEFAULT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_distrito ALTER COLUMN id SET DEFAULT nextval('gen.gen_distrito_id_seq'::regclass);


--
-- TOC entry 4413 (class 2604 OID 41324)
-- Name: gen_funcionario id; Type: DEFAULT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_funcionario ALTER COLUMN id SET DEFAULT nextval('gen.gen_funcionario_id_seq'::regclass);


--
-- TOC entry 4316 (class 2604 OID 40556)
-- Name: gen_predio id; Type: DEFAULT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_predio ALTER COLUMN id SET DEFAULT nextval('gen.gen_predio_id_seq'::regclass);


--
-- TOC entry 4281 (class 2604 OID 40392)
-- Name: gen_provincia id; Type: DEFAULT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_provincia ALTER COLUMN id SET DEFAULT nextval('gen.gen_provincia_id_seq'::regclass);


--
-- TOC entry 4301 (class 2604 OID 40470)
-- Name: gen_tipo_habilitacion_urbana id; Type: DEFAULT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_tipo_habilitacion_urbana ALTER COLUMN id SET DEFAULT nextval('gen.gen_tipo_habilitacion_urbana_id_seq'::regclass);


--
-- TOC entry 4296 (class 2604 OID 40457)
-- Name: gen_tipo_interior id; Type: DEFAULT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_tipo_interior ALTER COLUMN id SET DEFAULT nextval('gen.gen_tipo_interior_id_seq'::regclass);


--
-- TOC entry 4292 (class 2604 OID 40445)
-- Name: gen_tipo_via id; Type: DEFAULT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_tipo_via ALTER COLUMN id SET DEFAULT nextval('gen.gen_tipo_via_id_seq'::regclass);


--
-- TOC entry 4249 (class 2604 OID 38974)
-- Name: imp_arancel_urbano id_arancel_urbano; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_arancel_urbano ALTER COLUMN id_arancel_urbano SET DEFAULT nextval('imp.imp_arancel_urbano_id_arancel_urbano_seq'::regclass);


--
-- TOC entry 4270 (class 2604 OID 39320)
-- Name: imp_area_rustica id_area_rustica; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_area_rustica ALTER COLUMN id_area_rustica SET DEFAULT nextval('imp.imp_area_rustica_id_area_rustica_seq'::regclass);


--
-- TOC entry 4231 (class 2604 OID 38800)
-- Name: imp_asociacion id_asociacion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_asociacion ALTER COLUMN id_asociacion SET DEFAULT nextval('imp.imp_asociacion_id_asociacion_seq'::regclass);


--
-- TOC entry 4247 (class 2604 OID 38958)
-- Name: imp_categoria_terreno id_categoria_terreno; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_categoria_terreno ALTER COLUMN id_categoria_terreno SET DEFAULT nextval('imp.imp_categoria_terreno_id_categoria_terreno_seq'::regclass);


--
-- TOC entry 4245 (class 2604 OID 38944)
-- Name: imp_categoria_terreno_ext id_categoria_terreno_ext; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_categoria_terreno_ext ALTER COLUMN id_categoria_terreno_ext SET DEFAULT nextval('imp.imp_categoria_terreno_ext_id_categoria_terreno_ext_seq'::regclass);


--
-- TOC entry 4244 (class 2604 OID 38937)
-- Name: imp_clasificacion_terreno id_clasificacion_terreno; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_clasificacion_terreno ALTER COLUMN id_clasificacion_terreno SET DEFAULT nextval('imp.imp_clasificacion_terreno_id_clasificacion_terreno_seq'::regclass);


--
-- TOC entry 4275 (class 2604 OID 39366)
-- Name: imp_cuenta_corriente id_movimiento; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_cuenta_corriente ALTER COLUMN id_movimiento SET DEFAULT nextval('imp.imp_cuenta_corriente_id_movimiento_seq'::regclass);


--
-- TOC entry 4262 (class 2604 OID 39149)
-- Name: imp_declaracion_jurada id_declaracion_jurada; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_declaracion_jurada ALTER COLUMN id_declaracion_jurada SET DEFAULT nextval('imp.imp_declaracion_jurada_id_declaracion_jurada_seq'::regclass);


--
-- TOC entry 4225 (class 2604 OID 38729)
-- Name: imp_departamento id_departamento; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_departamento ALTER COLUMN id_departamento SET DEFAULT nextval('imp.imp_departamento_id_departamento_seq'::regclass);


--
-- TOC entry 4255 (class 2604 OID 39053)
-- Name: imp_depreciacion id_depreciacion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_depreciacion ALTER COLUMN id_depreciacion SET DEFAULT nextval('imp.imp_depreciacion_id_depreciacion_seq'::regclass);


--
-- TOC entry 4227 (class 2604 OID 38748)
-- Name: imp_distrito id_distrito; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_distrito ALTER COLUMN id_distrito SET DEFAULT nextval('imp.imp_distrito_id_distrito_seq'::regclass);


--
-- TOC entry 4263 (class 2604 OID 39168)
-- Name: imp_dj_predio id_dj_predio; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_dj_predio ALTER COLUMN id_dj_predio SET DEFAULT nextval('imp.imp_dj_predio_id_dj_predio_seq'::regclass);


--
-- TOC entry 4236 (class 2604 OID 38857)
-- Name: imp_domicilio_fiscal_contribuyente id_domicilio; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_domicilio_fiscal_contribuyente ALTER COLUMN id_domicilio SET DEFAULT nextval('imp.imp_domicilio_fiscal_contribuyente_id_domicilio_seq'::regclass);


--
-- TOC entry 4252 (class 2604 OID 39001)
-- Name: imp_escala_impuesto id_escala_impuesto; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_escala_impuesto ALTER COLUMN id_escala_impuesto SET DEFAULT nextval('imp.imp_escala_impuesto_id_escala_impuesto_seq'::regclass);


--
-- TOC entry 4248 (class 2604 OID 38965)
-- Name: imp_estado_conservacion id_estado_conservacion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_estado_conservacion ALTER COLUMN id_estado_conservacion SET DEFAULT nextval('imp.imp_estado_conservacion_id_estado_conservacion_seq'::regclass);


--
-- TOC entry 4256 (class 2604 OID 39062)
-- Name: imp_exoneracion id_exoneracion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_exoneracion ALTER COLUMN id_exoneracion SET DEFAULT nextval('imp.imp_exoneracion_id_exoneracion_seq'::regclass);


--
-- TOC entry 4246 (class 2604 OID 38951)
-- Name: imp_grupo_tierra id_grupo_tierra; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_grupo_tierra ALTER COLUMN id_grupo_tierra SET DEFAULT nextval('imp.imp_grupo_tierra_id_grupo_tierra_seq'::regclass);


--
-- TOC entry 4269 (class 2604 OID 39308)
-- Name: imp_grupo_tierra_detalle id_grupo_tierra_detalle; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_grupo_tierra_detalle ALTER COLUMN id_grupo_tierra_detalle SET DEFAULT nextval('imp.imp_grupo_tierra_detalle_id_grupo_tierra_detalle_seq'::regclass);


--
-- TOC entry 4230 (class 2604 OID 38781)
-- Name: imp_habilitacion_urbana id_habilitacion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_habilitacion_urbana ALTER COLUMN id_habilitacion SET DEFAULT nextval('imp.imp_habilitacion_urbana_id_habilitacion_seq'::regclass);


--
-- TOC entry 4260 (class 2604 OID 39097)
-- Name: imp_junta_vecinal id_junta_vecinal; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_junta_vecinal ALTER COLUMN id_junta_vecinal SET DEFAULT nextval('imp.imp_junta_vecinal_id_junta_vecinal_seq'::regclass);


--
-- TOC entry 4241 (class 2604 OID 38918)
-- Name: imp_material_estructural_predio id_material_estructural_predio; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_material_estructural_predio ALTER COLUMN id_material_estructural_predio SET DEFAULT nextval('imp.imp_material_estructural_pred_id_material_estructural_predi_seq'::regclass);


--
-- TOC entry 4242 (class 2604 OID 38927)
-- Name: imp_motivo_dj id_motivo_dj; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_motivo_dj ALTER COLUMN id_motivo_dj SET DEFAULT nextval('imp.imp_motivo_dj_id_motivo_dj_seq'::regclass);


--
-- TOC entry 4271 (class 2604 OID 39337)
-- Name: imp_pago id_pago; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_pago ALTER COLUMN id_pago SET DEFAULT nextval('imp.imp_pago_id_pago_seq'::regclass);


--
-- TOC entry 4274 (class 2604 OID 39357)
-- Name: imp_param_moratorio id_param_moratorio; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_param_moratorio ALTER COLUMN id_param_moratorio SET DEFAULT nextval('imp.imp_param_moratorio_id_param_moratorio_seq'::regclass);


--
-- TOC entry 4251 (class 2604 OID 38990)
-- Name: imp_param_principales id_param_principal; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_param_principales ALTER COLUMN id_param_principal SET DEFAULT nextval('imp.imp_param_principales_id_param_principal_seq'::regclass);


--
-- TOC entry 4261 (class 2604 OID 39104)
-- Name: imp_predio id_predio; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio ALTER COLUMN id_predio SET DEFAULT nextval('imp.imp_predio_id_predio_seq'::regclass);


--
-- TOC entry 4265 (class 2604 OID 39208)
-- Name: imp_predio_colindante id_predio_colindante; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_colindante ALTER COLUMN id_predio_colindante SET DEFAULT nextval('imp.imp_predio_colindante_id_predio_colindante_seq'::regclass);


--
-- TOC entry 4266 (class 2604 OID 39222)
-- Name: imp_predio_construccion id_predio_construccion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_construccion ALTER COLUMN id_predio_construccion SET DEFAULT nextval('imp.imp_predio_construccion_id_predio_construccion_seq'::regclass);


--
-- TOC entry 4268 (class 2604 OID 39276)
-- Name: imp_predio_otra_instalacion id_predio_otra_instalacion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_otra_instalacion ALTER COLUMN id_predio_otra_instalacion SET DEFAULT nextval('imp.imp_predio_otra_instalacion_id_predio_otra_instalacion_seq'::regclass);


--
-- TOC entry 4267 (class 2604 OID 39254)
-- Name: imp_predio_terreno id_predio_terreno; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_terreno ALTER COLUMN id_predio_terreno SET DEFAULT nextval('imp.imp_predio_terreno_id_predio_terreno_seq'::regclass);


--
-- TOC entry 4226 (class 2604 OID 38736)
-- Name: imp_provincia id_provincia; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_provincia ALTER COLUMN id_provincia SET DEFAULT nextval('imp.imp_provincia_id_provincia_seq'::regclass);


--
-- TOC entry 4228 (class 2604 OID 38760)
-- Name: imp_sector id_sector; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_sector ALTER COLUMN id_sector SET DEFAULT nextval('imp.imp_sector_id_sector_seq'::regclass);


--
-- TOC entry 4229 (class 2604 OID 38774)
-- Name: imp_tipo_habilitacion_urbana id_tipo_habilitacion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_tipo_habilitacion_urbana ALTER COLUMN id_tipo_habilitacion SET DEFAULT nextval('imp.imp_tipo_habilitacion_urbana_id_tipo_habilitacion_seq'::regclass);


--
-- TOC entry 4235 (class 2604 OID 38848)
-- Name: imp_tipo_interior id_tipo_interior; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_tipo_interior ALTER COLUMN id_tipo_interior SET DEFAULT nextval('imp.imp_tipo_interior_id_tipo_interior_seq'::regclass);


--
-- TOC entry 4239 (class 2604 OID 38910)
-- Name: imp_tipo_registro_predio id_tipo_registro_predio; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_tipo_registro_predio ALTER COLUMN id_tipo_registro_predio SET DEFAULT nextval('imp.imp_tipo_registro_predio_id_tipo_registro_predio_seq'::regclass);


--
-- TOC entry 4232 (class 2604 OID 38814)
-- Name: imp_tipo_via id_tipo_via; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_tipo_via ALTER COLUMN id_tipo_via SET DEFAULT nextval('imp.imp_tipo_via_id_tipo_via_seq'::regclass);


--
-- TOC entry 4250 (class 2604 OID 38983)
-- Name: imp_uso_predio id_uso; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_uso_predio ALTER COLUMN id_uso SET DEFAULT nextval('imp.imp_uso_predio_id_uso_seq'::regclass);


--
-- TOC entry 4258 (class 2604 OID 39072)
-- Name: imp_valor_exoneracion id_valor_exoneracion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_exoneracion ALTER COLUMN id_valor_exoneracion SET DEFAULT nextval('imp.imp_valor_exoneracion_id_valor_exoneracion_seq'::regclass);


--
-- TOC entry 4253 (class 2604 OID 39017)
-- Name: imp_valor_unitario_edificacion id_valor_unitario_edificacion; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_unitario_edificacion ALTER COLUMN id_valor_unitario_edificacion SET DEFAULT nextval('imp.imp_valor_unitario_edificacio_id_valor_unitario_edificacion_seq'::regclass);


--
-- TOC entry 4254 (class 2604 OID 39039)
-- Name: imp_valor_unitario_obra id_valor_unitario_obra; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_unitario_obra ALTER COLUMN id_valor_unitario_obra SET DEFAULT nextval('imp.imp_valor_unitario_obra_id_valor_unitario_obra_seq'::regclass);


--
-- TOC entry 4259 (class 2604 OID 39086)
-- Name: imp_vencimiento_emision id_vencimiento_emision; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_vencimiento_emision ALTER COLUMN id_vencimiento_emision SET DEFAULT nextval('imp.imp_vencimiento_emision_id_vencimiento_emision_seq'::regclass);


--
-- TOC entry 4233 (class 2604 OID 38821)
-- Name: imp_via id_via; Type: DEFAULT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_via ALTER COLUMN id_via SET DEFAULT nextval('imp.imp_via_id_via_seq'::regclass);


--
-- TOC entry 4337 (class 2604 OID 40735)
-- Name: lic_actividad_comercial id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_actividad_comercial ALTER COLUMN id SET DEFAULT nextval('lic.lic_actividad_comercial_id_seq'::regclass);


--
-- TOC entry 4332 (class 2604 OID 40720)
-- Name: lic_condicion_local id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_condicion_local ALTER COLUMN id SET DEFAULT nextval('lic.lic_condicion_local_id_seq'::regclass);


--
-- TOC entry 4362 (class 2604 OID 40815)
-- Name: lic_documento id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_documento ALTER COLUMN id SET DEFAULT nextval('lic.lic_documento_id_seq'::regclass);


--
-- TOC entry 4357 (class 2604 OID 40796)
-- Name: lic_giro_licencia id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_giro_licencia ALTER COLUMN id SET DEFAULT nextval('lic.lic_giro_licencia_id_seq'::regclass);


--
-- TOC entry 4347 (class 2604 OID 40765)
-- Name: lic_giro_negocio id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_giro_negocio ALTER COLUMN id SET DEFAULT nextval('lic.lic_giro_negocio_id_seq'::regclass);


--
-- TOC entry 4367 (class 2604 OID 40833)
-- Name: lic_licencia id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia ALTER COLUMN id SET DEFAULT nextval('lic.lic_licencia_id_seq'::regclass);


--
-- TOC entry 4322 (class 2604 OID 40690)
-- Name: lic_motivo_registro id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_motivo_registro ALTER COLUMN id SET DEFAULT nextval('lic.lic_motivo_registro_id_seq'::regclass);


--
-- TOC entry 4352 (class 2604 OID 40781)
-- Name: lic_requisito id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_requisito ALTER COLUMN id SET DEFAULT nextval('lic.lic_requisito_id_seq'::regclass);


--
-- TOC entry 4373 (class 2604 OID 40902)
-- Name: lic_sust_anulacion id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_sust_anulacion ALTER COLUMN id SET DEFAULT nextval('lic.lic_sust_anulacion_id_seq'::regclass);


--
-- TOC entry 4342 (class 2604 OID 40750)
-- Name: lic_tipo_establecimiento id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_tipo_establecimiento ALTER COLUMN id SET DEFAULT nextval('lic.lic_tipo_establecimiento_id_seq'::regclass);


--
-- TOC entry 4327 (class 2604 OID 40705)
-- Name: lic_tipo_licencia id; Type: DEFAULT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_tipo_licencia ALTER COLUMN id SET DEFAULT nextval('lic.lic_tipo_licencia_id_seq'::regclass);


--
-- TOC entry 4384 (class 2604 OID 41073)
-- Name: categoria_servicio id_categoria_servicio; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.categoria_servicio ALTER COLUMN id_categoria_servicio SET DEFAULT nextval('saa.categoria_servicio_id_categoria_servicio_seq'::regclass);


--
-- TOC entry 4392 (class 2604 OID 41132)
-- Name: contrato id_contrato; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato ALTER COLUMN id_contrato SET DEFAULT nextval('saa.contrato_id_contrato_seq'::regclass);


--
-- TOC entry 4406 (class 2604 OID 41253)
-- Name: corte_suspension id_corte_suspension; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.corte_suspension ALTER COLUMN id_corte_suspension SET DEFAULT nextval('saa.corte_suspension_id_corte_suspension_seq'::regclass);


--
-- TOC entry 4378 (class 2604 OID 41039)
-- Name: estado_servicio id_estado_servicio; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.estado_servicio ALTER COLUMN id_estado_servicio SET DEFAULT nextval('saa.estado_servicio_id_estado_servicio_seq'::regclass);


--
-- TOC entry 4410 (class 2604 OID 41284)
-- Name: informe_mantenimiento id_informe; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.informe_mantenimiento ALTER COLUMN id_informe SET DEFAULT nextval('saa.informe_mantenimiento_id_informe_seq'::regclass);


--
-- TOC entry 4408 (class 2604 OID 41269)
-- Name: omision_servicio id_omision; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.omision_servicio ALTER COLUMN id_omision SET DEFAULT nextval('saa.omision_servicio_id_omision_seq'::regclass);


--
-- TOC entry 4404 (class 2604 OID 41234)
-- Name: pago id_pago; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.pago ALTER COLUMN id_pago SET DEFAULT nextval('saa.pago_id_pago_seq'::regclass);


--
-- TOC entry 4398 (class 2604 OID 41206)
-- Name: recibo id_recibo; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.recibo ALTER COLUMN id_recibo SET DEFAULT nextval('saa.recibo_id_recibo_seq'::regclass);


--
-- TOC entry 4380 (class 2604 OID 41049)
-- Name: red_agua id_red_agua; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.red_agua ALTER COLUMN id_red_agua SET DEFAULT nextval('saa.red_agua_id_red_agua_seq'::regclass);


--
-- TOC entry 4396 (class 2604 OID 41192)
-- Name: sustento_descuento id_sustento_descuento; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.sustento_descuento ALTER COLUMN id_sustento_descuento SET DEFAULT nextval('saa.sustento_descuento_id_sustento_descuento_seq'::regclass);


--
-- TOC entry 4386 (class 2604 OID 41085)
-- Name: tarifa id_tarifa; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.tarifa ALTER COLUMN id_tarifa SET DEFAULT nextval('saa.tarifa_id_tarifa_seq'::regclass);


--
-- TOC entry 4382 (class 2604 OID 41061)
-- Name: zona_afectacion id_zona_afectacion; Type: DEFAULT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.zona_afectacion ALTER COLUMN id_zona_afectacion SET DEFAULT nextval('saa.zona_afectacion_id_zona_afectacion_seq'::regclass);


--
-- TOC entry 5611 (class 0 OID 42034)
-- Dependencies: 498
-- Data for Name: alc_contrato_alcabala; Type: TABLE DATA; Schema: alc; Owner: admin
--

COPY alc.alc_contrato_alcabala (id, codigo_contrato, n_contrato, fecha_contrato, fecha_proceso, tipo_transferencia, notaria, nombre_notaria, n_minuta, n_preminuta, id_predio, id_entidad_inafecta, id_factor_calculo, id_contribuyente_transferente, id_contribuyente_adquiriente, valor_venta, base_imponible, valor_base_imponible_actualizado, valor_mayor, tramo_afecto, impuesto_calculado, intereses, total_a_pagar, usuario_creador, fecha_creacion, usuario_modificador, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5607 (class 0 OID 42017)
-- Dependencies: 494
-- Data for Name: alc_entidad_inafecta; Type: TABLE DATA; Schema: alc; Owner: admin
--

COPY alc.alc_entidad_inafecta (id, codigo, nombre, abreviatura, usuario_creador, fecha_creacion, usuario_modificador, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5613 (class 0 OID 42071)
-- Dependencies: 500
-- Data for Name: alc_estado_contrato; Type: TABLE DATA; Schema: alc; Owner: admin
--

COPY alc.alc_estado_contrato (id, id_contrato_alcabala, estado_contrato, fecha_pago, n_recibo, codigo_caja, usuario_creador, fecha_creacion, usuario_modificador, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5609 (class 0 OID 42025)
-- Dependencies: 496
-- Data for Name: alc_factor_calculo; Type: TABLE DATA; Schema: alc; Owner: admin
--

COPY alc.alc_factor_calculo (id, anio, mes, valor_ipm, uit_valor, porcentaje_impuesto, fecha_vencimiento, usuario_creador, fecha_creacion, usuario_modificador, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5591 (class 0 OID 41824)
-- Dependencies: 478
-- Data for Name: arbitrio; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.arbitrio (id_arbitrio, id_contribuyente, id_predio, id_tipo_registro_origen, anio, estado, observacion, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5593 (class 0 OID 41850)
-- Dependencies: 480
-- Data for Name: arbitrio_detalle; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.arbitrio_detalle (id_arbitrio_detalle, id_arbitrio, id_tipo_beneficio_limpieza_publica, id_tipo_beneficio_parques_jardines, id_tipo_beneficio_relleno_sanitario, id_tipo_beneficio_serenazgo, frentera_metros, frecuencia_barrido, nro_habitantes, area_construida, area_terreno, tiene_licencia, porcentaje_inseguridad, monto_base, monto_final, distancia_a_parque, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre, anio, usuario_actualizado, fecha_actualizado, atributo_actualizado, interes, mora) FROM stdin;
\.


--
-- TOC entry 5587 (class 0 OID 41803)
-- Dependencies: 474
-- Data for Name: categoria; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.categoria (id_categoria, codigo, denominacion, abreviatura, id_grupo_categoria, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5605 (class 0 OID 41996)
-- Dependencies: 492
-- Data for Name: categoria_tributo; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.categoria_tributo (id_categoria_tributo, id_categoria, id_tributo, anio, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5597 (class 0 OID 41911)
-- Dependencies: 484
-- Data for Name: determina_calculo; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.determina_calculo (id_determina_calculo, codigo, denominacion, anio, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5585 (class 0 OID 41795)
-- Dependencies: 472
-- Data for Name: grupo_categoria; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.grupo_categoria (id_grupo_categoria, denominacion, abreviatura, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5595 (class 0 OID 41883)
-- Dependencies: 482
-- Data for Name: licencia_funcionamiento; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.licencia_funcionamiento (id_licencia, id_contribuyente, id_predio, id_categoria, nro_licencia, categoria_licencia, fecha_emision, fecha_vencimiento, estado, actividad_comercial, aforo, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5601 (class 0 OID 41954)
-- Dependencies: 488
-- Data for Name: tarifa_area_construida; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.tarifa_area_construida (id_tarifa_area_construida, id_tributo, id_categoria, desde_area_construida, hasta_area_construida, tasa_mensual, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5603 (class 0 OID 41975)
-- Dependencies: 490
-- Data for Name: tarifa_area_terreno; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.tarifa_area_terreno (id_tarifa_area_terreno, id_categoria, id_tributo, id_sector, desde_area_terreno, hasta_area_terreno, tasa_mensual, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5599 (class 0 OID 41919)
-- Dependencies: 486
-- Data for Name: tarifa_categoria; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.tarifa_categoria (id_tarifa_categoria, id_tributo, id_determina_calculo, id_categoria, estado, anio, codigo, denominacion_categoria, abreviado, tipo_determinacion_calculo, desde_mes, hasta_mes, monto_fijo_mensual, valor_tasa_mensual, valor_tasa_metro_lineal, nro_habitantes_promedio_predio, factor_variacion_habitante, porcentaje_descuento_subsidio, porcentaje_tope_incremento, calcular_incremento_sobre_anio, glosa_base_legal, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5583 (class 0 OID 41782)
-- Dependencies: 470
-- Data for Name: tipo_beneficio; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.tipo_beneficio (id_tipo_beneficio, codigo, denominacion, abreviatura, id_tributo, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5589 (class 0 OID 41816)
-- Dependencies: 476
-- Data for Name: tipo_registro_origen; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.tipo_registro_origen (id_tipo_registro_origen, denominacion, abreviatura, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5581 (class 0 OID 41774)
-- Dependencies: 468
-- Data for Name: tributo; Type: TABLE DATA; Schema: arb; Owner: admin
--

COPY arb.tributo (id_tributo, codigo, denominacion, abreviatura, reajuste, interes, id_tipo_tributo, id_dependencia, usuario_actualizado, fecha_actualizado, atributo_actualizado) FROM stdin;
\.


--
-- TOC entry 5367 (class 0 OID 36632)
-- Dependencies: 254
-- Data for Name: apertura_cobranza; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.apertura_cobranza (id, id_cajero, fecha_apertura, hora_apertura, observaciones, estado) FROM stdin;
\.


--
-- TOC entry 5369 (class 0 OID 36640)
-- Dependencies: 256
-- Data for Name: auditoria; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.auditoria (id, tabla, operacion, registro_id, usuario_bd, fecha, descripcion) FROM stdin;
\.


--
-- TOC entry 5371 (class 0 OID 36648)
-- Dependencies: 258
-- Data for Name: cajero; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.cajero (id, nombres, apellidos, dni, cod_acceso, numeracion_inicial_recibo, numeracion_actual_recibo, estado) FROM stdin;
1	Ana	Torres García	45678912	clave123	1001	1002	ACTIVO
\.


--
-- TOC entry 5373 (class 0 OID 36655)
-- Dependencies: 260
-- Data for Name: cierre_caja; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.cierre_caja (id, id_cajero, fecha_cierre, hora_cierre, total_efectivo, total_comisiones, total_general, observaciones) FROM stdin;
\.


--
-- TOC entry 5375 (class 0 OID 36665)
-- Dependencies: 262
-- Data for Name: concepto_pago; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.concepto_pago (id, descripcion, monto) FROM stdin;
1	Pago de licencia de funcionamiento	50.00
2	Derecho de funcionamiento	50.00
\.


--
-- TOC entry 5377 (class 0 OID 36669)
-- Dependencies: 264
-- Data for Name: extorno; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.extorno (id, id_pago, id_recibo, id_cajero, motivo, fecha_extorno, hora_extorno) FROM stdin;
\.


--
-- TOC entry 5379 (class 0 OID 36677)
-- Dependencies: 266
-- Data for Name: pago; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.pago (id, id_usuario, id_cajero, id_tipo_pago, fecha_pago, total, observaciones) FROM stdin;
1	1	1	1	2025-10-20	50.00	Pago de licencia
2	1	1	1	2025-10-20	50.00	Pago de licencia
\.


--
-- TOC entry 5380 (class 0 OID 36683)
-- Dependencies: 267
-- Data for Name: pago_detalle; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.pago_detalle (id, id_pago, id_concepto_pago, cantidad, subtotal) FROM stdin;
1	1	1	1	50.00
\.


--
-- TOC entry 5383 (class 0 OID 36689)
-- Dependencies: 270
-- Data for Name: recibo; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.recibo (id, id_pago, id_cajero, numero_recibo, fecha_emision, total, estado) FROM stdin;
1	1	1	1001	2025-10-20	50.00	EMITIDO
\.


--
-- TOC entry 5385 (class 0 OID 36695)
-- Dependencies: 272
-- Data for Name: tipo_pago; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.tipo_pago (id, descripcion) FROM stdin;
1	Efectivo
2	Yape
\.


--
-- TOC entry 5387 (class 0 OID 36699)
-- Dependencies: 274
-- Data for Name: usuario; Type: TABLE DATA; Schema: caj; Owner: postgres
--

COPY caj.usuario (id, nombres, apellidos, dni, direccion, telefono, correo) FROM stdin;
1	Carlos	Ramírez Quispe	72154896	Av. Grau 123	945612378	carlosr@gmail.com
\.


--
-- TOC entry 5573 (class 0 OID 41509)
-- Dependencies: 460
-- Data for Name: fis_acta_inspección; Type: TABLE DATA; Schema: fis; Owner: admin
--

COPY fis."fis_acta_inspección" (id_acta, id_fiscalizacion, numero_acta, fecha_inspeccion, hora_inicio, hora_fin, participantes, observaciones, evidencias_fotograficas, estado) FROM stdin;
\.


--
-- TOC entry 5569 (class 0 OID 41406)
-- Dependencies: 456
-- Data for Name: fis_fiscalizacion; Type: TABLE DATA; Schema: fis; Owner: admin
--

COPY fis.fis_fiscalizacion (id_fiscalizacion, numero_expediente, tipo_procedimiento, fecha_inicio, fecha_termino, estado, id_predio, id_contribuyente, id_funcionario) FROM stdin;
\.


--
-- TOC entry 5575 (class 0 OID 41523)
-- Dependencies: 462
-- Data for Name: fis_liquidacion; Type: TABLE DATA; Schema: fis; Owner: admin
--

COPY fis.fis_liquidacion (id_liquidacion, id_fiscalizacion, numero_liquidacion, fecha_emision, base_imponible, impuesto_omiso, multa, intereses, total_a_pagar, estado) FROM stdin;
\.


--
-- TOC entry 5579 (class 0 OID 41551)
-- Dependencies: 466
-- Data for Name: fis_multa; Type: TABLE DATA; Schema: fis; Owner: admin
--

COPY fis.fis_multa (id_multa, id_resolucion, codigo_multa, descripcion, porcentaje_aplicado, monto, tipo) FROM stdin;
\.


--
-- TOC entry 5571 (class 0 OID 41495)
-- Dependencies: 458
-- Data for Name: fis_requerimiento; Type: TABLE DATA; Schema: fis; Owner: admin
--

COPY fis.fis_requerimiento (id_requerimiento, id_fiscalizacion, numero_requerimiento, fecha_emision, fecha_vencimiento, tipo_requerimiento, descripcion, estado, evidencia_fotografica) FROM stdin;
\.


--
-- TOC entry 5577 (class 0 OID 41537)
-- Dependencies: 464
-- Data for Name: fis_resolucion; Type: TABLE DATA; Schema: fis; Owner: admin
--

COPY fis.fis_resolucion (id_resolucion, id_fiscalizacion, numero_resolucion, tipo, fecha_emision, fundamento_legal, disposiciones, estado) FROM stdin;
\.


--
-- TOC entry 5493 (class 0 OID 40526)
-- Dependencies: 380
-- Data for Name: gen_contribuyente; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_contribuyente (id, estado, fecha_creacion, dni, ruc, otro_documento_identidad, nro_documento_identidad, nombre, tipo_persona, genero, fecha_nacimiento, domicilio_fiscal, referencia_domicilio_fiscal, telefono_fijo, telefono_celular, celular_whatsapp, email, observaciones, f_control, h_control, fecha_servidor) FROM stdin;
1	Activo	2025-11-27	70865755	\N	\N	\N	Maria Lopez	Natural	Hombre	2017-08-23	Direccion 1	\N	\N	535062017	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
2	Activo	2025-11-27	50765220	\N	\N	\N	Lucia Fernandez	Juridica	Mujer	2010-07-31	Direccion 2	\N	\N	843615550	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
3	Activo	2025-11-27	76941220	\N	\N	\N	Pedro Rivas	Natural	Hombre	1982-06-08	Direccion 3	\N	\N	879295516	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
4	Activo	2025-11-27	54431635	\N	\N	\N	Carlos Diaz	Juridica	Mujer	2014-04-13	Direccion 4	\N	\N	276857579	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
5	Activo	2025-11-27	14299762	\N	\N	\N	Pedro Rivas	Natural	Mujer	1953-04-17	Direccion 5	\N	\N	119737475	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
6	Activo	2025-11-27	45359656	\N	\N	\N	Maria Lopez	Juridica	Hombre	2016-03-29	Direccion 6	\N	\N	885873672	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
7	Activo	2025-11-27	56440468	\N	\N	\N	Juan Perez	Natural	Mujer	1960-11-10	Direccion 7	\N	\N	438291579	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
8	Activo	2025-11-27	98003407	\N	\N	\N	Juan Perez	Juridica	Hombre	1993-02-15	Direccion 8	\N	\N	948037741	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
9	Activo	2025-11-27	68490608	\N	\N	\N	Jose Ramirez	Juridica	Mujer	1953-02-20	Direccion 9	\N	\N	629738693	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
10	Activo	2025-11-27	98047668	\N	\N	\N	Pedro Rivas	Natural	Mujer	1986-05-09	Direccion 10	\N	\N	218810201	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
11	Activo	2025-11-27	15553535	\N	\N	\N	Rosa Gutierrez	Natural	Hombre	2006-09-20	Direccion 11	\N	\N	140600704	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
12	Activo	2025-11-27	61304856	\N	\N	\N	Luis Castro	Natural	Mujer	2009-02-21	Direccion 12	\N	\N	731400698	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
13	Activo	2025-11-27	39621166	\N	\N	\N	Pedro Rivas	Juridica	Mujer	1971-10-14	Direccion 13	\N	\N	147821277	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
14	Activo	2025-11-27	68118245	\N	\N	\N	Miguel Campos	Natural	Mujer	1973-01-22	Direccion 14	\N	\N	567307349	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
15	Activo	2025-11-27	71823683	\N	\N	\N	Rosa Gutierrez	Juridica	Hombre	1963-06-17	Direccion 15	\N	\N	569402575	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
16	Activo	2025-11-27	56919308	\N	\N	\N	Maria Lopez	Natural	Hombre	1971-04-03	Direccion 16	\N	\N	292440402	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
17	Activo	2025-11-27	10163942	\N	\N	\N	Juan Perez	Natural	Hombre	1962-06-26	Direccion 17	\N	\N	463074664	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
18	Activo	2025-11-27	81059423	\N	\N	\N	Miguel Campos	Natural	Hombre	2012-04-19	Direccion 18	\N	\N	489773559	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
19	Activo	2025-11-27	50859875	\N	\N	\N	Rosa Gutierrez	Juridica	Mujer	1952-07-21	Direccion 19	\N	\N	409973858	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
20	Activo	2025-11-27	40344363	\N	\N	\N	Ana Torres	Natural	Mujer	1971-08-19	Direccion 20	\N	\N	888232188	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
21	Activo	2025-11-27	34819845	\N	\N	\N	Pedro Rivas	Natural	Hombre	2002-01-03	Direccion 21	\N	\N	603371233	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
22	Activo	2025-11-27	32835056	\N	\N	\N	Rosa Gutierrez	Natural	Hombre	1966-12-30	Direccion 22	\N	\N	244212815	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
23	Activo	2025-11-27	60405053	\N	\N	\N	Pedro Rivas	Juridica	Hombre	2015-11-19	Direccion 23	\N	\N	864989829	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
24	Activo	2025-11-27	34924900	\N	\N	\N	Rosa Gutierrez	Natural	Mujer	2008-05-09	Direccion 24	\N	\N	141128826	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
25	Activo	2025-11-27	58134089	\N	\N	\N	Carlos Diaz	Natural	Mujer	1980-04-09	Direccion 25	\N	\N	255505126	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
26	Activo	2025-11-27	94666442	\N	\N	\N	Rosa Gutierrez	Juridica	Hombre	1997-11-26	Direccion 26	\N	\N	949888048	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
27	Activo	2025-11-27	12078390	\N	\N	\N	Luis Castro	Natural	Mujer	1982-09-28	Direccion 27	\N	\N	472732842	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
28	Activo	2025-11-27	50447058	\N	\N	\N	Rosa Gutierrez	Natural	Hombre	2004-03-14	Direccion 28	\N	\N	143556147	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
29	Activo	2025-11-27	76728027	\N	\N	\N	Luis Castro	Natural	Hombre	1979-02-20	Direccion 29	\N	\N	462127141	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
30	Activo	2025-11-27	55344850	\N	\N	\N	Miguel Campos	Natural	Hombre	2011-08-12	Direccion 30	\N	\N	753076316	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
31	Activo	2025-11-27	83087308	\N	\N	\N	Carlos Diaz	Juridica	Hombre	2002-08-07	Direccion 31	\N	\N	711837438	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
32	Activo	2025-11-27	25586974	\N	\N	\N	Ana Torres	Natural	Hombre	1991-12-24	Direccion 32	\N	\N	256802557	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
33	Activo	2025-11-27	86984026	\N	\N	\N	Lucia Fernandez	Natural	Hombre	1958-03-23	Direccion 33	\N	\N	343936891	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
34	Activo	2025-11-27	71427389	\N	\N	\N	Luis Castro	Natural	Hombre	1996-05-28	Direccion 34	\N	\N	622572701	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
35	Activo	2025-11-27	25328661	\N	\N	\N	Ana Torres	Juridica	Mujer	2008-04-14	Direccion 35	\N	\N	398191433	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
36	Activo	2025-11-27	78318347	\N	\N	\N	Maria Lopez	Juridica	Mujer	1997-12-20	Direccion 36	\N	\N	506816690	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
37	Activo	2025-11-27	63321504	\N	\N	\N	Lucia Fernandez	Juridica	Hombre	1981-08-20	Direccion 37	\N	\N	849439687	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
38	Activo	2025-11-27	20377225	\N	\N	\N	Carlos Diaz	Juridica	Hombre	1968-08-09	Direccion 38	\N	\N	128787218	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
39	Activo	2025-11-27	91881060	\N	\N	\N	Ana Torres	Juridica	Hombre	2002-04-26	Direccion 39	\N	\N	405388520	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
40	Activo	2025-11-27	30065916	\N	\N	\N	Miguel Campos	Natural	Hombre	2008-05-16	Direccion 40	\N	\N	570006145	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
41	Activo	2025-11-27	83394325	\N	\N	\N	Lucia Fernandez	Juridica	Hombre	1988-08-25	Direccion 41	\N	\N	950301984	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
42	Activo	2025-11-27	15146991	\N	\N	\N	Pedro Rivas	Natural	Mujer	2001-02-20	Direccion 42	\N	\N	484922300	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
43	Activo	2025-11-27	71496674	\N	\N	\N	Maria Lopez	Natural	Hombre	2009-12-01	Direccion 43	\N	\N	313436698	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
44	Activo	2025-11-27	69494074	\N	\N	\N	Lucia Fernandez	Juridica	Hombre	1953-05-22	Direccion 44	\N	\N	956872596	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
45	Activo	2025-11-27	47273192	\N	\N	\N	Pedro Rivas	Juridica	Mujer	2016-07-13	Direccion 45	\N	\N	162527352	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
46	Activo	2025-11-27	48863350	\N	\N	\N	Carlos Diaz	Natural	Mujer	1989-03-19	Direccion 46	\N	\N	836165141	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
47	Activo	2025-11-27	93858233	\N	\N	\N	Lucia Fernandez	Natural	Mujer	1977-08-23	Direccion 47	\N	\N	926244102	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
48	Activo	2025-11-27	50032484	\N	\N	\N	Rosa Gutierrez	Juridica	Mujer	1993-10-26	Direccion 48	\N	\N	296245666	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
49	Activo	2025-11-27	58832895	\N	\N	\N	Luis Castro	Natural	Mujer	1975-12-13	Direccion 49	\N	\N	818323072	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
50	Activo	2025-11-27	58544326	\N	\N	\N	Lucia Fernandez	Natural	Mujer	1952-09-04	Direccion 50	\N	\N	164813627	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
51	Activo	2025-11-27	50893520	\N	\N	\N	Maria Lopez	Juridica	Hombre	1977-03-13	Direccion 51	\N	\N	341941247	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
52	Activo	2025-11-27	58004087	\N	\N	\N	Rosa Gutierrez	Natural	Hombre	1992-05-16	Direccion 52	\N	\N	923565100	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
53	Activo	2025-11-27	91258070	\N	\N	\N	Jose Ramirez	Natural	Mujer	1984-02-26	Direccion 53	\N	\N	494982401	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
54	Activo	2025-11-27	97546324	\N	\N	\N	Miguel Campos	Juridica	Mujer	2000-09-11	Direccion 54	\N	\N	102224994	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
55	Activo	2025-11-27	12134202	\N	\N	\N	Ana Torres	Natural	Hombre	1976-04-25	Direccion 55	\N	\N	473117609	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
56	Activo	2025-11-27	45953733	\N	\N	\N	Luis Castro	Natural	Mujer	1988-10-23	Direccion 56	\N	\N	484934687	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
57	Activo	2025-11-27	80101587	\N	\N	\N	Maria Lopez	Natural	Mujer	1984-08-06	Direccion 57	\N	\N	646424686	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
58	Activo	2025-11-27	34359267	\N	\N	\N	Maria Lopez	Natural	Mujer	1960-02-07	Direccion 58	\N	\N	390090537	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
59	Activo	2025-11-27	61335443	\N	\N	\N	Pedro Rivas	Natural	Hombre	1966-04-03	Direccion 59	\N	\N	747503971	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
60	Activo	2025-11-27	44394096	\N	\N	\N	Maria Lopez	Juridica	Mujer	2002-06-08	Direccion 60	\N	\N	696442777	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
61	Activo	2025-11-27	62210194	\N	\N	\N	Jose Ramirez	Natural	Mujer	1953-03-04	Direccion 61	\N	\N	640960106	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
62	Activo	2025-11-27	56163012	\N	\N	\N	Luis Castro	Natural	Mujer	1985-12-20	Direccion 62	\N	\N	602771175	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
63	Activo	2025-11-27	46933413	\N	\N	\N	Carlos Diaz	Juridica	Hombre	1951-10-11	Direccion 63	\N	\N	208012857	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
64	Activo	2025-11-27	48335205	\N	\N	\N	Maria Lopez	Natural	Mujer	1966-01-14	Direccion 64	\N	\N	318493593	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
65	Activo	2025-11-27	98463762	\N	\N	\N	Luis Castro	Juridica	Mujer	2012-02-04	Direccion 65	\N	\N	581826481	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
66	Activo	2025-11-27	30181415	\N	\N	\N	Ana Torres	Juridica	Mujer	1969-02-07	Direccion 66	\N	\N	789764790	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
67	Activo	2025-11-27	91872508	\N	\N	\N	Jose Ramirez	Natural	Hombre	1989-03-21	Direccion 67	\N	\N	268143073	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
68	Activo	2025-11-27	92390730	\N	\N	\N	Pedro Rivas	Natural	Hombre	1950-09-14	Direccion 68	\N	\N	103411573	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
69	Activo	2025-11-27	34969835	\N	\N	\N	Luis Castro	Natural	Hombre	1982-05-25	Direccion 69	\N	\N	485205180	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
70	Activo	2025-11-27	14450137	\N	\N	\N	Maria Lopez	Natural	Mujer	1973-12-28	Direccion 70	\N	\N	571038115	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
71	Activo	2025-11-27	13856058	\N	\N	\N	Ana Torres	Natural	Hombre	1996-07-29	Direccion 71	\N	\N	328627473	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
72	Activo	2025-11-27	64235137	\N	\N	\N	Pedro Rivas	Juridica	Hombre	1958-10-05	Direccion 72	\N	\N	150138730	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
73	Activo	2025-11-27	70095275	\N	\N	\N	Ana Torres	Natural	Hombre	1974-04-14	Direccion 73	\N	\N	205929830	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
74	Activo	2025-11-27	48539785	\N	\N	\N	Maria Lopez	Natural	Mujer	1998-01-29	Direccion 74	\N	\N	384606286	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
75	Activo	2025-11-27	82857473	\N	\N	\N	Lucia Fernandez	Natural	Mujer	1951-02-16	Direccion 75	\N	\N	371325869	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
76	Activo	2025-11-27	80795736	\N	\N	\N	Ana Torres	Juridica	Mujer	2005-01-05	Direccion 76	\N	\N	470951921	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
77	Activo	2025-11-27	25253538	\N	\N	\N	Maria Lopez	Juridica	Hombre	2007-06-14	Direccion 77	\N	\N	355632052	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
78	Activo	2025-11-27	80391341	\N	\N	\N	Miguel Campos	Natural	Mujer	1967-07-27	Direccion 78	\N	\N	361171373	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
79	Activo	2025-11-27	97804135	\N	\N	\N	Rosa Gutierrez	Juridica	Mujer	1957-01-10	Direccion 79	\N	\N	835229295	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
80	Activo	2025-11-27	17539515	\N	\N	\N	Luis Castro	Juridica	Mujer	1992-06-01	Direccion 80	\N	\N	471740464	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
81	Activo	2025-11-27	95998497	\N	\N	\N	Maria Lopez	Natural	Mujer	1956-05-28	Direccion 81	\N	\N	885425697	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
82	Activo	2025-11-27	83396133	\N	\N	\N	Carlos Diaz	Juridica	Mujer	1965-10-08	Direccion 82	\N	\N	578670027	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
83	Activo	2025-11-27	10098305	\N	\N	\N	Carlos Diaz	Juridica	Mujer	1959-01-30	Direccion 83	\N	\N	793411977	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
84	Activo	2025-11-27	70756061	\N	\N	\N	Pedro Rivas	Juridica	Hombre	1991-02-09	Direccion 84	\N	\N	649829003	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
85	Activo	2025-11-27	73769242	\N	\N	\N	Carlos Diaz	Natural	Mujer	2016-10-03	Direccion 85	\N	\N	233335438	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
86	Activo	2025-11-27	52027826	\N	\N	\N	Maria Lopez	Natural	Mujer	1987-07-30	Direccion 86	\N	\N	280746849	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
87	Activo	2025-11-27	15944146	\N	\N	\N	Maria Lopez	Natural	Hombre	2018-05-22	Direccion 87	\N	\N	533045980	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
88	Activo	2025-11-27	47461611	\N	\N	\N	Pedro Rivas	Natural	Mujer	1963-01-16	Direccion 88	\N	\N	618199945	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
89	Activo	2025-11-27	21947160	\N	\N	\N	Carlos Diaz	Juridica	Hombre	2012-07-08	Direccion 89	\N	\N	574655982	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
90	Activo	2025-11-27	72153092	\N	\N	\N	Carlos Diaz	Natural	Hombre	1974-09-10	Direccion 90	\N	\N	765432455	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
91	Activo	2025-11-27	99858485	\N	\N	\N	Maria Lopez	Juridica	Hombre	1978-11-22	Direccion 91	\N	\N	678279039	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
92	Activo	2025-11-27	47846706	\N	\N	\N	Rosa Gutierrez	Natural	Hombre	1951-07-01	Direccion 92	\N	\N	663913861	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
93	Activo	2025-11-27	53645611	\N	\N	\N	Pedro Rivas	Juridica	Hombre	1978-11-20	Direccion 93	\N	\N	411731054	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
94	Activo	2025-11-27	87957602	\N	\N	\N	Carlos Diaz	Juridica	Hombre	1957-07-08	Direccion 94	\N	\N	987366564	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
95	Activo	2025-11-27	94492404	\N	\N	\N	Luis Castro	Natural	Mujer	1956-06-30	Direccion 95	\N	\N	189455421	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
96	Activo	2025-11-27	12136674	\N	\N	\N	Rosa Gutierrez	Juridica	Mujer	1972-07-05	Direccion 96	\N	\N	904477765	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
97	Activo	2025-11-27	30311235	\N	\N	\N	Pedro Rivas	Natural	Mujer	2007-07-08	Direccion 97	\N	\N	732439997	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
98	Activo	2025-11-27	52825939	\N	\N	\N	Luis Castro	Juridica	Mujer	1978-01-10	Direccion 98	\N	\N	675266377	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
99	Activo	2025-11-27	60651910	\N	\N	\N	Maria Lopez	Natural	Hombre	1960-07-01	Direccion 99	\N	\N	598725298	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
100	Activo	2025-11-27	85858415	\N	\N	\N	Pedro Rivas	Natural	Hombre	1969-12-31	Direccion 100	\N	\N	802300650	\N	\N	\N	2025-11-27	03:32:42.767476	2025-11-27 03:32:42.767476
\.


--
-- TOC entry 5478 (class 0 OID 40377)
-- Dependencies: 365
-- Data for Name: gen_departamento; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_departamento (id, nombre, f_control, h_control, fecha_servidor) FROM stdin;
1	Amazonas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
2	Ancash	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
3	Apurimac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
4	Arequipa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
5	Ayachuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
6	Cajamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
7	Callao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
8	Cusco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
9	Huancavelica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
10	Huanuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
11	Ica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
12	Junin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
13	La Libertad	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
14	Lambayeque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
15	Lima	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
16	Loreto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
17	Madre de Dios	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
18	Moquegua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
19	Pasco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
20	Piura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
21	Puno	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
22	San Martin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
23	Tacna	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
24	Tumbes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
25	Ucayali	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
\.


--
-- TOC entry 5482 (class 0 OID 40406)
-- Dependencies: 369
-- Data for Name: gen_distrito; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_distrito (id, id_departamento, id_provincia, nombre, f_control, h_control, fecha_servidor) FROM stdin;
1	1	1	Chachapoyas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
2	1	1	Asunción	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
3	1	1	Balsas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
4	1	1	Cheto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
5	1	1	Chiliquin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
6	1	1	Chuquibamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
7	1	1	Granada	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
8	1	1	Huancas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
9	1	1	La Jalca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
10	1	1	Leimebamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
11	1	1	Levanto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
12	1	1	Magdalena	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
13	1	1	Mariscal Castilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
14	1	1	Molinopampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
15	1	1	Montevideo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
16	1	1	Olleros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
17	1	1	Quinjalca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
18	1	1	San Francisco de Daguas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
19	1	1	San Isidro de Maino	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
20	1	1	Soloco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
21	1	1	Sonche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
22	1	2	Bagua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
23	1	2	Aramango	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
24	1	2	Copallin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
25	1	2	El Parco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
26	1	2	Imaza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
27	1	2	La Peca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
28	1	3	Jumbilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
29	1	3	Chisquilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
30	1	3	Churuja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
31	1	3	Corosha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
32	1	3	Cuispes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
33	1	3	Florida	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
34	1	3	Jazan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
35	1	3	Recta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
36	1	3	San Carlos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
37	1	3	Shipasbamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
38	1	3	Valera	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
39	1	3	Yambrasbamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
40	1	4	Nieva	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
41	1	4	El Cenepa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
42	1	4	Río Santiago	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
43	1	5	Lamud	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
44	1	5	Camporredondo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
45	1	5	Cocabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
46	1	5	Colcamar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
47	1	5	Conila	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
48	1	5	Inguilpata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
49	1	5	Longuita	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
50	1	5	Lonya Chico	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
51	1	5	Luya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
52	1	5	Luya Viejo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
53	1	5	María	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
54	1	5	Ocalli	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
55	1	5	Ocumal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
56	1	5	Pisuquia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
57	1	5	Providencia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
58	1	5	San Cristóbal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
59	1	5	San Francisco de Yeso	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
60	1	5	San Jerónimo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
61	1	5	San Juan de Lopecancha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
62	1	5	Santa Catalina	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
63	1	5	Santo Tomas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
64	1	5	Tingo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
65	1	5	Trita	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
66	1	6	San Nicolás	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
67	1	6	Chirimoto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
68	1	6	Cochamal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
69	1	6	Huambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
70	1	6	Limabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
71	1	6	Longar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
72	1	6	Mariscal Benavides	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
73	1	6	Milpuc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
74	1	6	Omia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
75	1	6	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
76	1	6	Totora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
77	1	6	Vista Alegre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
78	1	7	Bagua Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
79	1	7	Cajaruro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
80	1	7	Cumba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
81	1	7	El Milagro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
82	1	7	Jamalca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
83	1	7	Lonya Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
84	1	7	Yamon	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
85	2	8	Huaraz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
86	2	8	Cochabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
87	2	8	Colcabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
88	2	8	Huanchay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
89	2	8	Independencia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
90	2	8	Jangas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
91	2	8	La Libertad	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
92	2	8	Olleros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
93	2	8	Pampas Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
94	2	8	Pariacoto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
95	2	8	Pira	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
96	2	8	Tarica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
97	2	9	Aija	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
98	2	9	Coris	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
99	2	9	Huacllan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
100	2	9	La Merced	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
101	2	9	Succha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
102	2	10	Llamellin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
103	2	10	Aczo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
104	2	10	Chaccho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
105	2	10	Chingas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
106	2	10	Mirgas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
107	2	10	San Juan de Rontoy	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
108	2	11	Chacas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
109	2	11	Acochaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
110	2	12	Chiquian	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
111	2	12	Abelardo Pardo Lezameta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
112	2	12	Antonio Raymondi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
113	2	12	Aquia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
114	2	12	Cajacay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
115	2	12	Canis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
116	2	12	Colquioc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
117	2	12	Huallanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
118	2	12	Huasta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
119	2	12	Huayllacayan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
120	2	12	La Primavera	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
121	2	12	Mangas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
122	2	12	Pacllon	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
123	2	12	San Miguel de Corpanqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
124	2	12	Ticllos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
125	2	13	Carhuaz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
126	2	13	Acopampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
127	2	13	Amashca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
128	2	13	Anta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
129	2	13	Ataquero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
130	2	13	Marcara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
131	2	13	Pariahuanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
132	2	13	San Miguel de Aco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
133	2	13	Shilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
134	2	13	Tinco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
135	2	13	Yungar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
136	2	14	San Luis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
137	2	14	San Nicolás	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
138	2	14	Yauya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
139	2	15	Casma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
140	2	15	Buena Vista Alta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
141	2	15	Comandante Noel	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
142	2	15	Yautan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
143	2	16	Corongo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
144	2	16	Aco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
145	2	16	Bambas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
146	2	16	Cusca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
147	2	16	La Pampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
148	2	16	Yanac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
149	2	16	Yupan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
150	2	17	Huari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
151	2	17	Anra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
152	2	17	Cajay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
153	2	17	Chavin de Huantar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
154	2	17	Huacachi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
155	2	17	Huacchis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
156	2	17	Huachis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
157	2	17	Huantar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
158	2	17	Masin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
159	2	17	Paucas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
160	2	17	Ponto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
161	2	17	Rahuapampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
162	2	17	Rapayan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
163	2	17	San Marcos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
164	2	17	San Pedro de Chana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
165	2	17	Uco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
166	2	18	Huarmey	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
167	2	18	Cochapeti	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
168	2	18	Culebras	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
169	2	18	Huayan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
170	2	18	Malvas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
171	2	19	Caraz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
172	2	19	Huallanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
173	2	19	Huata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
174	2	19	Huaylas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
175	2	19	Mato	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
176	2	19	Pamparomas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
177	2	19	Pueblo Libre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
178	2	19	Santa Cruz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
179	2	19	Santo Toribio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
180	2	19	Yuracmarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
181	2	20	Piscobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
182	2	20	Casca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
183	2	20	Eleazar Guzmán Barron	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
184	2	20	Fidel Olivas Escudero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
185	2	20	Llama	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
186	2	20	Llumpa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
187	2	20	Lucma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
188	2	20	Musga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
189	2	21	Ocros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
190	2	21	Acas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
191	2	21	Cajamarquilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
192	2	21	Carhuapampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
193	2	21	Cochas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
194	2	21	Congas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
195	2	21	Llipa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
196	2	21	San Cristóbal de Rajan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
197	2	21	San Pedro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
198	2	21	Santiago de Chilcas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
199	2	22	Cabana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
200	2	22	Bolognesi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
201	2	22	Conchucos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
202	2	22	Huacaschuque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
203	2	22	Huandoval	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
204	2	22	Lacabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
205	2	22	Llapo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
206	2	22	Pallasca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
207	2	22	Pampas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
208	2	22	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
209	2	22	Tauca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
210	2	23	Pomabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
211	2	23	Huayllan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
212	2	23	Parobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
213	2	23	Quinuabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
214	2	24	Recuay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
215	2	24	Catac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
216	2	24	Cotaparaco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
217	2	24	Huayllapampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
218	2	24	Llacllin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
219	2	24	Marca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
220	2	24	Pampas Chico	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
221	2	24	Pararin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
222	2	24	Tapacocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
223	2	24	Ticapampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
224	2	25	Chimbote	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
225	2	25	Cáceres del Perú	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
226	2	25	Coishco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
227	2	25	Macate	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
228	2	25	Moro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
229	2	25	Nepeña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
230	2	25	Samanco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
231	2	25	Santa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
232	2	25	Nuevo Chimbote	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
233	2	26	Sihuas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
234	2	26	Acobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
235	2	26	Alfonso Ugarte	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
236	2	26	Cashapampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
237	2	26	Chingalpo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
238	2	26	Huayllabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
239	2	26	Quiches	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
240	2	26	Ragash	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
241	2	26	San Juan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
242	2	26	Sicsibamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
243	2	27	Yungay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
244	2	27	Cascapara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
245	2	27	Mancos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
246	2	27	Matacoto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
247	2	27	Quillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
248	2	27	Ranrahirca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
249	2	27	Shupluy	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
250	2	27	Yanama	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
251	3	28	Abancay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
252	3	28	Chacoche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
253	3	28	Circa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
254	3	28	Curahuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
255	3	28	Huanipaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
256	3	28	Lambrama	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
257	3	28	Pichirhua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
258	3	28	San Pedro de Cachora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
259	3	28	Tamburco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
260	3	29	Andahuaylas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
261	3	29	Andarapa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
262	3	29	Chiara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
263	3	29	Huancarama	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
264	3	29	Huancaray	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
265	3	29	Huayana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
266	3	29	Kishuara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
267	3	29	Pacobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
268	3	29	Pacucha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
269	3	29	Pampachiri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
270	3	29	Pomacocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
271	3	29	San Antonio de Cachi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
272	3	29	San Jerónimo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
273	3	29	San Miguel de Chaccrampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
274	3	29	Santa María de Chicmo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
275	3	29	Talavera	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
276	3	29	Tumay Huaraca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
277	3	29	Turpo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
278	3	29	Kaquiabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
279	3	29	José María Arguedas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
280	3	30	Antabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
281	3	30	El Oro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
282	3	30	Huaquirca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
283	3	30	Juan Espinoza Medrano	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
284	3	30	Oropesa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
285	3	30	Pachaconas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
286	3	30	Sabaino	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
287	3	31	Chalhuanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
288	3	31	Capaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
289	3	31	Caraybamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
290	3	31	Chapimarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
291	3	31	Colcabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
292	3	31	Cotaruse	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
293	3	31	Ihuayllo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
294	3	31	Justo Apu Sahuaraura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
295	3	31	Lucre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
296	3	31	Pocohuanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
297	3	31	San Juan de Chacña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
298	3	31	Sañayca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
299	3	31	Soraya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
300	3	31	Tapairihua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
301	3	31	Tintay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
302	3	31	Toraya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
303	3	31	Yanaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
304	3	32	Tambobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
305	3	32	Cotabambas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
306	3	32	Coyllurqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
307	3	32	Haquira	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
308	3	32	Mara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
309	3	32	Challhuahuacho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
310	3	33	Chincheros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
311	3	33	Anco_Huallo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
312	3	33	Cocharcas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
313	3	33	Huaccana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
314	3	33	Ocobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
315	3	33	Ongoy	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
316	3	33	Uranmarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
317	3	33	Ranracancha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
318	3	33	Rocchacc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
319	3	33	El Porvenir	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
320	3	33	Los Chankas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
321	3	34	Chuquibambilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
322	3	34	Curpahuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
323	3	34	Gamarra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
324	3	34	Huayllati	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
325	3	34	Mamara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
326	3	34	Micaela Bastidas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
327	3	34	Pataypampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
328	3	34	Progreso	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
329	3	34	San Antonio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
330	3	34	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
331	3	34	Turpay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
332	3	34	Vilcabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
333	3	34	Virundo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
334	3	34	Curasco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
335	4	35	Arequipa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
336	4	35	Alto Selva Alegre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
337	4	35	Cayma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
338	4	35	Cerro Colorado	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
339	4	35	Characato	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
340	4	35	Chiguata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
341	4	35	Jacobo Hunter	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
342	4	35	La Joya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
343	4	35	Mariano Melgar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
344	4	35	Miraflores	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
345	4	35	Mollebaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
346	4	35	Paucarpata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
347	4	35	Pocsi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
348	4	35	Polobaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
349	4	35	Quequeña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
350	4	35	Sabandia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
351	4	35	Sachaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
352	4	35	San Juan de Siguas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
353	4	35	San Juan de Tarucani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
354	4	35	Santa Isabel de Siguas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
355	4	35	Santa Rita de Siguas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
356	4	35	Socabaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
357	4	35	Tiabaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
358	4	35	Uchumayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
359	4	35	Vitor	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
360	4	35	Yanahuara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
361	4	35	Yarabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
362	4	35	Yura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
363	4	35	José Luis Bustamante Y Rivero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
364	4	36	Camaná	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
365	4	36	José María Quimper	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
366	4	36	Mariano Nicolás Valcárcel	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
367	4	36	Mariscal Cáceres	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
368	4	36	Nicolás de Pierola	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
369	4	36	Ocoña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
370	4	36	Quilca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
371	4	36	Samuel Pastor	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
372	4	37	Caravelí	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
373	4	37	Acarí	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
374	4	37	Atico	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
375	4	37	Atiquipa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
376	4	37	Bella Unión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
377	4	37	Cahuacho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
378	4	37	Chala	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
379	4	37	Chaparra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
380	4	37	Huanuhuanu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
381	4	37	Jaqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
382	4	37	Lomas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
383	4	37	Quicacha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
384	4	37	Yauca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
385	4	38	Aplao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
386	4	38	Andagua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
387	4	38	Ayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
388	4	38	Chachas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
389	4	38	Chilcaymarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
390	4	38	Choco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
391	4	38	Huancarqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
392	4	38	Machaguay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
393	4	38	Orcopampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
394	4	38	Pampacolca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
395	4	38	Tipan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
396	4	38	Uñon	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
397	4	38	Uraca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
398	4	38	Viraco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
399	4	39	Chivay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
400	4	39	Achoma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
401	4	39	Cabanaconde	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
402	4	39	Callalli	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
403	4	39	Caylloma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
404	4	39	Coporaque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
405	4	39	Huambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
406	4	39	Huanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
407	4	39	Ichupampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
408	4	39	Lari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
409	4	39	Lluta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
410	4	39	Maca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
411	4	39	Madrigal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
412	4	39	San Antonio de Chuca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
413	4	39	Sibayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
414	4	39	Tapay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
415	4	39	Tisco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
416	4	39	Tuti	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
417	4	39	Yanque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
418	4	39	Majes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
419	4	40	Chuquibamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
420	4	40	Andaray	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
421	4	40	Cayarani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
422	4	40	Chichas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
423	4	40	Iray	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
424	4	40	Río Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
425	4	40	Salamanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
426	4	40	Yanaquihua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
427	4	41	Mollendo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
428	4	41	Cocachacra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
429	4	41	Dean Valdivia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
430	4	41	Islay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
431	4	41	Mejia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
432	4	41	Punta de Bombón	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
433	4	42	Cotahuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
434	4	42	Alca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
435	4	42	Charcana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
436	4	42	Huaynacotas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
437	4	42	Pampamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
438	4	42	Puyca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
439	4	42	Quechualla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
440	4	42	Sayla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
441	4	42	Tauria	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
442	4	42	Tomepampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
443	4	42	Toro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
444	5	43	Ayacucho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
445	5	43	Acocro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
446	5	43	Acos Vinchos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
447	5	43	Carmen Alto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
448	5	43	Chiara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
449	5	43	Ocros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
450	5	43	Pacaycasa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
451	5	43	Quinua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
452	5	43	San José de Ticllas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
453	5	43	San Juan Bautista	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
454	5	43	Santiago de Pischa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
455	5	43	Socos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
456	5	43	Tambillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
457	5	43	Vinchos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
458	5	43	Jesús Nazareno	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
459	5	43	Andrés Avelino Cáceres Dorregaray	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
460	5	44	Cangallo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
461	5	44	Chuschi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
462	5	44	Los Morochucos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
463	5	44	María Parado de Bellido	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
464	5	44	Paras	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
465	5	44	Totos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
466	5	45	Sancos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
467	5	45	Carapo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
468	5	45	Sacsamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
469	5	45	Santiago de Lucanamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
470	5	46	Huanta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
471	5	46	Ayahuanco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
472	5	46	Huamanguilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
473	5	46	Iguain	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
474	5	46	Luricocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
475	5	46	Santillana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
476	5	46	Sivia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
477	5	46	Llochegua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
478	5	46	Canayre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
479	5	46	Uchuraccay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
480	5	46	Pucacolpa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
481	5	46	Chaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
482	5	47	San Miguel	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
483	5	47	Anco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
484	5	47	Ayna	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
485	5	47	Chilcas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
486	5	47	Chungui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
487	5	47	Luis Carranza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
488	5	47	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
489	5	47	Tambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
490	5	47	Samugari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
491	5	47	Anchihuay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
492	5	47	Oronccoy	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
493	5	48	Puquio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
494	5	48	Aucara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
495	5	48	Cabana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
496	5	48	Carmen Salcedo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
497	5	48	Chaviña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
498	5	48	Chipao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
499	5	48	Huac-Huas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
500	5	48	Laramate	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
501	5	48	Leoncio Prado	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
502	5	48	Llauta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
503	5	48	Lucanas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
504	5	48	Ocaña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
505	5	48	Otoca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
506	5	48	Saisa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
507	5	48	San Cristóbal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
508	5	48	San Juan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
509	5	48	San Pedro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
510	5	48	San Pedro de Palco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
511	5	48	Sancos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
512	5	48	Santa Ana de Huaycahuacho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
513	5	48	Santa Lucia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
514	5	49	Coracora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
515	5	49	Chumpi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
516	5	49	Coronel Castañeda	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
517	5	49	Pacapausa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
518	5	49	Pullo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
519	5	49	Puyusca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
520	5	49	San Francisco de Ravacayco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
521	5	49	Upahuacho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
522	5	50	Pausa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
523	5	50	Colta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
524	5	50	Corculla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
525	5	50	Lampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
526	5	50	Marcabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
527	5	50	Oyolo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
528	5	50	Pararca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
529	5	50	San Javier de Alpabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
530	5	50	San José de Ushua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
531	5	50	Sara Sara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
532	5	51	Querobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
533	5	51	Belén	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
534	5	51	Chalcos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
535	5	51	Chilcayoc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
536	5	51	Huacaña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
537	5	51	Morcolla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
538	5	51	Paico	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
539	5	51	San Pedro de Larcay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
540	5	51	San Salvador de Quije	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
541	5	51	Santiago de Paucaray	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
542	5	51	Soras	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
543	5	52	Huancapi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
544	5	52	Alcamenca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
545	5	52	Apongo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
546	5	52	Asquipata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
547	5	52	Canaria	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
548	5	52	Cayara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
549	5	52	Colca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
550	5	52	Huamanquiquia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
551	5	52	Huancaraylla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
552	5	52	Hualla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
553	5	52	Sarhua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
554	5	52	Vilcanchos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
555	5	53	Vilcas Huaman	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
556	5	53	Accomarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
557	5	53	Carhuanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
558	5	53	Concepción	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
559	5	53	Huambalpa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
560	5	53	Independencia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
561	5	53	Saurama	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
562	5	53	Vischongo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
563	6	54	Cajamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
564	6	54	Asunción	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
565	6	54	Chetilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
566	6	54	Cospan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
567	6	54	Encañada	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
568	6	54	Jesús	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
569	6	54	Llacanora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
570	6	54	Los Baños del Inca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
571	6	54	Magdalena	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
572	6	54	Matara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
573	6	54	Namora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
574	6	54	San Juan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
575	6	55	Cajabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
576	6	55	Cachachi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
577	6	55	Condebamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
578	6	55	Sitacocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
579	6	56	Celendín	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
580	6	56	Chumuch	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
581	6	56	Cortegana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
582	6	56	Huasmin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
583	6	56	Jorge Chávez	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
584	6	56	José Gálvez	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
585	6	56	Miguel Iglesias	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
586	6	56	Oxamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
587	6	56	Sorochuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
588	6	56	Sucre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
589	6	56	Utco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
590	6	56	La Libertad de Pallan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
591	6	57	Chota	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
592	6	57	Anguia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
593	6	57	Chadin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
594	6	57	Chiguirip	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
595	6	57	Chimban	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
596	6	57	Choropampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
597	6	57	Cochabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
598	6	57	Conchan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
599	6	57	Huambos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
600	6	57	Lajas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
601	6	57	Llama	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
602	6	57	Miracosta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
603	6	57	Paccha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
604	6	57	Pion	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
605	6	57	Querocoto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
606	6	57	San Juan de Licupis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
607	6	57	Tacabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
608	6	57	Tocmoche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
609	6	57	Chalamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
610	6	58	Contumaza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
611	6	58	Chilete	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
612	6	58	Cupisnique	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
613	6	58	Guzmango	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
614	6	58	San Benito	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
615	6	58	Santa Cruz de Toledo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
616	6	58	Tantarica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
617	6	58	Yonan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
618	6	59	Cutervo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
619	6	59	Callayuc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
620	6	59	Choros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
621	6	59	Cujillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
622	6	59	La Ramada	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
623	6	59	Pimpingos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
624	6	59	Querocotillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
625	6	59	San Andrés de Cutervo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
626	6	59	San Juan de Cutervo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
627	6	59	San Luis de Lucma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
628	6	59	Santa Cruz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
629	6	59	Santo Domingo de la Capilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
630	6	59	Santo Tomas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
631	6	59	Socota	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
632	6	59	Toribio Casanova	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
633	6	60	Bambamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
634	6	60	Chugur	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
635	6	60	Hualgayoc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
636	6	61	Jaén	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
637	6	61	Bellavista	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
638	6	61	Chontali	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
639	6	61	Colasay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
640	6	61	Huabal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
641	6	61	Las Pirias	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
642	6	61	Pomahuaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
643	6	61	Pucara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
644	6	61	Sallique	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
645	6	61	San Felipe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
646	6	61	San José del Alto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
647	6	61	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
648	6	62	San Ignacio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
649	6	62	Chirinos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
650	6	62	Huarango	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
651	6	62	La Coipa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
652	6	62	Namballe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
653	6	62	San José de Lourdes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
654	6	62	Tabaconas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
655	6	63	San Miguel	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
656	6	63	Bolívar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
657	6	63	Calquis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
658	6	63	Catilluc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
659	6	63	El Prado	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
660	6	63	La Florida	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
661	6	63	Llapa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
662	6	63	Nanchoc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
663	6	63	Niepos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
664	6	63	San Gregorio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
665	6	63	San Silvestre de Cochan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
666	6	63	Tongod	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
667	6	63	Unión Agua Blanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
668	6	64	San Pablo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
669	6	64	San Bernardino	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
670	6	64	San Luis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
671	6	64	Tumbaden	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
672	6	65	Santa Cruz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
673	6	65	Andabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
674	6	65	Catache	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
675	6	65	Chancaybaños	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
676	6	65	La Esperanza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
677	6	65	Ninabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
678	6	65	Pulan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
679	6	65	Saucepampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
680	6	65	Sexi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
681	6	65	Uticyacu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
682	6	65	Yauyucan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
683	7	66	Callao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
684	7	66	Bellavista	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
685	7	66	Carmen de la Legua Reynoso	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
686	7	66	La Perla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
687	7	66	La Punta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
688	7	66	Ventanilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
689	7	66	Mi Perú	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
690	8	67	Cusco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
691	8	67	Ccorca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
692	8	67	Poroy	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
693	8	67	San Jerónimo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
694	8	67	San Sebastian	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
695	8	67	Santiago	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
696	8	67	Saylla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
697	8	67	Wanchaq	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
698	8	68	Acomayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
699	8	68	Acopia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
700	8	68	Acos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
701	8	68	Mosoc Llacta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
702	8	68	Pomacanchi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
703	8	68	Rondocan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
704	8	68	Sangarara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
705	8	69	Anta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
706	8	69	Ancahuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
707	8	69	Cachimayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
708	8	69	Chinchaypujio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
709	8	69	Huarocondo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
710	8	69	Limatambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
711	8	69	Mollepata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
712	8	69	Pucyura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
713	8	69	Zurite	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
714	8	70	Calca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
715	8	70	Coya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
716	8	70	Lamay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
717	8	70	Lares	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
718	8	70	Pisac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
719	8	70	San Salvador	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
720	8	70	Taray	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
721	8	70	Yanatile	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
722	8	71	Yanaoca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
723	8	71	Checca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
724	8	71	Kunturkanki	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
725	8	71	Langui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
726	8	71	Layo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
727	8	71	Pampamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
728	8	71	Quehue	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
729	8	71	Tupac Amaru	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
730	8	72	Sicuani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
731	8	72	Checacupe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
732	8	72	Combapata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
733	8	72	Marangani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
734	8	72	Pitumarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
735	8	72	San Pablo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
736	8	72	San Pedro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
737	8	72	Tinta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
738	8	73	Santo Tomas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
739	8	73	Capacmarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
740	8	73	Chamaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
741	8	73	Colquemarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
742	8	73	Livitaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
743	8	73	Llusco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
744	8	73	Quiñota	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
745	8	73	Velille	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
746	8	74	Espinar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
747	8	74	Condoroma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
748	8	74	Coporaque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
749	8	74	Ocoruro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
750	8	74	Pallpata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
751	8	74	Pichigua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
752	8	74	Suyckutambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
753	8	74	Alto Pichigua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
754	8	75	Santa Ana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
755	8	75	Echarate	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
756	8	75	Huayopata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
757	8	75	Maranura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
758	8	75	Ocobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
759	8	75	Quellouno	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
760	8	75	Kimbiri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
761	8	75	Santa Teresa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
762	8	75	Vilcabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
763	8	75	Pichari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
764	8	75	Inkawasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
765	8	75	Villa Virgen	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
766	8	75	Villa Kintiarina	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
767	8	75	Megantoni	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
768	8	76	Paruro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
769	8	76	Accha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
770	8	76	Ccapi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
771	8	76	Colcha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
772	8	76	Huanoquite	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
773	8	76	Omachaç	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
774	8	76	Paccaritambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
775	8	76	Pillpinto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
776	8	76	Yaurisque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
777	8	77	Paucartambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
778	8	77	Caicay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
779	8	77	Challabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
780	8	77	Colquepata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
781	8	77	Huancarani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
782	8	77	Kosñipata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
783	8	78	Urcos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
784	8	78	Andahuaylillas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
785	8	78	Camanti	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
786	8	78	Ccarhuayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
787	8	78	Ccatca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
788	8	78	Cusipata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
789	8	78	Huaro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
790	8	78	Lucre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
791	8	78	Marcapata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
792	8	78	Ocongate	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
793	8	78	Oropesa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
794	8	78	Quiquijana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
795	8	79	Urubamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
796	8	79	Chinchero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
797	8	79	Huayllabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
798	8	79	Machupicchu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
799	8	79	Maras	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
800	8	79	Ollantaytambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
801	8	79	Yucay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
802	9	80	Huancavelica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
803	9	80	Acobambilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
804	9	80	Acoria	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
805	9	80	Conayca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
806	9	80	Cuenca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
807	9	80	Huachocolpa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
808	9	80	Huayllahuara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
809	9	80	Izcuchaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
810	9	80	Laria	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
811	9	80	Manta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
812	9	80	Mariscal Cáceres	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
813	9	80	Moya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
814	9	80	Nuevo Occoro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
815	9	80	Palca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
816	9	80	Pilchaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
817	9	80	Vilca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
818	9	80	Yauli	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
819	9	80	Ascensión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
820	9	80	Huando	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
821	9	81	Acobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
822	9	81	Andabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
823	9	81	Anta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
824	9	81	Caja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
825	9	81	Marcas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
826	9	81	Paucara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
827	9	81	Pomacocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
828	9	81	Rosario	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
829	9	82	Lircay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
830	9	82	Anchonga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
831	9	82	Callanmarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
832	9	82	Ccochaccasa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
833	9	82	Chincho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
834	9	82	Congalla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
835	9	82	Huanca-Huanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
836	9	82	Huayllay Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
837	9	82	Julcamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
838	9	82	San Antonio de Antaparco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
839	9	82	Santo Tomas de Pata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
840	9	82	Secclla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
841	9	83	Castrovirreyna	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
842	9	83	Arma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
843	9	83	Aurahua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
844	9	83	Capillas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
845	9	83	Chupamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
846	9	83	Cocas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
847	9	83	Huachos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
848	9	83	Huamatambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
849	9	83	Mollepampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
850	9	83	San Juan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
851	9	83	Santa Ana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
852	9	83	Tantara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
853	9	83	Ticrapo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
854	9	84	Churcampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
855	9	84	Anco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
856	9	84	Chinchihuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
857	9	84	El Carmen	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
858	9	84	La Merced	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
859	9	84	Locroja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
860	9	84	Paucarbamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
861	9	84	San Miguel de Mayocc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
862	9	84	San Pedro de Coris	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
863	9	84	Pachamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
864	9	84	Cosme	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
865	9	85	Huaytara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
866	9	85	Ayavi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
867	9	85	Córdova	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
868	9	85	Huayacundo Arma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
869	9	85	Laramarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
870	9	85	Ocoyo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
871	9	85	Pilpichaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
872	9	85	Querco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
873	9	85	Quito-Arma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
874	9	85	San Antonio de Cusicancha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
875	9	85	San Francisco de Sangayaico	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
876	9	85	San Isidro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
877	9	85	Santiago de Chocorvos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
878	9	85	Santiago de Quirahuara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
879	9	85	Santo Domingo de Capillas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
880	9	85	Tambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
881	9	86	Pampas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
882	9	86	Acostambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
883	9	86	Acraquia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
884	9	86	Ahuaycha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
885	9	86	Colcabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
886	9	86	Daniel Hernández	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
887	9	86	Huachocolpa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
888	9	86	Huaribamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
889	9	86	Ñahuimpuquio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
890	9	86	Pazos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
891	9	86	Quishuar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
892	9	86	Salcabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
893	9	86	Salcahuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
894	9	86	San Marcos de Rocchac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
895	9	86	Surcubamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
896	9	86	Tintay Puncu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
897	9	86	Quichuas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
898	9	86	Andaymarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
899	9	86	Roble	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
900	9	86	Pichos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
901	9	86	Santiago de Tucuma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
902	10	87	Huanuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
903	10	87	Amarilis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
904	10	87	Chinchao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
905	10	87	Churubamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
906	10	87	Margos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
907	10	87	Quisqui (Kichki)	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
908	10	87	San Francisco de Cayran	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
909	10	87	San Pedro de Chaulan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
910	10	87	Santa María del Valle	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
911	10	87	Yarumayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
912	10	87	Pillco Marca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
913	10	87	Yacus	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
914	10	87	San Pablo de Pillao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
915	10	88	Ambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
916	10	88	Cayna	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
917	10	88	Colpas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
918	10	88	Conchamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
919	10	88	Huacar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
920	10	88	San Francisco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
921	10	88	San Rafael	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
922	10	88	Tomay Kichwa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
923	10	89	La Unión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
924	10	89	Chuquis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
925	10	89	Marías	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
926	10	89	Pachas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
927	10	89	Quivilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
928	10	89	Ripan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
929	10	89	Shunqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
930	10	89	Sillapata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
931	10	89	Yanas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
932	10	90	Huacaybamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
933	10	90	Canchabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
934	10	90	Cochabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
935	10	90	Pinra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
936	10	91	Llata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
937	10	91	Arancay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
938	10	91	Chavín de Pariarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
939	10	91	Jacas Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
940	10	91	Jircan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
941	10	91	Miraflores	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
942	10	91	Monzón	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
943	10	91	Punchao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
944	10	91	Puños	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
945	10	91	Singa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
946	10	91	Tantamayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
947	10	92	Rupa-Rupa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
948	10	92	Daniel Alomía Robles	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
949	10	92	Hermílio Valdizan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
950	10	92	José Crespo y Castillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
951	10	92	Luyando	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
952	10	92	Mariano Damaso Beraun	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
953	10	92	Pucayacu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
954	10	92	Castillo Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
955	10	92	Pueblo Nuevo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
956	10	92	Santo Domingo de Anda	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
957	10	93	Huacrachuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
958	10	93	Cholon	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
959	10	93	San Buenaventura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
960	10	93	La Morada	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
961	10	93	Santa Rosa de Alto Yanajanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
962	10	94	Panao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
963	10	94	Chaglla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
964	10	94	Molino	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
965	10	94	Umari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
966	10	95	Puerto Inca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
967	10	95	Codo del Pozuzo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
968	10	95	Honoria	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
969	10	95	Tournavista	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
970	10	95	Yuyapichis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
971	10	96	Jesús	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
972	10	96	Baños	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
973	10	96	Jivia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
974	10	96	Queropalca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
975	10	96	Rondos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
976	10	96	San Francisco de Asís	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
977	10	96	San Miguel de Cauri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
978	10	97	Chavinillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
979	10	97	Cahuac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
980	10	97	Chacabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
981	10	97	Aparicio Pomares	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
982	10	97	Jacas Chico	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
983	10	97	Obas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
984	10	97	Pampamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
985	10	97	Choras	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
986	11	98	Ica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
987	11	98	La Tinguiña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
988	11	98	Los Aquijes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
989	11	98	Ocucaje	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
990	11	98	Pachacutec	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
991	11	98	Parcona	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
992	11	98	Pueblo Nuevo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
993	11	98	Salas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
994	11	98	San José de Los Molinos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
995	11	98	San Juan Bautista	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
996	11	98	Santiago	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
997	11	98	Subtanjalla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
998	11	98	Tate	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
999	11	98	Yauca del Rosario	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1000	11	99	Chincha Alta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1001	11	99	Alto Laran	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1002	11	99	Chavin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1003	11	99	Chincha Baja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1004	11	99	El Carmen	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1005	11	99	Grocio Prado	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1006	11	99	Pueblo Nuevo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1007	11	99	San Juan de Yanac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1008	11	99	San Pedro de Huacarpana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1009	11	99	Sunampe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1010	11	99	Tambo de Mora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1011	11	100	Nasca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1012	11	100	Changuillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1013	11	100	El Ingenio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1014	11	100	Marcona	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1015	11	100	Vista Alegre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1016	11	101	Palpa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1017	11	101	Llipata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1018	11	101	Río Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1019	11	101	Santa Cruz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1020	11	101	Tibillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1021	11	102	Pisco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1022	11	102	Huancano	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1023	11	102	Humay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1024	11	102	Independencia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1025	11	102	Paracas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1026	11	102	San Andrés	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1027	11	102	San Clemente	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1028	11	102	Tupac Amaru Inca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1029	12	103	Huancayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1030	12	103	Carhuacallanga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1031	12	103	Chacapampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1032	12	103	Chicche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1033	12	103	Chilca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1034	12	103	Chongos Alto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1035	12	103	Chupuro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1036	12	103	Colca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1037	12	103	Cullhuas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1038	12	103	El Tambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1039	12	103	Huacrapuquio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1040	12	103	Hualhuas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1041	12	103	Huancan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1042	12	103	Huasicancha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1043	12	103	Huayucachi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1044	12	103	Ingenio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1045	12	103	Pariahuanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1046	12	103	Pilcomayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1047	12	103	Pucara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1048	12	103	Quichuay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1049	12	103	Quilcas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1050	12	103	San Agustín	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1051	12	103	San Jerónimo de Tunan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1052	12	103	Saño	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1053	12	103	Sapallanga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1054	12	103	Sicaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1055	12	103	Santo Domingo de Acobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1056	12	103	Viques	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1057	12	104	Concepción	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1058	12	104	Aco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1059	12	104	Andamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1060	12	104	Chambara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1061	12	104	Cochas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1062	12	104	Comas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1063	12	104	Heroínas Toledo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1064	12	104	Manzanares	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1065	12	104	Mariscal Castilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1066	12	104	Matahuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1067	12	104	Mito	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1068	12	104	Nueve de Julio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1069	12	104	Orcotuna	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1070	12	104	San José de Quero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1071	12	104	Santa Rosa de Ocopa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1072	12	105	Chanchamayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1073	12	105	Perene	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1074	12	105	Pichanaqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1075	12	105	San Luis de Shuaro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1076	12	105	San Ramón	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1077	12	105	Vitoc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1078	12	106	Jauja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1079	12	106	Acolla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1080	12	106	Apata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1081	12	106	Ataura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1082	12	106	Canchayllo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1083	12	106	Curicaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1084	12	106	El Mantaro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1085	12	106	Huamali	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1086	12	106	Huaripampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1087	12	106	Huertas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1088	12	106	Janjaillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1089	12	106	Julcán	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1090	12	106	Leonor Ordóñez	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1091	12	106	Llocllapampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1092	12	106	Marco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1093	12	106	Masma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1094	12	106	Masma Chicche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1095	12	106	Molinos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1096	12	106	Monobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1097	12	106	Muqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1098	12	106	Muquiyauyo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1099	12	106	Paca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1100	12	106	Paccha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1101	12	106	Pancan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1102	12	106	Parco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1103	12	106	Pomacancha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1104	12	106	Ricran	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1105	12	106	San Lorenzo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1106	12	106	San Pedro de Chunan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1107	12	106	Sausa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1108	12	106	Sincos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1109	12	106	Tunan Marca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1110	12	106	Yauli	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1111	12	106	Yauyos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1112	12	107	Junin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1113	12	107	Carhuamayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1114	12	107	Ondores	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1115	12	107	Ulcumayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1116	12	108	Satipo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1117	12	108	Coviriali	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1118	12	108	Llaylla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1119	12	108	Mazamari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1120	12	108	Pampa Hermosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1121	12	108	Pangoa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1122	12	108	Río Negro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1123	12	108	Río Tambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1124	12	108	Vizcatan del Ene	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1125	12	109	Tarma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1126	12	109	Acobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1127	12	109	Huaricolca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1128	12	109	Huasahuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1129	12	109	La Unión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1130	12	109	Palca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1131	12	109	Palcamayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1132	12	109	San Pedro de Cajas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1133	12	109	Tapo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1134	12	110	La Oroya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1135	12	110	Chacapalpa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1136	12	110	Huay-Huay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1137	12	110	Marcapomacocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1138	12	110	Morococha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1139	12	110	Paccha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1140	12	110	Santa Bárbara de Carhuacayan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1141	12	110	Santa Rosa de Sacco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1142	12	110	Suitucancha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1143	12	110	Yauli	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1144	12	111	Chupaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1145	12	111	Ahuac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1146	12	111	Chongos Bajo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1147	12	111	Huachac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1148	12	111	Huamancaca Chico	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1149	12	111	San Juan de Iscos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1150	12	111	San Juan de Jarpa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1151	12	111	Tres de Diciembre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1152	12	111	Yanacancha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1153	13	112	Trujillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1154	13	112	El Porvenir	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1155	13	112	Florencia de Mora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1156	13	112	Huanchaco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1157	13	112	La Esperanza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1158	13	112	Laredo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1159	13	112	Moche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1160	13	112	Poroto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1161	13	112	Salaverry	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1162	13	112	Simbal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1163	13	112	Victor Larco Herrera	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1164	13	113	Ascope	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1165	13	113	Chicama	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1166	13	113	Chocope	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1167	13	113	Magdalena de Cao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1168	13	113	Paijan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1169	13	113	Rázuri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1170	13	113	Santiago de Cao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1171	13	113	Casa Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1172	13	114	Bolívar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1173	13	114	Bambamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1174	13	114	Condormarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1175	13	114	Longotea	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1176	13	114	Uchumarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1177	13	114	Ucuncha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1178	13	115	Chepen	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1179	13	115	Pacanga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1180	13	115	Pueblo Nuevo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1181	13	116	Julcan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1182	13	116	Calamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1183	13	116	Carabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1184	13	116	Huaso	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1185	13	117	Otuzco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1186	13	117	Agallpampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1187	13	117	Charat	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1188	13	117	Huaranchal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1189	13	117	La Cuesta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1190	13	117	Mache	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1191	13	117	Paranday	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1192	13	117	Salpo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1193	13	117	Sinsicap	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1194	13	117	Usquil	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1195	13	118	San Pedro de Lloc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1196	13	118	Guadalupe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1197	13	118	Jequetepeque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1198	13	118	Pacasmayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1199	13	118	San José	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1200	13	119	Tayabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1201	13	119	Buldibuyo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1202	13	119	Chillia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1203	13	119	Huancaspata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1204	13	119	Huaylillas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1205	13	119	Huayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1206	13	119	Ongon	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1207	13	119	Parcoy	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1208	13	119	Pataz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1209	13	119	Pias	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1210	13	119	Santiago de Challas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1211	13	119	Taurija	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1212	13	119	Urpay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1213	13	120	Huamachuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1214	13	120	Chugay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1215	13	120	Cochorco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1216	13	120	Curgos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1217	13	120	Marcabal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1218	13	120	Sanagoran	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1219	13	120	Sarin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1220	13	120	Sartimbamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1221	13	121	Santiago de Chuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1222	13	121	Angasmarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1223	13	121	Cachicadan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1224	13	121	Mollebamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1225	13	121	Mollepata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1226	13	121	Quiruvilca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1227	13	121	Santa Cruz de Chuca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1228	13	121	Sitabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1229	13	122	Cascas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1230	13	122	Lucma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1231	13	122	Marmot	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1232	13	122	Sayapullo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1233	13	123	Viru	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1234	13	123	Chao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1235	13	123	Guadalupito	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1236	14	124	Chiclayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1237	14	124	Chongoyape	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1238	14	124	Eten	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1239	14	124	Eten Puerto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1240	14	124	José Leonardo Ortiz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1241	14	124	La Victoria	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1242	14	124	Lagunas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1243	14	124	Monsefu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1244	14	124	Nueva Arica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1245	14	124	Oyotun	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1246	14	124	Picsi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1247	14	124	Pimentel	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1248	14	124	Reque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1249	14	124	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1250	14	124	Saña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1251	14	124	Cayalti	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1252	14	124	Patapo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1253	14	124	Pomalca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1254	14	124	Pucala	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1255	14	124	Tuman	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1256	14	125	Ferreñafe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1257	14	125	Cañaris	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1258	14	125	Incahuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1259	14	125	Manuel Antonio Mesones Muro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1260	14	125	Pitipo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1261	14	125	Pueblo Nuevo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1262	14	126	Lambayeque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1263	14	126	Chochope	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1264	14	126	Illimo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1265	14	126	Jayanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1266	14	126	Mochumi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1267	14	126	Morrope	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1268	14	126	Motupe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1269	14	126	Olmos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1270	14	126	Pacora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1271	14	126	Salas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1272	14	126	San José	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1273	14	126	Tucume	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1274	15	127	Lima	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1275	15	127	Ancón	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1276	15	127	Ate	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1277	15	127	Barranco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1278	15	127	Breña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1279	15	127	Carabayllo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1280	15	127	Chaclacayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1281	15	127	Chorrillos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1282	15	127	Cieneguilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1283	15	127	Comas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1284	15	127	El Agustino	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1285	15	127	Independencia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1286	15	127	Jesús María	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1287	15	127	La Molina	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1288	15	127	La Victoria	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1289	15	127	Lince	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1290	15	127	Los Olivos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1291	15	127	Lurigancho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1292	15	127	Lurin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1293	15	127	Magdalena del Mar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1294	15	127	Pueblo Libre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1295	15	127	Miraflores	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1296	15	127	Pachacamac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1297	15	127	Pucusana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1298	15	127	Puente Piedra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1299	15	127	Punta Hermosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1300	15	127	Punta Negra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1301	15	127	Rímac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1302	15	127	San Bartolo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1303	15	127	San Borja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1304	15	127	San Isidro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1305	15	127	San Juan de Lurigancho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1306	15	127	San Juan de Miraflores	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1307	15	127	San Luis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1308	15	127	San Martín de Porres	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1309	15	127	San Miguel	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1310	15	127	Santa Anita	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1311	15	127	Santa María del Mar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1312	15	127	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1313	15	127	Santiago de Surco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1314	15	127	Surquillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1315	15	127	Villa El Salvador	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1316	15	127	Villa María del Triunfo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1317	15	128	Barranca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1318	15	128	Paramonga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1319	15	128	Pativilca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1320	15	128	Supe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1321	15	128	Supe Puerto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1322	15	129	Cajatambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1323	15	129	Copa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1324	15	129	Gorgor	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1325	15	129	Huancapon	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1326	15	129	Manas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1327	15	130	Canta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1328	15	130	Arahuay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1329	15	130	Huamantanga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1330	15	130	Huaros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1331	15	130	Lachaqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1332	15	130	San Buenaventura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1333	15	130	Santa Rosa de Quives	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1334	15	131	San Vicente de Cañete	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1335	15	131	Asia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1336	15	131	Calango	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1337	15	131	Cerro Azul	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1338	15	131	Chilca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1339	15	131	Coayllo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1340	15	131	Imperial	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1341	15	131	Lunahuana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1342	15	131	Mala	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1343	15	131	Nuevo Imperial	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1344	15	131	Pacaran	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1345	15	131	Quilmana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1346	15	131	San Antonio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1347	15	131	San Luis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1348	15	131	Santa Cruz de Flores	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1349	15	131	Zúñiga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1350	15	132	Huaral	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1351	15	132	Atavillos Alto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1352	15	132	Atavillos Bajo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1353	15	132	Aucallama	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1354	15	132	Chancay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1355	15	132	Ihuari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1356	15	132	Lampian	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1357	15	132	Pacaraos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1358	15	132	San Miguel de Acos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1359	15	132	Santa Cruz de Andamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1360	15	132	Sumbilca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1361	15	132	Veintisiete de Noviembre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1362	15	133	Matucana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1363	15	133	Antioquia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1364	15	133	Callahuanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1365	15	133	Carampoma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1366	15	133	Chicla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1367	15	133	Cuenca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1368	15	133	Huachupampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1369	15	133	Huanza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1370	15	133	Huarochiri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1371	15	133	Lahuaytambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1372	15	133	Langa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1373	15	133	Laraos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1374	15	133	Mariatana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1375	15	133	Ricardo Palma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1376	15	133	San Andrés de Tupicocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1377	15	133	San Antonio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1378	15	133	San Bartolomé	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1379	15	133	San Damian	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1380	15	133	San Juan de Iris	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1381	15	133	San Juan de Tantaranche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1382	15	133	San Lorenzo de Quinti	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1383	15	133	San Mateo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1384	15	133	San Mateo de Otao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1385	15	133	San Pedro de Casta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1386	15	133	San Pedro de Huancayre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1387	15	133	Sangallaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1388	15	133	Santa Cruz de Cocachacra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1389	15	133	Santa Eulalia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1390	15	133	Santiago de Anchucaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1391	15	133	Santiago de Tuna	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1392	15	133	Santo Domingo de Los Olleros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1393	15	133	Surco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1394	15	134	Huacho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1395	15	134	Ambar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1396	15	134	Caleta de Carquin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1397	15	134	Checras	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1398	15	134	Hualmay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1399	15	134	Huaura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1400	15	134	Leoncio Prado	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1401	15	134	Paccho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1402	15	134	Santa Leonor	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1403	15	134	Santa María	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1404	15	134	Sayan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1405	15	134	Vegueta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1406	15	135	Oyon	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1407	15	135	Andajes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1408	15	135	Caujul	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1409	15	135	Cochamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1410	15	135	Navan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1411	15	135	Pachangara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1412	15	136	Yauyos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1413	15	136	Alis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1414	15	136	Allauca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1415	15	136	Ayaviri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1416	15	136	Azángaro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1417	15	136	Cacra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1418	15	136	Carania	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1419	15	136	Catahuasi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1420	15	136	Chocos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1421	15	136	Cochas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1422	15	136	Colonia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1423	15	136	Hongos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1424	15	136	Huampara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1425	15	136	Huancaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1426	15	136	Huangascar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1427	15	136	Huantan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1428	15	136	Huañec	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1429	15	136	Laraos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1430	15	136	Lincha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1431	15	136	Madean	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1432	15	136	Miraflores	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1433	15	136	Omas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1434	15	136	Putinza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1435	15	136	Quinches	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1436	15	136	Quinocay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1437	15	136	San Joaquín	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1438	15	136	San Pedro de Pilas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1439	15	136	Tanta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1440	15	136	Tauripampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1441	15	136	Tomas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1442	15	136	Tupe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1443	15	136	Viñac	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1444	15	136	Vitis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1445	16	137	Iquitos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1446	16	137	Alto Nanay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1447	16	137	Fernando Lores	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1448	16	137	Indiana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1449	16	137	Las Amazonas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1450	16	137	Mazan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1451	16	137	Napo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1452	16	137	Punchana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1453	16	137	Torres Causana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1454	16	137	Belén	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1455	16	137	San Juan Bautista	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1456	16	138	Yurimaguas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1457	16	138	Balsapuerto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1458	16	138	Jeberos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1459	16	138	Lagunas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1460	16	138	Santa Cruz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1461	16	138	Teniente Cesar López Rojas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1462	16	139	Nauta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1463	16	139	Parinari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1464	16	139	Tigre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1465	16	139	Trompeteros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1466	16	139	Urarinas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1467	16	140	Ramón Castilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1468	16	140	Pebas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1469	16	140	Yavari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1470	16	140	San Pablo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1471	16	141	Requena	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1472	16	141	Alto Tapiche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1473	16	141	Capelo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1474	16	141	Emilio San Martín	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1475	16	141	Maquia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1476	16	141	Puinahua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1477	16	141	Saquena	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1478	16	141	Soplin	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1479	16	141	Tapiche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1480	16	141	Jenaro Herrera	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1481	16	141	Yaquerana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1482	16	142	Contamana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1483	16	142	Inahuaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1484	16	142	Padre Márquez	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1485	16	142	Pampa Hermosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1486	16	142	Sarayacu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1487	16	142	Vargas Guerra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1488	16	143	Barranca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1489	16	143	Cahuapanas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1490	16	143	Manseriche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1491	16	143	Morona	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1492	16	143	Pastaza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1493	16	143	Andoas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1494	16	144	Putumayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1495	16	144	Rosa Panduro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1496	16	144	Teniente Manuel Clavero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1497	16	144	Yaguas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1498	17	145	Tambopata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1499	17	145	Inambari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1500	17	145	Las Piedras	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1501	17	145	Laberinto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1502	17	146	Manu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1503	17	146	Fitzcarrald	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1504	17	146	Madre de Dios	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1505	17	146	Huepetuhe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1506	17	147	Iñapari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1507	17	147	Iberia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1508	17	147	Tahuamanu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1509	18	148	Moquegua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1510	18	148	Carumas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1511	18	148	Cuchumbaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1512	18	148	Samegua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1513	18	148	San Cristóbal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1514	18	148	Torata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1515	18	149	Omate	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1516	18	149	Chojata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1517	18	149	Coalaque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1518	18	149	Ichuña	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1519	18	149	La Capilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1520	18	149	Lloque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1521	18	149	Matalaque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1522	18	149	Puquina	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1523	18	149	Quinistaquillas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1524	18	149	Ubinas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1525	18	149	Yunga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1526	18	150	Ilo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1527	18	150	El Algarrobal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1528	18	150	Pacocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1529	19	151	Chaupimarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1530	19	151	Huachon	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1531	19	151	Huariaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1532	19	151	Huayllay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1533	19	151	Ninacaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1534	19	151	Pallanchacra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1535	19	151	Paucartambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1536	19	151	San Francisco de Asís de Yarusyacan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1537	19	151	Simon Bolívar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1538	19	151	Ticlacayan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1539	19	151	Tinyahuarco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1540	19	151	Vicco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1541	19	151	Yanacancha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1542	19	152	Yanahuanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1543	19	152	Chacayan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1544	19	152	Goyllarisquizga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1545	19	152	Paucar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1546	19	152	San Pedro de Pillao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1547	19	152	Santa Ana de Tusi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1548	19	152	Tapuc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1549	19	152	Vilcabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1550	19	153	Oxapampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1551	19	153	Chontabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1552	19	153	Huancabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1553	19	153	Palcazu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1554	19	153	Pozuzo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1555	19	153	Puerto Bermúdez	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1556	19	153	Villa Rica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1557	19	153	Constitución	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1558	20	154	Piura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1559	20	154	Castilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1560	20	154	Catacaos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1561	20	154	Cura Mori	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1562	20	154	El Tallan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1563	20	154	La Arena	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1564	20	154	La Unión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1565	20	154	Las Lomas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1566	20	154	Tambo Grande	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1567	20	154	Veintiseis de Octubre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1568	20	155	Ayabaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1569	20	155	Frias	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1570	20	155	Jilili	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1571	20	155	Lagunas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1572	20	155	Montero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1573	20	155	Pacaipampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1574	20	155	Paimas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1575	20	155	Sapillica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1576	20	155	Sicchez	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1577	20	155	Suyo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1578	20	156	Huancabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1579	20	156	Canchaque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1580	20	156	El Carmen de la Frontera	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1581	20	156	Huarmaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1582	20	156	Lalaquiz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1583	20	156	San Miguel de El Faique	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1584	20	156	Sondor	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1585	20	156	Sondorillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1586	20	157	Chulucanas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1587	20	157	Buenos Aires	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1588	20	157	Chalaco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1589	20	157	La Matanza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1590	20	157	Morropon	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1591	20	157	Salitral	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1592	20	157	San Juan de Bigote	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1593	20	157	Santa Catalina de Mossa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1594	20	157	Santo Domingo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1595	20	157	Yamango	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1596	20	158	Paita	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1597	20	158	Amotape	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1598	20	158	Arenal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1599	20	158	Colan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1600	20	158	La Huaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1601	20	158	Tamarindo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1602	20	158	Vichayal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1603	20	159	Sullana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1604	20	159	Bellavista	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1605	20	159	Ignacio Escudero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1606	20	159	Lancones	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1607	20	159	Marcavelica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1608	20	159	Miguel Checa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1609	20	159	Querecotillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1610	20	159	Salitral	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1611	20	160	Pariñas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1612	20	160	El Alto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1613	20	160	La Brea	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1614	20	160	Lobitos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1615	20	160	Los Organos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1616	20	160	Mancora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1617	20	161	Sechura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1618	20	161	Bellavista de la Unión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1619	20	161	Bernal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1620	20	161	Cristo Nos Valga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1621	20	161	Vice	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1622	20	161	Rinconada Llicuar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1623	21	162	Puno	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1624	21	162	Acora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1625	21	162	Amantani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1626	21	162	Atuncolla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1627	21	162	Capachica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1628	21	162	Chucuito	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1629	21	162	Coata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1630	21	162	Huata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1631	21	162	Mañazo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1632	21	162	Paucarcolla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1633	21	162	Pichacani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1634	21	162	Plateria	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1635	21	162	San Antonio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1636	21	162	Tiquillaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1637	21	162	Vilque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1638	21	163	Azángaro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1639	21	163	Achaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1640	21	163	Arapa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1641	21	163	Asillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1642	21	163	Caminaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1643	21	163	Chupa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1644	21	163	José Domingo Choquehuanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1645	21	163	Muñani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1646	21	163	Potoni	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1647	21	163	Saman	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1648	21	163	San Anton	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1649	21	163	San José	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1650	21	163	San Juan de Salinas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1651	21	163	Santiago de Pupuja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1652	21	163	Tirapata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1653	21	164	Macusani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1654	21	164	Ajoyani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1655	21	164	Ayapata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1656	21	164	Coasa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1657	21	164	Corani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1658	21	164	Crucero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1659	21	164	Ituata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1660	21	164	Ollachea	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1661	21	164	San Gaban	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1662	21	164	Usicayos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1663	21	165	Juli	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1664	21	165	Desaguadero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1665	21	165	Huacullani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1666	21	165	Kelluyo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1667	21	165	Pisacoma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1668	21	165	Pomata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1669	21	165	Zepita	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1670	21	166	Ilave	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1671	21	166	Capazo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1672	21	166	Pilcuyo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1673	21	166	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1674	21	166	Conduriri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1675	21	167	Huancane	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1676	21	167	Cojata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1677	21	167	Huatasani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1678	21	167	Inchupalla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1679	21	167	Pusi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1680	21	167	Rosaspata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1681	21	167	Taraco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1682	21	167	Vilque Chico	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1683	21	168	Lampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1684	21	168	Cabanilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1685	21	168	Calapuja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1686	21	168	Nicasio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1687	21	168	Ocuviri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1688	21	168	Palca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1689	21	168	Paratia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1690	21	168	Pucara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1691	21	168	Santa Lucia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1692	21	168	Vilavila	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1693	21	169	Ayaviri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1694	21	169	Antauta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1695	21	169	Cupi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1696	21	169	Llalli	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1697	21	169	Macari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1698	21	169	Nuñoa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1699	21	169	Orurillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1700	21	169	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1701	21	169	Umachiri	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1702	21	170	Moho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1703	21	170	Conima	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1704	21	170	Huayrapata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1705	21	170	Tilali	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1706	21	171	Putina	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1707	21	171	Ananea	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1708	21	171	Pedro Vilca Apaza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1709	21	171	Quilcapuncu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1710	21	171	Sina	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1711	21	172	Juliaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1712	21	172	Cabana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1713	21	172	Cabanillas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1714	21	172	Caracoto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1715	21	172	San Miguel	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1716	21	173	Sandia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1717	21	173	Cuyocuyo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1718	21	173	Limbani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1719	21	173	Patambuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1720	21	173	Phara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1721	21	173	Quiaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1722	21	173	San Juan del Oro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1723	21	173	Yanahuaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1724	21	173	Alto Inambari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1725	21	173	San Pedro de Putina Punco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1726	21	174	Yunguyo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1727	21	174	Anapia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1728	21	174	Copani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1729	21	174	Cuturapi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1730	21	174	Ollaraya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1731	21	174	Tinicachi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1732	21	174	Unicachi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1733	22	175	Moyobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1734	22	175	Calzada	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1735	22	175	Habana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1736	22	175	Jepelacio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1737	22	175	Soritor	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1738	22	175	Yantalo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1739	22	176	Bellavista	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1740	22	176	Alto Biavo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1741	22	176	Bajo Biavo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1742	22	176	Huallaga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1743	22	176	San Pablo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1744	22	176	San Rafael	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1745	22	177	San José de Sisa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1746	22	177	Agua Blanca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1747	22	177	San Martín	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1748	22	177	Santa Rosa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1749	22	177	Shatoja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1750	22	178	Saposoa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1751	22	178	Alto Saposoa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1752	22	178	El Eslabón	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1753	22	178	Piscoyacu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1754	22	178	Sacanche	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1755	22	178	Tingo de Saposoa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1756	22	179	Lamas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1757	22	179	Alonso de Alvarado	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1758	22	179	Barranquita	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1759	22	179	Caynarachi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1760	22	179	Cuñumbuqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1761	22	179	Pinto Recodo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1762	22	179	Rumisapa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1763	22	179	San Roque de Cumbaza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1764	22	179	Shanao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1765	22	179	Tabalosos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1766	22	179	Zapatero	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1767	22	180	Juanjuí	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1768	22	180	Campanilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1769	22	180	Huicungo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1770	22	180	Pachiza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1771	22	180	Pajarillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1772	22	181	Picota	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1773	22	181	Buenos Aires	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1774	22	181	Caspisapa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1775	22	181	Pilluana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1776	22	181	Pucacaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1777	22	181	San Cristóbal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1778	22	181	San Hilarión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1779	22	181	Shamboyacu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1780	22	181	Tingo de Ponasa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1781	22	181	Tres Unidos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1782	22	182	Rioja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1783	22	182	Awajun	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1784	22	182	Elías Soplin Vargas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1785	22	182	Nueva Cajamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1786	22	182	Pardo Miguel	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1787	22	182	Posic	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1788	22	182	San Fernando	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1789	22	182	Yorongos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1790	22	182	Yuracyacu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1791	22	183	Tarapoto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1792	22	183	Alberto Leveau	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1793	22	183	Cacatachi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1794	22	183	Chazuta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1795	22	183	Chipurana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1796	22	183	El Porvenir	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1797	22	183	Huimbayoc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1798	22	183	Juan Guerra	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1799	22	183	La Banda de Shilcayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1800	22	183	Morales	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1801	22	183	Papaplaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1802	22	183	San Antonio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1803	22	183	Sauce	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1804	22	183	Shapaja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1805	22	184	Tocache	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1806	22	184	Nuevo Progreso	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1807	22	184	Polvora	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1808	22	184	Shunte	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1809	22	184	Uchiza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1810	23	185	Tacna	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1811	23	185	Alto de la Alianza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1812	23	185	Calana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1813	23	185	Ciudad Nueva	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1814	23	185	Inclan	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1815	23	185	Pachia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1816	23	185	Palca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1817	23	185	Pocollay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1818	23	185	Sama	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1819	23	185	Coronel Gregorio Albarracín Lanchipa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1820	23	185	La Yarada los Palos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1821	23	186	Candarave	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1822	23	186	Cairani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1823	23	186	Camilaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1824	23	186	Curibaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1825	23	186	Huanuara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1826	23	186	Quilahuani	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1827	23	187	Locumba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1828	23	187	Ilabaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1829	23	187	Ite	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1830	23	188	Tarata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1831	23	188	Héroes Albarracín	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1832	23	188	Estique	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1833	23	188	Estique-Pampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1834	23	188	Sitajara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1835	23	188	Susapaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1836	23	188	Tarucachi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1837	23	188	Ticaco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1838	24	189	Tumbes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1839	24	189	Corrales	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1840	24	189	La Cruz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1841	24	189	Pampas de Hospital	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1842	24	189	San Jacinto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1843	24	189	San Juan de la Virgen	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1844	24	190	Zorritos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1845	24	190	Casitas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1846	24	190	Canoas de Punta Sal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1847	24	191	Zarumilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1848	24	191	Aguas Verdes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1849	24	191	Matapalo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1850	24	191	Papayal	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1851	25	192	Calleria	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1852	25	192	Campoverde	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1853	25	192	Iparia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1854	25	192	Masisea	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1855	25	192	Yarinacocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1856	25	192	Nueva Requena	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1857	25	192	Manantay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1858	25	193	Raymondi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1859	25	193	Sepahua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1860	25	193	Tahuania	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1861	25	193	Yurua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1862	25	194	Padre Abad	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1863	25	194	Irazola	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1864	25	194	Curimana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1865	25	194	Neshuya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1866	25	194	Alexander Von Humboldt	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
1867	25	195	Purus	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
\.


--
-- TOC entry 5567 (class 0 OID 41321)
-- Dependencies: 454
-- Data for Name: gen_funcionario; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_funcionario (id, dni, nombres, apellidos, cargo, area, credencial_fiscalizador, estado) FROM stdin;
\.


--
-- TOC entry 5490 (class 0 OID 40478)
-- Dependencies: 377
-- Data for Name: gen_habilitacion_urbana; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_habilitacion_urbana (id, estado, id_distrito, id_tipo_habilitacion_urbana, nombre, f_control, h_control, fecha_servidor) FROM stdin;
\.


--
-- TOC entry 5495 (class 0 OID 40553)
-- Dependencies: 382
-- Data for Name: gen_predio; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_predio (id, estado, id_via, id_sector, id_habilitacion_urbana, numero, letra, nombre_predio, id_tipo_interior, nro_interior, manzana, lote, sublote, bloque, edificio, piso, otra_numeracion, nro_partida, f_control, h_control, fecha_servidor, id_departamento, id_provincia, id_distrito) FROM stdin;
\.


--
-- TOC entry 5480 (class 0 OID 40389)
-- Dependencies: 367
-- Data for Name: gen_provincia; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_provincia (id, id_departamento, nombre, f_control, h_control, fecha_servidor) FROM stdin;
1	1	Chachapoyas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
2	1	Bagua	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
3	1	Bongará	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
4	1	Condorcanqui	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
5	1	Luya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
6	1	Rodríguez de Mendoza	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
7	1	Utcubamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
8	2	Huaraz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
9	2	Aija	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
10	2	Antonio Raymondi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
11	2	Asunción	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
12	2	Bolognesi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
13	2	Carhuaz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
14	2	Carlos Fermín Fitzcarrald	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
15	2	Casma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
16	2	Corongo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
17	2	Huari	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
18	2	Huarmey	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
19	2	Huaylas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
20	2	Mariscal Luzuriaga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
21	2	Ocros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
22	2	Pallasca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
23	2	Pomabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
24	2	Recuay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
25	2	Santa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
26	2	Sihuas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
27	2	Yungay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
28	3	Abancay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
29	3	Andahuaylas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
30	3	Antabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
31	3	Aymaraes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
32	3	Cotabambas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
33	3	Chincheros	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
34	3	Grau	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
35	4	Arequipa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
36	4	Camaná	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
37	4	Caravelí	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
38	4	Castilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
39	4	Caylloma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
40	4	Condesuyos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
41	4	Islay	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
42	4	La Unión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
43	5	Huamanga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
44	5	Cangallo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
45	5	Huanca Sancos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
46	5	Huanta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
47	5	La Mar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
48	5	Lucanas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
49	5	Parinacochas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
50	5	Paucar del Sara Sara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
51	5	Sucre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
52	5	Víctor Fajardo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
53	5	Vilcas Huamán	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
54	6	Cajamarca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
55	6	Cajabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
56	6	Celendín	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
57	6	Chota	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
58	6	Contumazá	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
59	6	Cutervo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
60	6	Hualgayoc	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
61	6	Jaén	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
62	6	San Ignacio	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
63	6	San Marcos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
64	6	San Miguel	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
65	6	San Pablo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
66	6	Santa Cruz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
67	7	Callao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
68	8	Cusco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
69	8	Acomayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
70	8	Anta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
71	8	Calca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
72	8	Canas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
73	8	Canchis	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
74	8	Chumbivilcas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
75	8	Espinar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
76	8	La Convención	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
77	8	Paruro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
78	8	Paucartambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
79	8	Quispicanchi	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
80	8	Urubamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
81	9	Huancavelica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
82	9	Acobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
83	9	Angaraes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
84	9	Castrovirreyna	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
85	9	Churcampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
86	9	Huaytará	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
87	9	Tayacaja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
88	10	Huánuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
89	10	Ambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
90	10	Dos de Mayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
91	10	Huacaybamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
92	10	Huamalíes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
93	10	Leoncio Prado	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
94	10	Marañón	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
95	10	Pachitea	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
96	10	Puerto Inca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
97	10	Lauricocha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
98	10	Yarowilca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
99	11	Ica	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
100	11	Chincha	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
101	11	Nazca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
102	11	Palpa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
103	11	Pisco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
104	12	Huancayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
105	12	Concepción	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
106	12	Chanchamayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
107	12	Jauja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
108	12	Junín	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
109	12	Satipo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
110	12	Tarma	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
111	12	Yauli	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
112	12	Chupaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
113	13	Trujillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
114	13	Ascope	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
115	13	Bolívar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
116	13	Chepén	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
117	13	Julcán	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
118	13	Otuzco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
119	13	Pacasmayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
120	13	Pataz	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
121	13	Sánchez Carrión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
122	13	Santiago de Chuco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
123	13	Gran Chimú	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
124	13	Virú	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
125	14	Chiclayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
126	14	Ferreñafe	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
127	14	Lambayeque	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
128	15	Lima	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
129	15	Barranca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
130	15	Cajatambo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
131	15	Canta	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
132	15	Cañete	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
133	15	Huaral	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
134	15	Huarochirí	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
135	15	Huaura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
136	15	Oyón	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
137	15	Yauyos	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
138	16	Maynas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
139	16	Alto Amazonas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
140	16	Loreto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
141	16	Mariscal Ramón Castilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
142	16	Requena	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
143	16	Ucayali	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
144	16	Datem del Marañón	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
145	16	Putumayo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
146	17	Tambopata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
147	17	Manu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
148	17	Tahuamanu	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
149	18	Mariscal Nieto	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
150	18	General Sánchez Cerro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
151	18	Ilo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
152	19	Pasco	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
153	19	Daniel Alcides Carrión	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
154	19	Oxapampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
155	20	Piura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
156	20	Ayabaca	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
157	20	Huancabamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
158	20	Morropón	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
159	20	Paita	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
160	20	Sullana	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
161	20	Talara	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
162	20	Sechura	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
163	21	Puno	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
164	21	Azángaro	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
165	21	Carabaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
166	21	Chucuito	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
167	21	El Collao	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
168	21	Huancané	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
169	21	Lampa	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
170	21	Melgar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
171	21	Moho	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
172	21	San Antonio de Putina	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
173	21	San Román	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
174	21	Sandia	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
175	21	Yunguyo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
176	22	Moyobamba	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
177	22	Bellavista	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
178	22	El Dorado	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
179	22	Huallaga	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
180	22	Lamas	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
181	22	Mariscal Cáceres	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
182	22	Picota	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
183	22	Rioja	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
184	22	San Martín	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
185	22	Tocache	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
186	23	Tacna	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
187	23	Candarave	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
188	23	Jorge Basadre	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
189	23	Tarata	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
190	24	Tumbes	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
191	24	Contralmirante Villar	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
192	24	Zarumilla	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
193	25	Coronel Portillo	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
194	25	Atalaya	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
195	25	Padre Abad	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
196	25	Purús	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
\.


--
-- TOC entry 5483 (class 0 OID 40425)
-- Dependencies: 370
-- Data for Name: gen_sector; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_sector (id, estado, id_distrito, nombre, f_control, h_control, fecha_servidor) FROM stdin;
\.


--
-- TOC entry 5489 (class 0 OID 40467)
-- Dependencies: 376
-- Data for Name: gen_tipo_habilitacion_urbana; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_tipo_habilitacion_urbana (id, nombre, abreviacion, f_control, h_control, fecha_servidor) FROM stdin;
1	ASENTAMIENTO HUMANO	AAHH	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
2	AGRUPAMIENTO	AGRUP.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
3	CONJUNTO HABITACIONAL	C.H.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
4	CONJUNTO RESIDENCIAL	C.R.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
5	PUEBLO JOVEN	P.J.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
6	URBANIZACION	URB	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
7	URBANIZACION POPULAR	URB.P	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
8	CERCADO	CRCAD	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
9	HACIENDA	HACIN	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
10	ASOCIACION	ASOC	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
11	COOPERATIVA	COOP	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
12	LOTIZACION	LOTIZ	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
13	PARCELA	PARCL	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
14	VALLE	VALLE	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
15	CASERIO	CASRI	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
16	UNIDAD VECINAL	U.V.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
17	COMUNIDAD	COMUN	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
18	BARRIO	BARRI	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
19	FUNDO	FUNDO	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
20	ASOCIACION DE VIVIENDA	AS.VI	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
21	COOPERATIVA DE VIVIENDA	COOP.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
22	ASOCIACION PRO VIVIENDA	AS.PV	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
23	CENTRO POBLADO	C.P.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
24	GRUPO RESIDENCIAL	G.R.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
25	HABILITACION	HAB	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
\.


--
-- TOC entry 5487 (class 0 OID 40454)
-- Dependencies: 374
-- Data for Name: gen_tipo_interior; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_tipo_interior (id, nombre, especificar_otros, f_control, h_control, fecha_servidor) FROM stdin;
1	DEPARTAMENTO	f	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
2	CASA/CHALET	f	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
3	OFICINA	f	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
4	ESTACIONAMIENTO	f	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
5	DEPOSITO	f	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
6	TENDAL	f	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
7	TIENDA	f	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
8	PUESTO	f	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
9	STAND	f	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
\.


--
-- TOC entry 5485 (class 0 OID 40442)
-- Dependencies: 372
-- Data for Name: gen_tipo_via; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_tipo_via (id, nombre, abreviacion, f_control, h_control, fecha_servidor) FROM stdin;
1	Avenida	AV.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
2	Calle	CA.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
3	JIRON	JR.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
4	PASAJE	PJE.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
5	ALAMEDA	AL.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
6	CARRETERA	CTRA.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
7	PROLONGACION	PRLG.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
8	PASEO	PS.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
9	MALECON	ML.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
10	CAMINO	CAM.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
11	TIENDA	TIEND	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
12	VIA	VIA	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
13	QUEBRADA	QUEB.	2025-11-27	02:53:19.908294	2025-11-27 02:53:19.908294
\.


--
-- TOC entry 5491 (class 0 OID 40499)
-- Dependencies: 378
-- Data for Name: gen_via; Type: TABLE DATA; Schema: gen; Owner: admin
--

COPY gen.gen_via (id, estado, id_habilitacion_urbana, id_sector, id_tipo_via, nombre, f_control, h_control, fecha_servidor) FROM stdin;
\.


--
-- TOC entry 5358 (class 0 OID 36432)
-- Dependencies: 245
-- Data for Name: antecedente_cumplimiento; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.antecedente_cumplimiento (id_ant_cumplimiento, id_historia, dentista_dolor, frecuenca_dentista, higiene_oral, tranquilo, nervioso, panico, desagrado_atencion) FROM stdin;
\.


--
-- TOC entry 5357 (class 0 OID 36422)
-- Dependencies: 244
-- Data for Name: antecedente_familiar; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.antecedente_familiar (id_ant_fam, id_historia, descripcion) FROM stdin;
\.


--
-- TOC entry 5356 (class 0 OID 36412)
-- Dependencies: 243
-- Data for Name: antecedente_medico; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.antecedente_medico (id_ant_patologico, id_historia, salud_general, bajo_tratamiento, tipo_tratamiento, hospitalizaciones, traumatismos, alergias, medicamentos_contraindicados, odontologicos) FROM stdin;
\.


--
-- TOC entry 5355 (class 0 OID 36402)
-- Dependencies: 242
-- Data for Name: antecedente_personal; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.antecedente_personal (id_antecedente, id_historia, esta_embarazada, mac, otros, psicosocial, vacunas, hepatitis_b, id_grupo_sanguineo, fuma, cigarrillos_dia, toma_te, tazas_te_dia, toma_alcohol, frecuencia_alcohol, aprieta_dientes, momento_aprieta, rechina, dolor_muscular, chupa_dedo, muerde_objetos, muerde_labios, otros_habitos, frecuencia_cepillado) FROM stdin;
\.


--
-- TOC entry 5366 (class 0 OID 36524)
-- Dependencies: 253
-- Data for Name: auditoria; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.auditoria (id_auditoria, id_usuario, fecha_cambio, nombre_tabla, id_registro_afectado, accion, datos_anteriores, datos_nuevos, ip_address, user_agent) FROM stdin;
\.


--
-- TOC entry 5345 (class 0 OID 36308)
-- Dependencies: 232
-- Data for Name: catalogo_clinica; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_clinica (id_clinica, nombre) FROM stdin;
\.


--
-- TOC entry 5342 (class 0 OID 36290)
-- Dependencies: 229
-- Data for Name: catalogo_enfermedad; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_enfermedad (id_enfermedad, nombre) FROM stdin;
\.


--
-- TOC entry 5339 (class 0 OID 36266)
-- Dependencies: 226
-- Data for Name: catalogo_estado_civil; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_estado_civil (id_estado_civil, descripcion) FROM stdin;
\.


--
-- TOC entry 5347 (class 0 OID 36320)
-- Dependencies: 234
-- Data for Name: catalogo_estado_revision; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_estado_revision (id_estado_revision, nombre) FROM stdin;
\.


--
-- TOC entry 5344 (class 0 OID 36302)
-- Dependencies: 231
-- Data for Name: catalogo_examen_auxiliar; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_examen_auxiliar (id_examen, descripcion) FROM stdin;
\.


--
-- TOC entry 5340 (class 0 OID 36274)
-- Dependencies: 227
-- Data for Name: catalogo_grado_instruccion; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_grado_instruccion (id_grado_instruccion, descripcion) FROM stdin;
\.


--
-- TOC entry 5346 (class 0 OID 36314)
-- Dependencies: 233
-- Data for Name: catalogo_grupo_sanguineo; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_grupo_sanguineo (id_grupo_sanguineo, descripcion) FROM stdin;
\.


--
-- TOC entry 5343 (class 0 OID 36296)
-- Dependencies: 230
-- Data for Name: catalogo_habito; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_habito (id_habito, nombre) FROM stdin;
\.


--
-- TOC entry 5341 (class 0 OID 36282)
-- Dependencies: 228
-- Data for Name: catalogo_ocupacion; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_ocupacion (id_ocupacion, descripcion) FROM stdin;
\.


--
-- TOC entry 5338 (class 0 OID 36258)
-- Dependencies: 225
-- Data for Name: catalogo_sexo; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.catalogo_sexo (id_sexo, descripcion) FROM stdin;
\.


--
-- TOC entry 5363 (class 0 OID 36495)
-- Dependencies: 250
-- Data for Name: diagnostico; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.diagnostico (id_diagnostico, id_historia, descripcion, definitivo, fecha) FROM stdin;
\.


--
-- TOC entry 5354 (class 0 OID 36392)
-- Dependencies: 241
-- Data for Name: enfermedad_actual; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.enfermedad_actual (id_enfermedad_actual, id_historia, sintoma_principal, tiempo_enfermedad, forma_inicio, curso, relato, tratamiento_prev) FROM stdin;
\.


--
-- TOC entry 5365 (class 0 OID 36515)
-- Dependencies: 252
-- Data for Name: evolucion; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.evolucion (id_evolucion, id_historia, fecha, actividad, alumno, observaciones) FROM stdin;
\.


--
-- TOC entry 5362 (class 0 OID 36487)
-- Dependencies: 249
-- Data for Name: examen_auxiliar; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.examen_auxiliar (id_examen_auxiliar, id_historia, id_examen, detalle, fecha_solicitud) FROM stdin;
\.


--
-- TOC entry 5361 (class 0 OID 36472)
-- Dependencies: 248
-- Data for Name: examen_clinico_boca; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.examen_clinico_boca (id_boca, id_historia, labios_sin_lesiones, labios_con_lesiones, vestibulo_sin_lesiones, vestibulo_con_lesiones, carrillos_retromolar_sin_lesiones, carrillos_retromolar_con_lesiones, paladar_sin_lesiones, paladar_con_lesiones, orofaringe_sin_lesiones, orofaringe_con_lesiones, piso_boca_sin_lesiones, piso_boca_con_lesiones, lengua_sin_lesiones, lengua_con_lesiones, encia_sin_lesiones, encia_con_lesiones, oclusion_molar_der, oclusion_molar_izq, oclusion_canina_der, oclusion_canina_izq, oclusion_mordida_cruzada, oclusion_vestibuloclusion, oclusion_overbite, oclusion_mordida_abierta, oclusion_sobremordida, oclusion_relacion_vertical_otros, oclusion_overjet, oclusion_protrusion, oclusion_guia_incisiva, oclusion_contacto_posterior, lat_der_guia_canina, lat_der_funcion_grupo, lat_der_contacto_balance, lat_der_describa, lat_izq_guia_canina, lat_izq_funcion_grupo, lat_izq_contacto_balance, lat_izq_describa) FROM stdin;
\.


--
-- TOC entry 5359 (class 0 OID 36442)
-- Dependencies: 246
-- Data for Name: examen_general; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.examen_general (id_examen, id_historia, posicion, actitud, deambulacion, facies, facies_obs, conciencia, constitucion, estado_nutritivo, temperatura, presion_arterial, frecuencia_respiratoria, pulso, peso, talla, piel_color, piel_humedad, piel_lesiones, piel_lesiones_obs, piel_anexos, piel_anexos_obs, tcs_distribucion, tcs_distribucion_obs, tcs_cantidad, ganglios, ganglios_obs) FROM stdin;
\.


--
-- TOC entry 5360 (class 0 OID 36457)
-- Dependencies: 247
-- Data for Name: examen_regional; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.examen_regional (id_regional, id_historia, cabeza_posicion, cabeza_movimientos, cabeza_movimientos_obs, craneo_tamano, craneo_forma, cara_forma_frente, cara_forma_perfil, ojos_cejas_adecuada, ojos_implantacion_obs, ojos_escleroticas, ojos_agudeza_visual, ojos_iris_color, ojos_arco_senil, nariz_forma, nariz_permeables, nariz_secreciones, nariz_senos_dolorosos, oidos_anomalias_morfologicas, oidos_anomalias_obs, oidos_secreciones, oidos_audicion_conservada, atm_trayectoria, atm_lat_izq_dolor, atm_lat_izq_ruido, atm_lat_izq_salto, atm_lat_der_dolor, atm_lat_der_ruido, atm_lat_der_salto, atm_prot_dolor, atm_prot_ruido, atm_prot_salto, atm_aper_dolor, atm_aper_ruido, atm_aper_salto, atm_cierre_dolor, atm_cierre_ruido, atm_cierre_salto, atm_coordinacion_condilar, atm_apertura_maxima_mm, atm_observaciones, atm_musculos_dolor, atm_musculos_dolor_grado, atm_musculos_dolor_zona, cuello_simetrico, cuello_simetrico_obs, cuello_movilidad_conservada, cuello_movilidad_obs, laringe_alineada, laringe_alineada_obs, cuello_otros) FROM stdin;
\.


--
-- TOC entry 5352 (class 0 OID 36373)
-- Dependencies: 239
-- Data for Name: filiacion; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.filiacion (id_filiacion, id_historia, raza, fecha_nacimiento, lugar, id_estado_civil, nombre_conyuge, id_ocupacion, lugar_procedencia, tiempo_residencia_tacna, direccion, id_grado_instruccion, ultima_visita_dentista, motivo_visita_dentista, ultima_visita_medico, motivo_visita_medico, contacto_emergencia, telefono_emergencia, acompaniante) FROM stdin;
\.


--
-- TOC entry 5350 (class 0 OID 36353)
-- Dependencies: 237
-- Data for Name: historia_clinica; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.historia_clinica (id_historia, id_paciente, id_estudiante, fecha_elaboracion, ultima_modificacion, estado) FROM stdin;
\.


--
-- TOC entry 5353 (class 0 OID 36383)
-- Dependencies: 240
-- Data for Name: motivo_consulta; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.motivo_consulta (id_motivo, id_historia, motivo, fecha_registro) FROM stdin;
\.


--
-- TOC entry 5349 (class 0 OID 36341)
-- Dependencies: 236
-- Data for Name: paciente; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.paciente (id_paciente, nombre, apellido, dni, fecha_nacimiento, id_sexo, telefono, email, fecha_registro, activo) FROM stdin;
\.


--
-- TOC entry 5364 (class 0 OID 36505)
-- Dependencies: 251
-- Data for Name: referencia_clinica; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.referencia_clinica (id_ref, id_historia, id_clinica, observaciones, fecha, estado) FROM stdin;
\.


--
-- TOC entry 5351 (class 0 OID 36364)
-- Dependencies: 238
-- Data for Name: revision_historia; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.revision_historia (id_revision, id_historia, id_docente, fecha, id_estado_revision, observaciones) FROM stdin;
\.


--
-- TOC entry 5348 (class 0 OID 36326)
-- Dependencies: 235
-- Data for Name: usuario; Type: TABLE DATA; Schema: hcl; Owner: admin
--

COPY hcl.usuario (id_usuario, codigo_usuario, nombre, apellido, dni, email, rol, contrasena_hash, activo) FROM stdin;
\.


--
-- TOC entry 5430 (class 0 OID 38971)
-- Dependencies: 317
-- Data for Name: imp_arancel_urbano; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_arancel_urbano (id_arancel_urbano, anio, valor_arancel_m2, direccion_predio) FROM stdin;
\.


--
-- TOC entry 5470 (class 0 OID 39317)
-- Dependencies: 357
-- Data for Name: imp_area_rustica; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_area_rustica (id_area_rustica, id_grupo_tierra_detalle, id_categoria_terreno, valor) FROM stdin;
\.


--
-- TOC entry 5402 (class 0 OID 38797)
-- Dependencies: 289
-- Data for Name: imp_asociacion; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_asociacion (id_asociacion, estado, nombre_asociacion, id_distrito) FROM stdin;
\.


--
-- TOC entry 5437 (class 0 OID 39006)
-- Dependencies: 324
-- Data for Name: imp_categoria_edificacion; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_categoria_edificacion (id_categoria, descripcion, muros_y_columnas, techos, pisos, puertas_ventanas, revestimiento, banos, instalaciones_electricas_sanitarias) FROM stdin;
\.


--
-- TOC entry 5426 (class 0 OID 38955)
-- Dependencies: 313
-- Data for Name: imp_categoria_terreno; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_categoria_terreno (id_categoria_terreno, denominacion) FROM stdin;
\.


--
-- TOC entry 5422 (class 0 OID 38941)
-- Dependencies: 309
-- Data for Name: imp_categoria_terreno_ext; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_categoria_terreno_ext (id_categoria_terreno_ext, categoria, abreviacion) FROM stdin;
\.


--
-- TOC entry 5420 (class 0 OID 38934)
-- Dependencies: 307
-- Data for Name: imp_clasificacion_terreno; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_clasificacion_terreno (id_clasificacion_terreno, denominacion) FROM stdin;
\.


--
-- TOC entry 5407 (class 0 OID 38836)
-- Dependencies: 294
-- Data for Name: imp_contribuyente; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_contribuyente (codigo, estado, tipo_persona, genero, fecha_nacimiento, dni, ruc, otros_doc_ident, nro_doc_ident, nombres_razon_social, observaciones, telefono_fijo, celular, celular_whatsapp, correo_electronico, fecha_creacion, codigo_anterior, doc_ident_rep_legal, nro_doc_rep_legal) FROM stdin;
\.


--
-- TOC entry 5476 (class 0 OID 39363)
-- Dependencies: 363
-- Data for Name: imp_cuenta_corriente; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_cuenta_corriente (id_movimiento, codigo_contribuyente, anio, fecha_registro, tipo_movimiento, concepto, monto, saldo, id_origen_dj, id_origen_pago) FROM stdin;
\.


--
-- TOC entry 5456 (class 0 OID 39146)
-- Dependencies: 343
-- Data for Name: imp_declaracion_jurada; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_declaracion_jurada (id_declaracion_jurada, codigo_contribuyente, id_motivo_dj, estado, anio, fecha_recepcion, otros_motivos_declaracion, total_predios_declarados, anio_desde, trimestre_desde, fecha_declaracion, total_base_imponible, impuesto_anual, impuesto_trimestral, observaciones, total_multa, total_multa_descuento) FROM stdin;
\.


--
-- TOC entry 5390 (class 0 OID 38726)
-- Dependencies: 277
-- Data for Name: imp_departamento; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_departamento (id_departamento, nombre) FROM stdin;
\.


--
-- TOC entry 5444 (class 0 OID 39050)
-- Dependencies: 331
-- Data for Name: imp_depreciacion; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_depreciacion (id_depreciacion, anio, clasificacion, material_predominante, antiguedad_anios, muy_bueno, bueno, regular, malo, muy_malo) FROM stdin;
\.


--
-- TOC entry 5394 (class 0 OID 38745)
-- Dependencies: 281
-- Data for Name: imp_distrito; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_distrito (id_distrito, id_provincia, nombre) FROM stdin;
\.


--
-- TOC entry 5458 (class 0 OID 39165)
-- Dependencies: 345
-- Data for Name: imp_dj_predio; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_dj_predio (id_dj_predio, id_declaracion_jurada, id_predio, id_tipo_registro_predio, direccion_predio, condicion_propiedad, id_uso_predio, porcentaje_co_propiedad, luz, agua, licencia_construccion, conformidad_obra, declaracion_fabrica, sustento, fecha_adquisicion, area_terreno, area_comun, id_arancel_urbano, partida_registral, total_area_construida, total_area_instalacion, autoavaluo_copropietario, valor_tconstruccion, valor_tinstalacion, valor_terreno, total_autoavaluo, base_imponible, url_foto_dj, id_valor_exoneracion) FROM stdin;
\.


--
-- TOC entry 5411 (class 0 OID 38854)
-- Dependencies: 298
-- Data for Name: imp_domicilio_fiscal_contribuyente; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_domicilio_fiscal_contribuyente (id_domicilio, codigo_contribuyente, id_distrito, id_via, id_sector, id_habilitacion, id_asociacion, numero, letra, id_tipo_interior, numero_interior, manzana, lote, sublote, bloque, edificio, piso, numeracion_ampliada, direccion_fiscal, referencia_direccion) FROM stdin;
\.


--
-- TOC entry 5436 (class 0 OID 38998)
-- Dependencies: 323
-- Data for Name: imp_escala_impuesto; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_escala_impuesto (id_escala_impuesto, anio, desde_autovaluo, hasta_autovaluo, tasa_impuesto, impuesto_acumulado) FROM stdin;
\.


--
-- TOC entry 5428 (class 0 OID 38962)
-- Dependencies: 315
-- Data for Name: imp_estado_conservacion; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_estado_conservacion (id_estado_conservacion, codigo, denominacion, factor_depreciacion) FROM stdin;
\.


--
-- TOC entry 5446 (class 0 OID 39059)
-- Dependencies: 333
-- Data for Name: imp_exoneracion; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_exoneracion (id_exoneracion, estado, tributo, descripcion, abreviacion, requiere_sustento) FROM stdin;
\.


--
-- TOC entry 5424 (class 0 OID 38948)
-- Dependencies: 311
-- Data for Name: imp_grupo_tierra; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_grupo_tierra (id_grupo_tierra, denominacion) FROM stdin;
\.


--
-- TOC entry 5468 (class 0 OID 39305)
-- Dependencies: 355
-- Data for Name: imp_grupo_tierra_detalle; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_grupo_tierra_detalle (id_grupo_tierra_detalle, id_grupo_tierra, denominacion, activo, eliminado, usuario_ingreso, fecha_ingreso) FROM stdin;
\.


--
-- TOC entry 5400 (class 0 OID 38778)
-- Dependencies: 287
-- Data for Name: imp_habilitacion_urbana; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_habilitacion_urbana (id_habilitacion, estado, nombre_habilitacion, numero_partida, id_tipo_habilitacion, id_distrito) FROM stdin;
\.


--
-- TOC entry 5452 (class 0 OID 39094)
-- Dependencies: 339
-- Data for Name: imp_junta_vecinal; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_junta_vecinal (id_junta_vecinal, descripcion) FROM stdin;
\.


--
-- TOC entry 5416 (class 0 OID 38915)
-- Dependencies: 303
-- Data for Name: imp_material_estructural_predio; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_material_estructural_predio (id_material_estructural_predio, codigo, denominacion, valor_referencia) FROM stdin;
\.


--
-- TOC entry 5418 (class 0 OID 38924)
-- Dependencies: 305
-- Data for Name: imp_motivo_dj; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_motivo_dj (id_motivo_dj, codigo, denominacion, abreviatura, transferencia) FROM stdin;
\.


--
-- TOC entry 5412 (class 0 OID 38897)
-- Dependencies: 299
-- Data for Name: imp_nivel; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_nivel (id_nivel, codigo, denominacion, incremento_sp, aplicar_5_por_ciento) FROM stdin;
\.


--
-- TOC entry 5440 (class 0 OID 39029)
-- Dependencies: 327
-- Data for Name: imp_obra_complementaria; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_obra_complementaria (id_obra, descripcion, componente, unidad) FROM stdin;
\.


--
-- TOC entry 5472 (class 0 OID 39334)
-- Dependencies: 359
-- Data for Name: imp_pago; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_pago (id_pago, declaracion_predio_id, cuota, fecha_vencimiento, monto, monto_pagado, fecha_pago, estado, id_vencimiento_emision) FROM stdin;
\.


--
-- TOC entry 5474 (class 0 OID 39354)
-- Dependencies: 361
-- Data for Name: imp_param_moratorio; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_param_moratorio (id_param_moratorio, anio, factor_ipm, tasa_tim) FROM stdin;
\.


--
-- TOC entry 5434 (class 0 OID 38987)
-- Dependencies: 321
-- Data for Name: imp_param_principales; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_param_principales (id_param_principal, anio, numero_cuponeras, porcentaje_quinta, valor_uit, moneda, cuotas, impuesto_minimo, tope_emision, porcentaje_incremento, factor_oficializacion_otras_instalaciones, glosa_base_legal) FROM stdin;
\.


--
-- TOC entry 5454 (class 0 OID 39101)
-- Dependencies: 341
-- Data for Name: imp_predio; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_predio (id_predio, estado, id_distrito, id_via, id_sector, id_habilitacion, id_asociacion, numero, letra, nombre_predio, id_tipo_interior, numero_interior, manzana, lote, sublote, bloque, edificio, piso, numeracion_ampliada, id_junta_vecinal, observaciones) FROM stdin;
\.


--
-- TOC entry 5460 (class 0 OID 39205)
-- Dependencies: 347
-- Data for Name: imp_predio_colindante; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_predio_colindante (id_predio_colindante, id_dj_predio, predio_norte, propietario_norte, medida_norte, predio_sur, propietario_sur, medida_sur, predio_este, propietario_este, medida_este, predio_oeste, propietario_oeste, medida_oeste) FROM stdin;
\.


--
-- TOC entry 5462 (class 0 OID 39219)
-- Dependencies: 349
-- Data for Name: imp_predio_construccion; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_predio_construccion (id_predio_construccion, id_dj_predio, id_nivel, id_material_estructural_predio, id_depreciacion, id_categoria_edificacion, antiguedad, area_construida, valor_unitario, valor_depreciado, valor_total_construccion) FROM stdin;
\.


--
-- TOC entry 5466 (class 0 OID 39273)
-- Dependencies: 353
-- Data for Name: imp_predio_otra_instalacion; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_predio_otra_instalacion (id_predio_otra_instalacion, id_dj_predio, id_nivel, id_material_estructural_predio, id_obra_complementaria, id_depreciacion, antiguedad, area, valor_instalacion) FROM stdin;
\.


--
-- TOC entry 5464 (class 0 OID 39251)
-- Dependencies: 351
-- Data for Name: imp_predio_terreno; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_predio_terreno (id_predio_terreno, id_dj_predio, id_clasificacion_terreno, id_categoria_terreno_ext, arancel, cantidad, valor) FROM stdin;
\.


--
-- TOC entry 5392 (class 0 OID 38733)
-- Dependencies: 279
-- Data for Name: imp_provincia; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_provincia (id_provincia, id_departamento, nombre) FROM stdin;
\.


--
-- TOC entry 5396 (class 0 OID 38757)
-- Dependencies: 283
-- Data for Name: imp_sector; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_sector (id_sector, estado, nombre_sector, id_distrito) FROM stdin;
\.


--
-- TOC entry 5398 (class 0 OID 38771)
-- Dependencies: 285
-- Data for Name: imp_tipo_habilitacion_urbana; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_tipo_habilitacion_urbana (id_tipo_habilitacion, descripcion, abreviacion) FROM stdin;
\.


--
-- TOC entry 5409 (class 0 OID 38845)
-- Dependencies: 296
-- Data for Name: imp_tipo_interior; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_tipo_interior (id_tipo_interior, descripcion, otros) FROM stdin;
\.


--
-- TOC entry 5414 (class 0 OID 38907)
-- Dependencies: 301
-- Data for Name: imp_tipo_registro_predio; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_tipo_registro_predio (id_tipo_registro_predio, denominacion, activo) FROM stdin;
\.


--
-- TOC entry 5404 (class 0 OID 38811)
-- Dependencies: 291
-- Data for Name: imp_tipo_via; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_tipo_via (id_tipo_via, tipo_via, abreviacion) FROM stdin;
\.


--
-- TOC entry 5432 (class 0 OID 38980)
-- Dependencies: 319
-- Data for Name: imp_uso_predio; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_uso_predio (id_uso, estado, descripcion_uso) FROM stdin;
\.


--
-- TOC entry 5448 (class 0 OID 39069)
-- Dependencies: 335
-- Data for Name: imp_valor_exoneracion; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_valor_exoneracion (id_valor_exoneracion, anio, id_exoneracion, monto_exonerado, porcentaje_exonerado) FROM stdin;
\.


--
-- TOC entry 5439 (class 0 OID 39014)
-- Dependencies: 326
-- Data for Name: imp_valor_unitario_edificacion; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_valor_unitario_edificacion (id_valor_unitario_edificacion, anio, id_categoria, muros_y_columnas, techos, pisos, puertas_ventanas, revestimientos, banos, instalaciones_electricas_sanitarias, base_legal) FROM stdin;
\.


--
-- TOC entry 5442 (class 0 OID 39036)
-- Dependencies: 329
-- Data for Name: imp_valor_unitario_obra; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_valor_unitario_obra (id_valor_unitario_obra, anio, id_obra, valor_unitario) FROM stdin;
\.


--
-- TOC entry 5450 (class 0 OID 39083)
-- Dependencies: 337
-- Data for Name: imp_vencimiento_emision; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_vencimiento_emision (id_vencimiento_emision, tributo, anio, periodo, fecha_vencimiento, fecha_prorroga, base_legal, derecho_emision, costo_por_predio, cantidad_predios_exceso) FROM stdin;
\.


--
-- TOC entry 5406 (class 0 OID 38818)
-- Dependencies: 293
-- Data for Name: imp_via; Type: TABLE DATA; Schema: imp; Owner: admin
--

COPY imp.imp_via (id_via, estado, nombre_via, id_tipo_via, id_distrito) FROM stdin;
\.


--
-- TOC entry 5514 (class 0 OID 40732)
-- Dependencies: 401
-- Data for Name: lic_actividad_comercial; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_actividad_comercial (id, nombre, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
1	INDUSTRIA	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
2	COMERCIO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
3	SERVICIOS	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
4	CATEGORIA A	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
5	CATEGORIA B	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
6	CATEGORIA C	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
7	CATEGORIA D	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
8	SALUD	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
\.


--
-- TOC entry 5512 (class 0 OID 40717)
-- Dependencies: 399
-- Data for Name: lic_condicion_local; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_condicion_local (id, nombre, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
1	PROPIETARIO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
2	INQUILINO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
3	OTROS	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
\.


--
-- TOC entry 5524 (class 0 OID 40812)
-- Dependencies: 411
-- Data for Name: lic_documento; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_documento (id, id_requisito, descripcion, num_documento, fecha, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
\.


--
-- TOC entry 5522 (class 0 OID 40793)
-- Dependencies: 409
-- Data for Name: lic_giro_licencia; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_giro_licencia (id, id_giro_negocio, desde, hasta, detalles, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
\.


--
-- TOC entry 5518 (class 0 OID 40762)
-- Dependencies: 405
-- Data for Name: lic_giro_negocio; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_giro_negocio (id, nombre, monto, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
1	EMPRESAS MINERAS	3200.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
2	EMPRESAS PESQUERAS	3200.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
3	EMPRESAS DE ENERGIA ELECTRICA	3200.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
4	EMP. DE GAS Y AFINES	3200.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
5	TRANS. MATERIALES PARA CONSTRUCCION	2000.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
6	TRANSFORMACION DE MATERIALES DIVERSOS	1600.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
7	FABRICA DE LADRILLOS	800.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
8	PANADERIA	800.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
9	SUPERMERCADO	950.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
10	MERCANTIL	950.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
11	AUTOSERVICIO	950.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
12	CONSULTORIOS PROFESIONALES	210.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
13	BODEGA	500.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
14	RESTAURANT	206.80	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
15	DISTRIBUIDORES	500.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
16	PEYAS	500.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
17	BOTILLERIAS	500.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
18	POLLERIAS	300.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
19	PIZZERIAS	300.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
20	SNACK Y AFINES	300.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
21	KIOSCOS	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
22	PENSIONES	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
23	COMIDAS AL PASO	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
24	ABARROTES	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
25	LIBRERIA	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
26	BAZAR	206.80	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
27	FERRETERIA	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
28	FARMACIA	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
29	EMPORIOS	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
30	OFICINAS ADMINISTRATIVAS	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
31	PANADERIAS	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
32	SALON DE BELLEZA	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
33	HELADERIA	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
34	SASTERIA	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
35	FOTO ESTUDIO	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
36	VENTA DE ACEITES Y LUBRICANTES	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
37	COCHERAS	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
38	AGENCIA DE TRANSPORTES	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
39	BAÑOS PUBLICOS	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
40	RENOVADORAS DE CALZADO	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
41	VENTA DE GAS PROPANO	217.20	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
42	REPUESTOS	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
43	TAPICERIA	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
44	LADRILLERIA	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
45	LLANTERIA	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
46	ALQUILER DE VIDEOS	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
47	VENTA DE REPUESTOS ANALOGOS	160.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
48	ENTIDADES FINANCIERAS Y BANCARIAS	2000.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
49	EMPRESAS DE TELEFONICA	2000.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
50	EMPRESAS DE AGUA, DESAGUE, LUZ Y ANALOGOS	2000.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
51	HOTELES	385.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
52	GRIFOS	1000.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
53	VENTA DE GAS Y PETROLEO	1000.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
54	EMPRESAS DE CABLE	1000.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
55	SERVICENTRO AUTOMOTRIZ	1000.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
56	SERVICIOS RECREATIVOS Y MULTIPLES	1000.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
57	VIDEO PUB	550.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
58	LAVADO Y ENGRASE DE VEHICULOS	550.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
59	AGENCIA DE TRANSPORTE	550.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
60	DEPOSITOS Y AFINES	550.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
61	TALLER DE MECANICA, SOLDADURA Y PLANCHADO	210.00	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
\.


--
-- TOC entry 5526 (class 0 OID 40830)
-- Dependencies: 413
-- Data for Name: lic_licencia; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_licencia (id, estado, num_certificado, anio_certificado, certificado_fecha, num_expediente, expediente_fecha, num_resolucion, resolucion_fecha, id_contribuyente, id_predio, id_motivo_registro, id_tipo_licencia, id_condicion_local, id_actividad_comercial, id_tipo_establecimiento, nombre, area_publica, area_total, desde, hasta, horario_extraordinario, exoneracion_sustento, id_giro_licencia, id_documento, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
\.


--
-- TOC entry 5508 (class 0 OID 40687)
-- Dependencies: 395
-- Data for Name: lic_motivo_registro; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_motivo_registro (id, nombre, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
1	INICIO DE ACTIVIDAD	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
2	RENOVACION	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
3	AMPLIACION DE GIRO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
4	RECTIFICACION	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
5	CESE DE ACTIVIDADES	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
6	DUPLICADO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
7	MODIFICACION DE AREA	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
8	NO CUMPLE CON ITSE	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
\.


--
-- TOC entry 5520 (class 0 OID 40778)
-- Dependencies: 407
-- Data for Name: lic_requisito; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_requisito (id, nombre, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
1	SOLICITUD DE TRAMITE	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
2	RECIBO DE DERECHO DE TRAMITE	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
3	CONSTITUCION DE LA EMPRESA DE SER PERSONA JURIDICA	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
4	DOS FOTOGRAFIAS, DE SER EL CASO DE PERSONA NATURAL	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
5	CERTIFICADO DE COMPATIBILIDAD DE USO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
6	COPIA DE CONTRATO DEL LOCAL O CONSTANCIA DE POSESION	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
7	CERTIFICADO DE INSPECCION TECNICA	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
8	PAGO POR DERECHO DE AUTORIZACION	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
9	PERMANENCIA EN EL GIRO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
10	COPIA DNI	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
11	COPIA RUC	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
12	DECLARACION JURADA DE OBSERVANCIA DE COND. DE SEGURIDAD	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
13	CARNET SANITARIO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
14	LICENCIA DE FUNCIONAMIENTO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
15	FORMULARIO UNICO DE TRAMITE PARA LICENCIA DE FUNCIONAMIENTO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
16	CONTRATO DE CESION EN USO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
17	CONTRATO DE ALQUILER DE INMUEBLE	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
18	CERTIFICADO DE VIGENCIA DE PODER	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
19	DECLARACION JURADA PARA LICENCIA DE FUNCIONAMIENTO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
20	DECLARACION JURADA DEL CUMPLIMIENTO DE LAS CONDICIONES DE SEGURIDAD	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
21	DDJJ DE CONTAR CON TITULO PROFESIONAL VIGENTE Y HABILITADO	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
\.


--
-- TOC entry 5528 (class 0 OID 40899)
-- Dependencies: 415
-- Data for Name: lic_sust_anulacion; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_sust_anulacion (id, id_licencia, id_motivo_registro, documento_sustento, fecha, observaciones, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
\.


--
-- TOC entry 5516 (class 0 OID 40747)
-- Dependencies: 403
-- Data for Name: lic_tipo_establecimiento; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_tipo_establecimiento (id, nombre, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
1	PRINCIPAL	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
2	SUCURSAL	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
\.


--
-- TOC entry 5510 (class 0 OID 40702)
-- Dependencies: 397
-- Data for Name: lic_tipo_licencia; Type: TABLE DATA; Schema: lic; Owner: admin
--

COPY lic.lic_tipo_licencia (id, nombre, f_creado, h_creado, f_modificado, h_modificado) FROM stdin;
1	TEMPORAL	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
2	DEFINITIVA	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
3	INDETERMINADA	2025-11-27	02:53:42.214527	2025-11-27	02:53:42.214527
\.


--
-- TOC entry 5545 (class 0 OID 41070)
-- Dependencies: 432
-- Data for Name: categoria_servicio; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.categoria_servicio (id_categoria_servicio, nombre_categoria, descripcion, anio_vigencia, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5548 (class 0 OID 41098)
-- Dependencies: 435
-- Data for Name: configuracion; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.configuracion (parametro, valor, descripcion, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5552 (class 0 OID 41129)
-- Dependencies: 439
-- Data for Name: contrato; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.contrato (id_contrato, numero_contrato, fecha_inicio, fecha_fin, tipo_cobranza, observaciones, id_contribuyente, id_predio, id_categoria_servicio, id_estado_servicio, id_red_agua, id_zona_afectacion, diametro_conexion_mm, numero_medidor, fondo_garantia, penalidad_temporal, esta_exonerado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5553 (class 0 OID 41171)
-- Dependencies: 440
-- Data for Name: contrato_instalacion_pago; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.contrato_instalacion_pago (id_contrato, forma_pago, monto_instalacion, plazo_meses, cuota_mensual, numero_cuotas, interes_porcentaje, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5561 (class 0 OID 41250)
-- Dependencies: 448
-- Data for Name: corte_suspension; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.corte_suspension (id_corte_suspension, id_contrato, tipo, fecha_inicio, fecha_reposicion, motivo, periodo_deuda_inicio, periodo_deuda_fin, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5539 (class 0 OID 41036)
-- Dependencies: 426
-- Data for Name: estado_servicio; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.estado_servicio (id_estado_servicio, nombre_estado, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5565 (class 0 OID 41281)
-- Dependencies: 452
-- Data for Name: informe_mantenimiento; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.informe_mantenimiento (id_informe, id_contrato, fecha_informe, descripcion, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5563 (class 0 OID 41266)
-- Dependencies: 450
-- Data for Name: omision_servicio; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.omision_servicio (id_omision, id_contrato, fecha_inicio, fecha_fin, mes_anio_inicio, mes_anio_fin, numero_documento_sustento, fecha_sustento, detalle_sustento, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5559 (class 0 OID 41231)
-- Dependencies: 446
-- Data for Name: pago; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.pago (id_pago, id_recibo, id_pago_caja, fecha_pago, monto_pagado, usuario_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5557 (class 0 OID 41203)
-- Dependencies: 444
-- Data for Name: recibo; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.recibo (id_recibo, id_contrato, anio, mes, monto_consumo, id_sustento_descuento, lectura_anterior, lectura_actual, monto_total, estado_pago, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5541 (class 0 OID 41046)
-- Dependencies: 428
-- Data for Name: red_agua; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.red_agua (id_red_agua, nombre_red, descripcion, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5555 (class 0 OID 41189)
-- Dependencies: 442
-- Data for Name: sustento_descuento; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.sustento_descuento (id_sustento_descuento, numero_documento, fecha_documento, detalle_sustento, porcentaje_descuento, monto_fijo_descuento, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5547 (class 0 OID 41082)
-- Dependencies: 434
-- Data for Name: tarifa; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.tarifa (id_tarifa, id_categoria_servicio, anio, mes, monto, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5550 (class 0 OID 41113)
-- Dependencies: 437
-- Data for Name: usuario; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.usuario (id_contribuyente, codigo_usuario_saa, estado_usuario, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5549 (class 0 OID 41106)
-- Dependencies: 436
-- Data for Name: vencimiento_parametro_anual; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.vencimiento_parametro_anual (anio, mes, fecha_vencimiento, factor_ipm, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5543 (class 0 OID 41058)
-- Dependencies: 430
-- Data for Name: zona_afectacion; Type: TABLE DATA; Schema: saa; Owner: admin
--

COPY saa.zona_afectacion (id_zona_afectacion, nombre_zona, descripcion, usuario_creacion, fecha_creacion, usuario_modificacion, fecha_modificacion) FROM stdin;
\.


--
-- TOC entry 5745 (class 0 OID 0)
-- Dependencies: 497
-- Name: alc_contrato_alcabala_id_seq; Type: SEQUENCE SET; Schema: alc; Owner: admin
--

SELECT pg_catalog.setval('alc.alc_contrato_alcabala_id_seq', 1, false);


--
-- TOC entry 5746 (class 0 OID 0)
-- Dependencies: 493
-- Name: alc_entidad_inafecta_id_seq; Type: SEQUENCE SET; Schema: alc; Owner: admin
--

SELECT pg_catalog.setval('alc.alc_entidad_inafecta_id_seq', 1, false);


--
-- TOC entry 5747 (class 0 OID 0)
-- Dependencies: 499
-- Name: alc_estado_contrato_id_seq; Type: SEQUENCE SET; Schema: alc; Owner: admin
--

SELECT pg_catalog.setval('alc.alc_estado_contrato_id_seq', 1, false);


--
-- TOC entry 5748 (class 0 OID 0)
-- Dependencies: 495
-- Name: alc_factor_calculo_id_seq; Type: SEQUENCE SET; Schema: alc; Owner: admin
--

SELECT pg_catalog.setval('alc.alc_factor_calculo_id_seq', 1, false);


--
-- TOC entry 5749 (class 0 OID 0)
-- Dependencies: 479
-- Name: arbitrio_detalle_id_arbitrio_detalle_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.arbitrio_detalle_id_arbitrio_detalle_seq', 1, false);


--
-- TOC entry 5750 (class 0 OID 0)
-- Dependencies: 477
-- Name: arbitrio_id_arbitrio_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.arbitrio_id_arbitrio_seq', 1, false);


--
-- TOC entry 5751 (class 0 OID 0)
-- Dependencies: 473
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.categoria_id_categoria_seq', 1, false);


--
-- TOC entry 5752 (class 0 OID 0)
-- Dependencies: 491
-- Name: categoria_tributo_id_categoria_tributo_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.categoria_tributo_id_categoria_tributo_seq', 1, false);


--
-- TOC entry 5753 (class 0 OID 0)
-- Dependencies: 483
-- Name: determina_calculo_id_determina_calculo_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.determina_calculo_id_determina_calculo_seq', 1, false);


--
-- TOC entry 5754 (class 0 OID 0)
-- Dependencies: 471
-- Name: grupo_categoria_id_grupo_categoria_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.grupo_categoria_id_grupo_categoria_seq', 1, false);


--
-- TOC entry 5755 (class 0 OID 0)
-- Dependencies: 481
-- Name: licencia_funcionamiento_id_licencia_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.licencia_funcionamiento_id_licencia_seq', 1, false);


--
-- TOC entry 5756 (class 0 OID 0)
-- Dependencies: 487
-- Name: tarifa_area_construida_id_tarifa_area_construida_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.tarifa_area_construida_id_tarifa_area_construida_seq', 1, false);


--
-- TOC entry 5757 (class 0 OID 0)
-- Dependencies: 489
-- Name: tarifa_area_terreno_id_tarifa_area_terreno_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.tarifa_area_terreno_id_tarifa_area_terreno_seq', 1, false);


--
-- TOC entry 5758 (class 0 OID 0)
-- Dependencies: 485
-- Name: tarifa_categoria_id_tarifa_categoria_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.tarifa_categoria_id_tarifa_categoria_seq', 1, false);


--
-- TOC entry 5759 (class 0 OID 0)
-- Dependencies: 469
-- Name: tipo_beneficio_id_tipo_beneficio_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.tipo_beneficio_id_tipo_beneficio_seq', 1, false);


--
-- TOC entry 5760 (class 0 OID 0)
-- Dependencies: 475
-- Name: tipo_registro_origen_id_tipo_registro_origen_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.tipo_registro_origen_id_tipo_registro_origen_seq', 1, false);


--
-- TOC entry 5761 (class 0 OID 0)
-- Dependencies: 467
-- Name: tributo_id_tributo_seq; Type: SEQUENCE SET; Schema: arb; Owner: admin
--

SELECT pg_catalog.setval('arb.tributo_id_tributo_seq', 1, false);


--
-- TOC entry 5762 (class 0 OID 0)
-- Dependencies: 255
-- Name: apertura_cobranza_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.apertura_cobranza_id_seq', 1, false);


--
-- TOC entry 5763 (class 0 OID 0)
-- Dependencies: 257
-- Name: auditoria_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.auditoria_id_seq', 1, false);


--
-- TOC entry 5764 (class 0 OID 0)
-- Dependencies: 259
-- Name: cajero_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.cajero_id_seq', 2, true);


--
-- TOC entry 5765 (class 0 OID 0)
-- Dependencies: 261
-- Name: cierre_caja_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.cierre_caja_id_seq', 1, false);


--
-- TOC entry 5766 (class 0 OID 0)
-- Dependencies: 263
-- Name: concepto_pago_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.concepto_pago_id_seq', 2, true);


--
-- TOC entry 5767 (class 0 OID 0)
-- Dependencies: 265
-- Name: extorno_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.extorno_id_seq', 1, false);


--
-- TOC entry 5768 (class 0 OID 0)
-- Dependencies: 268
-- Name: pago_detalle_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.pago_detalle_id_seq', 1, true);


--
-- TOC entry 5769 (class 0 OID 0)
-- Dependencies: 269
-- Name: pago_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.pago_id_seq', 2, true);


--
-- TOC entry 5770 (class 0 OID 0)
-- Dependencies: 271
-- Name: recibo_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.recibo_id_seq', 1, true);


--
-- TOC entry 5771 (class 0 OID 0)
-- Dependencies: 273
-- Name: tipo_pago_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.tipo_pago_id_seq', 2, true);


--
-- TOC entry 5772 (class 0 OID 0)
-- Dependencies: 275
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: caj; Owner: postgres
--

SELECT pg_catalog.setval('caj.usuario_id_seq', 2, true);


--
-- TOC entry 5773 (class 0 OID 0)
-- Dependencies: 459
-- Name: fis_acta_inspección_id_acta_seq; Type: SEQUENCE SET; Schema: fis; Owner: admin
--

SELECT pg_catalog.setval('fis."fis_acta_inspección_id_acta_seq"', 1, false);


--
-- TOC entry 5774 (class 0 OID 0)
-- Dependencies: 455
-- Name: fis_fiscalizacion_id_fiscalizacion_seq; Type: SEQUENCE SET; Schema: fis; Owner: admin
--

SELECT pg_catalog.setval('fis.fis_fiscalizacion_id_fiscalizacion_seq', 1, false);


--
-- TOC entry 5775 (class 0 OID 0)
-- Dependencies: 461
-- Name: fis_liquidacion_id_liquidacion_seq; Type: SEQUENCE SET; Schema: fis; Owner: admin
--

SELECT pg_catalog.setval('fis.fis_liquidacion_id_liquidacion_seq', 1, false);


--
-- TOC entry 5776 (class 0 OID 0)
-- Dependencies: 465
-- Name: fis_multa_id_multa_seq; Type: SEQUENCE SET; Schema: fis; Owner: admin
--

SELECT pg_catalog.setval('fis.fis_multa_id_multa_seq', 1, false);


--
-- TOC entry 5777 (class 0 OID 0)
-- Dependencies: 457
-- Name: fis_requerimiento_id_requerimiento_seq; Type: SEQUENCE SET; Schema: fis; Owner: admin
--

SELECT pg_catalog.setval('fis.fis_requerimiento_id_requerimiento_seq', 1, false);


--
-- TOC entry 5778 (class 0 OID 0)
-- Dependencies: 463
-- Name: fis_resolucion_id_resolucion_seq; Type: SEQUENCE SET; Schema: fis; Owner: admin
--

SELECT pg_catalog.setval('fis.fis_resolucion_id_resolucion_seq', 1, false);


--
-- TOC entry 5779 (class 0 OID 0)
-- Dependencies: 379
-- Name: gen_contribuyente_id_seq; Type: SEQUENCE SET; Schema: gen; Owner: admin
--

SELECT pg_catalog.setval('gen.gen_contribuyente_id_seq', 100, true);


--
-- TOC entry 5780 (class 0 OID 0)
-- Dependencies: 364
-- Name: gen_departamento_id_seq; Type: SEQUENCE SET; Schema: gen; Owner: admin
--

SELECT pg_catalog.setval('gen.gen_departamento_id_seq', 25, true);


--
-- TOC entry 5781 (class 0 OID 0)
-- Dependencies: 368
-- Name: gen_distrito_id_seq; Type: SEQUENCE SET; Schema: gen; Owner: admin
--

SELECT pg_catalog.setval('gen.gen_distrito_id_seq', 1867, true);


--
-- TOC entry 5782 (class 0 OID 0)
-- Dependencies: 453
-- Name: gen_funcionario_id_seq; Type: SEQUENCE SET; Schema: gen; Owner: admin
--

SELECT pg_catalog.setval('gen.gen_funcionario_id_seq', 1, false);


--
-- TOC entry 5783 (class 0 OID 0)
-- Dependencies: 381
-- Name: gen_predio_id_seq; Type: SEQUENCE SET; Schema: gen; Owner: admin
--

SELECT pg_catalog.setval('gen.gen_predio_id_seq', 2, true);


--
-- TOC entry 5784 (class 0 OID 0)
-- Dependencies: 366
-- Name: gen_provincia_id_seq; Type: SEQUENCE SET; Schema: gen; Owner: admin
--

SELECT pg_catalog.setval('gen.gen_provincia_id_seq', 196, true);


--
-- TOC entry 5785 (class 0 OID 0)
-- Dependencies: 375
-- Name: gen_tipo_habilitacion_urbana_id_seq; Type: SEQUENCE SET; Schema: gen; Owner: admin
--

SELECT pg_catalog.setval('gen.gen_tipo_habilitacion_urbana_id_seq', 25, true);


--
-- TOC entry 5786 (class 0 OID 0)
-- Dependencies: 373
-- Name: gen_tipo_interior_id_seq; Type: SEQUENCE SET; Schema: gen; Owner: admin
--

SELECT pg_catalog.setval('gen.gen_tipo_interior_id_seq', 9, true);


--
-- TOC entry 5787 (class 0 OID 0)
-- Dependencies: 371
-- Name: gen_tipo_via_id_seq; Type: SEQUENCE SET; Schema: gen; Owner: admin
--

SELECT pg_catalog.setval('gen.gen_tipo_via_id_seq', 13, true);


--
-- TOC entry 5788 (class 0 OID 0)
-- Dependencies: 316
-- Name: imp_arancel_urbano_id_arancel_urbano_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_arancel_urbano_id_arancel_urbano_seq', 1, false);


--
-- TOC entry 5789 (class 0 OID 0)
-- Dependencies: 356
-- Name: imp_area_rustica_id_area_rustica_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_area_rustica_id_area_rustica_seq', 1, false);


--
-- TOC entry 5790 (class 0 OID 0)
-- Dependencies: 288
-- Name: imp_asociacion_id_asociacion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_asociacion_id_asociacion_seq', 1, false);


--
-- TOC entry 5791 (class 0 OID 0)
-- Dependencies: 308
-- Name: imp_categoria_terreno_ext_id_categoria_terreno_ext_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_categoria_terreno_ext_id_categoria_terreno_ext_seq', 1, false);


--
-- TOC entry 5792 (class 0 OID 0)
-- Dependencies: 312
-- Name: imp_categoria_terreno_id_categoria_terreno_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_categoria_terreno_id_categoria_terreno_seq', 1, false);


--
-- TOC entry 5793 (class 0 OID 0)
-- Dependencies: 306
-- Name: imp_clasificacion_terreno_id_clasificacion_terreno_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_clasificacion_terreno_id_clasificacion_terreno_seq', 1, false);


--
-- TOC entry 5794 (class 0 OID 0)
-- Dependencies: 362
-- Name: imp_cuenta_corriente_id_movimiento_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_cuenta_corriente_id_movimiento_seq', 1, false);


--
-- TOC entry 5795 (class 0 OID 0)
-- Dependencies: 342
-- Name: imp_declaracion_jurada_id_declaracion_jurada_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_declaracion_jurada_id_declaracion_jurada_seq', 1, false);


--
-- TOC entry 5796 (class 0 OID 0)
-- Dependencies: 276
-- Name: imp_departamento_id_departamento_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_departamento_id_departamento_seq', 1, false);


--
-- TOC entry 5797 (class 0 OID 0)
-- Dependencies: 330
-- Name: imp_depreciacion_id_depreciacion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_depreciacion_id_depreciacion_seq', 1, false);


--
-- TOC entry 5798 (class 0 OID 0)
-- Dependencies: 280
-- Name: imp_distrito_id_distrito_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_distrito_id_distrito_seq', 1, false);


--
-- TOC entry 5799 (class 0 OID 0)
-- Dependencies: 344
-- Name: imp_dj_predio_id_dj_predio_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_dj_predio_id_dj_predio_seq', 1, false);


--
-- TOC entry 5800 (class 0 OID 0)
-- Dependencies: 297
-- Name: imp_domicilio_fiscal_contribuyente_id_domicilio_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_domicilio_fiscal_contribuyente_id_domicilio_seq', 1, false);


--
-- TOC entry 5801 (class 0 OID 0)
-- Dependencies: 322
-- Name: imp_escala_impuesto_id_escala_impuesto_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_escala_impuesto_id_escala_impuesto_seq', 1, false);


--
-- TOC entry 5802 (class 0 OID 0)
-- Dependencies: 314
-- Name: imp_estado_conservacion_id_estado_conservacion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_estado_conservacion_id_estado_conservacion_seq', 1, false);


--
-- TOC entry 5803 (class 0 OID 0)
-- Dependencies: 332
-- Name: imp_exoneracion_id_exoneracion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_exoneracion_id_exoneracion_seq', 1, false);


--
-- TOC entry 5804 (class 0 OID 0)
-- Dependencies: 354
-- Name: imp_grupo_tierra_detalle_id_grupo_tierra_detalle_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_grupo_tierra_detalle_id_grupo_tierra_detalle_seq', 1, false);


--
-- TOC entry 5805 (class 0 OID 0)
-- Dependencies: 310
-- Name: imp_grupo_tierra_id_grupo_tierra_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_grupo_tierra_id_grupo_tierra_seq', 1, false);


--
-- TOC entry 5806 (class 0 OID 0)
-- Dependencies: 286
-- Name: imp_habilitacion_urbana_id_habilitacion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_habilitacion_urbana_id_habilitacion_seq', 1, false);


--
-- TOC entry 5807 (class 0 OID 0)
-- Dependencies: 338
-- Name: imp_junta_vecinal_id_junta_vecinal_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_junta_vecinal_id_junta_vecinal_seq', 1, false);


--
-- TOC entry 5808 (class 0 OID 0)
-- Dependencies: 302
-- Name: imp_material_estructural_pred_id_material_estructural_predi_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_material_estructural_pred_id_material_estructural_predi_seq', 1, false);


--
-- TOC entry 5809 (class 0 OID 0)
-- Dependencies: 304
-- Name: imp_motivo_dj_id_motivo_dj_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_motivo_dj_id_motivo_dj_seq', 1, false);


--
-- TOC entry 5810 (class 0 OID 0)
-- Dependencies: 358
-- Name: imp_pago_id_pago_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_pago_id_pago_seq', 1, false);


--
-- TOC entry 5811 (class 0 OID 0)
-- Dependencies: 360
-- Name: imp_param_moratorio_id_param_moratorio_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_param_moratorio_id_param_moratorio_seq', 1, false);


--
-- TOC entry 5812 (class 0 OID 0)
-- Dependencies: 320
-- Name: imp_param_principales_id_param_principal_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_param_principales_id_param_principal_seq', 1, false);


--
-- TOC entry 5813 (class 0 OID 0)
-- Dependencies: 346
-- Name: imp_predio_colindante_id_predio_colindante_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_predio_colindante_id_predio_colindante_seq', 1, false);


--
-- TOC entry 5814 (class 0 OID 0)
-- Dependencies: 348
-- Name: imp_predio_construccion_id_predio_construccion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_predio_construccion_id_predio_construccion_seq', 1, false);


--
-- TOC entry 5815 (class 0 OID 0)
-- Dependencies: 340
-- Name: imp_predio_id_predio_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_predio_id_predio_seq', 1, false);


--
-- TOC entry 5816 (class 0 OID 0)
-- Dependencies: 352
-- Name: imp_predio_otra_instalacion_id_predio_otra_instalacion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_predio_otra_instalacion_id_predio_otra_instalacion_seq', 1, false);


--
-- TOC entry 5817 (class 0 OID 0)
-- Dependencies: 350
-- Name: imp_predio_terreno_id_predio_terreno_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_predio_terreno_id_predio_terreno_seq', 1, false);


--
-- TOC entry 5818 (class 0 OID 0)
-- Dependencies: 278
-- Name: imp_provincia_id_provincia_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_provincia_id_provincia_seq', 1, false);


--
-- TOC entry 5819 (class 0 OID 0)
-- Dependencies: 282
-- Name: imp_sector_id_sector_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_sector_id_sector_seq', 1, false);


--
-- TOC entry 5820 (class 0 OID 0)
-- Dependencies: 284
-- Name: imp_tipo_habilitacion_urbana_id_tipo_habilitacion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_tipo_habilitacion_urbana_id_tipo_habilitacion_seq', 1, false);


--
-- TOC entry 5821 (class 0 OID 0)
-- Dependencies: 295
-- Name: imp_tipo_interior_id_tipo_interior_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_tipo_interior_id_tipo_interior_seq', 1, false);


--
-- TOC entry 5822 (class 0 OID 0)
-- Dependencies: 300
-- Name: imp_tipo_registro_predio_id_tipo_registro_predio_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_tipo_registro_predio_id_tipo_registro_predio_seq', 1, false);


--
-- TOC entry 5823 (class 0 OID 0)
-- Dependencies: 290
-- Name: imp_tipo_via_id_tipo_via_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_tipo_via_id_tipo_via_seq', 1, false);


--
-- TOC entry 5824 (class 0 OID 0)
-- Dependencies: 318
-- Name: imp_uso_predio_id_uso_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_uso_predio_id_uso_seq', 1, false);


--
-- TOC entry 5825 (class 0 OID 0)
-- Dependencies: 334
-- Name: imp_valor_exoneracion_id_valor_exoneracion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_valor_exoneracion_id_valor_exoneracion_seq', 1, false);


--
-- TOC entry 5826 (class 0 OID 0)
-- Dependencies: 325
-- Name: imp_valor_unitario_edificacio_id_valor_unitario_edificacion_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_valor_unitario_edificacio_id_valor_unitario_edificacion_seq', 1, false);


--
-- TOC entry 5827 (class 0 OID 0)
-- Dependencies: 328
-- Name: imp_valor_unitario_obra_id_valor_unitario_obra_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_valor_unitario_obra_id_valor_unitario_obra_seq', 1, false);


--
-- TOC entry 5828 (class 0 OID 0)
-- Dependencies: 336
-- Name: imp_vencimiento_emision_id_vencimiento_emision_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_vencimiento_emision_id_vencimiento_emision_seq', 1, false);


--
-- TOC entry 5829 (class 0 OID 0)
-- Dependencies: 292
-- Name: imp_via_id_via_seq; Type: SEQUENCE SET; Schema: imp; Owner: admin
--

SELECT pg_catalog.setval('imp.imp_via_id_via_seq', 1, false);


--
-- TOC entry 5830 (class 0 OID 0)
-- Dependencies: 400
-- Name: lic_actividad_comercial_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_actividad_comercial_id_seq', 8, true);


--
-- TOC entry 5831 (class 0 OID 0)
-- Dependencies: 398
-- Name: lic_condicion_local_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_condicion_local_id_seq', 3, true);


--
-- TOC entry 5832 (class 0 OID 0)
-- Dependencies: 410
-- Name: lic_documento_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_documento_id_seq', 1, false);


--
-- TOC entry 5833 (class 0 OID 0)
-- Dependencies: 408
-- Name: lic_giro_licencia_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_giro_licencia_id_seq', 1, false);


--
-- TOC entry 5834 (class 0 OID 0)
-- Dependencies: 404
-- Name: lic_giro_negocio_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_giro_negocio_id_seq', 61, true);


--
-- TOC entry 5835 (class 0 OID 0)
-- Dependencies: 412
-- Name: lic_licencia_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_licencia_id_seq', 1, false);


--
-- TOC entry 5836 (class 0 OID 0)
-- Dependencies: 394
-- Name: lic_motivo_registro_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_motivo_registro_id_seq', 8, true);


--
-- TOC entry 5837 (class 0 OID 0)
-- Dependencies: 406
-- Name: lic_requisito_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_requisito_id_seq', 21, true);


--
-- TOC entry 5838 (class 0 OID 0)
-- Dependencies: 414
-- Name: lic_sust_anulacion_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_sust_anulacion_id_seq', 1, false);


--
-- TOC entry 5839 (class 0 OID 0)
-- Dependencies: 402
-- Name: lic_tipo_establecimiento_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_tipo_establecimiento_id_seq', 2, true);


--
-- TOC entry 5840 (class 0 OID 0)
-- Dependencies: 396
-- Name: lic_tipo_licencia_id_seq; Type: SEQUENCE SET; Schema: lic; Owner: admin
--

SELECT pg_catalog.setval('lic.lic_tipo_licencia_id_seq', 3, true);


--
-- TOC entry 5841 (class 0 OID 0)
-- Dependencies: 431
-- Name: categoria_servicio_id_categoria_servicio_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.categoria_servicio_id_categoria_servicio_seq', 1, false);


--
-- TOC entry 5842 (class 0 OID 0)
-- Dependencies: 438
-- Name: contrato_id_contrato_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.contrato_id_contrato_seq', 1, false);


--
-- TOC entry 5843 (class 0 OID 0)
-- Dependencies: 447
-- Name: corte_suspension_id_corte_suspension_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.corte_suspension_id_corte_suspension_seq', 1, false);


--
-- TOC entry 5844 (class 0 OID 0)
-- Dependencies: 425
-- Name: estado_servicio_id_estado_servicio_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.estado_servicio_id_estado_servicio_seq', 1, false);


--
-- TOC entry 5845 (class 0 OID 0)
-- Dependencies: 451
-- Name: informe_mantenimiento_id_informe_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.informe_mantenimiento_id_informe_seq', 1, false);


--
-- TOC entry 5846 (class 0 OID 0)
-- Dependencies: 449
-- Name: omision_servicio_id_omision_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.omision_servicio_id_omision_seq', 1, false);


--
-- TOC entry 5847 (class 0 OID 0)
-- Dependencies: 445
-- Name: pago_id_pago_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.pago_id_pago_seq', 1, false);


--
-- TOC entry 5848 (class 0 OID 0)
-- Dependencies: 443
-- Name: recibo_id_recibo_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.recibo_id_recibo_seq', 1, false);


--
-- TOC entry 5849 (class 0 OID 0)
-- Dependencies: 427
-- Name: red_agua_id_red_agua_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.red_agua_id_red_agua_seq', 1, false);


--
-- TOC entry 5850 (class 0 OID 0)
-- Dependencies: 441
-- Name: sustento_descuento_id_sustento_descuento_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.sustento_descuento_id_sustento_descuento_seq', 1, false);


--
-- TOC entry 5851 (class 0 OID 0)
-- Dependencies: 433
-- Name: tarifa_id_tarifa_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.tarifa_id_tarifa_seq', 1, false);


--
-- TOC entry 5852 (class 0 OID 0)
-- Dependencies: 429
-- Name: zona_afectacion_id_zona_afectacion_seq; Type: SEQUENCE SET; Schema: saa; Owner: admin
--

SELECT pg_catalog.setval('saa.zona_afectacion_id_zona_afectacion_seq', 1, false);


--
-- TOC entry 4983 (class 2606 OID 42044)
-- Name: alc_contrato_alcabala pk_alc_contrato_alcabala; Type: CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_contrato_alcabala
    ADD CONSTRAINT pk_alc_contrato_alcabala PRIMARY KEY (id);


--
-- TOC entry 4979 (class 2606 OID 42023)
-- Name: alc_entidad_inafecta pk_alc_entidad_inafecta; Type: CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_entidad_inafecta
    ADD CONSTRAINT pk_alc_entidad_inafecta PRIMARY KEY (id);


--
-- TOC entry 4985 (class 2606 OID 42077)
-- Name: alc_estado_contrato pk_alc_estado_contrato; Type: CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_estado_contrato
    ADD CONSTRAINT pk_alc_estado_contrato PRIMARY KEY (id);


--
-- TOC entry 4981 (class 2606 OID 42032)
-- Name: alc_factor_calculo pk_alc_factor_calculo; Type: CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_factor_calculo
    ADD CONSTRAINT pk_alc_factor_calculo PRIMARY KEY (id);


--
-- TOC entry 4965 (class 2606 OID 41894)
-- Name: licencia_funcionamiento licencia_funcionamiento_nro_licencia_key; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.licencia_funcionamiento
    ADD CONSTRAINT licencia_funcionamiento_nro_licencia_key UNIQUE (nro_licencia);


--
-- TOC entry 4961 (class 2606 OID 41833)
-- Name: arbitrio pk_arbitrio; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio
    ADD CONSTRAINT pk_arbitrio PRIMARY KEY (id_arbitrio);


--
-- TOC entry 4963 (class 2606 OID 41856)
-- Name: arbitrio_detalle pk_arbitrio_detalle; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio_detalle
    ADD CONSTRAINT pk_arbitrio_detalle PRIMARY KEY (id_arbitrio_detalle);


--
-- TOC entry 4957 (class 2606 OID 41809)
-- Name: categoria pk_categoria; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.categoria
    ADD CONSTRAINT pk_categoria PRIMARY KEY (id_categoria);


--
-- TOC entry 4977 (class 2606 OID 42002)
-- Name: categoria_tributo pk_categoria_tributo; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.categoria_tributo
    ADD CONSTRAINT pk_categoria_tributo PRIMARY KEY (id_categoria_tributo);


--
-- TOC entry 4969 (class 2606 OID 41917)
-- Name: determina_calculo pk_determina_calculo; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.determina_calculo
    ADD CONSTRAINT pk_determina_calculo PRIMARY KEY (id_determina_calculo);


--
-- TOC entry 4955 (class 2606 OID 41801)
-- Name: grupo_categoria pk_grupo_categoria; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.grupo_categoria
    ADD CONSTRAINT pk_grupo_categoria PRIMARY KEY (id_grupo_categoria);


--
-- TOC entry 4967 (class 2606 OID 41892)
-- Name: licencia_funcionamiento pk_licencia_funcionamiento; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.licencia_funcionamiento
    ADD CONSTRAINT pk_licencia_funcionamiento PRIMARY KEY (id_licencia);


--
-- TOC entry 4973 (class 2606 OID 41963)
-- Name: tarifa_area_construida pk_tarifa_area_construida; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_area_construida
    ADD CONSTRAINT pk_tarifa_area_construida PRIMARY KEY (id_tarifa_area_construida);


--
-- TOC entry 4975 (class 2606 OID 41984)
-- Name: tarifa_area_terreno pk_tarifa_area_terreno; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_area_terreno
    ADD CONSTRAINT pk_tarifa_area_terreno PRIMARY KEY (id_tarifa_area_terreno);


--
-- TOC entry 4971 (class 2606 OID 41937)
-- Name: tarifa_categoria pk_tarifa_categoria; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_categoria
    ADD CONSTRAINT pk_tarifa_categoria PRIMARY KEY (id_tarifa_categoria);


--
-- TOC entry 4953 (class 2606 OID 41788)
-- Name: tipo_beneficio pk_tipo_beneficio; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tipo_beneficio
    ADD CONSTRAINT pk_tipo_beneficio PRIMARY KEY (id_tipo_beneficio);


--
-- TOC entry 4959 (class 2606 OID 41822)
-- Name: tipo_registro_origen pk_tipo_registro_origen; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tipo_registro_origen
    ADD CONSTRAINT pk_tipo_registro_origen PRIMARY KEY (id_tipo_registro_origen);


--
-- TOC entry 4951 (class 2606 OID 41780)
-- Name: tributo pk_tributo; Type: CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tributo
    ADD CONSTRAINT pk_tributo PRIMARY KEY (id_tributo);


--
-- TOC entry 4613 (class 2606 OID 36716)
-- Name: apertura_cobranza apertura_cobranza_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.apertura_cobranza
    ADD CONSTRAINT apertura_cobranza_pkey PRIMARY KEY (id);


--
-- TOC entry 4615 (class 2606 OID 36718)
-- Name: auditoria auditoria_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id);


--
-- TOC entry 4617 (class 2606 OID 36720)
-- Name: cajero cajero_dni_key; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.cajero
    ADD CONSTRAINT cajero_dni_key UNIQUE (dni);


--
-- TOC entry 4619 (class 2606 OID 36722)
-- Name: cajero cajero_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.cajero
    ADD CONSTRAINT cajero_pkey PRIMARY KEY (id);


--
-- TOC entry 4621 (class 2606 OID 36724)
-- Name: cierre_caja cierre_caja_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.cierre_caja
    ADD CONSTRAINT cierre_caja_pkey PRIMARY KEY (id);


--
-- TOC entry 4623 (class 2606 OID 36726)
-- Name: concepto_pago concepto_pago_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.concepto_pago
    ADD CONSTRAINT concepto_pago_pkey PRIMARY KEY (id);


--
-- TOC entry 4625 (class 2606 OID 36728)
-- Name: extorno extorno_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.extorno
    ADD CONSTRAINT extorno_pkey PRIMARY KEY (id);


--
-- TOC entry 4629 (class 2606 OID 36730)
-- Name: pago_detalle pago_detalle_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.pago_detalle
    ADD CONSTRAINT pago_detalle_pkey PRIMARY KEY (id);


--
-- TOC entry 4627 (class 2606 OID 36732)
-- Name: pago pago_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.pago
    ADD CONSTRAINT pago_pkey PRIMARY KEY (id);


--
-- TOC entry 4631 (class 2606 OID 36734)
-- Name: recibo recibo_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.recibo
    ADD CONSTRAINT recibo_pkey PRIMARY KEY (id);


--
-- TOC entry 4633 (class 2606 OID 36736)
-- Name: tipo_pago tipo_pago_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.tipo_pago
    ADD CONSTRAINT tipo_pago_pkey PRIMARY KEY (id);


--
-- TOC entry 4635 (class 2606 OID 36738)
-- Name: usuario usuario_dni_key; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.usuario
    ADD CONSTRAINT usuario_dni_key UNIQUE (dni);


--
-- TOC entry 4637 (class 2606 OID 36740)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 4943 (class 2606 OID 41516)
-- Name: fis_acta_inspección fis_acta_inspección_pkey; Type: CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis."fis_acta_inspección"
    ADD CONSTRAINT "fis_acta_inspección_pkey" PRIMARY KEY (id_acta);


--
-- TOC entry 4939 (class 2606 OID 41413)
-- Name: fis_fiscalizacion fis_fiscalizacion_pkey; Type: CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_fiscalizacion
    ADD CONSTRAINT fis_fiscalizacion_pkey PRIMARY KEY (id_fiscalizacion);


--
-- TOC entry 4945 (class 2606 OID 41530)
-- Name: fis_liquidacion fis_liquidacion_pkey; Type: CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_liquidacion
    ADD CONSTRAINT fis_liquidacion_pkey PRIMARY KEY (id_liquidacion);


--
-- TOC entry 4949 (class 2606 OID 41558)
-- Name: fis_multa fis_multa_pkey; Type: CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_multa
    ADD CONSTRAINT fis_multa_pkey PRIMARY KEY (id_multa);


--
-- TOC entry 4941 (class 2606 OID 41502)
-- Name: fis_requerimiento fis_requerimiento_pkey; Type: CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_requerimiento
    ADD CONSTRAINT fis_requerimiento_pkey PRIMARY KEY (id_requerimiento);


--
-- TOC entry 4947 (class 2606 OID 41544)
-- Name: fis_resolucion fis_resolucion_pkey; Type: CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_resolucion
    ADD CONSTRAINT fis_resolucion_pkey PRIMARY KEY (id_resolucion);


--
-- TOC entry 4937 (class 2606 OID 41328)
-- Name: gen_funcionario gen_funcionario_pkey; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_funcionario
    ADD CONSTRAINT gen_funcionario_pkey PRIMARY KEY (id);


--
-- TOC entry 4808 (class 2606 OID 40547)
-- Name: gen_contribuyente pk_contribuyente; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_contribuyente
    ADD CONSTRAINT pk_contribuyente PRIMARY KEY (id);


--
-- TOC entry 4765 (class 2606 OID 40385)
-- Name: gen_departamento pk_departamento; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_departamento
    ADD CONSTRAINT pk_departamento PRIMARY KEY (id);


--
-- TOC entry 4775 (class 2606 OID 40414)
-- Name: gen_distrito pk_distrito; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_distrito
    ADD CONSTRAINT pk_distrito PRIMARY KEY (id);


--
-- TOC entry 4795 (class 2606 OID 40486)
-- Name: gen_habilitacion_urbana pk_habilitacion_urbana; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_habilitacion_urbana
    ADD CONSTRAINT pk_habilitacion_urbana PRIMARY KEY (id);


--
-- TOC entry 4821 (class 2606 OID 40566)
-- Name: gen_predio pk_predio; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_predio
    ADD CONSTRAINT pk_predio PRIMARY KEY (id);


--
-- TOC entry 4770 (class 2606 OID 40397)
-- Name: gen_provincia pk_provincia; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_provincia
    ADD CONSTRAINT pk_provincia PRIMARY KEY (id);


--
-- TOC entry 4778 (class 2606 OID 40433)
-- Name: gen_sector pk_sector; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_sector
    ADD CONSTRAINT pk_sector PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 40475)
-- Name: gen_tipo_habilitacion_urbana pk_tipo_habilitacion_urbana; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_tipo_habilitacion_urbana
    ADD CONSTRAINT pk_tipo_habilitacion_urbana PRIMARY KEY (id);


--
-- TOC entry 4786 (class 2606 OID 40463)
-- Name: gen_tipo_interior pk_tipo_interior; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_tipo_interior
    ADD CONSTRAINT pk_tipo_interior PRIMARY KEY (id);


--
-- TOC entry 4782 (class 2606 OID 40450)
-- Name: gen_tipo_via pk_tipo_via; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_tipo_via
    ADD CONSTRAINT pk_tipo_via PRIMARY KEY (id);


--
-- TOC entry 4800 (class 2606 OID 40507)
-- Name: gen_via pk_via; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_via
    ADD CONSTRAINT pk_via PRIMARY KEY (id);


--
-- TOC entry 4810 (class 2606 OID 40549)
-- Name: gen_contribuyente uq_contribuyente_dni; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_contribuyente
    ADD CONSTRAINT uq_contribuyente_dni UNIQUE (dni);


--
-- TOC entry 4812 (class 2606 OID 40551)
-- Name: gen_contribuyente uq_contribuyente_ruc; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_contribuyente
    ADD CONSTRAINT uq_contribuyente_ruc UNIQUE (ruc);


--
-- TOC entry 4767 (class 2606 OID 40387)
-- Name: gen_departamento uq_departamento_nombre; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_departamento
    ADD CONSTRAINT uq_departamento_nombre UNIQUE (nombre);


--
-- TOC entry 4797 (class 2606 OID 40488)
-- Name: gen_habilitacion_urbana uq_habilitacion_nombre_distrito; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_habilitacion_urbana
    ADD CONSTRAINT uq_habilitacion_nombre_distrito UNIQUE (id_distrito, nombre);


--
-- TOC entry 4772 (class 2606 OID 40399)
-- Name: gen_provincia uq_provincia_nombre_departamento; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_provincia
    ADD CONSTRAINT uq_provincia_nombre_departamento UNIQUE (id_departamento, nombre);


--
-- TOC entry 4780 (class 2606 OID 40435)
-- Name: gen_sector uq_sector_nombre_distrito; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_sector
    ADD CONSTRAINT uq_sector_nombre_distrito UNIQUE (id_distrito, nombre);


--
-- TOC entry 4792 (class 2606 OID 40477)
-- Name: gen_tipo_habilitacion_urbana uq_tipo_habilitacion_nombre; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_tipo_habilitacion_urbana
    ADD CONSTRAINT uq_tipo_habilitacion_nombre UNIQUE (nombre);


--
-- TOC entry 4788 (class 2606 OID 40465)
-- Name: gen_tipo_interior uq_tipo_interior_nombre; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_tipo_interior
    ADD CONSTRAINT uq_tipo_interior_nombre UNIQUE (nombre);


--
-- TOC entry 4784 (class 2606 OID 40452)
-- Name: gen_tipo_via uq_tipo_via_nombre; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_tipo_via
    ADD CONSTRAINT uq_tipo_via_nombre UNIQUE (nombre);


--
-- TOC entry 4802 (class 2606 OID 40509)
-- Name: gen_via uq_via_nombre_habilitacion; Type: CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_via
    ADD CONSTRAINT uq_via_nombre_habilitacion UNIQUE (id_habilitacion_urbana, nombre);


--
-- TOC entry 4587 (class 2606 OID 36441)
-- Name: antecedente_cumplimiento antecedente_cumplimiento_id_historia_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.antecedente_cumplimiento
    ADD CONSTRAINT antecedente_cumplimiento_id_historia_key UNIQUE (id_historia);


--
-- TOC entry 4589 (class 2606 OID 36439)
-- Name: antecedente_cumplimiento antecedente_cumplimiento_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.antecedente_cumplimiento
    ADD CONSTRAINT antecedente_cumplimiento_pkey PRIMARY KEY (id_ant_cumplimiento);


--
-- TOC entry 4583 (class 2606 OID 36431)
-- Name: antecedente_familiar antecedente_familiar_id_historia_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.antecedente_familiar
    ADD CONSTRAINT antecedente_familiar_id_historia_key UNIQUE (id_historia);


--
-- TOC entry 4585 (class 2606 OID 36429)
-- Name: antecedente_familiar antecedente_familiar_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.antecedente_familiar
    ADD CONSTRAINT antecedente_familiar_pkey PRIMARY KEY (id_ant_fam);


--
-- TOC entry 4579 (class 2606 OID 36421)
-- Name: antecedente_medico antecedente_medico_id_historia_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.antecedente_medico
    ADD CONSTRAINT antecedente_medico_id_historia_key UNIQUE (id_historia);


--
-- TOC entry 4581 (class 2606 OID 36419)
-- Name: antecedente_medico antecedente_medico_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.antecedente_medico
    ADD CONSTRAINT antecedente_medico_pkey PRIMARY KEY (id_ant_patologico);


--
-- TOC entry 4575 (class 2606 OID 36411)
-- Name: antecedente_personal antecedente_personal_id_historia_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.antecedente_personal
    ADD CONSTRAINT antecedente_personal_id_historia_key UNIQUE (id_historia);


--
-- TOC entry 4577 (class 2606 OID 36409)
-- Name: antecedente_personal antecedente_personal_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.antecedente_personal
    ADD CONSTRAINT antecedente_personal_pkey PRIMARY KEY (id_antecedente);


--
-- TOC entry 4611 (class 2606 OID 36532)
-- Name: auditoria auditoria_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.auditoria
    ADD CONSTRAINT auditoria_pkey PRIMARY KEY (id_auditoria);


--
-- TOC entry 4541 (class 2606 OID 36313)
-- Name: catalogo_clinica catalogo_clinica_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_clinica
    ADD CONSTRAINT catalogo_clinica_pkey PRIMARY KEY (id_clinica);


--
-- TOC entry 4535 (class 2606 OID 36295)
-- Name: catalogo_enfermedad catalogo_enfermedad_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_enfermedad
    ADD CONSTRAINT catalogo_enfermedad_pkey PRIMARY KEY (id_enfermedad);


--
-- TOC entry 4523 (class 2606 OID 36273)
-- Name: catalogo_estado_civil catalogo_estado_civil_descripcion_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_estado_civil
    ADD CONSTRAINT catalogo_estado_civil_descripcion_key UNIQUE (descripcion);


--
-- TOC entry 4525 (class 2606 OID 36271)
-- Name: catalogo_estado_civil catalogo_estado_civil_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_estado_civil
    ADD CONSTRAINT catalogo_estado_civil_pkey PRIMARY KEY (id_estado_civil);


--
-- TOC entry 4545 (class 2606 OID 36325)
-- Name: catalogo_estado_revision catalogo_estado_revision_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_estado_revision
    ADD CONSTRAINT catalogo_estado_revision_pkey PRIMARY KEY (id_estado_revision);


--
-- TOC entry 4539 (class 2606 OID 36307)
-- Name: catalogo_examen_auxiliar catalogo_examen_auxiliar_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_examen_auxiliar
    ADD CONSTRAINT catalogo_examen_auxiliar_pkey PRIMARY KEY (id_examen);


--
-- TOC entry 4527 (class 2606 OID 36281)
-- Name: catalogo_grado_instruccion catalogo_grado_instruccion_descripcion_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_grado_instruccion
    ADD CONSTRAINT catalogo_grado_instruccion_descripcion_key UNIQUE (descripcion);


--
-- TOC entry 4529 (class 2606 OID 36279)
-- Name: catalogo_grado_instruccion catalogo_grado_instruccion_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_grado_instruccion
    ADD CONSTRAINT catalogo_grado_instruccion_pkey PRIMARY KEY (id_grado_instruccion);


--
-- TOC entry 4543 (class 2606 OID 36319)
-- Name: catalogo_grupo_sanguineo catalogo_grupo_sanguineo_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_grupo_sanguineo
    ADD CONSTRAINT catalogo_grupo_sanguineo_pkey PRIMARY KEY (id_grupo_sanguineo);


--
-- TOC entry 4537 (class 2606 OID 36301)
-- Name: catalogo_habito catalogo_habito_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_habito
    ADD CONSTRAINT catalogo_habito_pkey PRIMARY KEY (id_habito);


--
-- TOC entry 4531 (class 2606 OID 36289)
-- Name: catalogo_ocupacion catalogo_ocupacion_descripcion_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_ocupacion
    ADD CONSTRAINT catalogo_ocupacion_descripcion_key UNIQUE (descripcion);


--
-- TOC entry 4533 (class 2606 OID 36287)
-- Name: catalogo_ocupacion catalogo_ocupacion_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_ocupacion
    ADD CONSTRAINT catalogo_ocupacion_pkey PRIMARY KEY (id_ocupacion);


--
-- TOC entry 4519 (class 2606 OID 36265)
-- Name: catalogo_sexo catalogo_sexo_descripcion_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_sexo
    ADD CONSTRAINT catalogo_sexo_descripcion_key UNIQUE (descripcion);


--
-- TOC entry 4521 (class 2606 OID 36263)
-- Name: catalogo_sexo catalogo_sexo_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.catalogo_sexo
    ADD CONSTRAINT catalogo_sexo_pkey PRIMARY KEY (id_sexo);


--
-- TOC entry 4605 (class 2606 OID 36504)
-- Name: diagnostico diagnostico_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.diagnostico
    ADD CONSTRAINT diagnostico_pkey PRIMARY KEY (id_diagnostico);


--
-- TOC entry 4571 (class 2606 OID 36401)
-- Name: enfermedad_actual enfermedad_actual_id_historia_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.enfermedad_actual
    ADD CONSTRAINT enfermedad_actual_id_historia_key UNIQUE (id_historia);


--
-- TOC entry 4573 (class 2606 OID 36399)
-- Name: enfermedad_actual enfermedad_actual_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.enfermedad_actual
    ADD CONSTRAINT enfermedad_actual_pkey PRIMARY KEY (id_enfermedad_actual);


--
-- TOC entry 4609 (class 2606 OID 36523)
-- Name: evolucion evolucion_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.evolucion
    ADD CONSTRAINT evolucion_pkey PRIMARY KEY (id_evolucion);


--
-- TOC entry 4603 (class 2606 OID 36493)
-- Name: examen_auxiliar examen_auxiliar_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_auxiliar
    ADD CONSTRAINT examen_auxiliar_pkey PRIMARY KEY (id_examen_auxiliar);


--
-- TOC entry 4599 (class 2606 OID 36481)
-- Name: examen_clinico_boca examen_clinico_boca_id_historia_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_clinico_boca
    ADD CONSTRAINT examen_clinico_boca_id_historia_key UNIQUE (id_historia);


--
-- TOC entry 4601 (class 2606 OID 36479)
-- Name: examen_clinico_boca examen_clinico_boca_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_clinico_boca
    ADD CONSTRAINT examen_clinico_boca_pkey PRIMARY KEY (id_boca);


--
-- TOC entry 4591 (class 2606 OID 36451)
-- Name: examen_general examen_general_id_historia_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_general
    ADD CONSTRAINT examen_general_id_historia_key UNIQUE (id_historia);


--
-- TOC entry 4593 (class 2606 OID 36449)
-- Name: examen_general examen_general_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_general
    ADD CONSTRAINT examen_general_pkey PRIMARY KEY (id_examen);


--
-- TOC entry 4595 (class 2606 OID 36466)
-- Name: examen_regional examen_regional_id_historia_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_regional
    ADD CONSTRAINT examen_regional_id_historia_key UNIQUE (id_historia);


--
-- TOC entry 4597 (class 2606 OID 36464)
-- Name: examen_regional examen_regional_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_regional
    ADD CONSTRAINT examen_regional_pkey PRIMARY KEY (id_regional);


--
-- TOC entry 4565 (class 2606 OID 36382)
-- Name: filiacion filiacion_id_historia_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.filiacion
    ADD CONSTRAINT filiacion_id_historia_key UNIQUE (id_historia);


--
-- TOC entry 4567 (class 2606 OID 36380)
-- Name: filiacion filiacion_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.filiacion
    ADD CONSTRAINT filiacion_pkey PRIMARY KEY (id_filiacion);


--
-- TOC entry 4559 (class 2606 OID 36363)
-- Name: historia_clinica historia_clinica_id_paciente_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.historia_clinica
    ADD CONSTRAINT historia_clinica_id_paciente_key UNIQUE (id_paciente);


--
-- TOC entry 4561 (class 2606 OID 36361)
-- Name: historia_clinica historia_clinica_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.historia_clinica
    ADD CONSTRAINT historia_clinica_pkey PRIMARY KEY (id_historia);


--
-- TOC entry 4569 (class 2606 OID 36391)
-- Name: motivo_consulta motivo_consulta_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.motivo_consulta
    ADD CONSTRAINT motivo_consulta_pkey PRIMARY KEY (id_motivo);


--
-- TOC entry 4555 (class 2606 OID 36352)
-- Name: paciente paciente_dni_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.paciente
    ADD CONSTRAINT paciente_dni_key UNIQUE (dni);


--
-- TOC entry 4557 (class 2606 OID 36350)
-- Name: paciente paciente_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id_paciente);


--
-- TOC entry 4607 (class 2606 OID 36514)
-- Name: referencia_clinica referencia_clinica_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.referencia_clinica
    ADD CONSTRAINT referencia_clinica_pkey PRIMARY KEY (id_ref);


--
-- TOC entry 4563 (class 2606 OID 36372)
-- Name: revision_historia revision_historia_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.revision_historia
    ADD CONSTRAINT revision_historia_pkey PRIMARY KEY (id_revision);


--
-- TOC entry 4547 (class 2606 OID 36336)
-- Name: usuario usuario_codigo_usuario_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.usuario
    ADD CONSTRAINT usuario_codigo_usuario_key UNIQUE (codigo_usuario);


--
-- TOC entry 4549 (class 2606 OID 36338)
-- Name: usuario usuario_dni_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.usuario
    ADD CONSTRAINT usuario_dni_key UNIQUE (dni);


--
-- TOC entry 4551 (class 2606 OID 36340)
-- Name: usuario usuario_email_key; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.usuario
    ADD CONSTRAINT usuario_email_key UNIQUE (email);


--
-- TOC entry 4553 (class 2606 OID 36334)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4697 (class 2606 OID 38976)
-- Name: imp_arancel_urbano imp_arancel_urbano_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_arancel_urbano
    ADD CONSTRAINT imp_arancel_urbano_pkey PRIMARY KEY (id_arancel_urbano);


--
-- TOC entry 4755 (class 2606 OID 39322)
-- Name: imp_area_rustica imp_area_rustica_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_area_rustica
    ADD CONSTRAINT imp_area_rustica_pkey PRIMARY KEY (id_area_rustica);


--
-- TOC entry 4655 (class 2606 OID 38802)
-- Name: imp_asociacion imp_asociacion_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_asociacion
    ADD CONSTRAINT imp_asociacion_pkey PRIMARY KEY (id_asociacion);


--
-- TOC entry 4711 (class 2606 OID 39012)
-- Name: imp_categoria_edificacion imp_categoria_edificacion_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_categoria_edificacion
    ADD CONSTRAINT imp_categoria_edificacion_pkey PRIMARY KEY (id_categoria);


--
-- TOC entry 4687 (class 2606 OID 38946)
-- Name: imp_categoria_terreno_ext imp_categoria_terreno_ext_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_categoria_terreno_ext
    ADD CONSTRAINT imp_categoria_terreno_ext_pkey PRIMARY KEY (id_categoria_terreno_ext);


--
-- TOC entry 4691 (class 2606 OID 38960)
-- Name: imp_categoria_terreno imp_categoria_terreno_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_categoria_terreno
    ADD CONSTRAINT imp_categoria_terreno_pkey PRIMARY KEY (id_categoria_terreno);


--
-- TOC entry 4685 (class 2606 OID 38939)
-- Name: imp_clasificacion_terreno imp_clasificacion_terreno_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_clasificacion_terreno
    ADD CONSTRAINT imp_clasificacion_terreno_pkey PRIMARY KEY (id_clasificacion_terreno);


--
-- TOC entry 4665 (class 2606 OID 38843)
-- Name: imp_contribuyente imp_contribuyente_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_contribuyente
    ADD CONSTRAINT imp_contribuyente_pkey PRIMARY KEY (codigo);


--
-- TOC entry 4763 (class 2606 OID 39371)
-- Name: imp_cuenta_corriente imp_cuenta_corriente_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_cuenta_corriente
    ADD CONSTRAINT imp_cuenta_corriente_pkey PRIMARY KEY (id_movimiento);


--
-- TOC entry 4741 (class 2606 OID 39153)
-- Name: imp_declaracion_jurada imp_declaracion_jurada_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_declaracion_jurada
    ADD CONSTRAINT imp_declaracion_jurada_pkey PRIMARY KEY (id_declaracion_jurada);


--
-- TOC entry 4639 (class 2606 OID 38731)
-- Name: imp_departamento imp_departamento_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_departamento
    ADD CONSTRAINT imp_departamento_pkey PRIMARY KEY (id_departamento);


--
-- TOC entry 4723 (class 2606 OID 39055)
-- Name: imp_depreciacion imp_depreciacion_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_depreciacion
    ADD CONSTRAINT imp_depreciacion_pkey PRIMARY KEY (id_depreciacion);


--
-- TOC entry 4643 (class 2606 OID 38750)
-- Name: imp_distrito imp_distrito_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_distrito
    ADD CONSTRAINT imp_distrito_pkey PRIMARY KEY (id_distrito);


--
-- TOC entry 4743 (class 2606 OID 39173)
-- Name: imp_dj_predio imp_dj_predio_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_dj_predio
    ADD CONSTRAINT imp_dj_predio_pkey PRIMARY KEY (id_dj_predio);


--
-- TOC entry 4669 (class 2606 OID 38861)
-- Name: imp_domicilio_fiscal_contribuyente imp_domicilio_fiscal_contribuyente_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_domicilio_fiscal_contribuyente
    ADD CONSTRAINT imp_domicilio_fiscal_contribuyente_pkey PRIMARY KEY (id_domicilio);


--
-- TOC entry 4707 (class 2606 OID 39003)
-- Name: imp_escala_impuesto imp_escala_impuesto_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_escala_impuesto
    ADD CONSTRAINT imp_escala_impuesto_pkey PRIMARY KEY (id_escala_impuesto);


--
-- TOC entry 4693 (class 2606 OID 38969)
-- Name: imp_estado_conservacion imp_estado_conservacion_codigo_key; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_estado_conservacion
    ADD CONSTRAINT imp_estado_conservacion_codigo_key UNIQUE (codigo);


--
-- TOC entry 4695 (class 2606 OID 38967)
-- Name: imp_estado_conservacion imp_estado_conservacion_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_estado_conservacion
    ADD CONSTRAINT imp_estado_conservacion_pkey PRIMARY KEY (id_estado_conservacion);


--
-- TOC entry 4727 (class 2606 OID 39067)
-- Name: imp_exoneracion imp_exoneracion_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_exoneracion
    ADD CONSTRAINT imp_exoneracion_pkey PRIMARY KEY (id_exoneracion);


--
-- TOC entry 4753 (class 2606 OID 39310)
-- Name: imp_grupo_tierra_detalle imp_grupo_tierra_detalle_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_grupo_tierra_detalle
    ADD CONSTRAINT imp_grupo_tierra_detalle_pkey PRIMARY KEY (id_grupo_tierra_detalle);


--
-- TOC entry 4689 (class 2606 OID 38953)
-- Name: imp_grupo_tierra imp_grupo_tierra_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_grupo_tierra
    ADD CONSTRAINT imp_grupo_tierra_pkey PRIMARY KEY (id_grupo_tierra);


--
-- TOC entry 4651 (class 2606 OID 38783)
-- Name: imp_habilitacion_urbana imp_habilitacion_urbana_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_habilitacion_urbana
    ADD CONSTRAINT imp_habilitacion_urbana_pkey PRIMARY KEY (id_habilitacion);


--
-- TOC entry 4737 (class 2606 OID 39099)
-- Name: imp_junta_vecinal imp_junta_vecinal_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_junta_vecinal
    ADD CONSTRAINT imp_junta_vecinal_pkey PRIMARY KEY (id_junta_vecinal);


--
-- TOC entry 4677 (class 2606 OID 38922)
-- Name: imp_material_estructural_predio imp_material_estructural_predio_codigo_key; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_material_estructural_predio
    ADD CONSTRAINT imp_material_estructural_predio_codigo_key UNIQUE (codigo);


--
-- TOC entry 4679 (class 2606 OID 38920)
-- Name: imp_material_estructural_predio imp_material_estructural_predio_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_material_estructural_predio
    ADD CONSTRAINT imp_material_estructural_predio_pkey PRIMARY KEY (id_material_estructural_predio);


--
-- TOC entry 4681 (class 2606 OID 38932)
-- Name: imp_motivo_dj imp_motivo_dj_codigo_key; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_motivo_dj
    ADD CONSTRAINT imp_motivo_dj_codigo_key UNIQUE (codigo);


--
-- TOC entry 4683 (class 2606 OID 38930)
-- Name: imp_motivo_dj imp_motivo_dj_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_motivo_dj
    ADD CONSTRAINT imp_motivo_dj_pkey PRIMARY KEY (id_motivo_dj);


--
-- TOC entry 4671 (class 2606 OID 38905)
-- Name: imp_nivel imp_nivel_codigo_key; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_nivel
    ADD CONSTRAINT imp_nivel_codigo_key UNIQUE (codigo);


--
-- TOC entry 4673 (class 2606 OID 38903)
-- Name: imp_nivel imp_nivel_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_nivel
    ADD CONSTRAINT imp_nivel_pkey PRIMARY KEY (id_nivel);


--
-- TOC entry 4717 (class 2606 OID 39034)
-- Name: imp_obra_complementaria imp_obra_complementaria_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_obra_complementaria
    ADD CONSTRAINT imp_obra_complementaria_pkey PRIMARY KEY (id_obra);


--
-- TOC entry 4757 (class 2606 OID 39342)
-- Name: imp_pago imp_pago_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_pago
    ADD CONSTRAINT imp_pago_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 4759 (class 2606 OID 39359)
-- Name: imp_param_moratorio imp_param_moratorio_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_param_moratorio
    ADD CONSTRAINT imp_param_moratorio_pkey PRIMARY KEY (id_param_moratorio);


--
-- TOC entry 4703 (class 2606 OID 38996)
-- Name: imp_param_principales imp_param_principales_anio_key; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_param_principales
    ADD CONSTRAINT imp_param_principales_anio_key UNIQUE (anio);


--
-- TOC entry 4705 (class 2606 OID 38994)
-- Name: imp_param_principales imp_param_principales_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_param_principales
    ADD CONSTRAINT imp_param_principales_pkey PRIMARY KEY (id_param_principal);


--
-- TOC entry 4745 (class 2606 OID 39212)
-- Name: imp_predio_colindante imp_predio_colindante_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_colindante
    ADD CONSTRAINT imp_predio_colindante_pkey PRIMARY KEY (id_predio_colindante);


--
-- TOC entry 4747 (class 2606 OID 39224)
-- Name: imp_predio_construccion imp_predio_construccion_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_construccion
    ADD CONSTRAINT imp_predio_construccion_pkey PRIMARY KEY (id_predio_construccion);


--
-- TOC entry 4751 (class 2606 OID 39278)
-- Name: imp_predio_otra_instalacion imp_predio_otra_instalacion_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_otra_instalacion
    ADD CONSTRAINT imp_predio_otra_instalacion_pkey PRIMARY KEY (id_predio_otra_instalacion);


--
-- TOC entry 4739 (class 2606 OID 39109)
-- Name: imp_predio imp_predio_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio
    ADD CONSTRAINT imp_predio_pkey PRIMARY KEY (id_predio);


--
-- TOC entry 4749 (class 2606 OID 39256)
-- Name: imp_predio_terreno imp_predio_terreno_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_terreno
    ADD CONSTRAINT imp_predio_terreno_pkey PRIMARY KEY (id_predio_terreno);


--
-- TOC entry 4641 (class 2606 OID 38738)
-- Name: imp_provincia imp_provincia_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_provincia
    ADD CONSTRAINT imp_provincia_pkey PRIMARY KEY (id_provincia);


--
-- TOC entry 4645 (class 2606 OID 38762)
-- Name: imp_sector imp_sector_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_sector
    ADD CONSTRAINT imp_sector_pkey PRIMARY KEY (id_sector);


--
-- TOC entry 4649 (class 2606 OID 38776)
-- Name: imp_tipo_habilitacion_urbana imp_tipo_habilitacion_urbana_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_tipo_habilitacion_urbana
    ADD CONSTRAINT imp_tipo_habilitacion_urbana_pkey PRIMARY KEY (id_tipo_habilitacion);


--
-- TOC entry 4667 (class 2606 OID 38852)
-- Name: imp_tipo_interior imp_tipo_interior_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_tipo_interior
    ADD CONSTRAINT imp_tipo_interior_pkey PRIMARY KEY (id_tipo_interior);


--
-- TOC entry 4675 (class 2606 OID 38913)
-- Name: imp_tipo_registro_predio imp_tipo_registro_predio_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_tipo_registro_predio
    ADD CONSTRAINT imp_tipo_registro_predio_pkey PRIMARY KEY (id_tipo_registro_predio);


--
-- TOC entry 4659 (class 2606 OID 38816)
-- Name: imp_tipo_via imp_tipo_via_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_tipo_via
    ADD CONSTRAINT imp_tipo_via_pkey PRIMARY KEY (id_tipo_via);


--
-- TOC entry 4701 (class 2606 OID 38985)
-- Name: imp_uso_predio imp_uso_predio_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_uso_predio
    ADD CONSTRAINT imp_uso_predio_pkey PRIMARY KEY (id_uso);


--
-- TOC entry 4729 (class 2606 OID 39074)
-- Name: imp_valor_exoneracion imp_valor_exoneracion_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_exoneracion
    ADD CONSTRAINT imp_valor_exoneracion_pkey PRIMARY KEY (id_valor_exoneracion);


--
-- TOC entry 4713 (class 2606 OID 39021)
-- Name: imp_valor_unitario_edificacion imp_valor_unitario_edificacion_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_unitario_edificacion
    ADD CONSTRAINT imp_valor_unitario_edificacion_pkey PRIMARY KEY (id_valor_unitario_edificacion);


--
-- TOC entry 4719 (class 2606 OID 39041)
-- Name: imp_valor_unitario_obra imp_valor_unitario_obra_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_unitario_obra
    ADD CONSTRAINT imp_valor_unitario_obra_pkey PRIMARY KEY (id_valor_unitario_obra);


--
-- TOC entry 4733 (class 2606 OID 39090)
-- Name: imp_vencimiento_emision imp_vencimiento_emision_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_vencimiento_emision
    ADD CONSTRAINT imp_vencimiento_emision_pkey PRIMARY KEY (id_vencimiento_emision);


--
-- TOC entry 4661 (class 2606 OID 38823)
-- Name: imp_via imp_via_pkey; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_via
    ADD CONSTRAINT imp_via_pkey PRIMARY KEY (id_via);


--
-- TOC entry 4699 (class 2606 OID 38978)
-- Name: imp_arancel_urbano uq_imp_arancel_anio_direccion; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_arancel_urbano
    ADD CONSTRAINT uq_imp_arancel_anio_direccion UNIQUE (anio, direccion_predio);


--
-- TOC entry 4657 (class 2606 OID 38804)
-- Name: imp_asociacion uq_imp_asociacion_idaso_distrito; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_asociacion
    ADD CONSTRAINT uq_imp_asociacion_idaso_distrito UNIQUE (id_asociacion, id_distrito);


--
-- TOC entry 4725 (class 2606 OID 39057)
-- Name: imp_depreciacion uq_imp_depreciacion_anio_clasif; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_depreciacion
    ADD CONSTRAINT uq_imp_depreciacion_anio_clasif UNIQUE (anio, clasificacion);


--
-- TOC entry 4709 (class 2606 OID 39005)
-- Name: imp_escala_impuesto uq_imp_escala_anio_desde_hasta; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_escala_impuesto
    ADD CONSTRAINT uq_imp_escala_anio_desde_hasta UNIQUE (anio, desde_autovaluo, hasta_autovaluo);


--
-- TOC entry 4653 (class 2606 OID 38785)
-- Name: imp_habilitacion_urbana uq_imp_habilitacion_idhab_distrito; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_habilitacion_urbana
    ADD CONSTRAINT uq_imp_habilitacion_idhab_distrito UNIQUE (id_habilitacion, id_distrito);


--
-- TOC entry 4761 (class 2606 OID 39361)
-- Name: imp_param_moratorio uq_imp_param_moratorio_anio; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_param_moratorio
    ADD CONSTRAINT uq_imp_param_moratorio_anio UNIQUE (anio);


--
-- TOC entry 4647 (class 2606 OID 38764)
-- Name: imp_sector uq_imp_sector_id_sector_distrito; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_sector
    ADD CONSTRAINT uq_imp_sector_id_sector_distrito UNIQUE (id_sector, id_distrito);


--
-- TOC entry 4731 (class 2606 OID 39076)
-- Name: imp_valor_exoneracion uq_imp_valor_exoneracion_anio_exo; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_exoneracion
    ADD CONSTRAINT uq_imp_valor_exoneracion_anio_exo UNIQUE (anio, id_exoneracion);


--
-- TOC entry 4721 (class 2606 OID 39043)
-- Name: imp_valor_unitario_obra uq_imp_valorobra_anio_obra; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_unitario_obra
    ADD CONSTRAINT uq_imp_valorobra_anio_obra UNIQUE (anio, id_obra);


--
-- TOC entry 4715 (class 2606 OID 39023)
-- Name: imp_valor_unitario_edificacion uq_imp_valorunit_edif_anio_cat; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_unitario_edificacion
    ADD CONSTRAINT uq_imp_valorunit_edif_anio_cat UNIQUE (anio, id_categoria);


--
-- TOC entry 4735 (class 2606 OID 39092)
-- Name: imp_vencimiento_emision uq_imp_venc_emision_tr_anio_periodo; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_vencimiento_emision
    ADD CONSTRAINT uq_imp_venc_emision_tr_anio_periodo UNIQUE (tributo, anio, periodo);


--
-- TOC entry 4663 (class 2606 OID 38825)
-- Name: imp_via uq_imp_via_idvia_distrito; Type: CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_via
    ADD CONSTRAINT uq_imp_via_idvia_distrito UNIQUE (id_via, id_distrito);


--
-- TOC entry 4844 (class 2606 OID 40743)
-- Name: lic_actividad_comercial pk_actividad_comercial; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_actividad_comercial
    ADD CONSTRAINT pk_actividad_comercial PRIMARY KEY (id);


--
-- TOC entry 4840 (class 2606 OID 40728)
-- Name: lic_condicion_local pk_condicion_local; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_condicion_local
    ADD CONSTRAINT pk_condicion_local PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 40823)
-- Name: lic_documento pk_documento; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_documento
    ADD CONSTRAINT pk_documento PRIMARY KEY (id);


--
-- TOC entry 4860 (class 2606 OID 40805)
-- Name: lic_giro_licencia pk_giro_licencia; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_giro_licencia
    ADD CONSTRAINT pk_giro_licencia PRIMARY KEY (id);


--
-- TOC entry 4852 (class 2606 OID 40774)
-- Name: lic_giro_negocio pk_giro_negocio; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_giro_negocio
    ADD CONSTRAINT pk_giro_negocio PRIMARY KEY (id);


--
-- TOC entry 4872 (class 2606 OID 40846)
-- Name: lic_licencia pk_licencia; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT pk_licencia PRIMARY KEY (id);


--
-- TOC entry 4832 (class 2606 OID 40698)
-- Name: lic_motivo_registro pk_motivo_registro; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_motivo_registro
    ADD CONSTRAINT pk_motivo_registro PRIMARY KEY (id);


--
-- TOC entry 4856 (class 2606 OID 40789)
-- Name: lic_requisito pk_requisito; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_requisito
    ADD CONSTRAINT pk_requisito PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 40910)
-- Name: lic_sust_anulacion pk_sust_anulacion; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_sust_anulacion
    ADD CONSTRAINT pk_sust_anulacion PRIMARY KEY (id);


--
-- TOC entry 4848 (class 2606 OID 40758)
-- Name: lic_tipo_establecimiento pk_tipo_establecimiento; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_tipo_establecimiento
    ADD CONSTRAINT pk_tipo_establecimiento PRIMARY KEY (id);


--
-- TOC entry 4836 (class 2606 OID 40713)
-- Name: lic_tipo_licencia pk_tipo_licencia; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_tipo_licencia
    ADD CONSTRAINT pk_tipo_licencia PRIMARY KEY (id);


--
-- TOC entry 4846 (class 2606 OID 40745)
-- Name: lic_actividad_comercial uq_actividad_comercial_nombre; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_actividad_comercial
    ADD CONSTRAINT uq_actividad_comercial_nombre UNIQUE (nombre);


--
-- TOC entry 4842 (class 2606 OID 40730)
-- Name: lic_condicion_local uq_condicion_local_nombre; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_condicion_local
    ADD CONSTRAINT uq_condicion_local_nombre UNIQUE (nombre);


--
-- TOC entry 4854 (class 2606 OID 40776)
-- Name: lic_giro_negocio uq_giro_negocio_nombre; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_giro_negocio
    ADD CONSTRAINT uq_giro_negocio_nombre UNIQUE (nombre);


--
-- TOC entry 4874 (class 2606 OID 40848)
-- Name: lic_licencia uq_licencia_num_certificado; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT uq_licencia_num_certificado UNIQUE (num_certificado);


--
-- TOC entry 4876 (class 2606 OID 40850)
-- Name: lic_licencia uq_licencia_num_expediente; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT uq_licencia_num_expediente UNIQUE (num_expediente);


--
-- TOC entry 4878 (class 2606 OID 40852)
-- Name: lic_licencia uq_licencia_num_resolucion; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT uq_licencia_num_resolucion UNIQUE (num_resolucion);


--
-- TOC entry 4834 (class 2606 OID 40700)
-- Name: lic_motivo_registro uq_motivo_registro_nombre; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_motivo_registro
    ADD CONSTRAINT uq_motivo_registro_nombre UNIQUE (nombre);


--
-- TOC entry 4858 (class 2606 OID 40791)
-- Name: lic_requisito uq_requisito_nombre; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_requisito
    ADD CONSTRAINT uq_requisito_nombre UNIQUE (nombre);


--
-- TOC entry 4850 (class 2606 OID 40760)
-- Name: lic_tipo_establecimiento uq_tipo_establecimiento_nombre; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_tipo_establecimiento
    ADD CONSTRAINT uq_tipo_establecimiento_nombre UNIQUE (nombre);


--
-- TOC entry 4838 (class 2606 OID 40715)
-- Name: lic_tipo_licencia uq_tipo_licencia_nombre; Type: CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_tipo_licencia
    ADD CONSTRAINT uq_tipo_licencia_nombre UNIQUE (nombre);


--
-- TOC entry 4882 (class 2606 OID 41044)
-- Name: estado_servicio estado_servicio_nombre_estado_key; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.estado_servicio
    ADD CONSTRAINT estado_servicio_nombre_estado_key UNIQUE (nombre_estado);


--
-- TOC entry 4894 (class 2606 OID 41078)
-- Name: categoria_servicio pk_categoria_servicio; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.categoria_servicio
    ADD CONSTRAINT pk_categoria_servicio PRIMARY KEY (id_categoria_servicio);


--
-- TOC entry 4902 (class 2606 OID 41105)
-- Name: configuracion pk_configuracion; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.configuracion
    ADD CONSTRAINT pk_configuracion PRIMARY KEY (parametro);


--
-- TOC entry 4912 (class 2606 OID 41138)
-- Name: contrato pk_contrato; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato
    ADD CONSTRAINT pk_contrato PRIMARY KEY (id_contrato);


--
-- TOC entry 4916 (class 2606 OID 41182)
-- Name: contrato_instalacion_pago pk_contrato_instalacion_pago; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato_instalacion_pago
    ADD CONSTRAINT pk_contrato_instalacion_pago PRIMARY KEY (id_contrato);


--
-- TOC entry 4931 (class 2606 OID 41259)
-- Name: corte_suspension pk_corte_suspension; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.corte_suspension
    ADD CONSTRAINT pk_corte_suspension PRIMARY KEY (id_corte_suspension);


--
-- TOC entry 4884 (class 2606 OID 41042)
-- Name: estado_servicio pk_estado_servicio; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.estado_servicio
    ADD CONSTRAINT pk_estado_servicio PRIMARY KEY (id_estado_servicio);


--
-- TOC entry 4935 (class 2606 OID 41290)
-- Name: informe_mantenimiento pk_informe_mantenimiento; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.informe_mantenimiento
    ADD CONSTRAINT pk_informe_mantenimiento PRIMARY KEY (id_informe);


--
-- TOC entry 4933 (class 2606 OID 41274)
-- Name: omision_servicio pk_omision_servicio; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.omision_servicio
    ADD CONSTRAINT pk_omision_servicio PRIMARY KEY (id_omision);


--
-- TOC entry 4928 (class 2606 OID 41238)
-- Name: pago pk_pago; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.pago
    ADD CONSTRAINT pk_pago PRIMARY KEY (id_pago);


--
-- TOC entry 4923 (class 2606 OID 41217)
-- Name: recibo pk_recibo; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.recibo
    ADD CONSTRAINT pk_recibo PRIMARY KEY (id_recibo);


--
-- TOC entry 4886 (class 2606 OID 41054)
-- Name: red_agua pk_red_agua; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.red_agua
    ADD CONSTRAINT pk_red_agua PRIMARY KEY (id_red_agua);


--
-- TOC entry 4918 (class 2606 OID 41199)
-- Name: sustento_descuento pk_sustento_descuento; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.sustento_descuento
    ADD CONSTRAINT pk_sustento_descuento PRIMARY KEY (id_sustento_descuento);


--
-- TOC entry 4898 (class 2606 OID 41090)
-- Name: tarifa pk_tarifa; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.tarifa
    ADD CONSTRAINT pk_tarifa PRIMARY KEY (id_tarifa);


--
-- TOC entry 4906 (class 2606 OID 41120)
-- Name: usuario pk_usuario; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (id_contribuyente);


--
-- TOC entry 4904 (class 2606 OID 41112)
-- Name: vencimiento_parametro_anual pk_vencimiento_parametro_anual; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.vencimiento_parametro_anual
    ADD CONSTRAINT pk_vencimiento_parametro_anual PRIMARY KEY (anio, mes);


--
-- TOC entry 4890 (class 2606 OID 41066)
-- Name: zona_afectacion pk_zona_afectacion; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.zona_afectacion
    ADD CONSTRAINT pk_zona_afectacion PRIMARY KEY (id_zona_afectacion);


--
-- TOC entry 4888 (class 2606 OID 41056)
-- Name: red_agua red_agua_nombre_red_key; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.red_agua
    ADD CONSTRAINT red_agua_nombre_red_key UNIQUE (nombre_red);


--
-- TOC entry 4896 (class 2606 OID 41080)
-- Name: categoria_servicio uq_categoria_servicio_nombre_anio; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.categoria_servicio
    ADD CONSTRAINT uq_categoria_servicio_nombre_anio UNIQUE (nombre_categoria, anio_vigencia);


--
-- TOC entry 4914 (class 2606 OID 41140)
-- Name: contrato uq_contrato_numero; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato
    ADD CONSTRAINT uq_contrato_numero UNIQUE (numero_contrato);


--
-- TOC entry 4925 (class 2606 OID 41219)
-- Name: recibo uq_recibo_contrato_periodo; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.recibo
    ADD CONSTRAINT uq_recibo_contrato_periodo UNIQUE (id_contrato, anio, mes);


--
-- TOC entry 4920 (class 2606 OID 41201)
-- Name: sustento_descuento uq_sustento_descuento_numero; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.sustento_descuento
    ADD CONSTRAINT uq_sustento_descuento_numero UNIQUE (numero_documento);


--
-- TOC entry 4900 (class 2606 OID 41092)
-- Name: tarifa uq_tarifa_categoria_anio_mes; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.tarifa
    ADD CONSTRAINT uq_tarifa_categoria_anio_mes UNIQUE (id_categoria_servicio, anio, mes);


--
-- TOC entry 4908 (class 2606 OID 41122)
-- Name: usuario uq_usuario_codigo_saa; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.usuario
    ADD CONSTRAINT uq_usuario_codigo_saa UNIQUE (codigo_usuario_saa);


--
-- TOC entry 4892 (class 2606 OID 41068)
-- Name: zona_afectacion zona_afectacion_nombre_zona_key; Type: CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.zona_afectacion
    ADD CONSTRAINT zona_afectacion_nombre_zona_key UNIQUE (nombre_zona);


--
-- TOC entry 4803 (class 1259 OID 40604)
-- Name: idx_contribuyente_dni; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_contribuyente_dni ON gen.gen_contribuyente USING btree (dni) WHERE (dni IS NOT NULL);


--
-- TOC entry 4804 (class 1259 OID 40603)
-- Name: idx_contribuyente_estado; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_contribuyente_estado ON gen.gen_contribuyente USING btree (estado);


--
-- TOC entry 4805 (class 1259 OID 40602)
-- Name: idx_contribuyente_nombre; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_contribuyente_nombre ON gen.gen_contribuyente USING btree (nombre);


--
-- TOC entry 4806 (class 1259 OID 40605)
-- Name: idx_contribuyente_ruc; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_contribuyente_ruc ON gen.gen_contribuyente USING btree (ruc) WHERE (ruc IS NOT NULL);


--
-- TOC entry 4773 (class 1259 OID 40614)
-- Name: idx_distrito_provincia; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_distrito_provincia ON gen.gen_distrito USING btree (id_provincia);


--
-- TOC entry 4793 (class 1259 OID 40616)
-- Name: idx_habilitacion_distrito; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_habilitacion_distrito ON gen.gen_habilitacion_urbana USING btree (id_distrito);


--
-- TOC entry 4813 (class 1259 OID 40606)
-- Name: idx_predio_departamento; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_predio_departamento ON gen.gen_predio USING btree (id_departamento);


--
-- TOC entry 4814 (class 1259 OID 40608)
-- Name: idx_predio_distrito; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_predio_distrito ON gen.gen_predio USING btree (id_distrito);


--
-- TOC entry 4815 (class 1259 OID 40612)
-- Name: idx_predio_estado; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_predio_estado ON gen.gen_predio USING btree (estado);


--
-- TOC entry 4816 (class 1259 OID 40609)
-- Name: idx_predio_habilitacion_urbana; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_predio_habilitacion_urbana ON gen.gen_predio USING btree (id_habilitacion_urbana);


--
-- TOC entry 4817 (class 1259 OID 40607)
-- Name: idx_predio_provincia; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_predio_provincia ON gen.gen_predio USING btree (id_provincia);


--
-- TOC entry 4818 (class 1259 OID 40611)
-- Name: idx_predio_ubigeo; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_predio_ubigeo ON gen.gen_predio USING btree (ubigeo);


--
-- TOC entry 4819 (class 1259 OID 40610)
-- Name: idx_predio_via; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_predio_via ON gen.gen_predio USING btree (id_via);


--
-- TOC entry 4768 (class 1259 OID 40613)
-- Name: idx_provincia_departamento; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_provincia_departamento ON gen.gen_provincia USING btree (id_departamento);


--
-- TOC entry 4776 (class 1259 OID 40615)
-- Name: idx_sector_distrito; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_sector_distrito ON gen.gen_sector USING btree (id_distrito);


--
-- TOC entry 4798 (class 1259 OID 40617)
-- Name: idx_via_habilitacion; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_via_habilitacion ON gen.gen_via USING btree (id_habilitacion_urbana);


--
-- TOC entry 4826 (class 1259 OID 40677)
-- Name: idx_vw_contribuyente_dni; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_vw_contribuyente_dni ON gen.vw_gen_contribuyente USING btree (dni) WHERE (dni IS NOT NULL);


--
-- TOC entry 4827 (class 1259 OID 40676)
-- Name: idx_vw_contribuyente_nombre; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_vw_contribuyente_nombre ON gen.vw_gen_contribuyente USING btree (nombre);


--
-- TOC entry 4828 (class 1259 OID 40678)
-- Name: idx_vw_contribuyente_ruc; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_vw_contribuyente_ruc ON gen.vw_gen_contribuyente USING btree (ruc) WHERE (ruc IS NOT NULL);


--
-- TOC entry 4822 (class 1259 OID 40672)
-- Name: idx_vw_departamento_nombre; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_vw_departamento_nombre ON gen.vw_gen_departamento USING btree (nombre);


--
-- TOC entry 4824 (class 1259 OID 40674)
-- Name: idx_vw_distrito_provincia; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_vw_distrito_provincia ON gen.vw_gen_distrito USING btree (id_provincia);


--
-- TOC entry 4829 (class 1259 OID 40680)
-- Name: idx_vw_predio_codigo_catastral; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_vw_predio_codigo_catastral ON gen.vw_gen_predio USING btree (codigo_catastral);


--
-- TOC entry 4830 (class 1259 OID 40679)
-- Name: idx_vw_predio_ubigeo; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_vw_predio_ubigeo ON gen.vw_gen_predio USING btree (ubigeo);


--
-- TOC entry 4823 (class 1259 OID 40673)
-- Name: idx_vw_provincia_departamento; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_vw_provincia_departamento ON gen.vw_gen_provincia USING btree (id_departamento);


--
-- TOC entry 4825 (class 1259 OID 40675)
-- Name: idx_vw_sector_distrito; Type: INDEX; Schema: gen; Owner: admin
--

CREATE INDEX idx_vw_sector_distrito ON gen.vw_gen_sector USING btree (id_distrito);


--
-- TOC entry 4861 (class 1259 OID 40928)
-- Name: idx_documento_fecha; Type: INDEX; Schema: lic; Owner: admin
--

CREATE INDEX idx_documento_fecha ON lic.lic_documento USING btree (fecha);


--
-- TOC entry 4862 (class 1259 OID 40927)
-- Name: idx_documento_requisito; Type: INDEX; Schema: lic; Owner: admin
--

CREATE INDEX idx_documento_requisito ON lic.lic_documento USING btree (id_requisito);


--
-- TOC entry 4865 (class 1259 OID 40926)
-- Name: idx_licencia_certificado_fecha; Type: INDEX; Schema: lic; Owner: admin
--

CREATE INDEX idx_licencia_certificado_fecha ON lic.lic_licencia USING btree (certificado_fecha);


--
-- TOC entry 4866 (class 1259 OID 40922)
-- Name: idx_licencia_contribuyente; Type: INDEX; Schema: lic; Owner: admin
--

CREATE INDEX idx_licencia_contribuyente ON lic.lic_licencia USING btree (id_contribuyente);


--
-- TOC entry 4867 (class 1259 OID 40921)
-- Name: idx_licencia_estado; Type: INDEX; Schema: lic; Owner: admin
--

CREATE INDEX idx_licencia_estado ON lic.lic_licencia USING btree (estado);


--
-- TOC entry 4868 (class 1259 OID 40925)
-- Name: idx_licencia_expediente; Type: INDEX; Schema: lic; Owner: admin
--

CREATE INDEX idx_licencia_expediente ON lic.lic_licencia USING btree (num_expediente);


--
-- TOC entry 4869 (class 1259 OID 40924)
-- Name: idx_licencia_num_certificado; Type: INDEX; Schema: lic; Owner: admin
--

CREATE INDEX idx_licencia_num_certificado ON lic.lic_licencia USING btree (num_certificado);


--
-- TOC entry 4870 (class 1259 OID 40923)
-- Name: idx_licencia_predio; Type: INDEX; Schema: lic; Owner: admin
--

CREATE INDEX idx_licencia_predio ON lic.lic_licencia USING btree (id_predio);


--
-- TOC entry 4909 (class 1259 OID 41296)
-- Name: idx_contrato_contribuyente; Type: INDEX; Schema: saa; Owner: admin
--

CREATE INDEX idx_contrato_contribuyente ON saa.contrato USING btree (id_contribuyente);


--
-- TOC entry 4910 (class 1259 OID 41297)
-- Name: idx_contrato_predio; Type: INDEX; Schema: saa; Owner: admin
--

CREATE INDEX idx_contrato_predio ON saa.contrato USING btree (id_predio);


--
-- TOC entry 4929 (class 1259 OID 41300)
-- Name: idx_corte_suspension_contrato; Type: INDEX; Schema: saa; Owner: admin
--

CREATE INDEX idx_corte_suspension_contrato ON saa.corte_suspension USING btree (id_contrato);


--
-- TOC entry 4926 (class 1259 OID 41299)
-- Name: idx_pago_recibo; Type: INDEX; Schema: saa; Owner: admin
--

CREATE INDEX idx_pago_recibo ON saa.pago USING btree (id_recibo);


--
-- TOC entry 4921 (class 1259 OID 41298)
-- Name: idx_recibo_contrato_periodo; Type: INDEX; Schema: saa; Owner: admin
--

CREATE INDEX idx_recibo_contrato_periodo ON saa.recibo USING btree (id_contrato, anio, mes);


--
-- TOC entry 5173 (class 2620 OID 42084)
-- Name: alc_contrato_alcabala tr_contrato_alcabala_iu; Type: TRIGGER; Schema: alc; Owner: admin
--

CREATE TRIGGER tr_contrato_alcabala_iu BEFORE INSERT OR UPDATE ON alc.alc_contrato_alcabala FOR EACH ROW EXECUTE FUNCTION alc.fn_calcular_impuesto_alcabala();


--
-- TOC entry 5172 (class 2620 OID 42090)
-- Name: arbitrio_detalle tr_calcular_arbitrio_detalle_iu; Type: TRIGGER; Schema: arb; Owner: admin
--

CREATE TRIGGER tr_calcular_arbitrio_detalle_iu BEFORE INSERT OR UPDATE ON arb.arbitrio_detalle FOR EACH ROW EXECUTE FUNCTION arb.fn_calcular_arbitrio_detalle();


--
-- TOC entry 5137 (class 2620 OID 36741)
-- Name: cajero trg_auditoria_cajero; Type: TRIGGER; Schema: caj; Owner: postgres
--

CREATE TRIGGER trg_auditoria_cajero AFTER INSERT OR DELETE OR UPDATE ON caj.cajero FOR EACH ROW EXECUTE FUNCTION caj.fn_auditoria();


--
-- TOC entry 5138 (class 2620 OID 36742)
-- Name: pago trg_auditoria_pago; Type: TRIGGER; Schema: caj; Owner: postgres
--

CREATE TRIGGER trg_auditoria_pago AFTER INSERT OR DELETE OR UPDATE ON caj.pago FOR EACH ROW EXECUTE FUNCTION caj.fn_auditoria();


--
-- TOC entry 5139 (class 2620 OID 36743)
-- Name: recibo trg_auditoria_recibo; Type: TRIGGER; Schema: caj; Owner: postgres
--

CREATE TRIGGER trg_auditoria_recibo AFTER INSERT OR DELETE OR UPDATE ON caj.recibo FOR EACH ROW EXECUTE FUNCTION caj.fn_auditoria();


--
-- TOC entry 5152 (class 2620 OID 41018)
-- Name: lic_actividad_comercial tg_actualizar_modificado_actividad_comercial_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_actividad_comercial_u BEFORE UPDATE ON lic.lic_actividad_comercial FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5148 (class 2620 OID 41017)
-- Name: lic_condicion_local tg_actualizar_modificado_condicion_local_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_condicion_local_u BEFORE UPDATE ON lic.lic_condicion_local FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5169 (class 2620 OID 41024)
-- Name: lic_documento tg_actualizar_modificado_documento_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_documento_u BEFORE UPDATE ON lic.lic_documento FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5168 (class 2620 OID 41023)
-- Name: lic_giro_licencia tg_actualizar_modificado_giro_licencia_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_giro_licencia_u BEFORE UPDATE ON lic.lic_giro_licencia FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5160 (class 2620 OID 41020)
-- Name: lic_giro_negocio tg_actualizar_modificado_giro_negocio_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_giro_negocio_u BEFORE UPDATE ON lic.lic_giro_negocio FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5170 (class 2620 OID 41022)
-- Name: lic_licencia tg_actualizar_modificado_licencia_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_licencia_u BEFORE UPDATE ON lic.lic_licencia FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5140 (class 2620 OID 41015)
-- Name: lic_motivo_registro tg_actualizar_modificado_motivo_registro_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_motivo_registro_u BEFORE UPDATE ON lic.lic_motivo_registro FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5164 (class 2620 OID 41021)
-- Name: lic_requisito tg_actualizar_modificado_requisito_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_requisito_u BEFORE UPDATE ON lic.lic_requisito FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5156 (class 2620 OID 41019)
-- Name: lic_tipo_establecimiento tg_actualizar_modificado_tipo_establecimiento_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_tipo_establecimiento_u BEFORE UPDATE ON lic.lic_tipo_establecimiento FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5144 (class 2620 OID 41016)
-- Name: lic_tipo_licencia tg_actualizar_modificado_tipo_licencia_u; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_modificado_tipo_licencia_u BEFORE UPDATE ON lic.lic_tipo_licencia FOR EACH ROW EXECUTE FUNCTION lic.fn_actualizar_modificado();


--
-- TOC entry 5153 (class 2620 OID 41028)
-- Name: lic_actividad_comercial tg_actualizar_vistas_actividad_comercial_iud; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_vistas_actividad_comercial_iud AFTER INSERT OR DELETE OR UPDATE ON lic.lic_actividad_comercial FOR EACH STATEMENT EXECUTE FUNCTION lic.fn_actualizar_vista_actividad_comercial();


--
-- TOC entry 5149 (class 2620 OID 41027)
-- Name: lic_condicion_local tg_actualizar_vistas_condicion_local_iud; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_vistas_condicion_local_iud AFTER INSERT OR DELETE OR UPDATE ON lic.lic_condicion_local FOR EACH STATEMENT EXECUTE FUNCTION lic.fn_actualizar_vista_condicion_local();


--
-- TOC entry 5161 (class 2620 OID 41030)
-- Name: lic_giro_negocio tg_actualizar_vistas_giro_negocio_iud; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_vistas_giro_negocio_iud AFTER INSERT OR DELETE OR UPDATE ON lic.lic_giro_negocio FOR EACH STATEMENT EXECUTE FUNCTION lic.fn_actualizar_vista_giro_negocio();


--
-- TOC entry 5171 (class 2620 OID 41032)
-- Name: lic_licencia tg_actualizar_vistas_licencia_iud; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_vistas_licencia_iud AFTER INSERT OR DELETE OR UPDATE ON lic.lic_licencia FOR EACH STATEMENT EXECUTE FUNCTION lic.fn_actualizar_vista_licencia();


--
-- TOC entry 5141 (class 2620 OID 41025)
-- Name: lic_motivo_registro tg_actualizar_vistas_motivo_registro_iud; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_vistas_motivo_registro_iud AFTER INSERT OR DELETE OR UPDATE ON lic.lic_motivo_registro FOR EACH STATEMENT EXECUTE FUNCTION lic.fn_actualizar_vista_motivo_registro();


--
-- TOC entry 5165 (class 2620 OID 41031)
-- Name: lic_requisito tg_actualizar_vistas_requisito_iud; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_vistas_requisito_iud AFTER INSERT OR DELETE OR UPDATE ON lic.lic_requisito FOR EACH STATEMENT EXECUTE FUNCTION lic.fn_actualizar_vista_requisito();


--
-- TOC entry 5157 (class 2620 OID 41029)
-- Name: lic_tipo_establecimiento tg_actualizar_vistas_tipo_establecimiento_iud; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_vistas_tipo_establecimiento_iud AFTER INSERT OR DELETE OR UPDATE ON lic.lic_tipo_establecimiento FOR EACH STATEMENT EXECUTE FUNCTION lic.fn_actualizar_vista_tipo_establecimiento();


--
-- TOC entry 5145 (class 2620 OID 41026)
-- Name: lic_tipo_licencia tg_actualizar_vistas_tipo_licencia_iud; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_actualizar_vistas_tipo_licencia_iud AFTER INSERT OR DELETE OR UPDATE ON lic.lic_tipo_licencia FOR EACH STATEMENT EXECUTE FUNCTION lic.fn_actualizar_vista_tipo_licencia();


--
-- TOC entry 5154 (class 2620 OID 41004)
-- Name: lic_actividad_comercial tg_evitar_duplicados_actividad_comercial_iu; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_duplicados_actividad_comercial_iu BEFORE INSERT OR UPDATE ON lic.lic_actividad_comercial FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_duplicados_catalogo();


--
-- TOC entry 5150 (class 2620 OID 41003)
-- Name: lic_condicion_local tg_evitar_duplicados_condicion_local_iu; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_duplicados_condicion_local_iu BEFORE INSERT OR UPDATE ON lic.lic_condicion_local FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_duplicados_catalogo();


--
-- TOC entry 5162 (class 2620 OID 41006)
-- Name: lic_giro_negocio tg_evitar_duplicados_giro_negocio_iu; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_duplicados_giro_negocio_iu BEFORE INSERT OR UPDATE ON lic.lic_giro_negocio FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_duplicados_catalogo();


--
-- TOC entry 5142 (class 2620 OID 41001)
-- Name: lic_motivo_registro tg_evitar_duplicados_motivo_registro_iu; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_duplicados_motivo_registro_iu BEFORE INSERT OR UPDATE ON lic.lic_motivo_registro FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_duplicados_catalogo();


--
-- TOC entry 5166 (class 2620 OID 41007)
-- Name: lic_requisito tg_evitar_duplicados_requisito_iu; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_duplicados_requisito_iu BEFORE INSERT OR UPDATE ON lic.lic_requisito FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_duplicados_catalogo();


--
-- TOC entry 5158 (class 2620 OID 41005)
-- Name: lic_tipo_establecimiento tg_evitar_duplicados_tipo_establecimiento_iu; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_duplicados_tipo_establecimiento_iu BEFORE INSERT OR UPDATE ON lic.lic_tipo_establecimiento FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_duplicados_catalogo();


--
-- TOC entry 5146 (class 2620 OID 41002)
-- Name: lic_tipo_licencia tg_evitar_duplicados_tipo_licencia_iu; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_duplicados_tipo_licencia_iu BEFORE INSERT OR UPDATE ON lic.lic_tipo_licencia FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_duplicados_catalogo();


--
-- TOC entry 5155 (class 2620 OID 41011)
-- Name: lic_actividad_comercial tg_evitar_eliminar_ultimo_actividad_comercial_d; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_eliminar_ultimo_actividad_comercial_d BEFORE DELETE ON lic.lic_actividad_comercial FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_eliminar_ultimo();


--
-- TOC entry 5151 (class 2620 OID 41010)
-- Name: lic_condicion_local tg_evitar_eliminar_ultimo_condicion_local_d; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_eliminar_ultimo_condicion_local_d BEFORE DELETE ON lic.lic_condicion_local FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_eliminar_ultimo();


--
-- TOC entry 5163 (class 2620 OID 41013)
-- Name: lic_giro_negocio tg_evitar_eliminar_ultimo_giro_negocio_d; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_eliminar_ultimo_giro_negocio_d BEFORE DELETE ON lic.lic_giro_negocio FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_eliminar_ultimo();


--
-- TOC entry 5143 (class 2620 OID 41008)
-- Name: lic_motivo_registro tg_evitar_eliminar_ultimo_motivo_registro_d; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_eliminar_ultimo_motivo_registro_d BEFORE DELETE ON lic.lic_motivo_registro FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_eliminar_ultimo();


--
-- TOC entry 5167 (class 2620 OID 41014)
-- Name: lic_requisito tg_evitar_eliminar_ultimo_requisito_d; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_eliminar_ultimo_requisito_d BEFORE DELETE ON lic.lic_requisito FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_eliminar_ultimo();


--
-- TOC entry 5159 (class 2620 OID 41012)
-- Name: lic_tipo_establecimiento tg_evitar_eliminar_ultimo_tipo_establecimiento_d; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_eliminar_ultimo_tipo_establecimiento_d BEFORE DELETE ON lic.lic_tipo_establecimiento FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_eliminar_ultimo();


--
-- TOC entry 5147 (class 2620 OID 41009)
-- Name: lic_tipo_licencia tg_evitar_eliminar_ultimo_tipo_licencia_d; Type: TRIGGER; Schema: lic; Owner: admin
--

CREATE TRIGGER tg_evitar_eliminar_ultimo_tipo_licencia_d BEFORE DELETE ON lic.lic_tipo_licencia FOR EACH ROW EXECUTE FUNCTION lic.fn_evitar_eliminar_ultimo();


--
-- TOC entry 5131 (class 2606 OID 42050)
-- Name: alc_contrato_alcabala fk_alc_contrato_entidad; Type: FK CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_contrato_alcabala
    ADD CONSTRAINT fk_alc_contrato_entidad FOREIGN KEY (id_entidad_inafecta) REFERENCES alc.alc_entidad_inafecta(id);


--
-- TOC entry 5132 (class 2606 OID 42045)
-- Name: alc_contrato_alcabala fk_alc_contrato_factor; Type: FK CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_contrato_alcabala
    ADD CONSTRAINT fk_alc_contrato_factor FOREIGN KEY (id_factor_calculo) REFERENCES alc.alc_factor_calculo(id);


--
-- TOC entry 5133 (class 2606 OID 42065)
-- Name: alc_contrato_alcabala fk_alc_contrato_gen_contribuyente_adq; Type: FK CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_contrato_alcabala
    ADD CONSTRAINT fk_alc_contrato_gen_contribuyente_adq FOREIGN KEY (id_contribuyente_adquiriente) REFERENCES gen.gen_contribuyente(id);


--
-- TOC entry 5134 (class 2606 OID 42060)
-- Name: alc_contrato_alcabala fk_alc_contrato_gen_contribuyente_transf; Type: FK CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_contrato_alcabala
    ADD CONSTRAINT fk_alc_contrato_gen_contribuyente_transf FOREIGN KEY (id_contribuyente_transferente) REFERENCES gen.gen_contribuyente(id);


--
-- TOC entry 5135 (class 2606 OID 42055)
-- Name: alc_contrato_alcabala fk_alc_contrato_gen_predio; Type: FK CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_contrato_alcabala
    ADD CONSTRAINT fk_alc_contrato_gen_predio FOREIGN KEY (id_predio) REFERENCES gen.gen_predio(id);


--
-- TOC entry 5136 (class 2606 OID 42078)
-- Name: alc_estado_contrato fk_alc_estado_contrato_contrato; Type: FK CONSTRAINT; Schema: alc; Owner: admin
--

ALTER TABLE ONLY alc.alc_estado_contrato
    ADD CONSTRAINT fk_alc_estado_contrato_contrato FOREIGN KEY (id_contrato_alcabala) REFERENCES alc.alc_contrato_alcabala(id);


--
-- TOC entry 5111 (class 2606 OID 41834)
-- Name: arbitrio fk_arbitrio_contribuyente; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio
    ADD CONSTRAINT fk_arbitrio_contribuyente FOREIGN KEY (id_contribuyente) REFERENCES gen.gen_contribuyente(id);


--
-- TOC entry 5114 (class 2606 OID 41857)
-- Name: arbitrio_detalle fk_arbitrio_detalle_arbitrio; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio_detalle
    ADD CONSTRAINT fk_arbitrio_detalle_arbitrio FOREIGN KEY (id_arbitrio) REFERENCES arb.arbitrio(id_arbitrio);


--
-- TOC entry 5115 (class 2606 OID 41862)
-- Name: arbitrio_detalle fk_arbitrio_detalle_tipo_beneficio_l; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio_detalle
    ADD CONSTRAINT fk_arbitrio_detalle_tipo_beneficio_l FOREIGN KEY (id_tipo_beneficio_limpieza_publica) REFERENCES arb.tipo_beneficio(id_tipo_beneficio);


--
-- TOC entry 5116 (class 2606 OID 41867)
-- Name: arbitrio_detalle fk_arbitrio_detalle_tipo_beneficio_p; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio_detalle
    ADD CONSTRAINT fk_arbitrio_detalle_tipo_beneficio_p FOREIGN KEY (id_tipo_beneficio_parques_jardines) REFERENCES arb.tipo_beneficio(id_tipo_beneficio);


--
-- TOC entry 5117 (class 2606 OID 41872)
-- Name: arbitrio_detalle fk_arbitrio_detalle_tipo_beneficio_r; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio_detalle
    ADD CONSTRAINT fk_arbitrio_detalle_tipo_beneficio_r FOREIGN KEY (id_tipo_beneficio_relleno_sanitario) REFERENCES arb.tipo_beneficio(id_tipo_beneficio);


--
-- TOC entry 5118 (class 2606 OID 41877)
-- Name: arbitrio_detalle fk_arbitrio_detalle_tipo_beneficio_s; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio_detalle
    ADD CONSTRAINT fk_arbitrio_detalle_tipo_beneficio_s FOREIGN KEY (id_tipo_beneficio_serenazgo) REFERENCES arb.tipo_beneficio(id_tipo_beneficio);


--
-- TOC entry 5112 (class 2606 OID 41839)
-- Name: arbitrio fk_arbitrio_predio; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio
    ADD CONSTRAINT fk_arbitrio_predio FOREIGN KEY (id_predio) REFERENCES gen.gen_predio(id);


--
-- TOC entry 5113 (class 2606 OID 41844)
-- Name: arbitrio fk_arbitrio_tipo_registro_origen; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.arbitrio
    ADD CONSTRAINT fk_arbitrio_tipo_registro_origen FOREIGN KEY (id_tipo_registro_origen) REFERENCES arb.tipo_registro_origen(id_tipo_registro_origen);


--
-- TOC entry 5110 (class 2606 OID 41810)
-- Name: categoria fk_categoria_grupo_categoria; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.categoria
    ADD CONSTRAINT fk_categoria_grupo_categoria FOREIGN KEY (id_grupo_categoria) REFERENCES arb.grupo_categoria(id_grupo_categoria);


--
-- TOC entry 5129 (class 2606 OID 42003)
-- Name: categoria_tributo fk_categoria_tributo_categoria; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.categoria_tributo
    ADD CONSTRAINT fk_categoria_tributo_categoria FOREIGN KEY (id_categoria) REFERENCES arb.categoria(id_categoria);


--
-- TOC entry 5130 (class 2606 OID 42008)
-- Name: categoria_tributo fk_categoria_tributo_tributo; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.categoria_tributo
    ADD CONSTRAINT fk_categoria_tributo_tributo FOREIGN KEY (id_tributo) REFERENCES arb.tributo(id_tributo);


--
-- TOC entry 5119 (class 2606 OID 41905)
-- Name: licencia_funcionamiento fk_licencia_funcionamiento_categoria; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.licencia_funcionamiento
    ADD CONSTRAINT fk_licencia_funcionamiento_categoria FOREIGN KEY (id_categoria) REFERENCES arb.categoria(id_categoria);


--
-- TOC entry 5120 (class 2606 OID 41895)
-- Name: licencia_funcionamiento fk_licencia_funcionamiento_contribuyente; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.licencia_funcionamiento
    ADD CONSTRAINT fk_licencia_funcionamiento_contribuyente FOREIGN KEY (id_contribuyente) REFERENCES gen.gen_contribuyente(id);


--
-- TOC entry 5121 (class 2606 OID 41900)
-- Name: licencia_funcionamiento fk_licencia_funcionamiento_predio; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.licencia_funcionamiento
    ADD CONSTRAINT fk_licencia_funcionamiento_predio FOREIGN KEY (id_predio) REFERENCES gen.gen_predio(id);


--
-- TOC entry 5125 (class 2606 OID 41969)
-- Name: tarifa_area_construida fk_tarifa_area_construida_categoria; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_area_construida
    ADD CONSTRAINT fk_tarifa_area_construida_categoria FOREIGN KEY (id_categoria) REFERENCES arb.categoria(id_categoria);


--
-- TOC entry 5126 (class 2606 OID 41964)
-- Name: tarifa_area_construida fk_tarifa_area_construida_tributo; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_area_construida
    ADD CONSTRAINT fk_tarifa_area_construida_tributo FOREIGN KEY (id_tributo) REFERENCES arb.tributo(id_tributo);


--
-- TOC entry 5127 (class 2606 OID 41985)
-- Name: tarifa_area_terreno fk_tarifa_area_terreno_categoria; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_area_terreno
    ADD CONSTRAINT fk_tarifa_area_terreno_categoria FOREIGN KEY (id_categoria) REFERENCES arb.categoria(id_categoria);


--
-- TOC entry 5128 (class 2606 OID 41990)
-- Name: tarifa_area_terreno fk_tarifa_area_terreno_tributo; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_area_terreno
    ADD CONSTRAINT fk_tarifa_area_terreno_tributo FOREIGN KEY (id_tributo) REFERENCES arb.tributo(id_tributo);


--
-- TOC entry 5122 (class 2606 OID 41948)
-- Name: tarifa_categoria fk_tarifa_categoria_categoria; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_categoria
    ADD CONSTRAINT fk_tarifa_categoria_categoria FOREIGN KEY (id_categoria) REFERENCES arb.categoria(id_categoria);


--
-- TOC entry 5123 (class 2606 OID 41943)
-- Name: tarifa_categoria fk_tarifa_categoria_determina_calculo; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_categoria
    ADD CONSTRAINT fk_tarifa_categoria_determina_calculo FOREIGN KEY (id_determina_calculo) REFERENCES arb.determina_calculo(id_determina_calculo);


--
-- TOC entry 5124 (class 2606 OID 41938)
-- Name: tarifa_categoria fk_tarifa_categoria_tributo; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tarifa_categoria
    ADD CONSTRAINT fk_tarifa_categoria_tributo FOREIGN KEY (id_tributo) REFERENCES arb.tributo(id_tributo);


--
-- TOC entry 5109 (class 2606 OID 41789)
-- Name: tipo_beneficio fk_tipo_beneficio_tributo; Type: FK CONSTRAINT; Schema: arb; Owner: admin
--

ALTER TABLE ONLY arb.tipo_beneficio
    ADD CONSTRAINT fk_tipo_beneficio_tributo FOREIGN KEY (id_tributo) REFERENCES arb.tributo(id_tributo);


--
-- TOC entry 4989 (class 2606 OID 36744)
-- Name: apertura_cobranza apertura_cobranza_id_cajero_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.apertura_cobranza
    ADD CONSTRAINT apertura_cobranza_id_cajero_fkey FOREIGN KEY (id_cajero) REFERENCES caj.cajero(id);


--
-- TOC entry 4990 (class 2606 OID 36749)
-- Name: cierre_caja cierre_caja_id_cajero_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.cierre_caja
    ADD CONSTRAINT cierre_caja_id_cajero_fkey FOREIGN KEY (id_cajero) REFERENCES caj.cajero(id);


--
-- TOC entry 4991 (class 2606 OID 36754)
-- Name: extorno extorno_id_cajero_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.extorno
    ADD CONSTRAINT extorno_id_cajero_fkey FOREIGN KEY (id_cajero) REFERENCES caj.cajero(id);


--
-- TOC entry 4992 (class 2606 OID 36759)
-- Name: extorno extorno_id_pago_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.extorno
    ADD CONSTRAINT extorno_id_pago_fkey FOREIGN KEY (id_pago) REFERENCES caj.pago(id);


--
-- TOC entry 4993 (class 2606 OID 36764)
-- Name: extorno extorno_id_recibo_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.extorno
    ADD CONSTRAINT extorno_id_recibo_fkey FOREIGN KEY (id_recibo) REFERENCES caj.recibo(id);


--
-- TOC entry 4997 (class 2606 OID 36769)
-- Name: pago_detalle pago_detalle_id_concepto_pago_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.pago_detalle
    ADD CONSTRAINT pago_detalle_id_concepto_pago_fkey FOREIGN KEY (id_concepto_pago) REFERENCES caj.concepto_pago(id);


--
-- TOC entry 4998 (class 2606 OID 36774)
-- Name: pago_detalle pago_detalle_id_pago_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.pago_detalle
    ADD CONSTRAINT pago_detalle_id_pago_fkey FOREIGN KEY (id_pago) REFERENCES caj.pago(id);


--
-- TOC entry 4994 (class 2606 OID 36779)
-- Name: pago pago_id_cajero_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.pago
    ADD CONSTRAINT pago_id_cajero_fkey FOREIGN KEY (id_cajero) REFERENCES caj.cajero(id);


--
-- TOC entry 4995 (class 2606 OID 36784)
-- Name: pago pago_id_tipo_pago_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.pago
    ADD CONSTRAINT pago_id_tipo_pago_fkey FOREIGN KEY (id_tipo_pago) REFERENCES caj.tipo_pago(id);


--
-- TOC entry 4996 (class 2606 OID 36789)
-- Name: pago pago_id_usuario_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.pago
    ADD CONSTRAINT pago_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES caj.usuario(id);


--
-- TOC entry 4999 (class 2606 OID 36794)
-- Name: recibo recibo_id_cajero_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.recibo
    ADD CONSTRAINT recibo_id_cajero_fkey FOREIGN KEY (id_cajero) REFERENCES caj.cajero(id);


--
-- TOC entry 5000 (class 2606 OID 36799)
-- Name: recibo recibo_id_pago_fkey; Type: FK CONSTRAINT; Schema: caj; Owner: postgres
--

ALTER TABLE ONLY caj.recibo
    ADD CONSTRAINT recibo_id_pago_fkey FOREIGN KEY (id_pago) REFERENCES caj.pago(id);


--
-- TOC entry 5105 (class 2606 OID 41517)
-- Name: fis_acta_inspección fk_acta_fiscalizacion; Type: FK CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis."fis_acta_inspección"
    ADD CONSTRAINT fk_acta_fiscalizacion FOREIGN KEY (id_fiscalizacion) REFERENCES fis.fis_fiscalizacion(id_fiscalizacion);


--
-- TOC entry 5101 (class 2606 OID 41419)
-- Name: fis_fiscalizacion fk_fiscalizacion_contribuyente; Type: FK CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_fiscalizacion
    ADD CONSTRAINT fk_fiscalizacion_contribuyente FOREIGN KEY (id_contribuyente) REFERENCES gen.gen_contribuyente(id);


--
-- TOC entry 5102 (class 2606 OID 41424)
-- Name: fis_fiscalizacion fk_fiscalizacion_funcionario; Type: FK CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_fiscalizacion
    ADD CONSTRAINT fk_fiscalizacion_funcionario FOREIGN KEY (id_funcionario) REFERENCES gen.gen_funcionario(id);


--
-- TOC entry 5103 (class 2606 OID 41414)
-- Name: fis_fiscalizacion fk_fiscalizacion_predio; Type: FK CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_fiscalizacion
    ADD CONSTRAINT fk_fiscalizacion_predio FOREIGN KEY (id_predio) REFERENCES gen.gen_predio(id);


--
-- TOC entry 5106 (class 2606 OID 41531)
-- Name: fis_liquidacion fk_liquidacion_fiscalizacion; Type: FK CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_liquidacion
    ADD CONSTRAINT fk_liquidacion_fiscalizacion FOREIGN KEY (id_fiscalizacion) REFERENCES fis.fis_fiscalizacion(id_fiscalizacion);


--
-- TOC entry 5108 (class 2606 OID 41559)
-- Name: fis_multa fk_multa_resolucion; Type: FK CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_multa
    ADD CONSTRAINT fk_multa_resolucion FOREIGN KEY (id_resolucion) REFERENCES fis.fis_resolucion(id_resolucion);


--
-- TOC entry 5104 (class 2606 OID 41503)
-- Name: fis_requerimiento fk_requerimiento_fiscalizacion; Type: FK CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_requerimiento
    ADD CONSTRAINT fk_requerimiento_fiscalizacion FOREIGN KEY (id_fiscalizacion) REFERENCES fis.fis_fiscalizacion(id_fiscalizacion);


--
-- TOC entry 5107 (class 2606 OID 41545)
-- Name: fis_resolucion fk_resolucion_fiscalizacion; Type: FK CONSTRAINT; Schema: fis; Owner: admin
--

ALTER TABLE ONLY fis.fis_resolucion
    ADD CONSTRAINT fk_resolucion_fiscalizacion FOREIGN KEY (id_fiscalizacion) REFERENCES fis.fis_fiscalizacion(id_fiscalizacion);


--
-- TOC entry 5057 (class 2606 OID 40415)
-- Name: gen_distrito fk_distrito_departamento; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_distrito
    ADD CONSTRAINT fk_distrito_departamento FOREIGN KEY (id_departamento) REFERENCES gen.gen_departamento(id);


--
-- TOC entry 5058 (class 2606 OID 40420)
-- Name: gen_distrito fk_distrito_provincia; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_distrito
    ADD CONSTRAINT fk_distrito_provincia FOREIGN KEY (id_provincia) REFERENCES gen.gen_provincia(id);


--
-- TOC entry 5060 (class 2606 OID 40489)
-- Name: gen_habilitacion_urbana fk_habilitacion_urbana_distrito; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_habilitacion_urbana
    ADD CONSTRAINT fk_habilitacion_urbana_distrito FOREIGN KEY (id_distrito) REFERENCES gen.gen_distrito(id);


--
-- TOC entry 5061 (class 2606 OID 40494)
-- Name: gen_habilitacion_urbana fk_habilitacion_urbana_tipo; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_habilitacion_urbana
    ADD CONSTRAINT fk_habilitacion_urbana_tipo FOREIGN KEY (id_tipo_habilitacion_urbana) REFERENCES gen.gen_tipo_habilitacion_urbana(id);


--
-- TOC entry 5065 (class 2606 OID 40567)
-- Name: gen_predio fk_predio_departamento; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_predio
    ADD CONSTRAINT fk_predio_departamento FOREIGN KEY (id_departamento) REFERENCES gen.gen_departamento(id);


--
-- TOC entry 5066 (class 2606 OID 40577)
-- Name: gen_predio fk_predio_distrito; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_predio
    ADD CONSTRAINT fk_predio_distrito FOREIGN KEY (id_distrito) REFERENCES gen.gen_distrito(id);


--
-- TOC entry 5067 (class 2606 OID 40587)
-- Name: gen_predio fk_predio_habilitacion_urbana; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_predio
    ADD CONSTRAINT fk_predio_habilitacion_urbana FOREIGN KEY (id_habilitacion_urbana) REFERENCES gen.gen_habilitacion_urbana(id);


--
-- TOC entry 5068 (class 2606 OID 40572)
-- Name: gen_predio fk_predio_provincia; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_predio
    ADD CONSTRAINT fk_predio_provincia FOREIGN KEY (id_provincia) REFERENCES gen.gen_provincia(id);


--
-- TOC entry 5069 (class 2606 OID 40582)
-- Name: gen_predio fk_predio_sector; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_predio
    ADD CONSTRAINT fk_predio_sector FOREIGN KEY (id_sector) REFERENCES gen.gen_sector(id);


--
-- TOC entry 5070 (class 2606 OID 40597)
-- Name: gen_predio fk_predio_tipo_interior; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_predio
    ADD CONSTRAINT fk_predio_tipo_interior FOREIGN KEY (id_tipo_interior) REFERENCES gen.gen_tipo_interior(id);


--
-- TOC entry 5071 (class 2606 OID 40592)
-- Name: gen_predio fk_predio_via; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_predio
    ADD CONSTRAINT fk_predio_via FOREIGN KEY (id_via) REFERENCES gen.gen_via(id);


--
-- TOC entry 5056 (class 2606 OID 40400)
-- Name: gen_provincia fk_provincia_departamento; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_provincia
    ADD CONSTRAINT fk_provincia_departamento FOREIGN KEY (id_departamento) REFERENCES gen.gen_departamento(id);


--
-- TOC entry 5059 (class 2606 OID 40436)
-- Name: gen_sector fk_sector_distrito; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_sector
    ADD CONSTRAINT fk_sector_distrito FOREIGN KEY (id_distrito) REFERENCES gen.gen_distrito(id);


--
-- TOC entry 5062 (class 2606 OID 40510)
-- Name: gen_via fk_via_habilitacion_urbana; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_via
    ADD CONSTRAINT fk_via_habilitacion_urbana FOREIGN KEY (id_habilitacion_urbana) REFERENCES gen.gen_habilitacion_urbana(id);


--
-- TOC entry 5063 (class 2606 OID 40515)
-- Name: gen_via fk_via_sector; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_via
    ADD CONSTRAINT fk_via_sector FOREIGN KEY (id_sector) REFERENCES gen.gen_sector(id);


--
-- TOC entry 5064 (class 2606 OID 40520)
-- Name: gen_via fk_via_tipo_via; Type: FK CONSTRAINT; Schema: gen; Owner: admin
--

ALTER TABLE ONLY gen.gen_via
    ADD CONSTRAINT fk_via_tipo_via FOREIGN KEY (id_tipo_via) REFERENCES gen.gen_tipo_via(id);


--
-- TOC entry 4988 (class 2606 OID 36482)
-- Name: examen_clinico_boca fk_examen_boca_historia; Type: FK CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_clinico_boca
    ADD CONSTRAINT fk_examen_boca_historia FOREIGN KEY (id_historia) REFERENCES hcl.historia_clinica(id_historia);


--
-- TOC entry 4986 (class 2606 OID 36452)
-- Name: examen_general fk_examen_general_historia; Type: FK CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_general
    ADD CONSTRAINT fk_examen_general_historia FOREIGN KEY (id_historia) REFERENCES hcl.historia_clinica(id_historia);


--
-- TOC entry 4987 (class 2606 OID 36467)
-- Name: examen_regional fk_examen_regional_historia; Type: FK CONSTRAINT; Schema: hcl; Owner: admin
--

ALTER TABLE ONLY hcl.examen_regional
    ADD CONSTRAINT fk_examen_regional_historia FOREIGN KEY (id_historia) REFERENCES hcl.historia_clinica(id_historia);


--
-- TOC entry 5009 (class 2606 OID 38892)
-- Name: imp_domicilio_fiscal_contribuyente fk_domfisc_aso_valida; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_domicilio_fiscal_contribuyente
    ADD CONSTRAINT fk_domfisc_aso_valida FOREIGN KEY (id_asociacion, id_distrito) REFERENCES imp.imp_asociacion(id_asociacion, id_distrito);


--
-- TOC entry 5010 (class 2606 OID 38887)
-- Name: imp_domicilio_fiscal_contribuyente fk_domfisc_hab_valida; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_domicilio_fiscal_contribuyente
    ADD CONSTRAINT fk_domfisc_hab_valida FOREIGN KEY (id_habilitacion, id_distrito) REFERENCES imp.imp_habilitacion_urbana(id_habilitacion, id_distrito);


--
-- TOC entry 5011 (class 2606 OID 38882)
-- Name: imp_domicilio_fiscal_contribuyente fk_domfisc_sector_valido; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_domicilio_fiscal_contribuyente
    ADD CONSTRAINT fk_domfisc_sector_valido FOREIGN KEY (id_sector, id_distrito) REFERENCES imp.imp_sector(id_sector, id_distrito);


--
-- TOC entry 5012 (class 2606 OID 38877)
-- Name: imp_domicilio_fiscal_contribuyente fk_domfisc_via_valida; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_domicilio_fiscal_contribuyente
    ADD CONSTRAINT fk_domfisc_via_valida FOREIGN KEY (id_via, id_distrito) REFERENCES imp.imp_via(id_via, id_distrito);


--
-- TOC entry 5019 (class 2606 OID 39140)
-- Name: imp_predio fk_predio_asociacion_valida; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio
    ADD CONSTRAINT fk_predio_asociacion_valida FOREIGN KEY (id_asociacion, id_distrito) REFERENCES imp.imp_asociacion(id_asociacion, id_distrito);


--
-- TOC entry 5020 (class 2606 OID 39135)
-- Name: imp_predio fk_predio_habilitacion_valida; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio
    ADD CONSTRAINT fk_predio_habilitacion_valida FOREIGN KEY (id_habilitacion, id_distrito) REFERENCES imp.imp_habilitacion_urbana(id_habilitacion, id_distrito);


--
-- TOC entry 5021 (class 2606 OID 39130)
-- Name: imp_predio fk_predio_sector_valido; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio
    ADD CONSTRAINT fk_predio_sector_valido FOREIGN KEY (id_sector, id_distrito) REFERENCES imp.imp_sector(id_sector, id_distrito);


--
-- TOC entry 5022 (class 2606 OID 39125)
-- Name: imp_predio fk_predio_via_valida; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio
    ADD CONSTRAINT fk_predio_via_valida FOREIGN KEY (id_via, id_distrito) REFERENCES imp.imp_via(id_via, id_distrito);


--
-- TOC entry 5049 (class 2606 OID 39328)
-- Name: imp_area_rustica imp_area_rustica_id_categoria_terreno_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_area_rustica
    ADD CONSTRAINT imp_area_rustica_id_categoria_terreno_fkey FOREIGN KEY (id_categoria_terreno) REFERENCES imp.imp_categoria_terreno(id_categoria_terreno);


--
-- TOC entry 5050 (class 2606 OID 39323)
-- Name: imp_area_rustica imp_area_rustica_id_grupo_tierra_detalle_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_area_rustica
    ADD CONSTRAINT imp_area_rustica_id_grupo_tierra_detalle_fkey FOREIGN KEY (id_grupo_tierra_detalle) REFERENCES imp.imp_grupo_tierra_detalle(id_grupo_tierra_detalle);


--
-- TOC entry 5006 (class 2606 OID 38805)
-- Name: imp_asociacion imp_asociacion_id_distrito_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_asociacion
    ADD CONSTRAINT imp_asociacion_id_distrito_fkey FOREIGN KEY (id_distrito) REFERENCES imp.imp_distrito(id_distrito);


--
-- TOC entry 5053 (class 2606 OID 39372)
-- Name: imp_cuenta_corriente imp_cuenta_corriente_codigo_contribuyente_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_cuenta_corriente
    ADD CONSTRAINT imp_cuenta_corriente_codigo_contribuyente_fkey FOREIGN KEY (codigo_contribuyente) REFERENCES imp.imp_contribuyente(codigo);


--
-- TOC entry 5054 (class 2606 OID 39377)
-- Name: imp_cuenta_corriente imp_cuenta_corriente_id_origen_dj_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_cuenta_corriente
    ADD CONSTRAINT imp_cuenta_corriente_id_origen_dj_fkey FOREIGN KEY (id_origen_dj) REFERENCES imp.imp_declaracion_jurada(id_declaracion_jurada);


--
-- TOC entry 5055 (class 2606 OID 39382)
-- Name: imp_cuenta_corriente imp_cuenta_corriente_id_origen_pago_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_cuenta_corriente
    ADD CONSTRAINT imp_cuenta_corriente_id_origen_pago_fkey FOREIGN KEY (id_origen_pago) REFERENCES imp.imp_pago(id_pago);


--
-- TOC entry 5026 (class 2606 OID 39154)
-- Name: imp_declaracion_jurada imp_declaracion_jurada_codigo_contribuyente_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_declaracion_jurada
    ADD CONSTRAINT imp_declaracion_jurada_codigo_contribuyente_fkey FOREIGN KEY (codigo_contribuyente) REFERENCES imp.imp_contribuyente(codigo);


--
-- TOC entry 5027 (class 2606 OID 39159)
-- Name: imp_declaracion_jurada imp_declaracion_jurada_id_motivo_dj_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_declaracion_jurada
    ADD CONSTRAINT imp_declaracion_jurada_id_motivo_dj_fkey FOREIGN KEY (id_motivo_dj) REFERENCES imp.imp_motivo_dj(id_motivo_dj);


--
-- TOC entry 5002 (class 2606 OID 38751)
-- Name: imp_distrito imp_distrito_id_provincia_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_distrito
    ADD CONSTRAINT imp_distrito_id_provincia_fkey FOREIGN KEY (id_provincia) REFERENCES imp.imp_provincia(id_provincia);


--
-- TOC entry 5028 (class 2606 OID 39194)
-- Name: imp_dj_predio imp_dj_predio_id_arancel_urbano_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_dj_predio
    ADD CONSTRAINT imp_dj_predio_id_arancel_urbano_fkey FOREIGN KEY (id_arancel_urbano) REFERENCES imp.imp_arancel_urbano(id_arancel_urbano);


--
-- TOC entry 5029 (class 2606 OID 39174)
-- Name: imp_dj_predio imp_dj_predio_id_declaracion_jurada_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_dj_predio
    ADD CONSTRAINT imp_dj_predio_id_declaracion_jurada_fkey FOREIGN KEY (id_declaracion_jurada) REFERENCES imp.imp_declaracion_jurada(id_declaracion_jurada);


--
-- TOC entry 5030 (class 2606 OID 39179)
-- Name: imp_dj_predio imp_dj_predio_id_predio_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_dj_predio
    ADD CONSTRAINT imp_dj_predio_id_predio_fkey FOREIGN KEY (id_predio) REFERENCES imp.imp_predio(id_predio);


--
-- TOC entry 5031 (class 2606 OID 39184)
-- Name: imp_dj_predio imp_dj_predio_id_tipo_registro_predio_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_dj_predio
    ADD CONSTRAINT imp_dj_predio_id_tipo_registro_predio_fkey FOREIGN KEY (id_tipo_registro_predio) REFERENCES imp.imp_tipo_registro_predio(id_tipo_registro_predio);


--
-- TOC entry 5032 (class 2606 OID 39189)
-- Name: imp_dj_predio imp_dj_predio_id_uso_predio_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_dj_predio
    ADD CONSTRAINT imp_dj_predio_id_uso_predio_fkey FOREIGN KEY (id_uso_predio) REFERENCES imp.imp_uso_predio(id_uso);


--
-- TOC entry 5033 (class 2606 OID 39199)
-- Name: imp_dj_predio imp_dj_predio_id_valor_exoneracion_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_dj_predio
    ADD CONSTRAINT imp_dj_predio_id_valor_exoneracion_fkey FOREIGN KEY (id_valor_exoneracion) REFERENCES imp.imp_valor_exoneracion(id_valor_exoneracion);


--
-- TOC entry 5013 (class 2606 OID 38862)
-- Name: imp_domicilio_fiscal_contribuyente imp_domicilio_fiscal_contribuyente_codigo_contribuyente_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_domicilio_fiscal_contribuyente
    ADD CONSTRAINT imp_domicilio_fiscal_contribuyente_codigo_contribuyente_fkey FOREIGN KEY (codigo_contribuyente) REFERENCES imp.imp_contribuyente(codigo);


--
-- TOC entry 5014 (class 2606 OID 38867)
-- Name: imp_domicilio_fiscal_contribuyente imp_domicilio_fiscal_contribuyente_id_distrito_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_domicilio_fiscal_contribuyente
    ADD CONSTRAINT imp_domicilio_fiscal_contribuyente_id_distrito_fkey FOREIGN KEY (id_distrito) REFERENCES imp.imp_distrito(id_distrito);


--
-- TOC entry 5015 (class 2606 OID 38872)
-- Name: imp_domicilio_fiscal_contribuyente imp_domicilio_fiscal_contribuyente_id_tipo_interior_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_domicilio_fiscal_contribuyente
    ADD CONSTRAINT imp_domicilio_fiscal_contribuyente_id_tipo_interior_fkey FOREIGN KEY (id_tipo_interior) REFERENCES imp.imp_tipo_interior(id_tipo_interior);


--
-- TOC entry 5048 (class 2606 OID 39311)
-- Name: imp_grupo_tierra_detalle imp_grupo_tierra_detalle_id_grupo_tierra_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_grupo_tierra_detalle
    ADD CONSTRAINT imp_grupo_tierra_detalle_id_grupo_tierra_fkey FOREIGN KEY (id_grupo_tierra) REFERENCES imp.imp_grupo_tierra(id_grupo_tierra);


--
-- TOC entry 5004 (class 2606 OID 38791)
-- Name: imp_habilitacion_urbana imp_habilitacion_urbana_id_distrito_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_habilitacion_urbana
    ADD CONSTRAINT imp_habilitacion_urbana_id_distrito_fkey FOREIGN KEY (id_distrito) REFERENCES imp.imp_distrito(id_distrito);


--
-- TOC entry 5005 (class 2606 OID 38786)
-- Name: imp_habilitacion_urbana imp_habilitacion_urbana_id_tipo_habilitacion_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_habilitacion_urbana
    ADD CONSTRAINT imp_habilitacion_urbana_id_tipo_habilitacion_fkey FOREIGN KEY (id_tipo_habilitacion) REFERENCES imp.imp_tipo_habilitacion_urbana(id_tipo_habilitacion);


--
-- TOC entry 5051 (class 2606 OID 39343)
-- Name: imp_pago imp_pago_declaracion_predio_id_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_pago
    ADD CONSTRAINT imp_pago_declaracion_predio_id_fkey FOREIGN KEY (declaracion_predio_id) REFERENCES imp.imp_dj_predio(id_dj_predio);


--
-- TOC entry 5052 (class 2606 OID 39348)
-- Name: imp_pago imp_pago_id_vencimiento_emision_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_pago
    ADD CONSTRAINT imp_pago_id_vencimiento_emision_fkey FOREIGN KEY (id_vencimiento_emision) REFERENCES imp.imp_vencimiento_emision(id_vencimiento_emision);


--
-- TOC entry 5034 (class 2606 OID 39213)
-- Name: imp_predio_colindante imp_predio_colindante_id_dj_predio_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_colindante
    ADD CONSTRAINT imp_predio_colindante_id_dj_predio_fkey FOREIGN KEY (id_dj_predio) REFERENCES imp.imp_dj_predio(id_dj_predio);


--
-- TOC entry 5035 (class 2606 OID 39245)
-- Name: imp_predio_construccion imp_predio_construccion_id_categoria_edificacion_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_construccion
    ADD CONSTRAINT imp_predio_construccion_id_categoria_edificacion_fkey FOREIGN KEY (id_categoria_edificacion) REFERENCES imp.imp_categoria_edificacion(id_categoria);


--
-- TOC entry 5036 (class 2606 OID 39240)
-- Name: imp_predio_construccion imp_predio_construccion_id_depreciacion_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_construccion
    ADD CONSTRAINT imp_predio_construccion_id_depreciacion_fkey FOREIGN KEY (id_depreciacion) REFERENCES imp.imp_depreciacion(id_depreciacion);


--
-- TOC entry 5037 (class 2606 OID 39225)
-- Name: imp_predio_construccion imp_predio_construccion_id_dj_predio_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_construccion
    ADD CONSTRAINT imp_predio_construccion_id_dj_predio_fkey FOREIGN KEY (id_dj_predio) REFERENCES imp.imp_dj_predio(id_dj_predio);


--
-- TOC entry 5038 (class 2606 OID 39235)
-- Name: imp_predio_construccion imp_predio_construccion_id_material_estructural_predio_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_construccion
    ADD CONSTRAINT imp_predio_construccion_id_material_estructural_predio_fkey FOREIGN KEY (id_material_estructural_predio) REFERENCES imp.imp_material_estructural_predio(id_material_estructural_predio);


--
-- TOC entry 5039 (class 2606 OID 39230)
-- Name: imp_predio_construccion imp_predio_construccion_id_nivel_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_construccion
    ADD CONSTRAINT imp_predio_construccion_id_nivel_fkey FOREIGN KEY (id_nivel) REFERENCES imp.imp_nivel(id_nivel);


--
-- TOC entry 5023 (class 2606 OID 39110)
-- Name: imp_predio imp_predio_id_distrito_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio
    ADD CONSTRAINT imp_predio_id_distrito_fkey FOREIGN KEY (id_distrito) REFERENCES imp.imp_distrito(id_distrito);


--
-- TOC entry 5024 (class 2606 OID 39120)
-- Name: imp_predio imp_predio_id_junta_vecinal_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio
    ADD CONSTRAINT imp_predio_id_junta_vecinal_fkey FOREIGN KEY (id_junta_vecinal) REFERENCES imp.imp_junta_vecinal(id_junta_vecinal);


--
-- TOC entry 5025 (class 2606 OID 39115)
-- Name: imp_predio imp_predio_id_tipo_interior_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio
    ADD CONSTRAINT imp_predio_id_tipo_interior_fkey FOREIGN KEY (id_tipo_interior) REFERENCES imp.imp_tipo_interior(id_tipo_interior);


--
-- TOC entry 5043 (class 2606 OID 39299)
-- Name: imp_predio_otra_instalacion imp_predio_otra_instalacion_id_depreciacion_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_otra_instalacion
    ADD CONSTRAINT imp_predio_otra_instalacion_id_depreciacion_fkey FOREIGN KEY (id_depreciacion) REFERENCES imp.imp_depreciacion(id_depreciacion);


--
-- TOC entry 5044 (class 2606 OID 39279)
-- Name: imp_predio_otra_instalacion imp_predio_otra_instalacion_id_dj_predio_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_otra_instalacion
    ADD CONSTRAINT imp_predio_otra_instalacion_id_dj_predio_fkey FOREIGN KEY (id_dj_predio) REFERENCES imp.imp_dj_predio(id_dj_predio);


--
-- TOC entry 5045 (class 2606 OID 39289)
-- Name: imp_predio_otra_instalacion imp_predio_otra_instalacion_id_material_estructural_predio_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_otra_instalacion
    ADD CONSTRAINT imp_predio_otra_instalacion_id_material_estructural_predio_fkey FOREIGN KEY (id_material_estructural_predio) REFERENCES imp.imp_material_estructural_predio(id_material_estructural_predio);


--
-- TOC entry 5046 (class 2606 OID 39284)
-- Name: imp_predio_otra_instalacion imp_predio_otra_instalacion_id_nivel_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_otra_instalacion
    ADD CONSTRAINT imp_predio_otra_instalacion_id_nivel_fkey FOREIGN KEY (id_nivel) REFERENCES imp.imp_nivel(id_nivel);


--
-- TOC entry 5047 (class 2606 OID 39294)
-- Name: imp_predio_otra_instalacion imp_predio_otra_instalacion_id_obra_complementaria_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_otra_instalacion
    ADD CONSTRAINT imp_predio_otra_instalacion_id_obra_complementaria_fkey FOREIGN KEY (id_obra_complementaria) REFERENCES imp.imp_obra_complementaria(id_obra);


--
-- TOC entry 5040 (class 2606 OID 39267)
-- Name: imp_predio_terreno imp_predio_terreno_id_categoria_terreno_ext_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_terreno
    ADD CONSTRAINT imp_predio_terreno_id_categoria_terreno_ext_fkey FOREIGN KEY (id_categoria_terreno_ext) REFERENCES imp.imp_categoria_terreno_ext(id_categoria_terreno_ext);


--
-- TOC entry 5041 (class 2606 OID 39262)
-- Name: imp_predio_terreno imp_predio_terreno_id_clasificacion_terreno_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_terreno
    ADD CONSTRAINT imp_predio_terreno_id_clasificacion_terreno_fkey FOREIGN KEY (id_clasificacion_terreno) REFERENCES imp.imp_clasificacion_terreno(id_clasificacion_terreno);


--
-- TOC entry 5042 (class 2606 OID 39257)
-- Name: imp_predio_terreno imp_predio_terreno_id_dj_predio_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_predio_terreno
    ADD CONSTRAINT imp_predio_terreno_id_dj_predio_fkey FOREIGN KEY (id_dj_predio) REFERENCES imp.imp_dj_predio(id_dj_predio);


--
-- TOC entry 5001 (class 2606 OID 38739)
-- Name: imp_provincia imp_provincia_id_departamento_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_provincia
    ADD CONSTRAINT imp_provincia_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES imp.imp_departamento(id_departamento);


--
-- TOC entry 5003 (class 2606 OID 38765)
-- Name: imp_sector imp_sector_id_distrito_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_sector
    ADD CONSTRAINT imp_sector_id_distrito_fkey FOREIGN KEY (id_distrito) REFERENCES imp.imp_distrito(id_distrito);


--
-- TOC entry 5018 (class 2606 OID 39077)
-- Name: imp_valor_exoneracion imp_valor_exoneracion_id_exoneracion_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_exoneracion
    ADD CONSTRAINT imp_valor_exoneracion_id_exoneracion_fkey FOREIGN KEY (id_exoneracion) REFERENCES imp.imp_exoneracion(id_exoneracion);


--
-- TOC entry 5016 (class 2606 OID 39024)
-- Name: imp_valor_unitario_edificacion imp_valor_unitario_edificacion_id_categoria_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_unitario_edificacion
    ADD CONSTRAINT imp_valor_unitario_edificacion_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES imp.imp_categoria_edificacion(id_categoria);


--
-- TOC entry 5017 (class 2606 OID 39044)
-- Name: imp_valor_unitario_obra imp_valor_unitario_obra_id_obra_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_valor_unitario_obra
    ADD CONSTRAINT imp_valor_unitario_obra_id_obra_fkey FOREIGN KEY (id_obra) REFERENCES imp.imp_obra_complementaria(id_obra);


--
-- TOC entry 5007 (class 2606 OID 38831)
-- Name: imp_via imp_via_id_distrito_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_via
    ADD CONSTRAINT imp_via_id_distrito_fkey FOREIGN KEY (id_distrito) REFERENCES imp.imp_distrito(id_distrito);


--
-- TOC entry 5008 (class 2606 OID 38826)
-- Name: imp_via imp_via_id_tipo_via_fkey; Type: FK CONSTRAINT; Schema: imp; Owner: admin
--

ALTER TABLE ONLY imp.imp_via
    ADD CONSTRAINT imp_via_id_tipo_via_fkey FOREIGN KEY (id_tipo_via) REFERENCES imp.imp_tipo_via(id_tipo_via);


--
-- TOC entry 5073 (class 2606 OID 40824)
-- Name: lic_documento fk_documento_requisito; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_documento
    ADD CONSTRAINT fk_documento_requisito FOREIGN KEY (id_requisito) REFERENCES lic.lic_requisito(id);


--
-- TOC entry 5072 (class 2606 OID 40806)
-- Name: lic_giro_licencia fk_giro_licencia_giro_negocio; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_giro_licencia
    ADD CONSTRAINT fk_giro_licencia_giro_negocio FOREIGN KEY (id_giro_negocio) REFERENCES lic.lic_giro_negocio(id);


--
-- TOC entry 5074 (class 2606 OID 40878)
-- Name: lic_licencia fk_licencia_actividad_comercial; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT fk_licencia_actividad_comercial FOREIGN KEY (id_actividad_comercial) REFERENCES lic.lic_actividad_comercial(id);


--
-- TOC entry 5075 (class 2606 OID 40873)
-- Name: lic_licencia fk_licencia_condicion_local; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT fk_licencia_condicion_local FOREIGN KEY (id_condicion_local) REFERENCES lic.lic_condicion_local(id);


--
-- TOC entry 5076 (class 2606 OID 40853)
-- Name: lic_licencia fk_licencia_contribuyente; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT fk_licencia_contribuyente FOREIGN KEY (id_contribuyente) REFERENCES gen.gen_contribuyente(id);


--
-- TOC entry 5077 (class 2606 OID 40893)
-- Name: lic_licencia fk_licencia_documento; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT fk_licencia_documento FOREIGN KEY (id_documento) REFERENCES lic.lic_documento(id);


--
-- TOC entry 5078 (class 2606 OID 40888)
-- Name: lic_licencia fk_licencia_giro_licencia; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT fk_licencia_giro_licencia FOREIGN KEY (id_giro_licencia) REFERENCES lic.lic_giro_licencia(id);


--
-- TOC entry 5079 (class 2606 OID 40863)
-- Name: lic_licencia fk_licencia_motivo_registro; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT fk_licencia_motivo_registro FOREIGN KEY (id_motivo_registro) REFERENCES lic.lic_motivo_registro(id);


--
-- TOC entry 5080 (class 2606 OID 40858)
-- Name: lic_licencia fk_licencia_predio; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT fk_licencia_predio FOREIGN KEY (id_predio) REFERENCES gen.gen_predio(id);


--
-- TOC entry 5081 (class 2606 OID 40883)
-- Name: lic_licencia fk_licencia_tipo_establecimiento; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT fk_licencia_tipo_establecimiento FOREIGN KEY (id_tipo_establecimiento) REFERENCES lic.lic_tipo_establecimiento(id);


--
-- TOC entry 5082 (class 2606 OID 40868)
-- Name: lic_licencia fk_licencia_tipo_licencia; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_licencia
    ADD CONSTRAINT fk_licencia_tipo_licencia FOREIGN KEY (id_tipo_licencia) REFERENCES lic.lic_tipo_licencia(id);


--
-- TOC entry 5083 (class 2606 OID 40911)
-- Name: lic_sust_anulacion fk_sust_anulacion_licencia; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_sust_anulacion
    ADD CONSTRAINT fk_sust_anulacion_licencia FOREIGN KEY (id_licencia) REFERENCES lic.lic_licencia(id);


--
-- TOC entry 5084 (class 2606 OID 40916)
-- Name: lic_sust_anulacion fk_sust_anulacion_motivo_registro; Type: FK CONSTRAINT; Schema: lic; Owner: admin
--

ALTER TABLE ONLY lic.lic_sust_anulacion
    ADD CONSTRAINT fk_sust_anulacion_motivo_registro FOREIGN KEY (id_motivo_registro) REFERENCES lic.lic_motivo_registro(id);


--
-- TOC entry 5087 (class 2606 OID 41146)
-- Name: contrato fk_contrato_categoria_servicio; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato
    ADD CONSTRAINT fk_contrato_categoria_servicio FOREIGN KEY (id_categoria_servicio) REFERENCES saa.categoria_servicio(id_categoria_servicio);


--
-- TOC entry 5088 (class 2606 OID 41151)
-- Name: contrato fk_contrato_estado_servicio; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato
    ADD CONSTRAINT fk_contrato_estado_servicio FOREIGN KEY (id_estado_servicio) REFERENCES saa.estado_servicio(id_estado_servicio);


--
-- TOC entry 5089 (class 2606 OID 41166)
-- Name: contrato fk_contrato_gen_predio; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato
    ADD CONSTRAINT fk_contrato_gen_predio FOREIGN KEY (id_predio) REFERENCES gen.gen_predio(id);


--
-- TOC entry 5093 (class 2606 OID 41183)
-- Name: contrato_instalacion_pago fk_contrato_instalacion_pago_contrato; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato_instalacion_pago
    ADD CONSTRAINT fk_contrato_instalacion_pago_contrato FOREIGN KEY (id_contrato) REFERENCES saa.contrato(id_contrato) ON DELETE CASCADE;


--
-- TOC entry 5090 (class 2606 OID 41156)
-- Name: contrato fk_contrato_red_agua; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato
    ADD CONSTRAINT fk_contrato_red_agua FOREIGN KEY (id_red_agua) REFERENCES saa.red_agua(id_red_agua);


--
-- TOC entry 5091 (class 2606 OID 41141)
-- Name: contrato fk_contrato_usuario; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato
    ADD CONSTRAINT fk_contrato_usuario FOREIGN KEY (id_contribuyente) REFERENCES saa.usuario(id_contribuyente);


--
-- TOC entry 5092 (class 2606 OID 41161)
-- Name: contrato fk_contrato_zona_afectacion; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.contrato
    ADD CONSTRAINT fk_contrato_zona_afectacion FOREIGN KEY (id_zona_afectacion) REFERENCES saa.zona_afectacion(id_zona_afectacion);


--
-- TOC entry 5098 (class 2606 OID 41260)
-- Name: corte_suspension fk_corte_suspension_contrato; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.corte_suspension
    ADD CONSTRAINT fk_corte_suspension_contrato FOREIGN KEY (id_contrato) REFERENCES saa.contrato(id_contrato);


--
-- TOC entry 5100 (class 2606 OID 41291)
-- Name: informe_mantenimiento fk_informe_mantenimiento_contrato; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.informe_mantenimiento
    ADD CONSTRAINT fk_informe_mantenimiento_contrato FOREIGN KEY (id_contrato) REFERENCES saa.contrato(id_contrato);


--
-- TOC entry 5099 (class 2606 OID 41275)
-- Name: omision_servicio fk_omision_servicio_contrato; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.omision_servicio
    ADD CONSTRAINT fk_omision_servicio_contrato FOREIGN KEY (id_contrato) REFERENCES saa.contrato(id_contrato);


--
-- TOC entry 5096 (class 2606 OID 41244)
-- Name: pago fk_pago_public_pago; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.pago
    ADD CONSTRAINT fk_pago_public_pago FOREIGN KEY (id_pago_caja) REFERENCES caj.pago(id);


--
-- TOC entry 5097 (class 2606 OID 41239)
-- Name: pago fk_pago_recibo; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.pago
    ADD CONSTRAINT fk_pago_recibo FOREIGN KEY (id_recibo) REFERENCES saa.recibo(id_recibo);


--
-- TOC entry 5094 (class 2606 OID 41220)
-- Name: recibo fk_recibo_contrato; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.recibo
    ADD CONSTRAINT fk_recibo_contrato FOREIGN KEY (id_contrato) REFERENCES saa.contrato(id_contrato);


--
-- TOC entry 5095 (class 2606 OID 41225)
-- Name: recibo fk_recibo_sustento_descuento; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.recibo
    ADD CONSTRAINT fk_recibo_sustento_descuento FOREIGN KEY (id_sustento_descuento) REFERENCES saa.sustento_descuento(id_sustento_descuento);


--
-- TOC entry 5085 (class 2606 OID 41093)
-- Name: tarifa fk_tarifa_categoria_servicio; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.tarifa
    ADD CONSTRAINT fk_tarifa_categoria_servicio FOREIGN KEY (id_categoria_servicio) REFERENCES saa.categoria_servicio(id_categoria_servicio);


--
-- TOC entry 5086 (class 2606 OID 41123)
-- Name: usuario fk_usuario_gen_contribuyente; Type: FK CONSTRAINT; Schema: saa; Owner: admin
--

ALTER TABLE ONLY saa.usuario
    ADD CONSTRAINT fk_usuario_gen_contribuyente FOREIGN KEY (id_contribuyente) REFERENCES gen.gen_contribuyente(id);


--
-- TOC entry 5505 (class 0 OID 40658)
-- Dependencies: 392 5615
-- Name: vw_gen_contribuyente; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_contribuyente;


--
-- TOC entry 5496 (class 0 OID 40618)
-- Dependencies: 383 5615
-- Name: vw_gen_departamento; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_departamento;


--
-- TOC entry 5498 (class 0 OID 40626)
-- Dependencies: 385 5615
-- Name: vw_gen_distrito; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_distrito;


--
-- TOC entry 5503 (class 0 OID 40648)
-- Dependencies: 390 5615
-- Name: vw_gen_habilitacion_urbana; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_habilitacion_urbana;


--
-- TOC entry 5506 (class 0 OID 40665)
-- Dependencies: 393 5615
-- Name: vw_gen_predio; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_predio;


--
-- TOC entry 5497 (class 0 OID 40622)
-- Dependencies: 384 5615
-- Name: vw_gen_provincia; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_provincia;


--
-- TOC entry 5499 (class 0 OID 40631)
-- Dependencies: 386 5615
-- Name: vw_gen_sector; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_sector;


--
-- TOC entry 5502 (class 0 OID 40644)
-- Dependencies: 389 5615
-- Name: vw_gen_tipo_habilitacion_urbana; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_tipo_habilitacion_urbana;


--
-- TOC entry 5501 (class 0 OID 40640)
-- Dependencies: 388 5615
-- Name: vw_gen_tipo_interior; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_tipo_interior;


--
-- TOC entry 5500 (class 0 OID 40636)
-- Dependencies: 387 5615
-- Name: vw_gen_tipo_via; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_tipo_via;


--
-- TOC entry 5504 (class 0 OID 40653)
-- Dependencies: 391 5615
-- Name: vw_gen_via; Type: MATERIALIZED VIEW DATA; Schema: gen; Owner: admin
--

REFRESH MATERIALIZED VIEW gen.vw_gen_via;


--
-- TOC entry 5533 (class 0 OID 40953)
-- Dependencies: 420 5615
-- Name: vw_lic_actividad_comercial; Type: MATERIALIZED VIEW DATA; Schema: lic; Owner: admin
--

REFRESH MATERIALIZED VIEW lic.vw_lic_actividad_comercial;


--
-- TOC entry 5532 (class 0 OID 40947)
-- Dependencies: 419 5615
-- Name: vw_lic_condicion_local; Type: MATERIALIZED VIEW DATA; Schema: lic; Owner: admin
--

REFRESH MATERIALIZED VIEW lic.vw_lic_condicion_local;


--
-- TOC entry 5535 (class 0 OID 40965)
-- Dependencies: 422 5615
-- Name: vw_lic_giro_negocio; Type: MATERIALIZED VIEW DATA; Schema: lic; Owner: admin
--

REFRESH MATERIALIZED VIEW lic.vw_lic_giro_negocio;


--
-- TOC entry 5537 (class 0 OID 40977)
-- Dependencies: 424 5615
-- Name: vw_lic_licencia; Type: MATERIALIZED VIEW DATA; Schema: lic; Owner: admin
--

REFRESH MATERIALIZED VIEW lic.vw_lic_licencia;


--
-- TOC entry 5530 (class 0 OID 40935)
-- Dependencies: 417 5615
-- Name: vw_lic_motivo_anulacion; Type: MATERIALIZED VIEW DATA; Schema: lic; Owner: admin
--

REFRESH MATERIALIZED VIEW lic.vw_lic_motivo_anulacion;


--
-- TOC entry 5529 (class 0 OID 40929)
-- Dependencies: 416 5615
-- Name: vw_lic_motivo_registro; Type: MATERIALIZED VIEW DATA; Schema: lic; Owner: admin
--

REFRESH MATERIALIZED VIEW lic.vw_lic_motivo_registro;


--
-- TOC entry 5536 (class 0 OID 40971)
-- Dependencies: 423 5615
-- Name: vw_lic_requisito; Type: MATERIALIZED VIEW DATA; Schema: lic; Owner: admin
--

REFRESH MATERIALIZED VIEW lic.vw_lic_requisito;


--
-- TOC entry 5534 (class 0 OID 40959)
-- Dependencies: 421 5615
-- Name: vw_lic_tipo_establecimiento; Type: MATERIALIZED VIEW DATA; Schema: lic; Owner: admin
--

REFRESH MATERIALIZED VIEW lic.vw_lic_tipo_establecimiento;


--
-- TOC entry 5531 (class 0 OID 40941)
-- Dependencies: 418 5615
-- Name: vw_lic_tipo_licencia; Type: MATERIALIZED VIEW DATA; Schema: lic; Owner: admin
--

REFRESH MATERIALIZED VIEW lic.vw_lic_tipo_licencia;


-- Completed on 2025-11-30 02:44:33

--
-- PostgreSQL database dump complete
--

\unrestrict EFoMuVkzvLUS3uLHvQqjzYs4WiK80J6Z2ygMPZa2ZV1zI6BLN9VUzx4pxa3Cnak

