-- 007_consultas_simples.sql (PostgreSQL; requiere 001 a 006)

-- 1. total de usuarios
SELECT (SELECT COUNT(*) FROM persona)  AS total_personas,
       (SELECT COUNT(*) FROM cliente)  AS total_clientes,
       (SELECT COUNT(*) FROM empleado) AS total_empleados;

-- 2. solo cajeros (cedula, nombre, lo q gana)
SELECT cedula,
       (SELECT primer_nombre FROM persona WHERE persona.cedula = cajero.cedula) AS primer_nombre,
       ((SELECT valor_mensual FROM salario_minimo WHERE anio = EXTRACT(YEAR FROM CURRENT_DATE)) + bono_mensual) AS lo_que_gana
FROM cajero;

-- 3. solo servicios generales (cedula, nombre, lo q gana)
SELECT cedula,
       (SELECT primer_nombre FROM persona WHERE persona.cedula = servicios_generales.cedula) AS primer_nombre,
       (SELECT valor_mensual FROM salario_minimo WHERE anio = EXTRACT(YEAR FROM CURRENT_DATE)) AS lo_que_gana
FROM servicios_generales;

-- 4. vigilantes contratistas (cedula, nombre, valor por hora)
SELECT cedula,
       (SELECT primer_nombre FROM persona WHERE persona.cedula = vigilante_contratista.cedula) AS primer_nombre,
       valor_hora
FROM vigilante_contratista;

-- 5. los 10 clientes con mas dinero
SELECT cedula_titular AS cedula,
       (SELECT primer_nombre FROM persona WHERE persona.cedula = cuenta.cedula_titular) AS nombre,
       SUM(saldo) AS saldo_total
FROM cuenta
GROUP BY cedula_titular
ORDER BY saldo_total DESC
LIMIT 10;

-- 6. total de dinero guardado en el banco
SELECT SUM(saldo) AS total_dinero_banco
FROM cuenta;	