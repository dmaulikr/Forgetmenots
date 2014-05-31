//
//  MenuViewController.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 30.04.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnMenuVC.h"

@interface FmnMenuVC ()

@end

@implementation FmnMenuVC

- (NSIndexPath *)initialIndexPathForLeftMenu
{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

-(NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;
    switch (indexPath.row) {
        case 0:
            identifier = @"timelineSegue";
            break;
        case 1:
            identifier = @"myEventsSegue";
            break;
        case 2:
            identifier = @"notificationsSegue";
            break;
        case 3:
            identifier = @"feedbackSegue";
            break;
        default:
            break;
    }
    return identifier;
}

-(void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0, 0};
    frame.size = (CGSize){40, 40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"menu-icon"] forState:UIControlStateNormal];
}

- (BOOL)deepnessForLeftMenu
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
