//
//  FmnTimelineV.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 04.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flower+Defaults.h"
#import "ScheduledEvent+Boilerplate.h"

#define FMN_TIMELINE_MARGIN 44
#define FMN_TIMELINE_STEP 99

@interface FmnTimelineElementV : UIView

@property (nonatomic, strong) NSDateFormatter * dateFormatter;

@property (nonatomic, strong) ScheduledEvent * event;

@property (nonatomic) BOOL focused;

@property (nonatomic) BOOL inactive;

@end
