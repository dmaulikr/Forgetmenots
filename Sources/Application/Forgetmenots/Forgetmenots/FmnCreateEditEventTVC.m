//
//  CreateEventTVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 09.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnCreateEditEventTVC.h"
#import "supl/ForgetmenotsUITableView.h"
#import "ForgetmenotsEvent+Boilerplate.h"
#import <objc/runtime.h>

@interface FmnCreateEditEventTVC ()

@property (weak, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;
@property (strong, nonatomic) UITextField *titleTextField;

@end

@implementation FmnCreateEditEventTVC

-(ForgetmenotsAppDelegate *)appDelegate
{
    if (_appDelegate)
    {
        return _appDelegate;
    }
    else
    {
        _appDelegate = (ForgetmenotsAppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return _appDelegate;
}

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

-(void)setSelectedFlowers:(FmnChooseFlowersCVC *)controller selectedFlowers:(NSArray *)selectedFlowers
{
    self.flowers = selectedFlowers;
}

-(void)setFlowers:(NSArray *)Nflowers
{
    _flowers = Nflowers;
    self.chosenFlowers.flowers = Nflowers;
}

-(void)updateDateLabel
{
    self.selectedDate.text = [NSString stringWithFormat:@"%@", [ForgetmenotsEvent timeData:self.date
                                                                                          nTimes:self.nTimes
                                                                                         inExact:self.inTimeUnits
                                                                                       timeUnits:self.timeUnit]];
}

-(void)setFixedDate:(FmnChooseDateTVC *)controller selectedDate:(NSDate *)date
{
    self.random = NO;
    self.date = date;
    [self updateDateLabel];
}

- (void)setForgetmenotsDate:(FmnChooseDateTVC *)controller
                     nTimes:(NSUInteger)nTimes
                inTimeUnits:(NSUInteger)inTimeUnits
               withTimeUnit:(TimeUnit)timeUnit
{
    self.random = YES;
    self.nTimes = nTimes + 1;
    self.inTimeUnits = inTimeUnits + 1;
    self.timeUnit = timeUnit;
    self.start = [NSDate date];
    [self updateDateLabel];
}

#pragma mark - Delete Functionality

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return YES if you want the specified item to be editable.
//    return YES;
//}

const char ALERT_FORGETMENOT_EVENT;

- (IBAction)deleteButtonClicked:(id)sender {
    if (self.event){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Delete"
                                                           message:[NSString stringWithFormat:@"Delete %@ event?", self.event.name]
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView.tag = 7;
        objc_setAssociatedObject(alertView, &ALERT_FORGETMENOT_EVENT, self.event, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [alertView show];        
    }
}

-(void)alertView: (UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 7) // this is delete confirmation
    {
        if (buttonIndex == 1) { // they clicked Ok
            ForgetmenotsEvent *event = objc_getAssociatedObject(alertView, &ALERT_FORGETMENOT_EVENT);
            
            [self.appDelegate.managedObjectContext deleteObject:event];

            [self.appDelegate.managedObjectContext save:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - Save functionality

- (IBAction)saveButtonClicked:(id)sender {
    
    self.name = self.titleTextField.text;
    
    UIAlertView *alertView = nil;
    if (!self.name || [self.name length] == 0)
    {
        alertView = [[UIAlertView alloc]initWithTitle:@"Name is not set"
                                              message:@"Please provide event's name"
                                             delegate:self
                                    cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    }
    if (!self.flowers || [self.flowers count] == 0)
    {
        alertView = [[UIAlertView alloc]initWithTitle:@"Flowers are not selected"
                                              message:@"Please select flowers"
                                             delegate:self
                                    cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    }
    if (alertView)
    {
        [alertView show];
    }
    else
    {
        if (self.random)
        {
            if (!self.nTimes || self.nTimes == 0)
            {
                alertView = [[UIAlertView alloc]initWithTitle:@"Dates are not set"
                                                      message:@"Please select dates"
                                                     delegate:self
                                            cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alertView show];
            }
            else
            {
                [self saveEvent];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            if (!self.date)
            {
                alertView = [[UIAlertView alloc]initWithTitle:@"Date is not set"
                                                      message:@"Please select date"
                                                     delegate:self
                                            cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alertView show];
            }
            else
            {
                [self saveEvent];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}

-(void)saveEvent
{
    if (self.editEvent) // Update existing event
    {
        // For now just delete it and recreate with new name
        [self.appDelegate.managedObjectContext deleteObject:self.event];
        
//        self.event.flowers = [NSSet setWithArray:self.flowers];
//        self.event.date = self.date;
//        self.event.name = self.name;
//        self.event.nTimes = [NSNumber numberWithInteger:self.nTimes];
//        self.event.inTimeUnits = [NSNumber numberWithInteger:self.inTimeUnits];
//        self.event.timeUnit = [NSNumber numberWithInteger:self.timeUnit];
//        self.event.start = self.start;
//        self.event.random = [NSNumber numberWithBool:self.random];
        
        NSError *error = nil;
        if (! [self.event.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            // Take some action!
        }
    }
//    else // Create new event
//    {
        if (self.random) {
            [ForgetmenotsEvent initWithFlowers:[NSSet setWithArray:self.flowers]
                                          name:self.name
                                        nTimes:self.nTimes
                                   inTimeUnits:self.inTimeUnits
                                      timeUnit:self.timeUnit
                                     withStart:self.start
                              inManagedContext:self.appDelegate.managedObjectContext];
            
        }
        else
        {
            [ForgetmenotsEvent initWithFlowers:[NSSet setWithArray:self.flowers]
                                          name:self.name
                                          date:self.date
                              inManagedContext:self.appDelegate.managedObjectContext];
        }
//    }
}


- (void)setName:(NSString *)name
{
    _name = name;
    [self.titleTextField setText:name];
}

- (void)setupTitleCell
{
    UITableViewCell *cell = self.titleCell;
    
    cell.detailTextLabel.hidden = YES;
    
    cell.textLabel.hidden = YES;
    
    [[cell viewWithTag:3] removeFromSuperview];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    UITextField* titleTextField = [[UITextField alloc] init];
    titleTextField.tag = 3;
    titleTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.16f];
    titleTextField.textColor = [UIColor whiteColor];
    titleTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [cell.contentView addSubview:titleTextField];
//    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
//                                                     attribute:NSLayoutAttributeLeading
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:cell.contentView
//                                                     attribute:NSLayoutAttributeLeft
//                                                    multiplier:0
//                                                      constant:8]];
//    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
//                                                     attribute:NSLayoutAttributeTrailing
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:cell.contentView
//                                                     attribute:NSLayoutAttributeTrailing
//                                                    multiplier:0
//                                                      constant:-8]];
//    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:cell.contentView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:8]];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:cell.contentView
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:-8]];

    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:cell.contentView
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:0.01
                                                      constant:8]];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:cell.contentView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:-0.01
                                                      constant:-8]];

    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:cell.contentView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:0.98
                                                      constant:0]];
    titleTextField.textAlignment = NSTextAlignmentCenter;
    titleTextField.delegate = self;
    titleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Title" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    self.titleTextField = titleTextField;
    
    ((ForgetmenotsUITableView *)self.view).titleTextField = titleTextField;
}

-(void)setupDateCell
{
    self.selectedDate.textColor = [UIColor whiteColor];
}

-(void)setupDefaultDate
{
    self.random = YES;
    self.nTimes = 1;
    self.inTimeUnits = 1;
    self.timeUnit = MONTH;
    self.start = [NSDate date];
}

-(void)setupNewEventOrEdit
{
    if (self.editEvent)
    {
        self.navigationItem.title = @"Edit Event";
    }
    else
    {
        self.navigationItem.title = @"New Event";
        [self.deleteCell setHidden:YES];
        
        [self setupDefaultDate];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNewEventOrEdit];
    
    [self setupTitleCell];
    [self setupDateCell];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem * nextBack = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(cancelButtonClicked:)];
    //set to red
//    nextBack.f
    self.navigationItem.leftBarButtonItem = nextBack;
}

- (void)cancelButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.flowers = self.flowers;
    
    self.name = self.name;
    
    [self updateDateLabel];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Save name for future
    self.name = self.titleTextField.text;
    
    if([segue.identifier isEqualToString:@"Choose flowers"])
    {
        FmnChooseFlowersCVC *pickFlowersVC = (FmnChooseFlowersCVC *)segue.destinationViewController;
        pickFlowersVC.delegate = self;
        for (Flower* flower in self.flowers)
        {
            [pickFlowersVC.selectedFlowers addObject:flower];
        }
    }
    else if([segue.identifier isEqualToString:@"Choose date"])
    {
        FmnChooseDateTVC *tvc = (FmnChooseDateTVC *)segue.destinationViewController;
        tvc.delegate = self;
        
        tvc.date = self.date;
        if (self.nTimes > 0){
            tvc.nTimes = self.nTimes - 1;
        }
        if (self.inTimeUnits > 0){
            tvc.inTimeUnits = self.inTimeUnits - 1;
        }
        tvc.timeUnit = self.timeUnit;
        tvc.start = self.start;
    }
}

@end
