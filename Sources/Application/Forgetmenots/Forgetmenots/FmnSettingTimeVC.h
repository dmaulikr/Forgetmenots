//
//  FmnSettingTimeVC.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 03.07.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FmnVC.h"

@class FmnSettingTimeVC;

@interface FmnSettingTimeVC : FmnVC

@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@end
