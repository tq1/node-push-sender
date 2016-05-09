module.exports = do ->

  json = null
  error = null
  response = null

  class Message

    constructor: (j) ->
      return

    addData: (key, value) ->
      return

    toJson: ->
      return json

  class Sender

    constructor: (auth) ->
      return

    send: (content, targets, done) ->
      done error, response

  Message: Message

  Sender: Sender

  setJson: (j) ->
    json = j

  setError: (e) ->
    error = e

  setResponse: (r) ->
    response = r
