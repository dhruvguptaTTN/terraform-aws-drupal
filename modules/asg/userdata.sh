#!/bin/bash

# Update system and install required utilities
sudo apt-get update -y
sudo apt-get install -y jq wget curl git

# Install PHP 8.1 and required PHP extensions
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y
sudo apt-get install -y php8.1 php8.1-cli php8.1-fpm php8.1-mysql php8.1-xml php8.1-mbstring php8.1-curl php8.1-zip php8.1-gd php8.1-soap php8.1-intl php8.1-bcmath php8.1-opcache

# Install MariaDB server and client
sudo apt-get install -y mariadb-server mariadb-client

# Start and enable MariaDB
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Configure RDS (or local) database
x=$(echo "${rds_endpt}" | cut -d':' -f1)
echo $x
sudo mysql -h "$x" -P 3306 -u drupaladmin -predhat22 -e "CREATE DATABASE drupal; CREATE USER 'drupaluser'@'%' IDENTIFIED BY 'drupalpass'; GRANT ALL ON drupal.* TO 'drupaluser'@'%' IDENTIFIED BY 'drupalpass' WITH GRANT OPTION; FLUSH PRIVILEGES; EXIT;"

# Install Nginx
sudo apt-get install -y nginx

# Download and install Drupal
cd /tmp && wget https://www.drupal.org/download-latest/tar.gz
sudo tar -zxvf tar*.gz -C /usr/share/nginx/html/
cd /usr/share/nginx/html/
sudo mv drupal-* drupal
sudo chown -R www-data:www-data /usr/share/nginx/html/
sudo chmod -R 755 /usr/share/nginx/html/

# Nginx configuration for Drupal
echo "user www-data;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
  worker_connections 1024;
}

http {
  log_format main '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '
  '\$status \$body_bytes_sent \"\$http_referer\" '
  '\"\$http_user_agent\" \"\$http_x_forwarded_for\"';

  access_log /var/log/nginx/access.log main;

  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 4096;

  include /etc/nginx/mime.types;
  default_type application/octet-stream;

  include /etc/nginx/conf.d/*.conf;

  server {
    listen 80;
    server_name _;
    root /usr/share/nginx/html/drupal;

    location = /favicon.ico {
      log_not_found off;
      access_log off;
    }

    location = /robots.txt {
      allow all;
      log_not_found off;
      access_log off;
    }

    location ~ \..*/.*\.php$ {
      return 403;
    }

    location ~ ^/sites/.*/private/ {
      return 403;
    }

    location ~ (^|/)\. {
      return 403;
    }

    location / {
      try_files \$uri @rewrite;
    }

    location @rewrite {
      rewrite ^ /index.php;
    }

    location ~ \.php$ {
      fastcgi_split_path_info ^(.+\.php)(/.+)$;
      include fastcgi_params;
      fastcgi_param SCRIPT_FILENAME \$request_filename;
      fastcgi_intercept_errors on;
      fastcgi_pass unix:/run/php/php8.1-fpm.sock;
    }

    location ~ ^/sites/.*/files/styles/ {
      try_files \$uri @rewrite;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
      expires max;
      log_not_found off;
    }
  }
}" | sudo tee /etc/nginx/nginx.conf

# Restart Nginx
sudo systemctl restart nginx

# Install Composer and Drush
cd /usr/share/nginx/html/drupal/
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php
sudo ./composer.phar require --dev drush/drush --no-interaction

# Install Drupal using Drush
sudo ./vendor/bin/drush site-install standard --db-url=mysql://drupaluser:drupalpass@"$x"/drupal --site-name=Example --account-name=drupal --account-pass=drupalpass --yes
sudo chmod 755 sites/ themes/ profiles/ modules/ vendor/ core/
sudo chmod -R 777 sites/default/files/

# Disable Drupal CSS and JS aggregation (optional)
sudo ./vendor/bin/drush -y config-set system.performance css.preprocess 0
sudo ./vendor/bin/drush -y config-set system.performance js.preprocess 0
sudo ./vendor/bin/drush -y theme:enable bartik
sudo ./vendor/bin/drush -y config:set system.theme default bartik

# Install Amazon CloudWatch Agent
sudo apt-get install -y amazon-cloudwatch-agent
sudo aws s3 cp s3://grafana-files-sg/cw-config.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo mkdir -p /usr/share/collectd
sudo touch /usr/share/collectd/types.db
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
sudo systemctl restart amazon-cloudwatch-agent

# Install Git and Prometheus Exporter for Drupal
sudo apt-get install -y git
sudo ./composer.phar require 'drupal/prometheus_exporter:1.x-dev@dev' --no-interaction
sudo sed -i 's/false/true/g' modules/contrib/prometheus_exporter/config/install/prometheus_exporter.settings.yml
sudo ./vendor/bin/drush en prometheus_exporter -y
sudo ./vendor/bin/drush en prometheus_exporter_token_access
