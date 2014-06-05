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
#import "FmnChooseFlowersCVC.h"
#import "FmnChooseDateTVC.h"
#import "FmnFlowersV.h"

@interface FmnCreateEditEventTVC : UITableViewController <UITextFieldDelegate, PickFlowersDelegate, PickDateDelegate>

@property (nonatomic, weak) ForgetmenotsAppDelegate *appDelegate;

// Whether is is a new event or we are editing an existing event
@property (nonatomic) BOOL editEvent;
@property (nonatomic, strong) ForgetmenotsEvent * event;

@property (weak, nonatomic) IBOutlet FmnFlowersV *chosenFlowers;
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
