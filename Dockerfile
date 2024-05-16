FROM php:8.2 as php

# Install dependencies
RUN apt-get update && apt-get install -y \
    libonig-dev \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libzip-dev 
    # Add libzip-dev for zip extension

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql zip exif pcntl
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

# Set working directory
WORKDIR /var/www
COPY . .

# Install composer
COPY --from=composer:2.7.6 /usr/bin/composer /usr/bin/composer

ENV PORT=9000
ENTRYPOINT [ "docker/entrypoint.sh" ]