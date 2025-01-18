import { defineConfig, loadEnv } from 'vite';
import laravel from 'laravel-vite-plugin';
import fs from 'fs';
import path from 'path'

process.env = { ...process.env, ...loadEnv('', process.cwd()) };
const appDomain = new URL(process.env.VITE_APP_URL).hostname;

export default defineConfig({
    server: {
      host: '0.0.0.0',
      hmr: {
          host: appDomain,
      },
      https: {
        key: fs.readFileSync(path.join(process.env.VITE_CERTS_DIR, appDomain) + '-key.pem'),
        cert: fs.readFileSync(path.join(process.env.VITE_CERTS_DIR, appDomain) + '.pem'),
      },
    },
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],
});
