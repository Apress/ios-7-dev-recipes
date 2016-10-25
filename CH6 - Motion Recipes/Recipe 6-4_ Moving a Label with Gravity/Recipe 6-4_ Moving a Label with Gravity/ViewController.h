//
//  ViewController.h
//  Recipe 6-4: Moving a Label with Gravity
//
//  Created by joseph hoffman on 8/9/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end
