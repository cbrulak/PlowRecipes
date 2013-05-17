# Install unicorn-friendly vhost
#
# $APP_NAME - app_name
# requires:
#   nginx

rm -f /opt/nginx/sites-available/$APP_NAME.nginx.conf
cp ~/plow/files/nginx.conf /opt/nginx/sites-available/$APP_NAME.nginx.conf
ln -sf /opt/nginx/sites-available/$APP_NAME.nginx.conf /opt/nginx/sites-enabled/$APP_NAME.nginx.conf
cp ~/plow/files/*.pem /opt/nginx/certs/$APP_NAME/
cp ~/plow/files/*.key /opt/nginx/certs/$APP_NAME/

restart nginx
