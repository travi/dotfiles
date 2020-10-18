# My .files

[![Build Status](http://img.shields.io/travis/com/travi/dotfiles.svg?style=flat)](https://travis-ci.com/travi/dotfiles)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/travi/dotfiles.svg)](https://codeclimate.com/github/travi/dotfiles)

My disaster recovery plan.

## Purpose

This repository contains most of my base configuration for bash shells, but is
primarily focused on OSX. These files make it simple to configure a new machine
from scratch as well as keep it up-to-date over time.

## Installation

### Prerequisites

* `git` must be installed
* `bash` should be configured as the preferred shell

### Command

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/travi/dotfiles/master/setup/bootstrap.sh)"
```

## What does it do?

### System Bootstrapping

`setup/init.sh` presents two options:

* Environment configuration
* Software Installation/Update

#### Environment Configuration

* Creates a symlink for `~/.files` in the home directory
* Symlinks dotfiles from each folder under `~/.files` into the home directory
* Symlinks dotfiles from each folder under `~/.files.extra` into the home directory
* Symlinks maven plugins into global plugins directory
* Symlinked `.bash_profile` sources several files in order to:
  * Define environment variables
  * Define aliases
  * Enable my custom prompt
  * Source additional files from `~/.files/osx/` and `~/.files/windows/`
  * Source `~/.files.extra/bash/source.sh`

##### macOS

* Configures OSX defaults

#### Software Installation/Update

* Updates global NPM packages
* Installs/Updates VIM plugins

##### macOS Software

* Installs [Homebrew](http://brew.sh/)
* Installs the applications defined in:
  * `~/.files/osx/Brewfile`
  * `~/.files.extra/osx/Brewfile`

## Supported Environments

The following environments are the ones that this configuration has been tested
in by me, in order from most often to least often used.

* Terminal.app on macOS (Catalina is my primary)
* SSH sessions into Ubuntu
* GitBash on Windows

## Verification

### Execute

With [Vagrant](https://www.vagrantup.com/) available, you can run the full
verification locally:

```sh
rake --rakefile=test/Rakefile
```

If Vagrant isn't installed, or you want to only run the lint checks:

```sh
rake --rakefile=test/Rakefile lint
```

#### Automatically

The [provided config file](./pre-commit-config.yaml) defines tasks for the
[pre-commit tool](https://pre-commit.com/)

##### as a `pre-commit` hook

Run `pre-commit install` to install the tool into the git hooks for this
project. Update to the latest version of the config by running
`pre-commit autoupdate`.

##### manually through the cli

`pre-commit run --all-files`

### What's included

* Lint

  * Shellcheck for shell scripts
  * Markdownlint for markdown files

* Behavioral tests

  * TestKitchen to verify that a fresh machine would be configured appropriately
    (coverage is sparse for these tests at this point)

## Influences

Strongly influenced by:

* <https://github.com/mathiasbynens/dotfiles>
* <https://github.com/cowboy/dotfiles>
