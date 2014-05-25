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
#import "DatabaseAvailability.h"

@interface ForgetmenotsAppDelegate()

@end

static NSManagedObjectContext* theObjectContext;

@implementation ForgetmenotsAppDelegate

-(void)loadDefaultEvents
{
    //load some defaults;
    [ForgetmenotsEvent initWithFlowers:[NSSet setWithObjects:[Flower flowerWithName:@"Forgetmenots" inManagedContext:self.managedObjectContext], [Flower flowerWithName:@"Tulip" inManagedContext:self.managedObjectContext], nil]
                                  name:@"Ally's birhtday"
                                  date:[NSDate dateWithTimeIntervalSince1970:1400107843]
                      inManagedContext:self.managedObjectContext]; // 14 may 2014
    
    [ForgetmenotsEvent initWithFlowers:[NSSet setWithObjects:[Flower flowerWithName:@"Lilium" inManagedContext:self.managedObjectContext], [Flower flowerWithName:@"Amaryllis" inManagedContext:self.managedObjectContext], nil]
                                  name:@"Ally Monthly"
                                nTimes:2
                           inTimeUnits:1
                              timeUnit:MONTH
                             withStart:[NSDate date] inManagedContext:self.managedObjectContext];
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

//-(void)applicationDidFinishLaunching:(UIApplication *)application
//{
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self notifyWithManagedContext];
    [self loadDefaultEvents];
    
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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
