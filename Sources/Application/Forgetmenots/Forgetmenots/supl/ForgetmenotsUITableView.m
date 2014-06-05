//
//  ForgetmenotsUITableView.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 10.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ForgetmenotsUITableView.h"
#import "FmnCreateEditEventTVC.h"

@implementation ForgetmenotsUITableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.titleTextField isFirstResponder] && [touch view] != self.titleTextField) {
        [self.titleTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end