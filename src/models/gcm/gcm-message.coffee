module.exports = (gcm) ->

  class GcmMessage

    constructor: (message, data, extras) ->
      @message = message
      @data = data
      @extras = extras

    build: ->
      content = new gcm.Message
        collapseKey: @extras?.collapseKey
        priority: @extras?.priority
        contentAvailable: @extras?.contentAvailable
        delayWhileIdle: @extras?.delayWhileIdle
        timeToLive: @extras?.timeToLive
        restrictedPackageName: @extras?.restrictedPackageName
        dryRun: @extras?.dryRun
        data:
          text: @message

      for own key, value of @data
        content.addData key, value

      return content
