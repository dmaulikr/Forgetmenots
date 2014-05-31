//
//  Flower.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 28.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Flower : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDictionary * colors;

@end
