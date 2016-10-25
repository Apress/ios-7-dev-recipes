//
//  ViewController.m
//  Recipe 6-4: Moving a Label with Gravity
//
//  Created by joseph hoffman on 8/9/13.
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
    [self startUpdates];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [self stopUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CMMotionManager *)motionManager
{
    //Lazy initilization
    if(_motionManager == nil)
    {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}
- (void)startUpdates
{
    if ([self.motionManager isDeviceMotionAvailable] &&
        ![self.motionManager isDeviceMotionActive])
    {
        __block double accumulatedDx = 0;
        __block double accumulatedDy = 0;
        
        [self.motionManager setDeviceMotionUpdateInterval:1.0/50.0];
        [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:
         CMAttitudeReferenceFrameXArbitraryCorrectedZVertical
                                                                toQueue:[NSOperationQueue mainQueue]
                                                            withHandler:
         ^(CMDeviceMotion *motion, NSError *error)
         {
             CGRect labelRect = self.myLabel.frame;
             double scale = 1.5;
             
             double dx = motion.gravity.x * scale;
             accumulatedDx += dx;
             labelRect.origin.x += accumulatedDx;
             
             if (labelRect.origin.x < 0)
             {
                 labelRect.origin.x = 0;
                 accumulatedDx = 0;
             }
             else if (labelRect.origin.x + labelRect.size.width >
                      self.view.bounds.size.width)
             {
                 labelRect.origin.x =
                 self.view.bounds.size.width - labelRect.size.width;
                 accumulatedDx = 0;
             }
             
             double dy = motion.gravity.y * scale;
             accumulatedDy += dy;
             labelRect.origin.y -= accumulatedDy;
             
             if (labelRect.origin.y < 0)
             {
                 labelRect.origin.y = 0;
                 accumulatedDy = 0;
             }
             else if (labelRect.origin.y + labelRect.size.height > self.view.bounds.size.height)
             {
                 labelRect.origin.y = self.view.bounds.size.height - labelRect.size.height;
                 accumulatedDy = 0;
             }
             
             [self.myLabel setFrame:labelRect];
         }];
    }
}


- (void)stopUpdates
{
    if ([self.motionManager isDeviceMotionAvailable] &&
        [self.motionManager isDeviceMotionActive])
    {
        [self.motionManager stopDeviceMotionUpdates];
    }
}
@end
