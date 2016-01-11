//
//  APNSViewController.m
//  CodeSnippets
//
//  Created by suorui on 1/11/16.
//  Copyright © 2016 GeekRRK. All rights reserved.
//

#import "APNSViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface APNSViewController ()

@end

@implementation APNSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)registerAPNS{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *pushToken = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"%@", pushToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    completionHandler(UIBackgroundFetchResultNewData);

    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"];
    
    NSLog(@"%@", content);
}

- (void)fireLocalNotification:(NSString *)msg {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification != nil) {
        NSDate *now = [NSDate new];
        localNotification.fireDate = now;
        localNotification.repeatInterval = kCFCalendarUnitHour;
        localNotification.repeatInterval = 0;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber += 1;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertBody = msg;
        localNotification.alertAction = @"Open";
        localNotification.hasAction = YES;
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"rrk" forKey:@"geek"];
        localNotification.userInfo = infoDict;
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    if([[notification.userInfo valueForKey:@"geek"] isEqualToString:@"rrk"]){
        AudioServicesPlaySystemSound(1007);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

@end
