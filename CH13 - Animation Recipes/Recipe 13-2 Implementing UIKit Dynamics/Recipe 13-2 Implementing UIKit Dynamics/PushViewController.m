//
//  PushViewController.m
//  Recipe 13-2 Implementing UIKit Dynamics
//
//  Created by joseph hoffman on 9/17/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIPushBehavior *instantPushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ball1] mode:UIPushBehaviorModeInstantaneous];
    UIPushBehavior *continuousPushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ball2] mode:UIPushBehaviorModeContinuous];
    
    //90 degrees counter-clockwise
    instantPushBehavior.angle = -1.57;
    continuousPushBehavior.angle = -1.57;
    
    instantPushBehavior.magnitude = 0.5;
    continuousPushBehavior.magnitude = 0.5;
    
    [self.animator addBehavior:instantPushBehavior];
    [self.animator addBehavior:continuousPushBehavior];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
