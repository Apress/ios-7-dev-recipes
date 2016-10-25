//
//  ViewController.h
//  Recipe 5-5: Region Monitoring
//
//  Created by joseph hoffman on 8/6/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

@property (strong, nonatomic) IBOutlet UITextView *regionInformationView;
@property (strong, nonatomic) IBOutlet UISwitch *regionMonitoringSwitch;

- (IBAction)toggleRegionMonitoring:(id)sender;

@end
