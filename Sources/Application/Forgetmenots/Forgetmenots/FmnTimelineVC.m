//
//  TimelineViewController.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 03.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnTimelineVC.h"

#import "Model/ForgetmenotsEvent+Boilerplate.h"
#import "ScheduledEvent+Boilerplate.h"
#import "FmnTimelineV.h"

@interface FmnTimelineVC ()

@property (weak, nonatomic) IBOutlet UINavigationItem *nav;

@property (strong, nonatomic) NSArray *scheduledEvents;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *currentDescription;

@end

@implementation FmnTimelineVC

-(ForgetmenotsAppDelegate *)appDelegate
{
    if (_appDelegate)
    {
        return _appDelegate;
    }
    else
    {
        _appDelegate = (ForgetmenotsAppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return _appDelegate;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSArray *)timelineViews
{
    if (_timelineViews)
    {
        return _timelineViews;
    }
    else
    {
        _timelineViews = [[NSMutableArray alloc] init];
        return _timelineViews;
    }
}

-(NSArray *)scheduledEvents
{
    if (_scheduledEvents)
    {
        return _scheduledEvents;
    }
    else
    {
        NSArray * loadedEvents = [ScheduledEvent allInManagedContext:self.appDelegate.managedObjectContext];
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        _scheduledEvents = [loadedEvents sortedArrayUsingDescriptors:sortDescriptors];
    }
    return _scheduledEvents;
}

-(void)setCurrentlyLookingAt:(int)currentlyLookingAt
{
    if (_currentlyLookingAt != currentlyLookingAt)
    {
        _currentlyLookingAt = currentlyLookingAt;
        
        ScheduledEvent * event = [self.scheduledEvents objectAtIndex:currentlyLookingAt];
        [self.currentDescription setText:event.description];

        [self defocusTimelineViews];
        
        FmnTimelineV * v = [self.timelineViews objectAtIndex:currentlyLookingAt];
        v.focusedEvent = 0;
    }
}

-(int)upcomingEventIndex
{
    if (_upcomingEventIndex)
    {
        return _upcomingEventIndex;
    }
    else
    {
        NSDate * now = [NSDate date];
        for (int i = 0; i < [self.scheduledEvents count]; i++)
        {
            ScheduledEvent * e = [self.scheduledEvents objectAtIndex:i];
            if ([now compare:e.date] == NSOrderedAscending)
            {
                _upcomingEventIndex = i;
                break;
            }
        }
    }
    return _upcomingEventIndex;
}

-(void)putUpDescription
{
    ScheduledEvent * event = [self.scheduledEvents objectAtIndex:self.upcomingEventIndex];
    
    [self.currentDescription setAdjustsFontSizeToFitWidth:NO];
    [self.currentDescription setNumberOfLines:0];
    
    [self.currentDescription setTextColor:[UIColor whiteColor]];
    
    [self.currentDescription setText:event.description];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self scrollToTheUpcomingEvent];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender{
    // sender.isDragging - to differentiate drag from scroll
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //ensure that the end of scroll is fired.
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:1.5];
    
    int currentlyLookingAt;
    
    if (sender.contentOffset.x < FMN_TIMELINE_STEP / 4)
    {
        currentlyLookingAt = 0;
    }
    else if (sender.contentOffset.x + sender.frame.size.width > sender.contentSize.width - FMN_TIMELINE_STEP / 4)
    {
        currentlyLookingAt = [self.scheduledEvents count] - 1;
    }
    else
    {
        currentlyLookingAt = (sender.contentOffset.x + sender.frame.size.width / 2) / FMN_TIMELINE_STEP;
    }
    
    if (self.currentlyLookingAt != currentlyLookingAt && currentlyLookingAt >= 0 && currentlyLookingAt < [self.scheduledEvents count])
    {
        self.currentlyLookingAt = currentlyLookingAt;
    }
}

-(void)defocusTimelineViews
{
    for (FmnTimelineV * v in self.timelineViews)
    {
        if (v.focusedEvent >= 0)
        {
            v.focusedEvent = -1;
        }
    }
}

-(void)scrollToTheUpcomingEvent
{
    int x = self.upcomingEventIndex * FMN_TIMELINE_STEP - _scrollview.frame.size.width / 2;
    int y = _scrollview.contentOffset.y;
    
    if (x < 0)
    {
        if (self.upcomingEventIndex == 0)
        {
            x = 1;
        }
        else
        {
            x = FMN_TIMELINE_STEP / 4 + 2; // filthy assumption that there can be now third extra case
        }
    }
    [_scrollview setContentOffset:CGPointMake(x, y) animated:true];
}

-(void)populateScrollView
{
    //XXX remove only those that are not present in future
    // and do nice autoLayout animation: https://developer.apple.com/library/ios/documentation/userexperience/conceptual/AutolayoutPG/AutoLayoutbyExample/AutoLayoutbyExample.html
    
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (ScheduledEvent * e in self.scheduledEvents)
    {
        NSUInteger i = [self.scheduledEvents indexOfObject:e];
        
        CGRect frame = CGRectMake(FMN_TIMELINE_STEP * i, 0, FMN_TIMELINE_STEP, self.scrollview.frame.size.height);
        FmnTimelineV * v = [[FmnTimelineV alloc]initWithFrame:frame];
        
        [self.timelineViews addObject:v];
        
        [self.scrollview addSubview:v];
        
        v.translatesAutoresizingMaskIntoConstraints = NO;
        [v setBackgroundColor:[UIColor clearColor]];
        [v setOpaque:NO];
        
        [v setScheduledEvents:@[e]];
        
        if (self.upcomingEventIndex == i)
        {
            [v setFocusedEvent:0];
        }
        else
        {
            [v setFocusedEvent:-1];
        }
    }
    
    _scrollview.contentSize = CGSizeMake(FMN_TIMELINE_STEP * [self.scheduledEvents count], self.scrollview.frame.size.height);
    _scrollview.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Background
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = [UIColor clearColor];
    
//    _timelineView = [[FmnTimelineV alloc]initWithFrame:CGRectMake(0, 0, 0, self.scrollview.frame.size.height)];
//    [self.scrollview addSubview:_timelineView];
//    
//    _timelineView.translatesAutoresizingMaskIntoConstraints = NO;
//    [_timelineView setBackgroundColor:[UIColor clearColor]];
//    [_timelineView setOpaque:NO];
//    
//    [_timelineView setScheduledEvents:self.scheduledEvents];
//    [_timelineView setFocusedEvent:self.upcomingEventIndex];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Fix only horizontal scroll with the same height
//    [_scrollview addConstraint:[NSLayoutConstraint constraintWithItem:_timelineView
//                                                            attribute:NSLayoutAttributeHeight
//                                                            relatedBy:NSLayoutRelationEqual
//                                                               toItem:_scrollview
//                                                            attribute:NSLayoutAttributeHeight
//                                                           multiplier:1.0
//                                                             constant:0]];
    
    [self populateScrollView];
    [self scrollToTheUpcomingEvent];

    [self.scrollview setBackgroundColor:[UIColor clearColor]];
//    [self.scrollview setShowsHorizontalScrollIndicator:NO];
    [self.scrollview setShowsVerticalScrollIndicator:NO];
    
    
    [self putUpDescription];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
