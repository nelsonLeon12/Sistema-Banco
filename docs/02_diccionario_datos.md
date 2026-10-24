# Banco Sierra Nevada — Diccionario de datos

Refleja el esquema implementado en `db/migrations/001…006`. Convenciones: **PK** clave primaria · **FK** clave foránea · **UQ** única · `NN` NOT NULL · `N` admite NULL.

> **Datos personales (para la Entrega 3):** `persona.cedula`, nombres y apellidos, `fecha_nacimiento`, `correo_electronico` y `persona_telefono.telefono`. El saldo y las transacciones son información financiera sensible. En el repositorio solo hay datos ficticios.

---

### persona
Toda persona natural que se relaciona con el banco (cliente, empleado o ambos).

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| cedula | VARCHAR(10) | NN | PK | Documento de identidad; 6 a 10 dígitos. Identifica de forma única a la persona en todo el banco. |
| primer_nombre | VARCHAR(40) | NN | | Primer nombre. |
| segundo_nombre | VARCHAR(40) | N | | Segundo nombre, si lo tiene. |
| primer_apellido | VARCHAR(40) | NN | | Primer apellido. |
| segundo_apellido | VARCHAR(40) | N | | Segundo apellido, si lo tiene. |
| fecha_nacimiento | DATE | NN | | Debe corresponder a mayor de 18 años. La edad se calcula (vista `v_persona_edad`). |
| correo_electronico | VARCHAR(120) | N | UQ | Correo de contacto; formato validado. |

### persona_telefono
Teléfonos de una persona (atributo multivalor).

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| cedula | VARCHAR(10) | NN | PK, FK → persona | Persona dueña del teléfono. |
| telefono | VARCHAR(10) | NN | PK | Número de 7 a 10 dígitos (fijo o celular). |

### sucursal
Sede física del banco.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| id_sucursal | SMALLINT (identity) | NN | PK | Identificador interno de la sede. |
| nombre | VARCHAR(80) | NN | UQ | Nombre de la sede. |
| direccion | VARCHAR(120) | NN | | Dirección física. |
| municipio | VARCHAR(60) | NN | | Municipio donde opera. |
| hora_apertura | TIME | NN | | Hora de apertura al público. |
| hora_cierre | TIME | NN | | Hora de cierre; debe ser posterior a la apertura. |

### empresa_seguridad
Firma contratista que provee los vigilantes.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| nit | VARCHAR(11) | NN | PK | NIT con dígito de verificación (`NNNNNNNNN-D`). |
| nombre | VARCHAR(100) | NN | UQ | Razón social. |

### salario_minimo
Parámetro anual del salario mínimo legal mensual.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| anio | SMALLINT | NN | PK | Año de vigencia. |
| valor_mensual | NUMERIC(12,2) | NN | | Valor en pesos; mayor que 0. |

### empleado
Supertipo de los empleados.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| cedula | VARCHAR(10) | NN | PK, FK → persona | Persona que es empleada. |
| id_sucursal | SMALLINT | NN | FK → sucursal | Sede donde trabaja actualmente (una sola a la vez). |
| tipo_empleado | VARCHAR(20) | NN | UQ con cedula | `CAJERO`, `SERVICIOS_GENERALES` o `VIGILANTE`. Discriminador de la especialización. |
| tipo_contrato | VARCHAR(12) | NN | | `INDEFINIDO`, `FIJO` o `TERCERIZADO`. Es `TERCERIZADO` si y solo si es vigilante. |
| fecha_ingreso | DATE | NN | | Fecha de ingreso; no puede ser futura. |

### cajero
Subtipo: devenga salario mínimo + bono.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| cedula | VARCHAR(10) | NN | PK, FK → empleado | Empleado cajero. |
| tipo_empleado | VARCHAR(20) | NN | FK → empleado | Siempre `CAJERO` (garantiza la disjunción). |
| bono_mensual | NUMERIC(12,2) | NN | | Bono mensual en pesos; ≥ 0. Se suma al salario mínimo. |

### servicios_generales
Subtipo: personal de aseo; devenga solo el salario mínimo.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| cedula | VARCHAR(10) | NN | PK, FK → empleado | Empleado de servicios generales. |
| tipo_empleado | VARCHAR(20) | NN | FK → empleado | Siempre `SERVICIOS_GENERALES`. |

### vigilante_contratista
Subtipo: vigilante tercerizado, pagado por hora.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| cedula | VARCHAR(10) | NN | PK, FK → empleado | Empleado vigilante. |
| tipo_empleado | VARCHAR(20) | NN | FK → empleado | Siempre `VIGILANTE`. |
| nit_empresa | VARCHAR(11) | NN | FK → empresa_seguridad | Empresa de seguridad que lo contrata. |
| valor_hora | NUMERIC(10,2) | NN | | Pesos pagados por hora trabajada; > 0. |

### cliente
Subtipo de persona: quien tiene o puede tener cuentas.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| cedula | VARCHAR(10) | NN | PK, FK → persona | Persona vinculada como cliente. Un único registro por cédula en todo el banco. |

### cliente_sucursal
Relación "se registra": en qué sedes está registrado un cliente.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| cedula | VARCHAR(10) | NN | PK, FK → cliente | Cliente. |
| id_sucursal | SMALLINT | NN | PK, FK → sucursal | Sede donde se registró. |
| fecha_registro | DATE | NN | | Fecha del registro; no futura. |

### cuenta
Cuenta de ahorros de un cliente.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| numero_cuenta | VARCHAR(10) | NN | PK | Número de cuenta de 10 dígitos. |
| cedula_titular | VARCHAR(10) | NN | FK → cliente_sucursal | Titular único de la cuenta. |
| id_sucursal | SMALLINT | NN | FK → cliente_sucursal | Sede de apertura; el titular debe estar registrado allí. |
| fecha_apertura | DATE | NN | | Fecha de apertura; no futura. |
| saldo | NUMERIC(16,2) | NN | | Saldo disponible en pesos. Nunca negativo; sin tope máximo. Se mantiene a partir de las transacciones. |
| estado | VARCHAR(10) | NN | | `ACTIVA`, `INACTIVA`, `BLOQUEADA` o `CANCELADA`. Una cuenta cancelada tiene saldo 0. |

### tipo_transaccion
Catálogo de tipos de transacción y su tasa de impuesto vigente.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| codigo | VARCHAR(15) | NN | PK | `DEPOSITO`, `RETIRO` o `TRANSFERENCIA`. |
| descripcion | VARCHAR(100) | NN | | Descripción del tipo. |
| tasa_impuesto | NUMERIC(6,5) | NN | | Fracción entre 0 y 1 (0,004 = 4x1000). 0 para depósitos. |

### transaccion
Historial de operaciones sobre cuentas (una fila por operación).

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| id_transaccion | BIGINT (identity) | NN | PK | Identificador de la operación. |
| tipo_transaccion | VARCHAR(15) | NN | FK → tipo_transaccion | Qué clase de operación es. |
| fecha_hora | TIMESTAMPTZ | NN | | Fecha y hora exactas de la operación. |
| monto | NUMERIC(14,2) | NN | | Valor base de la operación (sin impuesto); > 0. |
| cuenta_origen | VARCHAR(10) | N | FK → cuenta | Cuenta que paga. NULL en depósitos; obligatoria en retiros y transferencias. |
| cuenta_destino | VARCHAR(10) | N | FK → cuenta | Cuenta que recibe. NULL en retiros; obligatoria en depósitos y transferencias. Distinta del origen. |
| cedula_cajero | VARCHAR(10) | NN | FK → cajero | Cajero que procesó la operación (trazabilidad). |
| id_sucursal | SMALLINT | NN | FK → sucursal | Sede donde se realizó. Se guarda como hecho histórico. |

### impuesto_transaccion
Impuesto (4x1000) cobrado sobre una transacción concreta. Solo existe si la tasa del tipo es > 0.

| Columna | Tipo | Nulo | Clave | Significado de negocio |
|---|---|---|---|---|
| id_transaccion | BIGINT | NN | PK, FK → transaccion | Transacción gravada. |
| tasa_aplicada | NUMERIC(6,5) | NN | | Tasa vigente al momento de la operación. |
| valor_impuesto | NUMERIC(14,2) | NN | | Pesos cobrados, adicionales al monto. La cuenta origen se debita `monto + valor_impuesto`. |

---

### Vistas

| Vista | Qué entrega |
|---|---|
| `v_persona_edad` | Cédula, nombre completo, fecha de nacimiento y **edad calculada**. |
| `v_remuneracion_empleado` | Por empleado: remuneración mensual (salario mínimo del año + bono para cajeros; salario mínimo para servicios generales) o valor por hora (vigilantes). |
