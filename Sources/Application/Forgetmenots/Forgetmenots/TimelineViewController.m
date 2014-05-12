//
//  TimelineViewController.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 03.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "TimelineViewController.h"

#import "Model/PlannedEvent.h"
#import "Model/ForgetmenotsEvent.h"

@interface TimelineViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *nav;
@property (weak, nonatomic) IBOutlet UITextView *upcomingEventInfo;

@property (strong, nonatomic) NSArray *plannedEvents;

@end

@implementation TimelineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSArray *)plannedEvents
{
    if (_plannedEvents){
        return _plannedEvents;
    }else{
        _plannedEvents = [PlannedEvent planEventsWithForgetmenotsEventArray:[ForgetmenotsEvent allEvents]];
    }
    return _plannedEvents;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Transparent navigation bar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    // Background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    
    PlannedEvent* upcoming = [self.plannedEvents firstObject];
    
    _upcomingEventInfo.text = [upcoming description];
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
