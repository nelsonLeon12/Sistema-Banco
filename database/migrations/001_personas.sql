
-- 001_personas.sql




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
    CONSTRAINT ck_persona_mayor_edad
        CHECK (fecha_nacimiento <= CURRENT_DATE - INTERVAL '18 years'),
);


CREATE TABLE persona_telefono (
    cedula   VARCHAR(10) NOT NULL,
    telefono VARCHAR(10) NOT NULL,

    CONSTRAINT pk_persona_telefono PRIMARY KEY (cedula, telefono),
    CONSTRAINT fk_telefono_persona FOREIGN KEY (cedula)
        REFERENCES persona (cedula) ON DELETE CASCADE,
    CONSTRAINT ck_telefono_formato CHECK (telefono ~ '^[0-9]{7,10}$')
);


