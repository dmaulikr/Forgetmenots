//
//  FmnTimelineV.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 04.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnTimelineElementV.h"
#import "ScheduledEvent+Boilerplate.h"
#import "FmnFlowers.h"
#import "FmnMisc.h"

@implementation FmnTimelineElementV

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(NSDateFormatter *)dateFormatter
{
    if (_dateFormatter)
    {
        return _dateFormatter;
    }
    else
    {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"dd MMMM yy"];
    }
    return _dateFormatter;
}

-(void)setFocused:(BOOL)focused
{
    _focused = focused;
    [self setNeedsDisplay];
}

-(void)setEvent:(ScheduledEvent *)event
{
    _event = event;
    [self setNeedsDisplay];
}

-(void)setInactive:(BOOL)inactive
{
    _inactive = inactive;
    [self setNeedsDisplay];
}

//-(void)animate
//{
//    if (self.focusedEvent >= 0){
//        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        
//        // Set the initial and the final values
//        [animation setFromValue:[NSNumber numberWithFloat:1.5f]];
//        [animation setToValue:[NSNumber numberWithFloat:1.f]];
//        
//        // Set duration
//        [animation setDuration:0.5f];
//        
//        // Set animation to be consistent on completion
//        [animation setRemovedOnCompletion:NO];
//        [animation setFillMode:kCAFillModeForwards];
//        
//        animation.autoreverses = YES;
//        
//        // Add animation to the view's layer
//        [[self layer] addAnimation:animation forKey:@"scale"];
//    }
//}

- (void)drawRect:(CGRect)rect
{
    //Drawing everything to memmory and then rendering it (to apply filters, night we want to)
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(rect.size.width, rect.size.height), NO, 0.0);
    CGContextRef wrapperContext = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(wrapperContext);
    
    //XXX What the heck was I doing this for? - begin
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
    
    CGFloat unit = rect.size.height * 0.1;
    
    CGFloat timelineHeight = rect.origin.y + rect.size.height * 0.9;
    
    CGFloat x = FMN_TIMELINE_STEP / 2;
        
    CGFloat stalkWidth;
    CGFloat dotR;

    CGFloat top;
    CGFloat bottom;
    CGFloat r;
    CGRect flowerRect;
    if (self.focused)
    {
        top = rect.origin.y;
        bottom = top + rect.size.height * 0.5;
        r = (bottom - top) / 2;
        stalkWidth = 6.0f;
        dotR = 5.0f;
    }
    else
    {
        top = rect.origin.y + rect.size.height * 0.4;
        bottom = top + rect.size.height * 0.3;
        r = (bottom - top) / 2;
        stalkWidth = 3.0f;
        dotR = 2.0f;
    }
        
    if (r > FMN_TIMELINE_STEP / 2) {
        r = FMN_TIMELINE_STEP / 2;
    }
        
    // Drawing stalk
    UIBezierPath * stalk = [UIBezierPath bezierPath];
    stalk.lineWidth = stalkWidth;
    [stalk moveToPoint:CGPointMake(x, bottom - r)];
    [stalk addLineToPoint:CGPointMake(x, timelineHeight)];
    [UIColorFromRGB(0x4CD964) setStroke];
    [stalk stroke];
    
    // Drawing bouqet
    flowerRect = CGRectMake(x - r, top, 2 * r, 2 * r);
    [FmnFlowers drawBullseyeFlowersInRect:flowerRect withFlowers:[self.event.flowers allObjects]];
    
    
    // Drawing complete, grab the image now
    UIGraphicsPopContext();
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (self.inactive)
    {
        outputImage = [FmnMisc imageToGreyImage:outputImage];
    }
    [outputImage drawInRect:rect];

    // Bottom dot
    CGRect dotRect = CGRectMake(x - dotR, timelineHeight - dotR, dotR * 2, dotR * 2);
    UIBezierPath * dot = [UIBezierPath bezierPathWithOvalInRect:dotRect];
    [[UIColor whiteColor] setFill];
    [dot fill];
    
    // Drawing date
    CGRect dateRect = CGRectMake(x - FMN_TIMELINE_STEP / 2, timelineHeight + unit / 4, FMN_TIMELINE_STEP, timelineHeight + unit / 4 + unit);
    [self drawDate:self.event.date inRect:dateRect];

    // Drawing time line
    UIBezierPath * timeLine = [UIBezierPath bezierPath];
    timeLine.lineWidth = 1.0f;
    [timeLine moveToPoint:CGPointMake(rect.origin.x, timelineHeight)];
    [timeLine addLineToPoint:CGPointMake(rect.origin.x + rect.size.width, timelineHeight)];
    [[UIColor whiteColor] setStroke];
    [timeLine stroke];
    
    //XXX What the heck was I doing this for? - end    
//    CGContextRestoreGState(context);
}

- (void)drawDate:(NSDate *)date inRect:(CGRect)rect
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    titleFont = [titleFont fontWithSize:14.0f];
    
    NSString* title = [self.dateFormatter stringFromDate:date];
    
    if (! title)
    {
        title = @"N/A";
    }
    
    NSAttributedString *titleText = [[NSAttributedString alloc]
                                     initWithString : title
                                     attributes : @{NSFontAttributeName : titleFont,
                                                    NSParagraphStyleAttributeName : paragraphStyle,
                                                    NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [titleText drawInRect:rect];
}

@end
