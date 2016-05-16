require('rootpath')()

assert = require('chai').assert
sinon = require 'sinon'

_ = require 'lodash'

apns = require 'test/stubs/apns/apn-stub'
ApnsMessage = require('src/models/apns/apns-message') apns

describe 'ApnsMessage', ->

  message = null
  data = null
  extras = null

  before (done) ->
    message = 'sample message'
    extras =
      timeToLive: 86400
      priority: 5
    done()

  it 'should correctly build the notification content', ->
    json =
      alert:
        body: message
    for own k, v of data
      json.data[k] = v
    for own k, v of extras
      json[_.snakeCase(k)] = v

    apns.setJson json
    apnsMessage = new ApnsMessage message, data, extras
    assert.deepEqual apnsMessage.build().toJson(), json
