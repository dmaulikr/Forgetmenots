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
#import "FmnCreateEditEventTVC.h"

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

#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Forgetmenots Event Cell"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    ForgetmenotsEvent* e = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
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
        FmnCreateEditEventTVC *createEventTvc = [segue destinationViewController];
        
        createEventTvc.editEvent = NO;
    }
    else if ([segue.identifier isEqualToString:@"editEventSegue"])
    {
        FmnCreateEditEventTVC *createEventTvc = [segue destinationViewController];
        
        ForgetmenotsEvent* e = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        createEventTvc.editEvent = YES;
        createEventTvc.event = e;
        
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
