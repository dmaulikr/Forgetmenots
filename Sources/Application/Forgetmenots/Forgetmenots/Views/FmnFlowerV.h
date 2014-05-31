//
//  FlowerView.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 11.04.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flower+Defaults.h"

@interface FmnFlowerV : UIView

@property (strong, nonatomic) Flower * flower;
@property (nonatomic) BOOL selected;

@end
