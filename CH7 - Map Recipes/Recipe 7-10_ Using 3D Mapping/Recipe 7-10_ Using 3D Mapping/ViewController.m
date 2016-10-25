//
//  ViewController.m
//  Recipe 7-10: Using 3D Mapping
//
//  Created by joseph hoffman on 8/12/13.
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
    
    
    //Create a new MKMapCamera object
    //MKMapCamera *mapCamera = [[MKMapCamera alloc] init];
    
    
    //set MKMapCamera properties
    //mapCamera.centerCoordinate = CLLocationCoordinate2DMake(40.7130,-74.0085);
    //mapCamera.pitch = 57;
    //mapCamera.altitude = 650;
    //mapCamera.heading = 90;
    
    //Using the Convenience Method
    
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(40.7128,-74.0117);
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(40.7132,-74.0150);
    MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground fromEyeCoordinate:eye eyeAltitude:700];
    
    CLLocationCoordinate2D ground2 = CLLocationCoordinate2DMake(40.7,-73.99);
    CLLocationCoordinate2D eye2 = CLLocationCoordinate2DMake(40.7,-73.98);
    MKMapCamera *mapCamera2 = [MKMapCamera cameraLookingAtCenterCoordinate:ground2 fromEyeCoordinate:eye2 eyeAltitude:700];
    
    
    
    //Set MKmapView camera property
    self.mapView.camera = mapCamera;
    
    //Set a few MKMapView Properties to allow pitch, building view, points of interest, and zooming.
    self.mapView.pitchEnabled = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.zoomEnabled = YES;
    
    
    
    [UIView animateWithDuration:25.0 animations:^{
        
        
        
        self.mapView.camera = mapCamera2;
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    NSLog(@"pitch: %f",self.mapView.camera.pitch);
    NSLog(@"altitude: %f",self.mapView.camera.altitude);
    NSLog(@"heading: %f",self.mapView.camera.heading);
    
    
    
}

@end
