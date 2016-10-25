//
//  ViewController.m
//  Recipe 14-4 Creating Calendar Events
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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
                                  action:@selector(addEvent:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
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

- (void)addEvent:(id)sender
{
    UIAlertView * inputAlert = [[UIAlertView alloc] initWithTitle:@"New Event"
                                                          message:@"Enter a title for the event" delegate:self cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"OK", nil];
    inputAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [inputAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        // OK button tapped
        
        // Calculate the date exactly one day from now
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *aDayFromNowComponents = [[NSDateComponents alloc] init];
        aDayFromNowComponents.day = 1;
        NSDate *now = [NSDate date];
        NSDate *aDayFromNow = [calendar dateByAddingComponents:aDayFromNowComponents
                                                        toDate:now options:0];
        
        // Create the event
        EKEvent *event = [EKEvent eventWithEventStore:self.eventStore];
        event.title = [alertView textFieldAtIndex:0].text;
        event.calendar = [self.eventStore defaultCalendarForNewEvents];
        event.startDate = aDayFromNow;
        event.endDate = [NSDate dateWithTimeInterval:60*60.0 sinceDate:event.startDate];
        
        // Make it recur
        EKRecurrenceRule *repeatEverySecondWednesdayRecurrenceRule =
        [[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyDaily
                                                     interval:2
                                                daysOfTheWeek:@[[EKRecurrenceDayOfWeek dayOfWeek:4]]
                                               daysOfTheMonth:nil
                                              monthsOfTheYear:nil
                                               weeksOfTheYear:nil
                                                daysOfTheYear:nil
                                                 setPositions:nil
                                                          end:[EKRecurrenceEnd recurrenceEndWithOccurrenceCount:20]];
        
        event.recurrenceRules = @[repeatEverySecondWednesdayRecurrenceRule];

        
        // Save the event and update the table view
        [self.eventStore saveEvent:event span:EKSpanThisEvent error:nil];
        [self refresh:self];
    }
}



@end
