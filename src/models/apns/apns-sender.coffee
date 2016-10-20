module.exports = (apns, PushResponse) ->

  class ApnsSender

    constructor: (authorization) ->
      @sender = new apns.Provider
        production: authorization.production
        cert: authorization.cert
        key: authorization.key
      @response = new PushResponse 0, 0, []

    send: (content, target, done) ->
      targets = if target.constructor is Array then target else [target]
      @callback = done

      @sender.send(content, targets).then (res) ->
        @response.success = res.sent.length
        @response.failure = res.failed.length
        @response.results = res
      @sender.shutdown()
