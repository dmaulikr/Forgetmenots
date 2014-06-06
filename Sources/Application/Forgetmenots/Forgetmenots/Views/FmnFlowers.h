//
//  FmnFlowers.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 28.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Flower+Defaults.h"

@interface FmnFlowers : NSObject

+ (void)drawBullseyeChooseFlowerInRect:(CGRect)rect;

+ (void)drawBullseyeFlowerInRect:(CGRect)rect withFlower:(Flower *)flower;

+ (void)drawBullseyeFlowersInRect:(CGRect)rest withFlowers:(NSArray *)flowers;

@end
