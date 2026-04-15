# Menggunakan image resmi WordPress
FROM wordpress:latest

# Install plugin SQLite agar WordPress bisa jalan tanpa MySQL server
# Alasan: Render Free tier tidak memberikan database gratis secara otomatis, 
# jadi kita gunakan SQLite (file-based database) untuk efisiensi.
RUN apt-get update && apt-get install -y sqlite3 libsqlite3-dev \
    && curl -o /tmp/sqlite-plugin.zip -L https://downloads.wordpress.org/plugin/sqlite-integration.1.8.1.zip \
    && apt-get install -y unzip \
    && unzip /tmp/sqlite-plugin.zip -d /usr/src/wordpress/wp-content/plugins/ \
    && cp /usr/src/wordpress/wp-content/plugins/sqlite-integration/db.php /usr/src/wordpress/wp-content/db.php \
    && rm /tmp/sqlite-plugin.zip

# Memberi izin akses folder agar WordPress bisa menulis file database
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 sesuai standar PaaS
EXPOSE 80