//
//  ScheduledEvent+Boilerplate.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 26.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ScheduledEvent+Boilerplate.h"
#import "Flower+Defaults.h"

@implementation ScheduledEvent (Boilerplate)

#pragma mark - Schedulling Local Notifications

-(void)scheduleLocalNotification
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = self.date;
    notification.alertBody = self.name;
    notification.userInfo = @{ NOTIFICATION_NAME: self.name };
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

+(NSArray *)notificationsByName:(NSString *)name withNotifications:(NSArray *)notifications
{
    NSMutableArray * result = [[NSMutableArray alloc]init];
    
    for (UILocalNotification * n in notifications)
    {
        if ([[n.userInfo valueForKey:NOTIFICATION_NAME] isEqualToString:name])
        {
            [result addObject:n];
        }
    }
    
    return [result copy];
}

-(void)prepareForDeletion
{
    NSArray * allRelevant = [ScheduledEvent notificationsByName:self.name
                                              withNotifications:[[UIApplication sharedApplication] scheduledLocalNotifications]];
    
    for (UILocalNotification * n in allRelevant)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:n];
    }
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
        NSDate * now = [NSDate date];
        for (ScheduledEvent* event in matches)
        {
            if ([event.date compare:now] == NSOrderedAscending)
            {
                [context deleteObject:event];
            }
        }
        [context save:nil];
    }
}

+(void)deleteAllInManagedContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ScheduledEvent"];
    request.predicate = [NSPredicate predicateWithFormat:@"name != nil"];
    
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

+(NSDate *)date:(NSDate *)date AtHour:(int)hour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
    [components setHour:hour];
    return [calendar dateFromComponents:components];
}

+(NSDate *)yearLaterDate:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:dateComponents toDate:date options:0];
}

+(NSArray *) planAheadEventsWithForgetmenotsEvent:(ForgetmenotsEvent *)event fromDate:(NSDate *)date
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    if (event)
    {
        NSTimeInterval start = [date timeIntervalSince1970];
        if ([event.random boolValue]) {
            long step = [event.timeUnit longValue] * [event.inTimeUnits longValue] / [event.nTimes longValue];
            if (step < DAY)
            {
                step = DAY;
            }
            
            // Schedule at 5 pm PLANAHEAD_NUMBER times
            for (int i = 0; i < PLANAHEAD_NUMBER; i++)
            {
                // XXX todo add random factor, like +-2 days if TIME_UNIT > week
                NSDate* eventDate = [[NSDate alloc] initWithTimeIntervalSince1970:start + (i + 1) * step];
                eventDate = [ScheduledEvent date:eventDate AtHour:17];
                
                [result addObject:[ScheduledEvent initWithFlowers:event.flowers
                                                             name:event.name
                                                             date:eventDate
                                                 inManagedContext:event.managedObjectContext]];
            }
        }
        else
        {
            NSDate* eventDate = [[NSDate alloc] initWithTimeIntervalSince1970:start];
            eventDate = [ScheduledEvent date:eventDate AtHour:9];
            // Schedule PLANAHEAD_NUMBER consequent notifications each year at 9 am
            if ([[NSDate date] compare:eventDate] == NSOrderedAscending)
            {
                // We are cool
            }
            else
            {
                // Starting next year
                eventDate = [ScheduledEvent yearLaterDate:date];
            }
            for (int i = 0; i < PLANAHEAD_NUMBER; i++)
            {
                [result addObject:[ScheduledEvent initWithFlowers:event.flowers
                                                             name:event.name
                                                             date:eventDate
                                                 inManagedContext:event.managedObjectContext]];
                eventDate = [ScheduledEvent yearLaterDate:eventDate];
            }
        }
    }
    
    return [result sortedArrayUsingSelector:@selector(compare:)];
}

- (NSComparisonResult)compare:(ScheduledEvent *)anotherEvent
{
    return [self.date compare:anotherEvent.date];
}

+(NSArray *)allInManagedContext:(NSManagedObjectContext *)context
{
    NSArray *result = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ScheduledEvent"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"name != nil"]];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error){
        // handle error
    }
    else if ([matches count])
    {
        result = matches;
    }
    else
    {
        //nothing here
    }
    
    return result;
}

- (NSString *)description
{
    NSMutableArray *chosenFlowers = [[NSMutableArray alloc] init];
    for (Flower *f in self.flowers)
    {
        [chosenFlowers addObject:f.name];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"dd MMMM yy" options:0 locale:[NSLocale currentLocale]]];
    NSString * dateString = [dateFormatter stringFromDate:self.date];
    
    NSString * flowersString = [chosenFlowers componentsJoinedByString:@", "];
    return [NSString stringWithFormat: @"%@\n%@\n%@", self.name, dateString, flowersString];
}

@end
