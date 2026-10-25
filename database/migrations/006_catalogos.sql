-- =====================================================================
-- 006_catalogos.sql
-- Datos de referencia que el sistema necesita para operar (no son datos
-- de prueba): tipos de transacción con su tasa y salario mínimo legal.
-- =====================================================================


-- Supuesto de alcance: solo se modela el impuesto a las transacciones
-- financieras (4x1000 = 0,004) sobre retiros y transferencias, sin las
-- exenciones del GMF. Los depósitos no causan impuesto. Las comisiones
-- quedan fuera del alcance reducido.
INSERT INTO tipo_transaccion (codigo, descripcion, tasa_impuesto) VALUES
    ('DEPOSITO',      'Ingreso de dinero a una cuenta',             0.00000),
    ('RETIRO',        'Retiro de dinero desde una cuenta',          0.00400),
    ('TRANSFERENCIA', 'Traslado de dinero entre dos cuentas',       0.00400);

-- Salario mínimo mensual legal vigente (Decreto 1469 de 2025 para 2026).
INSERT INTO salario_minimo (anio, valor_mensual) VALUES
    (2025, 1423500.00),
    (2026, 1750905.00);

