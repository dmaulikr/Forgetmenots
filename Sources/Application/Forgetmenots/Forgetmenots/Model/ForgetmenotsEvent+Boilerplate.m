//
//  ForgetmenotsEvent+Boilerplate.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 22.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ForgetmenotsEvent+Boilerplate.h"
#import "ScheduledEvent+Boilerplate.h"

static NSMutableArray* theAllEvents;

@implementation ForgetmenotsEvent (Boilerplate)

-(void)prepareForDeletion
{
    [ScheduledEvent deleteAllWithName:self.name inManagedContext:self.managedObjectContext];
}

+(ForgetmenotsEvent*)existsWithName:(NSString *)name
        inManagedContext:(NSManagedObjectContext *)context
{
    ForgetmenotsEvent *event= nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ForgetmenotsEvent"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    
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
        event = [NSEntityDescription insertNewObjectForEntityForName:@"ForgetmenotsEvent" inManagedObjectContext:context];
        event.name = name;
        
        //init will come later
    }    
    
    return event;
}

+(void)saveAndTrigger:(ForgetmenotsEvent *)fmnEvent
{
    NSError *error = nil;
    if (![fmnEvent.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // Take some action!
    }
    else
    {
        if ([fmnEvent.random boolValue])
        {
            [ScheduledEvent planAheadEventsWithForgetmenotsEvent:fmnEvent fromDate:fmnEvent.start];
        }
        else
        {
            [ScheduledEvent planAheadEventsWithForgetmenotsEvent:fmnEvent fromDate:fmnEvent.date];
        }
    }
}

+(ForgetmenotsEvent *) initWithFlowers:(NSSet *)flowers name:(NSString *)name date:(NSDate *)date inManagedContext:(NSManagedObjectContext *)context
{
    ForgetmenotsEvent *event = [ForgetmenotsEvent existsWithName:name inManagedContext:context];
    
    event.flowers = flowers;
    event.date = date;
    event.name = name;
    event.random = NO;
    
    [ForgetmenotsEvent saveAndTrigger:event];
    
    return event;
}

+(ForgetmenotsEvent *) initWithFlowers:(NSSet *)flowers name:(NSString *)name nTimes:(NSUInteger)nTimes inTimeUnits:(NSUInteger)timeUnits timeUnit:(TimeUnit)timeUnit withStart:(NSDate *)start inManagedContext:(NSManagedObjectContext *)context
{
    ForgetmenotsEvent *event = [ForgetmenotsEvent existsWithName:name inManagedContext:context];
    
    event.flowers = flowers;
    event.date = nil;
    event.name = name;
    event.nTimes = [NSNumber numberWithInteger:nTimes];
    event.inTimeUnits = [NSNumber numberWithInteger:timeUnits];
    event.timeUnit = [NSNumber numberWithInteger:timeUnit];
    event.start = start;
    event.random = [NSNumber numberWithBool:YES];
    
    [ForgetmenotsEvent saveAndTrigger:event];
    
    return event;
}

+(NSArray*)allInManagedContext:(NSManagedObjectContext *)context
{
    NSArray *result = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ForgetmenotsEvent"];
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
    return [NSString stringWithFormat:@"%@, flowers: %@, %@", self.name, self.flowers, [self timeData]];
}

+(NSString *)timeUnitName:(TimeUnit)timeUnit
{
    switch (timeUnit) {
        case DAY:
            return @"day";
            break;
            
        case WEEK:
            return @"week";
            break;
            
        case MONTH:
            return @"month";
            break;
            
        case YEAR:
            return @"year";
            break;
            
        default:
            return @"undefined";
            break;
    }
}

+(NSString *)timeData:(NSDate *)date nTimes:(NSUInteger)nTimes inExact:(NSUInteger)inTimeUnits timeUnits:(TimeUnit)timeUnit
{
    if (date)
    {
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"dd MMMM yyyy"];
        return [df stringFromDate:date];
    }
    else
    {
        return [NSString stringWithFormat:@"%lu times in %lu %@s", (unsigned long)nTimes, (unsigned long)inTimeUnits, [ForgetmenotsEvent timeUnitName:timeUnit]];
    }
}


-(NSString *)timeData
{
    return [ForgetmenotsEvent timeData:self.date
                                nTimes:[self.nTimes intValue]
                               inExact:[self.inTimeUnits intValue]
                             timeUnits:[self.timeUnit intValue]];
}


@end
