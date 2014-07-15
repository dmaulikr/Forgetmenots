//
//  FmnSettingTimeVC.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 03.07.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForgetmenotsAppDelegate.h"

@class FmnSettingTimeVC;

@interface FmnSettingTimeVC : UIViewController

@property (nonatomic, strong) ForgetmenotsAppDelegate * appDelegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@end
