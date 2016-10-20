module.exports = (GcmMessage, GcmSender, ApnsMessage, ApnsSender) ->

  send: (authorization, target, message, data, extras, done) ->
    if target? and target.platform is 'ios'
      content = new ApnsMessage(message, data, extras).build()
      sender = new ApnsSender authorization
    else
      content = new GcmMessage(message, data, extras).build()
      sender = new GcmSender authorization

    sender.send content, target.deviceToken, done
