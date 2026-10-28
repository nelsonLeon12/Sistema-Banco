
-- 006_catalogos.sql

INSERT INTO tipo_transaccion (codigo, descripcion, tasa_impuesto) VALUES
    ('DEPOSITO',      'Ingreso de dinero a una cuenta',             0.00000),
    ('RETIRO',        'Retiro de dinero desde una cuenta',          0.00400),
    ('TRANSFERENCIA', 'Traslado de dinero entre dos cuentas',       0.00400);


INSERT INTO salario_minimo (anio, valor_mensual) VALUES
    (2025, 1423500.00),
    (2026, 1750905.00);

