//
//  FmnFlowers.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 28.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnFlowers.h"
#include <math.h>
#include "FmnMisc.h"

@implementation FmnFlowers

#define CIRCLE_STEP 5

//+ (void) drawRect:(CGRect)rect
//{
//    // Create a gradient from white to red
//    CGFloat colors [] = {
//        1.0, 1.0, 1.0, 1.0,
//        1.0, 0.0, 0.0, 1.0
//    };
//    
//    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
//    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
//    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSaveGState(context);
//    CGContextAddEllipseInRect(context, rect);
//    CGContextClip(context);
//    
//    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
//    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
//    
//    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
//    CGGradientRelease(gradient), gradient = NULL;
//    
//    CGContextRestoreGState(context);
//    
//    CGContextAddEllipseInRect(context, rect);
//    CGContextDrawPath(context, kCGPathStroke);
//}

+ (void)drawGradientFilledPath:(UIBezierPath *)path withTopColor:(UIColor *)topColor andBottomColor:(UIColor *)bottomColor
{
    CGContextRef gc = UIGraphicsGetCurrentContext();
    CGContextSaveGState(gc); {
        [path addClip];
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient =
            CGGradientCreateWithColors(rgb,
                                       (__bridge CFArrayRef)@[(__bridge id)topColor.CGColor, (__bridge id)bottomColor.CGColor],
                                       (CGFloat[]){ 0.0f, 1.0f });
        CGColorSpaceRelease(rgb);
        
        CGPoint start = CGPointMake(path.bounds.origin.x + path.bounds.size.width / 2, path.bounds.origin.y);
        CGPoint end = CGPointMake(path.bounds.origin.x + path.bounds.size.width / 2, path.bounds.origin.y + path.bounds.size.height);
        
        CGContextClip(gc);
        
        CGContextDrawLinearGradient(gc, gradient, start, end, 0);
        
        CGGradientRelease(gradient);
    } CGContextRestoreGState(gc);
}

#define CENTRAL_CIRCLE_BIGGER_COEFF 0.9

+ (void)drawBullseyeFlowerInRect:(CGRect)rect withColors:(NSDictionary *)colors
{
    CGFloat flowerSize = fmin(rect.size.width, rect.size.height);
    CGRect flowerRect = CGRectMake(rect.origin.x + (rect.size.width - flowerSize) / 2,
                                   rect.origin.y + (rect.size.height - flowerSize) / 2,
                                   flowerSize,
                                   flowerSize);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:flowerRect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [circle addClip];
    
    [FmnFlowers drawGradientFilledPath:circle withTopColor:[colors valueForKeyPath:@"first.top"] andBottomColor:[colors valueForKeyPath:@"first.bottom"]];
    
    CGFloat step = flowerSize / CIRCLE_STEP;
    
    CGRect innerRect = CGRectInset(flowerRect, step, step);
    if ([colors valueForKeyPath:@"second.top"] == [NSNull null] || [colors valueForKeyPath:@"second.bottom"] == [NSNull null])
    {
        // do nothing
    }
    else
    {
        UIBezierPath *innerCircle = [UIBezierPath bezierPathWithOvalInRect:innerRect];
        [FmnFlowers drawGradientFilledPath:innerCircle withTopColor:[colors valueForKeyPath:@"second.top"] andBottomColor:[colors valueForKeyPath:@"second.bottom"]];
    }
    
    if ([colors valueForKeyPath:@"third.top"] == [NSNull null] || [colors valueForKeyPath:@"third.bottom"] == [NSNull null])
    {
        // do nothing
    }
    else
    {
        CGRect centerRect = CGRectInset(innerRect, step * CENTRAL_CIRCLE_BIGGER_COEFF, step * CENTRAL_CIRCLE_BIGGER_COEFF);
        UIBezierPath *centerCircle = [UIBezierPath bezierPathWithOvalInRect:centerRect];
        [FmnFlowers drawGradientFilledPath:centerCircle withTopColor:[colors valueForKeyPath:@"third.top"] andBottomColor:[colors valueForKeyPath:@"third.bottom"]];
    }
    
    CGRect blingRect = CGRectMake(flowerRect.origin.x,
                                  flowerRect.origin.y,
                                  flowerRect.size.width / 2,
                                  flowerRect.size.height);
    UIBezierPath *bling = [UIBezierPath bezierPathWithRect:blingRect];
    [[[UIColor alloc] initWithWhite:1.0 alpha:0.26] setFill];
    [bling fill];
    
    CGContextRestoreGState(context);
}

+(void)drawBullseyeChooseFlowerInRect:(CGRect)rect
{
    CGFloat flowerSize = fmin(rect.size.width, rect.size.height);
    CGRect flowerRect = CGRectMake(rect.origin.x + (rect.size.width - flowerSize) / 2,
                                   rect.origin.y + (rect.size.height - flowerSize) / 2,
                                   flowerSize,
                                   flowerSize);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:flowerRect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [[UIColor whiteColor] setStroke];
    [circle setLineWidth:1.0];
    [circle stroke];
    
    // Render '+' sign
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    
    NSString * plusSign = @"+";

//    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *textAttrs = @{NSFontAttributeName : [UIFont fontWithName:@"Didot" size:57.0],
                                NSParagraphStyleAttributeName : paragraphStyle,
                                NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSAttributedString *plusSignText = [[NSAttributedString alloc]
                                     initWithString : plusSign
                                     attributes : textAttrs];
    
    CGSize textSize = [plusSign sizeWithAttributes:textAttrs];
    CGRect textFrame = CGRectMake(rect.size.width / 2 - textSize.width / 2,
                                  rect.size.height / 2 - textSize.height / 2,
                                  textSize.width, textSize.height);
    [plusSignText drawInRect:textFrame];
    
//    NSDictionary *attr = [NSDictionary dictionaryWithObject:style forKey:NSParagraphStyleAttributeName];
//    [@"+" drawInRect:rect withAttributes:attr];
    
    CGContextRestoreGState(context);
}

@end
