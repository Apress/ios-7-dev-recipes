//
//  ViewController.m
//  Recipe 6-2: Accessing Raw Core Motion Data
//
//  Created by joseph hoffman on 8/8/13.
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


- (void)startUpdates
{
    // Start accelerometer if available
    if ([self.motionManager isAccelerometerAvailable])
    {
        [self.motionManager setAccelerometerUpdateInterval:1.0/2.0];
        [self.motionManager startAccelerometerUpdatesToQueue:
         [NSOperationQueue mainQueue]
                                                 withHandler:
         ^(CMAccelerometerData *data, NSError *error)
         {
             self.xAccLabel.text = [NSString stringWithFormat:@"%f",
                                    data.acceleration.x];
             self.yAccLabel.text = [NSString stringWithFormat:@"%f",
                                    data.acceleration.y];
             self.zAccLabel.text = [NSString stringWithFormat:@"%f",
                                    data.acceleration.z];
             
         }];
        
    }
    
    // Start gyroscope if available
    if ([self.motionManager isGyroAvailable])
    {
        [self.motionManager setGyroUpdateInterval:1.0/2.0];
        [self.motionManager startGyroUpdatesToQueue:
         [NSOperationQueue mainQueue]
                                        withHandler:
         ^(CMGyroData *data, NSError *error)
         {
             self.xGyroLabel.text = [NSString stringWithFormat:@"%f",
                                     data.rotationRate.x];
             self.yGyroLabel.text = [NSString stringWithFormat:@"%f",
                                     data.rotationRate.y];
             self.zGyroLabel.text = [NSString stringWithFormat:@"%f",
                                     data.rotationRate.z];
         }];
    }
    
    // Start magnetometer if available
    if ([self.motionManager isMagnetometerAvailable])
    {
        [self.motionManager setMagnetometerUpdateInterval:1.0/2.0];
        [self.motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                                withHandler:
         ^(CMMagnetometerData *data, NSError *error)
         {
             self.xMagLabel.text = [NSString stringWithFormat:@"%f",
                                    data.magneticField.x];
             self.yMagLabel.text = [NSString stringWithFormat:@"%f",
                                    data.magneticField.y];
             self.zMagLabel.text = [NSString stringWithFormat:@"%f",
                                    data.magneticField.z];
         }];
    }
}

-(void)stopUpdates
{
    if ([self.motionManager isAccelerometerAvailable] &&
        [self.motionManager isAccelerometerActive])
    {
        [self.motionManager stopAccelerometerUpdates];
    }
    
    if ([self.motionManager isGyroAvailable] &&
        [self.motionManager isGyroActive])
    {
        [self.motionManager stopGyroUpdates];
    }
    
    if ([self.motionManager isMagnetometerAvailable] &&
        [self.motionManager isMagnetometerActive])
    {
        [self.motionManager stopMagnetometerUpdates];
    }
}


@end
