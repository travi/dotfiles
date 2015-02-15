# Scoped Property Store [![Build Status](https://travis-ci.org/atom/scoped-property-store.svg?branch=master)](https://travis-ci.org/atom/scoped-property-store)

Stores and retrieves properties associated with CSS selectors.

Currently, this library only supports the combinations of the following
elements. More could be added pretty easily.

* Element names: `div`
* Class names: `.foo`
* Simple attributes: `[foo=bar]`
* Descendant selectors: `.foo .bar`
* Child selectors: `.foo > .bar`

Usage:

```coffee
ScopedPropertyScore = require 'scoped-property-store'
store = new ScopedPropertyScore

# First associate some properties with selectors
disposable = store.addProperties 'some-description',
  '.foo.bar .baz':
    x:
      y: 1
      z: 2

  '.foo':
    x:
      y: 3

# Then query properties based on a string description of a path in the DOM.
store.get('div.foo.bar p.baz', 'x.y') # ==> 1
store.get('div.foo.bar p.baz', 'x.z') # ==> 2

# Falls back to selectors matching an *ancestor* if necessary
store.get('div.foo p.baz', 'x.y') # ==> 3

# You can also remove properties via the returned Disposable
disposable.dispose()
```
