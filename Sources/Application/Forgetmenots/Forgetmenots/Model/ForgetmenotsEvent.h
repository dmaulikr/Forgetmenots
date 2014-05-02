//
//  ForgetmenotsEvent.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 01.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "Flower.h"

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TimeUnit)
{
    DAY,
    WEEK,
    MONTH,
    YEAR
};

@interface ForgetmenotsEvent : NSObject

@property  (strong, nonatomic) NSSet *flowers;
@property (strong, nonatomic) NSString *name;

//whether this event should be treated as a random or not
@property (nonatomic, getter = isRandom) BOOL random;

//fixed event data
@property (strong, nonatomic) NSDate *date;

//random events data
@property (nonatomic) NSUInteger nTimes;
@property (nonatomic) NSUInteger inTimeUnits;
@property (nonatomic) TimeUnit timeUnit;

-(ForgetmenotsEvent *)initWithFlowers:(NSSet *)flowers
                                name:(NSString *)name
                                date:(NSDate *)date;

-(ForgetmenotsEvent *)initWithFlowers:(NSSet *)flowers
                                name:(NSString * )name
                              nTimes:(NSUInteger)nTimes
                         inTimeUnits:(NSUInteger)timeUnits
                            timeUnit:(TimeUnit)timeUnit;

+(ForgetmenotsEvent*)upcoming;

+(NSArray*) allEvents;

@end
