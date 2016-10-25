//
//  ViewController.m
//  Recipe 7-6: Grouping Annotations Dynamically
//
//  Created by joseph hoffman on 8/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//


#define centerLat 39.7392
#define centerLong -104.9842
#define spanDeltaLat 4.9
#define spanDeltaLong 5.8
#define scaleLat 9.0
#define scaleLong 11.0

#import "ViewController.h"
#import "Hotspot.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mapView = _mapView;

-(float)randomFloatFrom:(float)a to:(float)b
{
    float random = ((float) rand()) / (float) RAND_MAX;
    float diff = b - a;
    float r = random * diff;
    return a + r;
}

-(void)generateAnnotations
{
    srand((unsigned)time(0));
    
    for (int i=0; i<1000; i++)
    {
        CLLocationCoordinate2D randomLocation =
        CLLocationCoordinate2DMake([self randomFloatFrom:37.0 to:42.0], [self randomFloatFrom:-103.0 to:-107.0]);
        
        Hotspot *place = [[Hotspot alloc] initWithCoordinate:randomLocation title:[NSString stringWithFormat:@"Place %d title", i] subtitle:[NSString stringWithFormat:@"Place %d subtitle", i]];
        [_annotations addObject:place];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    
    _annotations = [[NSMutableArray alloc] initWithCapacity:1000];
    
    [self generateAnnotations];
    // The line below is for setup purposes only. It will be unnecessary
    // when grouping is implemented.
    //[self.mapView addAnnotations:_annotations];
    
    CLLocationCoordinate2D centerPoint = {centerLat, centerLong};
	MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(spanDeltaLat, spanDeltaLong);
	MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(centerPoint, coordinateSpan);
    
	[self.mapView setRegion:coordinateRegion];
	[self.mapView regionThatFits:coordinateRegion];
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
	else
    {
        static NSString *startPinId = @"StartPinIdentifier";
        MKPinAnnotationView *startPin = (id)[mapView dequeueReusableAnnotationViewWithIdentifier:startPinId];
		if (startPin == nil)
        {
            startPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:startPinId];
            startPin.canShowCallout = YES;
            startPin.animatesDrop = YES;
            
            Hotspot *place = annotation;
            place.annotationView = startPin;
            if ([place placesCount] > 1)
            {
                startPin.pinColor = MKPinAnnotationColorGreen;
            }
            else if ([place placesCount] == 1)
            {
                startPin.pinColor = MKPinAnnotationColorRed;
            }
        }
        return startPin;
	}
}

-(void)group:(NSArray *)annotations
{
    float latDelta = self.mapView.region.span.latitudeDelta / scaleLat;
    float longDelta = self.mapView.region.span.longitudeDelta / scaleLong;
    [_annotations makeObjectsPerformSelector:@selector(cleanPlaces)];
    NSMutableArray *visibleAnnotations = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (Hotspot *current in annotations)
    {
        CLLocationDegrees lat = current.coordinate.latitude;
        CLLocationDegrees longi = current.coordinate.longitude;
        
        bool found = FALSE;
        for (Hotspot *temp in visibleAnnotations)
        {
            if(fabs(temp.coordinate.latitude - lat) < latDelta &&
               fabs(temp.coordinate.longitude - longi) < longDelta)
            {
                [self.mapView removeAnnotation:current];
                found = TRUE;
                [temp addPlace:current];
                break;
            }
        }
        if (!found)
        {
            [visibleAnnotations addObject:current];
            [self.mapView addAnnotation:current];
        }
    }
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (_zoomLevel != mapView.region.span.longitudeDelta)
    {
        [self group:_annotations];
        _zoomLevel = mapView.region.span.longitudeDelta;
        
        NSSet *visibleAnnotations = [mapView annotationsInMapRect:mapView.visibleMapRect];
        for (Hotspot *place in visibleAnnotations)
        {
            if ([place placesCount] > 1)
                place.annotationView.pinColor = MKPinAnnotationColorGreen;
            else
                place.annotationView.pinColor = MKPinAnnotationColorRed;
        }
        
    }
}



@end
