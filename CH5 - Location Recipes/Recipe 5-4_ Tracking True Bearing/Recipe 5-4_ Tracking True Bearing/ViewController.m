//
//  ViewController.m
//  Recipe 5-4: Tracking True Bearing
//
//  Created by joseph hoffman on 8/6/13.
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

- (IBAction)toggleHeadingUpdates:(id)sender
{
    if (self.headingUpdatesSwitch.on == YES)
    {
        // Heading data is not available on all devices
        if ([CLLocationManager headingAvailable] == NO)
        {
            self.headingInformationView.text = @"Heading services unavailable";
            self.headingUpdatesSwitch.on = NO;
            return;
        }
        
        if ([CLLocationManager locationServicesEnabled] == NO)
        {
            UIAlertView *locationServicesDisabledAlert =
            [[UIAlertView alloc] initWithTitle:@"Location Services Disabled"
                                       message:@"This feature requires location services. Enable it in the privacy settings on your device"
                                      delegate:nil
                             cancelButtonTitle:@"Dismiss"
                             otherButtonTitles:nil];
            
            [locationServicesDisabledAlert show];
            self.headingUpdatesSwitch.on = NO;
            return;
        }
        
        if (_locationManager == nil)
        {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.headingFilter = 5; // degrees
            _locationManager.delegate = self;
            
            // For backward compatibility, set the deprecated purpose property
            // to the same as NSLocationUsageDescription in the Info.plist
            _locationManager.purpose = [[NSBundle mainBundle]
                                        objectForInfoDictionaryKey:@"NSLocationUsageDescription"];
        }
        [_locationManager startUpdatingHeading];
        // Start location service in order to get true heading
        [_locationManager startUpdatingLocation];
        self.headingInformationView.text = @"Starting heading tracking...";
    }
    else
    {
        // Switch was turned Off
        self.headingInformationView.text = @"Stopped heading tracking";
        // Stop updates if they have been started
        if (_locationManager != nil)
        {
            [_locationManager stopUpdatingHeading];
            [_locationManager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied)
    {
        // Turning the switch to off will indirectly stop
        // further updates from coming
        self.headingUpdatesSwitch.on = NO;
    }
    else
    {
        NSLog(@"%@", error);
    }
}

-(void)locationManager:(CLLocationManager *)manager
      didUpdateHeading:(CLHeading *)newHeading
{
    NSTimeInterval headingInterval = [newHeading.timestamp timeIntervalSinceNow];
    // Check if reading is recent
    if(abs(headingInterval) < 30)
    {
        // Check if reading is valid
        if(newHeading.headingAccuracy < 0)
            return;
        
        self.headingInformationView.text =
        [NSString stringWithFormat:@"Magnetic Heading: %.1f°", newHeading.magneticHeading];
        
        if(newHeading.trueHeading >= 0)
            self.trueHeadingInformationView.text = [NSString stringWithFormat: @"True Heading: %.1f°", newHeading.trueHeading];
    }
}

-(BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return YES;
}



@end