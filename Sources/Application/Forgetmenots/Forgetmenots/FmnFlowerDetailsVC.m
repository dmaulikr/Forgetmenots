//
//  FmnFlowerDetailsVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 09.07.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnFlowerDetailsVC.h"

@interface FmnFlowerDetailsVC ()

@end

@implementation FmnFlowerDetailsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)setupFlowerView
{
    //    ScheduledEvent * e = [_events firstObject];
    //
    //    NSString * name = e.name;
    //    NSDate * date = e.date;
    
    self.flowerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.flowerView setBackgroundColor:[UIColor clearColor]];
    [self.flowerView setOpaque:NO];
    [self.flowerView setEvent:self.event];
    [self.flowerView setFocused:YES];
    [self.flowerView setInactive:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupFlowerView];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
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
