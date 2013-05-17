# Install default ruby
#
# Based on http://blog.arkency.com/2012/11/one-app-one-user-one-ruby/
#
# $RUBY_VER - ruby-version
# $APP_NAME - deployer

# Install ruby-build
if which ruby-build ; then
  echo 'ruby-build already installed'
else
  mkdir -p /usr/local/sources
  git clone git://github.com/sstephenson/ruby-build.git /usr/local/sources/ruby-build
  (cd /usr/local/sources/ruby-build && ./install.sh)
fi

# Install ruby
if test -d "/home/$APP_NAME/$RUBY_VER" ; then
  echo "ruby-$RUBY_VER already installed"
else
  ruby-build $RUBY_VER /home/$APP_NAME/$RUBY_VER
fi

# Update path
if grep -xq "export PATH=\$HOME/$RUBY_VER/bin:\$PATH" /home/$APP_NAME/.bashrc ; then
  echo 'Path already includes ruby'
else
  sed -i "1i export PATH=\$HOME/$RUBY_VER/bin:\$PATH" /home/$APP_NAME/.bashrc
fi

# Install bundler
if /home/$APP_NAME/$RUBY_VER/bin/gem list | grep -q bundler ; then
  echo "bundler already installed"
else
  /home/$APP_NAME/$RUBY_VER/bin/gem install bundler --no-ri --no-rdoc
fi

#ln ruby-local-exec
ln -s /home/$APP_NAME/$RUBY_VER/bin/ruby /usr/local/bin/ruby-local-exec
ln -fs /home/$APP_NAME/$RUBY_VER/bin/ruby /usr/bin/ruby