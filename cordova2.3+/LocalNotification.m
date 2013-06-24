/*!
 * Cordova 2.3.0+ LocalNotification plugin
 * Original author: Olivier Lesnicki
 */

#import "LocalNotification.h"
#import <Cordova/CDV.h>

@implementation LocalNotification

-(void)addNotification:(CDVInvokedUrlCommand*)command {
        
    NSMutableDictionary *repeatDict = [[NSMutableDictionary alloc] init];
    [repeatDict setObject:[NSNumber numberWithInt:NSDayCalendarUnit     ] forKey:@"daily"   ];
    [repeatDict setObject:[NSNumber numberWithInt:NSWeekCalendarUnit    ] forKey:@"weekly"  ];
    [repeatDict setObject:[NSNumber numberWithInt:NSMonthCalendarUnit   ] forKey:@"monthly" ];
    [repeatDict setObject:[NSNumber numberWithInt:NSYearCalendarUnit    ] forKey:@"yearly"  ];
    [repeatDict setObject:[NSNumber numberWithInt:0] forKey:@""         ];
    
    UILocalNotification* notif = [[UILocalNotification alloc] init];

	double fireDate             = [[command.arguments objectAtIndex:0] doubleValue];
    NSString *alertBody         =  [command.arguments objectAtIndex:1];
    NSNumber *repeatInterval    =  [command.arguments objectAtIndex:2];
    NSString *soundName         =  [command.arguments objectAtIndex:3];
    NSString *notificationId    =  [command.arguments objectAtIndex:4];
    
    notif.alertBody         = ([alertBody isEqualToString:@""])?nil:alertBody;
    notif.fireDate          = [NSDate dateWithTimeIntervalSince1970:fireDate];
    notif.repeatInterval    = [[repeatDict objectForKey: repeatInterval] intValue];
    notif.soundName         = soundName;
    notif.timeZone          = [NSTimeZone defaultTimeZone];
    
	NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                notificationId    , @"notificationId",
                                command.callbackId, @"callbackId",
                                nil
                              ];
    
    notif.userInfo = userDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        
    
}

- (void)cancelNotification:(CDVInvokedUrlCommand*)command {
    
    NSString *notificationId    = [command.arguments objectAtIndex:0];
	NSArray *notifications      = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
	for (UILocalNotification *notification in notifications) {
        
		NSString *notId = [notification.userInfo objectForKey:@"notificationId"];
        
		if ([notificationId isEqualToString:notId]) {
			[[UIApplication sharedApplication] cancelLocalNotification: notification];
		}
        
	}

}

- (void)cancelAllNotifications:(CDVInvokedUrlCommand*)command {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

- (void)didReceiveLocalNotification:(NSNotification *)notification
{
    
    UILocalNotification* notif  = [notification object];
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    
    NSString* stateStr = (state == UIApplicationStateActive ? @"active" : @"background");
    
    CDVPluginResult* pluginResult = nil;
    NSString* javaScript          = nil;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:stateStr forKey:@"appState"];
    [params setObject:[notif.userInfo objectForKey:@"notificationId"] forKey:@"notificationId"];
    
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsDictionary:params];
    javaScript   = [pluginResult toSuccessCallbackString: [notif.userInfo objectForKey:@"callbackId"]];
    
    [self writeJavascript:javaScript];
    
}


@end