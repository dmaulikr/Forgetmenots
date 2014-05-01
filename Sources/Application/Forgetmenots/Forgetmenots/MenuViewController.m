//
//  MenuViewController.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 30.04.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (NSIndexPath *)initialIndexPathForLeftMenu
{
    return [NSIndexPath indexPathForRow:1 inSection:0];
}

-(NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;
    switch (indexPath.row) {
        case 1:
            identifier = @"timelineSegue";
            break;
        case 2:
            identifier = @"settingsSegue";
            break;
            
        case 3:
            identifier = @"aboutUsSegue";
            break;
            
        case 4:
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
