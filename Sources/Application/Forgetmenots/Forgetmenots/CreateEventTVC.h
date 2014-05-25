//
//  CreateEventTVC.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 09.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flower+Defaults.h"
#import "ForgetmenotsEvent+Boilerplate.h"
#import "PickFlowersViewController.h"
#import "ForgetmenotsPickDateTVC.h"

@interface CreateEventTVC : UITableViewController <UITextFieldDelegate, PickFlowersDelegate, PickDateDelegate>

@property (nonatomic, weak) ForgetmenotsAppDelegate *appDelegate;

@property (weak, nonatomic) IBOutlet UITextView *chosenFlowers;
@property (weak, nonatomic) IBOutlet UILabel *selectedDate;

@property  (strong, nonatomic) NSArray *flowers;
@property (strong, nonatomic) NSString *name;

//whether this event should be treated as a random or not
@property (nonatomic, getter = isRandom) BOOL random;

//fixed event data
@property (strong, nonatomic) NSDate *date;

//random events data
@property (nonatomic) NSUInteger nTimes;
@property (nonatomic) NSUInteger inTimeUnits;
@property (nonatomic) TimeUnit timeUnit;
@property (nonatomic, strong) NSDate* start;

@end
