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

@property  (strong, nonatomic) Flower *flower;
@property (strong, nonatomic) NSString *name;

//whether this event should be treated as a random or not
@property (nonatomic, getter = isRandom) BOOL random;

//fixed event data
@property (strong, nonatomic) NSDate *date;

//random events data
@property (nonatomic) NSInteger howManyTimes;
@property (nonatomic) NSInteger inHowManyTimeUnits;
@property (nonatomic) TimeUnit timeUnit;

@end
