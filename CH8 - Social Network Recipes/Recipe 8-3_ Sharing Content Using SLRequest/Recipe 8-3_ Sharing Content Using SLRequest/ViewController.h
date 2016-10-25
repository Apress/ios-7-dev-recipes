//
//  ViewController.h
//  Recipe 8-3: Sharing Content Using SLRequest
//
//  Created by joseph hoffman on 8/14/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h> 
#import <Accounts/Accounts.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>
{
@private
    NSArray *availableTwitterAccounts;
}

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong,nonatomic) ACAccountStore *accountStore;

- (IBAction)shareOnTwitter:(id)sender;

@end
