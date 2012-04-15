PHONEGAP LOCALNOTIFICATION 
The Phonegap LocalNotification plugin is great, but the documentation is lacking - also explanation of how to do more than set a 60 second timer.

This example goes through in detail how to set a timer for the future based on hours and minutes, as well as days in the future - also setting up repeat events for daily, weekly, monthly, yearly.

It also explains how to create a callback to your app when it is launched from that notification.

the full write up is here
http://www.drewdahlman.com/meusLabs/?p=84

/////////////////////////////////////////////////////////////////////////////////////

NOTES:
A breakdown of options - 
- date ( this expects a date object )
- message ( the message that is displayed )
- repeat ( has the options of 'weekly','daily','monthly','yearly')
- badge ( displays number badge to notification )
- foreground ( a javascript function to be called if the app is running )
- background ( a javascript function to be called if the app is in the background )
- sound ( a sound to be played, the sound must be located in your project's resources and must be a caf file )

/////////////////////////////////////////////////////////////////////////////////////
- UPDATES:
3.31.12 - 
Added support for Cordova Please check LocalNotification.h to comment and uncomment the correct code.


window.plugins.localNotification.add({
  date: d, // your set date object
  message: 'Hello world!',
  repeat: 'weekly', // will fire every week on this day
  badge: 1,
  foreground:'app.foreground',
  background:'app.background',
  sound:'sub.caf'
})

enjoy!

