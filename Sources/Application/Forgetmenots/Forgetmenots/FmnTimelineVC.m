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

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Background
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = [UIColor clearColor];
    
    _timelineView = [[FmnTimelineV alloc]initWithFrame:CGRectMake(0, 0, 0, self.scrollview.frame.size.height)];
    [self.scrollview addSubview:_timelineView];
    
    _timelineView.translatesAutoresizingMaskIntoConstraints = NO;
    [_timelineView setBackgroundColor:[UIColor clearColor]];
    [_timelineView setOpaque:NO];
    
    [_timelineView setScheduledEvents:self.scheduledEvents];
    [_timelineView setFocusedEvent:self.upcomingEventIndex];
    
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    
    // Fix only horizontal scroll with the same height
    [_scrollview addConstraint:[NSLayoutConstraint constraintWithItem:_timelineView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollview
                                                            attribute:NSLayoutAttributeHeight
                                                           multiplier:1.0
                                                             constant:0]];

    [self.scrollview setBackgroundColor:[UIColor clearColor]];
    [self.scrollview setShowsHorizontalScrollIndicator:NO];
    [self.scrollview setShowsVerticalScrollIndicator:NO];
    
    [self.scrollview setContentInset: UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    
    [self putUpDescription];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.scrollview setContentInset:UIEdgeInsetsZero];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // XXX dirty hack, contentInset is automatically adjusted for some reason
    [self.scrollview setContentInset: UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
