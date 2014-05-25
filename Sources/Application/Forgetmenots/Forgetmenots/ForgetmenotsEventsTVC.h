//
//  ForgetmenotsEventsTVC.h
//  Forgetmenots
//
//  Created by Ilya Pimenov on 09.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "ForgetmenotsAppDelegate.h"

@interface ForgetmenotsEventsTVC : CoreDataTableViewController

@property (nonatomic, weak) ForgetmenotsAppDelegate *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
