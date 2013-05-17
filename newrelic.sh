if dpkg-query -W newrelic-sysmond; then
  echo 'new relic already installed'
else
  wget -O /etc/apt/sources.list.d/newrelic.list http://download.newrelic.com/debian/newrelic.list
  apt-key adv --keyserver hkp://subkeys.pgp.net --recv-keys 548C16BF
  apt-get update
  apt-get install newrelic-sysmond
  nrsysmond-config --set license_key=4dc8354fd66ceb960a78de4266781e6985ea1b02
  /etc/init.d/newrelic-sysmond start
fi