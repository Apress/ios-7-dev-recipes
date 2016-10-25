//
//  ViewController.h
//  Recipe 5-4: Tracking True Bearing
//
//  Created by joseph hoffman on 8/6/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
{
    
    CLLocationManager *_locationManager;
}

@property (weak, nonatomic) IBOutlet UITextView *headingInformationView;
@property (weak, nonatomic) IBOutlet UITextView *trueHeadingInformationView;
@property (weak, nonatomic) IBOutlet UISwitch *headingUpdatesSwitch;

- (IBAction)toggleHeadingUpdates:(id)sender;

@end

