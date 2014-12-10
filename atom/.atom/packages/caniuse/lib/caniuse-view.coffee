{SelectListView, TextEditorView, $} = require 'atom'
{exec} = require('child_process')
{markdown} = require('markdown')
open = require 'open'


# infos =
#   y: 'Yes, supported by default'
#   a: 'Almost supported (aka Partial support)'
#   u: 'Support unknown'
#   x: 'Requires prefix to work'
#   p: 'No support, but has Polyfill'
#   n: 'No support, or disabled by default'
#   d: 'Disabled by default (need to enable flag or something)'


repeat = (str, num) -> new Array(Number(num) + 1).join(str)

module.exports =
class AtomCaniuseView extends SelectListView
  @content: ->
    @div class: 'select-list no-data', =>
      @subview 'filterEditorView', new TextEditorView(mini: true)
      @div class: 'error-message', outlet: 'error'
      @div class: 'loading', outlet: 'loadingArea', =>
        @span class: 'loading-message', outlet: 'loading'
        @span class: 'badge', outlet: 'loadingBadge'
      @ol class: 'list-group', outlet: 'list'
      @table =>
        @thead outlet: 'head'
        @tbody outlet: 'table'
      @div class: 'notes', outlet: 'notes'

  data: null

  getFilterKey: -> 'title'

  initialize: (serializeState) ->
    @addClass('overlay from-top caniuse-view')
    super

  loadData: ->
    @setLoading('Loading data...')
    @data = null

    try
      @data = JSON.parse localStorage['caniuse:data']

    if not @data or not @data.data
      atom.workspaceView.trigger 'can-i-use:update'
      @addClass 'no-data'
      return no

    @removeClass 'no-data'
    return yes

  viewForItem: (item) ->
    "<li>#{item.title}</li>"

  confirmed: (item) ->
    open("http://caniuse.com/#feat=#{item.key}");
    @cancel()

  selectItemView: (view) ->
    super(view)

    agentKeys = Object.keys(@data.agents)
      .filter (key) ->
        confKey = 'show' + key.replace(/(^|_)([a-z])/g, (m) ->
          m.replace(/^_/, '').toUpperCase()
        )
        return atom.config.get("caniuse.#{confKey}")

    item = @getSelectedItem()

    @head.html('')
    tr = $('<tr>')

    countCls = 'agents-count-' + agentKeys.length

    agentKeys
      .forEach (key) =>
        tr.append($('<th>')
          .text(@data.agents[key].abbr))
          .addClass countCls
    @head.append(tr)

    @table.html('')

    needNotes = []

    i = 0
    while true
      tr = $('<tr>')
      agentKeys
        .forEach (key) =>
          agent = @data.agents[key]
          version = agent.versions[agent.versions.length - i] or ''

          support = String(item.stats[key][version])

          td = $('<td>').text(version)

          # console.log(support, item.notes_by_num)
          hasNote = support.match(/\s#(\d+)$/)
          if hasNote
            td.append $('<span>').text(hasNote[1])
            support = support.replace /\s#(\d+)$/g, ''
            needNotes.push hasNote[1]

          # hasInfo = support.match(/\s([a-z]$)$/)
          # if hasInfo
          #   support = support.replace /\s[a-z]$/g, ''
          #   info = infos[hasInfo[1]]
          #   console.log hasInfo[1], info

          # support = support.replace /\s.*/g, ''

          supportKeys = support.split(/\s/g)

          if version
            td.addClass('is-unsupported')

          supportKeys
            .forEach (supportKey) =>
              # y - (Y)es, supported by default
              if supportKey is 'y'
                td.removeClass('is-unsupported')
                td.addClass('is-supported')

              # a - (A)lmost supported (aka Partial support)
              else if supportKey is 'a'
                td.removeClass('is-unsupported')
                td.addClass('is-almost-supported')

              else if supportKey is 'x'
                td.addClass('requires-prefix')

              # u - Support (u)nknown
              # x - Requires prefi(x) to work
              # p - No support, but has (P)olyfill
              # n - (N)o support, or disabled by default
              # d - (D)isabled by default (need to enable flag or something)

          tr.append(td)

      @table.prepend(tr)

      break unless i++ < 10

    notes = []
    notes.push(markdown.toHTML(item.notes)) if item.notes

    notesByNumber = Object.keys(item.notes_by_num)
      .filter (i) => needNotes.indexOf(i) isnt -1
      .map (i) => markdown.toHTML("#{i} #{item.notes_by_num[i]}")

    notes = notes.concat(notesByNumber)

    @notes
      .html('')
      .append(notes)

  # cancel: -> console.log 'mööp'

  populateList: ->
    super()
    if @list.is(':empty')
      @head.empty()
      @table.empty()
      @notes.empty()

  populate: ->
    if @loadData()
      rows = Object.keys(@data.data)
        .map (key) =>
          row = @data.data[key]
          row.key = key
          return row

      @setItems rows

  show: ->
    @populate()
    atom.workspaceView.append(this)
    @focusFilterEditor()
