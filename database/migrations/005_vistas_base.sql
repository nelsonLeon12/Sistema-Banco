-- =======================
-- 005_vistas_simples.sql
--========================

-- 1. total de usuarios

SELECT (SELECT COUNT(*) FROM persona)  AS total_personas,
       (SELECT COUNT(*) FROM cliente)  AS total_clientes,
       (SELECT COUNT(*) FROM empleado) AS total_empleados;


-- 3. solo cajeros
SELECT cedula,
       (SELECT primer_nombre || ' ' || primer_apellido FROM persona
        WHERE persona.cedula = cajero.cedula) AS nombre,
       bono_mensual
FROM cajero;


-- 4. solo servicios generales
SELECT cedula,
       (SELECT primer_nombre || ' ' || primer_apellido
        FROM persona
        WHERE persona.cedula = servicios_generales.cedula) AS nombre
FROM servicios_generales;


-- 5. vigilantes contratistas (de otra empresa)

SELECT cedula,
       (SELECT primer_nombre || ' ' || primer_apellido
        FROM persona
        WHERE persona.cedula = vigilante_contratista.cedula) AS nombre,
       nit_empresa,
       (SELECT nombre
        FROM empresa_seguridad
        WHERE empresa_seguridad.nit = vigilante_contratista.nit_empresa) AS empresa,
       valor_hora
FROM vigilante_contratista;


-- 6. los 10 clientes con mas dinero (suma de todas sus cuentas)
SELECT cedula_titular AS cedula,
       (SELECT primer_nombre || ' ' || primer_apellido
        FROM persona
        WHERE persona.cedula = cuenta.cedula_titular) AS nombre,
       COUNT(*)   AS num_cuentas,
       SUM(saldo) AS saldo_total
FROM cuenta
GROUP BY cedula_titular
ORDER BY saldo_total DESC, cedula_titular
LIMIT 10;


-- 7. total de dinero guardado en el banco
SELECT (SUM(saldo)) AS total_dinero_banco FROM cuenta;


-- 8. total pagado a los empleados por mes
-- (cajeros + servicios generales) x salario minimo del año + bonos de los cajeros
-- los vigilantes no suman: se pagan por hora y no se guardan las horas
SELECT ((SELECT COUNT(*) FROM cajero) + (SELECT COUNT(*) FROM servicios_generales))
       * (SELECT valor_mensual FROM salario_minimo WHERE anio = EXTRACT(YEAR FROM CURRENT_DATE))
       + (SELECT COALESCE(SUM(bono_mensual), 0) FROM cajero) AS total_nomina_mensual;
