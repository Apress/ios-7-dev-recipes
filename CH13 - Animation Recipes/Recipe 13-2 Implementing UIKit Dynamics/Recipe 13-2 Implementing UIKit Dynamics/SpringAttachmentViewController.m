//
//  SpringAttachmentViewController.m
//  Recipe 13-2 Implementing UIKit Dynamics
//
//  Created by joseph hoffman on 9/18/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "SpringAttachmentViewController.h"
#import "BouncingSpringBehavior.h"

@interface SpringAttachmentViewController ()

@end

@implementation SpringAttachmentViewController

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
    
    /*
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.ball,self.star]];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ball,self.star]];
    
    CGPoint anchorPoint = CGPointMake(self.view.frame.size.width/2, 20);
    
    UIAttachmentBehavior *ballAttachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.ball attachedToAnchor:anchorPoint];
    
    UIAttachmentBehavior *starAttachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.star offsetFromCenter:UIOffsetMake(-20.0, 0) attachedToItem:self.ball offsetFromCenter:UIOffsetZero];
    
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    [ballAttachmentBehavior setFrequency:1.0];
    [ballAttachmentBehavior setDamping:0.65];
    
    [starAttachmentBehavior setFrequency:1.0];
    [starAttachmentBehavior setDamping:0.65];
    
    [self.animator addBehavior:ballAttachmentBehavior];
    [self.animator addBehavior:starAttachmentBehavior];
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:gravityBehavior];
     
     */
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    CGPoint anchorPoint = CGPointMake(self.view.frame.size.width/2, 20);
    NSString *anchorPointString = NSStringFromCGPoint(anchorPoint);
    
    BouncingSpringBehavior *bouncingSpringBehavior = [[BouncingSpringBehavior alloc] initWithItems:@[self.ball,self.star] withAnchorPoint:anchorPointString];
    
    [self.animator addBehavior:bouncingSpringBehavior];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
