//
//  ScheduledEvent+Boilerplate.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 26.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ScheduledEvent+Boilerplate.h"

@implementation ScheduledEvent (Boilerplate)

#pragma mark - Schedulling Local Notifications

-(void)scheduleLocalNotification
{
    //XXX create notification here
    NSLog(@"semi Created local push notification");
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = self.date;
    notification.alertBody = self.name;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)prepareForDeletion
{
    //XXX todo
    
    
//    UIApplication *app = [UIApplication sharedApplication];
//    NSArray *eventArray = [app scheduledLocalNotifications];
//    for (int i=0; i < [eventArray count]; i++)
//    {
//        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
//        NSDictionary *userInfoCurrent = oneEvent.userInfo;
//        NSString *name = [NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"uid"]];
//        if ([uid isEqualToString:uidtodelete])
//        {
//            //Cancelling local notification
//            [app cancelLocalNotification:oneEvent];
//            break;
//        }
//    }
//    //XXX remove notification standing for this event
//    NSLog(@"semi Removed local push notification");
}

#pragma mark - Database handling routine

+(ScheduledEvent *) initWithFlowers:(NSSet *)flowers
                               name:(NSString *)name
                               date:(NSDate *)date
                   inManagedContext:(NSManagedObjectContext *)context
{
    ScheduledEvent *event= nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ScheduledEvent"];
    request.predicate = [NSPredicate predicateWithFormat:@"(name = %@) AND (date = %@)", name, date];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || [matches count] > 1){
        // handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else if ([matches count])
    {
        event = [matches firstObject];
    }
    else
    {
        event = [NSEntityDescription insertNewObjectForEntityForName:@"ScheduledEvent" inManagedObjectContext:context];
        event.name = name;
        event.date = date;
        event.flowers = flowers;
        
        [event scheduleLocalNotification];
        [context save:nil]; // fucking simulator
    }
    
    return event;
    
}

+(void)deleteAllWithName:(NSString *)name inManagedContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ScheduledEvent"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error){
        // handle error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else if ([matches count])
    {
        for (ScheduledEvent* event in matches)
        {
            [context deleteObject:event];
        }
        [context save:nil];
    }
}

//XXX currently plans only for a single year ahead
//XXX no random factor at all
#define SECONDS_IN_A_YEAR 31556900

+(NSArray *) planEventsWithForgetmenotsEvent:(ForgetmenotsEvent *)fmnEvent
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    if (fmnEvent.random)
    {
        NSTimeInterval startFromEpoch = [fmnEvent.start timeIntervalSince1970];
        for (int i = 0; i < SECONDS_IN_A_YEAR / [fmnEvent.timeUnit intValue]; i++)
        {
            //xxx add actual randomness here, like +- 2 days
            NSDate* randomDate = [[NSDate alloc] initWithTimeIntervalSince1970:startFromEpoch + i * [fmnEvent.timeUnit intValue]];
            [result addObject:[ScheduledEvent initWithFlowers:fmnEvent.flowers
                                                         name:fmnEvent.name
                                                         date:randomDate
                                             inManagedContext:fmnEvent.managedObjectContext]];
        }
    }else {
        [result addObject:[ScheduledEvent initWithFlowers:fmnEvent.flowers
                                                     name:fmnEvent.name
                                                     date:fmnEvent.date
                                         inManagedContext:fmnEvent.managedObjectContext]];
    }
    
    return [result sortedArrayUsingSelector:@selector(compare:)];
}

- (NSComparisonResult)compare:(ScheduledEvent *)anotherEvent
{
    return [self.date compare:anotherEvent.date];
}

@end
