module.exports = (apns) ->

  class ApnsMessage

    constructor: (message, data, extras) ->
      @message = message
      @data = data
      @extras = extras

    build: ->
      content = new apns.notification()

      content.setAlertText @message
      content.badge = 1
      content.sound = "default"
      if @extras?.contentAvailable?
        content.contentAvailable = @extras.contentAvailable
      else
        content.contentAvailable = 1
      content.payload = @data

      content.priority = @extras.priority if @extras?.priority?
      content.expiry = @extras.timeToLive if @extras?.timeToLive?

      return content
