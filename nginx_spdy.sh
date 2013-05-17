# Install nginx from source and the SPDY patch


if test -x /opt/nginx/sbin/nginx ; then
  echo 'nginx already installed'
else
  apt-get -y install libpcre3 libpcre3-dev libpcrecpp0 zlib1g-dev libc6 libpcre3 libpcre3-dev libpcrecpp0 libssl0.9.8 libssl-dev zlib1g zlib1g-dev lsb-base

  rm -rf /usr/local/build/nginx-1.3.11

  mkdir -p /usr/local/nginx && mkdir -p /usr/local/build && mkdir -p /usr/local/sources

  wget -cq --directory-prefix='/usr/local/sources' http://nginx.org/download/nginx-1.3.11.tar.gz
  tar xzf /usr/local/sources/nginx-1.3.11.tar.gz -C /usr/local/build

  # Fetch and apply the Nginx SPDY patch
  (cd /usr/local/build/nginx-1.3.11 && wget http://nginx.org/patches/spdy/patch.spdy-55_1.3.11.txt && patch -p1 < patch.spdy-55_1.3.11.txt)

  (cd /usr/local/build/nginx-1.3.11 && ./configure --with-cc-opt=-Wno-warn --prefix=/opt/nginx --user=nginx --group=nginx  --with-http_ssl_module --with-http_spdy_module --with-http_gzip_static_module --with-openssl=/usr/local/build/openssl-1.0.1c && make && make install )
  adduser --system --no-create-home --disabled-login --disabled-password --group nginx


fi

if test -e /etc/init/nginx.conf ; then
  echo 'nginx upstart already installed'
else
  cp ~/sunzi/files/nginx.init.conf /etc/init/nginx.conf
  restart nginx
fi

if test -d /opt/nginx/sites-available && test -d /opt/nginx/sites-enabled ; then
  echo 'sites-available and sites-enabled already installed'
else
  mkdir -p /opt/nginx/sites-available
  mkdir -p /opt/nginx/sites-enabled
  rm /opt/nginx/conf/nginx.conf
  cp ~/sunzi/files/nginx.conf /opt/nginx/conf/nginx.conf
fi

cp ~/sunzi/files/*.nginx.conf /opt/nginx/sites-enabled/
mkdir -p /opt/nginx/certs
mkdir -p /opt/nginx/certs/$1
cp ~/sunzi/files/thedomain.pem /opt/nginx/certs/$1/thedomain.pem
cp ~/sunzi/files/myserver.key  /opt/nginx/certs/$1/myserver.key
restart nginx

