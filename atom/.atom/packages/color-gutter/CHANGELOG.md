## 0.4.1 (02/04/2015)

Bugs:

* Fixed `package.json` `engines.atom` requirement

## 0.4.0 (02/04/2015)

Bugs:

* Use `atom-text-editor::shadow` as well as `atom-text-editor`
* Use `box-sizing: border-box` for gutter width
* Use `CompositeDisposable` instead of 'emissary', remove dependency
* Update config spec
* Use `CommandRegistry`
* Use `atom.workspace.observeTextEditors` instead of `atom.workspaceView.eachEditorView`
* Use native JS instead of jQuery to set color

## 0.3.2 (17/03/2015)

Bugs:

* Use `atom-workspace` instead of `workspace` class
* Use `atom-text-editor` instead of `editor` class

## 0.3.1 (05/08/2014)

Bugs:

* Fix markers showing on the wrong line when code blocks were folded
* Improve handling of ignore commented lines setting

Documentation:

* Minor updates

## 0.3.0 (04/08/2014)

Features:

* Add setting to ignore commented lines

Bugs:

* Fixed end of pattern detection for hex regex pattern

Documentation:

* Add details to README.md
* Update screenshot to gif to show mouse hover effect

## 0.2.1 (02/08/2014)

Bugs:

* Fixed issues with regular expressions

Documentation:

* Add screenshot

## 0.2.0 (02/08/2014)

Features:

* Detect rgb/a and hsl/a colours

## 0.1.0 (01/08/2014)

Features:

* Initial version with simple hex pattern recognition
* Expand swatch on mouse hover
