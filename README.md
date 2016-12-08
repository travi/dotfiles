My .files
=========

[![Build Status](http://img.shields.io/travis/travi/dotfiles.svg?style=flat)](https://travis-ci.org/travi/dotfiles)
[![Code Climate](https://img.shields.io/codeclimate/github/travi/dotfiles.svg)](https://codeclimate.com/github/travi/dotfiles)

My disaster recovery plan.

## Purpose

This repository contains most of my base configuration for bash shells, but is primarily focused on OSX. These files make it simple to configure a new machine
from scratch as well as keep it up-to-date over time.

## Installation
### Prerequisites
* `git` must be installed
* `bash` should be configured as the preferred shell

### Command
```
git clone https://github.com/travi/dotfiles.git && cd dotfiles/setup/ && source init.sh
```

## What does it do?

### System Bootstrapping

`setup/init.sh` presents two options:

* Environment configuration
* Software Installation/Update

#### Environment Configuration
* Creates a symlink for `~/.dotfiles` in the home directory
* Symlinks dotfiles from each folder under `~/.dotfiles` into the home directory
* Symlinks dotfiles from each folder under `~/.dotfiles.extra` into the home directory
* Symlinks maven plugins into global plugins directory
* Symlinked `.bash_profile` sources several files in order to:
    * Define environment variables
    * Define aliases
    * Enable my custom prompt
    * Source additional files from `~/.dotfiles/osx/` and `~/.dotfiles/windows/`
    * Source `~/.dotfiles.extra/bash/source.sh`


##### OSX
 * Configures OSX defaults

#### Software Installation/Update
* Updates global NPM packages
* Installs/Updates VIM plugins

##### OSX
* Installs [Homebrew](http://brew.sh/)
* Installs the applications defined in:
    * `~/.dotfiles/osx/Brewfile`
    * `~/.dotfiles.extra/osx/Brewfile`

## Supported Environments
The following environments are the ones that this configuration has been tested
in by me, in order from most often to least often used.

* Terminal.app on OSX (Yosemite is my primary)
* GitBash on Windows
* SSH sessions into Ubuntu

## Influences

Strongly influenced by:

* https://github.com/mathiasbynens/dotfiles
* https://github.com/cowboy/dotfiles
