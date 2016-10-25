//
//  RecentTweetsTableViewController.h
//  Recipe 8-4: Retrieving Tweets
//
//  Created by joseph hoffman on 8/15/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface TweetTableViewController : UITableViewController

@property (strong, nonatomic) ACAccount *twitterAccount;
@property (strong, nonatomic) NSMutableArray *tweets;

-(id)initWithTwitterAccount:(ACAccount *)account;

@end
