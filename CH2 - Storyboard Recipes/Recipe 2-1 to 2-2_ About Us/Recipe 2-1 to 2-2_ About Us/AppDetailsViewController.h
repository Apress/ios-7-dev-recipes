//
//  AppDetailsViewController.h
//  Recipe 2-1 to 2-2 About Us
//
//  Created by joseph hoffman on 6/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDetails.h"

@interface AppDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong,nonatomic) AppDetails *appDetails;

@end
