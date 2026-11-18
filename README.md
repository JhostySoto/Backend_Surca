# Backend_Surca

API REST de Surca: conecta a productores locales de Loja con compradores.

**Tecnologías:** Node.js · TypeScript · Express 5 · PostgreSQL · JWT · pnpm

## Cómo correrlo

Necesitas Node 20 o más, pnpm y Docker.

```bash
pnpm install
cp .env.example .env        # y cambia JWT_SECRET
docker compose up -d        # PostgreSQL con el esquema de db/schema.sql
pnpm dev                    # http://localhost:3000/api/salud
```

## Comandos

| Comando | Qué hace |
|---|---|
| `pnpm dev` | Arranca la API y se reinicia al guardar |
| `pnpm test` | Corre las pruebas (Vitest + Supertest) |
| `pnpm typecheck` | Revisa los tipos de TypeScript |
| `pnpm build` y `pnpm start` | Compila y arranca la versión final |

## Estructura

```
src/
  app.ts          configura Express (sin abrir puerto, para poder probarla)
  server.ts       arranca el servidor
  config/env.ts   variables de entorno validadas con zod
  db/pool.ts      conexión a PostgreSQL
  routes/         una carpeta o archivo por recurso
db/schema.sql     tablas: usuarios, productos, pedidos, estimaciones
tests/            pruebas
docs/             documentación de la API
```

Para reiniciar la base de datos desde cero: `docker compose down -v && docker compose up -d`.
