#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

heading 'Brew bundle'
brew doctor
brew bundle $HOME/.dotfiles/osx/Brewfile

heading 'Brew Cask bundle'
brew bundle $HOME/.dotfiles/osx/Caskfile

heading 'Bundle Install'
gem install bundler
gem update --system
gem update
bundle install --gemfile=$HOME/.dotfiles/ruby/Gemfile
gem cleanup
