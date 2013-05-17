# Install unicorn-friendly vhost
#
# $APP_NAME - app_name
#
# requires:
#   nginx

rm -f /opt/nginx/sites-available/$APP_NAME.nginx_blog.conf
cp ~/plow/files/$APP_NAME.nginx_blog.conf /opt/nginx/sites-available/$APP_NAME.nginx_blog.conf
ln -sf /opt/nginx/sites-available/$APP_NAME.nginx_blog.conf /opt/nginx/sites-enabled/$APP_NAME.nginx_blog.conf

restart nginx
