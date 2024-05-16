#!/bin/bash

if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.example .env
else
    echo ".env file already exists."
fi

if [ ! -f "storage/" ]; then
    php artisan storage:link
fi

role=${CONTAINER_ROLE:-app}

if [ "$role" = "app" ]; then
    php artisan key:generate
    php artisan migrate
    php artisan optimize:clear
    php artisan serve --port=$PORT --host=0.0.0.0 --env=.env
    exec docker-php-entrypoint "@"
elif [ "$role" = "queue" ]; then
    echo "Running the queue service..."
    php /var/www/artisan queue:work --verbose --tries=3 --timeout=180
fi