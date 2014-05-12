//
//  PlannedEvent.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 06.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "PlannedEvent.h"
#import "ForgetmenotsEvent.h"

@implementation PlannedEvent

-(PlannedEvent *) initWithFlowers:(NSSet *)flowers
                             name:(NSString *)name
                             date:(NSDate *)date
{
    self = [super init];
    
    self.flowers = flowers;
    self.name = name;
    self.date = date;
    
    return self;
}

#define SECONDS_IN_A_YEAR 31556900

+(NSArray *) planEventsWithForgetmenotsEventArray:(NSArray *)forgetmenotsEvents{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (ForgetmenotsEvent* e in forgetmenotsEvents)
    {
        if (e.isRandom)
        {
            NSTimeInterval startFromEpoch = [e.start timeIntervalSince1970];
            for (int i = 0; i < SECONDS_IN_A_YEAR / e.timeUnit; i++)
            {
                //xxx add actual randomness here, like +- 2 days
                NSDate* randomDate = [[NSDate alloc] initWithTimeIntervalSince1970:startFromEpoch + i * e.timeUnit];
                [result addObject:[[PlannedEvent alloc]initWithFlowers:e.flowers
                                                                  name:e.name
                                                                  date:randomDate]];
            }
        }else {
            [result addObject:[[PlannedEvent alloc] initWithFlowers:e.flowers
                                                              name:e.name
                                                              date:e.date]];
        }
    }
    
    return [result sortedArrayUsingSelector:@selector(compare:)];
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"%@\n%@\n%@", self.name, self.flowers, self.date];
}

- (NSComparisonResult)compare:(PlannedEvent *)anotherEvent
{
    return [self.date compare:anotherEvent.date];
}


@end
