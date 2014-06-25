//
//  TimelineViewController.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 03.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForgetmenotsAppDelegate.h"
#import "FmnTimelineElementV.h"

@interface FmnTimelineVC : UIViewController

@property (nonatomic, weak) ForgetmenotsAppDelegate *appDelegate;

@property (nonatomic, strong) FmnTimelineElementV * timelineView;

@property (nonatomic, strong) NSMutableArray * timelineViews;

@property (nonatomic, strong) NSString * tappedEventName;

@property (nonatomic) int currentlyLookingAt;

@property (nonatomic) int upcomingEventIndex;

@end
