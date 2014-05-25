//
//  ForgetmenotsPickDateTVC.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 12.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForgetmenotsEvent+Boilerplate.h"

@class ForgetmenotsPickDateTVC;

@protocol PickDateDelegate <NSObject>

- (void)setFixedDate:(ForgetmenotsPickDateTVC *)controller selectedDate:(NSDate *)date;

- (void)setForgetmenotsDate:(ForgetmenotsPickDateTVC *)controller
                     nTimes:(NSUInteger)nTimes
                inTimeUnits:(NSUInteger)inTimeUnits
               withTimeUnit:(TimeUnit)timeUnit;

@end

@interface ForgetmenotsPickDateTVC : UITableViewController <UIPickerViewDelegate>

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
