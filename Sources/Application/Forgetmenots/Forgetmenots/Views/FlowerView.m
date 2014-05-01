//
//  FlowerView.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 11.04.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FlowerView.h"
#include <math.h>

@implementation FlowerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setName:(NSString *)name
{
    _name = name;
    [self setNeedsDisplay];
}

#pragma mark Drawing

#define CIRCLE_STEP 6
#define IMAGE_TO_NAME_RATIO 7

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    CGFloat offset = self.bounds.size.height / IMAGE_TO_NAME_RATIO;
    CGFloat flowerSize = fmin(self.bounds.size.width - offset, self.bounds.size.height - offset);
    CGRect flowerRect = CGRectMake(self.bounds.origin.x + (self.bounds.size.width - flowerSize) / 2,
                                   self.bounds.origin.y,
                                   flowerSize,
                                   flowerSize);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:flowerRect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [circle addClip];
    
    [[UIColor blueColor] setFill];
    [circle fill];
    
    CGFloat xStep = self.bounds.size.width / CIRCLE_STEP;
    CGFloat yStep = self.bounds.size.height / CIRCLE_STEP;
    
    CGRect innerRect = CGRectInset(flowerRect, xStep, yStep);
    UIBezierPath *innerCircle = [UIBezierPath bezierPathWithOvalInRect:innerRect];
    [[UIColor lightGrayColor] setFill];
    [innerCircle fill];
    
    CGRect centerRect = CGRectInset(innerRect, xStep, yStep);
    UIBezierPath *centerCircle = [UIBezierPath bezierPathWithOvalInRect:centerRect];
    [[UIColor yellowColor] setFill];
    [centerCircle fill];
    
    CGRect blingRect = CGRectMake(flowerRect.origin.x,
                                  flowerRect.origin.y,
                                  flowerRect.size.width / 2,
                                  flowerRect.size.height);
    UIBezierPath *bling = [UIBezierPath bezierPathWithRect:blingRect];
    [[[UIColor alloc] initWithWhite:1.0 alpha:0.5] setFill];
    [bling fill];
    
    CGContextRestoreGState(context);
    
    [self drawName];
    
}

- (void)drawName
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
//    titleFont = [titleFont fontWithSize:titleFont.pointSize * [self cornerScaleFactor]];
    
    NSAttributedString *titleText = [[NSAttributedString alloc]
                                     initWithString : @"Forgetmenots"
                                     attributes : @{NSFontAttributeName : titleFont,
                                                  NSParagraphStyleAttributeName : paragraphStyle,
                                                    NSForegroundColorAttributeName: [UIColor grayColor]}];
    
    CGRect textBounds;
    CGFloat titleHeight = self.bounds.size.height / IMAGE_TO_NAME_RATIO;
    textBounds.origin = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height - titleHeight);
    textBounds.size = CGSizeMake(self.bounds.size.width, titleHeight);
    [[UIColor grayColor] setStroke];
    [titleText drawInRect:textBounds];
}

@end
