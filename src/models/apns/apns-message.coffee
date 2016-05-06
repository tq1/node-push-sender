module.exports = (apns) ->

  class ApnsMessage

    constructor: (message, data, extras) ->
      @message = message
      @data = data
      @extras = extras

    build: ->
      content = new apns.Notification()

      content.setAlertText @message
      content.badge = 1
      content.sound = "default"

      content.priority = @extras.priority if @extras?.priority?
      content.expiry = @extras.ttl if @extras?.ttl?

      return content
