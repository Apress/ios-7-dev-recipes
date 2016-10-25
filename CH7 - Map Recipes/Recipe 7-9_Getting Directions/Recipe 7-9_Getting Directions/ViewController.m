//
//  ViewController.m
//  Recipe 7-9:Getting Directions
//
//  Created by joseph hoffman on 8/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#define centerLat 39.6653
#define centerLong -105.2058
#define spanDeltaLat .5
#define spanDeltaLong .5

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D centerPoint = {centerLat, centerLong};
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(spanDeltaLat, spanDeltaLong);
    MKCoordinateRegion coordinateRegion =
    MKCoordinateRegionMake(centerPoint, coordinateSpan);
    
    [self.mapView setRegion:coordinateRegion];
    [self.mapView regionThatFits:coordinateRegion];
    
    CLLocationCoordinate2D redRocksAmpitheater = CLLocationCoordinate2DMake(39.6653, -105.2058);
    MKPlacemark *redRocksPlacemark = [[MKPlacemark alloc] initWithCoordinate:redRocksAmpitheater addressDictionary:nil];
    MKMapItem *redRocksItem = [[MKMapItem alloc] initWithPlacemark:redRocksPlacemark];
    redRocksItem.name = @"Big Ben";
    
    CLLocationCoordinate2D sportsAuthorityField = CLLocationCoordinate2DMake(39.7439, -105.0200);
    MKPlacemark *sportsAuthorityPlacemark = [[MKPlacemark alloc] initWithCoordinate:sportsAuthorityField addressDictionary:nil];
    MKMapItem *sportsAuthorityItem = [[MKMapItem alloc] initWithPlacemark:sportsAuthorityPlacemark];
    sportsAuthorityItem.name = @"Big Ben";
    
    
    [self findDirectionsFrom:redRocksItem to: sportsAuthorityItem];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)findDirectionsFrom: (MKMapItem *)source to:(MKMapItem *)destination
{
    //Make request and provide it with source and destination MKMapItems
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = source;
    request.destination = destination;
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    
    
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if(error)
        {
            NSLog(@"Bummer, we got an error: %@",error);
            
        }
        else
        {
            [self showDirectionsOnMap:response];
            
            [directions calculateETAWithCompletionHandler:^(MKETAResponse *response, NSError *error) {
                NSLog(@"You will arive in: %.1f Mins%@", response.expectedTravelTime/60.0,error);
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ETA!"
                                                                message:[NSString stringWithFormat:@"Estimated Time of Arrival in: %.1f Mins.",response.expectedTravelTime/60.0]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Dismiss"
                                                      otherButtonTitles: nil];
                [alert show];
            }];
            
        }
    }];
    
    
    
    
    
    
    
}

-(void)showDirectionsOnMap:(MKDirectionsResponse *)response
{
    self.response = response;
    
    for (MKRoute *route in self.response.routes)
    {
        [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    }
    
    [self.mapView addAnnotation:self.response.source.placemark];
    [self.mapView addAnnotation:self.response.destination.placemark];
    
}

#pragma mark - delegates

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id )overlay
{
    
    if([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 3;
        renderer.strokeColor = [UIColor blueColor];
        return renderer;
        
    }
    else
    {
        return nil;
    }
}

@end
