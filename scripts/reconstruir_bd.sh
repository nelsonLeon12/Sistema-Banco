#!/usr/bin/env bash
# Reconstruye la base de datos desde cero: migraciones en orden + datos semilla.
# Uso:  ./scripts/reconstruir_bd.sh [banco_sierra_nevada]
# Las credenciales NO van en el código: use variables de entorno de PostgreSQL
# (PGHOST, PGPORT, PGUSER, PGPASSWORD) o el archivo ~/.pgpass.
# ATENCIÓN: elimina y vuelve a crear la base indicada.
set -euo pipefail

DB="${1:-banco_sierra_nevada}"
cd "$(dirname "$0")/.."

dropdb --if-exists "$DB"
createdb "$DB"

for f in database/migrations/*.sql database/seeds/*.sql; do
  echo ">> $f"
  psql -v ON_ERROR_STOP=1 -q -d "$DB" -f "$f"
done
echo "Base '$DB' reconstruida correctamente."
