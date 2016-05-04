require('rootpath')()

assert = require('chai').assert
sinon = require 'sinon'

GcmMessage = require 'test/stubs/gcm-message-stub'

gcmSendStub = sinon.spy()
GcmSender = require('test/stubs/gcm-sender-stub') gcmSendStub
index = require('src/index') GcmMessage, GcmSender

describe 'Index', ->

  authorization = null
  target = null
  message = null
  data = null
  extras = null
  callback = null

  before (done) ->
    message = 'sample message'
    data =
      data_key_1: 'data_value_1'
    extras =
      extras_key_1: 'extras_value_1'

    done()

  it 'should invoke GcmSender for an Android device registered with GCM 3', ->
    authorization = 'AIzaZSJi04RieGWWElutKRw8lkNBtx8MugwCMhn'
    target = 'e4uEvCZELP0:APA91bE8Jt75rjHma4p2jwkvVC62pHvjSkxM_ZTY7JkcE3fN67D4uIurEk7Jw78KEcnYtW4GxLE6rdUfSMqL4qIJgbA_zZWSLZ2jus_OdW-QXZfev4RA1r7ln52yQFGvvXVc16pR-BnO'
    index.send authorization, target, message, data, extras, callback
    assert gcmSendStub.calledOnce

  it 'should invoke GcmSender for an Android device registered with old versions of GCM', ->
    authorization = 'AIzaZSJi04RieGWWElutKRw8lkNBtx8MugwCMhn'
    target = 'APA91bFfoi8lPdPlCasG2HaLloQButFvpSeWoMZ1EqFjqcp1qSJyyWBdqxS9Ag2PB7lEza0slA0CT67G7iJCeIDNDBluNGRaoOTAEAk9P6rLlleOtSKye_tiqIzZJoWZD2amt2JJ_Awu'
    index.send authorization, target, message, data, extras, callback
    assert gcmSendStub.calledTwice
