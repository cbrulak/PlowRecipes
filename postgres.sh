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
  echo "setting up db roles: '$DB_USER' '$DB_PASS' '$DB_NAME'"
  echo "CREATE USER $DB_USER WITH PASSWORD '$DB_PASS';" | sudo -u postgres psql
  echo "CREATE DATABASE $DB_NAME OWNER $DB_USER;" | sudo -u postgres psql
  echo "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME to $DB_USER;" | sudo -u postgres psql
# fi




# reference:
#
# sudo -u postgres psql
#  echo "CREATE USER dev WITH PASSWORD 'development' SUPERU