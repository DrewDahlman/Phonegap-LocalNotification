PHONEGAP LOCALNOTIFICATION 
The Phonegap LocalNotification plugin is great, but the documentation is lacking - also explanation of how to do more than set a 60 second timer.

This example goes through in detail how to set a timer for the future based on hours and minutes, as well as days in the future.

It also explains how to create a callback to your app when it is launched from that notification.

the full write up is here
http://www.drewdahlman.com/meusLabs/?p=84

Added options to repeat notifications on a daily, weekly, monthly, or yearly interval. Use the repeat option:

window.plugins.localNotification.add({
  date: (3).days().fromNow(),
  message: 'Hello world!',
  repeat: 'weekly'
})

enjoy!
