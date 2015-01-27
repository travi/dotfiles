TravisCiStatus = require '../lib/travis-ci-status'

describe "TravisCiStatus", ->
  workspaceElement = null
  beforeEach ->
    spyOn(TravisCiStatus, "isTravisProject").andCallFake((cb) -> cb(true))

    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

  describe "when the travis-ci-status:toggle event is triggered", ->
    workspaceElement = null
    beforeEach ->
      workspaceElement = atom.views.getView(atom.workspace)

      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "git@github.com:test/test.git"
      })

    it "attaches and then detaches the view", ->
      expect(workspaceElement.querySelector(".travis-ci-status")).not.toExist()

      waitsForPromise -> atom.packages.activatePackage('status-bar')
      waitsForPromise -> atom.packages.activatePackage("travis-ci-status")

      runs ->
        expect(workspaceElement.querySelector(".travis-ci-status")).toExist()

  describe "can get the nwo if the project is a github repo", ->
    it "gets nwo of https repo ending in .git", ->
      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "https://github.com/tombell/travis-ci-status.git"
      })

      nwo = TravisCiStatus.getNameWithOwner()
      expect(nwo).toEqual("tombell/travis-ci-status")

    it "gets nwo of https repo not ending in .git", ->
      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "https://github.com/tombell/test-status"
      })

      nwo = TravisCiStatus.getNameWithOwner()
      expect(nwo).toEqual("tombell/test-status")

    it "gets nwo of ssh repo ending in .git", ->
      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "git@github.com:tombell/travis-ci-status.git"
      })

      nwo = TravisCiStatus.getNameWithOwner()
      expect(nwo).toEqual("tombell/travis-ci-status")

    it "gets nwo of ssh repo not ending in .git", ->
      spyOn(atom.project, "getRepo").andReturn({
        getOriginUrl: ->
          "git@github.com:tombell/test-status"
      })

      nwo = TravisCiStatus.getNameWithOwner()
      expect(nwo).toEqual("tombell/test-status")
