//
//  ViewController.h
//  Recipe 7-1:  Showing a Map with the Current Locaiton
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <MKMapViewDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;

@property (weak, nonatomic) IBOutlet UIToolbar *mapToolbar;

@end
