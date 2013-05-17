# git

if dpkg-query -W  git-core; then
  echo 'git already installed'
else
  apt-get -y install git-core
fi