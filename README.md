My dotfiles
========

My disaster recovery plan.

## Purpose

This repository contains most of my base configuration for unix-based machines, but is primarily focused on OSX. These files make it simple to configure a new machine from scratch as well as keep it up-to-date over time.

## Installation
### Prerequisites
* `git` must be installed
* `brew` must be installed on OSX

### Command
```
bash -c "$(git clone https://github.com/travi/dotfiles.git)" && cd dotfiles/ && ./bootstrap.sh
```

## What does it do?

By running the `bootstrap.sh` file, it:
* symlinks all of the dotfiles from the directories to the home directory
* installs the applications defined in the `Brewfile` and `Caskfile` if run on OSX

By including the `source.sh` file from the `bash` directory into the `.bash_profile`:
* common environment variables are defined
* common aliases are defined
* the prompt gets customized

By running the `osx/osx.sh` file, it:
* configures a bunch of osx level things
