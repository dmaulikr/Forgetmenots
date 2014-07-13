//
//  FmnTodaysEventVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 25.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnTodaysEventsVC.h"
#import "FmnFlowerDetailsVC.h"
#import <QuartzCore/QuartzCore.h>

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

-(void)setupMainView
{
    self.mainView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.mainView setBackgroundColor:[UIColor clearColor]];
    [self.mainView setOpaque:NO];
    [self.mainView setEvent:self.event];
    [self.mainView setFocused:YES];
    [self.mainView setInactive:NO];
}

- (IBAction)flowerInfo:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    FmnFlowerDetailsVC * vc = [storyboard instantiateViewControllerWithIdentifier:@"FmnFlowerDetailsVC"];
    
    [vc setEvent:self.event];
    
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupMainView];

    self.titleLabel.text = self.event.name;
//    self.adviceLabel.text = @"If the flower food solution becomes cloudy, replace it entirely with properly mixed flower food solution.";
    
    CALayer * layer = [self.sweetButtin layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:7.5]; //when radius is 0, the border is a rectangle
    [layer setBorderWidth:0.5];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
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
