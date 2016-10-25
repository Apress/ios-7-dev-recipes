//
//  TwitterFeedCell.h
//  Recipe 8-4: Retrieving Tweets
//
//  Created by joseph hoffman on 8/14/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>

extern NSString * const TwitterFeedCellId;

@interface TwitterFeedCell : UITableViewCell

@property (strong, nonatomic)ACAccount *twitterAccount;

@end
