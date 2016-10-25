//
//  ViewController.m
//  14-3 Displaying Events in a Table View
//
//  Created by joseph hoffman on 8/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Events";
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self
                                      action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = refreshButton;
    
    self.eventsTableView.delegate = self;
    self.eventsTableView.dataSource = self;
    
    self.eventStore = [[EKEventStore alloc] init];
    
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent
                                    completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             self.calendars =
             [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
             [self fetchEvents];
         }
         else
         {
             NSLog(@"Access not granted: %@", error);
         }
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self refresh:self];
    [super viewWillAppear:animated];
}

- (void)refresh:(id)sender
{
    [self fetchEvents];
    [self.eventsTableView reloadData];
}

- (void)fetchEvents
{
    self.events = [[NSMutableDictionary alloc] initWithCapacity:[self.calendars count]];
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *fortyEightHoursFromNowComponents =
    [[NSDateComponents alloc] init];
    fortyEightHoursFromNowComponents.day = 2; // 48 hours forward
    NSDate *fortyEightHoursFromNow =
    [calendar dateByAddingComponents:fortyEightHoursFromNowComponents toDate:now
                             options:0];
    
    for (EKCalendar *calendar in self.calendars)
    {
        NSPredicate *allEventsWithin48HoursPredicate =
        [self.eventStore predicateForEventsWithStartDate:now
                                                 endDate:fortyEightHoursFromNow calendars:@[calendar]];
        NSArray *eventsInThisCalendar =
        [self.eventStore eventsMatchingPredicate:allEventsWithin48HoursPredicate];
        if (eventsInThisCalendar != nil)
        {
            [self.events setObject:eventsInThisCalendar forKey:calendar.title];
        }
    }
    dispatch_async(dispatch_get_main_queue(),^{
        [self.eventsTableView reloadData];
    });
}

- (EKCalendar *)calendarAtSection:(NSInteger)section
{
    return [self.calendars objectAtIndex:section];
}

- (EKEvent *)eventAtIndexPath:(NSIndexPath *)indexPath
{
    EKCalendar *calendar = [self calendarAtSection:indexPath.section];
    NSArray *calendarEvents = [self eventsForCalendar:calendar];
    return [calendarEvents objectAtIndex:indexPath.row];
}

- (NSArray *)eventsForCalendar:(EKCalendar *)calendar
{
    return [self.events objectForKey:calendar.title];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.calendars count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self calendarAtSection:section].title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    EKCalendar *calendar = [self calendarAtSection:section];
    return [self eventsForCalendar:calendar].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
    }
	
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:19.0];
    
    cell.textLabel.text = [self eventAtIndexPath:indexPath].title;
	
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EKEventViewController *eventVC = [[EKEventViewController alloc] init];
    eventVC.event = [self eventAtIndexPath:indexPath];
    eventVC.allowsEditing = YES;
    [self.navigationController pushViewController:eventVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    EKEventEditViewController *eventEditVC = [[EKEventEditViewController alloc] init];
    eventEditVC.event = [self eventAtIndexPath:indexPath];
    eventEditVC.eventStore = self.eventStore;
    eventEditVC.editViewDelegate = self;
    [self presentViewController:eventEditVC animated:YES completion:nil];
}
-(void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:
(EKEventEditViewController *)controller
{
    return [self.eventStore defaultCalendarForNewEvents];
}



@end
