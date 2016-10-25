//
//  ViewController.h
//  Recipe 7-6: Grouping Annotations Dynamically
//
//  Created by joseph hoffman on 8/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>
{
    CLLocationDegrees _zoomLevel;
    NSMutableArray *_annotations;
    
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@end
