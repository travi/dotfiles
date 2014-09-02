#!/bin/sh

. ./functions.sh

. ../osx/apps.sh

heading 'Bundle Install'
gem install bundler
gem update --system
gem update
bundle install --gemfile=$HOME/.dotfiles/ruby/Gemfile
