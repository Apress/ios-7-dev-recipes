//
//  ViewController.h
//  Recipe 16-1: Composing Text Messages
//
//  Created by joseph hoffman on 9/5/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController <UITextViewDelegate, MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UIButton *textMessageButton;

- (IBAction)textMessage:(id)sender;
@end
