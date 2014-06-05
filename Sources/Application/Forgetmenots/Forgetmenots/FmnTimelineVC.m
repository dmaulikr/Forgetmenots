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
@property (weak, nonatomic) IBOutlet UITextView *upcomingEventInfo;

@property (strong, nonatomic) NSArray *scheduledEvents;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
//@property (weak, nonatomic) IBOutlet FmnTimelineV *timeline;

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

- (void)prepTimeline
{
//    self.scrollView.si
//    CGRect rect = CGRectMake(0,
//                             0,
//                             1300, //XXX should be dependent on the scheduledEvents arrays size
//                             200); //self.scrollView.frame.size.height
//    
//    // XXX call init with scheduledEvents instead?
//    FmnTimelineV * timelineV = [[FmnTimelineV alloc] initWithFrame:rect];
//    timelineV.backgroundColor = [UIColor purpleColor];
//    [self.scrollView addSubview:timelineV];
//    self.scrollView.contentSize = timelineV.frame.size;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Background
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = [UIColor clearColor];
    
//    [self.timeline setScheduledEvents:self.scheduledEvents];
    
    FmnTimelineV * v = [[FmnTimelineV alloc]initWithFrame:CGRectMake(0, 0, 0, self.scrollview.frame.size.height)];
    [v setBackgroundColor:[UIColor clearColor]];
    [v setOpaque:NO];
    
    [v setScheduledEvents:self.scheduledEvents];
    [self.scrollview addSubview:v];
    [self.scrollview setContentSize:v.frame.size];
    
    [self.scrollview setBackgroundColor:[UIColor clearColor]];
    [self.scrollview setShowsHorizontalScrollIndicator:NO];
    [self.scrollview setShowsVerticalScrollIndicator:NO];
    
    
//    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, container.frame.size.width/2, container.frame.size.height/2)];
//    scroll.pagingEnabled = YES;
//    scroll.scrollEnabled = YES;
//    [scroll setBackgroundColor:[UIColor redColor]];
//    NSInteger numberOfViews = 3;
//    for (int i = 0; i < numberOfViews; i++)
//    {
//        CGFloat xOrigin = i * container.frame.size.width/2;
//        UIView *awesomeView = [[UIView alloc] initWithFrame:CGRectMake(xOrigin, 0, container.frame.size.width, container.frame.size.height)];
//        awesomeView.backgroundColor = [UIColor colorWithRed:0.5/i green:0.5 blue:0.5 alpha:1];
//        [scroll addSubview:awesomeView];
//        [awesomeView release];
//    }
//    scroll.contentSize = CGSizeMake(container.frame.size.width/2 * numberOfViews, container.frame.size.height);
//    [container addSubview:scroll];
    
//    [self prepTimeline];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
//    PlannedEvent* upcoming = [self.plannedEvents firstObject];
//    self.flowerView.flower = [Flower flowerWithName:@"Forgetmenot" inManagedContext:self.appDelegate.managedObjectContext];
//    self.upcomingEventInfo.text = [upcoming description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
