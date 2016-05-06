module.exports = (GcmMessage, GcmSender, ApnsMessage, ApnsSender) ->

  send: (authorization, target, message, data, extras, done) ->
    apnsRegex = /[0-9A-Fa-f]{64}/g
    if target? and apnsRegex.test target
      content = new ApnsMessage(message, data, extras).build()
      sender = new ApnsSender authorization
    else
      content = new GcmMessage(message, data, extras).build()
      sender = new GcmSender authorization

    sender.send content, target, done
