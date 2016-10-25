//
//  ViewController.m
//  Recipe 7-2: Marking Locations wiht Pins
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
    
    MKPointAnnotation *annotation1 = [[MKPointAnnotation alloc] init];
    annotation1.title = @"Miami";
    annotation1.subtitle = @"Annotation 1";
    annotation1.coordinate = CLLocationCoordinate2DMake(25.802, -80.132);
    
    MKPointAnnotation *annotation2 = [[MKPointAnnotation alloc] init];
    annotation2.title = @"Denver";
    annotation2.subtitle = @"Annotation 2";
    annotation2.coordinate = CLLocationCoordinate2DMake(39.733, -105.018);
    
    [self.mapView addAnnotation:annotation1];
    [self.mapView addAnnotation:annotation2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // Don't create annotation views for the user location annotation
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        static NSString *userPinAnnotationId = @"userPinAnnotation";
        
        // Create an annotation view, but reuse a cached one if available
        MKPinAnnotationView *annotationView =(MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:userPinAnnotationId];
        
        if(annotationView)
        {
            // Cached view found. It’ll have the pin color set but not annotation.
            annotationView.annotation = annotation;
        }
        else
        {
            // No cached view were available, create a new one
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:userPinAnnotationId];
            
            // Purple indicates user defined pin
            annotationView.pinColor = MKPinAnnotationColorPurple;
        }
        
        return annotationView;
    }
    return nil;
}

@end
