import pg from 'pg';
import { env } from '../config/env.js';

// Un solo pool de conexiones para toda la API.
export const pool = new pg.Pool({ connectionString: env.DATABASE_URL });
