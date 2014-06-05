//
//  FmnAboutUsTVCTableViewController.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 03.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnAboutUsTVC.h"

@interface FmnAboutUsTVC ()

@property (weak, nonatomic) IBOutlet UILabel *teamHeadline;
@property (weak, nonatomic) IBOutlet UITextView *teamBody;
@property (weak, nonatomic) IBOutlet UILabel *whyHeadline;
@property (weak, nonatomic) IBOutlet UITextView *whyBody;

@end

@implementation FmnAboutUsTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setCellStyles
{
    [self.teamHeadline setTextColor:[UIColor whiteColor]];
    [self.teamBody setTextColor:[UIColor whiteColor]];

    [self.whyHeadline setTextColor:[UIColor whiteColor]];
    [self.whyBody setTextColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Background
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self setCellStyles];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
