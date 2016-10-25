//
//  AppDelegate.h
//  Recipe 1-10 Handling Exceptions
//
//  Created by joseph hoffman on 6/26/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
