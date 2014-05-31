//
//  ForgetmenotsPickDateTVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 12.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnChooseDateTVC.h"

@interface FmnChooseDateTVC ()

@end

@implementation FmnChooseDateTVC

UIDatePicker *datePickerView;
UIPickerView *forgetmenotsPickerView;

-(void)setAllSelected:(BOOL)animated
{
    if (self.date)
    {
        [datePickerView setDate:self.date animated:animated];
    }
    else
    {
        [forgetmenotsPickerView selectRow:self.nTimes
                              inComponent:0
                                 animated:animated];
        [forgetmenotsPickerView selectRow:self.inTimeUnits
                              inComponent:2
                                 animated:animated];
        [forgetmenotsPickerView selectRow:[FmnChooseDateTVC findTimeUnitIndex:self.timeUnit]
                              inComponent:3
                                 animated:animated];
    }
}

NSInteger TIME_UNIT_MAP[4] = {DAY, WEEK, MONTH, YEAR};

+(NSUInteger)findTimeUnitIndex:(TimeUnit)timeUnit
{
    for (int i = 0; i < 4; i++) {
        if (TIME_UNIT_MAP[i] == timeUnit)
        {
            return i;
        }
    }
    return 0;
}

+(TimeUnit)timeUnitMap:(NSUInteger)position
{
    return TIME_UNIT_MAP[position];
}

+(NSArray *)forgetmenotsDates
{
    return @[
  @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"],
  @[@"times in"],
  @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"],
  @[@"days", @"weeks", @"months", @"years"]
  ];
}

+(NSArray *)pickerWidths
{
    return @[@50, @100, @50, @100];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)flip:(id)sender {
    if (self.onOff.on)
    {
        [self renderForgetmenotsUIPickerView];
    }
    else
    {
        [self renderDateUIPicker];
    }
}

-(void)animateOut:(UIView *)target {
    if (target)
    {
        [target removeFromSuperview];   
//        [UIView animateWithDuration:0.5
//                              delay:0.01
//                            options: UIViewAnimationOptionCurveEaseOut
//                         animations: ^{
//                             target.alpha = 0;
//                         }
//                         completion: ^(BOOL finished){
//                             [target removeFromSuperview];
//                         }];
    }
}

-(void)clearPickers
{
    [self animateOut:datePickerView];
    [self animateOut:forgetmenotsPickerView];
}

#pragma mark - UIDatePickerView

-(void)renderDateUIPicker
{
    [self clearPickers];
    datePickerView = [[UIDatePicker alloc] initWithFrame:self.pickerViewCell.bounds];
    [datePickerView addTarget:self
                 action:@selector(pickerChanged:)
       forControlEvents:UIControlEventValueChanged];
    [self.pickerViewCell addSubview:datePickerView];
    [self.pickerViewCell setNeedsDisplay];
}

- (void)pickerChanged:(id)sender
{
    [self.delegate setFixedDate:self selectedDate:[sender date]];
}

#pragma mark - ForgetmenotsUIPickerVIew

-(void)renderForgetmenotsUIPickerView
{
    [self clearPickers];
    forgetmenotsPickerView = [[UIPickerView alloc] initWithFrame:self.pickerViewCell.bounds];
    forgetmenotsPickerView.delegate = self;
    forgetmenotsPickerView.showsSelectionIndicator = YES;
    [self.pickerViewCell addSubview:forgetmenotsPickerView];
    [self.pickerViewCell setNeedsDisplay];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    TimeUnit timeUnit = [FmnChooseDateTVC timeUnitMap:[pickerView selectedRowInComponent:3]];
    
    [self.delegate setFixedDate:self selectedDate:nil];
    
    [self.delegate setForgetmenotsDate:self
                                nTimes:[pickerView selectedRowInComponent:0]
                           inTimeUnits:[pickerView selectedRowInComponent:2]
                          withTimeUnit:timeUnit];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[FmnChooseDateTVC forgetmenotsDates][component] count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [[FmnChooseDateTVC forgetmenotsDates] count];
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return [FmnChooseDateTVC forgetmenotsDates][component][row];
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return [[FmnChooseDateTVC pickerWidths][component] floatValue];
}

#pragma mark - Main View Controller Routine

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    if (self.date)
    {
        [self.onOff setOn:NO];
        [self renderDateUIPicker];
    }
    else
    {
        [self.onOff setOn:YES];
        [self renderForgetmenotsUIPickerView];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self setAllSelected:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
