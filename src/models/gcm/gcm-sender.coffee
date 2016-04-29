module.exports = (gcm, PushResponse) ->

  class GcmSender

    constructor: (authorization) ->
      @sender = new gcm.Sender authorization

    send: (content, target, done) ->
      targets = if target.constructor is Array then target else [target]

      @sender.send content, {registrationTokens: targets}, (err, res) ->
        results = []
        for result in res.results
          results.push
            message_id: result.message_id ? null
            error: result.error ? null

        response = new PushResponse res.success, res.failure, results
        done err, response
