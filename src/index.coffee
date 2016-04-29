module.exports = (GcmMessage, GcmSender) ->

  send: (authorization, target, message, data, extras, done) ->
    content = new GcmMessage(message, data, extras).build()
    sender = new GcmSender authorization

    sender.send content, target, done
