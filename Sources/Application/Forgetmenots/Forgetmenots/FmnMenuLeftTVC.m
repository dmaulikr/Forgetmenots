//
//  FmnMenuLeftTVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 27.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnMenuLeftTVC.h"

@interface FmnMenuLeftTVC ()

@end

@implementation FmnMenuLeftTVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // left and top margin
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 20, 0, 0);
    self.tableView.contentInset = inset;
    
    for (int i = 0; i < [self.tableView numberOfSections]; i++)
    {
        NSInteger rows =  [self.tableView numberOfRowsInSection:i];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:i];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

            UIView * bgColorView = [[UIView alloc] init];
            [bgColorView setBackgroundColor:[UIColor blackColor]];
            
            [cell setSelectedBackgroundView:bgColorView];
        }
    }
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
