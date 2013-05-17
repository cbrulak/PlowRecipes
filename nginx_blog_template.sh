echo building blog conf...
cat > files/nginx_blog.conf <<End-of-file

server {
  listen         80;
  server_name blog.$HOST_NAME;

  client_max_body_size 4G;
  
  keepalive_timeout 5;
  #access_log off;
  access_log /srv/blog/$APP_NAME/log/blog.access.log;
  error_log /srv/blog/$APP_NAME/log/blog.error.log;

  root /srv/$APP_NAME/public/blog/;
  
  try_files \$uri/index.html \$uri.html \$uri @app;
  error_page 502 503 =503                  @maintenance;
  error_page 500 504 =500                  @server_error;

  location @maintenance {
    root /srv/$APP_NAME/public;
    try_files /503.html =503;
  }

  location @server_error {
    root /srv/$APP_NAME/public;
    try_files /500.html =500;
  }

  location @app {
    gzip_static on;
    expires max;
  }
  
  location ~ ^/assets/.*-(.*)\..* {
    gzip_static on;
    expires max;
  }
  
  location ~ ^/stylesheets/.*-(.*)\..* {
    gzip_static on;
    expires max;
  }

  location = /favicon.ico {
    expires    max;
  }
}
End-of-file
