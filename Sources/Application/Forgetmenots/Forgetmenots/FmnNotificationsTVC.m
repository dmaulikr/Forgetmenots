//
//  ScheduledNotificationTVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 26.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnNotificationsTVC.h"

@interface FmnNotificationsTVC ()

@end

@implementation FmnNotificationsTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Background
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduledNotification" forIndexPath:indexPath];
        
    UILocalNotification *n = [[[UIApplication sharedApplication] scheduledLocalNotifications] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = n.alertBody;
    cell.detailTextLabel.text = [n.fireDate description];
    
    return cell;
}

@end
