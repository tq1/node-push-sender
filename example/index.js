var pushSender = require("node-push-sender");

//Forming the notification
var androidPushNotification = {
  "serverKey":"AIza...",
  "target":{
    "deviceToken":"APA91bHPRgkF3JUikC4ENAHEeMrd41Zxv3hVZjC9KtT8OvPVGJ-hQMRKRrZuJAEcl7B338qju59zJMjw2DELjzEvxwYv7hH5Ynpc1ODQ0aT4U4OFEeco8ohsN5PjL1iR2dNtk2BAokeMCg2ZXKqpc8FXKmhX94kIdQ",
    "platform":"android"
  },
  "message":"Hello World!",
  "contents":{
    "actionId": "test"
  },
  "extras":{
    "timeToLive":3600
  }
};

//Sending the push
pushSender.send(androidPushNotification.serverKey, androidPushNotification.target, androidPushNotification.message, androidPushNotification.contents, androidPushNotification.extras, function(err, result)
{
  if(err) {
    console.log(err);
  }
  else {
    console.log(result);
  }
});

var iosPushNotification = {
  "target":{
    "deviceToken":"ddc090afbb7accd2fd796b445c947c93582df52135b35bec3385ec698f008123",
    "platform":"ios"
  },
  "message":"Hello World!",
  "contents":{
    "actionId": "test"
  },
  "extras":{
    "timeToLive":3600
    "topic": "com.node.push.sender"
  }
};

var iosAuthentication = {
  "production": false
  "cert": "----- BEGIN CERTIFICATE ------",
  "key": "------ BEGIN PRIVATE KEY -------"
}

pushSender.send(iosAuthentication, iosPushNotification.target, androidPushNotification.message, iosPushNotification.contents, iosPushNotification.extras, function(err, result)
{
  if(err) {
    console.log(err);
  }
  else {
    console.log(result);
  }
});
