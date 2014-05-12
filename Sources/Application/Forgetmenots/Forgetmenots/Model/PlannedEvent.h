//
//  PlannedEvent.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 06.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForgetmenotsEvent.h"

@interface PlannedEvent : NSObject

@property  (strong, nonatomic) NSSet *flowers;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *date;

-(PlannedEvent *) initWithFlowers:(NSSet *)flowers
                                 name:(NSString *)name
                                 date:(NSDate *)date;

+(NSArray *) planEventsWithForgetmenotsEventArray:(NSArray *)forgetmenotsEvents;

@end
