//
//  FmnFlowersV.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 31.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnFlowersV.h"

@implementation FmnFlowersV

-(void)commonInit
{
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)setFlowers:(NSArray *)flowers
{
    _flowers = flowers;
    [self setNeedsDisplay];
}

#pragma mark Drawing

#define CAPTION_OFFSET 10
#define CAPTION_SIZE 30
#define CAPTION_LINE_HEIGHT (CAPTION_OFFSET + CAPTION_SIZE)

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    CGRect bouquetRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - CAPTION_LINE_HEIGHT);
    
    if ([self.flowers count] > 1)
    {
        [FmnFlowers drawBullseyeFlowersInRect:bouquetRect withFlowers:self.flowers];
    }
    else if ([self.flowers count] == 1)
    {
        [FmnFlowers drawBullseyeFlowerInRect:bouquetRect withFlower:[self.flowers firstObject]];
    }
    else
    {
        [FmnFlowers drawBullseyeChooseFlowerInRect:bouquetRect];
    }
    
    CGRect captionRect = CGRectMake(rect.origin.x, rect.origin.y + rect.size.height - CAPTION_SIZE, rect.size.width, CAPTION_SIZE);
    [self drawNameInRect:captionRect];
}

- (void)drawNameInRect:(CGRect)rect
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *titleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    
    NSString* title = nil;
    if ([self.flowers count] == 1)
    {
        title = ((Flower *)[self.flowers firstObject]).name;
    }
    else if ([self.flowers count] > 1)
    {
        title = @"Bouquet";
    }
    else
    {
        title = @"Choose flowers";
    }
    
    NSAttributedString *titleText = [[NSAttributedString alloc]
                                     initWithString : title
                                     attributes : @{NSFontAttributeName : titleFont,
                                                    NSParagraphStyleAttributeName : paragraphStyle,
                                                    NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [titleText drawInRect:rect];
}

@end
