//
//  FmnAboutUsTVCTableViewController.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 03.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnSettingsTVC.h"
#import "FmnMisc.h"

@interface FmnSettingsTVC ()

@property (weak, nonatomic) IBOutlet UILabel *teamHeadline;
@property (weak, nonatomic) IBOutlet UITextView *teamBody;
@property (weak, nonatomic) IBOutlet UILabel *whyHeadline;
@property (weak, nonatomic) IBOutlet UITextView *whyBody;

@end

@implementation FmnSettingsTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *)view;
    tableViewHeaderFooterView.textLabel.textColor = [UIColor whiteColor];
    tableViewHeaderFooterView.backgroundView.backgroundColor = [UIColor clearColor];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Background
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
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
