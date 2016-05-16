module.exports = do ->

  json = null
  error = null
  response = null
  events = require "events"

  class notification

    constructor: (j) ->
      return

    setAlertText: (message) ->
      return

    toJson: ->
      return json

  class connection

    constructor: (auth) ->
      return

    pushNotification: (content, targets) ->
      return

    shutdown: ->
      return

    on: (event, callback) ->
      callback()
      return

  notification: notification

  connection: connection

  setJson: (j) ->
    json = j

  setError: (e) ->
    error = e

  setResponse: (r) ->
    response = r
