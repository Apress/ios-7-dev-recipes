//
//  ViewController.h
//  Recipe 5-6: Implementing Geocoding
//
//  Created by joseph hoffman on 8/6/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
}

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextView *geocodingResultsView;
@property (strong, nonatomic) IBOutlet UIButton *reverseGeocodingButton;

- (IBAction)findCurrentAddress:(id)sender;
- (IBAction)findCoordinateOfAddress:(id)sender;

@end
