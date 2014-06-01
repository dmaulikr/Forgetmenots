//
//  ForgetmenotsPickDateTVC.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 12.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForgetmenotsEvent+Boilerplate.h"
#import "UILabel+WhiteUIDatePickerLabels.h"

@class FmnChooseDateTVC;

@protocol PickDateDelegate <NSObject>

- (void)setFixedDate:(FmnChooseDateTVC *)controller selectedDate:(NSDate *)date;

- (void)setForgetmenotsDate:(FmnChooseDateTVC *)controller
                     nTimes:(NSUInteger)nTimes
                inTimeUnits:(NSUInteger)inTimeUnits
               withTimeUnit:(TimeUnit)timeUnit;

@end

@interface FmnChooseDateTVC : UITableViewController <UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *switchCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *pickerCell;

@property (nonatomic, weak) id <PickDateDelegate> delegate;

//fixed event data
@property (strong, nonatomic) NSDate *date;

//random events data
@property (nonatomic) NSUInteger nTimes;
@property (nonatomic) NSUInteger inTimeUnits;
@property (nonatomic) TimeUnit timeUnit;
@property (nonatomic, strong) NSDate* start;

@property (weak, nonatomic) IBOutlet UILabel *eventTypeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *onOff;
@property (weak, nonatomic) IBOutlet UITableViewCell *pickerViewCell;

@end
