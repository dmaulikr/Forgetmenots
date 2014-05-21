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
    self.chosenFlowers.text = [Nflowers description];;
}

-(void)updateDateLabel
{
    self.selectedDate.text = [ForgetmenotsEvent timeData:self.date
                                                  nTimes:self.nTimes
                                                 inExact:self.inTimeUnits
                                               timeUnits:self.timeUnit];
}

-(void)setFixedDate:(ForgetmenotsPickDateTVC *)controller selectedDate:(NSDate *)date
{
    self.random = NO;
    self.date = date;
    [self updateDateLabel];
}

- (void)setForgetmenotsDate:(ForgetmenotsPickDateTVC *)controller
                     nTimes:(NSUInteger)nTimes
                inTimeUnits:(NSUInteger)inTimeUnits
               withTimeUnit:(TimeUnit)timeUnit
{
    self.random = YES;
    self.nTimes = nTimes;
    self.inTimeUnits = inTimeUnits;
    self.timeUnit = timeUnit;
    self.start = [NSDate date];
    [self updateDateLabel];
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
        PickFlowersViewController *pickFlowersVC = (PickFlowersViewController *)segue.destinationViewController;
        pickFlowersVC.delegate = self;
        for (Flower* flower in self.flowers)
        {
            [pickFlowersVC.selectedFlowers addObject:flower];
        }
    }
    else if([segue.identifier isEqualToString:@"Choose date"])
    {
        ForgetmenotsPickDateTVC *tvc = (ForgetmenotsPickDateTVC *)segue.destinationViewController;
        
        tvc.date = self.date;
        tvc.nTimes = self.nTimes;
        tvc.inTimeUnits = self.inTimeUnits;
        tvc.timeUnit = self.timeUnit;
        tvc.start = self.start;
        
        tvc.delegate = self;
    }
}

@end
