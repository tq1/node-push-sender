module.exports = (apns) ->

  class ApnsMessage

    constructor: (message, data, extras) ->
      @message = message
      @data = data
      @extras = extras

    build: ->
      payload =
        category: @extras?.category
        sound: @extras?.sound
        "content-available": @extras?.contentAvailable
        alert:
          body: @message
          title: @extras?.title

      for own key, value of @data
        payload[key] = value

      content = new apns.Notification payload

      content.priority = @extras?.priority
      content.expiry = @extras?.ttl

      return content
