import { camelCase } from 'lodash';

// Utilisation de import.meta.glob pour charger dynamiquement les modules
const modules = import.meta.glob('./*.js', { eager: true });

const storeModules: { [key: string]: any } = {};

for (const path in modules) {
  if (path === './index.js') continue;

  const moduleName = camelCase(path.replace(/(\.\/|\.js)/g, ''));
  const module = modules[path] as { [key: string]: any };
  storeModules[moduleName] = module.default || module;
}

export default storeModules;