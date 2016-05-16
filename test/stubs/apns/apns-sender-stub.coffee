module.exports = () ->

  sendStub = null

  class ApnsSender

    constructor: (authorization) ->
      return

    send: ->
      sendStub()

  ApnsSender: ApnsSender

  setSendStub: (s) ->
    sendStub = s
