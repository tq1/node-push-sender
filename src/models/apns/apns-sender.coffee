module.exports = (apns, PushResponse, async) ->

  class ApnsSender

    constructor: (authorization) ->
      @sender = new apns.Provider
        production: authorization.production
        cert: authorization.cert
        key: authorization.key
      @response = new PushResponse 0, 0, []

    send: (content, target, done) ->
      targets = if target.constructor is Array then target else [target]
      sender = @sender
      response = @response

      async.waterfall [
        async.asyncify (cb) ->
          sender.send(content, targets)
        (res, cb) ->
          response.success = res.sent.length
          response.failure = res.failed.length
          response.results = res
          sender.shutdown()
          cb(null, response)
      ], done
