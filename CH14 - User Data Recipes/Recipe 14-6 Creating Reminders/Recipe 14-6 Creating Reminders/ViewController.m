//
//  ViewController.m
//  Recipe 14-6 Creating Reminders
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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy initializers

- (EKEventStore *)eventStore
{
    if (_eventStore == nil)
    {
        _eventStore = [[EKEventStore alloc] init];
    }
    return _eventStore;
}

- (IBAction)addTimeBasedReminder:(id)sender
{
    [self.activityIndicator startAnimating];
    
    [self handleReminderAction:^()
     {
         // Create Reminder
         EKReminder *newReminder = [EKReminder reminderWithEventStore:self.eventStore];
         newReminder.title = @"Simpsons is on";
         newReminder.calendar = [self.eventStore defaultCalendarForNewReminders];
         
         // Calculate the date exactly one day from now
         NSCalendar *calendar = [NSCalendar currentCalendar];
         NSDateComponents *oneDayComponents = [[NSDateComponents alloc] init];
         oneDayComponents.day = 1;
         NSDate *nextDay = [calendar dateByAddingComponents:oneDayComponents
                                                     toDate:[NSDate date] options:0];
         
         NSUInteger unitFlags = NSEraCalendarUnit | NSYearCalendarUnit |
         NSMonthCalendarUnit | NSDayCalendarUnit;
         NSDateComponents *tomorrowAt6PMComponents = [calendar components:unitFlags
                                                                 fromDate:nextDay];
         tomorrowAt6PMComponents.hour = 18;
         tomorrowAt6PMComponents.minute = 0;
         tomorrowAt6PMComponents.second = 0;
         NSDate *nextDayAt6PM = [calendar dateFromComponents:tomorrowAt6PMComponents];
         
         // Create an Alarm
         EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:nextDayAt6PM];
         [newReminder addAlarm:alarm];
         newReminder.dueDateComponents = tomorrowAt6PMComponents;
         
         // Save Reminder
         NSString *alertTitle;
         NSString *alertMessage;
         NSString *alertButtonTitle;
         NSError *error;
         [self.eventStore saveReminder:newReminder commit:YES error:&error];
         if (error == nil)
         {
             alertTitle = @"Information";
             alertMessage = [NSString stringWithFormat:@"\"%@\" was added to Reminders",
                             newReminder.title];
             alertButtonTitle = @"OK";
         }
         else
         {
             alertTitle = @"Error";
             alertMessage = [NSString stringWithFormat:@"Unable to save reminder: %@",
                             error];
             alertButtonTitle = @"Dismiss";
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:alertTitle
                                                                message:alertMessage delegate:nil cancelButtonTitle:alertButtonTitle
                                                      otherButtonTitles:nil];
             [alertView show];
             [self.activityIndicator stopAnimating];
         });
         
     }];

}

- (IBAction)addLocationBasedReminder:(id)sender
{
    [self.activityIndicator startAnimating];
    
    [self retrieveCurrentLocation:
     ^(CLLocation *currentLocation)
     {
         if (currentLocation != nil)
         {
             [self handleReminderAction:^()
              {
                  // Create Reminder
                  EKReminder *newReminder =
                  [EKReminder reminderWithEventStore:self.eventStore];
                  newReminder.title = @"Buy milk!";
                  newReminder.calendar =
                  [self.eventStore defaultCalendarForNewReminders];
                  
                  // Create Location-based Alarm
                  EKStructuredLocation *currentStructuredLocation =
                  [EKStructuredLocation locationWithTitle:@"Current Location"];
                  currentStructuredLocation.geoLocation = currentLocation;
                  
                  EKAlarm *alarm = [[EKAlarm alloc] init];
                  alarm.structuredLocation = currentStructuredLocation;
                  alarm.proximity = EKAlarmProximityLeave;
                  
                  [newReminder addAlarm:alarm];
                  
                  // Save Reminder
                  NSString *alertTitle;
                  NSString *alertMessage;
                  NSString *alertButtonTitle;
                  NSError *error;
                  [self.eventStore saveReminder:newReminder commit:YES error:&error];
                  if (error == nil)
                  {
                      alertTitle = @"Information";
                      alertMessage =
                      [NSString stringWithFormat:@"\"%@\" was added to Reminders",
                       newReminder.title];
                      alertButtonTitle = @"OK";
                  }
                  else
                  {
                      alertTitle = @"Error";
                      alertMessage =
                      [NSString stringWithFormat:@"Unable to save reminder: %@",
                       error];
                      alertButtonTitle = @"Dismiss";
                  }
                  
                  dispatch_async(dispatch_get_main_queue(), ^{
                      UIAlertView *alertView =
                      [[UIAlertView alloc]initWithTitle:alertTitle
                                                message:alertMessage delegate:nil
                                      cancelButtonTitle:alertButtonTitle otherButtonTitles:nil];
                      [alertView show];
                      [self.activityIndicator stopAnimating];
                  });
              }];
         }
     }];
}

#pragma mark - helper methods
- (void)handleReminderAction:(RestrictedEventStoreActionHandler)block
{
    [self.eventStore requestAccessToEntityType:EKEntityTypeReminder
                                    completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             block();
         }
         else
         {
             UIAlertView *notGrantedAlert = [[UIAlertView alloc] initWithTitle:@"Access Denied"
                                                                       message:@"Access to device's reminders has been denied for this app."
                                                                      delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [notGrantedAlert show];
             });
         }
     }];
}
- (void)retrieveCurrentLocation:(RetrieveCurrentLocationHandler)block
{
    if ([CLLocationManager locationServicesEnabled] == NO)
    {
        UIAlertView *locationServicesDisabledAlert = [[UIAlertView alloc]
                                                      initWithTitle:@"Location Services Disabled" message:@"This feature requires location services. Enable it in the privacy settings on your device"
                                                      delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [locationServicesDisabledAlert show];
        return;
    }
    
    if (_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1; // meter
        _locationManager.activityType = CLActivityTypeOther;
        _locationManager.delegate = self;
    }
    _numberOfTries = 0;
    _retrieveCurrentLocationBlock = block;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // Make sure this is a recent location event
    CLLocation *lastLocation = [locations lastObject];
    NSTimeInterval eventInterval = [lastLocation.timestamp timeIntervalSinceNow];
    if(abs(eventInterval) < 30.0)
    {
        // Make sure the event is accurate enough
        if (lastLocation.horizontalAccuracy >= 0 &&
            lastLocation.horizontalAccuracy < 20)
        {
            [_locationManager stopUpdatingLocation];
            _retrieveCurrentLocationBlock(lastLocation);
            return;
        }
    }
    if (_numberOfTries++ == 10)
    {
        [_locationManager stopUpdatingLocation];
        UIAlertView *unableToGetLocationAlert =
        [[UIAlertView alloc]initWithTitle:@"Error"
                                  message:@"Unable to get the current location." delegate:nil
                        cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [unableToGetLocationAlert show];
    }
}


@end
