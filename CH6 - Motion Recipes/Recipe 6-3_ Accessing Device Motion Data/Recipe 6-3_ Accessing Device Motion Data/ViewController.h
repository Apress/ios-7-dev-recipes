//
//  ViewController.h
//  Recipe 6-3: Accessing Device Motion Data
//
//  Created by joseph hoffman on 8/9/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *rollLabel;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
@property (weak, nonatomic) IBOutlet UILabel *yawLabel;

@property (weak, nonatomic) IBOutlet UILabel *xRotLabel;
@property (weak, nonatomic) IBOutlet UILabel *yRotLabel;
@property (weak, nonatomic) IBOutlet UILabel *zRotLabel;

@property (weak, nonatomic) IBOutlet UILabel *xGravLabel;
@property (weak, nonatomic) IBOutlet UILabel *yGravLabel;
@property (weak, nonatomic) IBOutlet UILabel *zGravLabel;

@property (weak, nonatomic) IBOutlet UILabel *xAccLabel;
@property (weak, nonatomic) IBOutlet UILabel *yAccLabel;
@property (weak, nonatomic) IBOutlet UILabel *zAccLabel;

@property (weak, nonatomic) IBOutlet UILabel *xMagLabel;
@property (weak, nonatomic) IBOutlet UILabel *yMagLabel;
@property (weak, nonatomic) IBOutlet UILabel *zMagLabel;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (strong,nonatomic) CMMotionManager *motionManager;

- (IBAction)toggleUpdates:(id)sender;

@end
