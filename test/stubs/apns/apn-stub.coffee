module.exports = do ->

  json = null
  error = null
  response = null
  events = require "events"

  class Notification

    constructor: (j) ->
      return

    setAlertText: (message) ->
      return

    toJson: ->
      return json

  class Provider

    constructor: (auth) ->
      return

    send: (content, targets) ->
      res =
        success: []
        failure: []
      return res

    shutdown: ->
      return

  Notification: Notification

  Provider: Provider

  setJson: (j) ->
    json = j

  setError: (e) ->
    error = e

  setResponse: (r) ->
    response = r
