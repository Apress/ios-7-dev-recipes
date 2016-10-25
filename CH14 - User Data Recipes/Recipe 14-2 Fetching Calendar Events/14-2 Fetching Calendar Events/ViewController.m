//
//  ViewController.m
//  14-2 Fetching Calendar Events
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

    self.eventStore = [[EKEventStore alloc] init];
    
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent
                                    completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             NSDate *now = [NSDate date];
             
             NSCalendar *calendar = [NSCalendar currentCalendar];
             NSDateComponents *fortyEightHoursFromNowComponents =
             [[NSDateComponents alloc] init];
             fortyEightHoursFromNowComponents.day = 2; // 48 hours forward
             NSDate *fortyEightHoursFromNow =
             [calendar dateByAddingComponents:fortyEightHoursFromNowComponents
                                       toDate:now options:0];
             
             NSPredicate *allEventsWithin48HoursPredicate =
             [self.eventStore predicateForEventsWithStartDate:now
                                                      endDate:fortyEightHoursFromNow calendars:nil];
             NSArray *events = [self.eventStore
                                eventsMatchingPredicate:allEventsWithin48HoursPredicate];
             for (EKEvent *event in events)
             {
                 NSLog(@"%@", event.title);
             }
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

@end
