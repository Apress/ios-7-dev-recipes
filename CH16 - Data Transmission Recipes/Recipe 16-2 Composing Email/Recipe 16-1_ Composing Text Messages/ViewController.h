//
//  ViewController.h
//  Recipe 16-2 Composing Email
//
//  Created by joseph hoffman on 9/5/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController <UITextViewDelegate,
                                              MFMessageComposeViewControllerDelegate,
                                              MFMailComposeViewControllerDelegate,
                                              UIImagePickerControllerDelegate,
                                              UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UIButton *textMessageButton;
@property (weak, nonatomic) IBOutlet UIButton *mailMessageButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *getImageButton;
@property (strong, nonatomic) UIImagePickerController *picker;

- (IBAction)textMessage:(id)sender;
- (IBAction)mailMessage:(id)sender;
- (IBAction)getImage:(id)sender;
@end
