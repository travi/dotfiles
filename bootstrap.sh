#!/bin/bash

info () {
	  printf "  [ \033[00;34m..\033[0m ] $1"
}

info 'Brew bundle'
brew bundle
