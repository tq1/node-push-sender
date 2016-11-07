require('rootpath')()

assert = require('chai').assert
sinon = require 'sinon'
async = require 'async'

apns = require 'test/stubs/apns/apn-stub'
PushResponse = require('src/models/response')()
ApnsSender = require('src/models/apns/apns-sender') apns, PushResponse, async

describe 'ApnsSender', ->

  apnsSender = null
  authorization = null
  content = null
  singleTarget = null
  multipleTargets = null
  defaultServerError = null
  defaultDeviceMessageId = null
  defaultDeviceError = null
  defaultResponse = null

  before (done) ->
    authorization = ["-----BEGIN CERTIFICATE-----\r\nMIIDXTCCAkWgAwIBAgIJAJC1HiIAZAiIMA0GCSqGSIb3DfBAYTAkFVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVxaWRnaXRzIFB0eSBMdGQwHhcNMTExMjMxMDg1OTQ0WhcNMTAJjyzfN746vaInA1KxYEeI1Rx5KXY8zIdj6a7hhphpj2E04C3Fayua4DRHyZOLmlvQ6tIChY0ClXXuefbmVSDeUHwc8YuB7xxt8BVc69rLeHV15A0qyx77CLSj3tCx2IUXVqRs5mlSbvA==\r\n-----END CERTIFICATE-----",
    "-----BEGIN ENCRYPTED PRIVATE KEY-----\r\nMIIFDjBABgkqhkiG9w0BBQ0wMzAbBgkqhkiG9w0BBQwwDgMBQGCCqGSIb3DQMHBAgD1kGN4ZslJgSCBMi1xk9jhlPxPc9g73NQbtqZwI+9X5OhpSg/2ALxlCCjbqvzgSu8gfFZ4yo+AX0R+meOaudPTBxoSgCCM51poFgaqt4l6VlTN4FRpj+c/WcblK948UAda/bWVmZjXfY4Tztah0CuqlAldOQBzu8TwE7WDH0ga/iLNvWYexG7FHLRiq5hTj0g9mUPEbeTXuPtOkTEb/0GEs=\r\n-----END ENCRYPTED PRIVATE KEY-----"]
    firstTarget = 'f476e090fd958d351684d9331aad5e6c3c87546ea10247576a76f394ec94b674'
    secondTarget = 'f476e090fd958d351684d9331aad5e6c3c87546ea10247576a76f394ec94b672'
    singleTarget = firstTarget
    multipleTargets = [firstTarget, secondTarget]
    content = {}
    done()

  beforeEach (done) ->
    apnsSender = new ApnsSender authorization
    done()

  it 'should process the response for a single target', (done) ->
    apnsSender.send content, singleTarget, (err, res) ->
      assert.notOk err
      assert.equal res.success, 1
      assert.equal res.failure, 0
      done()
