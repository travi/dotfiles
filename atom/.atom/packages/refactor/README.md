# Refactor Package [![Build Status](https://travis-ci.org/minodisk/refactor.svg?branch=master)](https://travis-ci.org/minodisk/refactor)

Let's refactor code! With this package, you can rename the name of variables and functions easily.

![capture_rename](https://cloud.githubusercontent.com/assets/514164/2929354/b4e848d4-d788-11e3-99c2-620f406d5e6f.gif)

## Language plugins

This package works with these plugins. You can install using the Preferences pane.

* [coffee-refactor](https://atom.io/packages/coffee-refactor) for CoffeeScript
* [js-refactor](https://atom.io/packages/js-refactor) for JavaScript

## Usage

1. Set cursor to a symbol.
2. Start renaming by using `ctrl-alt-r`.
3. Type new name.
4. Finish renaming by using `enter` or removing cursor from the focused symbol.

## User setting

* Override [keymap](kaymaps/refactor.cson) by using `Atom > Open Your Keymap`.
* Override [stylesheet](stylesheets/refactor.less) by using `Atom > Open Your Stylesheet`.

## API Documentation (for plugin developer)

### Interface

Implement `Ripper` class in main module.

* `Ripper.scopeNames []String` : **[Required]** Array of scope name, like 'source.coffee', 'source.js' and all that.
* `Ripper#parse(code String, callback Function)` : **[Required]** Parse code, and you should callback when the parsing process is done. Callback specify the params error object.
* `Ripper#find(range Range, editor Editor) []Range` : **[Required]** Array of found symbol's `Range`.
* `Ripper#constructor(editor)` : **[Optional]** Pass the target `Editor`.
* `Ripper#destruct()` : **[Optional]** Delete every reference.

Add `refactor` as `engines` in `package.json`.

```
{
  ...
  "engines": {
    "atom": ">0.50.0",
    "refactor": "*"
  },
  ...
}
```



See [minodisk/coffee-refactor](https://github.com/minodisk/coffee-refactor) or [minodisk/js-refactor](https://github.com/minodisk/js-refactor).
