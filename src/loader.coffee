gcm = require 'node-gcm'

PushResponse = require('./models/response')()

GcmMessage = require('./models/gcm/gcm-message') gcm
GcmSender = require('./models/gcm/gcm-sender') gcm, PushResponse

module.exports = do ->
  return require('./index') GcmMessage, GcmSender
