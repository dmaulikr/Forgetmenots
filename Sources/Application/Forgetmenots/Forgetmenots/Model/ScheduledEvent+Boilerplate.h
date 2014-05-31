//
//  ScheduledEvent+Boilerplate.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 26.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ScheduledEvent.h"
#import "ForgetmenotsEvent+Boilerplate.h"

@interface ScheduledEvent (Boilerplate)

+(ScheduledEvent *) initWithFlowers:(NSSet *)flowers
                               name:(NSString *)name
                               date:(NSDate *)date
                   inManagedContext:(NSManagedObjectContext *)context;

+(NSArray *) planEventsWithForgetmenotsEvent:(ForgetmenotsEvent *)fmnEvent;

+(void) deleteAllWithName:(NSString *)name inManagedContext:(NSManagedObjectContext *)context;

@end
