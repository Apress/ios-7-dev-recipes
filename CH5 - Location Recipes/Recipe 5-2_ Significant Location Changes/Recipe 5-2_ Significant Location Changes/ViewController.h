//
//  ViewController.h
//  Recipe 5-2: Significant Location Changes
//
//  Created by joseph hoffman on 8/4/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
{
    
    CLLocationManager *_locationManager;
}

@property (weak, nonatomic) IBOutlet UITextView *locationInformationView;
@property (weak, nonatomic) IBOutlet UISwitch *locationUpdatesSwitch;

- (IBAction)toggleLocationUpdates:(id)sender;

@end
