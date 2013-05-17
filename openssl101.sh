if test -x /usr/local/ssl/bin/openssl ; then
  echo 'openssl 1.0.1 already installed'
else
  echo 'Downloading openssl 1.0.1'
  apt-get -y install libpcre3 libpcre3-dev libpcrecpp0 zlib1g-dev
  #apt-get -y remove openssl

  mkdir -p mkdir -p /usr/local/build && mkdir -p /usr/local/sources && mkdir -p /usr/local/openssl

  wget -cq --directory-prefix='/usr/local/sources' http://www.openssl.org/source/openssl-1.0.1c.tar.gz
  tar xzf /usr/local/sources/openssl-1.0.1c.tar.gz -C /usr/local/build
  #cd /usr/local/build/openssl-1.0.1c

  #(./config threads zlib --prefix=/usr && make && make test && make install )
fi