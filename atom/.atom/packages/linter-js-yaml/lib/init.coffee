path = require 'path'

module.exports =
  configDefaults:
    jsYamlExecutablePath: path.join __dirname, '..', 'node_modules', 'js-yaml', 'bin'

  activate: ->
    console.log 'activate linter-js-yaml'
