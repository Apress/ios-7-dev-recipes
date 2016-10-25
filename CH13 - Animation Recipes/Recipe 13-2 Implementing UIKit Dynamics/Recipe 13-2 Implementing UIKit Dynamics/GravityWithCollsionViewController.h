//
//  GravityWithCollsionViewController.h
//  Recipe 13-2 Implementing UIKit Dynamics
//
//  Created by joseph hoffman on 9/16/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GravityWithCollsionViewController : UIViewController <UICollisionBehaviorDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *blueBall;
@property (nonatomic) UIDynamicAnimator *animator;

@end
