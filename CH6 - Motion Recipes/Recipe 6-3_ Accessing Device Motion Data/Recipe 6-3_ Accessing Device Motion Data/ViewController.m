//
//  ViewController.m
//  Recipe 6-3: Accessing Device Motion Data
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
    
    
    [self.startButton setTitle:@"Stop" forState:UIControlStateSelected];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CMMotionManager *)motionManager
{
    // Lazy initialization
    if (_motionManager == nil)
    {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}
- (void)startUpdates
{
    // Start device motion updates
    if ([self.motionManager isDeviceMotionAvailable])
    {
        //Update twice per second
        [self.motionManager setDeviceMotionUpdateInterval:1.0/2.0];
        [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:
         CMAttitudeReferenceFrameXMagneticNorthZVertical
                                                                toQueue:[NSOperationQueue mainQueue]
                                                            withHandler:
         ^(CMDeviceMotion *deviceMotion, NSError *error)

         {
             // Update attitude labels
             self.rollLabel.text =  [NSString stringWithFormat:@"%f",
                                     deviceMotion.attitude.roll];
             self.pitchLabel.text = [NSString stringWithFormat:@"%f",
                                     deviceMotion.attitude.pitch];
             self.yawLabel.text =   [NSString stringWithFormat:@"%f",
                                     deviceMotion.attitude.yaw];
             
             // Update rotation rate labels
             self.xRotLabel.text = [NSString stringWithFormat:@"%f",
                                    deviceMotion.rotationRate.x];
             self.yRotLabel.text = [NSString stringWithFormat:@"%f",
                                    deviceMotion.rotationRate.y];
             self.zRotLabel.text = [NSString stringWithFormat:@"%f",
                                    deviceMotion.rotationRate.z];
             
             // Update user acceleration labels
             self.xGravLabel.text = [NSString stringWithFormat:@"%f",
                                     deviceMotion.gravity.x];
             self.yGravLabel.text = [NSString stringWithFormat:@"%f",
                                     deviceMotion.gravity.y];
             self.zGravLabel.text = [NSString stringWithFormat:@"%f",
                                     deviceMotion.gravity.z];
             
             // Update user acceleration labels
             self.xAccLabel.text = [NSString stringWithFormat:@"%f",
                                    deviceMotion.userAcceleration.x];
             self.yAccLabel.text = [NSString stringWithFormat:@"%f",
                                    deviceMotion.userAcceleration.y];
             self.zAccLabel.text = [NSString stringWithFormat:@"%f",
                                    deviceMotion.userAcceleration.z];
             
             // Update magnetic field labels
             self.xMagLabel.text = [NSString stringWithFormat:@"%f",
                                    deviceMotion.magneticField.field.x];
             self.yMagLabel.text = [NSString stringWithFormat:@"%f",
                                    deviceMotion.magneticField.field.y];
             self.zMagLabel.text = [NSString stringWithFormat:@"%f",
                                    deviceMotion.magneticField.field.z];
         }];
    }
}

-(void)stopUpdates
{
    if ([self.motionManager isDeviceMotionAvailable] &&
        [self.motionManager isDeviceMotionActive])
    {
        [self.motionManager stopDeviceMotionUpdates];
    }
}

- (IBAction)toggleUpdates:(id)sender {
    
    if(![self.startButton isSelected])
    {
        [self startUpdates];
        [self.startButton setSelected:YES];
    }
    else
    {
        [self stopUpdates];
        [self.startButton setSelected:NO];
    }
}
@end
