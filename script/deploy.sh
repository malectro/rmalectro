cd /var/www/sites/%app_name%
git pull
rake assets:precompile
sudo /etc/init.d/httpd restart
