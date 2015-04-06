GitIssueView = require './GitIssueView'
request = require 'request'

request = request.defaults
  headers:
    'User-Agent': 'baconscript/github-issues'

GH_REGEX = /^(https:\/\/|git@)github\.com(\/|:)([-\w]+)\/([-\w]+)(\.git)?$/

issuesUrl = (info) ->
  "https://api.github.com/repos/#{info.user}/#{info.repo}/issues?state=all"

getOriginUrl = -> atom.project.getRepo()?.getOriginUrl() or null

isGitHubRepo = ->
  return false unless getOriginUrl()
  m = getOriginUrl().match GH_REGEX
  if m
    {
      user: m[3]
      repo: m[4]
    }
  else
    false

fetchIssues = (callback) ->
  request issuesUrl(isGitHubRepo()), (err, resp, body) ->
    if err
      callback err
    else
      try
        issues = JSON.parse body
        callback null, issues
      catch err
        console.log 'ERR', body
        callback err

module.exports =
  configDefaults:
    username: ''
  activate: ->
    atom.workspaceView.command 'github-issues:list', ->
      if isGitHubRepo()
        atom.workspace.open 'github-issues://list'
      else
        alert 'The current project does not appear to be a GitHub repo.'
    fetchIssues (err, issues) ->
      if err
        console.error err
        alert 'Error opening issues. Is this a public GitHub project?'
      atom.workspace.registerOpener (uri) ->
        return unless uri.match /^github-issues:/
        new GitIssueView
          issues: issues
