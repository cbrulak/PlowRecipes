echo building nginx.conf...
cat > ../files/nginx.conf <<End-of-file
upstream app_server {
  server unix:/srv/$APP_NAME/tmp/sockets/unicorn.sock fail_timeout=0;
}

server {
   listen         80;
   server_name    $HOST_NAME;
   return 301 https://www.$host$1;
}


server {
   listen         80;
   server_name    www.$HOST_NAME;
   return 301 https://www.$host$1;
}

server {
   listen         443 ssl;
   server_name    $HOST_NAME;
   ssl_certificate      /opt/nginx/certs/$APP_NAME/thedomain.pem;
   ssl_certificate_key  /opt/nginx/certs/$APP_NAME/myserver.key;
   return 301 https://www.$host$1;
}


server {
  server_name *.$HOST_NAME www.$HOST_NAME $SUB_HOST_NAME;

  client_max_body_size 4G;

  access_log /srv/$APP_NAME/log/access.log;
  error_log /srv/$APP_NAME/log/error.log;

  root /srv/$APP_NAME/public/;
  
  keepalive_timeout 5;
  error_log  /srv/$APP_NAME/log/nginx.error.log;
  access_log  off;

  listen 443 ssl spdy default_server;

  ssl_certificate      /opt/nginx/certs/$APP_NAME/thedomain.pem;
  ssl_certificate_key  /opt/nginx/certs/$APP_NAME/myserver.key;
  

  try_files \$uri/index.html \$uri.html \$uri @app;
  error_page 502 503 =503                  @maintenance;
  error_page 500 504 =500                  @server_error;

  location @app {
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header Host \$http_host;
    proxy_redirect off;

    # enable this if and only if you use HTTPS, this helps Rack
    # set the proper protocol for doing redirects:
    # proxy_set_header X-Forwarded-Proto https;

    proxy_pass http://app_server;
  }

  location @maintenance {
    root /srv/$APP_NAME/public;
    try_files /503.html =503;
  }

  location @server_error {
    root /srv/$APP_NAME/public;
    try_files /500.html =500;
  }

  location ~ ^/assets/.*-(.*)\..* {
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
