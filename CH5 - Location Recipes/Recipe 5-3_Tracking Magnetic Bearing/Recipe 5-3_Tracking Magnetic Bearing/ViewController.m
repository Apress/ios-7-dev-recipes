//
//  ViewController.m
//  Recipe 5-3:Tracking Magnetic Bearing
//
//  Created by joseph hoffman on 8/4/13.
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
        
        if (_locationManager == nil)
        {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.headingFilter = 5; // degrees
            _locationManager.delegate = self;
            
            
        }
        [_locationManager startUpdatingHeading];
        self.headingInformationView.text = @"Starting heading tracking...";
    }
    else
    {
        // Switch was turned Off
        self.headingInformationView.text = @"Stopped heading tracking...";
        // Stop updates if they have been started
        if (_locationManager != nil)
        {
            [_locationManager stopUpdatingHeading];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error while tracking heading: %@", error);
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
        [NSString stringWithFormat:@"%.1f°", newHeading.magneticHeading];
    }
}

-(BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return YES;
}



@end
