# Install deploy user
#
# $1 - deploy_user
# $2 - ssh_key_file

useradd --create-home --shell /bin/bash --user-group --groups sudo $1

mkdir -p /home/$1/.ssh
touch /home/$1/.bashrc
cp files/authorized_keys /home/$1/.ssh/authorized_keys
cp files/known_hosts /home/$1/.ssh/known_hosts
chmod 700 /home/$1/.ssh
chmod 600 /home/$1/.ssh/authorized_keys
chown -R $1:$1 /home/$1/.ssh
chown -R $1:$1 /home/$1/
mkdir -p /srv

cat `export RUBY=/home/$1/1.9.3-p194/bin/ruby` >> /home/$1/.bashrc

echo $1 ALL=\(ALL\) NOPASSWD:ALL >> /etc/sudoers