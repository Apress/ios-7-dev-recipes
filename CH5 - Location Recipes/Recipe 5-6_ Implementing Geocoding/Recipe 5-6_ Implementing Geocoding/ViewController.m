//
//  ViewController.m
//  Recipe 5-6: Implementing Geocoding
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

#pragma mark - actions

- (IBAction)findCurrentAddress:(id)sender
{
    if([CLLocationManager locationServicesEnabled])
    {
        if(_locationManager==nil)
        {
            _locationManager=[[CLLocationManager alloc] init];
            _locationManager.distanceFilter = 500;
            _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            _locationManager.delegate = self;
            
        }
        
        [_locationManager startUpdatingLocation];
        self.geocodingResultsView.text = @"Getting location...";
    }
    else
    {
        self.geocodingResultsView.text=@"Location services are unavailable";
    }
}

- (IBAction)findCoordinateOfAddress:(id)sender
{
    // Instantiate _geocoder if it has not been already
    if (_geocoder == nil)
        _geocoder = [[CLGeocoder alloc] init];
    
    NSString *address = self.addressTextField.text;
    [_geocoder geocodeAddressString:address
                  completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if ([placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             
             self.geocodingResultsView.text = placemark.location.description;
         }
         else if (error.domain == kCLErrorDomain)
         {
             switch (error.code)
             {
                 case kCLErrorDenied:
                     self.geocodingResultsView.text
                     = @"Location Services Denied by User";
                     break;
                 case kCLErrorNetwork:
                     self.geocodingResultsView.text = @"No Network";
                     break;
                 case kCLErrorGeocodeFoundNoResult:
                     self.geocodingResultsView.text = @"No Result Found";
                     break;
                 default:
                     self.geocodingResultsView.text = error.localizedDescription;
                     break;
             }
         }
         else
         {
             self.geocodingResultsView.text = error.localizedDescription;
         }
     }
     ];
}
#pragma mark - delegate methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(error.code == kCLErrorDenied)
    {
        self.geocodingResultsView.text = @"Location information denied";
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // Make sure this is a recent location event
    CLLocation *newLocation = [locations lastObject];
    NSTimeInterval eventInterval = [newLocation.timestamp timeIntervalSinceNow];
    if(abs(eventInterval) < 30.0)
    {
        // Make sure the event is valid
        if (newLocation.horizontalAccuracy < 0)
            return;
        
        // Instantiate _geoCoder if it has not been already
        if (_geocoder == nil)
            _geocoder = [[CLGeocoder alloc] init];
        
        //Only one geocoding instance per action
        //so stop any previous geocoding actions before starting this one
        if([_geocoder isGeocoding])
            [_geocoder cancelGeocode];
        
        [_geocoder reverseGeocodeLocation: newLocation
                        completionHandler: ^(NSArray* placemarks, NSError* error)
         {
             if([placemarks count] > 0)
             {
                 CLPlacemark *foundPlacemark = [placemarks objectAtIndex:0];
                 self.geocodingResultsView.text =
                 [NSString stringWithFormat:@"You are in: %@",
                  foundPlacemark.description];
             }
             else if (error.code == kCLErrorGeocodeCanceled)
             {
                 NSLog(@"Geocoding cancelled");
             }
             else if (error.code == kCLErrorGeocodeFoundNoResult)
             {
                 self.geocodingResultsView.text=@"No geocode result found";
             }
             else if (error.code == kCLErrorGeocodeFoundPartialResult)
             {
                 self.geocodingResultsView.text=@"Partial geocode result";
             }
             else
             {
                 self.geocodingResultsView.text =
                 [NSString stringWithFormat:@"Unknown error: %@",
                  error.description];
             }
         }
         ];
        
        //Stop updating location until they click the button again
        [manager stopUpdatingLocation];
    }
}

@end
