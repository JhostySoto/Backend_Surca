-- Esquema inicial de Surca (PostgreSQL).
-- Se ejecuta solo la primera vez que se crea el contenedor (ver docker-compose.yml).

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE usuarios (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre         TEXT NOT NULL,
  correo         TEXT NOT NULL UNIQUE,
  password_hash  TEXT NOT NULL,
  rol            TEXT NOT NULL CHECK (rol IN ('productor', 'comprador')),
  creado_en      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE productos (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  productor_id          UUID NOT NULL REFERENCES usuarios(id),
  nombre                TEXT NOT NULL,
  precio_centavos       INTEGER NOT NULL CHECK (precio_centavos > 0), -- dólares en centavos
  unidad                TEXT NOT NULL,                                -- libra, mazorca, etc.
  cantidad_disponible   INTEGER NOT NULL CHECK (cantidad_disponible >= 0),
  activo                BOOLEAN NOT NULL DEFAULT true,
  creado_en             TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE pedidos (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  comprador_id          UUID NOT NULL REFERENCES usuarios(id),
  producto_id           UUID NOT NULL REFERENCES productos(id),
  cantidad              INTEGER NOT NULL CHECK (cantidad > 0),
  total_centavos        INTEGER NOT NULL CHECK (total_centavos > 0),
  estado                TEXT NOT NULL DEFAULT 'enviado' CHECK (estado IN ('enviado', 'confirmado', 'entregado')),
  -- La app manda una clave única por pedido. Si la repite, el servidor no crea un segundo pedido.
  clave_idempotencia    TEXT NOT NULL,
  creado_en             TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (comprador_id, clave_idempotencia)
);

-- La escribe el script de AI_Surca una vez al día. La API solo la lee.
CREATE TABLE estimaciones (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  producto_id         UUID NOT NULL REFERENCES productos(id),
  semana_inicio       DATE NOT NULL,
  cantidad_estimada   NUMERIC(10, 2) NOT NULL,
  es_simulado         BOOLEAN NOT NULL DEFAULT true, -- los datos de entrenamiento son simulados
  generado_en         TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (producto_id, semana_inicio)
);

CREATE INDEX idx_productos_productor ON productos (productor_id);
CREATE INDEX idx_pedidos_comprador ON pedidos (comprador_id);
CREATE INDEX idx_pedidos_producto ON pedidos (producto_id);
