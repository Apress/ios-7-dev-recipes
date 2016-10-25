//
//  ViewController.m
//  Recipe 5-5: Region Monitoring
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
- (IBAction)toggleRegionMonitoring:(id)sender
{
    if (self.regionMonitoringSwitch.on == YES)
    {

            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            
            if (status == kCLAuthorizationStatusAuthorized ||
                status == kCLAuthorizationStatusNotDetermined)
            {
                if(_locationManager == nil)
                {
                    _locationManager = [[CLLocationManager alloc] init];
                    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
                    _locationManager.delegate = self;
                }
                
                CLLocationCoordinate2D denverCoordinate =
                CLLocationCoordinate2DMake(39.7392, -104.9847);
                int regionRadius = 3000; // meters
                if (regionRadius > _locationManager.maximumRegionMonitoringDistance)
                {
                    regionRadius = _locationManager.maximumRegionMonitoringDistance;
                }
               
                
                CLCircularRegion *denverRegion = [[CLCircularRegion alloc] initWithCenter:denverCoordinate
                                                                                   radius:regionRadius
                                                                               identifier:@"denverRegion"];
                

                [_locationManager startMonitoringForRegion: denverRegion];
            }
            else
            {
                self.regionInformationView.text = @"Region monitoring disabled";
                self.regionMonitoringSwitch.on = NO;
            }
            
     
    }
    else
    {
        if (_locationManager!=nil)
        {
            for (CLCircularRegion *monitoredRegion in [_locationManager monitoredRegions])
            {
                [_locationManager stopMonitoringForRegion:monitoredRegion];
                self.regionInformationView.text =
                [NSString stringWithFormat:@"Turned off region monitoring for: %@",
                 monitoredRegion.identifier];
            }
        }
    }
    
}

-(void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    switch (error.code)
    {
        case kCLErrorRegionMonitoringDenied:
        {
            self.regionInformationView.text =
            @"Region monitoring is denied on this device";
            break;
        }
        case kCLErrorRegionMonitoringFailure:
        {
            self.regionInformationView.text =
            [NSString stringWithFormat:@"Region monitoring failed for region: %@",
             region.identifier];
            break;
        }
        default:
        {
            self.regionInformationView.text =
            [NSString stringWithFormat:@"An unhandled error occured: %@",
             error.description];
            break;
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    self.regionInformationView.text = @"Welcome to Denver!";
    
    UILocalNotification *entranceNotification = [[UILocalNotification alloc] init];
    entranceNotification.alertBody = @"Welcome to Denver!";
    entranceNotification.alertAction = @"Ok";
    entranceNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow: entranceNotification];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    self.regionInformationView.text = @"Thanks for visiting Denver! Come back soon!";
    
    UILocalNotification *exitNotification = [[UILocalNotification alloc] init];
    exitNotification.alertBody = @"Thanks for visiting Denver! Come back soon!";
    exitNotification.alertAction = @"Ok";
    exitNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow: exitNotification];
}


@end
