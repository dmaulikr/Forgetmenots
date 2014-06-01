//
//  ForgetmenotsEventsTVC.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 09.05.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnEventsTVC.h"
#import "ForgetmenotsEvent+Boilerplate.h"
#import "DatabaseAvailability.h"
#import <objc/runtime.h>
#import "FmnCreateEventTVC.h"

@interface FmnEventsTVC ()

@end

@implementation FmnEventsTVC


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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Forgetmenots Event Cell"];
    
    ForgetmenotsEvent* e = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
//    NSString *name = e.name;
//    NSSet * flowers = e.flowers;
    
    cell.textLabel.text = e.name;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.detailTextLabel.text = [e timeData];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

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

    // Background - common for all
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if  ([segue.identifier isEqualToString:@"newEventSegue"])
    {
        FmnCreateEventTVC *createEventTvc = [segue destinationViewController];
        
//        createEventTvc.new = YES;
        NSLog(@"new event");
    }
    else if ([segue.identifier isEqualToString:@"editEventSegue"])
    {
        FmnCreateEventTVC *createEventTvc = [segue destinationViewController];
        
        ForgetmenotsEvent* e = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        createEventTvc.flowers = [e.flowers allObjects];
        
        createEventTvc.name = e.name;
        
        createEventTvc.random = [e.random boolValue];
        
        createEventTvc.date = e.date;
        createEventTvc.nTimes = [e.nTimes intValue];
        createEventTvc.inTimeUnits = [e.inTimeUnits intValue];
        createEventTvc.timeUnit = [e.timeUnit intValue];
        createEventTvc.start = e.start;
    }
}

@end
