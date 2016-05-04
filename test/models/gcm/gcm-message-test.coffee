require('rootpath')()

assert = require('chai').assert
sinon = require 'sinon'

_ = require 'lodash'

gcm = require 'test/stubs/node-gcm-stub'
GcmMessage = require('src/models/gcm/gcm-message') gcm

describe 'GcmMessage', ->

  message = null
  data = null
  extras = null

  before (done) ->
    message = 'sample message'
    data =
      dataKey1: 'data_value_1'
      dataKey2: 'data_value_2'
    extras =
      timeToLive: 86400
      collapseKey: true
    done()

  it 'should correctly build the notification content', ->
    json =
      data:
        text: message
    for own k, v of data
      json.data[k] = v
    for own k, v of extras
      json[_.snakeCase(k)] = v

    gcm.setJson json
    gcmMessage = new GcmMessage message, data, extras
    assert.deepEqual gcmMessage.build().toJson(), json
