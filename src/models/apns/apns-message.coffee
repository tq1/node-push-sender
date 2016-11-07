module.exports = (apns) ->

  class ApnsMessage

    constructor: (message, data, extras) ->
      @message = message
      @data = data
      @extras = extras

    build: ->
      content = new apns.Notification()

      content.alert = @message
      content.badge = 1
      content.sound = "default"
      if @extras?.contentAvailable?
        content.contentAvailable = @extras.contentAvailable
      else
        content.contentAvailable = 1
      if @data?.actionId?
        content.category =  @data.actionId
        delete @data.actionId
      content.payload = @data

      content.priority = @extras.priority if @extras?.priority?
      content.expiry = @extras.timeToLive if @extras?.timeToLive?
      content.topic = @extras.topic if @extras?.topic?

      return content
