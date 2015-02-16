module.exports =
  configDefaults:
    puppetLintArguments: '--no-autoloader_layout-check'
    puppetLintExecutablePath: null

  activate: ->
    console.log 'activate linter-puppet-lint'
