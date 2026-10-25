-- =====================================================================
-- 001_datos_semilla.sql
-- Datos FICTICIOS pero coherentes para Banco Sierra Nevada.
-- Cédulas, teléfonos y correos son inventados (dominio example.com);
-- ninguna persona real está representada.
-- Ejecutar DESPUÉS de las migraciones 001-006, sobre base sin datos.
-- =====================================================================
SET client_encoding = 'UTF8';


-- ---------------------------------------------------------------------
-- 1. SUCURSALES (4 sedes en el Cesar)
-- ---------------------------------------------------------------------
INSERT INTO sucursal (id_sucursal, nombre, direccion, municipio, hora_apertura, hora_cierre) VALUES
    (1, 'Sede Valledupar Centro', 'Carrera 5 # 15-30',      'Valledupar', '08:00', '16:00'),
    (2, 'Sede Aguachica',         'Calle 6 # 14-22',        'Aguachica',  '08:00', '16:00'),
    (3, 'Sede Bosconia',          'Carrera 8 # 9-41',       'Bosconia',   '08:30', '15:30'),
    (4, 'Sede Codazzi',           'Calle 12 # 7-18',        'Agustín Codazzi', '08:30', '15:30');

-- ---------------------------------------------------------------------
-- 2. PERSONAS (12 clientes + 9 empleados; Rosa Fuentes es ambas cosas)
-- ---------------------------------------------------------------------
INSERT INTO persona (cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, correo_electronico) VALUES
    -- Clientes
    ('1065623481', 'Camila',    'Andrea',  'Pérez',    'Mendoza',   '1991-03-14', 'camila.perez@example.com'),
    ('77193407',   'Juan',      'David',   'Ortiz',    'Pacheco',   '1987-11-02', 'juan.ortiz@example.com'),
    ('1065845103', 'Laura',     'Sofía',   'Maestre',  'Daza',      '1995-07-21', 'laura.maestre@example.com'),
    ('77038521',   'Carlos',    'Eduardo', 'Rincón',   'Araújo',    '1978-01-30', 'carlos.rincon@example.com'),
    ('1066732915', 'María',     'Fernanda','Zuleta',   'Cuello',    '2000-05-09', 'maria.zuleta@example.com'),
    ('77105268',   'Andrés',    'Felipe',  'Molina',   'Vega',      '1983-09-18', 'andres.molina@example.com'),
    ('49712630',   'Luisa',     'Marina',  'Barros',   'Fuentes',   '1969-12-05', 'luisa.barros@example.com'),
    ('1065691748', 'Jorge',     'Iván',    'Castilla', 'Peñaloza',  '1992-04-27', 'jorge.castilla@example.com'),
    ('1065912034', 'Daniela',   'Paola',   'Redondo',  'Mejía',     '1998-08-16', 'daniela.redondo@example.com'),
    ('1067284415', 'Sebastián', NULL,      'Gómez',    'Orozco',    '2002-02-11', 'sebastian.gomez@example.com'),
    ('49784106',   'Ana',       'Lucía',   'Villero',  'Sierra',    '1974-06-23', 'ana.villero@example.com'),
    ('12528937',   'Pedro',     'Pablo',   'Daza',     'Ariza',     '1966-10-10', 'pedro.daza@example.com'),
    -- Empleados (la primera, Rosa Fuentes, también es clienta del banco)
    ('52318076',   'Rosa',      'Elena',   'Fuentes',  'Caro',      '1988-02-19', 'rosa.fuentes@example.com'),
    ('1065537219', 'Miguel',    'Ángel',   'Arzuaga',  'Ruiz',      '1990-10-03', 'miguel.arzuaga@example.com'),
    ('1065778306', 'Yurleidis', 'Paola',   'Carrillo', 'Soto',      '1994-12-28', 'yurleidis.carrillo@example.com'),
    ('77214953',   'Ricardo',   'Antonio', 'Salas',    'Brito',     '1985-05-15', 'ricardo.salas@example.com'),
    ('1065948827', 'Dayana',    'Marcela', 'Ospino',   'Lara',      '1997-09-07', 'dayana.ospino@example.com'),
    ('49653182',   'Nubia',     'Esther',  'Cantillo', 'Rey',       '1972-03-25', NULL),
    ('36518740',   'Gladys',    'María',   'Torres',   'Pino',      '1970-08-12', NULL),
    ('77045369',   'Wilmer',    'José',    'Escorcia', 'Díaz',      '1980-01-09', NULL),
    ('72184650',   'Hernán',    'Darío',   'Plata',    'Núñez',     '1982-11-30', NULL);

INSERT INTO persona_telefono (cedula, telefono) VALUES
    ('1065623481', '3015550142'), ('1065623481', '3105550143'),
    ('77193407',   '3125550177'),
    ('1065845103', '3205550118'),
    ('77038521',   '3005550163'), ('77038521',   '6055841200'),
    ('1066732915', '3115550124'),
    ('77105268',   '3135550190'),
    ('49712630',   '3145550102'), ('49712630',   '6055712345'),
    ('1065691748', '3155550136'),
    ('1065912034', '3165550155'),
    ('1067284415', '3175550171'),
    ('49784106',   '3185550184'),
    ('12528937',   '3195550109'),
    ('52318076',   '3005550211'),
    ('1065537219', '3015550222'),
    ('1065778306', '3025550233'),
    ('77214953',   '3035550244'),
    ('1065948827', '3045550255'),
    ('49653182',   '3055550266'),
    ('36518740',   '3065550277'),
    ('77045369',   '3075550288'),
    ('72184650',   '3085550299');

-- ---------------------------------------------------------------------
-- 3. EMPRESAS DE SEGURIDAD Y EMPLEADOS
-- ---------------------------------------------------------------------
INSERT INTO empresa_seguridad (nit, nombre) VALUES
    ('900412875-3', 'Vigías del Cesar S.A.S.'),
    ('800256391-7', 'Guardianes del Valle Ltda.');

INSERT INTO empleado (cedula, id_sucursal, tipo_empleado, tipo_contrato, fecha_ingreso) VALUES
    ('52318076',   1, 'CAJERO',              'INDEFINIDO', '2019-11-04'),
    ('1065537219', 1, 'CAJERO',              'FIJO',       '2023-02-01'),
    ('1065778306', 2, 'CAJERO',              'INDEFINIDO', '2021-06-14'),
    ('77214953',   3, 'CAJERO',              'INDEFINIDO', '2018-09-03'),
    ('1065948827', 4, 'CAJERO',              'FIJO',       '2024-01-15'),
    ('49653182',   1, 'SERVICIOS_GENERALES', 'INDEFINIDO', '2017-04-10'),
    ('36518740',   2, 'SERVICIOS_GENERALES', 'FIJO',       '2022-08-22'),
    ('77045369',   1, 'VIGILANTE',           'TERCERIZADO','2020-03-02'),
    ('72184650',   2, 'VIGILANTE',           'TERCERIZADO','2021-10-18');

INSERT INTO cajero (cedula, bono_mensual) VALUES
    ('52318076',   350000),
    ('1065537219', 300000),
    ('1065778306', 300000),
    ('77214953',   250000),
    ('1065948827', 250000);

INSERT INTO servicios_generales (cedula) VALUES
    ('49653182'),
    ('36518740');

INSERT INTO vigilante_contratista (cedula, nit_empresa, valor_hora) VALUES
    ('77045369', '900412875-3', 9800),
    ('72184650', '800256391-7', 10200);

-- ---------------------------------------------------------------------
-- 4. CLIENTES Y SU REGISTRO EN SUCURSALES (relación N:M "Se registra")
-- ---------------------------------------------------------------------
INSERT INTO cliente (cedula) VALUES
    ('1065623481'), ('77193407'), ('1065845103'), ('77038521'), ('1066732915'),
    ('77105268'),   ('49712630'), ('1065691748'), ('1065912034'), ('1067284415'),
    ('49784106'),   ('12528937'), ('52318076');

INSERT INTO cliente_sucursal (cedula, id_sucursal, fecha_registro) VALUES
    ('1065623481', 1, '2021-02-10'),
    ('1065623481', 2, '2023-05-18'),   -- Camila: registrada en dos sedes
    ('77193407',   1, '2019-08-05'),
    ('1065845103', 2, '2022-01-17'),
    ('77038521',   1, '2018-03-12'),
    ('77038521',   3, '2020-09-01'),   -- Carlos: registrado en dos sedes
    ('1066732915', 4, '2023-11-06'),
    ('77105268',   2, '2020-06-22'),
    ('49712630',   3, '2017-04-03'),
    ('1065691748', 1, '2024-02-14'),
    ('1065912034', 4, '2022-10-30'),
    ('1067284415', 1, '2025-01-20'),
    ('49784106',   3, '2016-07-11'),
    ('12528937',   2, '2026-03-02'),   -- Pedro: registrado, aún sin cuentas
    ('52318076',   1, '2020-01-15');   -- Rosa (cajera) también es clienta

-- ---------------------------------------------------------------------
-- 5. CUENTAS DE AHORRO (saldo inicial 0; se recalcula en el paso 8)
-- ---------------------------------------------------------------------
INSERT INTO cuenta (numero_cuenta, cedula_titular, id_sucursal, fecha_apertura, saldo, estado) VALUES
    ('4001000001', '1065623481', 1, '2021-02-10', 0, 'ACTIVA'),
    ('4001000002', '1065623481', 2, '2023-05-18', 0, 'ACTIVA'),
    ('4001000003', '77193407',   1, '2019-08-05', 0, 'ACTIVA'),
    ('4001000004', '1065845103', 2, '2022-01-17', 0, 'ACTIVA'),
    ('4001000005', '77038521',   1, '2018-03-12', 0, 'ACTIVA'),
    ('4001000006', '77038521',   3, '2020-09-01', 0, 'ACTIVA'),
    ('4001000007', '1066732915', 4, '2023-11-06', 0, 'ACTIVA'),
    ('4001000008', '77105268',   2, '2020-06-22', 0, 'ACTIVA'),
    ('4001000009', '49712630',   3, '2017-04-03', 0, 'ACTIVA'),
    ('4001000010', '1065691748', 1, '2024-02-14', 0, 'ACTIVA'),
    ('4001000011', '1065912034', 4, '2022-10-30', 0, 'ACTIVA'),
    ('4001000012', '1067284415', 1, '2025-01-20', 0, 'ACTIVA'),
    ('4001000013', '49784106',   3, '2016-07-11', 0, 'INACTIVA'),  -- sin movimientos desde 2023
    ('4001000014', '52318076',   1, '2020-01-15', 0, 'ACTIVA');

-- ---------------------------------------------------------------------
-- 6. TRANSACCIONES (43 movimientos, en orden cronológico)
--    Cajeros: 52318076 y 1065537219 (sede 1), 1065778306 (sede 2),
--             77214953 (sede 3), 1065948827 (sede 4).
--    Ningún cajero procesa operaciones sobre su propia cuenta.
-- ---------------------------------------------------------------------
INSERT INTO transaccion
    (id_transaccion, tipo_transaccion, fecha_hora, monto, cuenta_origen, cuenta_destino, cedula_cajero, id_sucursal) VALUES
    ( 1, 'DEPOSITO',      '2022-03-10 09:15-05',  4000000, NULL,         '4001000013', '77214953',   3),
    ( 2, 'RETIRO',        '2022-06-20 11:00-05',   500000, '4001000013', NULL,         '77214953',   3),
    ( 3, 'DEPOSITO',      '2023-02-14 10:30-05',   300000, NULL,         '4001000013', '77214953',   3),
    ( 4, 'DEPOSITO',      '2025-01-22 10:05-05',  1500000, NULL,         '4001000012', '52318076',   1),
    ( 5, 'DEPOSITO',      '2025-02-03 08:45-05',  6000000, NULL,         '4001000001', '1065537219', 1),
    ( 6, 'DEPOSITO',      '2025-02-03 09:10-05',  2500000, NULL,         '4001000003', '52318076',   1),
    ( 7, 'DEPOSITO',      '2025-02-10 14:20-05',  8000000, NULL,         '4001000005', '1065537219', 1),
    ( 8, 'DEPOSITO',      '2025-02-12 15:00-05',  3200000, NULL,         '4001000004', '1065778306', 2),
    ( 9, 'DEPOSITO',      '2025-02-18 09:30-05', 12000000, NULL,         '4001000009', '77214953',   3),
    (10, 'DEPOSITO',      '2025-03-01 10:00-05',  5000000, NULL,         '4001000008', '1065778306', 2),
    (11, 'DEPOSITO',      '2025-03-05 11:40-05',  2000000, NULL,         '4001000007', '1065948827', 4),
    (12, 'DEPOSITO',      '2025-03-07 16:00-05',  4500000, NULL,         '4001000011', '1065948827', 4),
    (13, 'DEPOSITO',      '2025-03-15 09:00-05',  3000000, NULL,         '4001000010', '52318076',   1),
    (14, 'DEPOSITO',      '2025-03-20 10:20-05',  1800000, NULL,         '4001000014', '1065537219', 1),
    (15, 'DEPOSITO',      '2025-03-28 08:50-05',  2200000, NULL,         '4001000002', '1065778306', 2),
    (16, 'DEPOSITO',      '2025-04-02 09:40-05',  7000000, NULL,         '4001000006', '77214953',   3),
    (17, 'RETIRO',        '2025-04-10 11:15-05',  1000000, '4001000001', NULL,         '52318076',   1),
    (18, 'RETIRO',        '2025-04-15 15:30-05',   500000, '4001000003', NULL,         '1065537219', 1),
    (19, 'TRANSFERENCIA', '2025-04-22 10:10-05',  1000000, '4001000005', '4001000003', '1065537219', 1),
    (20, 'TRANSFERENCIA', '2025-05-05 09:25-05',   800000, '4001000009', '4001000007', '77214953',   3),
    (21, 'RETIRO',        '2025-05-12 14:00-05',  2000000, '4001000009', NULL,         '77214953',   3),
    (22, 'TRANSFERENCIA', '2025-05-20 10:45-05',  1500000, '4001000008', '4001000004', '1065778306', 2),
    (23, 'DEPOSITO',      '2025-06-03 11:00-05',  2000000, NULL,         '4001000012', '52318076',   1),
    (24, 'RETIRO',        '2025-06-18 16:10-05',   700000, '4001000012', NULL,         '1065537219', 1),
    (25, 'TRANSFERENCIA', '2025-07-07 09:00-05',  2000000, '4001000001', '4001000002', '52318076',   1),
    (26, 'RETIRO',        '2025-07-15 10:30-05',  1200000, '4001000011', NULL,         '1065948827', 4),
    (27, 'DEPOSITO',      '2025-08-04 13:45-05',  6500000, NULL,         '4001000010', '52318076',   1),
    (28, 'RETIRO',        '2025-08-19 09:35-05',  3000000, '4001000006', NULL,         '77214953',   3),
    (29, 'TRANSFERENCIA', '2025-09-02 15:20-05',  1000000, '4001000010', '4001000012', '1065537219', 1),
    (30, 'DEPOSITO',      '2025-09-16 10:00-05',  5000000, NULL,         '4001000005', '1065537219', 1),
    (31, 'TRANSFERENCIA', '2025-10-06 11:30-05',   500000, '4001000014', '4001000001', '1065537219', 1),
    (32, 'RETIRO',        '2025-11-03 09:05-05',  2500000, '4001000004', NULL,         '1065778306', 2),
    (33, 'DEPOSITO',      '2025-11-21 14:50-05',  3500000, NULL,         '4001000008', '1065778306', 2),
    (34, 'RETIRO',        '2025-12-05 10:15-05',  1500000, '4001000007', NULL,         '1065948827', 4),
    (35, 'DEPOSITO',      '2025-12-19 16:30-05',  4000000, NULL,         '4001000003', '52318076',   1),
    (36, 'TRANSFERENCIA', '2026-01-14 09:20-05',  3000000, '4001000005', '4001000006', '1065537219', 1),
    (37, 'RETIRO',        '2026-02-09 11:10-05',   800000, '4001000012', NULL,         '52318076',   1),
    (38, 'TRANSFERENCIA', '2026-03-10 10:40-05',  2500000, '4001000011', '4001000009', '1065948827', 4),
    (39, 'DEPOSITO',      '2026-04-14 15:05-05',  2000000, NULL,         '4001000014', '1065537219', 1),
    (40, 'RETIRO',        '2026-05-18 09:50-05',  4000000, '4001000009', NULL,         '77214953',   3),
    (41, 'TRANSFERENCIA', '2026-06-02 10:25-05',  1200000, '4001000003', '4001000010', '52318076',   1),
    (42, 'DEPOSITO',      '2026-09-08 11:00-05',  1000000, NULL,         '4001000001', '1065537219', 1),
    (43, 'RETIRO',        '2026-10-05 09:40-05',   900000, '4001000002', NULL,         '1065778306', 2);

-- ---------------------------------------------------------------------
-- 7. IMPUESTO: se calcula desde el catálogo para las transacciones cuyo
--    tipo tiene tasa > 0 (retiros y transferencias).
-- ---------------------------------------------------------------------
INSERT INTO impuesto_transaccion (id_transaccion, tasa_aplicada, valor_impuesto)
SELECT t.id_transaccion, tt.tasa_impuesto, ROUND(t.monto * tt.tasa_impuesto, 2)
FROM transaccion t
JOIN tipo_transaccion tt ON tt.codigo = t.tipo_transaccion
WHERE tt.tasa_impuesto > 0;

-- ---------------------------------------------------------------------
-- 8. SALDOS: se derivan del historial para garantizar coherencia.
--    saldo = depósitos y transferencias recibidas
--          - (retiros y transferencias enviadas + su impuesto)
-- ---------------------------------------------------------------------
UPDATE cuenta c
SET saldo =
      COALESCE((SELECT SUM(t.monto)
                FROM transaccion t
                WHERE t.cuenta_destino = c.numero_cuenta), 0)
    - COALESCE((SELECT SUM(t.monto + COALESCE(i.valor_impuesto, 0))
                FROM transaccion t
                LEFT JOIN impuesto_transaccion i ON i.id_transaccion = t.id_transaccion
                WHERE t.cuenta_origen = c.numero_cuenta), 0);

-- ---------------------------------------------------------------------
-- 9. Alinear las secuencias con los ids insertados a mano
-- ---------------------------------------------------------------------
SELECT setval(pg_get_serial_sequence('sucursal',    'id_sucursal'),    (SELECT MAX(id_sucursal)    FROM sucursal));
SELECT setval(pg_get_serial_sequence('transaccion', 'id_transaccion'), (SELECT MAX(id_transaccion) FROM transaccion));

