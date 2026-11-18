import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import { healthRouter } from './routes/health.js';

// La app se separa del servidor para poder probarla sin abrir un puerto.
export function crearApp() {
  const app = express();
  app.use(helmet());
  app.use(cors());
  app.use(express.json());

  app.use('/api', healthRouter);

  return app;
}
