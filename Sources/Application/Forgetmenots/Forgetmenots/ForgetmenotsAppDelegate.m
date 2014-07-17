    //
//  ForgetmenotsAppDelegate.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 11.04.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ForgetmenotsAppDelegate.h"
#import "Flower+Defaults.h"
#import "ForgetmenotsEvent+Boilerplate.h"
#import "ScheduledEvent+Boilerplate.h"
#import "DatabaseAvailability.h"
#import "FmnSettings.h"
#import "FmnMisc.h"
#import "FmnTodaysEventsVC.h"

@interface ForgetmenotsAppDelegate()

@end

static NSManagedObjectContext* theObjectContext;

@implementation ForgetmenotsAppDelegate

@synthesize notificationDate = _notificationDate;

#define YES_STRING @"YES"
#define NO_STRING @"NO"

-(void)setNotificationDate:(NSDate *)notificationDate
{
    _notificationDate = notificationDate;
    [[NSUserDefaults standardUserDefaults] setObject:_notificationDate forKey:NOTIFICATION_TIME];
}

-(NSDate *)notificationDate
{
    if (_notificationDate)
    {
        return _notificationDate;
    }
    else{
        _notificationDate = [[NSUserDefaults standardUserDefaults] objectForKey:NOTIFICATION_TIME];
    }
    if (! _notificationDate)
    {
        _notificationDate = [NSDate dateWithTimeIntervalSince1970:544899600]; // 5:00 pm GWT 8 april 1987
    }
    return _notificationDate;
}

+(BOOL)didShowMoreInfoToday
{
    NSDate * lastShown = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_SHOWN_DETAILS_DATE];
    if ([FmnMisc isToday:lastShown])
    {
        //do nothing
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:LAST_SHOWN_DETAILS_DATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return [FmnMisc isToday:lastShown];
}

-(void)cleanupOldNotifications
{
    NSString * loaded = [FmnSettings getSettingsStringWithKey:CLEANED_UP_OLD_NOTIFICATIONS];
    if (loaded && [loaded isEqualToString:YES_STRING])
    {
        // do nothing, old notifications were cleaned out already
    }
    else
    {
        [FmnSettings saveSettingsString:YES_STRING withKey:CLEANED_UP_OLD_NOTIFICATIONS];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        [ScheduledEvent deleteAllInManagedContext:self.managedObjectContext];
    }
}

-(void)scheduleLaggingBehind
{
    NSArray * forgetmenots = [ForgetmenotsEvent allInManagedContext:self.managedObjectContext];
    NSArray * allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (ForgetmenotsEvent * event in forgetmenots)
    {
        NSArray * notifications = [ScheduledEvent notificationsByName:event.name withNotifications:allNotifications];
        NSDate * from = ((UILocalNotification *)[notifications lastObject]).fireDate;
        if (!from)
        {
            from = [NSDate date];
        }
        if ([notifications count] < PLANAHEAD_NUMBER)
        {
            [ScheduledEvent planAheadEventsWithForgetmenotsEvent:event fromDate:from];
        }
    }
}

-(void)loadInNecessaryDefaultFlowers
{
    NSString * loaded = [FmnSettings getSettingsStringWithKey:LOADED_DEFAULT_FLOWERS];
    //XXX to be removed on deploy to AppStore
//    loaded = NO_STRING;
    if (loaded && [loaded isEqualToString:YES_STRING])
    {
        // do nothing, flowers are loaded
    }
    else
    {
        [FmnSettings saveSettingsString:YES_STRING withKey:LOADED_DEFAULT_FLOWERS];
        
        UIColor * white26 = [UIColor colorWithWhite:1.0 alpha:0.26];
        
        [Flower initflowerWithName:@"Forgetmenot"
                         andColors:@{@"first": @{@"top": UIColorFromRGB(0x6666FF), @"bottom": UIColorFromRGB(0x0066FF)},
                                     @"second": @{@"top": white26, @"bottom": white26},
                                     @"third": @{@"top": UIColorFromRGB(0xFFCC00), @"bottom": UIColorFromRGB(0xFF9900)}}
                  inManagedContext:self.managedObjectContext];
        
        [Flower initflowerWithName:@"Rose"
                         andColors:@{@"first": @{@"top": UIColorFromRGB(0xFF3366), @"bottom": UIColorFromRGB(0xFF3333)},
                                     @"second": @{@"top": white26, @"bottom": white26},
                                     @"third": @{@"top": UIColorFromRGB(0xFF3366), @"bottom": UIColorFromRGB(0xFF3333)}}
                  inManagedContext:self.managedObjectContext];
        
        [Flower initflowerWithName:@"Tulip"
                         andColors:@{@"first": @{@"top": UIColorFromRGB(0xFF3366), @"bottom": UIColorFromRGB(0xFF9900)},
                                     @"second": @{@"top": [NSNull null], @"bottom": [NSNull null]},
                                     @"third": @{@"top": [NSNull null], @"bottom": [NSNull null]}}
                  inManagedContext:self.managedObjectContext];
        
        [Flower initflowerWithName:@"Mum"
                         andColors:@{@"first": @{@"top": UIColorFromRGB(0xFF3366), @"bottom": UIColorFromRGB(0x6666FF)},
                                     @"second": @{@"top": white26, @"bottom": white26},
                                     @"third": @{@"top": UIColorFromRGB(0xFFCC00), @"bottom": UIColorFromRGB(0xFF9900)}}
                  inManagedContext:self.managedObjectContext];
        
        [Flower initflowerWithName:@"Sunflower"
                         andColors:@{@"first": @{@"top": UIColorFromRGB(0xFFCC00), @"bottom": UIColorFromRGB(0xFF9900)},
                                     @"second": @{@"top": white26, @"bottom": white26},
                                     @"third": @{@"top": UIColorFromRGB(0x333333), @"bottom": UIColorFromRGB(0x999999)}}
                  inManagedContext:self.managedObjectContext];
        
        [Flower initflowerWithName:@"Amaryllis"
                         andColors:@{@"first": @{@"top": UIColorFromRGB(0xFF3366), @"bottom": UIColorFromRGB(0xFF3333)},
                                     @"second": @{@"top": white26, @"bottom": white26},
                                     @"third": @{@"top": UIColorFromRGB(0xFFCC00), @"bottom": UIColorFromRGB(0xFF9900)}}
                  inManagedContext:self.managedObjectContext];
        
        [Flower initflowerWithName:@"Gerbera"
                         andColors:@{@"first": @{@"top": UIColorFromRGB(0xFF3366), @"bottom": UIColorFromRGB(0xFF9900)},
                                     @"second": @{@"top": white26, @"bottom": white26},
                                     @"third": @{@"top": UIColorFromRGB(0x333333), @"bottom": UIColorFromRGB(0x999999)}}
                  inManagedContext:self.managedObjectContext];
        
        [Flower initflowerWithName:@"Alstroemeria"
                         andColors:@{@"first": @{@"top": UIColorFromRGB(0xFF3366), @"bottom": UIColorFromRGB(0xFF9900)},
                                     @"second": @{@"top": white26, @"bottom": white26},
                                     @"third": @{@"top": UIColorFromRGB(0xFF3366), @"bottom": UIColorFromRGB(0xFF9900)}}
                  inManagedContext:self.managedObjectContext];
        
        [Flower initflowerWithName:@"Lilium"
                         andColors:@{@"first": @{@"top": UIColorFromRGB(0xFFFFFF), @"bottom": UIColorFromRGB(0xFFFFFF)},
                                     @"second": @{@"top": [UIColor colorWithWhite:0.5 alpha:0.26], @"bottom": [UIColor colorWithWhite:0.5 alpha:0.26]},
                                     @"third": @{@"top": UIColorFromRGB(0xFFCC00), @"bottom": UIColorFromRGB(0xFF9900)}}
                  inManagedContext:self.managedObjectContext];
        NSError *error;
        [self.managedObjectContext save:&error];
        if (![self.managedObjectContext save:&error]){
            [FmnSettings saveSettingsString:NO_STRING withKey:LOADED_DEFAULT_FLOWERS];
        }
    }
}

-(void)loadDefaultEvents
{
    //load some defaults;
    
    // XXX some weird shite with this one
    [ForgetmenotsEvent initWithFlowers:[NSSet setWithObjects:[Flower flowerWithName:@"Forgetmenot" inManagedContext:self.managedObjectContext], [Flower flowerWithName:@"Tulip" inManagedContext:self.managedObjectContext], nil]
                                  name:@"Ally's birhtday"
                                  date:[NSDate dateWithTimeIntervalSince1970:1400107843]
                      inManagedContext:self.managedObjectContext]; // 14 may 2014
    
//    [ForgetmenotsEvent initWithFlowers:[NSSet setWithObjects:[Flower flowerWithName:@"Lilium" inManagedContext:self.managedObjectContext], [Flower flowerWithName:@"Amaryllis" inManagedContext:self.managedObjectContext], nil]
//                                  name:@"Ally Monthly"
//                                nTimes:2
//                           inTimeUnits:1
//                              timeUnit:MONTH
//                             withStart:[NSDate date] inManagedContext:self.managedObjectContext];
}

-(void) setUIAppearanceStyles
{
    [[UINavigationBar appearance] setTintColor:[UIColor lightGrayColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]}];
}

-(void)notifyWithManagedContext
{
    // let everyone who might be interested know this context is available
    // this happens very early in the running of our application
    // it would make NO SENSE to listen to this radio station in a View Controller that was segued to, for example
    // (but that's okay because a segued-to View Controller would presumably be "prepared" by being given a context to work in)
    NSDictionary *userInfo = @{ FmnDatabaseAvailabilityContext : self.managedObjectContext };
    [[NSNotificationCenter defaultCenter] postNotificationName:FmnDatabaseAvailabilityNotification
                                                        object:self
                                                      userInfo:userInfo];
}

+ (void)presentTodaysEvents:(NSArray *)events
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    FmnTodaysEventsVC * vc = [storyboard instantiateViewControllerWithIdentifier:@"FmnTodaysEventVC"];
        
    [vc setEvent:[events firstObject]];
        
    [[ForgetmenotsAppDelegate topMostController] presentViewController:vc animated:YES completion:^{
        if ([events count] > 1){
            [ForgetmenotsAppDelegate presentTodaysEvents:[events subarrayWithRange:NSMakeRange(1, [events count] - 1)]];
        }
    }];
}

+ (UIViewController*) topMostController
{
    UIViewController *topController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    return topController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self notifyWithManagedContext];
    [self loadInNecessaryDefaultFlowers];
    
    [self loadDefaultEvents];
    
    //XXX in a different thread?
    {
        [self cleanupOldNotifications];
        [self scheduleLaggingBehind];
    }
    
    [self setUIAppearanceStyles];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data stack setup

//
// These methods are very slightly modified from what is provided by the Xcode template
// An overview of what these methods do can be found in the section "The Core Data Stack"
// in the following article:
// http://developer.apple.com/iphone/library/documentation/DataManagement/Conceptual/iPhoneCoreData01/Articles/01_StartingOut.html
//

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator == nil) {
        NSURL *storeUrl = [NSURL fileURLWithPath:self.persistentStorePath];
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
        NSError *error = nil;
        NSPersistentStore *persistentStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error];
        NSAssert3(persistentStore != nil, @"Unhandled error adding persistent store in %s at line %d: %@", __FUNCTION__, __LINE__, [error localizedDescription]);
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext == nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [self.managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _managedObjectContext;
}

- (NSString *)persistentStorePath {
    
    if (_persistentStorePath == nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths lastObject];
        _persistentStorePath = [documentsDirectory stringByAppendingPathComponent:@"Forgetmenots.sqlite"];
    }
    return _persistentStorePath;
}


@end
