module.exports = ->

  class PushResponse

    constructor: (success, failure, results) ->
      @success = success
      @failure = failure
      @results = results
