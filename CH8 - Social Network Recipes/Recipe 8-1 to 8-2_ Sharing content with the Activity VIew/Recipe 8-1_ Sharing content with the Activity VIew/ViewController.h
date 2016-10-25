//
//  ViewController.h
//  Recipe 8-1: Sharing content with the Activity VIew
//
//  Created by joseph hoffman on 8/13/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

- (IBAction)shareContent:(id)sender;
- (IBAction)shareOnFacebook:(id)sender;

@end
