//
//  ViewController.m
//  Recipe 5-1: Getting Basic Location Info
//
//  Created by joseph hoffman on 8/1/13.
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)toggleLocationUpdates:(id)sender
{
    if (self.locationUpdatesSwitch.on == YES)
    {
        if ([CLLocationManager locationServicesEnabled] == NO)
        {
            UIAlertView *locationServicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled"
                                                                                    message:@"This feature requires location services. Enable it in the privacy settings on your device"
                                                                                   delegate:nil cancelButtonTitle:@"Dismiss"
                                                                          otherButtonTitles:nil];
            [locationServicesDisabledAlert show];
            self.locationUpdatesSwitch.on = NO;
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
        [_locationManager startUpdatingLocation];
    }
    else
    {
        // Switch was turned Off
        // Stop updates if they have been started
        if (_locationManager != nil)
        {
            [_locationManager stopUpdatingLocation];
        }
    }
}

#pragma mark - delegate methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied)
    {
        // Turning the switch to off will trigger the toggleLocationServices action,
        // which in turn will stop further updates from coming
        self.locationUpdatesSwitch.on = NO;
    }
    else
    {
        NSLog(@"%@", error);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    CLLocation *lastLocation = [locations lastObject];
    // Make sure this is a recent location event
    NSTimeInterval eventInterval = [lastLocation.timestamp timeIntervalSinceNow];
    if(abs(eventInterval) < 30.0)
    {
        // Make sure the event is accurate enough
        if (lastLocation.horizontalAccuracy >= 0 && lastLocation.horizontalAccuracy < 20)
        {
            self.locationInformationView.text = lastLocation.description;
        }
    }
}

@end
