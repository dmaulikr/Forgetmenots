//
//  ForgetmenotsEvent.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 21.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ForgetmenotsEvent : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * random;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * nTimes;
@property (nonatomic, retain) NSNumber * inTimeUnits;
@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSNumber * timeUnit;
@property (nonatomic, retain) NSSet *flowers;
@end

@interface ForgetmenotsEvent (CoreDataGeneratedAccessors)

- (void)addFlowersObject:(NSManagedObject *)value;
- (void)removeFlowersObject:(NSManagedObject *)value;
- (void)addFlowers:(NSSet *)values;
- (void)removeFlowers:(NSSet *)values;

@end
