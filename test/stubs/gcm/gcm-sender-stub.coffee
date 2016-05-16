module.exports = () ->

  sendStub = null

  class GcmSender

    constructor: (authorization) ->
      return

    send: ->
      sendStub()

  GcmSender: GcmSender

  setSendStub: (s) ->
    sendStub = s
