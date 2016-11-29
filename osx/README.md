# OSX config

## homebrew

### find details on a package
http://brewformulas.org

### taps

* [services](https://github.com/Homebrew/homebrew-services)
    * `brew services list` provides a list of available servies and their status
    * `brew services [start|stop] <service-name>`


### pinning a specific version

pin a formula to the current version
```
$ brew pin <formula>
```

list pinned formulae
```
$ brew ls --pinned
```

determine version that was pinned
```
$ brew info <formula>
```

switch to another version
```
$ brew switch <formula> <version #>
