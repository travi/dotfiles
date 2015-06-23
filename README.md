My dotfiles
========

[![Build Status](http://img.shields.io/travis/travi/dotfiles.svg?style=flat)](https://travis-ci.org/travi/dotfiles)

My disaster recovery plan.

## Purpose

This repository contains most of my base configuration for unix-based machines, but is primarily focused on OSX. These
files make it simple to configure a new machine from scratch as well as keep it up-to-date over time.

## Installation
### Prerequisites
* `git` must be installed

### Command
```
git clone https://github.com/travi/dotfiles.git && cd dotfiles/setup/ && source init.sh
```

## What does it do?

By running the `setup/init.sh` file, it:
* installs [Homebrew](http://brew.sh/) if on OSX
* creates a symlink in the home directory for the repository for easy access
* symlinks all of the dotfiles from the directories to the home directory
* installs the applications defined in the `Brewfile` and `Caskfile` if run on OSX

By including the `source.sh` file from the `bash` directory into the `.bash_profile`:
* common environment variables are defined
* common aliases are defined
* the prompt gets customized

By running the `osx/environment.sh` file, it:
* configures a large number of osx environment settings

## Influences

Strongly influenced by:
* https://github.com/mathiasbynens/dotfiles
* https://github.com/cowboy/dotfiles
