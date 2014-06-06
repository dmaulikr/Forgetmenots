//
//  FmnTimelineV.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 04.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnTimelineV.h"
#import "ScheduledEvent+Boilerplate.h"
#import "FmnFlowers.h"
#import "FmnMisc.h"

@implementation FmnTimelineV

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

#define STEP 88

-(CGFloat)step
{
    if (_step)
    {
        return _step;
    }
    else
    {
//        _step = self.superview.frame.size.width / 2.1f;
        _step = STEP;
    }
    return _step;
}

-(void)resize
{
    CGFloat width = [self.scheduledEvents count] * self.step;
    CGRect newFrame = CGRectMake(self.frame.origin.x,
                                 self.frame.origin.y,
                                 width,
                                 self.frame.size.height);
    
    UIView * superview = self.superview;
    
    if ([superview isKindOfClass:[UIScrollView class]])
    {
        UIScrollView * scrollview =(UIScrollView *)self.superview;
        
        [scrollview setContentSize:newFrame.size];
    }
    
    [self setFrame:newFrame];
}

-(void)setScheduledEvents:(NSArray *)scheduledEvents
{
    BOOL shouldResize = [_scheduledEvents count] != [scheduledEvents count];
    
    _scheduledEvents = scheduledEvents;
    
    if (shouldResize)
    {
        [self resize];
    }
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSLog(@"Origin is at %f %f", rect.origin.x, rect.origin.y);
    int startFromEvent = rect.origin.x / self.step;
    int endWithEvent = (rect.origin.x + rect.size.width) / self.step + 1;
    
    if (endWithEvent > [self.scheduledEvents count])
    {
        endWithEvent = [self.scheduledEvents count] - 1;
    }
    
    UIBezierPath *viewRect = [UIBezierPath bezierPathWithRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [viewRect addClip];
    
    CGFloat unit = rect.size.height * 0.1;
    
    CGFloat timelineHeight = rect.origin.y + rect.size.height * 0.9;
    
    for (int i = startFromEvent; i <= endWithEvent; i++)
    {
        ScheduledEvent * e = [self.scheduledEvents objectAtIndex:i];
        
        CGFloat x = i * self.step + self.step / 2;
        
        CGFloat stalkWidth;
        
        CGFloat dotR;

        CGFloat top;
        CGFloat bottom;
        CGFloat r;
        CGRect flowerRect;
        if (i == self.focusedEvent)
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
        
        // Drawing stalk
        UIBezierPath * stalk = [UIBezierPath bezierPath];
        stalk.lineWidth = stalkWidth;
        [stalk moveToPoint:CGPointMake(x, bottom - r)];
        [stalk addLineToPoint:CGPointMake(x, timelineHeight)];
        [UIColorFromRGB(0x4CD964) setStroke];
        [stalk stroke];
        
        // Bottom dot
        CGRect dotRect = CGRectMake(x - dotR, timelineHeight - dotR, dotR * 2, dotR * 2);
        UIBezierPath * dot = [UIBezierPath bezierPathWithOvalInRect:dotRect];
        [[UIColor whiteColor] setFill];
        [dot fill];
        
        // Drawing bouqet
        flowerRect = CGRectMake(x - r, top, 2 * r, 2 * r);
        [FmnFlowers drawBullseyeFlowersInRect:flowerRect withFlowers:[e.flowers allObjects]];
        
        // Drawing date
        CGRect dateRect = CGRectMake(x - r, timelineHeight + unit / 4, 2 * r, timelineHeight + unit / 4 + unit);
        [self drawDate:e.date inRect:dateRect];
        
        NSLog(@"%d", i);
        NSLog(@"event name %@", e.name);
    }
    
    // Drawing time line
    UIBezierPath * timeLine = [UIBezierPath bezierPath];
    timeLine.lineWidth = 1.0f;
    [timeLine moveToPoint:CGPointMake(rect.origin.x, timelineHeight)];
    [timeLine addLineToPoint:CGPointMake(rect.origin.x + rect.size.width, timelineHeight)];
    [[UIColor whiteColor] setStroke];
    [timeLine stroke];
    
    CGContextRestoreGState(context);
}

- (void)drawDate:(NSDate *)date inRect:(CGRect)rect
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    titleFont = [titleFont fontWithSize:9.0f];
    
    // XXX nice date
    NSString* title = [self.dateFormatter stringFromDate:date];
    
    NSAttributedString *titleText = [[NSAttributedString alloc]
                                     initWithString : title
                                     attributes : @{NSFontAttributeName : titleFont,
                                                    NSParagraphStyleAttributeName : paragraphStyle,
                                                    NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [titleText drawInRect:rect];
}



@end