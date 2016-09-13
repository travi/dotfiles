# OSX config

## homebrew

### taps

* [services](https://github.com/Homebrew/homebrew-services)

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
