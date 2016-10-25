//
//  GravityViewController.m
//  Recipe 13-2 Implementing UIKit Dynamics
//
//  Created by joseph hoffman on 9/15/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "GravityViewController.h"

@interface GravityViewController ()

@end

@implementation GravityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.blueBall]];
    
    [self.animator addBehavior:gravityBehavior];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}

@end
