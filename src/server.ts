import { crearApp } from './app.js';
import { env } from './config/env.js';

crearApp().listen(env.PORT, () => {
  console.log(`API de Surca escuchando en http://localhost:${env.PORT}/api`);
});
