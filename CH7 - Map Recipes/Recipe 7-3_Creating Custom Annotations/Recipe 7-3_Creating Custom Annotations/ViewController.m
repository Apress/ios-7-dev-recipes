//
//  ViewController.m
//  Recipe 7-3:Creating Custom Annotations
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"
#import "MyAnnotation.h"
#import "MyAnnotationView.h"
#import "DetailedViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    MyAnnotation *ann1 = [[MyAnnotation alloc]
                          initWithCoordinate: CLLocationCoordinate2DMake(37.68, -97.33)
                          title: @"Company 1"
                          subtitle: @"Something Catchy"
                          contactInformation: @"Call 555-123456"];
    
    MyAnnotation *ann2 = [[MyAnnotation alloc]
                          initWithCoordinate:CLLocationCoordinate2DMake(41.500, -81.695)
                          title:@"Company 2"
                          subtitle:@"Even More Catchy"
                          contactInformation:@"Call 555-654321"];
    
    NSArray *annotations = [NSArray arrayWithObjects: ann1, ann2, nil];
    [self.mapView addAnnotations:annotations];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // Don't create annotation views for the user location annotation
    if ([annotation isKindOfClass:[MyAnnotation class]])
    {
        static NSString *myAnnotationId = @"myAnnotation";
        
        // Create an annotation view, but reuse a cached one if available
        MyAnnotationView *annotationView =
        (MyAnnotationView *)[self.mapView
                             dequeueReusableAnnotationViewWithIdentifier:myAnnotationId];
        if(annotationView)
        {
            // Cached view found, associate it with the annotation
            annotationView.annotation = annotation;
        }
        else
        {
            // No cached view were available, create a new one
            annotationView = [[MyAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:myAnnotationId];
        }
        
        return annotationView;
    }
    
    // Use a default annotation view for the user location annotation
    return nil;
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    DetailedViewController *dvc = [[DetailedViewController alloc]
                                   initWithAnnotation:view.annotation];
    dvc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:dvc animated:YES completion:^{}];
}


@end
