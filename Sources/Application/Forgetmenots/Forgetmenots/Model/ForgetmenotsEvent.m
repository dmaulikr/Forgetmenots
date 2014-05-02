//
//  ForgetmenotsEvent.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 01.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ForgetmenotsEvent.h"

@implementation ForgetmenotsEvent

-(ForgetmenotsEvent *) initWithFlowers:(NSSet *)flowers name:(NSString *)name date:(NSDate *)date
{
    self = [super init];

    self.flowers = flowers;
    self.date = date;
    self.name = name;
    
    return self;
}

-(ForgetmenotsEvent *) initWithFlowers:(NSSet *)flowers name:(NSString *)name nTimes:(NSUInteger)nTimes inTimeUnits:(NSUInteger)timeUnits timeUnit:(TimeUnit)timeUnit
{
    self = [super init];
    
    self.flowers = flowers;
    self.date = nil;
    self.name = name;
    self.nTimes = nTimes;
    self.inTimeUnits = timeUnits;
    self.timeUnit = timeUnit;
    
    return self;
}

+(ForgetmenotsEvent*)upcoming
{
    //xxx obviously requires proper implementation here with building timeline and etc.
    return [[ForgetmenotsEvent allEvents] firstObject];
}

+(NSArray *) allEvents
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
                                                   name:@"Anual monthly flowers for Ally :-)"
                                                 nTimes:2
                                            inTimeUnits:1
                                               timeUnit:MONTH],
             
             [[ForgetmenotsEvent alloc] initWithFlowers:[NSSet setWithObjects:[Flower lilium], [Flower amaryllis], nil]
                                                   name:@"Karma flowers"
                                                 nTimes:1
                                            inTimeUnits:3
                                               timeUnit:WEEK]
             
             ];
}

- (NSString *)description
{
    if (self.date)
    {
        return [NSString stringWithFormat: @"%@\n%@\n%@", self.name, self.flowers, self.date];
    }else {
        //xxx should be proper date calculation here. different object?
        return [NSString stringWithFormat: @"%@\n%@\n%lu in %lu", self.name, self.flowers, (unsigned long)self.nTimes, (unsigned long)self.inTimeUnits];
    }
}

@end
