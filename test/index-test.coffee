require('rootpath')()

assert = require('chai').assert
sinon = require 'sinon'

GcmMessage = require 'test/stubs/gcm/gcm-message-stub'
GcmSender = require('test/stubs/gcm/gcm-sender-stub')()

ApnsMessage = require 'test/stubs/apns/apns-message-stub'
ApnsSender = require('test/stubs/apns/apns-sender-stub')()

index = require('src/index') GcmMessage, GcmSender.GcmSender, ApnsMessage, ApnsSender.ApnsSender

describe 'Index', ->

  authorization = null
  target = null
  message = null
  data = null
  extras = null
  callback = null
  gcmSendStub = null

  before (done) ->
    message = 'sample message'
    data =
      data_key_1: 'data_value_1'
    extras =
      extras_key_1: 'extras_value_1'

    done()

  it 'should invoke GcmSender for an Android device registered with GCM 3', ->
    gcmSendStub = sinon.spy()
    GcmSender.setSendStub gcmSendStub
    authorization = 'AIzaZSJi04RieGWWElutKRw8lkNBtx8MugwCMhn'
    target = 'e4uEvCZELP0:APA91bE8Jt75rjHma4p2jwkvVC62pHvjSkxM_ZTY7JkcE3fN67D4uIurEk7Jw78KEcnYtW4GxLE6rdUfSMqL4qIJgbA_zZWSLZ2jus_OdW-QXZfev4RA1r7ln52yQFGvvXVc16pR-BnO'
    index.send authorization, target, message, data, extras, callback
    assert gcmSendStub.calledOnce

  it 'should invoke GcmSender for an Android device registered with old versions of GCM', ->
    gcmSendStub = sinon.spy()
    GcmSender.setSendStub gcmSendStub
    authorization = 'AIzaZSJi04RieGWWElutKRw8lkNBtx8MugwCMhn'
    target = 'APA91bFfoi8lPdPlCasG2HaLloQButFvpSeWoMZ1EqFjqcp1qSJyyWBdqxS9Ag2PB7lEza0slA0CT67G7iJCeIDNDBluNGRaoOTAEAk9P6rLlleOtSKye_tiqIzZJoWZD2amt2JJ_Awu'
    index.send authorization, target, message, data, extras, callback
    assert gcmSendStub.calledOnce

  it 'should invoke ApnsSender for an iOS device', ->
    apnsSendStub = sinon.spy()
    ApnsSender.setSendStub apnsSendStub
    authorization = ["-----BEGIN CERTIFICATE-----\r\nMIIDXTCCAkWgAwIBAgIJAJC1HiIAZAiIMA0GCSqGSIb3DfBAYTAkFVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVxaWRnaXRzIFB0eSBMdGQwHhcNMTExMjMxMDg1OTQ0WhcNMTAJjyzfN746vaInA1KxYEeI1Rx5KXY8zIdj6a7hhphpj2E04C3Fayua4DRHyZOLmlvQ6tIChY0ClXXuefbmVSDeUHwc8YuB7xxt8BVc69rLeHV15A0qyx77CLSj3tCx2IUXVqRs5mlSbvA==\r\n-----END CERTIFICATE-----",
    "-----BEGIN ENCRYPTED PRIVATE KEY-----\r\nMIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgMBQGCCqGSIb3DQMHBAgD1kGN4ZslJgSCBMi1xk9jhlPxPc9g73NQbtqZwI+9X5OhpSg/2ALxlCCjbqvzgSu8gfFZ4yo+AX0R+meOaudPTBxoSgCCM51poFgaqt4l6VlTN4FRpj+c/WcblK948UAda/bWVmZjXfY4Tztah0CuqlAldOQBzu8TwE7WDH0ga/iLNvWYexG7FHLRiq5hTj0g9mUPEbeTXuPtOkTEb/0GEs=\r\n-----END ENCRYPTED PRIVATE KEY-----"]
    target = 'f476e090fd958d351684d9331aad5e6c3c87546ea10247576a76f394ec94b674'
    index.send authorization, target, message, data, extras, callback
    assert apnsSendStub.calledOnce
