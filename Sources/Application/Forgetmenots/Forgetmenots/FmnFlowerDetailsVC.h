//
//  FmnFlowerDetailsVC.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 09.07.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FmnTimelineElementV.h"

@interface FmnFlowerDetailsVC : UIViewController

// XXX change to Flower instead of event
@property (weak, nonatomic) IBOutlet FmnTimelineElementV *flowerView;
@property (nonatomic, strong) ScheduledEvent * event;

@end
