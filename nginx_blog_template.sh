cat > .plow/files/nginx_blog.conf <<End-of-file

server {
  listen         80;
  server_name blog.$HOST_NAME;

  client_max_body_size 4G;

  access_log /srv/$APP_NAME/log/blog.access.log;
  error_log /srv/$APP_NAME/log/blog.error.log;

  root /srv/$APP_NAME/public/blog/;
  
  keepalive_timeout 5;
  error_log  /srv/$APP_NAME/log/blog.nginx.error.log;
  access_log  off;

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

  location ~ ^/blog/.*-(.*)\..* {
    gzip_static on;
    expires max;
    add_header ETag $1;
    add_header Cache-Control public;
  }

  location = /favicon.ico {
    expires    max;
    add_header ETag $1;
    add_header Cache-Control public;
  }
}
End-of-file
