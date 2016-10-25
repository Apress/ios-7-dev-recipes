//
//  ViewController.h
//  Recipe 14-6 Creating Reminders
//
//  Created by joseph hoffman on 8/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^RestrictedEventStoreActionHandler)();
typedef void(^RetrieveCurrentLocationHandler)(CLLocation *);

@interface ViewController : UIViewController <CLLocationManagerDelegate>
{
@private
    CLLocationManager *_locationManager;
    RetrieveCurrentLocationHandler _retrieveCurrentLocationBlock;
    int _numberOfTries;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic)EKEventStore *eventStore;

- (IBAction)addTimeBasedReminder:(id)sender;
- (IBAction)addLocationBasedReminder:(id)sender;

- (void)handleReminderAction:(RestrictedEventStoreActionHandler)block;
- (void)retrieveCurrentLocation:(RetrieveCurrentLocationHandler)block;

@end
