//
//  FmnTodaysEventVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 25.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnTodaysEventsVC.h"

@interface FmnTodaysEventsVC ()

@end

@implementation FmnTodaysEventsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)dismissClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//-(void)setEvents:(NSArray *)events
//{
//    _events = events;
//    [self updateViews];
//}

-(void)setupMainView
{
    ScheduledEvent * e = [_events firstObject];
    
    NSString * name = e.name;
    NSDate * date = e.date;
    
    self.mainView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.mainView setBackgroundColor:[UIColor clearColor]];
    [self.mainView setOpaque:NO];
    [self.mainView setEvent:[_events firstObject]];
    [self.mainView setFocused:YES];
    [self.mainView setInactive:NO];
}

//- (void)updateViews
//{
//    [self setupMainView];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupMainView];

    ScheduledEvent * firstEvent = [self.events firstObject];
    self.titleLabel.text = firstEvent.name;
//    self.adviceLabel.text = @"If the flower food solution becomes cloudy, replace it entirely with properly mixed flower food solution.";
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
