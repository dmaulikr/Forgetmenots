//
//  CreateEventTVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 09.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnCreateEventTVC.h"
#import "supl/ForgetmenotsUITableView.h"

@interface FmnCreateEventTVC ()

@property (weak, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (strong, nonatomic) UITextField *titleTextField;

@end

@implementation FmnCreateEventTVC

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
    self.selectedDate.text = [ForgetmenotsEvent timeData:self.date
                                                  nTimes:self.nTimes
                                                 inExact:self.inTimeUnits
                                               timeUnits:self.timeUnit];
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
}


- (void)setName:(NSString *)name
{
    _name = name;
    
//    self.titleCell.textLabel.text  = name;
}

- (void)setupTitleCell
{
    UITableViewCell *cell = self.titleCell;
    
    cell.detailTextLabel.hidden = YES;
    
    [[cell viewWithTag:3] removeFromSuperview];
    
    UITextField* titleTextField = [[UITextField alloc] init];
    titleTextField.tag = 3;
    titleTextField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    titleTextField.textColor = [UIColor whiteColor];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTitleCell];
    
    self.tableView.backgroundColor = [UIColor clearColor];
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
        
        tvc.date = self.date;
        if (self.nTimes > 0){
            tvc.nTimes = self.nTimes - 1;
        }
        if (self.inTimeUnits > 0){
            tvc.inTimeUnits = self.inTimeUnits - 1;
        }
        tvc.timeUnit = self.timeUnit;
        tvc.start = self.start;
        
        tvc.delegate = self;
    }
}

@end
