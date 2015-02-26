fs = require 'fs'
yaml = require 'js-yaml'
linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"

class LinterJsYaml extends Linter
  # The syntax that the linter handles. May be a string or
  # list/tuple of strings. Names should be all lowercase.
  @syntax: ['source.yaml']

  # A string, list, tuple or callable that returns a string, list or tuple,
  # containing the command line (with arguments) used to lint.
  cmd: 'js-yaml.js'

  executablePath: null

  linterName: 'js-yaml'

  isNodeExecutable: yes

  errorStream: 'stderr'

  # A regex pattern used to extract information from the executable's output.
  regex: 'JS-YAML: (?<message>.+) at line (?<line>\\d+), column (?<col>\\d+):'

  constructor: (editor) ->
    super(editor)

    atom.config.observe 'linter-js-yaml.jsYamlExecutablePath', =>
      @executablePath = atom.config.get 'linter-js-yaml.jsYamlExecutablePath'

  lintFile: (filePath, callback) ->
    fs.readFile filePath, 'utf8', (err, data) =>
      messages = []

      try
        yaml.safeLoad data, onWarning: (error) ->
          messages.push error.message
        @processMessage messages, callback
      catch e
        super(filePath, callback)

  createMessage: (match) ->
    if match.message.startsWith('unknown tag')
      match.warning = true

    super(match)

  destroy: ->
    atom.config.unobserve 'linter-js-yaml.jsYamlExecutablePath'

module.exports = LinterJsYaml
