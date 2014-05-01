//
//  Flower.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 01.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "Flower.h"

static NSArray* theFlowers;

@implementation Flower

-(Flower*)initWithName:(NSString *)name
{
    self = [super init];
    
    self.name = name;
    
    return self;
}


+(void)initialize
{
    if (self == [Flower class])
    {
        theFlowers = @[[[Flower alloc] initWithName:@"Rose"],
                       [[Flower alloc] initWithName:@"Tulip"]];
    }
}

+(NSArray*) flowers
{
    return theFlowers;
}

@end
