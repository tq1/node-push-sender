# push-sender
[![npm version](https://badge.fury.io/js/node-push-sender.svg)](https://badge.fury.io/js/node-push-sender)
[![Code Climate](https://codeclimate.com/github/tq1/node-push-sender/badges/gpa.svg)](https://codeclimate.com/github/tq1/node-push-sender)

A NodeJS library built to send remote notifications for Android (GCM), iOS (APNS) and Windows (WNS) mobile devices.
It is based on already existent platform-specific open source libraries: [node-gcm](https://github.com/ToothlessGear/node-gcm) and [node-apn](https://github.com/argon/node-apn).

## Features

- Supports Google Cloud Messaging (GCM) for Android devices and Apple Push Notification Service (APNS) for iOS;
- Sends notifications to multiple devices at once;
- Supports all GCM [optional parameters](https://developers.google.com/cloud-messaging/http-server-ref#downstream-http-messages-plain-text);
- Sends custom content to the end user;
- Provides the server response with the errors/message_ids for each targeted device.

## Installation

$ npm install node-push-sender

## Contributing

We encourage you to contribute to node-push-sender! Please check out the
[contributing guide](.github/CONTRIBUTING.md) for guidelines about how to proceed.
