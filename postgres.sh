# Install postgresql
#
# $1 - db_user
# $2 - db_password
# $3 - db_name

if dpkg-query -W postgresql-9.2 ; then
  echo 'postgresql already installed'
else
  apt-get -y install software-properties-common
  apt-get -y install python-software-properties
  add-apt-repository ppa:pitti/postgresql
  apt-get -y update
  apt-get -y install postgresql-9.2 libpq-dev
fi

# if psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='$1'" | grep -q 1
#   echo 'database user already exists'
# else
  echo "setting up db roles: '$1' '$2' '$3'"
  echo "CREATE USER $1 WITH PASSWORD '$2';" | sudo -u postgres psql
  echo "CREATE DATABASE $3 OWNER $1;" | sudo -u postgres psql
  echo "GRANT ALL PRIVILEGES ON DATABASE $3 to $1;" | sudo -u postgres psql
# fi




# reference:
#
# sudo -u postgres psql
#  echo "CREATE USER dev WITH PASSWORD 'development' SUPERU