//
//  FmnAboutUsTVCTableViewController.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 03.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "FmnSettings.h"

@interface FmnSettingsTVC : UITableViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end
