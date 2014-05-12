//
//  CreateEventTVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 09.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "CreateEventTVC.h"
#import "supl/ForgetmenotsUITableView.h"

@interface CreateEventTVC ()

@property (weak, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (strong, nonatomic) UITextField *titleTextField;

@end

@implementation CreateEventTVC

@synthesize flowers = _flowers;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSArray *)flowers
{
    if (_flowers)
    {
        return _flowers;
    }
    else
    {
        _flowers = [[NSArray alloc] init];
    }
    return _flowers;
}

-(void)setSelectedFlowers:(PickFlowersViewController *)controller selectedFlowers:(NSArray *)selectedFlowers
{
    NSLog(@"%@", selectedFlowers);
    self.flowers = selectedFlowers;
}

-(void)setFlowers:(NSArray *)Nflowers
{
    _flowers = Nflowers;
    //XXX update flowers view    
//    self.chooseFlowersLabel.text = self.flowers.description;
    NSString* ololo = [Nflowers description];
    NSLog(@"%@", ololo);
    self.chosenFlowers.text = ololo;
}

- (void)setName:(NSString *)name
{
    _name = name;
    
//    self.titleCell.textLabel.text  = name;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UITableViewCell *cell = self.titleCell;
    
    cell.detailTextLabel.hidden = YES;
    
    [[cell viewWithTag:3] removeFromSuperview];
    
    UITextField* titleTextField = [[UITextField alloc] init];
    titleTextField.tag = 3;
    titleTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [cell.contentView addSubview:titleTextField];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell.textLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:8]];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell.detailTextLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    titleTextField.textAlignment = NSTextAlignmentRight;
    titleTextField.delegate = self;
    
    self.titleTextField = titleTextField;
    
    ((ForgetmenotsUITableView *)self.view).titleTextField = titleTextField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    switch (indexPath.row)
//    {
//        case 0:
//            break;
//        case 1:
//            return [self getTitleCell:tableView cellForRowAtIndexPath:indexPath];
//            break;
//        case 2:
//            break;
//    }
//    
//    return nil;
//}
//
//- (UITableViewCell *)getChooseFlowers:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Title" forIndexPath:indexPath];
//    
//    return cell;
//}
//
//- (UITableViewCell *)getTitleCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Title" forIndexPath:indexPath];
//
//    cell.detailTextLabel.hidden = YES;
//    
//    [[cell viewWithTag:3] removeFromSuperview];
//    
//    UITextField* textField = [[UITextField alloc] init];
//    textField.tag = 3;
//    textField.translatesAutoresizingMaskIntoConstraints = NO;
//    [cell.contentView addSubview:textField];
//    [cell addConstraint:[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell.textLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:8]];
//    [cell addConstraint:[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
//    [cell addConstraint:[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
//    [cell addConstraint:[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell.detailTextLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
//    textField.textAlignment = NSTextAlignmentRight;
//    textField.delegate = self;
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Choose flowers"])
    {
        PickFlowersViewController *pickFlowersVC = (PickFlowersViewController *)segue.destinationViewController;
        pickFlowersVC.delegate = self;
        for (Flower* flower in self.flowers)
        {
            [pickFlowersVC.selectedFlowers addObject:flower];
        }
    }
}


@end
