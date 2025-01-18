#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

pnpm i
lando rebuild -y
lando composer install
lando php artisan key:generate
lando php artisan migrate