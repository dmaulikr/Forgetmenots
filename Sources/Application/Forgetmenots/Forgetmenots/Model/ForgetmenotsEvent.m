//
//  ForgetmenotsEvent.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 01.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ForgetmenotsEvent.h"

static NSMutableArray* theAllEvents;

@implementation ForgetmenotsEvent

// So that you'll be able to modify it temporarily
+(NSMutableArray *)allEvents
{
    if (theAllEvents)
    {
        return theAllEvents;
    }
    else
    {
        return [[self sampleEvents] mutableCopy];
    }
}

-(ForgetmenotsEvent *) initWithFlowers:(NSSet *)flowers name:(NSString *)name date:(NSDate *)date
{
    self = [super init];

    self.flowers = flowers;
    self.date = date;
    self.name = name;
    self.random = NO;
    
    return self;
}

-(ForgetmenotsEvent *) initWithFlowers:(NSSet *)flowers name:(NSString *)name nTimes:(NSUInteger)nTimes inTimeUnits:(NSUInteger)timeUnits timeUnit:(TimeUnit)timeUnit withStart:(NSDate *)start
{
    self = [super init];
    
    self.flowers = flowers;
    self.date = nil;
    self.name = name;
    self.nTimes = nTimes;
    self.inTimeUnits = timeUnits;
    self.timeUnit = timeUnit;
    self.start = start;
    self.random = YES;
    
    return self;
}

+(ForgetmenotsEvent*)upcoming
{
    //xxx obviously requires proper implementation here with building timeline and etc.
    return [[ForgetmenotsEvent allEvents] firstObject];
}

+(NSArray *) sampleEvents
{
    return @[
             [[ForgetmenotsEvent alloc] initWithFlowers:[NSSet setWithObjects:[Flower rose], nil]
                                                   name:@"Sis thesis defense"
                                                   date:[NSDate dateWithTimeIntervalSince1970:1399330243]], // 5 may 2014
             
             [[ForgetmenotsEvent alloc] initWithFlowers:[NSSet setWithObjects:[Flower forgetmenot], [Flower tulip], nil]
                                                   name:@"Ally's birhtday"
                                                   date:[NSDate dateWithTimeIntervalSince1970:1400107843]], // 14 may 2014
             
             [[ForgetmenotsEvent alloc] initWithFlowers:[NSSet setWithObjects:[Flower forgetmenot], [Flower tulip], nil]
                                                   name:@"New House"
                                                   date:[NSDate dateWithTimeIntervalSince1970:1401663043]], // 1 june 2014
             
             [[ForgetmenotsEvent alloc] initWithFlowers:[NSSet setWithObjects:[Flower lilium], [Flower amaryllis], nil]
                                                   name:@"Ally Monthly"
                                                 nTimes:2
                                            inTimeUnits:1
                                               timeUnit:MONTH
                                              withStart:[NSDate date]],
             
             [[ForgetmenotsEvent alloc] initWithFlowers:[NSSet setWithObjects:[Flower lilium], [Flower amaryllis], nil]
                                                   name:@"Karma flowers"
                                                 nTimes:1
                                            inTimeUnits:3
                                               timeUnit:WEEK
                                              withStart:[NSDate date]]
             
             ];
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
        return [NSString stringWithFormat:@"%lu times in %lu %@s", (unsigned long)nTimes + 1, (unsigned long)inTimeUnits + 1, [ForgetmenotsEvent timeUnitName:timeUnit]];
    }
}


-(NSString *)timeData
{
    return [ForgetmenotsEvent timeData:self.date nTimes:self.nTimes inExact:self.inTimeUnits timeUnits:self.timeUnit];
}

@end
