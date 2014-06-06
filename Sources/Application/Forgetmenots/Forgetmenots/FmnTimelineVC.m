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
    
    [self.currentDescription setText:event.description];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Background
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = [UIColor clearColor];
    
    FmnTimelineV * v = [[FmnTimelineV alloc]initWithFrame:CGRectMake(0, 0, 0, self.scrollview.frame.size.height)];
//    [v setBackgroundColor:[UIColor clearColor]];
    [v setBackgroundColor:[UIColor yellowColor]];
    [v setOpaque:NO];
    
    [v setScheduledEvents:self.scheduledEvents];
    [v setFocusedEvent:self.upcomingEventIndex];
//    v.translatesAutoresizingMaskIntoConstraints = NO;
    
//    [v setFocusedEvent:self.upcomingEventIndex];
    
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_imageView(700)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView(1500)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];

    
    [self.scrollview addSubview:v];
    
//    [v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_scrollview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scrollview)]];
//    
//    [v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scrollview)]];
    
    
//    [self.scrollview setContentSize:v.frame.size];
    
//    [self.scrollview setBackgroundColor:[UIColor clearColor]];
    [self.scrollview setShowsHorizontalScrollIndicator:NO];
    [self.scrollview setShowsVerticalScrollIndicator:NO];

    self.scrollview.contentSize = CGSizeMake(self.scrollview.contentSize.width, self.scrollview.frame.size.height);
//    [self.scrollview setContentOffset:CGPointMake(0, 0)];
    
//    CGFloat h = self.scrollview.contentSize.height;
//    NSLog(@"%f vs %f", self.scrollview.contentSize.height, v.frame.size.height);
    
//    [self putUpDescription];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_scrollview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scrollview)]];
    
    [v addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scrollview)]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
