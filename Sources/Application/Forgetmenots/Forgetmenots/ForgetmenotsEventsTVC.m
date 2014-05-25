//
//  ForgetmenotsEventsTVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 09.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "ForgetmenotsEventsTVC.h"
#import "ForgetmenotsEvent+Boilerplate.h"
#import "DatabaseAvailability.h"
#import <objc/runtime.h>

@interface ForgetmenotsEventsTVC ()

@end

@implementation ForgetmenotsEventsTVC

//- (void)awakeFromNib
//{
//    [[NSNotificationCenter defaultCenter] addObserverForName:FmnDatabaseAvailabilityNotification
//                                                      object:nil
//                                                       queue:nil
//                                                  usingBlock:^(NSNotification *note) {
//                                                      self.managedObjectContext = note.userInfo[FmnDatabaseAvailabilityContext];
//                                                  }];
//}

-(ForgetmenotsAppDelegate *)appDelegate
{
    if (_appDelegate)
    {
        return _appDelegate;
    }
    else
    {
        _appDelegate = (ForgetmenotsAppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return _appDelegate;
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ForgetmenotsEvent"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                              ascending:YES
                                                               selector:@selector(localizedStandardCompare:)]];
    
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

#pragma mark - Delete Functionality

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

const char ALERT_FORGETMENOT_EVENT;

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ForgetmenotsEvent* event = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Delete"
                                              message:[NSString stringWithFormat:@"Delete %@ event?", event.name]
                                             delegate:self
                                    cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView.tag = 7;
        objc_setAssociatedObject(alertView, &ALERT_FORGETMENOT_EVENT, event, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [alertView show];
    }
}

-(void)alertView: (UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 7) // this is delete confirmation
    {
        if (buttonIndex == 1) { // they clicked Ok
            ForgetmenotsEvent *event = objc_getAssociatedObject(alertView, &ALERT_FORGETMENOT_EVENT);

            [self.appDelegate.managedObjectContext deleteObject:event];
            [self.appDelegate.managedObjectContext save:nil];
        }
        else
        {
            self.tableView.editing = false;
        }
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Forgetmenots Event Cell"];
    
    ForgetmenotsEvent* e = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = e.name;
    
    cell.detailTextLabel.text = [e timeData];
    
    return cell;
}

//-(NSArray *)forgetmenotsEvents
//{
//    if (_forgetmenotsEvents){
//        return _forgetmenotsEvents;
//    }else{
//        _forgetmenotsEvents = [ForgetmenotsEvent allEvents];
//    }
//    return _forgetmenotsEvents;
//}

//-(void)setPlannedEvents:(NSArray *)plannedEvents
//{
//    _plannedEvents = plannedEvents;
//    [self.tableView reloadData];
//}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    self.managedObjectContext = self.appDelegate.managedObjectContext;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.forgetmenotsEvents count];
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Forgetmenots Event Cell" forIndexPath:indexPath];
////    
//    static NSString *CellIdentifier = @"Forgetmenots Event Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
////    if(!cell)
////    {
////        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
////    }
//    
//    ForgetmenotsEvent* e = self.forgetmenotsEvents[indexPath.row];
//    
//    cell.textLabel.text = e.name;
//
//    cell.detailTextLabel.text = [e timeData];
//    
//    return cell;
//}

@end
