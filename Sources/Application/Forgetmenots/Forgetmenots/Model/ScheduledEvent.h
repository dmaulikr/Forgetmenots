//
//  ScheduledEvent.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 26.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Flower;

@interface ScheduledEvent : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSSet *flowers;
@end

@interface ScheduledEvent (CoreDataGeneratedAccessors)

- (void)addFlowersObject:(Flower *)value;
- (void)removeFlowersObject:(Flower *)value;
- (void)addFlowers:(NSSet *)values;
- (void)removeFlowers:(NSSet *)values;

@end
