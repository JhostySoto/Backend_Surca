import 'dotenv/config';
import { z } from 'zod';

// Validamos las variables de entorno al arrancar para fallar rápido y con un mensaje claro.
const esquema = z.object({
  PORT: z.coerce.number().default(3000),
  DATABASE_URL: z.string().min(1, 'Falta DATABASE_URL'),
  JWT_SECRET: z.string().min(16, 'JWT_SECRET debe tener al menos 16 caracteres'),
});

export const env = esquema.parse(process.env);
