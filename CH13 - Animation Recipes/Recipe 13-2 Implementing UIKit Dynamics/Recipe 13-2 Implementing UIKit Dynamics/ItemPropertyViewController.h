//
//  ItemPropertyViewController.h
//  Recipe 13-2 Implementing UIKit Dynamics
//
//  Created by joseph hoffman on 9/17/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemPropertyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *ball1;
@property (weak, nonatomic) IBOutlet UIImageView *ball2;
@property (nonatomic) UIDynamicAnimator *animator;

@end
