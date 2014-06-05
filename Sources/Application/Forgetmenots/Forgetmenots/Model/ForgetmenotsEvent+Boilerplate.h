//
//  ForgetmenotsEvent+Boilerplate.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 22.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ForgetmenotsEvent.h"

typedef NS_ENUM(NSUInteger, TimeUnit)
{
    DAY = 86400,
    WEEK = 604800,
    MONTH = 2629740,
    YEAR = 31556900
};

@interface ForgetmenotsEvent (Boilerplate)

+(ForgetmenotsEvent *)initWithFlowers:(NSSet *)flowers
                                 name:(NSString *)name
                                 date:(NSDate *)date
                     inManagedContext:(NSManagedObjectContext *)context;

+(ForgetmenotsEvent *)initWithFlowers:(NSSet *)flowers
                                 name:(NSString *)name
                               nTimes:(NSUInteger)nTimes
                          inTimeUnits:(NSUInteger)timeUnits
                             timeUnit:(TimeUnit)timeUnit
                            withStart:(NSDate *)start
                     inManagedContext:(NSManagedObjectContext *)context;

-(NSString *)timeData;

+(NSString *)timeData:(NSDate *)date nTimes:(NSUInteger)nTimes inExact:(NSUInteger)inTimeUnits timeUnits:(TimeUnit)timeUnit;

+(NSArray*)allInManagedContext:(NSManagedObjectContext *)context;

@end
