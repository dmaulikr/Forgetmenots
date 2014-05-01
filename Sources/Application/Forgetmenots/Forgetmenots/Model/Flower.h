//
//  Flower.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 01.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flower : NSObject

+(NSArray*)flowers;

@property (strong, nonatomic) NSString *name;

-(Flower*)initWithName:(NSString *)name;

@end
