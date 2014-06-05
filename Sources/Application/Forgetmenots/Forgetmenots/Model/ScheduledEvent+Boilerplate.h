//
//  ScheduledEvent+Boilerplate.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 26.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ScheduledEvent.h"
#import "ForgetmenotsEvent+Boilerplate.h"

#define PLANAHEAD_NUMBER 3
#define NOTIFICATION_NAME @"name"

@interface ScheduledEvent (Boilerplate)

+(ScheduledEvent *) initWithFlowers:(NSSet *)flowers
                               name:(NSString *)name
                               date:(NSDate *)date
                   inManagedContext:(NSManagedObjectContext *)context;


+(NSArray *)notificationsByName:(NSString *)name withNotifications:(NSArray *)notifications;

+(NSArray *) planAheadEventsWithForgetmenotsEvent:(ForgetmenotsEvent *)event fromDate:(NSDate *)date;

+(NSArray *)allInManagedContext:(NSManagedObjectContext *)context;

+(void) deleteAllInManagedContext:(NSManagedObjectContext *)context;

+(void) deleteAllWithName:(NSString *)name inManagedContext:(NSManagedObjectContext *)context;

@end
