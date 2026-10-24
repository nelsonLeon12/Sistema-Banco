-- =====================================================================
-- 005_vistas_base.sql
-- Vistas que materializan atributos DERIVADOS del modelo conceptual
-- (edad y remuneración). No almacenan datos redundantes.
-- =====================================================================
BEGIN;

-- Edad calculada a partir de la fecha de nacimiento.
CREATE VIEW v_persona_edad AS
SELECT p.cedula,
       concat_ws(' ', p.primer_nombre, p.segundo_nombre,
                      p.primer_apellido, p.segundo_apellido) AS nombre_completo,
       p.fecha_nacimiento,
       EXTRACT(YEAR FROM age(CURRENT_DATE, p.fecha_nacimiento))::INT AS edad
FROM persona p;

-- Remuneración de cada empleado según su tipo:
--   CAJERO              → salario mínimo del año en curso + bono
--   SERVICIOS_GENERALES → salario mínimo del año en curso
--   VIGILANTE           → se paga por hora (remuneracion_mensual queda NULL)
CREATE VIEW v_remuneracion_empleado AS
SELECT e.cedula,
       e.id_sucursal,
       e.tipo_empleado,
       CASE e.tipo_empleado
            WHEN 'CAJERO'              THEN sm.valor_mensual + c.bono_mensual
            WHEN 'SERVICIOS_GENERALES' THEN sm.valor_mensual
       END AS remuneracion_mensual,
       v.valor_hora
FROM empleado e
LEFT JOIN cajero c                ON c.cedula = e.cedula
LEFT JOIN vigilante_contratista v ON v.cedula = e.cedula
LEFT JOIN salario_minimo sm       ON sm.anio = EXTRACT(YEAR FROM CURRENT_DATE)::SMALLINT;

COMMIT;
