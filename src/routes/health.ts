import { Router } from 'express';

export const healthRouter = Router();

// Ruta de salud: sirve para comprobar que la API está viva.
healthRouter.get('/salud', (_req, res) => {
  res.json({ estado: 'ok', servicio: 'surca-api' });
});
