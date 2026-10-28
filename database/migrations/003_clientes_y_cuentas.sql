
-- 003_clientes_y_cuentas.sql

CREATE TABLE cliente (
    cedula VARCHAR(10) NOT NULL,

    CONSTRAINT pk_cliente PRIMARY KEY (cedula),
    CONSTRAINT fk_cliente_persona FOREIGN KEY (cedula)
        REFERENCES persona (cedula) ON DELETE RESTRICT
);


CREATE TABLE cliente_sucursal (
    cedula         VARCHAR(10) NOT NULL,
    id_sucursal    SMALLINT    NOT NULL,
    fecha_registro DATE        NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT pk_cliente_sucursal PRIMARY KEY (cedula, id_sucursal),
    CONSTRAINT fk_clisuc_cliente FOREIGN KEY (cedula)
        REFERENCES cliente (cedula) ON DELETE RESTRICT,
    CONSTRAINT fk_clisuc_sucursal FOREIGN KEY (id_sucursal)
        REFERENCES sucursal (id_sucursal) ON DELETE RESTRICT,
    CONSTRAINT ck_clisuc_fecha CHECK (fecha_registro <= CURRENT_DATE)
);


CREATE TABLE cuenta (
    numero_cuenta  VARCHAR(10)   NOT NULL,
    cedula_titular VARCHAR(10)   NOT NULL,
    id_sucursal    SMALLINT      NOT NULL,
    fecha_apertura DATE          NOT NULL DEFAULT CURRENT_DATE,
    saldo          NUMERIC(16,2) NOT NULL DEFAULT 0,
    estado         VARCHAR(10)   NOT NULL DEFAULT 'ACTIVA',

    CONSTRAINT pk_cuenta PRIMARY KEY (numero_cuenta),
    CONSTRAINT fk_cuenta_titular_sucursal FOREIGN KEY (cedula_titular, id_sucursal)
        REFERENCES cliente_sucursal (cedula, id_sucursal) ON DELETE RESTRICT,
    CONSTRAINT ck_cuenta_numero CHECK (numero_cuenta ~ '^[0-9]{10}$'),
    CONSTRAINT ck_cuenta_fecha_apertura CHECK (fecha_apertura <= CURRENT_DATE),
    CONSTRAINT ck_cuenta_saldo_no_negativo CHECK (saldo >= 0),
    CONSTRAINT ck_cuenta_estado
        CHECK (estado IN ('ACTIVA', 'INACTIVA', 'BLOQUEADA', 'CANCELADA')),
   
    CONSTRAINT ck_cuenta_cancelada_en_cero
        CHECK (estado <> 'CANCELADA' OR saldo = 0)
);


