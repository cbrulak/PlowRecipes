# Install deploy user
#
# $1 - deploy_user
# $2 - ssh_key_file

useradd --create-home --shell /bin/bash --user-group --groups sudo $APP_NAME

mkdir -p /home/$APP_NAME/.ssh
touch /home/$APP_NAME/.bashrc
cp files/authorized_keys /home/$APP_NAME/.ssh/authorized_keys
cp files/known_hosts /home/$APP_NAME/.ssh/known_hosts
chmod 700 /home/$APP_NAME/.ssh
chmod 600 /home/$APP_NAME/.ssh/authorized_keys
chown -R $APP_NAME:$APP_NAME /home/$APP_NAME/.ssh
chown -R $APP_NAME:$APP_NAME /home/$APP_NAME/
mkdir -p /srv

cat `export RUBY=/home/$1/1.9.3-p194/bin/ruby` >> /home/$APP_NAME/.bashrc

echo $APP_NAME ALL=\(ALL\) NOPASSWD:ALL >> /etc/sudoers