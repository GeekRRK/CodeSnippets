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

static void completionCallback(SystemSoundID  mySSID) {
    AudioServicesPlaySystemSound(mySSID);
}

- (void)playSound {
    // Get the main bundle for the app
    CFBundleRef mainBundle;
    SystemSoundID soundFileObject;
    mainBundle = CFBundleGetMainBundle();
    
    // Get the URL to the sound file to play
    CFURLRef soundFileURLRef  = CFBundleCopyResourceURL (
                                                         mainBundle,
                                                         CFSTR ("background" ),
                                                         CFSTR ("wav" ),
                                                         NULL
                                                         );
    // Create a system sound object representing the sound file
    AudioServicesCreateSystemSoundID (
                                      soundFileURLRef,
                                      &soundFileObject
                                      );
    // Add sound completion callback
    AudioServicesAddSystemSoundCompletion (soundFileObject, NULL , NULL ,
                                        (void *) completionCallback,
                                           (__bridge void *) self );
    // Play the audio
    AudioServicesPlaySystemSound(soundFileObject);
    
}

// Define a callback to be called when the sound is finished
// playing. Useful when you need to free memory after playing.
static void MyCompletionCallback (
                                  SystemSoundID  mySSID,
                                  void * myURLRef
                                  ) {
    AudioServicesDisposeSystemSoundID (mySSID);
    CFRelease (myURLRef);
    
    CFRunLoopStop (CFRunLoopGetCurrent());
}

- (void)playSound2 {
    // Set up the pieces needed to play a sound.
    SystemSoundID    mySSID;
    CFURLRef        myURLRef;
    myURLRef = CFURLCreateWithFileSystemPath (
                                              kCFAllocatorDefault,
                                              CFSTR ("http://www.cnblogs.com/ComedyHorns.aif"),
                                              kCFURLPOSIXPathStyle,
                                              FALSE
                                              );
    // create a system sound ID to represent the sound file
    OSStatus error = AudioServicesCreateSystemSoundID (myURLRef,
                                                       &mySSID);
    // Register the sound completion callback.
    // Again, useful when you need to free memory after playing.
    AudioServicesAddSystemSoundCompletion (
                                           mySSID,
                                           NULL,
                                           NULL,
                                           MyCompletionCallback,
                                           (void *) myURLRef
                                           );
    // Play the sound file.
    AudioServicesPlaySystemSound (mySSID);
    // Invoke a run loop on the current thread to keep the application
    // running long enough for the sound to play; the sound completion
    // callback later stops this run loop.
    CFRunLoopRun ();
}

@end
