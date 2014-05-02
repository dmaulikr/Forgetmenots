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

+(Flower*)forgetmenot
{
    return [[Flower alloc] initWithName:@"Forgetmenot"];
}
    
+(Flower*)rose
{
    return [[Flower alloc] initWithName:@"Rose"];
}

+(Flower*)tulip
{
    return [[Flower alloc] initWithName:@"Tulip"];
}

+(Flower*)mum
{
    return [[Flower alloc] initWithName:@"Mum"];
}

+(Flower*)sunflower
{
    return [[Flower alloc] initWithName:@"Sunflower"];
}

+(Flower*)amaryllis
{
    return [[Flower alloc] initWithName:@"Amaryllis"];
}

+(Flower*)gerbera
{
    return [[Flower alloc] initWithName:@"Gerbera"];
}

+(Flower*)alstroemeria
{
    return [[Flower alloc] initWithName:@"Alstroemeria"];
}

+(Flower*)lilium
{
    return [[Flower alloc] initWithName:@"Lilium"];
}


+(void)initialize
{
    if (self == [Flower class])
    {
        theFlowers = @[[Flower forgetmenot],
                       [Flower rose],
                       [Flower tulip],
                       [Flower mum],
                       [Flower sunflower],
                       [Flower amaryllis],
                       [Flower gerbera],
                       [Flower alstroemeria],
                       [Flower lilium]];
    }
}

+(NSArray*) flowers
{
    return theFlowers;
}

- (NSString *)description
{
    return self.name;
}

@end
