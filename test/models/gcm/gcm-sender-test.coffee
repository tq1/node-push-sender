require('rootpath')()

assert = require('chai').assert
sinon = require 'sinon'

gcm = require 'test/stubs/gcm/node-gcm-stub'
PushResponse = require('src/models/response')()
GcmSender = require('src/models/gcm/gcm-sender') gcm, PushResponse

describe 'GcmSender', ->

  gcmSender = null
  authorization = null
  content = null
  singleTarget = null
  multipleTargets = null
  defaultServerError = null
  defaultDeviceMessageId = null
  defaultDeviceError = null
  defaultResponse = null

  before (done) ->
    authorization = 'AIzaZSJi04RieGWWElutKRw8lkNBtx8MugwCMhn'
    firstTarget = 'e4uEvCZELP0:APA91bE8Jt75rjHma4p2jwkvVC62pHvjSkxM_ZTY7JkcE3fN67D4uIurEk7Jw78KEcnYtW4GxLE6rdUfSMqL4q' +
    'IJgbA_zZWSLZ2jus_OdW-QXZfev4RA1r7ln52yQFGvvXVc16pR-BnO'
    secondTarget = 'e4uEvCZELP0:APA91bE8Jt75rjHma4p2jwkvVC62pHvjSkxM_ZTY7JkcE3fN67D4uIurEk7Jw78KEcnYtW4GxLE6rdUfSMqL4' +
    'qIJgbA_zZWSLZ2jus_OdW-QXZfev4RA1r7ln52yQFGvvXVc16pR-Bn1'
    singleTarget = firstTarget
    multipleTargets = [firstTarget, secondTarget]
    content = {}
    defaultServerError = new Error 'server error'
    done()

  beforeEach (done) ->
    gcmSender = new GcmSender authorization
    defaultResponse =
      multicast_id: '6488698612352996000'
      success: 0
      failure: 0
      canonical_ids: 0
      results: []
    done()

  it 'should process the response for a single successful target', (done) ->
    defaultResponse.results.push message_id: defaultDeviceMessageId
    defaultResponse.success = 1
    gcm.setError null
    gcm.setResponse defaultResponse

    gcmSender.send content, singleTarget, (err, res) ->
      assert.isNull err
      assert.equal res.success, 1
      assert.equal res.failure, 0
      assert.lengthOf res.results, 1
      assert.propertyVal res.results[0], 'error', null
      assert.propertyVal res.results[0], 'message_id', defaultResponse.results[0].message_id
      done()

  it 'should process the response for a single unsuccessful target', (done) ->
    defaultResponse.results.push error: defaultDeviceError
    defaultResponse.failure = 1
    gcm.setError null
    gcm.setResponse defaultResponse

    gcmSender.send content, singleTarget, (err, res) ->
      assert.isNull err
      assert.equal res.success, 0
      assert.equal res.failure, 1
      assert.lengthOf res.results, 1
      assert.propertyVal res.results[0], 'error', defaultResponse.results[0].error
      assert.propertyVal res.results[0], 'message_id', null
      done()

  it 'should process the response for multiple targets', (done) ->
    defaultResponse.results.push message_id: defaultDeviceMessageId
    defaultResponse.results.push error: defaultDeviceError
    defaultResponse.success = 1
    defaultResponse.failure = 1
    gcm.setError null
    gcm.setResponse defaultResponse

    gcmSender.send content, multipleTargets, (err, res) ->
      assert.isNull err
      assert.equal res.success, 1
      assert.equal res.failure, 1
      assert.lengthOf res.results, 2
      assert.propertyVal res.results[0], 'error', null
      assert.propertyVal res.results[0], 'message_id', defaultResponse.results[0].message_id
      assert.propertyVal res.results[1], 'error', defaultResponse.results[1].error
      assert.propertyVal res.results[1], 'message_id', null
      done()

  it 'should handle GCM server error', (done) ->
    gcm.setError defaultServerError
    gcm.setResponse null

    gcmSender.send content, multipleTargets, (err, res) ->
      assert.isNotNull err
      assert.isNull res
      done()
