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


NSDateFormatter * df = nil;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom init
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Background
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    df = [NSDateFormatter new];
    [df setDateFormat:@"dd MMMM yy"];
    
    self.notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fireDate" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.notifications = [self.notifications sortedArrayUsingDescriptors:sortDescriptors];
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
    return [self.notifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduledNotification" forIndexPath:indexPath];
        
    UILocalNotification *n = [self.notifications objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [df stringFromDate:n.fireDate];
    cell.detailTextLabel.text = n.alertBody;
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    UIView * bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.26]];
    
    [cell setSelectedBackgroundView:bgColorView];

    
    return cell;
}

@end
