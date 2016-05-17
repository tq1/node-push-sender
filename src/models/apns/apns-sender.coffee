module.exports = (apns, PushResponse) ->

  class ApnsSender

    constructor: (authorization) ->
      @sender = new apns.connection
        production: authorization.production
        cert: authorization.cert
        key: authorization.key
      @response = new PushResponse 0, 0, []

    send: (content, target, done) ->
      targets = if target.constructor is Array then target else [target]
      @callback = done
      @sender.pushNotification content, targets
      @sender.shutdown()

      @sender.on 'transmitted', (notification, device) =>
        @response.success++
        @response.results.push
          device: device
          success: true

      @sender.on 'transmissionError', (errCode, notification, device) =>
        @response.failure++
        @response.success--
        @response.results.push
          device: device
          success: false
          errorCode: errCode

      @sender.on 'disconnected', () =>
        done null, @response
