//
//  FmnTodaysEventVC.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 25.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduledEvent+Boilerplate.h"
#import "FmnTimelineElementV.h"

@interface FmnTodaysEventsVC : UIViewController

@property (nonatomic, strong) ScheduledEvent * event;

@property (weak, nonatomic) IBOutlet FmnTimelineElementV *mainView;

@property (weak, nonatomic) IBOutlet UILabel *flowerSelectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *adviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@property (weak, nonatomic) IBOutlet UIButton *sweetButtin;

@end
