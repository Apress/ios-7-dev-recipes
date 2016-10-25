//
//  SpringAttachmentViewController.h
//  Recipe 13-2 Implementing UIKit Dynamics
//
//  Created by joseph hoffman on 9/18/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpringAttachmentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *ball;
@property (weak, nonatomic) IBOutlet UIImageView *star;
@property (nonatomic) UIDynamicAnimator *animator;
@end
