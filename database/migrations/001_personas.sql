-- =====================================================================
-- 001_personas.sql
-- Supertipo PERSONA y su atributo multivalor (teléfono).
-- Banco Sierra Nevada · Proyecto Integrador · Entrega 2
-- =====================================================================
BEGIN;

-- PERSONA: toda persona natural que interactúa con el banco, sea como
-- cliente, como empleado o como ambas cosas (especialización solapada).
-- 'edad' NO se almacena: es un atributo derivado (ver vista v_persona_edad).
CREATE TABLE persona (
    cedula             VARCHAR(10)  NOT NULL,
    primer_nombre      VARCHAR(40)  NOT NULL,
    segundo_nombre     VARCHAR(40),
    primer_apellido    VARCHAR(40)  NOT NULL,
    segundo_apellido   VARCHAR(40),
    fecha_nacimiento   DATE         NOT NULL,
    correo_electronico VARCHAR(120),

    CONSTRAINT pk_persona PRIMARY KEY (cedula),
    CONSTRAINT uq_persona_correo UNIQUE (correo_electronico),
    CONSTRAINT ck_persona_cedula
        CHECK (cedula ~ '^[0-9]{6,10}$'),
    CONSTRAINT ck_persona_nombres_no_vacios
        CHECK (btrim(primer_nombre) <> '' AND btrim(primer_apellido) <> ''),
    -- Supuesto: el banco solo atiende y emplea mayores de edad.
    CONSTRAINT ck_persona_mayor_edad
        CHECK (fecha_nacimiento <= CURRENT_DATE - INTERVAL '18 years'),
    CONSTRAINT ck_persona_correo
        CHECK (correo_electronico ~ '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$')
);

-- PERSONA_TELEFONO: atributo multivalor 'Teléfono' → tabla propia.
-- Si se borra la persona, sus teléfonos no tienen sentido: CASCADE.
CREATE TABLE persona_telefono (
    cedula   VARCHAR(10) NOT NULL,
    telefono VARCHAR(10) NOT NULL,

    CONSTRAINT pk_persona_telefono PRIMARY KEY (cedula, telefono),
    CONSTRAINT fk_telefono_persona FOREIGN KEY (cedula)
        REFERENCES persona (cedula) ON DELETE CASCADE,
    CONSTRAINT ck_telefono_formato CHECK (telefono ~ '^[0-9]{7,10}$')
);

COMMIT;
