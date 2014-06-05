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

@implementation FmnTimelineV

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define STEP_SIZE 44

-(void)resize
{
    CGFloat width = [self.scheduledEvents count] * STEP_SIZE;
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
    int startFromEvent = rect.origin.x / STEP_SIZE;
    int endWithEvent = (rect.origin.x + rect.size.width) / STEP_SIZE + 1;
    
    if (endWithEvent > [self.scheduledEvents count])
    {
        endWithEvent = [self.scheduledEvents count] - 1;
    }
    
    UIBezierPath *viewRect = [UIBezierPath bezierPathWithRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [viewRect addClip];
    
    for (int i = startFromEvent; i <= endWithEvent; i++)
    {
        ScheduledEvent * e = [self.scheduledEvents objectAtIndex:i];
        
        NSLog(@"%d", i);
        NSLog(@"event name %@", e.name);
        
        CGRect eRect = CGRectMake(i * STEP_SIZE, rect.origin.y + rect.size.height * 0.5, 22, 22);
        
        
        NSDictionary * flowerColors = ((Flower *)[[e.flowers allObjects] objectAtIndex:0]).colors;
        [FmnFlowers drawBullseyeFlowerInRect:eRect withColors:flowerColors];
        //draw each event
        
        //    draw flowers
        
        //    draw stalk
        
        //    write date
    }
    
    //draw timeline, the line itself
    
    //draw scale
    
    CGContextRestoreGState(context);
}


@end
