//
//  MainTableViewController.h
//  Recipe 8-4: Retrieving Tweets
//
//  Created by joseph hoffman on 8/14/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>

@interface MainTableViewController : UITableViewController

@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) NSArray *twitterAccounts;

@end
