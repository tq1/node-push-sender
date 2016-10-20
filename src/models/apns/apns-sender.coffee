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
        async.asyncify () ->
          console.log targets
          sender.send(content, targets)
        (err, res) ->
          response.success = res.sent.length
          response.failure = res.failed.length
          response.results = res
        (response) ->
          sender.shutdown()
          return response
      ], done
