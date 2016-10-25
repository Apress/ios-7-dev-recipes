///Users/josephhoffman/Google Drive/iOS 7 Book/iOS 7 Book Chapter folders/CH7 - Map Recipes/projects/Recipe 7-1:  Showing a Map with the Current Locaiton/Recipe 7-1:  Showing a Map with the Current Locaiton.xcodeproj
//  ViewController.m
//  Recipe 7-1:  Showing a Map with the Current Locaiton
//
//  Created by joseph hoffman on 8/10/13.
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
    self.mapView.delegate = self;
    
    // Set initial region
    CLLocationCoordinate2D denverLocation = CLLocationCoordinate2DMake(39.739, 104.984);
    self.mapView.region =
    MKCoordinateRegionMakeWithDistance(denverLocation, 10000, 10000);
    
    // Optional Controls
    //   self.mapView.zoomEnabled = NO;
    //   self.mapView.scrollEnabled = NO;
    
    //Control User Location on Map
    if ([CLLocationManager locationServicesEnabled])
    {
        self.mapView.showsUserLocation = YES;
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
    
    // Add button for controlling user location tracking
    MKUserTrackingBarButtonItem *trackingButton =
    [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    [self.mapToolbar setItems: [NSArray arrayWithObject: trackingButton] animated:YES];



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate methods

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.userLocationLabel.text =
    [NSString stringWithFormat:@"Location: %.5f°, %.5f°",
     userLocation.coordinate.latitude, userLocation.coordinate.longitude];
}

@end
