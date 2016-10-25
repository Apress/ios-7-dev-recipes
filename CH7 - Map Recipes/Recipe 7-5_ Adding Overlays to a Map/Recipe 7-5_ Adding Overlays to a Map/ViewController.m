//
//  ViewController.m
//  Recipe 7-5: Adding Overlays to a Map
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
    
    CLLocationCoordinate2D mexicoCityLocation = CLLocationCoordinate2DMake(19.808, -98.965);
    MKCircle *circleOverlay = [MKCircle circleWithCenterCoordinate:mexicoCityLocation
                                                            radius:500000];
    
    CLLocationCoordinate2D polyCoords[5] =
    {
        CLLocationCoordinate2DMake(39.9, -76.6),
        CLLocationCoordinate2DMake(36.7, -84.0),
        CLLocationCoordinate2DMake(33.1, -89.4),
        CLLocationCoordinate2DMake(27.3, -80.8),
        CLLocationCoordinate2DMake(39.9, -76.6)
    };
    
    MKPolygon *polygonOverlay = [MKPolygon polygonWithCoordinates:polyCoords count:5];
    
    CLLocationCoordinate2D pathCoords[2] =
    {
        CLLocationCoordinate2DMake(46.8, -100.8),
        CLLocationCoordinate2DMake(43.7, -70.4)
    };
    MKPolyline *pathOverlay = [MKPolyline polylineWithCoordinates:pathCoords count:2];
    
    [self.mapView addOverlays:[NSArray arrayWithObjects: circleOverlay, polygonOverlay, pathOverlay, nil]
                        level:MKOverlayLevelAboveRoads];


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate methods

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id )overlay
{
    if([overlay isKindOfClass:[MKCircle class]])
    {
        
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        
        //Display settings
        renderer.lineWidth = 1;
        renderer.strokeColor = [UIColor blueColor];
        renderer.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        return renderer;
    }
    if([overlay isKindOfClass:[MKPolygon class]])
    {
        MKPolygonRenderer *renderer= [[MKPolygonRenderer alloc] initWithOverlay:overlay];
        
        //Display settings
        renderer.lineWidth=1;
        renderer.strokeColor=[UIColor blueColor];
        renderer.fillColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];
        return renderer;
    }
    else if ([overlay isKindOfClass:[MKPolyline class]])
    {
   
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        
        //Display settings
        renderer.lineWidth = 3;
        renderer.strokeColor = [UIColor blueColor];
        return renderer;
    }
    
    return nil;
}



@end
